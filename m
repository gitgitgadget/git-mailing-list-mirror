Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA537C11B
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750651; cv=none; b=Dpgrra8cNrqnqALlnBAetkckITbuVg9ptRqaVyenJSTMG0IPLYpuDRO+AIG2KQ8Ue1AUu/IO00iofnoW91Z5L8sDeRbJWOxqCLvi8tXWEeV7pddBtZo0tW3za5r1lmw9paaltZb1+rW2vkHAmBBWHAJgkhhX0j3KJW9FHBSfTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750651; c=relaxed/simple;
	bh=6njfGCN7U4WjHz8IW7QcaME0MUdwNAWjH3DldoIQ/Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNS2oxWUKd632ulribPfBg1fJUE5oyO2euKUZmCa2Yg1YOh6+nbsuQrs46TPU7J6vjOjF6+DNR1jcVXjiexQbAm3InAJrxL2p7tLyK+krGzgxxIGFIxFUBC93ivZvwc9FBChe58Q1efAxs+4iIV6B3KJnfcAuApRkLdJr3iGy2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qotm63EV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qotm63EV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956242332dso16632505e9.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750647; x=1786355447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pnsM6eUUDz5e5abnWa53ey5WCWCY2CV+lvQoQTiI++w=;
        b=Qotm63EV6QEtlI7sEJXboZlLHmwvl5ZESFHcVnTlkZMe0B8vhtDedXGfXXETMn6jBK
         etnpUAwBtlKBp63v2A/CNyKBKozTgHeuiNnPdVzlXBup+BjeZN03pr+cvaL9G0t7DbNv
         e4lz4jJRtitnp/W13x1WtEzeR3Za4H+DmReTdADQOS/Z1tEFL144rygVvm1FZW3bGsR0
         iEouoSJS/9Qq0mZbsKfspn6wdkTl5GrP4JQQr9b0ChZGVTLkdbWeXwMFkCo+4cyonz/R
         JRjwGZ8zzelRGb6KvtjtAT22BCpv0IhxZvCE7+del/6eO0RIOPIbUoJvDMdUcOlmCx/d
         4+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750647; x=1786355447;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnsM6eUUDz5e5abnWa53ey5WCWCY2CV+lvQoQTiI++w=;
        b=XQWiM3BVU8psavfwqCIjuHQSg+/vSlEnpZvMZ0Kwbq4OfHj5W1brROmx+O6zZsYBcy
         JL6T6cV6r6Evyc6rNiK5DOTREhVZ5s25HkSD171KcEZTDhTVLNKYj8j7+Wbu2toX1MLR
         zEcqmaNyPbbtjv+L94xRItMzTJrXtESo56YSKC5JDvbWipBvRovdnQTjFt4ob82G6gEy
         Arf8gXWnrvQ80EgZpG7FxnhROQfnUlcbDS/crDSgG7IRLOUJLXnopYJdJRzVCFkkRrhp
         rPcXSWvTpM9aL7jqeuYHU4DxU59cs/4QVgzmMPg4u7JCun8SlyXS/ScFZVrfZbOazYU4
         qYdg==
X-Gm-Message-State: AOJu0Yzi8omIBYjZHxL8dCsjRrNU3BkDNYgppL7yF7v6cSBDPYthzHPz
	6VrGal5gkBoFhOYab6CjXC3OAJsHD0a2jfqBC7Re77qE2NggM0xO+OPwCKCdgQ==
X-Gm-Gg: AR+sD12FhytVmCFmkrUOqOOzT/YkrU43ZgP23pkGUqbdEZE7buuA/LXocp2pks6EgLZ
	RHsVWLSHqi1URS43FXuG7IsUaPPGmzACOoOdLPJBU3hu9a6mj5nZT32fbFWXTeBaomb6KyHxPkA
	KxCVH4RkyG7+bVYLXarZVn9Zm7zJK5RyfwlRuG/F3kHRIy+ULnRpnveqj1iKSJJzWDhpAUyAr2a
	Q2UN7xoUM6BSfootfstCGR9Y/xVFais++gZlt/mw+za8sKabyoSCCCgzkEz20MGbC2Bn+OcDAaL
	zKBFH2BP3cPdMbUa+XILT1VYuKLXaGdLDA8DW1xN6zdi4BNVQkreSV6XQQv6xde+ZNe7FfNv/zc
	yTCcKL/cJHOxE2fmXAMFHqg5EvxV5ZhSSVxLrokskktGA28aWdQ0WIF6IMYyofzy/hrs4w+kf1T
	tdJAiiJJiFlWOAru+yaLtMUUbaso8vv5v1Ejoo26l17lhRvT+RJSTUgzmUUpu/yfp0IvtORrN8h
	eg=
