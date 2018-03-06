Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059221F404
	for <e@80x24.org>; Tue,  6 Mar 2018 04:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeCFEjg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 23:39:36 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36393 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeCFEjg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 23:39:36 -0500
Received: by mail-pg0-f53.google.com with SMTP id i14so7847523pgv.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 20:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R9p8uL+uc59KjArZsUGTtJBDms1LE0Nbb61VO76AWcM=;
        b=CP+2m2zdQYn//KjB155991Gp71M2gtU5adLCNeBQZe077E6cLPGQVqPc3aT5HfD6wI
         op2+frgWYb28t4WaVYouYGOUgVcHaCf3DnMcxja9OwQmF2En5+C3sLV238fF0eK6LVTR
         JytC3+0Dp8uIrUFUaNyZ938s90BRBOOIfQp7Zb5Un8tllxiB5qBckcHDwGp1FZjw9aHk
         Dr8MLmum3GsY46YJWzkv3rCY6SENuvvyva+Gu3AQuBCmxEOw63l2eRcTRVZTf64mV+cM
         6+OulezesbulWEReA4HptY0W34rKzy/UeTjUFRpGmRrWDfbmTet+fzo+L1bT5LPU7KR5
         qTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R9p8uL+uc59KjArZsUGTtJBDms1LE0Nbb61VO76AWcM=;
        b=IONJrofa23ZCiNzMvI+7Znp1vaN6flVgW4qaXC5173GgDs2Rp59miUT3sW0JVE8hza
         PTKgbvKww1QU2ppK5xsKvUh8E0gIm11F40CtRQUGCCi2d8HLlkQequF8XUEoMg0Hbnyh
         EIwh7oBEO9M5K6hBtVa8LOSFFyKiuJfDRZy6eWN3hAMRa+lhwXV38wcJ+D3vqbMQBIrT
         DJVFXSxtAhzXWs5pCJ6VmyQmSzYTraxwDO7EdfHwhaN0sZHBYa8VmFozJaXqauSa4u1T
         ESnjs3NJG7vrYg/IyKtWo5MGlW+BH3kd2mNdY2n9JzAEM5/QKn2eNiDFvIkYe27tTq8/
         xTGQ==
X-Gm-Message-State: APf1xPBzfsr4heen1T5FF94P8qdQAYaMe6KoCAGUeOtgkwFfyGBQQvbq
        4ZPlhPeoIcecUnfXBIwDxqNnhvKE
X-Google-Smtp-Source: AG47ELsBVJFMKmCEr/JTGBHpKBYSrvc1K7JHhameaiLmW99PFJqGw8wy8D/OFcj9ZP/FoX0Arww9fQ==
X-Received: by 10.98.69.196 with SMTP id n65mr17712437pfi.29.1520311175245;
        Mon, 05 Mar 2018 20:39:35 -0800 (PST)
Received: from Dorabs-iMac.com (cpe-23-242-199-161.socal.res.rr.com. [23.242.199.161])
        by smtp.gmail.com with ESMTPSA id q20sm25330098pgc.84.2018.03.05.20.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Mar 2018 20:39:34 -0800 (PST)
From:   Dorab Patel <dorabpatel@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>
Subject: [PATCH v2] git.el: handle default excludesfile properly
Date:   Mon,  5 Mar 2018 20:38:46 -0800
Message-Id: <20180306043846.33733-1-dorabpatel@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180303034803.21589-1-dorabpatel@gmail.com>
References: <20180303034803.21589-1-dorabpatel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous version only looked at core.excludesfile for locating the
excludesfile.  So, when core.excludesfile was not defined, it did not
use the relevant default locations for the global excludes file.

The issue is in git-get-exclude-files().  Investigation shows that
git-get-exclude-files() is only called from
git-run-ls-files-with-excludes().  Modifying
git-run-ls-files-with-excludes() to use the "--exclude-standard"
option to git-run-ls-files() obviates the need for
git-get-exclude-files() altogether, which is now removed.  In
addition, the "--exclude-per-directory" option to git-run-ls-files()
is used only when git-per-dir-ignore-file is not the default
(.gitignore), since the default case is handled by the
"--exclude-standard" option.

Looking at the history shows that git-get-exclude-files() was
implemented by commit 274e13e0e9 (git.el: Take into account the
core.excludesfile config option., 2007-07-31), whereas the
"--exclude-standard" option was introduced by commit 8e7b07c8a7
(git-ls-files: add --exclude-standard, 2007-11-15), three and a half
months later.  This explains why the "--exclude-standard" option was
not used in the original code.

Signed-off-by: Dorab Patel <dorabpatel@gmail.com>
---

Notes:
    The original patch[1] V1 attempted to add code to
    git-get-exclude-files() to handle the case when core.excludesfile was
    not defined.  This involved code to check for the env variable
    XDG_CONFIG_HOME and related processing to find the value of the
    default excludesfile.  Further investigation showed that using the
    "--exclude-standard" option to git-run-ls-files-with-excludes()
    already does similar processing.  Hence the V2 patch uses the
    "--exclude-standard" option and does away with
    git-get-exclude-files().
    
    [1] https://public-inbox.org/git/20180303034803.21589-1-dorabpatel@gmail.com/

 contrib/emacs/git.el | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 97919f2d7..cef42f1de 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -755,22 +755,13 @@ Return the list of files that haven't been handled."
       (setq unmerged-files (nreverse unmerged-files))  ;; assume it is sorted already
       (git-set-filenames-state status unmerged-files 'unmerged))))
 
-(defun git-get-exclude-files ()
-  "Get the list of exclude files to pass to git-ls-files."
-  (let (files
-        (config (git-config "core.excludesfile")))
-    (when (file-readable-p ".git/info/exclude")
-      (push ".git/info/exclude" files))
-    (when (and config (file-readable-p config))
-      (push config files))
-    files))
-
 (defun git-run-ls-files-with-excludes (status files default-state &rest options)
-  "Run git-ls-files on FILES with appropriate --exclude-from options."
-  (let ((exclude-files (git-get-exclude-files)))
-    (apply #'git-run-ls-files status files default-state "--directory" "--no-empty-directory"
-           (concat "--exclude-per-directory=" git-per-dir-ignore-file)
-           (append options (mapcar (lambda (f) (concat "--exclude-from=" f)) exclude-files)))))
+  "Run git-ls-files on FILES with appropriate exclude options."
+  (apply #'git-run-ls-files status files default-state
+	 "--directory" "--no-empty-directory" "--exclude-standard"
+	 (append (unless (string-equal git-per-dir-ignore-file ".gitignore") ; handled by --exclude-standard
+		   (list (concat "--exclude-per-directory=" git-per-dir-ignore-file)))
+		 options)))
 
 (defun git-update-status-files (&optional files mark-files)
   "Update the status of FILES from the index.
-- 
2.16.2

