Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D4C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356547AbhKYQNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356419AbhKYQMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:12:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B59BC061396
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 137so6003250wma.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OMkONmESSyzuP+LEH8Nipa8nlXx3f9Kd5YZKOnW6svg=;
        b=NTp4IACGyKgkG7h5ym7UKP1VMSU/uRhBiZ0i//DxR9GlExC3e+SC2+duHTuZ8UQrY9
         hbPUZBzKYvWWF5vzFezbntf6rH/xDFZTQaScmmi03glhtsL+gF48z+/qXbx2ltmx1468
         oYcIcT/UkE5fvB5ojxPx1bLFDpxPAHbeJ4K7A/ydr1CDjNJf8KZSfzs69QHp47EBJzrG
         Mj+Xp7e+WZq11BrIwDWApKnCqFkpt0uC8bCW953VHsovRJxW8DJKjmiB2ImFgZF/OKQ1
         2Odmo0gyuTcJ5m6sz9nieYruhLaJiIleZws7tpaVXfcogxZG02udl8HwTsYxCKg2lRkF
         7BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OMkONmESSyzuP+LEH8Nipa8nlXx3f9Kd5YZKOnW6svg=;
        b=wigFQ7VX2C2aBOVscemx7xufr97OQgZxJlZbeJY/jBY8pkIXzEX9kSQMBbesP8Vqoo
         EYGxDPRh00SNqPPg3WEC1Ae/039ut8/rJ5Y/6q1is3nA8QOZn2Q5Lr/6k/XtDfh2Vqiw
         7yxG0VJ09hMzBiJBieZj85i4JZW8x3Mb2OO8g0a36IuNf49BZnFhOhhxnLg85F66GK+7
         M4DFOtRfFT04/3LpoMD17/dMJmQ6NDO5qHN1LxeVbT7Ur45n+PQvmVVW7LRipvgq8BRZ
         WqF1n5rbTJVfU5NnoMC42LF8mqhAkGo/k+rYvyirJS7wh+XP0buysjSlGZqGAq1EdVRA
         QboQ==
X-Gm-Message-State: AOAM531gJS3lSqYUyOKlY+B06QQF9XodwEQ9Mzat2LsjNsnXJG9bFBZn
        F4iBzA/W/AEOu6nJqG2QpPryBhEHhz0=
X-Google-Smtp-Source: ABdhPJyL/c/GA0V1zUSq4Ps7oCBbZbn9OenwaPv16bk+COz4ksFDsO9bYSI45C6mPDXbhdofUIBiJQ==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr8384372wmi.107.1637855873524;
        Thu, 25 Nov 2021 07:57:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19sm4164181wmq.4.2021.11.25.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:53 -0800 (PST)
Message-Id: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:47 +0000
Subject: [PATCH v2 0/5] Inspect reflog data programmatically in more tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps for reftable support, and will help if we want to reconsider
under which conditions reflogs get created/updated.

Han-Wen Nienhuys (5):
  show-branch: show reflog message
  test-ref-store: don't add newline to reflog message
  t1405: check for_each_reflog_ent_reverse() more thoroughly
  test-ref-store: tweaks to for-each-reflog-ent format
  refs/debug: trim trailing LF from reflog message

 builtin/show-branch.c          | 12 +++++++-----
 refs/debug.c                   | 10 ++++++++--
 t/helper/test-ref-store.c      |  6 +++---
 t/t1400-update-ref.sh          | 13 ++++++++-----
 t/t1405-main-ref-store.sh      |  4 ++--
 t/t1406-submodule-ref-store.sh |  4 ++--
 t/t3202-show-branch.sh         | 15 +++++++++++++++
 7 files changed, 45 insertions(+), 19 deletions(-)


base-commit: 35151cf0720460a897cde9b8039af364743240e7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1145%2Fhanwen%2Freflog-prelims-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1145/hanwen/reflog-prelims-v2
Pull-Request: https://github.com/git/git/pull/1145

