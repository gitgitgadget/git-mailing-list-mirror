Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59244C432C3
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7892245B
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx7NObvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKSXCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:02:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46062 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSXCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:02:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so25879971wrs.12
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N+l4iIy81iLjRMTSN//p+Xqnb/n6MgAsLuFDFex0GO4=;
        b=Mx7NObvnHrTgKwyZWvYbIaFcKCAbRkN4l5Pa9kw2wUGTv3H85uNJrdkSn158BzOafT
         OqRFI5fCfVfhr19m/rt123lLNutBADRar6HqD4ulUo5ctwjFLLh3Kgc2lRGMa410HD8H
         6Lwbip3VupfBmLcsr9NQOXceTK0dKH0TQyee8Jd/CkqfwRGKcVnfB+Cwaps+BPpt7WWZ
         2DvFX6SeZjUqg9FSy/dpwHhumfNPpfYtaLix9D8TG6LF45hZXFyTV/zd5G1OXQgsEHYm
         TgAxSnveL27nA0ppU5rzA8oknPEvDwGOGxgocjLhU5PwoNSqPAgq3BHBRdyLLW1BB2Lh
         NTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N+l4iIy81iLjRMTSN//p+Xqnb/n6MgAsLuFDFex0GO4=;
        b=hKmGDL4+gKgQ45lrc6yJwN2Ow68RTb5f0fntAKTNY46onh2icoqaK6j1OTZbt7Pp7l
         MtdPN2oY3WCguNmOVcpEBHhUm6xi+1J//VXhUBJI3wsYZnxL763qiE+mO9ff6ijD3KIN
         su8Ltze8Xpjw6fkFwUh0/36AU/O7PHp/mQpIl79ljdoBQ5q++m687VwudfaDNECaV4PA
         f94eIkS3l+hS3GSRuVtejqwAHW+M+IA9oyegwGopxNTWT41ofAlfQ71lHldB8NnIq5i2
         qv2dgvknMnow4Dz1Ey251eHJuPBs2ltqCExGP1VheGd7vplR/bXCsI3rs+v0/s13/HD6
         MSuw==
X-Gm-Message-State: APjAAAWhWqMukC01SKt+fnpKB6lzeb+eOWBb/BCeBgspyL55ZHefhiDl
        mirmLsp4Cvxi8LuISkZSemy2gsm8
X-Google-Smtp-Source: APXvYqzNpjI9ZIWM1WtuVwlaP6UdWziEkLqQNWCKS1PL/PY14F9B8QPu0jX9SICJIX98M9eOeFl2mw==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr2805335wrx.212.1574204530627;
        Tue, 19 Nov 2019 15:02:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm29738177wrx.71.2019.11.19.15.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 15:02:10 -0800 (PST)
Message-Id: <pull.451.v5.git.1574204529.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
References: <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
From:   "erik chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 23:02:08 +0000
Subject: [PATCH v5 0/1] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

* matching common remote and local refs
* marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]

Erik Chen (1):
  fetch: add trace2 instrumentation

 fetch-pack.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-451%2Ferikchen%2Ftest12-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-451/erikchen/test12-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/451

Range-diff vs v4:

 1:  508d07a3eb ! 1:  d7bf1849ce fetch: add trace2 instrumentation
     @@ -5,12 +5,11 @@
          Add trace2 regions to fetch-pack.c to better track time spent in the various
          phases of a fetch:
      
     -        * matching common remote and local refs
              * parsing remote refs and finding a cutoff
              * marking local refs as complete
              * marking complete remote refs as common
      
     -    Both of these stages can be slow for repositories with many refs.
     +    All stages could potentially be slow for repositories with many refs.
      
          Signed-off-by: Erik Chen <erikchen@chromium.org>
      
     @@ -21,8 +20,6 @@
       
       	save_commit_buffer = 0;
       
     -+	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
     -+
      +	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
       	for (ref = *refs; ref; ref = ref->next) {
       		struct object *o;
     @@ -72,7 +69,4 @@
      +	trace2_region_leave("fetch-pack", "mark_common_remote_refs", NULL);
       
       	save_commit_buffer = old_save_commit_buffer;
     -+	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);
       }
     - 
     - /*

-- 
gitgitgadget
