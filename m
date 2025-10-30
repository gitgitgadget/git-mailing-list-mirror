Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B12191F92
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827633; cv=none; b=i7MM4HxLaigk3r2OFg+O0ddEAfq3VAmg9qsmWbkvdqtnsuBYJRI0si6JXBxwEvJIE2EsFg4qNWB9rMn6HE3fgCWOECT/sAE7m2ddDXWrpvGO7sL4AIuUEpIwCyp9KFg761LqWUj6ZVe388U7mjGdITSZ5gJWFuwFlJCHgxg6Tug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827633; c=relaxed/simple;
	bh=jaN5I2iGjt+i/Y82HqkPT68RjqKLXTT6H5vnrYw0K4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKzhDmVATLaPAXOw6iW8r7AS/13md3NQTaUdqDPQSYSvExuRVjZzSnTFyHppB/g7d74aDYFgfLJLCM1BH5Vqdoo5tKXZZmiB0YfXXY0PeydJ2B4veBTsxUW/6CONv4NkkKBPQBPHhHDyMdKPHO8hApOVErsX0LUp3zHBxEHr2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4AZSlIb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4AZSlIb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso13239195e9.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827628; x=1762432428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udl1lA8gGgZ3b51l0gQNmvDSdFfeVK0vhuRuwQphyqw=;
        b=O4AZSlIbMHnLDQNnkGFbwq3Mlnws9DKbTv7MtETPo9e6/GX32UZJulcN27l6tcPrU/
         ZAty8yO4LZMbDW9fDXqAx6hW3jwp4Pc9cz2ne2gPK9fQtvuriqbFD5onw1xAdAdXvwnk
         68wzron9nz5xRp6RbXm1f3jf/eguehYWpcDeN+dZsIB2LHYb9GeZx/jiBlo6kSzteVyj
         ZchpYKI+Fdu23bjAj7f0cVldqNKhtvPJt3e/+xf2vfzZWG4LG3qsLQtE3f/zSk+OatXi
         1c3C0dOiXFkuKk5uhyNxiyBguRhAGZFQ3w6MHffzYmCij3wLhmkdPhhS7R9suYCDupbj
         tNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827628; x=1762432428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udl1lA8gGgZ3b51l0gQNmvDSdFfeVK0vhuRuwQphyqw=;
        b=uB8arBVtsu8WFJFhEqQXygw3TFg2P17Y2ge5qyHAu4GFDGO4GlhVwuMtQr8266Ly3A
         GtCykHQyGhAGaqzLjgkiX0NG0Qbw5cbbvtF6VA/m7zXcT6hEoTSzP2aYLLkCRCxUMr+y
         TfLjxRwpHYEQIfSYDzeY2RrYvJrtMmU5f53DnceR4+LYVRV+zxULpb1Zvwe6NLicMgYK
         ZG+cFUCz3kqaF2imhYmBo0zaEAk1WrjZ7JQ+xTxRwNFAgyTgafRy6AduzKBRBT9wVF3A
         jC+Mrr5Xb10NYfHaPAmY6hvwJLXIFrbZQ/jRIsfD77dkNNCqixtq4OB7hclQd9U4639s
         wL4A==
X-Gm-Message-State: AOJu0YwBziauRcdlBeSXiTnyPGLYk0p1N6Gdz5Z08rfeZ+1cz+0ySvEH
	pOA2k+SeLq+hHAsrq4ohUglAXTg9MxTl9ppi1PxVf7BdCErX1mHCFv9iT8Pa5w==
X-Gm-Gg: ASbGnctW8nbIl+secjeSkOi8Rx5+chaEil4fj7mTzYLJ1T2GM8FdC1FiOkBwZB7+qnD
	e8OUXEHVe5evhm7Nq/vxRM0+nJEO6tu0z+D+cAiVd2ItetGR/0YizWcX6Ewrh1kIpmKl7QoK3yu
	aHSfhSsU4Mw3he64jgPBXDc1h1OEwmH/322bz5iLwELeEklqGZ5YLO/0Ckms87DM84WcXbpOkHg
	ZOFfd8FXhORXpEu7I4IxygUTL29HXmS9esHtUfJEh7IhmUjgi/fc2+SugeOQK/DUwseF/zFnQli
	zgxqaeLbV/m8U/E1okk9xqxfAGYQoMR9ZtPfptAguQP9Ec5DrBO6t1Fg2l+2Ub1CWLJ1dLEkgP2
	dTTl2EoTrTSnluTwOGAByQ+G57qAjUBlE1/8hNsaqMAsfAd+t0rxtJDDdJCJrpjLU/xuC3mFOLj
	zJFy/QWKWdevAG0cKlQniRNrpSgBdteatrxz6m
X-Google-Smtp-Source: AGHT+IGtyJ4F3RZrvuxnAzIXr5o6MfWJwQVvEjRfu2M3O3wuqx9p46EauHMXxo0bMqAX8newJRYHng==
X-Received: by 2002:a05:600c:4ecb:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-4771e1edb27mr61235985e9.32.1761827627315;
        Thu, 30 Oct 2025 05:33:47 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:8aa2:a86f:99be:b78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm2364595f8f.44.2025.10.30.05.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:33:46 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/5] fast-export/import: cleanups and translation
Date: Thu, 30 Oct 2025 13:33:27 +0100
Message-ID: <20251030123332.3337684-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.617.g2aaa867cd1
In-Reply-To: <20251028081232.3068147-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Introduction
------------

In a previous v2 patch series[1] that I sent last May, there were two
preparatory cleanup patches[2][3] that have been dropped in the v3 and
next versions. I think these two cleanup patches are worth resending
in their own series though.

While at cleaning things up, I realized that, when working in this
area of the code, I have often been annoyed by the fact that few error
and warning messages were marked for translation. So I decided to also
address this here.

So patches 1/5 and 2/5 are small code cleanups that are resent, while
patches 3/5, 4/5 and 5/5 are about marking strings for translation.

[1] https://lore.kernel.org/git/20250526103314.1542316-1-christian.couder@gmail.com/
[2] https://lore.kernel.org/git/20250526103314.1542316-2-christian.couder@gmail.com/
[3] https://lore.kernel.org/git/20250526103314.1542316-3-christian.couder@gmail.com/

Changes compared to v1
----------------------

Thanks to Junio for commenting on the v1! 

There are only small changes in patches 3/5 and 4/5. Mostly some
uppercase letters at the start of error and warning messages have been
downcased according to our style.

In patch 3/5, an error message that started with "Error: " has been
changed to remove that part.

In patch 4/5, some tests in "t9300-fast-import.sh" had to be adjusted
because they were testing error or warning messages where the first
letter was downcased.

The commit messages of patches 3/5 and 4/5 have also been adjusted to
mention these changes.

CI tests:
---------

All the tests passed. See:

https://github.com/chriscool/git/actions/runs/18938796521

Range diff compared to v1
-------------------------

