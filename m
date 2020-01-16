Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF90C33CB7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6DB2077B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCDbP8o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgAPUWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:22:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34676 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgAPUWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:22:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so7934113wmi.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cBTC8tCo7P9XJoveFX6O7HPmxFMxxn2pGtR2BnNpop4=;
        b=vCDbP8o5kJCa31bTWrQuFsrJcIf336G1hj2aZ5ElyZRYUnn2FOs6JMrEB3UvgLf0+K
         zZVydcKq9OObuV1Dt6Y2XefvBoTxzPeIUPFni0si1yOYll8Kn9lwBzxGeQtbT7doikWf
         yfH2c2Q8jlqexigSbQh/LlUE9s2DCERcdafYWD21/nXmiDYnf0vvzdK84QZ0ZYjm2sut
         MtEW9F2sy5Xz9HRQ66ao5sH8sZ2sUGzUAn/nYwd98p6EQ35SNrPY0WPTpa1Y4Rylr3rn
         NPbHceIuoT2c06G7BRR9rEt0KZoKONhYwUL/cJkc74j0QJz6aFGTPGKdwIDhrwDgfulm
         rvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cBTC8tCo7P9XJoveFX6O7HPmxFMxxn2pGtR2BnNpop4=;
        b=sFrGCzBT7Us1r+L1FPCOVlKNS1quM4weAsDhC+7Zlcbxb7bRdoECbaPFO+Srf/+8cK
         /ZUGQR19xtBYENf/EgZxpKwR5bSMITTo0PpHEVfliOnbcLdwB+Vnvz+X5U8q4q2Mphjb
         c2tOHv/CvyYzkbzZK2OVOD1Z++ti+xyVMzFOMs2b6/iPph0gAZtkhHI+TpW1Dlp59Txw
         9z1tMCFCSW0DE0PmiirfaGPsAHqaNf6T83g/jdKmgmZz3/pV/6XiSWzIytD2fIIq/5KR
         14JvqafefZnRK2CHSPGG4D+NrfLk1zIUWbvFKhJAH/0LHPhj8N+wdp0TPLBddeXGDLkx
         WUeQ==
X-Gm-Message-State: APjAAAV8XgW+1oA+wKIifKuJtq5V07Dx1VnWfTJZne+4LRiiwQeRyfF6
        bIQBD+GFCjwNY02rK0dcCObsyuQL
X-Google-Smtp-Source: APXvYqylvAsf5UiAVhIHSrHYyhaHL94uDkMJWPI7qmYfLuCsZQqDK+na9oueqa/ErfXI0GuAGy9DOg==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr820827wmj.88.1579206117901;
        Thu, 16 Jan 2020 12:21:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s65sm4675571wmf.48.2020.01.16.12.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:21:57 -0800 (PST)
Message-Id: <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 20:21:52 +0000
Subject: [PATCH v3 0/4] dir: more fill_directory() fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up to en/fill-directory-fixes, and has grown from 1 patch
in v1 to 4 patches in v2, 3 of which are submissions by others to the git
list that I've just combined into one series since they are all about
fill_directory().

The first two patches may make sense to include in maint at some point,
though Stolee isn't that concerned about this regression[5][6].

 * The first patch is Kevin and Stolee's testcase showing a regression in
   "git clean -f "[1]
 * The second patch is a "simple" fix for that testcase with a pretty long
   (and slightly embarrassing though entertaining) backstory.
 * The third patch was from v1, and is a small tweak made by me to a patch
   proposed by Peff[2] (signoff from [3]) to avoid needing to create a
   dirent.
 * The fourth patch was a follow-up from Peff in response to V1 fixing a
   code comment[4].

[1] 
https://lore.kernel.org/git/pull.526.git.1579119946211.gitgitgadget@gmail.com/
[2] 
https://lore.kernel.org/git/20191219222403.GA705525@coredump.intra.peff.net/
[3] 
https://lore.kernel.org/git/20200114220357.GA3957260@coredump.intra.peff.net/
[4] 
https://lore.kernel.org/git/20200115202146.GA4091171@coredump.intra.peff.net/
[5] 
https://lore.kernel.org/git/354fa43b-0e62-1ee5-a63f-59d9b2da7d3f@gmail.com/
[6] 
https://lore.kernel.org/git/e008da66-defe-d2b0-410b-64b7754b9c6e@gmail.com/

Derrick Stolee (1):
  clean: demonstrate a bug with pathspecs

Elijah Newren (1):
  dir: treat_leading_path() and read_directory_recursive(), round 2

Jeff King (2):
  dir: restructure in a way to avoid passing around a struct dirent
  dir: point treat_leading_path() warning to the right place

 dir.c            | 83 ++++++++++++++++++++++--------------------------
 t/t7300-clean.sh |  9 ++++++
 2 files changed, 47 insertions(+), 45 deletions(-)


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-692%2Fnewren%2Favoid-dirent-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-692/newren/avoid-dirent-v3
Pull-Request: https://github.com/git/git/pull/692

Range-diff vs v2:

 -:  ---------- > 1:  9efed585ef clean: demonstrate a bug with pathspecs
 -:  ---------- > 2:  ea95186774 dir: treat_leading_path() and read_directory_recursive(), round 2
 1:  edb18304b2 = 3:  5b8fa6e5a7 dir: restructure in a way to avoid passing around a struct dirent
 -:  ---------- > 4:  9d346f8b6b dir: point treat_leading_path() warning to the right place

-- 
gitgitgadget