Range-diff vs v1:

 1:  fd2595d370a = 1:  9d8394d8c76 show-branch: show reflog message
 2:  dfb63937323 ! 2:  4a86d212589 refs: trim newline from reflog message
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: trim newline from reflog message
     +    test-ref-store: don't add newline to reflog message
      
     -    Commit 523fa69c ("reflog: cleanse messages in the refs.c layer") standardizes
     -    how write entries into the reflog. This commit standardizes how we get messages
     -    out of the reflog. Before, the files backend implicitly added '\n' to the end of
     -    reflog message on reading, which creates a subtle incompatibility with alternate
     -    ref storage backends, such as reftable.
     -
     -    We address this by stripping LF from the message before we pass it to the
     -    user-provided callback.
     +    The files backend produces a newline for messages automatically, so before we
     +    would print blank lines between entries.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## builtin/show-branch.c ##
     -@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     - 			char *logmsg;
     - 			char *nth_desc;
     - 			const char *msg;
     --			char *end;
     - 			timestamp_t timestamp;
     - 			int tz;
     - 
     -@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     - 				break;
     - 			}
     - 
     --			end = strchr(logmsg, '\n');
     --			if (end)
     --				*end = '\0';
     --
     - 			msg = (*logmsg == '\0') ? "(none)" : logmsg;
     - 			reflog_msg[i] = xstrfmt("(%s) %s",
     - 						show_date(timestamp, tz,
     -
     - ## reflog-walk.c ##
     -@@ reflog-walk.c: void get_reflog_message(struct strbuf *sb,
     - 
     - 	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
     - 	len = strlen(info->message);
     --	if (len > 0)
     --		len--; /* strip away trailing newline */
     - 	strbuf_add(sb, info->message, len);
     - }
     - 
     -@@ reflog-walk.c: void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
     - 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
     - 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
     - 		if (oneline) {
     --			printf("%s: %s", selector.buf, info->message);
     -+			printf("%s: %s\n", selector.buf, info->message);
     - 		}
     - 		else {
     --			printf("Reflog: %s (%s)\nReflog message: %s",
     -+			printf("Reflog: %s (%s)\nReflog message: %s\n",
     - 			       selector.buf, info->email, info->message);
     - 		}
     - 
     -
     - ## refs/files-backend.c ##
     -@@ refs/files-backend.c: static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
     - 	int tz;
     - 	const char *p = sb->buf;
     - 
     --	/* old SP new SP name <email> SP time TAB msg LF */
     --	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
     --	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
     -+	/* old SP new SP name <email> SP time TAB msg */
     -+	if (!sb->len || parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
     - 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
     --	    !(email_end = strchr(p, '>')) ||
     --	    email_end[1] != ' ' ||
     -+	    !(email_end = strchr(p, '>')) || email_end[1] != ' ' ||
     - 	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
     - 	    !message || message[0] != ' ' ||
     --	    (message[1] != '+' && message[1] != '-') ||
     --	    !isdigit(message[2]) || !isdigit(message[3]) ||
     --	    !isdigit(message[4]) || !isdigit(message[5]))
     -+	    (message[1] != '+' && message[1] != '-') || !isdigit(message[2]) ||
     -+	    !isdigit(message[3]) || !isdigit(message[4]) ||
     -+	    !isdigit(message[5]))
     - 		return 0; /* corrupt? */
     - 	email_end[1] = '\0';
     - 	tz = strtol(message + 1, NULL, 10);
     -@@ refs/files-backend.c: static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
     - 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
     - 				scanp = bp;
     - 				endp = bp + 1;
     -+				strbuf_trim_trailing_newline(&sb);
     - 				ret = show_one_reflog_ent(&sb, fn, cb_data);
     - 				strbuf_reset(&sb);
     - 				if (ret)
     -@@ refs/files-backend.c: static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
     - 				 * Process it, and we can end the loop.
     - 				 */
     - 				strbuf_splice(&sb, 0, 0, buf, endp - buf);
     -+				strbuf_trim_trailing_newline(&sb);
     - 				ret = show_one_reflog_ent(&sb, fn, cb_data);
     - 				strbuf_reset(&sb);
     - 				break;
     -@@ refs/files-backend.c: static int files_for_each_reflog_ent(struct ref_store *ref_store,
     - 	if (!logfp)
     - 		return -1;
     - 
     --	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
     -+	while (!ret && !strbuf_getline(&sb, logfp))
     - 		ret = show_one_reflog_ent(&sb, fn, cb_data);
     - 	fclose(logfp);
     - 	strbuf_release(&sb);
     -@@ refs/files-backend.c: static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
     - 	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
     - 				   message, policy_cb)) {
     - 		if (!cb->newlog)
     --			printf("would prune %s", message);
     -+			printf("would prune %s\n", message);
     - 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
     --			printf("prune %s", message);
     -+			printf("prune %s\n", message);
     - 	} else {
     - 		if (cb->newlog) {
     --			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
     --				oid_to_hex(ooid), oid_to_hex(noid),
     --				email, timestamp, tz, message);
     -+			fprintf(cb->newlog, "%s %s %s %" PRItime " %+05d\t%s\n",
     -+				oid_to_hex(ooid), oid_to_hex(noid), email,
     -+				timestamp, tz, message);
     - 			oidcpy(&cb->last_kept_oid, noid);
     - 		}
     - 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
     --			printf("keep %s", message);
     -+			printf("keep %s\n", message);
     - 	}
     + ## t/helper/test-ref-store.c ##
     +@@ t/helper/test-ref-store.c: static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
     + 		       const char *committer, timestamp_t timestamp,
     + 		       int tz, const char *msg, void *cb_data)
     + {
     +-	printf("%s %s %s %"PRItime" %d %s\n",
     +-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
     +-	       committer, timestamp, tz, msg);
     ++	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
     ++	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
       	return 0;
       }
     + 
      
       ## t/t1405-main-ref-store.sh ##
      @@ t/t1405-main-ref-store.sh: test_expect_success 'for_each_reflog()' '
 3:  8a1b094d547 ! 3:  0319503045b test-ref-store: tweaks to for-each-reflog-ent format
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    test-ref-store: tweaks to for-each-reflog-ent format
     +    t1405: check for_each_reflog_ent_reverse() more thoroughly
      
     -    Follow the reflog format more closely, so it can be used for comparing
     -    reflogs in tests without using inspecting files under .git/logs/
     +    If we are checking for a certain ordering, we should check that there are two
     +    entries. Do this by mirroring the preceding test.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## t/helper/test-ref-store.c ##
     -@@ t/helper/test-ref-store.c: static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
     - 		       const char *committer, timestamp_t timestamp,
     - 		       int tz, const char *msg, void *cb_data)
     - {
     --	printf("%s %s %s %"PRItime" %d %s\n",
     --	       oid_to_hex(old_oid), oid_to_hex(new_oid),
     --	       committer, timestamp, tz, msg);
     -+	printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
     -+	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
     - 	return 0;
     - }
     - 
     -
       ## t/t1405-main-ref-store.sh ##
      @@ t/t1405-main-ref-store.sh: test_expect_success 'for_each_reflog_ent()' '
       
 4:  4ba97a4e70a ! 4:  62f5cb8a824 t1400: use test-helper ref-store to inspect reflog contents
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    t1400: use test-helper ref-store to inspect reflog contents
     +    test-ref-store: tweaks to for-each-reflog-ent format
      
     -    This avoids inspecting the file system, which only works with the files ref
     -    backend.
     +    We have some tests that read from files in .git/logs/ hierarchy
     +    when checking if correct reflog entries are created, but that is
     +    too specific to the files backend.  Other backends like reftable
     +    may not store its reflog entries in such a "one line per entry"
     +    format.
     +
     +    Update for-each-reflog-ent test helper to produce output that
     +    is identical to lines in a reflog file files backend uses.
     +    That way, (1) the current tests can be updated to use the test
     +    helper to read the reflog entries instead of (parts of) reflog
     +    files, and perform the same inspection for correctness, and (2)
     +    when the ref backend is swapped to another backend, the updated
     +    test can be used as-is to check the correctness.
     +
     +    Adapt t1400 to use the for-each-reflog-ent test helper.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## t/t1400-update-ref.sh ##
     -@@ t/t1400-update-ref.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - . ./test-lib.sh
     + ## t/helper/test-ref-store.c ##
     +@@ t/helper/test-ref-store.c: static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
     + 		       const char *committer, timestamp_t timestamp,
     + 		       int tz, const char *msg, void *cb_data)
     + {
     +-	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
     +-	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
     ++	printf("%s %s %s %" PRItime " %+05d%s%s", oid_to_hex(old_oid),
     ++	       oid_to_hex(new_oid), committer, timestamp, tz,
     ++	       *msg == '\n' ? "" : "\t", msg);
     + 	return 0;
     + }
       
     - Z=$ZERO_OID
     -+TAB='	'
     - 
     - m=refs/heads/main
     - n_dir=refs/heads/gu
     -@@ t/t1400-update-ref.sh: test_expect_success 'symref empty directory removal' '
     - cat >expect <<EOF
     - $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
     - $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
     --$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
     -+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
     +
     + ## t/t1400-update-ref.sh ##
     +@@ t/t1400-update-ref.sh: $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
     + $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
       EOF
       test_expect_success "verifying $m's log (logged by touch)" '
      -	test_when_finished "rm -rf .git/$m .git/logs expect" &&
     @@ t/t1400-update-ref.sh: test_expect_success 'symref empty directory removal' '
       '
       
       test_expect_success "create $m (logged by config)" '
     -@@ t/t1400-update-ref.sh: test_expect_success "set $m (logged by config)" '
     - cat >expect <<EOF
     - $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
     - $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
     --$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
     -+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000$TAB
     +@@ t/t1400-update-ref.sh: $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
     + $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
       EOF
       test_expect_success "verifying $m's log (logged by config)" '
      -	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
 -:  ----------- > 5:  0288e743eb2 refs/debug: trim trailing LF from reflog message

-- 
gitgitgadget