1:  525f8a7bbb = 1:  fbc4a97b6a gpg-interface: simplify ssh fingerprint parsing
2:  54a4126ad6 = 2:  e653da13fb gpg-interface: use left shift to define GPG_VERIFY_*
3:  719785dc07 ! 3:  82348e8e42 fast-export: mark strings for translation
    @@ Commit message
         translated version, let's mark all the remaining error or warning
         messages for translation.
     
    -    While at it, improve how some arguments to some error functions are
    -    indented.
    +    While at it:
    +
    +      - improve how some arguments to some error functions are indented,
    +      - remove "Error:" at the start of an error message,
    +      - downcase error and warning messages that start with an uppercase.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ builtin/fast-export.c: static int parse_opt_sign_mode(const struct option *opt,
      
      	if (parse_sign_mode(arg, val))
     -		return error("Unknown %s mode: %s", opt->long_name, arg);
    -+		return error(_("Unknown %s mode: %s"), opt->long_name, arg);
    ++		return error(_("unknown %s mode: %s"), opt->long_name, arg);
      
      	return 0;
      }
    @@ builtin/fast-export.c: static int parse_opt_tag_of_filtered_mode(const struct op
      		*val = REWRITE;
      	else
     -		return error("Unknown tag-of-filtered mode: %s", arg);
    -+		return error(_("Unknown tag-of-filtered mode: %s"), arg);
    ++		return error(_("unknown tag-of-filtered mode: %s"), arg);
      	return 0;
      }
      
    @@ builtin/fast-export.c: static int parse_opt_reencode_mode(const struct option *o
      			*val = REENCODE_ABORT;
      		else
     -			return error("Unknown reencoding mode: %s", arg);
    -+			return error(_("Unknown reencoding mode: %s"), arg);
    ++			return error(_("unknown reencoding mode: %s"), arg);
      	}
      
      	return 0;
    @@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
      
      	if (!object)
     -		die("Could not read blob %s", oid_to_hex(oid));
    -+		die(_("Could not read blob %s"), oid_to_hex(oid));
    ++		die(_("could not read blob %s"), oid_to_hex(oid));
      
      	mark_next_object(object);
      
    @@ builtin/fast-export.c: static void show_filemodify(struct diff_queue_struct *q,
     -				q->queue[i]->status,
     -				ospec->path ? ospec->path : "none",
     -				spec->path ? spec->path : "none");
    -+			die(_("Unexpected comparison status '%c' for %s, %s"),
    ++			die(_("unexpected comparison status '%c' for %s, %s"),
     +			    q->queue[i]->status,
     +			    ospec->path ? ospec->path : _("none"),
     +			    spec->path ? spec->path : _("none"));
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
      		case REENCODE_ABORT:
     -			die("Encountered commit-specific encoding %.*s in commit "
     -			    "%s; use --reencode=[yes|no] to handle it",
    -+			die(_("Encountered commit-specific encoding %.*s in commit "
    ++			die(_("encountered commit-specific encoding %.*s in commit "
     +			      "%s; use --reencode=[yes|no] to handle it"),
      			    (int)encoding_len, encoding,
      			    oid_to_hex(&commit->object.oid));
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      	}
      	if (tagged->type == OBJ_TREE) {
     -		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
    -+		warning(_("Omitting tag %s,\nsince tags of trees (or tags "
    ++		warning(_("omitting tag %s,\nsince tags of trees (or tags "
     +			  "of tags of trees, etc.) are not supported."),
      			oid_to_hex(&tag->object.oid));
      		return;
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      	if (message) {
      		message += 2;
     @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
    - 		if (signature)
    + 		if (sig_offset < message_size)
      			switch (signed_tag_mode) {
      			case SIGN_ABORT:
     -				die("encountered signed tag %s; use "
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      			    oid_to_hex(&tag->object.oid));
      		case DROP:
      			/* Ignore this tag altogether */
    +@@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
    + 			return;
    + 		case REWRITE:
    + 			if (tagged->type == OBJ_TAG && !mark_tags) {
    +-				die(_("Error: Cannot export nested tags unless --mark-tags is specified."));
    ++				die(_("cannot export nested tags unless --mark-tags is specified."));
    + 			} else if (tagged->type == OBJ_COMMIT) {
    + 				p = rewrite_commit((struct commit *)tagged);
    + 				if (!p) {
     @@ builtin/fast-export.c: static struct commit *get_commit(struct rev_cmdline_entry *e, const char *full_n
      			tag = (struct tag *)tag->tagged;
      		}
      		if (!tag)
     -			die("Tag %s points nowhere?", e->name);
    -+			die(_("Tag %s points nowhere?"), e->name);
    ++			die(_("tag %s points nowhere?"), e->name);
      		return (struct commit *)tag;
      	}
      	default:
    @@ builtin/fast-export.c: static void get_tags_and_duplicates(struct rev_cmdline_in
      		commit = get_commit(e, full_name);
      		if (!commit) {
     -			warning("%s: Unexpected object of type %s, skipping.",
    -+			warning(_("%s: Unexpected object of type %s, skipping."),
    ++			warning(_("%s: unexpected object of type %s, skipping."),
      				e->name,
      				type_name(e->item->type));
      			free(full_name);
    @@ builtin/fast-export.c: static void get_tags_and_duplicates(struct rev_cmdline_in
      			continue;
      		default: /* OBJ_TAG (nested tags) is already handled */
     -			warning("Tag points to object of unexpected type %s, skipping.",
    -+			warning(_("Tag points to object of unexpected type %s, skipping."),
    ++			warning(_("tag points to object of unexpected type %s, skipping."),
      				type_name(commit->object.type));
      			free(full_name);
      			continue;
    @@ builtin/fast-export.c: static void export_marks(char *file)
      	f = fopen_for_writing(file);
      	if (!f)
     -		die_errno("Unable to open marks file %s for writing.", file);
    -+		die_errno(_("Unable to open marks file %s for writing."), file);
    ++		die_errno(_("unable to open marks file %s for writing."), file);
      
      	for (i = 0; i < idnums.size; i++) {
      		if (deco->base && deco->base->type == 1) {
    @@ builtin/fast-export.c: static void export_marks(char *file)
      	e |= fclose(f);
      	if (e)
     -		error("Unable to write marks file %s.", file);
    -+		error(_("Unable to write marks file %s."), file);
    ++		error(_("unable to write marks file %s."), file);
      }
      
      static void import_marks(char *input_file, int check_exists)
    @@ builtin/fast-export.c: static void import_marks(char *input_file, int check_exis
      
      		if (object->flags & SHOWN)
     -			error("Object %s already has a mark", oid_to_hex(&oid));
    -+			error(_("Object %s already has a mark"), oid_to_hex(&oid));
    ++			error(_("object %s already has a mark"), oid_to_hex(&oid));
      
      		mark_object(object, mark);
      
4:  bfb336a14f ! 4:  024ffc060e fast-import: mark strings for translation
    @@ Commit message
         While at it, let's make the following small changes:
     
           - replace "GIT" or "git" in a few error messages to just "Git",
    -      - replace "Expected from command, got %s" to "Expected 'from'
    +      - replace "Expected from command, got %s" to "expected 'from'
             command, got '%s'", which makes it clearer that "from" is a command
             and should not be translated,
    +      - downcase error and warning messages that start with an uppercase,
    +      - fix test cases in "t9300-fast-import.sh" that broke because an
    +        error or warning message was downcased,
    +      - split error and warning messages that are too long,
           - adjust the indentation of some arguments of the error functions.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    @@ builtin/fast-import.c: static struct branch *new_branch(const char *name)
      
      	if (b)
     -		die("Invalid attempt to create duplicate branch: %s", name);
    -+		die(_("Invalid attempt to create duplicate branch: %s"), name);
    ++		die(_("invalid attempt to create duplicate branch: %s"), name);
      	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
     -		die("Branch name doesn't conform to GIT standards: %s", name);
    -+		die(_("Branch name doesn't conform to Git standards: %s"), name);
    ++		die(_("branch name doesn't conform to Git standards: %s"), name);
      
      	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
      	b->name = mem_pool_strdup(&fi_mem_pool, name);
    @@ builtin/fast-import.c: static int loosen_small_pack(const struct packed_git *p)
      
      	if (lseek(p->pack_fd, 0, SEEK_SET) < 0)
     -		die_errno("Failed seeking to start of '%s'", p->pack_name);
    -+		die_errno(_("Failed seeking to start of '%s'"), p->pack_name);
    ++		die_errno(_("failed seeking to start of '%s'"), p->pack_name);
      
      	unpack.in = p->pack_fd;
      	unpack.git_cmd = 1;
    @@ builtin/fast-import.c: static void load_tree(struct tree_entry *root)
      	if (myoe && myoe->pack_id != MAX_PACK_ID) {
      		if (myoe->type != OBJ_TREE)
     -			die("Not a tree: %s", oid_to_hex(oid));
    -+			die(_("Not a tree: %s"), oid_to_hex(oid));
    ++			die(_("not a tree: %s"), oid_to_hex(oid));
      		t->delta_depth = myoe->depth;
      		buf = gfi_unpack_entry(myoe, &size);
      		if (!buf)
     -			die("Can't load tree %s", oid_to_hex(oid));
    -+			die(_("Can't load tree %s"), oid_to_hex(oid));
    ++			die(_("can't load tree %s"), oid_to_hex(oid));
      	} else {
      		enum object_type type;
      		buf = odb_read_object(the_repository->objects, oid, &type, &size);
      		if (!buf || type != OBJ_TREE)
     -			die("Can't load tree %s", oid_to_hex(oid));
    -+			die(_("Can't load tree %s"), oid_to_hex(oid));
    ++			die(_("can't load tree %s"), oid_to_hex(oid));
      	}
      
      	c = buf;
    @@ builtin/fast-import.c: static void load_tree(struct tree_entry *root)
      		c = parse_mode(c, &e->versions[1].mode);
      		if (!c)
     -			die("Corrupt mode in %s", oid_to_hex(oid));
    -+			die(_("Corrupt mode in %s"), oid_to_hex(oid));
    ++			die(_("corrupt mode in %s"), oid_to_hex(oid));
      		e->versions[0].mode = e->versions[1].mode;
      		e->name = to_atom(c, strlen(c));
      		c += e->name->str_len + 1;
    @@ builtin/fast-import.c: static void tree_content_replace(
      {
      	if (!S_ISDIR(mode))
     -		die("Root cannot be a non-directory");
    -+		die(_("Root cannot be a non-directory"));
    ++		die(_("root cannot be a non-directory"));
      	oidclr(&root->versions[0].oid, the_repository->hash_algo);
      	oidcpy(&root->versions[1].oid, oid);
      	if (root->tree)
    @@ builtin/fast-import.c: static int tree_content_set(
      	n = slash1 - p;
      	if (!n)
     -		die("Empty path component found in input");
    -+		die(_("Empty path component found in input"));
    ++		die(_("empty path component found in input"));
      	if (!*slash1 && !S_ISDIR(mode) && subtree)
     -		die("Non-directories cannot have subtrees");
    -+		die(_("Non-directories cannot have subtrees"));
    ++		die(_("non-directories cannot have subtrees"));
      
      	if (!root->tree)
      		load_tree(root);
    @@ builtin/fast-import.c: static int tree_content_get(
      	n = slash1 - p;
      	if (!n && !allow_root)
     -		die("Empty path component found in input");
    -+		die(_("Empty path component found in input"));
    ++		die(_("empty path component found in input"));
      
      	if (!root->tree)
      		load_tree(root);
    @@ builtin/fast-import.c: static int update_branch(struct branch *b)
      		if (!quiet)
     -			warning("Dropping %s since it would point to "
     -				"itself (i.e. to %s)",
    -+			warning(_("Dropping %s since it would point to "
    ++			warning(_("dropping %s since it would point to "
     +				  "itself (i.e. to %s)"),
      				b->name, oid_to_hex(&b->oid));
      		refs_delete_ref(get_main_ref_store(the_repository),
    @@ builtin/fast-import.c: static int update_branch(struct branch *b)
      							  &b->oid, 0);
      		if (!old_cmit || !new_cmit)
     -			return error("Branch %s is missing commits.", b->name);
    -+			return error(_("Branch %s is missing commits."), b->name);
    ++			return error(_("branch %s is missing commits."), b->name);
      
      		ret = repo_in_merge_bases(the_repository, old_cmit, new_cmit);
      		if (ret < 0)
    @@ builtin/fast-import.c: static int update_branch(struct branch *b)
      		if (!ret) {
     -			warning("Not updating %s"
     -				" (new tip %s does not contain %s)",
    -+			warning(_("Not updating %s"
    ++			warning(_("not updating %s"
     +				  " (new tip %s does not contain %s)"),
      				b->name, oid_to_hex(&b->oid),
      				oid_to_hex(&old_oid));
    @@ builtin/fast-import.c: static void dump_marks(void)
      
      	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
     -		failure |= error_errno("Unable to write marks file %s",
    -+		failure |= error_errno(_("Unable to write marks file %s"),
    ++		failure |= error_errno(_("unable to write marks file %s"),
      				       export_marks_file);
      		return;
      	}
    @@ builtin/fast-import.c: static void dump_marks(void)
      		int saved_errno = errno;
      		rollback_lock_file(&mark_lock);
     -		failure |= error("Unable to write marks file %s: %s",
    -+		failure |= error(_("Unable to write marks file %s: %s"),
    ++		failure |= error(_("unable to write marks file %s: %s"),
      			export_marks_file, strerror(saved_errno));
      		return;
      	}
    @@ builtin/fast-import.c: static void dump_marks(void)
      	for_each_mark(marks, 0, dump_marks_fn, f);
      	if (commit_lock_file(&mark_lock)) {
     -		failure |= error_errno("Unable to write file %s",
    -+		failure |= error_errno(_("Unable to write file %s"),
    ++		failure |= error_errno(_("unable to write file %s"),
      				       export_marks_file);
      		return;
      	}
    @@ builtin/fast-import.c: static int parse_data(struct strbuf *sb, uintmax_t limit,
      
      	if (!skip_prefix(command_buf.buf, "data ", &data))
     -		die("Expected 'data n' command, found: %s", command_buf.buf);
    -+		die(_("Expected 'data n' command, found: %s"), command_buf.buf);
    ++		die(_("expected 'data n' command, found: %s"), command_buf.buf);
      
      	if (skip_prefix(data, "<<", &data)) {
      		char *term = xstrdup(data);
    @@ builtin/fast-import.c: static char *parse_ident(const char *buf)
      	ltgt = buf + strcspn(buf, "<>");
      	if (*ltgt != '<')
     -		die("Missing < in ident string: %s", buf);
    -+		die(_("Missing < in ident string: %s"), buf);
    ++		die(_("missing < in ident string: %s"), buf);
      	if (ltgt != buf && ltgt[-1] != ' ')
     -		die("Missing space before < in ident string: %s", buf);
    -+		die(_("Missing space before < in ident string: %s"), buf);
    ++		die(_("missing space before < in ident string: %s"), buf);
      	ltgt = ltgt + 1 + strcspn(ltgt + 1, "<>");
      	if (*ltgt != '>')
     -		die("Missing > in ident string: %s", buf);
    -+		die(_("Missing > in ident string: %s"), buf);
    ++		die(_("missing > in ident string: %s"), buf);
      	ltgt++;
      	if (*ltgt != ' ')
     -		die("Missing space after > in ident string: %s", buf);
    -+		die(_("Missing space after > in ident string: %s"), buf);
    ++		die(_("missing space after > in ident string: %s"), buf);
      	ltgt++;
      	name_len = ltgt - buf;
      	strbuf_add(&ident, buf, name_len);
    @@ builtin/fast-import.c: static char *parse_ident(const char *buf)
      	case WHENSPEC_RAW:
      		if (validate_raw_date(ltgt, &ident, 1) < 0)
     -			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
    -+			die(_("Invalid raw date \"%s\" in ident: %s"), ltgt, buf);
    ++			die(_("invalid raw date \"%s\" in ident: %s"), ltgt, buf);
      		break;
      	case WHENSPEC_RAW_PERMISSIVE:
      		if (validate_raw_date(ltgt, &ident, 0) < 0)
     -			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
    -+			die(_("Invalid raw date \"%s\" in ident: %s"), ltgt, buf);
    ++			die(_("invalid raw date \"%s\" in ident: %s"), ltgt, buf);
      		break;
      	case WHENSPEC_RFC2822:
      		if (parse_date(ltgt, &ident) < 0)
     -			die("Invalid rfc2822 date \"%s\" in ident: %s", ltgt, buf);
    -+			die(_("Invalid rfc2822 date \"%s\" in ident: %s"), ltgt, buf);
    ++			die(_("invalid rfc2822 date \"%s\" in ident: %s"), ltgt, buf);
      		break;
      	case WHENSPEC_NOW:
      		if (strcmp("now", ltgt))
     -			die("Date in ident must be 'now': %s", buf);
    -+			die(_("Date in ident must be 'now': %s"), buf);
    ++			die(_("date in ident must be 'now': %s"), buf);
      		datestamp(&ident);
      		break;
      	}
    @@ builtin/fast-import.c: static void construct_path_with_fanout(const char *hex_sh
      	unsigned int i = 0, j = 0;
      	if (fanout >= the_hash_algo->rawsz)
     -		die("Too large fanout (%u)", fanout);
    -+		die(_("Too large fanout (%u)"), fanout);
    ++		die(_("too large fanout (%u)"), fanout);
      	while (fanout) {
      		path[i++] = hex_sha1[j++];
      		path[i++] = hex_sha1[j++];
    @@ builtin/fast-import.c: static uintmax_t do_change_note_fanout(
      			/* Rename fullpath to realpath */
      			if (!tree_content_remove(orig_root, fullpath, &leaf, 0))
     -				die("Failed to remove path %s", fullpath);
    -+				die(_("Failed to remove path %s"), fullpath);
    ++				die(_("failed to remove path %s"), fullpath);
      			tree_content_set(orig_root, realpath,
      				&leaf.versions[1].oid,
      				leaf.versions[1].mode,
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref(const char *p, char **end
      	mark = strtoumax(p, endptr, 10);
      	if (*endptr == p)
     -		die("No value after ':' in mark: %s", command_buf.buf);
    -+		die(_("No value after ':' in mark: %s"), command_buf.buf);
    ++		die(_("no value after ':' in mark: %s"), command_buf.buf);
      	return mark;
      }
      
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_eol(const char *p)
      	mark = parse_mark_ref(p, &end);
      	if (*end != '\0')
     -		die("Garbage after mark: %s", command_buf.buf);
    -+		die(_("Garbage after mark: %s"), command_buf.buf);
    ++		die(_("garbage after mark: %s"), command_buf.buf);
      	return mark;
      }
      
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const char **p)
      	mark = parse_mark_ref(*p, &end);
      	if (*end++ != ' ')
     -		die("Missing space after mark: %s", command_buf.buf);
    -+		die(_("Missing space after mark: %s"), command_buf.buf);
    ++		die(_("missing space after mark: %s"), command_buf.buf);
      	*p = end;
      	return mark;
      }
    @@ builtin/fast-import.c: static void parse_path(struct strbuf *sb, const char *p,
      	if (*p == '"') {
      		if (unquote_c_style(sb, p, endp))
     -			die("Invalid %s: %s", field, command_buf.buf);
    -+			die(_("Invalid %s: %s"), field, command_buf.buf);
    ++			die(_("invalid %s: %s"), field, command_buf.buf);
      		if (strlen(sb->buf) != sb->len)
     -			die("NUL in %s: %s", field, command_buf.buf);
     +			die(_("NUL in %s: %s"), field, command_buf.buf);
    @@ builtin/fast-import.c: static void parse_path_eol(struct strbuf *sb, const char
      	parse_path(sb, p, &end, 1, field);
      	if (*end)
     -		die("Garbage after %s: %s", field, command_buf.buf);
    -+		die(_("Garbage after %s: %s"), field, command_buf.buf);
    ++		die(_("garbage after %s: %s"), field, command_buf.buf);
      }
      
      /*
    @@ builtin/fast-import.c: static void parse_path_space(struct strbuf *sb, const cha
      	parse_path(sb, p, endp, 0, field);
      	if (**endp != ' ')
     -		die("Missing space after %s: %s", field, command_buf.buf);
    -+		die(_("Missing space after %s: %s"), field, command_buf.buf);
    ++		die(_("missing space after %s: %s"), field, command_buf.buf);
      	(*endp)++;
      }
      
    @@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b
      	p = parse_mode(p, &mode);
      	if (!p)
     -		die("Corrupt mode: %s", command_buf.buf);
    -+		die(_("Corrupt mode: %s"), command_buf.buf);
    ++		die(_("corrupt mode: %s"), command_buf.buf);
      	switch (mode) {
      	case 0644:
      	case 0755:
    @@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b
      		break;
      	default:
     -		die("Corrupt mode: %s", command_buf.buf);
    -+		die(_("Corrupt mode: %s"), command_buf.buf);
    ++		die(_("corrupt mode: %s"), command_buf.buf);
      	}
      
      	if (*p == ':') {
    @@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b
      	} else {
      		if (parse_mapped_oid_hex(p, &oid, &p))
     -			die("Invalid dataref: %s", command_buf.buf);
    -+			die(_("Invalid dataref: %s"), command_buf.buf);
    ++			die(_("invalid dataref: %s"), command_buf.buf);
      		oe = find_object(&oid);
      		if (*p++ != ' ')
     -			die("Missing space after SHA1: %s", command_buf.buf);
    -+			die(_("Missing space after SHA1: %s"), command_buf.buf);
    ++			die(_("missing space after SHA1: %s"), command_buf.buf);
      	}
      
      	strbuf_reset(&path);
    @@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b
      		else if (oe) {
      			if (oe->type != OBJ_COMMIT)
     -				die("Not a commit (actually a %s): %s",
    -+				die(_("Not a commit (actually a %s): %s"),
    ++				die(_("not a commit (actually a %s): %s"),
      					type_name(oe->type), command_buf.buf);
      		}
      		/*
    @@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b
      	} else if (inline_data) {
      		if (S_ISDIR(mode))
     -			die("Directories cannot be specified 'inline': %s",
    -+			die(_("Directories cannot be specified 'inline': %s"),
    ++			die(_("directories cannot be specified 'inline': %s"),
      				command_buf.buf);
      		while (read_next_command() != EOF) {
      			const char *v;
    @@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b
     -					S_ISDIR(mode) ?  "Tree" : "Blob",
     -					command_buf.buf);
     +			die(_("%s not found: %s"),
    -+			    S_ISDIR(mode) ?  _("Tree") : _("Blob"),
    ++			    S_ISDIR(mode) ?  _("tree") : _("blob"),
     +			    command_buf.buf);
      		if (type != expected)
     -			die("Not a %s (actually a %s): %s",
    -+			die(_("Not a %s (actually a %s): %s"),
    ++			die(_("not a %s (actually a %s): %s"),
      				type_name(expected), type_name(type),
      				command_buf.buf);
      	}
    @@ builtin/fast-import.c: static void file_change_cr(const char *p, struct branch *
      		tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
      	if (!leaf.versions[1].mode)
     -		die("Path %s not in branch", source.buf);
    -+		die(_("Path %s not in branch"), source.buf);
    ++		die(_("path %s not in branch"), source.buf);
      	if (!*dest.buf) {	/* C "path/to/subdir" "" */
      		tree_content_replace(&b->branch_tree,
      			&leaf.versions[1].oid,
    @@ builtin/fast-import.c: static void note_change_n(const char *p, struct branch *b
      	} else {
      		if (parse_mapped_oid_hex(p, &oid, &p))
     -			die("Invalid dataref: %s", command_buf.buf);
    -+			die(_("Invalid dataref: %s"), command_buf.buf);
    ++			die(_("invalid dataref: %s"), command_buf.buf);
      		oe = find_object(&oid);
      		if (*p++ != ' ')
     -			die("Missing space after SHA1: %s", command_buf.buf);
    -+			die(_("Missing space after SHA1: %s"), command_buf.buf);
    ++			die(_("missing space after SHA1: %s"), command_buf.buf);
      	}
      
      	/* <commit-ish> */
    @@ builtin/fast-import.c: static void note_change_n(const char *p, struct branch *b
      	if (s) {
      		if (is_null_oid(&s->oid))
     -			die("Can't add a note on empty branch.");
    -+			die(_("Can't add a note on empty branch."));
    ++			die(_("can't add a note on empty branch."));
      		oidcpy(&commit_oid, &s->oid);
      	} else if (*p == ':') {
      		uintmax_t commit_mark = parse_mark_ref_eol(p);
      		struct object_entry *commit_oe = find_mark(marks, commit_mark);
      		if (commit_oe->type != OBJ_COMMIT)
     -			die("Mark :%" PRIuMAX " not a commit", commit_mark);
    -+			die(_("Mark :%" PRIuMAX " not a commit"), commit_mark);
    ++			die(_("mark :%" PRIuMAX " not a commit"), commit_mark);
      		oidcpy(&commit_oid, &commit_oe->idx.oid);
      	} else if (!repo_get_oid(the_repository, p, &commit_oid)) {
      		unsigned long size;
    @@ builtin/fast-import.c: static void note_change_n(const char *p, struct branch *b
      						   &commit_oid);
      		if (!buf || size < the_hash_algo->hexsz + 6)
     -			die("Not a valid commit: %s", p);
    -+			die(_("Not a valid commit: %s"), p);
    ++			die(_("not a valid commit: %s"), p);
      		free(buf);
      	} else
     -		die("Invalid ref name or SHA1 expression: %s", p);
    -+		die(_("Invalid ref name or SHA1 expression: %s"), p);
    ++		die(_("invalid ref name or SHA1 expression: %s"), p);
      
      	if (inline_data) {
      		read_next_command();
    @@ builtin/fast-import.c: static void note_change_n(const char *p, struct branch *b
      	} else if (oe) {
      		if (oe->type != OBJ_BLOB)
     -			die("Not a blob (actually a %s): %s",
    -+			die(_("Not a blob (actually a %s): %s"),
    ++			die(_("not a blob (actually a %s): %s"),
      				type_name(oe->type), command_buf.buf);
      	} else if (!is_null_oid(&oid)) {
      		enum object_type type = odb_read_object_info(the_repository->objects, &oid,
      							NULL);
      		if (type < 0)
     -			die("Blob not found: %s", command_buf.buf);
    -+			die(_("Blob not found: %s"), command_buf.buf);
    ++			die(_("blob not found: %s"), command_buf.buf);
      		if (type != OBJ_BLOB)
     -			die("Not a blob (actually a %s): %s",
    -+			die(_("Not a blob (actually a %s): %s"),
    ++			die(_("not a blob (actually a %s): %s"),
      			    type_name(type), command_buf.buf);
      	}
      
    @@ builtin/fast-import.c: static void file_change_deleteall(struct branch *b)
      {
      	if (!buf || size < the_hash_algo->hexsz + 6)
     -		die("Not a valid commit: %s", oid_to_hex(&b->oid));
    -+		die(_("Not a valid commit: %s"), oid_to_hex(&b->oid));
    ++		die(_("not a valid commit: %s"), oid_to_hex(&b->oid));
      	if (memcmp("tree ", buf, 5)
      		|| get_oid_hex(buf + 5, &b->branch_tree.versions[1].oid))
     -		die("The commit %s is corrupt", oid_to_hex(&b->oid));
    -+		die(_("The commit %s is corrupt"), oid_to_hex(&b->oid));
    ++		die(_("the commit %s is corrupt"), oid_to_hex(&b->oid));
      	oidcpy(&b->branch_tree.versions[0].oid,
      	       &b->branch_tree.versions[1].oid);
      }
    @@ builtin/fast-import.c: static int parse_objectish(struct branch *b, const char *
      	s = lookup_branch(objectish);
      	if (b == s)
     -		die("Can't create a branch from itself: %s", b->name);
    -+		die(_("Can't create a branch from itself: %s"), b->name);
    ++		die(_("can't create a branch from itself: %s"), b->name);
      	else if (s) {
      		struct object_id *t = &s->branch_tree.versions[1].oid;
      		oidcpy(&b->oid, &s->oid);
    @@ builtin/fast-import.c: static int parse_objectish(struct branch *b, const char *
      		struct object_entry *oe = find_mark(marks, idnum);
      		if (oe->type != OBJ_COMMIT)
     -			die("Mark :%" PRIuMAX " not a commit", idnum);
    -+			die(_("Mark :%" PRIuMAX " not a commit"), idnum);
    ++			die(_("mark :%" PRIuMAX " not a commit"), idnum);
      		if (!oideq(&b->oid, &oe->idx.oid)) {
      			oidcpy(&b->oid, &oe->idx.oid);
      			if (oe->pack_id != MAX_PACK_ID) {
    @@ builtin/fast-import.c: static int parse_objectish(struct branch *b, const char *
      	}
      	else
     -		die("Invalid ref name or SHA1 expression: %s", objectish);
    -+		die(_("Invalid ref name or SHA1 expression: %s"), objectish);
    ++		die(_("invalid ref name or SHA1 expression: %s"), objectish);
      
      	if (b->branch_tree.tree && !oideq(&oid, &b->branch_tree.versions[1].oid)) {
      		release_tree_content_recursive(b->branch_tree.tree);
    @@ builtin/fast-import.c: static struct hash_list *parse_merge(unsigned int *count)
      			struct object_entry *oe = find_mark(marks, idnum);
      			if (oe->type != OBJ_COMMIT)
     -				die("Mark :%" PRIuMAX " not a commit", idnum);
    -+				die(_("Mark :%" PRIuMAX " not a commit"), idnum);
    ++				die(_("mark :%" PRIuMAX " not a commit"), idnum);
      			oidcpy(&n->oid, &oe->idx.oid);
      		} else if (!repo_get_oid(the_repository, from, &n->oid)) {
      			unsigned long size;
    @@ builtin/fast-import.c: static struct hash_list *parse_merge(unsigned int *count)
      							   &size, &n->oid);
      			if (!buf || size < the_hash_algo->hexsz + 6)
     -				die("Not a valid commit: %s", from);
    -+				die(_("Not a valid commit: %s"), from);
    ++				die(_("not a valid commit: %s"), from);
      			free(buf);
      		} else
     -			die("Invalid ref name or SHA1 expression: %s", from);
    -+			die(_("Invalid ref name or SHA1 expression: %s"), from);
    ++			die(_("invalid ref name or SHA1 expression: %s"), from);
      
      		n->next = NULL;
      		*tail = n;
    @@ builtin/fast-import.c: static void parse_one_signature(struct signature_data *si
      	if (!space)
     -		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
     -		    "got 'gpgsig %s'", args);
    -+		die(_("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
    ++		die(_("expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
     +		      "got 'gpgsig %s'"), args);
      	*space = '\0';
      
    @@ builtin/fast-import.c: static void parse_one_signature(struct signature_data *si
      	if (strcmp(sig->hash_algo, "sha1") &&
      	    strcmp(sig->hash_algo, "sha256"))
     -		die("Unknown git hash algorithm in gpgsig: '%s'", sig->hash_algo);
    -+		die(_("Unknown git hash algorithm in gpgsig: '%s'"), sig->hash_algo);
    ++		die(_("unknown git hash algorithm in gpgsig: '%s'"), sig->hash_algo);
      
      	/* Validate signature format */
      	if (!valid_signature_format(sig->sig_format))
     -		die("Invalid signature format in gpgsig: '%s'", sig->sig_format);
    -+		die(_("Invalid signature format in gpgsig: '%s'"), sig->sig_format);
    ++		die(_("invalid signature format in gpgsig: '%s'"), sig->sig_format);
      	if (!strcmp(sig->sig_format, "unknown"))
     -		warning("'unknown' signature format in gpgsig");
     +		warning(_("'unknown' signature format in gpgsig"));
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      	}
      	if (!committer)
     -		die("Expected committer but didn't get one");
    -+		die(_("Expected committer but didn't get one"));
    ++		die(_("expected committer but didn't get one"));
      
      	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
      		switch (signed_commit_mode) {
    @@ builtin/fast-import.c: static void parse_new_tag(const char *arg)
      	/* from ... */
      	if (!skip_prefix(command_buf.buf, "from ", &from))
     -		die("Expected from command, got %s", command_buf.buf);
    -+		die(_("Expected 'from' command, got '%s'"), command_buf.buf);
    ++		die(_("expected 'from' command, got '%s'"), command_buf.buf);
      	s = lookup_branch(from);
      	if (s) {
      		if (is_null_oid(&s->oid))
     -			die("Can't tag an empty branch.");
    -+			die(_("Can't tag an empty branch."));
    ++			die(_("can't tag an empty branch."));
      		oidcpy(&oid, &s->oid);
      		type = OBJ_COMMIT;
      	} else if (*from == ':') {
    @@ builtin/fast-import.c: static void parse_new_tag(const char *arg)
      						    &oid, NULL);
      			if (type < 0)
     -				die("Not a valid object: %s", from);
    -+				die(_("Not a valid object: %s"), from);
    ++				die(_("not a valid object: %s"), from);
      		} else
      			type = oe->type;
      	} else
     -		die("Invalid ref name or SHA1 expression: %s", from);
    -+		die(_("Invalid ref name or SHA1 expression: %s"), from);
    ++		die(_("invalid ref name or SHA1 expression: %s"), from);
      	read_next_command();
      
      	/* original-oid ... */
    @@ builtin/fast-import.c: static void parse_reset_branch(const char *arg)
      {
      	if (write_in_full(cat_blob_fd, buf, size) < 0)
     -		die_errno("Write to frontend failed");
    -+		die_errno(_("Write to frontend failed"));
    ++		die_errno(_("write to frontend failed"));
      }
      
      static void cat_blob(struct object_entry *oe, struct object_id *oid)
    @@ builtin/fast-import.c: static void cat_blob(struct object_entry *oe, struct obje
      	}
      	if (!buf)
     -		die("Can't read object %s", oid_to_hex(oid));
    -+		die(_("Can't read object %s"), oid_to_hex(oid));
    ++		die(_("can't read object %s"), oid_to_hex(oid));
      	if (type != OBJ_BLOB)
     -		die("Object %s is a %s but a blob was expected.",
    -+		die(_("Object %s is a %s but a blob was expected."),
    ++		die(_("object %s is a %s but a blob was expected."),
      		    oid_to_hex(oid), type_name(type));
      	strbuf_reset(&line);
      	strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
    @@ builtin/fast-import.c: static void parse_get_mark(const char *p)
      	/* get-mark SP <object> LF */
      	if (*p != ':')
     -		die("Not a mark: %s", p);
    -+		die(_("Not a mark: %s"), p);
    ++		die(_("not a mark: %s"), p);
      
      	oe = find_mark(marks, parse_mark_ref_eol(p));
      	if (!oe)
     -		die("Unknown mark: %s", command_buf.buf);
    -+		die(_("Unknown mark: %s"), command_buf.buf);
    ++		die(_("unknown mark: %s"), command_buf.buf);
      
      	xsnprintf(output, sizeof(output), "%s\n", oid_to_hex(&oe->idx.oid));
      	cat_blob_write(output, the_hash_algo->hexsz + 1);
    @@ builtin/fast-import.c: static void parse_cat_blob(const char *p)
      		oe = find_mark(marks, parse_mark_ref_eol(p));
      		if (!oe)
     -			die("Unknown mark: %s", command_buf.buf);
    -+			die(_("Unknown mark: %s"), command_buf.buf);
    ++			die(_("unknown mark: %s"), command_buf.buf);
      		oidcpy(&oid, &oe->idx.oid);
      	} else {
      		if (parse_mapped_oid_hex(p, &oid, &p))
     -			die("Invalid dataref: %s", command_buf.buf);
    -+			die(_("Invalid dataref: %s"), command_buf.buf);
    ++			die(_("invalid dataref: %s"), command_buf.buf);
      		if (*p)
     -			die("Garbage after SHA1: %s", command_buf.buf);
    -+			die(_("Garbage after SHA1: %s"), command_buf.buf);
    ++			die(_("garbage after SHA1: %s"), command_buf.buf);
      		oe = find_object(&oid);
      	}
      
    @@ builtin/fast-import.c: static struct object_entry *dereference(struct object_ent
      		break;
      	default:
     -		die("Not a tree-ish: %s", command_buf.buf);
    -+		die(_("Not a tree-ish: %s"), command_buf.buf);
    ++		die(_("not a tree-ish: %s"), command_buf.buf);
      	}
      
      	if (oe->pack_id != MAX_PACK_ID) {	/* in a pack being written */
    @@ builtin/fast-import.c: static struct object_entry *dereference(struct object_ent
      	}
      	if (!buf)
     -		die("Can't load object %s", oid_to_hex(oid));
    -+		die(_("Can't load object %s"), oid_to_hex(oid));
    ++		die(_("can't load object %s"), oid_to_hex(oid));
      
      	/* Peel one layer. */
      	switch (oe->type) {
    @@ builtin/fast-import.c: static struct object_entry *dereference(struct object_ent
      		if (size < hexsz + strlen("object ") ||
      		    get_oid_hex(buf + strlen("object "), oid))
     -			die("Invalid SHA1 in tag: %s", command_buf.buf);
    -+			die(_("Invalid SHA1 in tag: %s"), command_buf.buf);
    ++			die(_("invalid SHA1 in tag: %s"), command_buf.buf);
      		break;
      	case OBJ_COMMIT:
      		if (size < hexsz + strlen("tree ") ||
      		    get_oid_hex(buf + strlen("tree "), oid))
     -			die("Invalid SHA1 in commit: %s", command_buf.buf);
    -+			die(_("Invalid SHA1 in commit: %s"), command_buf.buf);
    ++			die(_("invalid SHA1 in commit: %s"), command_buf.buf);
      	}
      
      	free(buf);
    +@@ builtin/fast-import.c: static void build_mark_map(struct string_list *from, struct string_list *to)
    + 	for_each_string_list_item(fromp, from) {
    + 		top = string_list_lookup(to, fromp->string);
    + 		if (!fromp->util) {
    +-			die(_("Missing from marks for submodule '%s'"), fromp->string);
    ++			die(_("missing from marks for submodule '%s'"), fromp->string);
    + 		} else if (!top || !top->util) {
    +-			die(_("Missing to marks for submodule '%s'"), fromp->string);
    ++			die(_("missing to marks for submodule '%s'"), fromp->string);
    + 		}
    + 		build_mark_map_one(fromp->util, top->util);
    + 	}
     @@ builtin/fast-import.c: static struct object_entry *parse_treeish_dataref(const char **p)
      	if (**p == ':') {	/* <mark> */
      		e = find_mark(marks, parse_mark_ref_space(p));
      		if (!e)
     -			die("Unknown mark: %s", command_buf.buf);
    -+			die(_("Unknown mark: %s"), command_buf.buf);
    ++			die(_("unknown mark: %s"), command_buf.buf);
      		oidcpy(&oid, &e->idx.oid);
      	} else {	/* <sha1> */
      		if (parse_mapped_oid_hex(*p, &oid, p))
     -			die("Invalid dataref: %s", command_buf.buf);
    -+			die(_("Invalid dataref: %s"), command_buf.buf);
    ++			die(_("invalid dataref: %s"), command_buf.buf);
      		e = find_object(&oid);
      		if (*(*p)++ != ' ')
     -			die("Missing space after tree-ish: %s", command_buf.buf);
    -+			die(_("Missing space after tree-ish: %s"), command_buf.buf);
    ++			die(_("missing space after tree-ish: %s"), command_buf.buf);
      	}
      
      	while (!e || e->type != OBJ_TREE)
    @@ builtin/fast-import.c: static void parse_ls(const char *p, struct branch *b)
      	if (*p == '"') {
      		if (!b)
     -			die("Not in a commit: %s", command_buf.buf);
    -+			die(_("Not in a commit: %s"), command_buf.buf);
    ++			die(_("not in a commit: %s"), command_buf.buf);
      		root = &b->branch_tree;
      	} else {
      		struct object_entry *e = parse_treeish_dataref(&p);
    +@@ builtin/fast-import.c: static void parse_alias(void)
    + 	/* mark ... */
    + 	parse_mark();
    + 	if (!next_mark)
    +-		die(_("Expected 'mark' command, got %s"), command_buf.buf);
    ++		die(_("expected 'mark' command, got %s"), command_buf.buf);
    + 
    + 	/* to ... */
    + 	memset(&b, 0, sizeof(b));
    + 	if (!parse_objectish_with_prefix(&b, "to "))
    +-		die(_("Expected 'to' command, got %s"), command_buf.buf);
    ++		die(_("expected 'to' command, got %s"), command_buf.buf);
    + 	e = find_object(&b.oid);
    + 	assert(e);
    + 	insert_mark(&marks, next_mark, e);
     @@ builtin/fast-import.c: static void option_import_marks(const char *marks,
      {
      	if (import_marks_file) {
      		if (from_stream)
     -			die("Only one import-marks command allowed per stream");
    -+			die(_("Only one import-marks command allowed per stream"));
    ++			die(_("only one import-marks command allowed per stream"));
      
      		/* read previous mark file */
      		if(!import_marks_file_from_stream)
    @@ builtin/fast-import.c: static void option_cat_blob_fd(const char *fd)
      	cat_blob_fd = (int) n;
      }
      
    +@@ builtin/fast-import.c: static void option_rewrite_submodules(const char *arg, struct string_list *list)
    + 	char *s = xstrdup(arg);
    + 	char *f = strchr(s, ':');
    + 	if (!f)
    +-		die(_("Expected format name:filename for submodule rewrite option"));
    ++		die(_("expected format name:filename for submodule rewrite option"));
    + 	*f = '\0';
    + 	f++;
    + 	CALLOC_ARRAY(ms, 1);
     @@ builtin/fast-import.c: static void option_rewrite_submodules(const char *arg, struct string_list *list)
      	f = prefix_filename(global_prefix, f);
      	fp = fopen(f, "r");
    @@ builtin/fast-import.c: static int parse_one_feature(const char *feature, int fro
      {
      	if (seen_data_command)
     -		die("Got feature command '%s' after data command", feature);
    -+		die(_("Got feature command '%s' after data command"), feature);
    ++		die(_("got feature command '%s' after data command"), feature);
      
      	if (parse_one_feature(feature, 1))
      		return;
      
     -	die("This version of fast-import does not support feature %s.", feature);
    -+	die(_("This version of fast-import does not support feature %s."), feature);
    ++	die(_("this version of fast-import does not support feature %s."), feature);
      }
      
      static void parse_option(const char *option)
      {
      	if (seen_data_command)
     -		die("Got option command '%s' after data command", option);
    -+		die(_("Got option command '%s' after data command"), option);
    ++		die(_("got option command '%s' after data command"), option);
      
      	if (parse_one_option(option))
      		return;
      
     -	die("This version of fast-import does not support option: %s", option);
    -+	die(_("This version of fast-import does not support option: %s"), option);
    ++	die(_("this version of fast-import does not support option: %s"), option);
      }
      
      static void git_pack_config(void)
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
      			/* ignore non-git options*/;
      		else
     -			die("Unsupported command: %s", command_buf.buf);
    -+			die(_("Unsupported command: %s"), command_buf.buf);
    ++			die(_("unsupported command: %s"), command_buf.buf);
      
      		if (checkpoint_requested)
      			checkpoint();
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
      
      	end_packfile();
      
    +
    + ## t/t9300-fast-import.sh ##
    +@@ t/t9300-fast-import.sh: test_expect_success 'R: blob appears only once' '
    + # The error message when a space is missing not at the
    + # end of the line is:
    + #
    +-#   Missing space after ..
    ++#   missing space after ..
    + #
    + # or when extra characters come after the mark at the end
    + # of the line:
    + #
    +-#   Garbage after ..
    ++#   garbage after ..
    + #
    + # or when the dataref is neither "inline " or a known SHA1,
    + #
    +-#   Invalid dataref ..
    ++#   invalid dataref ..
    + #
    + test_expect_success 'S: initialize for S tests' '
    + 	test_tick &&
    +@@ t/t9300-fast-import.sh: test_path_fail () {
    + 
    + test_path_base_fail () {
    + 	local change="$1" prefix="$2" field="$3" suffix="$4"
    +-	test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"hello.c'    "$suffix" "Invalid $field"
    +-	test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"hello\xff"' "$suffix" "Invalid $field"
    ++	test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"hello.c'    "$suffix" "invalid $field"
    ++	test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"hello\xff"' "$suffix" "invalid $field"
    + 	test_path_fail "$change" "escaped NUL in quoted $field"    "$prefix" '"hello\000"' "$suffix" "NUL in $field"
    + }
    + test_path_eol_quoted_fail () {
    + 	local change="$1" prefix="$2" field="$3"
    + 	test_path_base_fail "$change" "$prefix" "$field" ''
    +-	test_path_fail "$change" "garbage after quoted $field" "$prefix" '"hello.c"' 'x' "Garbage after $field"
    +-	test_path_fail "$change" "space after quoted $field"   "$prefix" '"hello.c"' ' ' "Garbage after $field"
    ++	test_path_fail "$change" "garbage after quoted $field" "$prefix" '"hello.c"' 'x' "garbage after $field"
    ++	test_path_fail "$change" "space after quoted $field"   "$prefix" '"hello.c"' ' ' "garbage after $field"
    + }
    + test_path_eol_fail () {
    + 	local change="$1" prefix="$2" field="$3"
    +@@ t/t9300-fast-import.sh: test_path_eol_fail () {
    + test_path_space_fail () {
    + 	local change="$1" prefix="$2" field="$3"
    + 	test_path_base_fail "$change" "$prefix" "$field" ' world.c'
    +-	test_path_fail "$change" "missing space after quoted $field"   "$prefix" '"hello.c"' 'x world.c' "Missing space after $field"
    +-	test_path_fail "$change" "missing space after unquoted $field" "$prefix" 'hello.c'   ''          "Missing space after $field"
    ++	test_path_fail "$change" "missing space after quoted $field"   "$prefix" '"hello.c"' 'x world.c' "missing space after $field"
    ++	test_path_fail "$change" "missing space after unquoted $field" "$prefix" 'hello.c'   ''          "missing space after $field"
    + }
    + 
    + test_path_eol_fail   filemodify       'M 100644 :1 ' path
    +@@ t/t9300-fast-import.sh: test_expect_success 'X: replace ref that becomes useless is removed' '
    + 		sed -e s/othername/somename/ tmp >tmp2 &&
    + 		git fast-import --force <tmp2 2>msgs &&
    + 
    +-		grep "Dropping.*since it would point to itself" msgs &&
    ++		grep "dropping.*since it would point to itself" msgs &&
    + 		git show-ref >refs &&
    + 		! grep refs/replace refs
    + 	)
5:  4ad31e1014 = 5:  158c13c078 gpg-interface: mark a string for translation


Christian Couder (5):
  gpg-interface: simplify ssh fingerprint parsing
  gpg-interface: use left shift to define GPG_VERIFY_*
  fast-export: mark strings for translation
  fast-import: mark strings for translation
  gpg-interface: mark a string for translation

 builtin/fast-export.c  |  79 ++++++------
 builtin/fast-import.c  | 280 ++++++++++++++++++++---------------------
 gpg-interface.c        |   4 +-
 gpg-interface.h        |   6 +-
 t/t9300-fast-import.sh |  20 +--
 5 files changed, 195 insertions(+), 194 deletions(-)

-- 
2.51.2.617.g2aaa867cd1

