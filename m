Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9301FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbdBJT54 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:57:56 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34945 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdBJT5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:57:55 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so3804970pge.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5gK77orLWJess1HH5EWbjo7eU/Vxeck3VZreibkcUNE=;
        b=kkaISjjYDL628zjvlghfnhmM7CpyC1I0kkKXG1x+mmOvbWhcq3lnbfMnhcHGDMwFS3
         QUtG44ctJPhTeWJUhtkOdlxv/aqr0uTYQg6yB5UdoW8fP6sqlf3hhciz+R9x0dyTh7xn
         ZgXAoWeBCV6K4wFRY42mqDBNHPHE83IvpbqCSoE0q9PeUrCLXwRudzND4rgzmvICdzlg
         /VwmoRGTH9DUPUipWUsFjorYMLu9NMIgzgs/hz8dKvUHZTT+tnQ0yUOzsOu/SazhdxH+
         DPnyDaPJu+yLP/qTTJqP4ZoFlHtguHH0I5j4sRPN1P9zdopmw7xE/YtNybRGe31Ayfjt
         YTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5gK77orLWJess1HH5EWbjo7eU/Vxeck3VZreibkcUNE=;
        b=crg60rZeCGDMMLpz/hC04+xQMRQJeCScTQtvYzq+J90cvcQWEVmu7bGzRl3Mpy20hj
         QWclHWOKsXbi+yI9CuXdQI4dYRmvJqauYTX19Hui8k8uxjUR/uNBwMuonNuk48InJa+/
         7QzJzm2Vy1+rdnWVNpjirKX4yCX7TTduXCrWYatP0ggudHkF2gg5xZ07EAh/5rv5avsY
         qWjz2+7DxLu5EFUH9QcMp/LL95u5UBxYMQ3fBkiRtAp+8rKmDmFCbhHDSyrzrbB9uvZN
         22P9pCtHe8/r1/UeHNoGAiVLFZUcdHk5uN3BJdKIVa3/TR8x9Dhb9tXliVDkX6AQP7wQ
         0diQ==
X-Gm-Message-State: AMke39nVXww2R5CsHQ/s4EN28xQWHU/Oyf/RhmGWyrzF5fDUbBtxcEQq+T6W6Bz93aFhcQ==
X-Received: by 10.99.139.68 with SMTP id j65mr12836063pge.64.1486756610325;
        Fri, 10 Feb 2017 11:56:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id p26sm7219165pfj.23.2017.02.10.11.56.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 11:56:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH v3] gc: ignore old gc.log files
References: <20170210192019.13927-1-dturner@twosigma.com>
        <xmqqy3xdkeuw.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 10 Feb 2017 11:56:48 -0800
In-Reply-To: <xmqqy3xdkeuw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 10 Feb 2017 11:47:19 -0800")
Message-ID: <xmqqtw81kef3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twosigma.com> writes:
> ...
>> It might still happen that manual intervention is required
>> (e.g. because the repo is corrupt), but at the very least it won't be
>> because Git is too dumb to try again.
>
> Thanks, nicely explained.

Sorry but I spotted a typo "whre" and ended up updating the proposed
log message by reordering them, omitting redundant info, etc.  Here
is a proposed amend with the "where does saved-errno go?" and "we do
not seem to use keep" fix-ups squashed in.

-- >8 --
Subject: gc: ignore old gc.log files

A server can end up in a state where there are lots of unreferenced
loose objects (say, because many users are doing a bunch of rebasing
and pushing their rebased branches).  Running "git gc --auto" in
this state would cause a gc.log file to be created, preventing
future auto gcs, causing pack files to pile up.  Since many git
operations are O(n) in the number of pack files, this would lead to
poor performance.

Git should never get itself into a state where it refuses to do any
maintenance, just because at some point some piece of the maintenance
didn't make progress.

Teach Git to ignore gc.log files which are older than (by default)
one day old, which can be tweaked via the gc.logExpiry configuration
variable.  That way, these pack files will get cleaned up, if
necessary, at least once per day.  And operators who find a need for
more-frequent gcs can adjust gc.logExpiry to meet their needs.

There is also some cleanup: a successful manual gc, or a
warning-free auto gc with an old log file, will remove any old
gc.log files.

It might still happen that manual intervention is required
(e.g. because the repo is corrupt), but at the very least it won't
be because Git is too dumb to try again.

