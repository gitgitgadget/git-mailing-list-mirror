Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A3520A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeLIKpE (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39645 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLIKpE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so7091618ljh.6
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=in/KfUEslkDy4N82L9x/pUwJ3R8vX4GvrN0V+SSOwKY=;
        b=Pvr2tl+Su71MphkGn4ZDtN0QbxMk9SmJqfhVLFU/y6QitpcMomUonohRHA3s2YuqD4
         Cl3itXskJlMFV4Of2W7JIyRNOsk8bTIgcYQZCkuUT509pJEpcCziKYBwWW8h3zlWFtk2
         6bPE8uayWJEMYBTR8fJiNAJ4fP6qgz7MFjBqFrb4lnDnxSYhlx4grPh5p5JXROhbJtpk
         tDKhVYcqwim13zykpvK5x3JA3RZqBa/bFD7xXUGNL6GWXOffMPF9FoSdIh5olnZH2Xph
         2988h1/tvkmnRW+xJWkkuTlYDnPLZhB6QtYC43mMwasxYNAzHpKEeDMeFZBiGiP1IOov
         UfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=in/KfUEslkDy4N82L9x/pUwJ3R8vX4GvrN0V+SSOwKY=;
        b=HLR3dFJ0jQFn6Nyso7a1P1yR07Eg8eD1bwyIYgXNG8ZcROdropkI5mPBjqqVGG6sVf
         WiPMGW30QR4/HvdcHRCsVQTpeKrWzWiPhNvrURKQfEsHdtLV8IokXac2QDxpmEEx12IX
         5WqM2M1P7i788UKdMihpcvRvXO4N9AuXGW0wXODdcP9BM9siiOyZupo8Xqk+u4TLOGL3
         jxeGYmUkJcRA1tGUi6YWh06GdSSiG3qSO/+/iE6hIup3cTPBX/3Y4SJdaLVnYS8L0lyV
         rKswAmr4kl/U9Ajp2gp0wWGd8khyr3n8enOuZzTtkXp1MVg7Rmkxz/CmvmHmKZYNam8J
         GwPw==
X-Gm-Message-State: AA+aEWbyEIAs71jI9PTv8oeSkU2vaai6KO9Kpn5Yb+PPjRZ5VtLPuy5/
        Ig+8DBcXxN5/16RlOlsfA4UhDSYg
X-Google-Smtp-Source: AFSGD/Xr11yw+QZLPFV/tGyBWYRnBC5+UtGWU2aI7b0oNPI/6n+t5WWO+kK0hBf8hhrXQjSogxtP+Q==
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr5223737lji.133.1544352301470;
        Sun, 09 Dec 2018 02:45:01 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:00 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/24] doc: introduce new "backup log" concept
Date:   Sun,  9 Dec 2018 11:43:56 +0100
Message-Id: <20181209104419.12639-2-pclouds@gmail.com>
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

A reflog file records changes of a certain ref over time. A backup log
file does a similar job, but it records changes of some files over time.
This is the main idea of it.

This is added so that we can support undoing certain changes. For
example, if you have carefully prepared your index with "git add -p"
then accidentally do "git commit -a", your well crafted index is lost
with no easy way to recover it. We could go the other way and make
"git commit -a" complain loudly, but that has other bad side effects,
the big one is we may complain too loudly at the wrong time and too
often. This "do the right things (most of the time) but allow the
user to undo when we get it wrong" approach seems more inline with how
git handles other things.

The current plan is to have three backup log files:

- $GIT_DIR/index.bkl contains "interesting" changes made in the index.

- $GIT_DIR/worktree.bkl contains "interesting" changes made in
  worktree.

- $GIT_DIR/common/gitdir.bkl contains changes made in other files
  inside $GIT_DIR such as config, those in info/ directory, or reflog
  file deletion (aka the mystical reflog graveyard)

All these only record "interesting" changes which will be defined
later. But a few examples of them are: "git add -p" is interesting,
but "git reset HEAD" is not. Similarly changes made in $GIT_DIR/config
are usually interesting.

