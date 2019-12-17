Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D1C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD3C20717
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPtw6ku1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLQIdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:33:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55755 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 03:33:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so1965595wmj.5
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 00:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uXhqVAkWwBqwge8hiwMEOQ0XWZMAEn9859MJQWMN8UI=;
        b=NPtw6ku1epaBV5jLexpiCQ46DejnzKNj2u41hthxAcaDOi6/NWKijUD3hQ4yEYeg+t
         TUDC5VNwFAvD7IhOO4cMkHoEzDdDu7zbGLs8dsVb6BSFiotY4EgcZF9XkLF31E3pDv3P
         nhGdcOcZhAfGitmRbXbCHd/pjFQmo3EoXVyhLiNPv0faqoPfGDpEVHQwepaR6l5gaXOr
         pq810fWQkfYylz5G9zzIdc7OWBoZT9+/54DZbRqsmhMY0+Jqea33zWX4QDIrF97ewhqs
         LOBW9rWJD88X/ms4oy+jBrf2hWRw7AT/gf3WRw+S7QJMQ4/0c6ZVHjwYvQ2QzbtijpAB
         VrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uXhqVAkWwBqwge8hiwMEOQ0XWZMAEn9859MJQWMN8UI=;
        b=J6EblZNoQ3gdqhYhdeOMlpZjNXTwcU+7ksOIaL40vB4xv8HxMt/VLHoP1fNqhJaNgV
         Br7lKjd4Vf5BHkc7Dr/ZqetvZHE56pn2mvGjziLLeCCGt424EFwBCvMaRoB4PL/v/uWZ
         tgKshy/o76VilLkAq/KrVYCmAZpBWDXgCxKo0723p8RSKiYWnzJyEMiMmtSvGUmuRTSB
         pleyY+5iwsbD70nMfRya3NdzImhZQM3DFjXtp6/DJNipBSSbdX1U2ePuXYi1D1iVQ5mP
         jfpD6Ktl8pS9/cy1R4obzuaeaL2bt4gAoGzQKxuPXw6NZUGUeX4VHmPDYuEmiM2Xb7xL
         vuOg==
X-Gm-Message-State: APjAAAU/4QA2H82xGyhrJoHoursj/uWVcsiQVTa+zZbz3ZYW1e9szjgb
        VNkok+MEyoFs1C9L0NGHuDNyA2/v
X-Google-Smtp-Source: APXvYqyYP+ZdOO52SM2Ors94Kn1F/ON2rMpbt4TcROkSZtuzKSImuqDUbVPqfTodOwd+ReAG+J1Gfg==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr3992701wmf.105.1576571588093;
        Tue, 17 Dec 2019 00:33:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm2110583wmj.40.2019.12.17.00.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 00:33:07 -0800 (PST)
Message-Id: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 08:33:03 +0000
Subject: [PATCH v3 0/3] Directory traversal bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series documents multiple fill_directory() bugs, and fixes the one that
is new to 2.24.0 coming from en/clean-nested-with-ignored-topic, the rest
having been around in versions of git going back up to a decade. 

Changes since v2:

 * gutted the series of most the fixes, dropping the patch count from 8 to
   3, due to incompatibility with git-for-windows (which interestingly has a
   different compat/win32/dirent.h than git.git does). The only bugs
   reported by a user are fixed by patch 3, and fixing the remaining bugs
   (which I found while investigating the one fixed bug) would require a
   major refactor that I don't have the time for currently.

Elijah Newren (3):
  t3011: demonstrate directory traversal failures
  dir: remove stray quote character in comment
  dir: exit before wildcard fall-through if there is no wildcard

 dir.c                                         |   9 +-
 ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
 2 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-676%2Fnewren%2Fls-files-bug-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-676/newren/ls-files-bug-v3
Pull-Request: https://github.com/git/git/pull/676

Range-diff vs v2:

 1:  6d659b2302 ! 1:  61d303d8bd t3011: demonstrate directory traversal failures
     @@ -14,6 +14,18 @@
          of the en/clean-nested-with-ignored-topic); the other 5 also failed
          under git-2.23.0 and earlier.
      
     +    The old failing tests can be traced down to the common prefix
     +    optimization in dir.c handling paths differently than
     +    read_directory_recursive() and treat_path() would, due to incomplete
     +    duplication of logic into treat_leading_path() and having that
     +    function call treat_one_path() rather than treat_path().  Fixing
     +    that problem would require restructuring treat_path() and its full
     +    call hierarchy to stop taking a dirent; see
     +       https://lore.kernel.org/git/xmqqzhfshsk2.fsf@gitster-ct.c.googlers.com/
     +    and the thread surrounding it for details.
     +
     +    For now, simply document the breakages.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
 2:  79f2b56174 < -:  ---------- Revert "dir.c: make 'git-status --ignored' work within leading directories"
 3:  d6f858cab1 = 2:  49b0b628db dir: remove stray quote character in comment
 4:  8d2d98eec3 = 3:  47814640e4 dir: exit before wildcard fall-through if there is no wildcard
 5:  d2f5623bd7 < -:  ---------- dir: break part of read_directory_recursive() out for reuse
 6:  9839aca00a < -:  ---------- dir: fix checks on common prefix directory
 7:  df7f08886a < -:  ---------- dir: synchronize treat_leading_path() and read_directory_recursive()
 8:  77b57e44fd < -:  ---------- dir: consolidate similar code in treat_directory()

-- 
gitgitgadget
