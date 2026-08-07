Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978723C39A
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088388; cv=none; b=Ju5Dlz1K/E0EB3XowFvumvP9pechqOW3GxVWPrU87UdIe/Fq0a+qs5nO1JAiBbFwHX9O4x4Js3KqaleCYvVea/URQey9kYA7ZZqzdY4ltUv+RYGBuJvkFfBNSO3k2njAvpYXXZUMGx8Yr3AeWHWYpzrImf6nlKWSws5OsO6MGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088388; c=relaxed/simple;
	bh=+vFXPXLSP/4mxYXHY/isztUAwezhNwoSSj8QflIit+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YIgTZvyI3uU3XdqIlrCGRHkh2MO6ul6vKty25D9rBfWsCSxn5JUPzt60cqvd4SDwgjgSpqjn2Zl3xxXoET1tyBPgEa7p6oM0D1i28t/HSGEBuayrmuvdlBz1I8RrERRtmjxAsYW3n/R0Awl50thExUfVQNodT8R3cOKKW6s8MG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj3oAgav; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj3oAgav"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1641236a91.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088385; x=1786693185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ilbY+mmiQ/Lf0aZwdWdWEZRBU+yemOuJgSwZSIGd45E=;
        b=fj3oAgavDbalXRQa7v7KpaG2x1Uu8jN4F0J+U/avF+we0rRe8Tpq2ZBgfwVX4PYwrR
         XkyZ/RMTO3O8a50dV6d2IRW5anSTkNE22tTZIFQHzflYz7Q5biztu+vU8VcJOIS6Wrbq
         tiZnTvnXuNW3Z5JoDz8Mkf6FUSAaVI7GOPmWMeewR1uFdzdYTStkWgqcinJvz4J3JsVe
         CGityPhvaY01RW+vEmQvVkaVzROWjhTiSPPyJdgboF2du5TsFGE7UFfeyGBmYryXIv+g
         NQaxhxHb7NjnaPKKN7xm7ee6ofZD0h2GZaKX33FjtvyoswIa/oEPwzXbZDXQ15FBGPE4
         KR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088385; x=1786693185;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilbY+mmiQ/Lf0aZwdWdWEZRBU+yemOuJgSwZSIGd45E=;
        b=D5icoieIfOATs2EnmTmJUelVg+p2l5BYY/EynXHe6SmuwLFbPaK/6ISPUqqzpslKZS
         IipoPrvLFixunumYpH5dCS5f3i5gsD31841Q8D3zuStGR4SVHhSRY2m//SAIG0RNkR6C
         5cVdan5neINTeFJMNmuq/dwWHA5eey1rc+7Pq/40ATBQnlmVpwnNUk+6zDJrKEeZGLLG
         hjUHEvH+bUu3OQ46CesZoGkj1WriNEUUkqOvK+5Ldz+/uii9uzuPGuaTWTIunstNVxKI
         8yhe09o2WuxGwbWQHoVz2ArFiR2H7kuiSTSG7VFXgYXUpAWY33XS8M89vPqShc4yzNgR
         YaUg==
X-Gm-Message-State: AOJu0Yx00//k1QNXXtgDyrhk1xNpKqjwICd8zCN9wed8S4WIi+t4Xhn/
	sF47nrI/6IQ8rhGC6sa6ZUlgrnxNlLeBYKP2GQKOnACAxX93Nl/2wVNUDAu+zQqa
X-Gm-Gg: AR+sD13wukT7SaXC25fk3TdADaxD5pIdEBOYnE/tHlz04Nahwy+v2py6r+6ku/PUxhU
	urV32sAz2Ss4hcJnQd5wbSgRutkpesM+TrNrl2FTCF9aY2+gkkSxtXUXsAv0OLHxch+J/V2nlty
	MCqtP2A9Jb4s+Kwz8hUwe84jKW2kqOLUA4jTdjfygMBxAbvNTWm4aTZZMfCTJvkKFp8yb8h/Jvq
	xcvQlNMwAa3o2AyaOaK05xzqfexot/f/bZUK8Sy7ZVYBBA1w4a9wE7Qo5Ur/xybEQPfDJVQjvNl
	pSfpggGtde91mVxo4ictP1bB4rwxGB9PKgM3rN/3NvHl0pV9cWPhiWAkrpVD2mQXDVtwhd3NusC
	i+b4jWaTpiNsM6a72a+jbxkdOvQmpGULuBGNRFX+o4M3ameXz2DlfX+nAWcpVbAwCzgjdbVssvy
	jn2vt3SM8vxnoZQoSrsEuDqpdDgLYytn9+gSKpwhqtptaq2KXcRe0oeCeJYuTDr/dgLFIVp1gyU
	A==
X-Received: by 2002:a17:90b:3ec3:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-390897b18cbmr1022144a91.11.1786088385227;
        Fri, 07 Aug 2026 00:39:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3760288a91.6.2026.08.07.00.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:44 -0700 (PDT)