X-Received: by 2002:a05:600c:c8c:b0:493:eed4:7210 with SMTP id 5b1f17b1804b1-4980c673866mr162434085e9.11.1785750646754;
        Mon, 03 Aug 2026 02:50:46 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.6/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:26 +0100
Message-ID: <84abbf386548600fafd33352480466362e73747a.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Do not discard "squash!" or "amend!" messages

"squash!" and "amend!" commit messages are a strong indication that
the user intended to reword the target commit when squashing. To
that end only squash them if the message ends up being used. If an
"amend!" message targets a commit that's being squashed, but is not
the first commit that's being squashed, then refuse to squash it
unless the commit message is being edited. Also refuse to squash a
"squash!" message unless it is being squashed into a "fixup!" or
"squash!" message with the same target, or the message is being
edited. If an "amend!" or "squash!" message is being squashed into
a "fixup!" message, then we retain the original target text. This
means that we can safely squash 'def456 "amend! abc123"' into 'abc123
"fixup! add new feature"', and later squash the result into '098765
"add new feature"'.

The logic is implemented directly, rather than creating a rebase
todo list which is more efficient and hopefully clearer (I had a hard
time understanding what the existing code does). It also allows us to
tailor the rules to suit the new command. In particular we are much
more careful when handling "fixup! <object-name>" subjects, rejecting
subjects like "fixup! HEAD^" that do not have a fixed target. We also
support squashing "fixup! abc123" into "fixup! <subject of abc123>"
to make it easier to squash a group of fixups together.

