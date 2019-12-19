Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67870C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2886324679
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njmnspSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLSV2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43132 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSV2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so6291691edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2q8KnlNrJTDqyUI5VnahSB9Fm2w6Elk41S3NsW95Em8=;
        b=njmnspSKgeqARZ1MdZQA6WjeTn0YPKdMFbbEeWUltLCACXSV1Cu1vyt1N6D9ip7fcH
         ntWsLQeL9peppG9YHa9rVtFDjn3kZHgJJ95Y4twd+D2h2nkfNdGHBvyk3cziISVcR1uk
         6qMlkBGwnxuOPeDttYraFkUIeXAG4ipOQxGxeebdlXadGM7q1x6AuKX1Ab/seuafiYTt
         vQrzHUMCmFDs5pnkeWVce9jmIHXtAz9mvqs28WDklG6Y+1UEG5wAadxRvWICBwyS/3aJ
         gUMCqjRIo8Wh2MmpooV99jJ0YdIn+ivMLFVrYyxCx1eozberCx1kM2ph+TPTeqlKtmR9
         gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2q8KnlNrJTDqyUI5VnahSB9Fm2w6Elk41S3NsW95Em8=;
        b=SUQ43b06d57Q9k3PyrdUSdTKc7XMFJ5Lx+vFwLbkRDN8XB6K/KGlBeAnzDPxHQO6lf
         AYnG7O/Sp5VFqsXAenMORFCNcf1TEd7VSIPogSnTrGH6q9P5XTd6pmIEiitem1lnyVaG
         soonh5+fB+iLOGKO90JTL98TOtkHpn+XhhV/M8jn8um5MIL4hOUL9IFeDcdfpJCyBPXp
         9JGQsU37pWp/tZcIoSgGuA8ustjxeegCV8ORZd7aQ+u/afTdAWFqHKAeIUFsxSKunAqR
         2aEn4OeIdaEScwlEBQuch+B+ne3eF9jxLAbx1iPvwom6hPnN9Hbrza/9tEEd22nxInN2
         62mw==
X-Gm-Message-State: APjAAAUvLl/pDpomU9Xb25tnssRIWR+tt8hoIyeIAeNit/y+6ZxxMLUz
        6KX4Plo0ew8t5z4YEZhLk+LDnrsH
X-Google-Smtp-Source: APXvYqzDueR5M4WzRWuDfCjWoL9DqukcErt8cFJAIZ6OprUoTGrtpzWim6y3dohsBl8gEbQTSxYZ3w==
X-Received: by 2002:a50:cbc3:: with SMTP id l3mr11773289edi.258.1576790908407;
        Thu, 19 Dec 2019 13:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm674328edu.70.2019.12.19.13.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:27 -0800 (PST)
Message-Id: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:18 +0000
Subject: [PATCH v5 0/8] Directory traversal bugs
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

Changes since v4:

 * added a comment with the rationale for allocating an extra len+1 bytes
   for the dirent.

Elijah Newren (8):
  t3011: demonstrate directory traversal failures
  Revert "dir.c: make 'git-status --ignored' work within leading
    directories"
  dir: remove stray quote character in comment
  dir: exit before wildcard fall-through if there is no wildcard
  dir: break part of read_directory_recursive() out for reuse
  dir: fix checks on common prefix directory
  dir: synchronize treat_leading_path() and read_directory_recursive()
  dir: consolidate similar code in treat_directory()

 dir.c                                         | 187 ++++++++++++----
 ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
 t/t7061-wtstatus-ignore.sh                    |   9 +-
 3 files changed, 354 insertions(+), 51 deletions(-)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-676%2Fnewren%2Fls-files-bug-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-676/newren/ls-files-bug-v5
Pull-Request: https://github.com/git/git/pull/676

Range-diff vs v4:

 1:  6d659b2302 = 1:  6d659b2302 t3011: demonstrate directory traversal failures
 2:  79f2b56174 = 2:  79f2b56174 Revert "dir.c: make 'git-status --ignored' work within leading directories"
 3:  d6f858cab1 = 3:  d6f858cab1 dir: remove stray quote character in comment
 4:  8d2d98eec3 = 4:  8d2d98eec3 dir: exit before wildcard fall-through if there is no wildcard
 5:  d2f5623bd7 = 5:  d2f5623bd7 dir: break part of read_directory_recursive() out for reuse
 6:  1f3978aa46 ! 6:  97e145489d dir: fix checks on common prefix directory
     @@ -93,6 +93,16 @@
       	if (!len)
       		return 1;
      +
     ++	/*
     ++	 * We need a manufactured dirent with sufficient space to store a
     ++	 * leading directory component of path in its d_name.  Here, we
     ++	 * assume that the dirent's d_name is either declared as
     ++	 *    char d_name[BIG_ENOUGH]
     ++	 * or that it is declared at the end of the struct as
     ++	 *    char d_name[]
     ++	 * For either case, padding with len+1 bytes at the end will ensure
     ++	 * sufficient storage space.
     ++	 */
      +	de = xcalloc(1, sizeof(struct dirent)+len+1);
      +	memset(&cdir, 0, sizeof(cdir));
      +	cdir.de = de;
 7:  542c6e5792 = 7:  5275e6d7f0 dir: synchronize treat_leading_path() and read_directory_recursive()
 8:  31079dc1cf = 8:  e4768931d0 dir: consolidate similar code in treat_directory()

-- 
gitgitgadget