Message-Id: <8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:30 +0000
Subject: [PATCH v13 7/8] history: create squashed commits without editing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Create one replacement commit from the resolved range when --no-edit is
selected. Preserve the authorship and all parents of the oldest commit,
use the tip tree, and replay descendants through the existing history
rewrite machinery. Record the complete revision expression in the
reflog and retain dry-run and update-refs behavior.

Resolve fixup!, squash! and amend! subjects while walking the range.
Reject markers whose targets are not selected and refuse any no-edit
fold that would discard a squash! or amend! message. A range made
entirely from related markers can still be consolidated, with the last
applicable amend! body supplying the message.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  44 ++-
 builtin/history.c              | 324 ++++++++++++++++-
 object.h                       |   2 +-
 t/t3455-history-squash.sh      | 633 +++++++++++++++++++++++++++++++--
 4 files changed, 968 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index b660baf94d..fb04a67685 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -44,8 +44,11 @@ at once.
 LIMITATIONS
 -----------
 
-This command does not (yet) work with histories that contain merges. You
-should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
+This command does not (yet) replay merge commits onto the rewritten
+history: if a commit that would be replayed is a merge, the operation is
+rejected, and you should use linkgit:git-rebase[1] with the
+`--rebase-merges` flag instead. The `squash` subcommand can still fold merges
+that lie inside the selected range, subject to the restrictions below.
 
 Furthermore, the command does not support operations that can result in merge
 conflicts. This limitation is by design as history rewrites are not intended to
@@ -114,6 +117,43 @@ linkgit:gitglossary[7].
 It is invalid to select either all or no hunks, as that would lead to
 one of the commits becoming empty.
 
+`squash <revision-range>`::
+	Fold all commits in _<revision-range>_ into the oldest commit of that
+	range. The resulting commit keeps the oldest commit's authorship and
+	takes the tree of the range's newest commit, so the whole range
+	collapses into a single commit. Commits above the range are replayed
+	on top of the result.
++
+The range is given in the usual `<base>..<tip>` form, where _<base>_ is
+the commit just below the oldest commit to squash. For example, `git
+history squash HEAD~3..HEAD` folds the three most recent commits into
+one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
+while leaving the two newest commits in place. Several revisions may be
+given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
+already on `topic`. Rev-list options may also be given, but any that would
+change how the range is walked are overridden with a warning.
++
+With `--no-edit`, the oldest commit's message is preserved, except that an
+`amend!` commit targeting it replaces its message.
++
+The selected commits must form a connected graph with a single tip and must
+not include a root commit. Every parent of a commit after the oldest one must
+either be selected or also be a parent of the oldest commit. When the oldest
+commit is a merge, all of its parents are preserved in the squashed commit.
++
+A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
+targets is also in the range, so the fold does not silently absorb a
+marker meant for a commit outside it. As an exception, a range made up entirely
+of markers for one target is combined into a single commit. With `--no-edit`,
+the last `amend!` message is used if there is one; a `squash!` or `amend!` is
+otherwise refused if folding it would discard its message.
++
+A local branch descended from a selected commit but not from the range tip
+cannot be rewritten as a descendant of the result, so with the default
+`--update-refs=branches` the command refuses. Rerun with `--update-refs=head`
+to rewrite only the current branch and leave such branches unchanged. Tags
+and remote-tracking refs are always left unchanged.
+
 OPTIONS
 -------
 
diff --git a/builtin/history.c b/builtin/history.c
index e65b76b59f..915cfb0cb9 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1011,6 +1011,260 @@ out:
 
 #define SQUASH_SEEN (1u << 11)
 #define SQUASH_TIP (1u << 12)
