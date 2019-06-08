Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864D81F462
	for <e@80x24.org>; Sat,  8 Jun 2019 19:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfFHTXA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 15:23:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45732 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHTXA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 15:23:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id w34so2866907pga.12
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6E5OJlLmpvCUojBbNvvSJfeTwR8Atp2hl+3PorSHd4=;
        b=Y9xeOYlEbunR6DRoa+kDOrMY/u6DHog52XgB+LVC/xymubbJyfvNphcyM1VNKYX9ew
         EeIwR3jB06xmxYNrhV54I3n8aoy9kVVg27uxXP/IDTHcGgzdR9vjBgUiPMQccmRcokD5
         usmxrFCYGMX4UeZAKvZWHT4vV+jHitVZ1rB40nEUpjQ22sTN0w1QQ1JIkCdxUENmRQDl
         kU4IMGbQ7/S/2mXyqpPIOB6pR16W4B26klNESQV5aadz6nnjCN1J1Ir9XxaCLD3MRi/3
         bRg3mAHLydA7YKDN3ZJWG/992SHApYuyZeOATcaiilk6bBXzsp73HXYQ90I1AeuLwnux
         WwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6E5OJlLmpvCUojBbNvvSJfeTwR8Atp2hl+3PorSHd4=;
        b=pTdemmfHQNtsUhr8BmxZXt9V78qUYz804306n1zLlBksiPclWimyLe1nswocANVTMt
         aqLeypDqhmx9KfLQgHwSo363c83dOvCUWjARHSgqgvSPoir+pbCmZeBvl9ebUDgyd4Tw
         Fh6FqPHOJHa3BTRTXkeCGKau0BOEFQ4n5XgaTrzvqUA5lvRY8/wdLRiFQJEmRElZT6oa
         to7AVRun5AMhYUXAcIh9WvVZfJk3ryI/SAqj+XHijOhHSOVoPIGLynAWIgeXClf9Dnj+
         Ig5F7BjYw9iNgLcQnvlHwEdQR4+ulzxCvaWcwh9eQseGogNcLjMBogQVC0NbbYpx+h5s
         W+Sw==
X-Gm-Message-State: APjAAAXqDN3IuanO1HRuM5d3fYGv1a7Df/iVlf79k0Njrm9+NkPZls/x
        8UYGMjg3U67ClR8730XyGf4dcxF0jRY=
X-Google-Smtp-Source: APXvYqwQDa0niZevwC2wLqa2VYomuoI8pmvttL9aOrqI6LCBjCpFLlJG5aoUKliFwsk06XWsOhL/pg==
X-Received: by 2002:a65:4c07:: with SMTP id u7mr8268996pgq.93.1560021779080;
        Sat, 08 Jun 2019 12:22:59 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.32.84])
        by smtp.gmail.com with ESMTPSA id o126sm6186290pfb.134.2019.06.08.12.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:22:58 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 1/3] sequencer: add advice for revert
Date:   Sun,  9 Jun 2019 00:49:56 +0530
Message-Id: <20190608191958.4593-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of merge conflicts, while performing a revert, we are
currently advised to use `git cherry-pick --<sequencer-options>`
of which --continue is incompatible for continuing the revert.
Introduce a separate advice message for `git revert`.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..9c561a041b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2655,6 +2655,7 @@ static int create_seq_dir(void)
 	if (file_exists(git_path_seq_dir())) {
 		error(_("a cherry-pick or revert is already in progress"));
 		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
+		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
 		return -1;
 	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
-- 
2.21.0