This patch does none of that! It adds a new man page for a new
plumbing command "git backup-log" which does show what this
functionality looks like.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config/core.txt    |   5 ++
 Documentation/git-backup-log.txt | 107 +++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/git-backup-log.txt

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d0e6635fe0..63b78cc048 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -316,6 +316,11 @@ This value is true by default in a repository that has
 a working directory associated with it, and false by
 default in a bare repository.
 
+core.backupLog::
+	If true, many commands will keep backup content in object database
+	before they modify some file. See linkgit:git-backup-log[1] for more
+	information.
+
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
 	version.
diff --git a/Documentation/git-backup-log.txt b/Documentation/git-backup-log.txt
new file mode 100644
index 0000000000..98998156c1
--- /dev/null
+++ b/Documentation/git-backup-log.txt
@@ -0,0 +1,107 @@
+git-backup-log(1)
+=================
+
+NAME
+----
+git-backup-log - Manage backup log files
+
+
+SYNOPSIS
+--------
+[verse]
+'git backup-log' [--id=<id> | --path=<path>] log [<rev-options>] [[--] <path>...]
+'git backup-log' [--id=<id> | --path=<path>] cat [--before] [--hash] <change-id> <path>
+'git backup-log' [--id=<id> | --path=<path>] diff [<diff-options>] <change-id>
+'git backup-log' [--id=<id> | --path=<path>] prune [--expire=<time>]
+'git backup-log' [--id=<id> | --path=<path>] update <path> <old-hash> <new-hash>
+
+DESCRIPTION
+-----------
+Backup log records changes of certain files in the object database so
+that if some file is overwritten by accident, you could still get the
+original content back.
+
+Backup log is enabled by setting core.backupLog to true and the
+following commands will save backups:
+
+- linkgit:git-add[1] keeps all index changes. File removal is not
+  recorded.
+- linkgit:git-commit[1] keep all index changes in `-a` or partial
+  commit mode.
+- linkgit:git-apply[1] and linkgit:git-update-index[1] will keep
+  changes if `--keep-backup` is specified
+- Changes of `$GIT_DIR/config` made by `git config --edit` are kept.
+- Deleted reflogs are kept. References from this deleted reflog will
+  not be kept at the next garbage collection though. This is mostly
+  meant to immediately undo an accidental branch deletion.
+- linkgit:git-checkout[1] when switching branches and
+  linkgit:git-merge[1] will make a backup before overwriting
+  ignored files.
+- linkgit:git-checkout[1] with `--force`, linkgit:git-reset[1] with
+  `--hard` or linkgit:git-am[1] and linkgit:git-rebase[1] with
+  `--skip` or `--abort` will make a backup before overwriting non
+  up-to-date files.
+
+Backups are split in three groups, changes related in the index, in
+working directory or in $GIT_DIR. These can be selected with `--id`
+parameter as `index`, `worktree` and `gitdir` respectively.
+Alternatively file path of these are `$GIT_DIR/index.bkl`,
+`$GIT_DIR/worktree.bkl` and `$GIT_DIR/common/gitdir.bkl` which could
+be specified with `--path`
+
+This command is split into subcommands:
+
+update::
+	Add a new change associated with `<path>` from `<old-hash>` to
+	`<new-hash>` to the selected backup log file. `<path>` must be
+	normalized.
+
+log::
+	View the selected backup log (optionally filtered by pathspec).
+	By default, the diff of the change is shown.
+
+cat::
+	Output the file content or their object name of a specific
+	change.
+
+diff::
+	Output the diff of a specific change.
+
+prune::
+	Prune the backup log, delete updates older than a specific
+	time or invalid entries. The actual backup content is still in
+	the object database and may need to be pruned separatedly.
+
+OPTIONS
+-------
+
+--id=<id>::
+	The name of the the backup log file. Supported names are
+	`index`, `worktree` and `gitdir`.
+
+--path=<path>::
+	The path of a backup log file.
+
+--before::
+	Show the version before the change instead. This is most
+	useful when the change is a file deletion.
+
+--hash::
+	Show the object name instead of content.
+
+--expire=<time>::
+	The cutoff time for pruning backup log. The default is three
+	months ago.
+
+<path>::
+	The path of the file where the change is made.
+
+<old-hash>::
+	The blob hash of the content before the change.
+
+<old-hash>::
+	The blob hash of the content after the change.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.20.0.rc2.486.g9832c05c3d