+#define SQUASH_AMEND_TARGET (1u << 13)
+
+static bool is_autosquash_subject(const char *s)
+{
+	return starts_with(s, "amend!") || starts_with(s, "fixup!") ||
+		starts_with(s, "squash!");
+}
+
+static bool skip_one_autosquash_prefix(const char *s, const char **out)
+{
+	if (skip_prefix(s, "amend!", out) || skip_prefix(s, "fixup!", out) ||
+	    skip_prefix(s, "squash!", out)) {
+		while (**out == ' ')
+			(*out)++;
+		return true;
+	}
+	return false;
+}
+
+static void truncate_message_to_subject(struct strbuf *msg)
+{
+	const char *eos = strstr(msg->buf, "\n\n");
+
+	if (eos)
+		strbuf_setlen(msg, eos - msg->buf + 1);
+}
+
+struct subject_data {
+	struct strintmap subjects;
+	struct strbuf subject;
+	struct strbuf squash_message;
+	const char *message;
+	bool edit_message;
+};
+
+#define SUBJECT_DATA_INIT {		\
+	.subjects = STRINTMAP_INIT,	\
+	.subject = STRBUF_INIT,		\
+	.squash_message = STRBUF_INIT,	\
+}
+
+static void subject_data_clear(struct subject_data *data)
+{
+	strintmap_clear(&data->subjects);
+	strbuf_release(&data->subject);
+	strbuf_release(&data->squash_message);
+}
+
+static int squash_amend_message(struct repository *repo,
+				struct commit *commit,
+				struct subject_data *data,
+				unsigned flags)
+{
+	const char *body = data->message + data->subject.len;
+
+	while (isspace(*body))
+		body++;
+
+	if (!*body) {
+		warning(_("ignoring %s (%s): message body is empty"),
+			repo_find_unique_abbrev(repo, &commit->object.oid,
+						DEFAULT_ABBREV),
+			data->subject.buf);
+		return 0;
+	}
+
+	if (data->edit_message) {
+		return 0;
+	} else if (flags & SQUASH_AMEND_TARGET) {
+		if (starts_with(data->squash_message.buf, "squash!"))
+			return error(_("squashing %s (%s) would overwrite "
+				       "'squash!' message, please combine them "
+				       "using '--edit'"),
+				     repo_find_unique_abbrev(repo,
+							     &commit->object.oid,
+							     DEFAULT_ABBREV),
+				     data->subject.buf);
+		if (starts_with(data->squash_message.buf, "fixup!"))
+			strbuf_splice(&data->squash_message, 0, 5, "amend!", 5);
+		if (starts_with(data->squash_message.buf, "amend!")) {
+			truncate_message_to_subject(&data->squash_message);
+			strbuf_addch(&data->squash_message, '\n');
+		} else {
+			strbuf_reset(&data->squash_message);
+		}
+		strbuf_addstr(&data->squash_message, body);
+		strbuf_complete_line(&data->squash_message);
+	} else {
+		return error(_("cannot squash %s (%s) that does not target "
+			       "base commit without '--edit'"),
+			     repo_find_unique_abbrev(repo, &commit->object.oid,
+						     DEFAULT_ABBREV),
+			     data->subject.buf);
+	}
+	return 0;
+}
+
+static int squash_squash_message(struct repository *repo,
+				struct commit *commit,
+				struct subject_data *data,
+				unsigned flags)
+{
+	const char *body = data->message + data->subject.len;
+
+	while (isspace(*body))
+		body++;
+
+	if (data->edit_message) {
+		return 0;
+	} else if (flags & SQUASH_AMEND_TARGET) {
+		if (starts_with(data->squash_message.buf, "fixup!")) {
+			truncate_message_to_subject(&data->squash_message);
+			strbuf_splice(&data->squash_message, 0, 5, "squash", 6);
+		}
+		if (starts_with(data->squash_message.buf, "squash!")) {
+			strbuf_addch(&data->squash_message, '\n');
+			strbuf_addstr(&data->squash_message, body);
+			strbuf_complete_line(&data->squash_message);
+		} else {
+			return error(_("squashing %s (%s) would discard its "
+				       "message, please combine them using "
+				       "'--edit'"),
+				     repo_find_unique_abbrev(repo,
+							     &commit->object.oid,
+							     DEFAULT_ABBREV),
+				     data->subject.buf);
+		}
+	} else {
+		return error(_("cannot squash %s (%s) that does not target "
+			       "base commit without '--edit'"),
+			      repo_find_unique_abbrev(repo, &commit->object.oid,
+						      DEFAULT_ABBREV),
+			      data->subject.buf);
+	}
+	return 0;
+}
+
+static int squash_check_can_autosquash(struct repository *repo,
+				       struct commit *commit,
+				       struct subject_data *data,
+				       unsigned flags)
+{
+	commit->object.flags |= flags & SQUASH_AMEND_TARGET;
+	if (starts_with(data->subject.buf, "amend!"))
+		return squash_amend_message(repo, commit, data, flags);
+	else if (starts_with(data->subject.buf, "squash!"))
+		return squash_squash_message(repo, commit, data, flags);
+
+	return 0;
+}
+
+static int squash_check_autosquash_subject(struct repository *repo,
+					   struct commit *commit,
+					   struct subject_data *data)
+{
+	const char* s = data->subject.buf;
+	struct commit *target;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	/* Try skipping autosquash prefixes one at a time to allow
+	 * squashing
+	 *     a commit
+	 *     fixup! fixup! a commit
+	 *
+	 * where we may have started with
+	 *     a commit
+	 *     fixup! a commit
+	 *     fixup! fixup! a commit
+	 *
+	 * and squashed the first fixup separately from the second
+	 */
+	while (skip_one_autosquash_prefix(s, &s)) {
+		unsigned flags = strintmap_get(&data->subjects, s);
+		if (flags)
+			return squash_check_can_autosquash(repo, commit, data, flags);
+	}
+	/*
+	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
+	 * "fixup! main". If the target is not being squshed check the subject
+	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
+	 * squashed together.
+	 */
+	target = lookup_commit_reference_by_name(s);
+	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
+		unsigned flags =
+			target->object.flags & (SQUASH_SEEN | SQUASH_AMEND_TARGET);
+		if (!flags) {
+			const char *subject_start;
+			const char *buffer = repo_logmsg_reencode(repo, target,
+								  NULL, NULL);
+			size_t subject_len = find_commit_subject(buffer,
+								 &subject_start);
+			char *subject = xmemdupz(subject_start, subject_len);
+
+			flags = strintmap_get(&data->subjects, subject);
+			free(subject);
+			repo_unuse_commit_buffer(repo, target, buffer);
+		}
+		if (flags)
+			return squash_check_can_autosquash(repo, commit,
+							   data, flags);
+	}
+	/* Try subject prefix matches */
+	strintmap_for_each_entry(&data->subjects, &iter, entry) {
+		s = data->subject.buf;
+		while(skip_one_autosquash_prefix(s, &s)) {
+			if (starts_with(entry->key, s)) {
+				unsigned value = (intptr_t)entry->value;
+
+				return squash_check_can_autosquash(repo, commit,
+								   data, value);
+			}
+		}
+	}
+	return error(_("cannot squash %s (%s): its target is not being "
+		       "squashed"),
+		       repo_find_unique_abbrev(repo, &commit->object.oid,
+					       DEFAULT_ABBREV),
+		       data->subject.buf);
+}
+
+static int squash_check_subject(struct repository *repo,
+				struct commit *commit,
+				struct subject_data *data)
+{
+	int ret = 0;
+	const char *buf = repo_logmsg_reencode(repo, commit, NULL, NULL);
+	size_t subject_len = find_commit_subject(buf, &data->message);
+
+	strbuf_reset(&data->subject);
+	strbuf_add(&data->subject, data->message, subject_len);
+
+	if (!strintmap_get_size(&data->subjects)) {
+		const char *s;
+
+		strbuf_addstr(&data->squash_message, data->message);
+		strbuf_complete_line(&data->squash_message);
+		/*
+		 * Strip a single autosquash prefix to allow squashing
+		 *     fixup! base
+		 *     amend! base
+		 */
+		s = data->subject.buf;
+		skip_one_autosquash_prefix(s, &s);
+		strintmap_set(&data->subjects, s, SQUASH_AMEND_TARGET | SQUASH_SEEN);
+		commit->object.flags |= SQUASH_AMEND_TARGET;
+	} else if (is_autosquash_subject(data->subject.buf)) {
+		ret = squash_check_autosquash_subject(repo, commit, data);
+	} else {
+		strintmap_set(&data->subjects, data->subject.buf, SQUASH_SEEN);
+	}
+	repo_unuse_commit_buffer(repo, commit, buf);
+	return ret;
+}
 
 static int setup_squash_revisions(struct repository *repo,
 				  int argc, const char **argv,
@@ -1067,9 +1321,11 @@ static int resolve_squash_range(struct repository *repo,
 				bool update_branches,
 				int argc, const char **argv,
 				struct commit **oldest_out,
-				struct commit **tip_out)
+				struct commit **tip_out,
+				char **message_out)
 {
 	struct rev_info revs;
+	struct subject_data subject_data = SUBJECT_DATA_INIT;
 	struct commit *commit, *oldest = NULL, *tip = NULL;
 	int ret, tip_count = 0;
 	bool walk_started = false;
@@ -1132,6 +1388,10 @@ static int resolve_squash_range(struct repository *repo,
 			commit_list_insert(commit, &filter.with_commit);
 			oldest = commit;
 		}
+		if (squash_check_subject(repo, commit, &subject_data)) {
+			ret = -1;
+			goto out;
+		}
 		tip = commit;
 		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
 		tip_count++;
@@ -1200,12 +1460,15 @@ static int resolve_squash_range(struct repository *repo,
 
 	*oldest_out = oldest;
 	*tip_out = tip;
+	*message_out = strbuf_detach(&subject_data.squash_message, NULL);
 	ret = 0;
 
 out:
-	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP |
+			   SQUASH_AMEND_TARGET);
 	if (walk_started)
 		reset_revision_walk();
+	subject_data_clear(&subject_data);
 	release_revisions(&revs);
 	ref_filter_clear(&filter);
 	ref_array_clear(&refs);
@@ -1234,23 +1497,68 @@ static int cmd_history_squash(int argc,
 			 N_("edit the commit message")),
 		OPT_END(),
 	};