Signed-off-by: David Turner <dturner@twosigma.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  6 ++++
 builtin/gc.c             | 76 +++++++++++++++++++++++++++++++++++++++++++-----
 t/t6500-gc.sh            | 12 ++++++++
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1fee83ca42..d385711b70 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1397,6 +1397,12 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.logExpiry::
+	If the file gc.log exists, then `git gc --auto` won't run
+	unless that file is more than 'gc.logExpiry' old.  Default is
+	"1.day".  See `gc.pruneExpire` for more ways to specify its
+	value.
+
 gc.packRefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
diff --git a/builtin/gc.c b/builtin/gc.c
index 331f219260..55c441115d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,6 +33,7 @@ static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
+static unsigned long gc_log_expire_time;
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 
@@ -76,10 +77,48 @@ static void git_config_date_string(const char *key, const char **output)
 static void process_log_file(void)
 {
 	struct stat st;
-	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size)
+	if (fstat(get_lock_file_fd(&log_lock), &st)) {
+		if (errno == ENOENT) {
+			/*
+			 * The user has probably intentionally deleted
+			 * gc.log.lock (perhaps because they're blowing
+			 * away the whole repo), so thre's no need to
+			 * report anything here.  But we also won't
+			 * delete gc.log, because we don't know what
+			 * the user's intentions are.
+			 */
+		} else {
+			FILE *fp;
+			int fd;
+			int saved_errno = errno;
+			/*
+			 * Perhaps there was an i/o error or another
+			 * unlikely situation.  Try to make a note of
+			 * this in gc.log.  If this fails again,
+			 * give up and leave gc.log as it was.
+			 */
+			rollback_lock_file(&log_lock);
+			fd = hold_lock_file_for_update(&log_lock,
+						       git_path("gc.log"),
+						       LOCK_DIE_ON_ERROR);
+
+			fp = fdopen(fd, "w");
+			fprintf(fp, _("Failed to fstat %s: %s"),
+				get_tempfile_path(&log_lock.tempfile),
+				strerror(saved_errno));
+			fclose(fp);
+			commit_lock_file(&log_lock);
+			errno = saved_errno;
+		}
+
+	} else if (st.st_size) {
+		/* There was some error recorded in the lock file */
 		commit_lock_file(&log_lock);
-	else
+	} else {
+		/* No error, clean up any old gc.log */
+		unlink(git_path("gc.log"));
 		rollback_lock_file(&log_lock);
+	}
 }
 
 static void process_log_file_at_exit(void)
@@ -113,6 +152,9 @@ static void gc_config(void)
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_date_string("gc.pruneexpire", &prune_expire);
 	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
+	if (!git_config_get_value("gc.logexpiry", &value))
+		parse_expiry_date(value, &gc_log_expire_time);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -290,19 +332,34 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	int ret = 0;
+	struct stat st;
+	char *gc_log_path = git_pathdup("gc.log");
+
+	if (stat(gc_log_path, &st)) {
+		if (errno == ENOENT)
+			goto done;
+
+		ret = error_errno(_("Can't stat %s"), gc_log_path);
+		goto done;
+	}
+
+	if (st.st_mtime < gc_log_expire_time)
+		goto done;
 
-	ret = strbuf_read_file(&sb, git_path("gc.log"), 0);
+	ret = strbuf_read_file(&sb, gc_log_path, 0);
 	if (ret > 0)
-		return error(_("The last gc run reported the following. "
+		ret = error(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
-			     git_path("gc.log"), sb.buf);
+			    gc_log_path, sb.buf);
 	strbuf_release(&sb);
-	return 0;
+done:
+	free(gc_log_path);
+	return ret;
 }
 
 static int gc_before_repack(void)
@@ -349,6 +406,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
 
+	/* default expiry time, overwritten in gc_config */
+	parse_expiry_date("1.day", &gc_log_expire_time);
 	gc_config();
 
 	if (pack_refs < 0)
@@ -448,5 +507,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
+	if (!daemonized)
+		unlink(git_path("gc.log"));
+
 	return 0;
 }
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1762dfa6a3..e1fb9b4d5b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,5 +67,17 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
+	test_commit foo &&
+	test_commit bar &&
+	git repack &&
+	test_config gc.autopacklimit 1 &&
+	test_config gc.autodetach true &&
+	echo fleem >.git/gc.log &&
+	test_must_fail git gc --auto 2>err &&
+	test_i18ngrep "^error:" err &&
+	test-chmtime =-86401 .git/gc.log &&
+	git gc --auto
+'
 
 test_done
