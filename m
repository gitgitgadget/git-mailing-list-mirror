Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D0320A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLIKpI (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33025 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLIKpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so7135090ljd.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yEeoat5Llcv8lEZ5ntDWDeQSgXcIflSaqsl8KBpFyo=;
        b=sNAHNjQYaEdoKhRWbwQTS7XnHSYcfIeD3eWDIeTzK1rqR6ormbT90FMc55OLAhV83R
         zfNwDsfK8TflzGB1+zRChq/rqiN4casX+0dOYyvTteJczjEUYXcl0cR+VN9An+BMsl+m
         ZEFuZTEvDvkB5TXdAGGuCj4WEu9mLEOXUSEKO4ImmSqZKO9Wd/s2lMlcZCq2KbODTdF+
         BfInZNcZH/QWfRLBNB54l6iw7oN/GMTImYAqK7CqZ0eTswebBTWAN+xIUbpa36kvY8ri
         AX0CKkpOZpOkaB5wcqIwAl6wD2kXyOBnRAd4Y60SaAohq+lc4P5kWU2wC//bGUE1VKCe
         B8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yEeoat5Llcv8lEZ5ntDWDeQSgXcIflSaqsl8KBpFyo=;
        b=t+EBUMNjl3BBpM4HOOzVHlDeParA8IvIArepqQ4DJYqMM7GHv/UnDCeQIAEA0e1y1n
         HnBLKpW3Z8u0vlKCRrk4UU2ieMlIiYlcSF46+TFYtTKHArN90tw0+H1paYDZXPOvsVBo
         iVeeNOjTg69RvvGum9+ehvfNUrFw1Kgx+bPTasWnLFEf05gg8j2B/Mx3ATyY0/E7SXhG
         8L4xyznvpZNl005Puq40KkT5CVnNRPXrmx3JpM8TF3VRd+t+tn4gAwg/TFzdVNa7BfZK
         hvNr+zN10Dxc6az2iKZkDA+zv+Rn0GajPj9D3yDrI7PPZbjEtwEOjwh30JFHH8Zk0MUy
         SPQg==
X-Gm-Message-State: AA+aEWaWzY/Rcoom5v0byJuTfcz+x3gt5CxXFbOYvFZwsRBNTuSlQIyh
        RvBFN+dP3XLBMeqdsft6ACAR9F2J
X-Google-Smtp-Source: AFSGD/UvCc9f+Ikx+QtXWe6KRnV0zBJ4V7DN3AIZZalplSdloMmYeOGwtNG5r+TQzcj4o/ubmGRHrw==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr5529445ljj.61.1544352305445;
        Sun, 09 Dec 2018 02:45:05 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:04 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/24] add: support backup log
Date:   Sun,  9 Dec 2018 11:43:59 +0100
Message-Id: <20181209104419.12639-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is not much to say about the actual change in this patch, which
is straightforward. There is something to say about the lack of change
though.

The definition of "interesting" changes to keep in backup log
previously is "file modification, except file removal". It is further
refined: only changes coming from worktree (for from the user to be
more accurate) are interesting. Changes in the index from object
database (e.g. merging, switching branches, resetting...) are not
interesting because the actual content is already in the object
database and can be recovered (provided that you still have the
history of commands you used, of course)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/add.c         |  5 +++++
 t/t2080-backup-log.sh | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index f65c172299..f21d9efdd9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -393,6 +393,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int require_pathspec;
 	char *seen = NULL;
 	struct lock_file lock_file = LOCK_INIT;
+	int core_backup_log = 0;
 
 	git_config(add_config, NULL);
 
@@ -439,6 +440,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
+	repo_config_get_bool(the_repository, "core.backuplog", &core_backup_log);
+	if (core_backup_log)
+		flags |= ADD_CACHE_LOG_UPDATES;
+
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index 267c34bb25..f7bdaaa3f6 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -17,4 +17,15 @@ test_expect_success 'backup-log add new item' '
 	test_cmp expected .git/index.bkl
 '
 
+test_expect_success 'add writes backup log' '
+	test_tick &&
+	echo update >>initial.t &&
+	OLD=$(git rev-parse :./initial.t) &&
+	NEW=$(git hash-object initial.t) &&
+	git -c core.backupLog=true add initial.t &&
+	echo "$OLD $NEW $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	initial.t" >expected &&
+	tail -n1 .git/index.bkl >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