-	struct commit *oldest, *tip;
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *oldest, *tip, *rewritten;
+	const struct object_id *base_tree_oid, *tip_tree_oid;
+	char *message_template = NULL;
+	struct rev_info revs = { 0 };
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
-	if (argc < 2)
-		return error(_("command expects a revision range"));
+	if (argc < 2) {
+		ret = error(_("command expects a revision range"));
+		goto out;
+	}
 	repo_config(repo, git_default_config, NULL);
+
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
 
+	strbuf_addstr(&reflog_msg, "squash: updating ");
+	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
+
 	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
-				   argc, argv, &oldest, &tip);
+				   argc, argv, &oldest, &tip,
+				   &message_template);
 	if (ret < 0)
-		return ret;
+		goto out;
+	if (edit) {
+		ret = error(_("message editing is not supported yet; use '--no-edit'"));
+		goto out;
+	}
+
+	ret = setup_revwalk(repo, action, tip, &revs);
+	if (ret < 0)
+		goto out;
+
+	base_tree_oid = &repo_get_commit_tree(repo,
+					oldest->parents->item)->object.oid;
+	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
+
+	ret = commit_tree_ext(repo, "squash", oldest, message_template,
+			      oldest->parents, base_tree_oid, tip_tree_oid,
+			      &rewritten, 0);
+	if (ret < 0) {
+		ret = error(_("failed writing squashed commit"));
+		goto out;
+	}
+
+	ret = handle_reference_updates(&revs, action, tip, rewritten,
+				       reflog_msg.buf, dry_run,
+				       REPLAY_EMPTY_COMMIT_ABORT);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
 