The authorship of the squashed commit is always taken from the first
commit being squashed which matches what rebase does (if there is
an "amend!" commit the existing code takes the authorship from that
instead). While an "amend!" commit might contain substantial changes
that justify changing the authorship it could equally be correcting
a simple typo. There is no reason to assume that changes in "amend!"
commits are more significant that those in "fixup!" or "squash!"
commits.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/history.c         | 409 +++++++++++++++++++++++++-------------
 object.h                  |   2 +-
 t/t3455-history-squash.sh | 261 ++++++++++++++----------
 3 files changed, 431 insertions(+), 241 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 84e13fd75a..894da69f31 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1011,6 +1011,260 @@ static int cmd_history_split(int argc,
 /*Remember to update object flag allocation in object.h */
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
+		BUG("Editing is not implemented yet");
+	} else if (flags & SQUASH_AMEND_TARGET) {
+		if (starts_with(data->squash_message.buf, "squash!"))
+			return error(_("squashing %s (%s) would overwrite "
+				       "'squash!' message, please combine them "
+				       "using '--reedit-message'"),
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
+			       "base commit without '--reedit-message'"),
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
+		BUG("Editing is not implemented yet");
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
+				       "'--reedit-message'"),
+				     repo_find_unique_abbrev(repo,
+							     &commit->object.oid,
+							     DEFAULT_ABBREV),
+				     data->subject.buf);
+		}
+	} else {
+		return error(_("cannot squash %s (%s) that does not target "
+			       "base commit without '--reedit-message'"),
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
 
 /*
  * Resolve a "<base>..<tip>" revision range into the base commit just outside
@@ -1024,9 +1278,11 @@ static int resolve_squash_range(struct repository *repo,
 				int argc, const char **argv,
 				struct commit **base_out,
 				struct commit **oldest_out,
-				struct commit **tip_out)
+				struct commit **tip_out,
+				char **message_out)
 {
 	struct rev_info revs;
+	struct subject_data subject_data = SUBJECT_DATA_INIT;
 	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
 	size_t i;
 	int ret, tip_count = 0;
@@ -1127,12 +1383,16 @@ static int resolve_squash_range(struct repository *repo,
 		if (!oldest) {
 			commit_list_insert(commit, &filter.with_commit);
 			oldest = commit;
+		}
+		if (squash_check_subject(repo, commit, &subject_data)) {
+			ret = -1;
+			goto out;
 		}
 		tip = commit;
 		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
 		tip_count++;
 	}
-	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP | SQUASH_AMEND_TARGET);
 	reset_revision_walk();
 	if (!tip_count) {
 		ret = error(_("the revision range is empty"));
@@ -1171,122 +1431,14 @@ static int resolve_squash_range(struct repository *repo,
 	*base_out = base;
 	*oldest_out = oldest;
 	*tip_out = tip;
+	*message_out = strbuf_detach(&subject_data.squash_message, NULL);
 	ret = 0;
 
 out:
+	subject_data_clear(&subject_data);
 	release_revisions(&revs);
 	ref_filter_clear(&filter);
 	ref_array_clear(&refs);
-	return ret;
-}
-
-static const char *autosquash_target(const char *subject)
-{
-	const char *rest;
-
-	while (skip_prefix(subject, "fixup! ", &rest) ||
-	       skip_prefix(subject, "squash! ", &rest) ||
-	       skip_prefix(subject, "amend! ", &rest))
-		subject = rest;
-	return subject;
-}
-
-static int reject_dangling_fixups(struct repository *repo,
-				  struct commit *base,
-				  struct commit *tip,
-				  struct commit *oldest,
-				  struct commit **msg_source,
-				  struct commit **amend_source)
-{
-	struct todo_list todo = TODO_LIST_INIT;
-	struct replay_opts opts = REPLAY_OPTS_INIT;
-	struct rev_info revs;
-	struct commit *commit, *last_amend = NULL;
-	struct strvec args = STRVEC_INIT;
-	char *dangling_subject = NULL, *dangling_target = NULL;
-	bool mixed_target = false, all_fixups_one_target;
-	bool past_oldest_group = false;
-	int i, ret, nr_dangling = 0;
-
-	*msg_source = oldest;
-	*amend_source = NULL;
-
-	repo_init_revisions(repo, &revs, NULL);
-	strvec_push(&args, "ignored");
-	strvec_push(&args, "--reverse");
-	strvec_push(&args, "--topo-order");
-	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
-		     oid_to_hex(&tip->object.oid));
-	setup_revisions_from_strvec(&args, &revs, NULL);
-
-	if (prepare_revision_walk(&revs) < 0) {
-		ret = error(_("error preparing revisions"));
-		goto out;
-	}
-	while ((commit = get_revision(&revs)))
-		strbuf_addf(&todo.buf, "pick %s\n",
-			    oid_to_hex(&commit->object.oid));
-
-	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
-	    todo_list_rearrange_squash(&todo) < 0) {
-		ret = error(_("could not check the range for fixups"));
-		goto out;
-	}
-
-	for (i = 0; i < todo.nr; i++) {
-		const char *message, *subject_start, *target;
-		char *subject;
-		size_t sublen;
-
-		message = repo_logmsg_reencode(repo, todo.items[i].commit,
-					       NULL, NULL);
-		sublen = find_commit_subject(message, &subject_start);
-
-		if (todo.items[i].command != TODO_PICK) {
-			if (!past_oldest_group &&
-			    starts_with(subject_start, "amend! "))
-				*amend_source = todo.items[i].commit;
-			repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
-			continue;
-		}
-		if (i)
-			past_oldest_group = true;
-
-		subject = xmemdupz(subject_start, sublen);
-		target = autosquash_target(subject);
-		if (target != subject) {
-			nr_dangling++;
-			if (!dangling_target) {
-				dangling_target = xstrdup(target);
-				dangling_subject = xstrdup(subject);
-			} else if (strcmp(dangling_target, target)) {
-				mixed_target = true;
-			}
-			if (starts_with(subject, "amend! "))
-				last_amend = todo.items[i].commit;
-		}
-		free(subject);
-		repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
-	}
-
-	all_fixups_one_target = nr_dangling == todo.nr && !mixed_target;
-	if (nr_dangling && !all_fixups_one_target) {
-		ret = error(_("cannot squash '%s': its target is not in the "
-			      "range"), dangling_subject);
-	} else {
-		if (last_amend)
-			*msg_source = last_amend;
-		ret = 0;
-	}
-
-out:
-	free(dangling_subject);
-	free(dangling_target);
-	todo_list_release(&todo);
-	replay_opts_release(&opts);
-	reset_revision_walk();
-	release_revisions(&revs);
-	strvec_clear(&args);
 	return ret;
 }
 
@@ -1314,11 +1466,9 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
-	struct strbuf message = STRBUF_INIT;
-	struct commit *base, *oldest, *tip, *rewritten, *msg_source,
-		*amend_source;
+	struct commit *base, *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
-	const char *message_template = NULL;
+	char *message_template = NULL;
 	struct commit_list *parents = NULL;
 	struct rev_info revs = { 0 };
 	int ret;
@@ -1338,25 +1488,10 @@ static int cmd_history_squash(int argc,
 	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
 
 	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
-				   argc, argv, &base, &oldest, &tip);
-	if (ret < 0)
-		goto out;
-
-	ret = reject_dangling_fixups(repo, base, tip, oldest, &msg_source,
-				     &amend_source);
-	if (ret < 0)
-		goto out;
-	if (amend_source) {
-		const char *amend_message, *body;
-
-		amend_message = repo_logmsg_reencode(repo, amend_source,
-						     NULL, NULL);
-		find_commit_subject(amend_message, &body);
-		body = skip_blank_lines(body + commit_subject_length(body));
-		strbuf_addstr(&message, body);
-		message_template = message.buf;
-		repo_unuse_commit_buffer(repo, amend_source, amend_message);
-	}
+				   argc, argv, &base, &oldest, &tip,
+				   &message_template);
+	if (ret < 0)
+		goto out;
 
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
@@ -1366,7 +1501,7 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", msg_source, message_template,
+	ret = commit_tree_ext(repo, "squash", oldest, message_template,
 			      parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
@@ -1386,9 +1521,9 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
-	strbuf_release(&message);
 	commit_list_free(parents);
 	release_revisions(&revs);
+	free(message_template);
 	return ret;
 }
 
diff --git a/object.h b/object.h
index ad18ffcc55..46cade33fb 100644
--- a/object.h
+++ b/object.h
@@ -74,7 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
- * builtin/history.c:                    11-12
+ * builtin/history.c:                    11---13
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index d7697489a0..26c4b4e29e 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -29,14 +29,25 @@ check_log_subjects () {
 check_log_messages () {
 	git log --format="%B" "$1" >actual &&
 	cat >expect &&
+	test_cmp expect actual
+}
+
+# Checks that the author data of two commits matches
+# Usage: check_commit_author <rev1> <rev2>
+check_commit_author () {
+	git show -s --format="%an <%ae> %ad" "$1" >expect &&
+	git show -s --format="%an <%ae> %ad" "$1" >actual &&
 	test_cmp expect actual
 }
 
 test_expect_success 'setup linear history touching two files' '
 	test_commit base file a start &&
-	test_commit --no-tag one other x &&
-	test_commit --no-tag two file c &&
-	test_commit three file d
+	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
+		test_commit one other x &&
+	GIT_AUTHOR_NAME=Two GIT_AUTHOR_EMAIL=two@example.com \
+		test_commit two file c &&
+	GIT_AUTHOR_NAME=Three GIT_AUTHOR_EMAIL=three@example.com \
+		test_commit three file d
 '
 
 test_expect_success 'errors on missing range argument' '
@@ -192,106 +203,150 @@ test_expect_success 'squashes when the base is the root commit' '
 	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
 '
 
-
-test_expect_success 'folds fixups whose target is in the range' '
-	git reset --hard start &&
-	test_commit --no-tag target file b &&
-	git commit --allow-empty -m "fixup! target" &&
-	git commit --allow-empty -m "fixup! target" &&
-	test_commit --no-tag later file c &&
-
-	git history squash start.. &&
-
-	check_commit_count start..HEAD 1 &&
-	check_log_subjects -1 <<-\EOF
-	target
-	EOF
-'
-
-test_expect_success 'refuses a below-range fixup! after an in-range commit' '
-	git reset --hard start &&
-	test_commit --no-tag inside file b &&
-	test_commit --no-tag "fixup! outside" file c &&
-	head_before=$(git rev-parse HEAD) &&
-
-	test_must_fail git history squash start.. 2>err &&
-	test_grep "target is not in the range" err &&
-	test_cmp_rev "$head_before" HEAD
-'
-
-test_expect_success 'combines a run of fixups for one commit below the range' '
-	git reset --hard start &&
-	stage_file b && git commit -m "fixup! base" &&
-	stage_file c && git commit -m "fixup! base" &&
-
-	git history squash start.. &&
-
-	check_commit_count start..HEAD 1 &&
-	check_log_subjects -1 <<-\EOF
-	fixup! base
-	EOF
-'
-
-test_expect_success 'combining below-range fixups keeps the last amend! message' '
-	git reset --hard start &&
-	stage_file b && git commit -m "fixup! base" &&
-	stage_file c &&
-	commit_with_message "amend! base\n\namended body\n" &&
-
-	git history squash start.. &&
-
-	check_commit_count start..HEAD 1 &&
-	check_log_messages -1 <<-\EOF
-	amend! base
-
-	amended body
-
-	EOF
-'
-
-test_expect_success 'refuses fixups for two different commits below the range' '
-	git reset --hard start &&
-	stage_file b && git commit -m "fixup! aaa" &&
-	stage_file c && git commit -m "fixup! bbb" &&
-	head_before=$(git rev-parse HEAD) &&
-
-	test_must_fail git history squash start.. 2>err &&
-	test_grep "target is not in the range" err &&
-	test_cmp_rev "$head_before" HEAD
-'
-
-test_expect_success 'the last amend! for the oldest commit replaces its message' '
-	git reset --hard start &&
-	test_commit --no-tag marker-oldest file b &&
-	git commit --allow-empty -m "squash! marker-oldest" &&
-	commit_with_message "amend! marker-oldest\n\nearlier message\n" &&
-	commit_with_message \
-		"amend! marker-oldest\n\namended subject\n\namended body\n" &&
-	test_commit --no-tag marker-later file c &&
-	commit_with_message "amend! marker-later\n\nwrong message\n" &&
-
-	git history squash start.. &&
-
-	check_commit_count start..HEAD 1 &&
-	check_log_messages -1 <<-\EOF
-	amended subject
-
-	amended body
-
-	EOF
-'
-
-test_expect_success 'preserves authorship of the oldest commit' '
-	git reset --hard start &&
-	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
-		test_commit --no-tag oldest file b &&
-	test_commit newest file c &&
-
-	git history squash start.. &&
-
-	git log -1 --format="%an <%ae>" >actual &&
-	echo "Squasher <squash@example.com>" >expect &&
-	test_cmp expect actual
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
+	git history squash start..HEAD~1 &&
+	test_cmp_rev start HEAD~2 &&
+	check_commit_author one HEAD~1 &&
+	test_commit_message HEAD~1 -m one &&
+
+	# squashing "fixup! fixup! <target>" into "<target>"
+	git history squash start.. &&
+	test_cmp_rev start HEAD~1 &&
+	check_commit_author one HEAD &&
+	test_commit_message HEAD -m one
+'
+
+test_expect_success 'squashing "squash!" messages' '
+	git reset --hard two &&
+	echo fix >file &&
+	git commit --fixup=HEAD -a &&
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
+	test_must_fail git history squash two^.. 2>err &&
+	test_grep "^error: squashing .* (squash! [a-f0-9]*) would discard its message" err &&
+
+	# squashing "squash!" into "fixup!" appends messages and changes
+	# subject prefix
+	git history squash two.. &&
+	test_cmp_rev HEAD^ two &&
+	test_commit_message HEAD <<-\EOF &&
+	squash! two
+
+	Append this
+
+	Append this as well
+	EOF
+	check_commit_author two HEAD &&
+
+	git commit --allow-empty -F - <<-\EOF &&
+	amend! two
+
+	A new message
+	EOF
+
+	# "amend!" does not replace "squash!"
+	test_must_fail git history squash HEAD~2.. 2>err &&
+	test_grep "^error: squashing .* (amend! two) would overwrite .squash!. message" err
+'
+
+test_expect_success 'squash commit uses last "amend!" message' '
+	git reset --hard three &&
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
+	git history squash three^.. &&
+	sed -e 1,2d msg | test_commit_message HEAD &&
+	check_commit_author three HEAD &&
+	test_cmp_rev HEAD^ three^ &&
+
+	# squashing amend! into fixup! updates subject prefix
+	git reset --hard HEAD@{1} &&
+	git history squash three.. &&
+	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
+	check_commit_author HEAD@{1}~4 HEAD &&
+	test_cmp_rev HEAD^ three &&
+
+	# squashing amend! into amend! keeps original subject line
+	git reset --hard HEAD@{1} &&
+	git history squash HEAD~3.. &&
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
+	test_must_fail git history squash HEAD~4.. 2>err &&
+	test_grep "^error: cannot squash .* that does not target" err &&
+
+	# amend! message that targets commit that is not in range is rejected
+	test_must_fail git history squash HEAD~3.. 2>err &&
+	test_grep "^error: cannot squash .* target is not being squashed" err
 '
 
 test_expect_success '--update-refs=head only moves HEAD' '
-- 
2.54.0.200.gfd8d68259e3

