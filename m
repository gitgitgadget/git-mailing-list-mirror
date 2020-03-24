Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72993C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4025720714
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4r/g3g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgCXTft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:35:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45533 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTft (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 15:35:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id u59so22096195edc.12
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QmuEj7bclplbq20p6EMc5fENjrB7izHsLxV02dAymJY=;
        b=t4r/g3g55VUISuzsesDerSP4OmKZM495oGBNGyGsZw78CbSdzmk/098a/JHNqPxwLJ
         RX5wXQsThW6LR0E3raCHMO2K9nS0vlVmeFYuAeNvoqt13PEMJBOvy0kl+vi0h0JuFdm5
         Y5ctycLWsyOOprp7JhcJxf+Zqt8UeVV3oMutb92i1lMwFUIEPhud6+NoI4ZIHatXCihq
         QV08NYPR9LUv9b3KkUDgL+6nD/bk1P+XmrjOC71cYvzvhh9NfNNRXqXykdTRqaMZaHbM
         gcusI4066bh3kGfyLbo/iOkrx1XSYrDQB7PxLj3sYTFJhXfIiY94HzmWyHt2vd949ASC
         idbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QmuEj7bclplbq20p6EMc5fENjrB7izHsLxV02dAymJY=;
        b=AaekHIMlqR/ECZnlAZebUGPDaDqkut2EFjhpuDsu1YErhupKtRDiWiamh9eHUyqadI
         GUILImfwyv32kNoby9LbpP8vFQ+IKJJJnZDtwSRm0m53kg5+6VGvHhnNVsUc4BzLWTue
         ukXu0aDoyGuYaarLOvrq1r8JDMYrNr+FovP7cCWP3+fDi0U6ttj2BsJkU/sN+34S4Dts
         0qHtv2I2CVAitF6n+LxIGPVJqYIepG4ldcIJZ/1AADGLjHqp1L45z3ZRwhdzS3Uqs/eT
         vpnUgdKBWqVKOq7WJZQY+IvF0jjLejk0Doo47NtWFSFbd+8+IS9k3Cwuo0nv+u47ObMY
         X4sg==
X-Gm-Message-State: ANhLgQ0gxg41TVOHfrxIDTSHV0hiRWbpODsCvlPK3sbFmXfEh/YxkR2l
        rA0SZEOYiq6UU5TNsjvi3p0OUNPo
X-Google-Smtp-Source: ADFU+vu1cM9IfxEQ2vUsTT2ZvkH0z3eww8r+IYxVawhCZb4PQkQKSIkJMdzb+b0E9TijWWvUrPO0sQ==
X-Received: by 2002:a50:d614:: with SMTP id x20mr29139319edi.186.1585078546510;
        Tue, 24 Mar 2020 12:35:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cq25sm517856edb.16.2020.03.24.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:35:45 -0700 (PDT)
Message-Id: <pull.577.v2.git.1585078545448.gitgitgadget@gmail.com>
In-Reply-To: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Mar 2020 19:35:45 +0000
Subject: [PATCH v2] import-tars: ignore the global PAX header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The tar importer in `contrib/fast-import/import-tars.perl` has a very
convenient feature: if _all_ paths stored in the imported `.tar` start
with a common prefix, e.g. `git-2.26.0/` in the tar at
https://github.com/git/git/archive/v2.26.0.tar.gz, then this prefix is
stripped.

This feature makes a ton of sense because it is relatively common to
import two or more revisions of the same project into Git, and obviously
we don't want all files to live in a tree whose name changes from
revision to revision.

Now, the problem with that feature is that it breaks down if there is a
`pax_global_header` "file" located outside of said prefix, at the top of
the tree. This is the case for `.tar` files generated by Git's very own
`git archive` command: it inserts that header, and `git archive` allows
specifying a common prefix (that the header does _not_ share with the
other files contained in the archive) via `--prefix=my-project-1.0.0/`.

Let's just skip any global header when importing `.tar` files into Git.

Note: this global header might contain useful information. For example,
in the output of `git archive`, it lists the original commit, which _is_
useful information. A future improvement to the `import-tars.perl`
script might be to include that information in the commit message, or do
other things with the information (e.g. use `mtime` information
contained in the global header as date of the commit). This patch does
not prevent any future patch from making that happen, it only prevents
the header from being treated as if it was a regular file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Ignore the global PAX header in import-tars.perl
    
    This problem came up in Pacman-related work, where PKGBUILD definitions
    would reference the tarballs downloaded from GitHub, and patches would
    be applied on top. To work on those patches efficiently (e.g. when an
    upgrade to a new version of the project no longer lets those patches
    apply), I need to be able to import those tarballs into playground
    worktrees and work on them. I like to use 
    contrib/fast-import/import-tars.perl for that purpose, but it really
    needs to strip the prefix, otherwise it is too tedious to work with it.
    
    Changes since v1:
    
     * Mentioned the implicit prefix-stripping feature of import-tars.perl 
       in the commit message; Without that context, it is really hard to
       understand the motivation for this patch.
     * Clarified in the commit message that this patch does not prevent any
       future patches that would use the information contained in the global
       header.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-577%2Fdscho%2Fimport-tars-skip-pax-header-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-577/dscho/import-tars-skip-pax-header-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/577

Range-diff vs v1:

 1:  718bde8f4a7 ! 1:  842dabe6128 import-tars: ignore the global PAX header
     @@ -2,12 +2,34 @@
      
          import-tars: ignore the global PAX header
      
     -    Git's own `git archive` inserts that header, but it often gets into the
     -    way of `import-tars.perl` e.g. when a prefix was specified (for example
     -    via `--prefix=my-project-1.0.0/`, or when downloading a `.tar.gz` from
     -    GitHub releases): this prefix _should_ be stripped.
     +    The tar importer in `contrib/fast-import/import-tars.perl` has a very
     +    convenient feature: if _all_ paths stored in the imported `.tar` start
     +    with a common prefix, e.g. `git-2.26.0/` in the tar at
     +    https://github.com/git/git/archive/v2.26.0.tar.gz, then this prefix is
     +    stripped.
      
     -    Let's just skip it.
     +    This feature makes a ton of sense because it is relatively common to
     +    import two or more revisions of the same project into Git, and obviously
     +    we don't want all files to live in a tree whose name changes from
     +    revision to revision.
     +
     +    Now, the problem with that feature is that it breaks down if there is a
     +    `pax_global_header` "file" located outside of said prefix, at the top of
     +    the tree. This is the case for `.tar` files generated by Git's very own
     +    `git archive` command: it inserts that header, and `git archive` allows
     +    specifying a common prefix (that the header does _not_ share with the
     +    other files contained in the archive) via `--prefix=my-project-1.0.0/`.
     +
     +    Let's just skip any global header when importing `.tar` files into Git.
     +
     +    Note: this global header might contain useful information. For example,
     +    in the output of `git archive`, it lists the original commit, which _is_
     +    useful information. A future improvement to the `import-tars.perl`
     +    script might be to include that information in the commit message, or do
     +    other things with the information (e.g. use `mtime` information
     +    contained in the global header as date of the commit). This patch does
     +    not prevent any future patch from making that happen, it only prevents
     +    the header from being treated as if it was a regular file.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      


 contrib/fast-import/import-tars.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index e800d9f5c9c..d50ce26d5d9 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -139,6 +139,8 @@
 			print FI "\n";
 		}
 
+		next if ($typeflag eq 'g'); # ignore global header
+
 		my $path;
 		if ($prefix) {
 			$path = "$prefix/$name";

base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
-- 
gitgitgadget