-	return error(_("squashing commits is not implemented yet"));
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	release_revisions(&revs);
+	free(message_template);
+	return ret;
 }
 
 static int update_worktree(struct repository *repo,
diff --git a/object.h b/object.h
index dcf30156ca..46cade33fb 100644
--- a/object.h
+++ b/object.h
@@ -74,7 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
- * builtin/history.c:                    1112
+ * builtin/history.c:                    11---13
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index b1f65de5f5..d2d8e5fdb9 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -4,11 +4,50 @@ test_description='tests for git-history squash subcommand'
 
 . ./test-lib.sh
 
-test_expect_success 'setup linear history' '
+stage_file () {
+	printf "%s\n" "$1" >file &&
+	git add file
+}
+
+commit_with_message () {
+	printf "%b" "$1" >msg &&
+	git commit --allow-empty -qF msg
+}
+
+check_commit_count () {
+	git rev-list --count "$1" >actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+check_log_subjects () {
+	git log --format="%s" "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+check_log_messages () {
+	git log --format="%B" "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+# Checks that the author data of two commits matches
+# Usage: check_commit_author <rev1> <rev2>
+check_commit_author () {
+	git show -s --format="%an <%ae> %ad" "$1" >expect &&
+	git show -s --format="%an <%ae> %ad" "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup linear history touching two files' '
 	test_commit base file a start &&
-	test_commit one file b &&
-	test_commit two file c &&
-	test_commit three file d
+	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
+		test_commit one other x &&
+	GIT_AUTHOR_NAME=Two GIT_AUTHOR_EMAIL=two@example.com \
+		test_commit two file c &&
+	GIT_AUTHOR_NAME=Three GIT_AUTHOR_EMAIL=three@example.com \
+		test_commit three file d
 '
 
 test_expect_success 'errors on missing range argument' '
@@ -29,40 +68,331 @@ test_expect_success 'errors on a single revision that is not a range' '
 '
 
 test_expect_success 'errors on a range holding a single commit' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
 	test_must_fail git history squash "HEAD^!" 2>err &&
-	test_grep "single commit; nothing to squash" err
+	test_grep "single commit; nothing to squash" err &&
+	test_cmp_rev "$head_before" HEAD
 '
 
-test_expect_success 'rejects a root commit' '
+test_expect_success 'rejects root commit' '
+	# create a disconnected root commit
 	oid=$(git commit-tree -m root three^{tree}) &&
-	test_must_fail git history squash \
-		--ancestry-path=start "$oid..three" 2>err &&
-	test_grep "cannot squash down to root commit" err
+	# because we pass --ancestry-path when calling setup_revs() it the
+	# revision walk will only include commits decended from $oid so
+	# we need to give it another --ancestry-path commit to actually walk
+	# any commits.
+	test_must_fail git history squash --ancestry-path=start $oid..three 2>err &&
+	echo "error: cannot squash down to root commit" >expect &&
+	test_cmp expect err
 '
 
 test_expect_success 'rejects multiple tips' '
 	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
-	test_must_fail git history squash ^start "$oid" three~1 2>err &&
-	test_grep "revision range contains more than one tip" err
+	test_must_fail git history squash ^start $oid three~1 2>err &&
+	echo "error: the revision range contains more than one tip commit" >expect &&
+	test_cmp expect err &&
+
+	git reset --hard three &&
+	git history squash --no-edit ^start three~1 three &&
+	test_cmp_rev HEAD~1 start^0 &&
+	test_cmp_rev HEAD^{tree} three^{tree}
 '
 
-test_expect_success 'rejects a merge parent outside the range' '
-	git reset --hard start &&
+test_expect_success 'accepts multiple revision arguments with an exclusion' '
+	git reset --hard three &&
+	git branch -f keep HEAD~2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start..HEAD ^keep &&
+
+	git reflog -1 --format=%gs >actual &&
+	echo "squash: updating start..HEAD ^keep" >expect &&
+	test_cmp expect actual &&
+
+	check_log_subjects start..HEAD <<-\EOF &&
+	two
+	one
+	EOF
+	test_cmp_rev keep HEAD~1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git branch -D keep
+'
+
+test_expect_success 'squashes a branch the current branch is not on' '
+	git reset --hard three &&
 	main=$(git symbolic-ref --short HEAD) &&
-	git checkout -b outside-parent &&
-	test_commit --no-tag outside-parent outside x &&
+	head_before=$(git rev-parse HEAD) &&
+	git checkout -b off-history start &&
+	test_commit --no-tag off-one off a &&
+	test_commit --no-tag off-two off b &&
 	git checkout "$main" &&
-	test_commit --no-tag outside-main file b &&
-	base=$(git rev-parse HEAD) &&
-	test_commit --no-tag outside-mid file c &&
-	git merge --no-ff -m "merge outside-parent" outside-parent &&
-	git branch -D outside-parent &&
 
-	test_must_fail git history squash "$base.." 2>err &&
-	test_grep "parent .* of commit .* is outside the revision range" err
+	git history squash --no-edit start..off-history &&
+
+	check_commit_count start..off-history 1 &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D off-history
+'
+
+test_expect_success 'squashes a range into a single commit without changing the tree' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit --dry-run start.. >out &&
+	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git history squash --no-edit start.. &&
+
+	test "$predicted" = "$(git rev-parse HEAD)" &&
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	check_log_subjects -1 <<-\EOF &&
+	one
+	EOF
+	git reflog >reflog &&
+	test_grep "squash: updating" reflog
+'
+
+test_expect_success 'sanitizes rev-list walk options, before and after --' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit --date-order start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git reset --hard three &&
+	git history squash --no-edit -- --reverse start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes an interior range and replays descendants verbatim' '
+	git reset --hard three &&
+	final_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start..@~1 &&
+
+	check_log_subjects start..HEAD <<-\EOF &&
+	three
+	one
+	EOF
+
+	test_cmp_rev start HEAD~2 &&
+	test "$final_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes when the base is the root commit' '
+	git reset --hard three &&
+	root=$(git rev-list --max-parents=0 HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit "$root.." &&
+
+	check_commit_count "$root..HEAD" 1 &&
+	test_cmp_rev "$root" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashing a mix of fixups' '
+	git reset --hard three &&
+	echo fix >file &&
+	git commit --fixup=two -a &&
+	echo really fix >file &&
+	git commit --fixup=one -a &&
+	echo really really fix >file &&
+	git commit --fixup=HEAD~1 -a && # fixup! two
+	echo really really really fix >file &&
+	git commit --fixup=HEAD~1 -a && # fixup! one
+
+	# squashing fixup! with a target that is not being squashed fails
+	test_must_fail git history squash one.. 2>err &&
+	test_grep "^error: cannot squash .* (fixup! one): its target is not being squashed" err &&
+
+	# squashing fixup! into fixup! with a different target fails
+	test_must_fail git history squash HEAD~4.. 2>err && # HEAD~4 is fixup! two
+	test_grep "^error: cannot squash .* (fixup! one): its target is not being squashed" err &&
+
+	# squashing a sequence of fixup! commits into their targets
+	git history squash --no-edit start..HEAD~1 &&
+	test_cmp_rev start HEAD~2 &&
+	check_commit_author one HEAD~1 &&
+	test_commit_message HEAD~1 -m one &&
+
+	# squashing "fixup! fixup! <target>" into "<target>"
+	git history squash --no-edit start.. &&
+	test_cmp_rev start HEAD~1 &&
+	check_commit_author one HEAD &&
+	test_commit_message HEAD -m one
+'
+
+test_expect_success 'squashing "squash!" messages' '
+	git reset --hard two &&
+	echo fix >file &&
+	git commit --fixup=HEAD -a &&
+	oldest=$(git rev-parse HEAD) &&
+	echo better fix >file &&
+	git commit -a -F - <<-EOF &&
+	squash! $(git rev-parse two)
+
+	Append this
+	EOF
+
+	echo an even better fix >file &&
+	git commit -a -F - <<-EOF &&
+	squash! squash! two
+
+	Append this as well
+	EOF
+
+	# must edit when squashing "squash!" into its target
+	test_must_fail git history squash --no-edit two^.. 2>err &&
+	test_grep "^error: squashing .* (squash! [a-f0-9]*) would discard its message" err &&
+
+	# squashing "squash!" into "fixup!" appends messages and changes
+	# subject prefix
+	git history squash --no-edit two.. &&
+	test_cmp_rev HEAD^ two &&
+	test_commit_message HEAD <<-\EOF &&
+	squash! two
+
+	Append this
+
+	Append this as well
+	EOF
+	check_commit_author "$oldest" HEAD &&
+
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! two
+
+	A new message
+	EOF
+
+	# "amend!" does not replace "squash!"
+	test_must_fail git history squash --no-edit HEAD~2.. 2>err &&
+	test_grep "^error: squashing .* (amend! two) would overwrite .squash!. message" err
+'
+
+test_expect_success '--no-edit uses last "amend!" message without an editor' '
+	git reset --hard three &&
+	write_script editor <<-\EOF &&
+	exit 1
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	echo fix >file &&
+	git commit --author="Fix Me <fix.me@example.com>" --fixup=HEAD -a &&
+	git commit --allow-empty -F - <<-EOF &&
+	amend! $(git rev-parse --short HEAD)
+
+	The first reword
+
+	More detail
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! three
+
+	The second reword
+
+	Extra detail
+	EOF
+
+	test_commit WIP &&
+
+	cat >msg <<-EOF &&
+	amend! $(git rev-parse HEAD^ | tr a-f A-F)
+
+	The third reword
+
+	Excruciating detail
+	EOF
+
+	git commit --author="Someone Else <s.else@example.com>" --allow-empty \
+		-F msg &&
+
+	# squashing amend! updates the commit message
+	git history squash --no-edit three^.. &&
+	sed -e 1,2d msg | test_commit_message HEAD &&
+	check_commit_author three HEAD &&
+	test_cmp_rev HEAD^ three^ &&
+
+	# squashing amend! into fixup! updates subject prefix
+	git reset --hard HEAD@{1} &&
+	git history squash --no-edit three.. &&
+	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
+	check_commit_author HEAD@{1}~4 HEAD &&
+	test_cmp_rev HEAD^ three &&
+
+	# squashing amend! into amend! keeps original subject line
+	git reset --hard HEAD@{1} &&
+	git history squash --no-edit HEAD~3.. &&
+	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
+	test_cmp_rev HEAD~3 three &&
+
+	# all amend! messages must target the first commit
+	git reset --hard HEAD@{1} &&
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! WIP
+
+	The real message
+	EOF
+
+	test_must_fail git history squash --no-edit HEAD~4.. 2>err &&
+	test_grep "^error: cannot squash .* that does not target" err &&
+
+	# amend! message that targets commit that is not in range is rejected
+	test_must_fail git history squash --no-edit HEAD~3.. 2>err &&
+	test_grep "^error: cannot squash .* target is not being squashed" err &&
+	test_set_editor :
 '
 
-test_expect_success 'prints branches that cannot follow the squash' '
+test_expect_success 'squashing fixups into a merge' '
+	test_when_finished \
+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
+		 git branch -D feature" &&
+	git checkout -f start &&
+	test_commit F1 &&
+	git checkout -b feature start &&
+	test_commit F2 &&
+	git merge F1 &&
+	echo fixed >F1.t &&
+	cat >msg <<-EOF &&
+	amend! $(git rev-parse HEAD)
+
+	merge F1 and F2
+
+	reworded
+	EOF
+
+	git commit -a -F msg &&
+	git history squash --no-edit HEAD^^! HEAD &&
+	test_cmp_rev HEAD^1 F2 &&
+	test_cmp_rev HEAD^2 F1 &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	sed 1,2d msg | test_commit_message HEAD
+'
+
+test_expect_success '--update-refs=head only moves HEAD' '
+	git reset --hard three &&
+	git branch -f other HEAD &&
+	other_before=$(git rev-parse other) &&
+
+	git history squash --no-edit --update-refs=head start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev "$other_before" other
+'
+
+test_expect_success 'refuses to fold a range a branch points into' '
 	test_when_finished \
 		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
 		 git branch -D feature" &&
@@ -85,20 +415,275 @@ test_expect_success 'prints branches that cannot follow the squash' '
 	test_grep "^error: the following branches cannot be rewritten" err &&
 	test_grep "^  topic-1$" err &&
 	test_grep "^  topic-2$" err &&
-	test_grep "^hint: .* --update-refs=head" err
+	test_grep "^hint: .* --update-refs=head" err &&
+	test_cmp_rev C6 HEAD &&
+
+	# squash succeeds with --update-refs=head
+	git history squash --no-edit --update-refs=head start.. &&
+	test_cmp_rev start HEAD^ &&
+	test_cmp_rev C6^{tree} HEAD^{tree} &&
+	test_cmp_rev C6 HEAD@{1}
 '
 
 test_expect_success 'advice.historyUpdateRefs silences the hint' '
 	git reset --hard three &&
 	git branch -f mid HEAD~1 &&
+	head_before=$(git rev-parse HEAD) &&
 
 	test_must_fail git -c advice.historyUpdateRefs=false \
 		history squash start.. 2>err &&
 	test_grep "^error: the following branches cannot be rewritten" err &&
 	test_grep "^  mid$" err &&
 	test_grep ! "hint:" err &&
+	test_cmp_rev "$head_before" HEAD &&
 
 	git branch -D mid
 '
 
+test_expect_success 'leaves tags and remote-tracking refs unchanged' '
+	git reset --hard three &&
+	git tag -f mark HEAD~1 &&
+	git update-ref refs/remotes/origin/mark HEAD~1 &&
+	mark_before=$(git rev-parse mark) &&
+
+	git history squash --no-edit start.. &&
+
+	test_cmp_rev "$mark_before" mark &&
+	test_cmp_rev "$mark_before" refs/remotes/origin/mark &&
+
+	git tag -d mark &&
+	git update-ref -d refs/remotes/origin/mark
+'
+
+test_expect_success 'squashes a range whose internal merge has a single base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag before-side file b &&
+	git checkout -b inner-side &&
+	test_commit --no-tag on-inner-side inner x &&
+	git checkout "$main" &&
+	test_commit --no-tag after-side file c &&
+	git merge --no-ff -m merge inner-side &&
+	git branch -D inner-side &&
+	test_commit --no-tag after-merge file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_subjects -1 <<-\EOF &&
+	before-side
+	EOF
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file inner
+'
+
+test_expect_success 'folds a merge of a branch that forked at the base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b base-fork-side &&
+	test_commit --no-tag base-fork-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag base-fork-main file b &&
+	git merge --no-ff -m "merge base-fork-side" base-fork-side &&
+	git branch -D base-fork-side &&
+	test_commit --no-tag base-fork-tail file c &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file side
+'
+
+test_expect_success 'refuses a merge whose other parent is outside the range' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b outside-parent &&
+	test_commit --no-tag outside-parent outside x &&
+	git checkout "$main" &&
+	test_commit --no-tag outside-main file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag outside-mid file c &&
+	git merge --no-ff -m "merge outside-parent" outside-parent &&
+	git branch -D outside-parent &&
+	merged=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'folds a range whose tip is a merge commit' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag tipmerge-base file b &&
+	git checkout -b tipmerge-side &&
+	test_commit --no-tag tipmerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag tipmerge-main file c &&
+	git merge --no-ff -m "merge tipmerge-side" tipmerge-side &&
+	git branch -D tipmerge-side &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file side
+'
+
+test_expect_success 'folds a range whose base is a merge commit' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b basemerge-side &&
+	test_commit --no-tag basemerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag basemerge-main file b &&
+	git merge --no-ff -m "merge basemerge-side" basemerge-side &&
+	git branch -D basemerge-side &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag basemerge-one file c &&
+	test_commit --no-tag basemerge-two file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit "$base.." &&
+
+	check_commit_count "$base..HEAD" 1 &&
+	test_cmp_rev "$base" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'folds a range with two interior merges' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag two-merge-a file a1 &&
+	git checkout -b two-merge-s1 &&
+	test_commit --no-tag two-merge-s1 s1 x &&
+	git checkout "$main" &&
+	git merge --no-ff -m "merge s1" two-merge-s1 &&
+	test_commit --no-tag two-merge-b file b1 &&
+	git checkout -b two-merge-s2 &&
+	test_commit --no-tag two-merge-s2 s2 y &&
+	git checkout "$main" &&
+	git merge --no-ff -m "merge s2" two-merge-s2 &&
+	git branch -D two-merge-s1 two-merge-s2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file s1 &&
+	test_path_is_file s2
+'
+
+test_expect_success 'folds a range with a nested merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b nested-outer &&
+	test_commit --no-tag nested-outer outer x &&
+	git checkout -b nested-inner &&
+	test_commit --no-tag nested-inner inner y &&
+	git checkout nested-outer &&
+	git merge --no-ff -m "merge inner" nested-inner &&
+	git checkout "$main" &&
+	test_commit --no-tag nested-main file b1 &&
+	git merge --no-ff -m "merge outer" nested-outer &&
+	git branch -D nested-outer nested-inner &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file outer &&
+	test_path_is_file inner
+'
+
+test_expect_success 'folds a range with an octopus merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag octo-base file a1 &&
+	git checkout -b octo-1 &&
+	test_commit --no-tag octo-1 o1 x &&
+	git checkout "$main" &&
+	git checkout -b octo-2 &&
+	test_commit --no-tag octo-2 o2 y &&
+	git checkout "$main" &&
+	git merge --no-ff -m octopus octo-1 octo-2 &&
+	git branch -D octo-1 octo-2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file o1 &&
+	test_path_is_file o2
+'
+
+test_expect_success 'refuses an octopus merge with an arm forked before the base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b octo-pre &&
+	test_commit octo-pre-side pside x &&
+	git checkout "$main" &&
+	test_commit octo-pre-main file b1 &&
+	octo_base=$(git rev-parse HEAD) &&
+	git checkout -b octo-within &&
+	test_commit --no-tag octo-within wside y &&
+	git checkout "$main" &&
+	git merge --no-ff -m octopus octo-pre octo-within &&
+	merged=$(git rev-parse HEAD) &&
+	git branch -D octo-pre octo-within &&
+
+	test_must_fail git history squash "$octo_base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'refuses when a descendant above the range is a merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag desc-one file b &&
+	test_commit --no-tag desc-two file c &&
+	git tag desc-tip &&
+	git checkout -b desc-above &&
+	test_commit --no-tag desc-above above x &&
+	git checkout "$main" &&
+	test_commit --no-tag desc-main file d &&
+	git merge --no-ff -m "merge desc-above" desc-above &&
+	git branch -D desc-above &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash --no-edit start..desc-tip 2>err &&
+	test_grep "merge commits is not supported" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'refuses to fold a range a ref points into at a merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag refmerge-base file b &&
+	git checkout -b refmerge-side &&
+	test_commit --no-tag refmerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag refmerge-main file c &&
+	git merge --no-ff -m "interior merge" refmerge-side &&
+	git branch -D refmerge-side &&
+	git branch at-merge HEAD &&
+	test_commit --no-tag refmerge-tail file d &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "^error: the following branches cannot be rewritten" err &&
+	test_grep "^  at-merge$" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D at-merge
+'
+
 test_done
-- 
gitgitgadget

