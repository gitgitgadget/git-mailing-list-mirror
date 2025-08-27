Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B278E7E
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308470; cv=none; b=tTZN5vtnIi0XJeK7DB1EUcJuJFwcuOOHdhVWN5UtxofZL2pl4m6ypf8RwvOjYu+GhJsQrhRXUH0N1JvLwsji+518hc5PBXk+orvx2UK36VPimrRTL9Gce0Av2DrhoPvGSgWJN2zUERk+5JTEw2DYlHw8uZq3PaIQ9McuyauuMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308470; c=relaxed/simple;
	bh=OxwzhVB17g5Q/ty95rzVUTVOpF+xqprPQYnxIiTsv00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUfXXnoOIhpA1WsOmrgSijRiG/rifAil8upTvlubsCTEjhY+K3G6h6ljGyIsLZbabbCxV4ZNashmsk3fykwrNl8LAz5/GqX0UbTd9Or4vNEGE3LSZrpSqI6GfYp5FosO8QQaD2K9u3wEU3Bdx9inuFRK+nmXAozCXNMAFvMmmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYA9diWo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYA9diWo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b4d892175so35644615e9.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308466; x=1756913266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7JS7S3oKN4J4sfjfXqaFrHx6BPQGyMti2oDI41XtAng=;
        b=IYA9diWoisS8fkNe8EycTGjs3IaSoYEAeL/wRtDZw8KFrcvpkL0U4TmJxhDHaOiB3O
         wGbeXXRhyi01mKZ91Q+fwfE+QsFgjTypUpizreiY9fINMF1Md1TS8enJBaWXxR0HXSi6
         ntDPNoM0tKtl3aXdNfAEMS3B4OSyndWKfgjm6HaXl8VZghGwiqUY8scpPpbT4GqR9jDs
         zNgYDGokYZdlUfL83gKEc5X9wTt/PeIC9/9SFn8DUfG6x8E0ir5buVOfcGSblV0pVfcB
         2p2TK75wYxIcGKedJHbx0qGXQxBOs3jemhaKlVnwq3jhYDKTLHWkI2KepOS31Rsi0ZxE
         N2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308466; x=1756913266;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JS7S3oKN4J4sfjfXqaFrHx6BPQGyMti2oDI41XtAng=;
        b=BGe1qtLhh1TCnl+t1R9JSdHgd8579MrjWxbCOCqaeBMflClDV1MMMRl1CDjhiQMIFe
         qlfNy7d01j8W6lRVcFZ0qlJ96AuoOYsCvix7popGDf5OYG87PoVjwLjj0Gkjt7+Q+eTl
         9ObWzMlUA1UWHyCOA7VSmPiGkTgZU0apgig17HgQp0yVISmjr3cydG4woOBN4ugGCxZN
         KgLRZRPXco5h03FHZSOC+v54W1Tx7x6iT79yREe09EReu7hMyv6XnkeHfsIaz5qhGs7Y
         f9d5NQSKb/iTTfwVXjoX5zZaFzVLMJtFQCV5mXM5lY6ms16kfQrwofBLEtuauguGkL06
         PNZw==
X-Gm-Message-State: AOJu0YzUYXJ7v3nE0O4bdq8Fk2VRJqx0eAVxErufAGZzDhbrcOBR6aNc
	/Lzh+pNgYoNmzYS9JAuQPAT2/CP2ClLfp9qeVDkKhJ+3pYMBolw2F+hrt74DJg==
X-Gm-Gg: ASbGncv4v0jVClGpr7B4c8GnZS+eWkrMkzrJjqiKNvC79hBZq8uv0lSmkIqHJInZypW
	ssa+klkO5hIEZbbpHr4+eYHTmIJZTdZj9BTsaVbCmtI0VxfkN7TpR7StDzHZKQXlOl1Q+NVxaTa
	qOvUYLSvBYqCiIlXFumIIQz9KK/CENFsFtFlod+yD+mVQWCh8wiE+n6BNSS3J0U4MYBsBPYZlIT
	QTq1XGxLcSAotWWf6FbZScCIyNFB+iCNPJA0cKXL6JXbtJd8hEEUW28jX7S3dnFwV2v3mERQUiG
	WChmYz5fnS3igJXPgapE8K/dL54SjrlftDf55plm8b35elWfkUwL30ug6WI7D2/ITPAnQq33Zch
	EDXlpseaWRVCZ6bERDyglFAD8DKMAsry+IqqcbxOtsSI7Cg==
X-Google-Smtp-Source: AGHT+IGGJL9+dz5ffa6nsEhA4TfPnqYVp4nBRO9chmETa/1xulSER8bO+S+BiYzS30CjbbCxMmS0gg==
X-Received: by 2002:a05:6000:400e:b0:3bf:2c26:eb73 with SMTP id ffacd0b85a97d-3c5dac1a04cmr14568651f8f.17.1756308466191;
        Wed, 27 Aug 2025 08:27:46 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211bd7sm21511597f8f.38.2025.08.27.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:27:45 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 1/3] breaking-changes: deprecate support for core.commentString=auto
Date: Wed, 27 Aug 2025 16:27:28 +0100
Message-ID: <5b921064f1e6c06ec2c150b1cce9d2b2b87a74a1.1756308431.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308431.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk> <cover.1756308431.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When "core.commentString" is set to "auto" then "git commit" will
automatically select the comment character ensuring that it is not the
first character on any of the lines in the commit message. This was
introduced by commit 84c9dc2c5a2 (commit: allow core.commentChar=auto
for character auto selection, 2014-05-17). The motivation seems to be
to avoid commenting out lines from the existing message when amending
a commit that was created with a message from a file.

Unfortunately this feature does not work with:

 * commit message templates that contain comments.

 * prepare-commit-msg hooks that introduce comments.

 * "git commit --cleanup=strip --edit -F <file>" which means that it
   is incompatible with

   - the "fixup" and "squash" commands of "git rebase -i" as the
     comments added by those commands are then treated as part of
     the commit message.

   - the conflict comments added to the commit message by "git
     cherry-pick", "git rebase" etc. as these comments are then
     treated as part of the commit message.

It is also ignored by "git notes" when amending a note.

The issues with comments coming from a template, hook or file are a
consequence of the design of this feature and are therefore hard to
fix.

As the costs of this feature outweigh the benefits, deprecate it and
remove it in Git 3.0. If someone comes up with some patches that fix
all the issues in a maintainable way then I'd be happy to see this
change reverted.

The next commits will add a warning and some advice for users on how
they can update their config settings.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/BreakingChanges.adoc |  5 +++++
 Documentation/config/core.adoc     | 20 ++++++++++++++++++--
 builtin/commit.c                   |  4 ++++
 environment.c                      | 10 ++++++++--
 environment.h                      |  2 ++
 t/t3404-rebase-interactive.sh      |  2 +-
 t/t3418-rebase-continue.sh         |  2 +-
 t/t7502-commit-porcelain.sh        |  4 ++--
 8 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..344ce500603 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -239,6 +239,11 @@ These features will be removed.
 +
 The command will be removed.
 
+* Support for `core.commentString=auto` has been deprecated and will
+  be removed in Git 3.0.
++
+cf. <xmqqa59i45wc.fsf@gitster.g>
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 9fde1ab63a7..7133f00c38b 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -531,9 +531,25 @@ core.commentString::
 	commented, and removes them after the editor returns
 	(default '#').
 +
-If set to "auto", `git-commit` would select a character that is not
+ifndef::with-breaking-changes[]
+If set to "auto", `git-commit` will select a character that is not
 the beginning character of any line in existing commit messages.
-+
+Support for this value is deprecated and will be removed in Git 3.0
+due to the following limitations:
++
+--
+* It is incompatible with adding comments in a commit message
+  template. This includes the conflicts comments added to
+  the commit message by `cherry-pick`, `merge`, `rebase` and
+  `revert`.
+* It is incompatible with adding comments to the commit message
+  in the `prepare-commit-msg` hook.
+* It is incompatible with the `fixup` and `squash` commands when
+  rebasing,
+* It is not respected by `git notes`
+--
++
+endif::with-breaking-changes[]
 Note that these two variables are aliases of each other, and in modern
 versions of Git you are free to use a string (e.g., `//` or `⁑⁕⁑`) with
 `commentChar`. Versions of Git prior to v2.45.0 will ignore
diff --git a/builtin/commit.c b/builtin/commit.c
index 757f51eac82..d25cc07a355 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -683,6 +683,7 @@ static int author_date_is_interesting(void)
 	return author_message || force_date;
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static void adjust_comment_line_char(const struct strbuf *sb)
 {
 	char candidates[] = "#;@!$%^&|:";
@@ -720,6 +721,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	free(comment_line_str_to_free);
 	comment_line_str = comment_line_str_to_free = xstrfmt("%c", *p);
 }
+#endif /* !WITH_BREAKING_CHANGES */
 
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 				struct pretty_print_context *ctx)
@@ -916,8 +918,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
 
+#ifndef WITH_BREAKING_CHANGES
 	if (auto_comment_line_char)
 		adjust_comment_line_char(&sb);
+#endif /* !WITH_BREAKING_CHANGES */
 	strbuf_release(&sb);
 
 	/* This checks if committer ident is explicitly given */
diff --git a/environment.c b/environment.c
index a0ac5934b37..4c87876d483 100644
--- a/environment.c
+++ b/environment.c
@@ -122,7 +122,9 @@ int protect_ntfs = PROTECT_NTFS_DEFAULT;
  */
 const char *comment_line_str = "#";
 char *comment_line_str_to_free;
+#ifndef WITH_BREAKING_CHANGES
 int auto_comment_line_char;
+#endif /* !WITH_BREAKING_CHANGES */
 
 /* This is set by setup_git_directory_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
@@ -459,18 +461,22 @@ static int git_default_core_config(const char *var, const char *value,
 
 	if (!strcmp(var, "core.commentchar") ||
 	    !strcmp(var, "core.commentstring")) {
-		if (!value)
+		if (!value) {
 			return config_error_nonbool(var);
-		else if (!strcasecmp(value, "auto")) {
+#ifndef WITH_BREAKING_CHANGES
+		} else if (!strcasecmp(value, "auto")) {
 			auto_comment_line_char = 1;
 			FREE_AND_NULL(comment_line_str_to_free);
 			comment_line_str = "#";
+#endif /* !WITH_BREAKING_CHANGES */
 		} else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
 			comment_line_str = value;
 			FREE_AND_NULL(comment_line_str_to_free);
+#ifndef WITH_BREAKING_CHANGES
 			auto_comment_line_char = 0;
+#endif /* !WITH_BREAKING_CHANGES */
 		} else
 			return error(_("%s must have at least one character"), var);
 		return 0;
diff --git a/environment.h b/environment.h
index 8cfce41015b..e75c4abb388 100644
--- a/environment.h
+++ b/environment.h
@@ -208,7 +208,9 @@ extern char *excludes_file;
  */
 extern const char *comment_line_str;
 extern char *comment_line_str_to_free;
+#ifndef WITH_BREAKING_CHANGES
 extern int auto_comment_line_char;
+#endif /* !WITH_BREAKING_CHANGES */
 
 # endif /* USE_THE_REPOSITORY_VARIABLE */
 #endif /* ENVIRONMENT_H */
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6bac217ed35..ce0aebb9a7e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1176,7 +1176,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-test_expect_success 'rebase -i respects core.commentchar=auto' '
+test_expect_success !WITH_BREAKING_CHANGES 'rebase -i respects core.commentchar=auto' '
 	test_config core.commentchar auto &&
 	write_script copy-edit-script.sh <<-\EOF &&
 	cp "$1" edit-script
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index b8a8dd77e74..f9b8999db50 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -328,7 +328,7 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
-test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
+test_expect_success !WITH_BREAKING_CHANGES 'no change in comment character due to conflicts markers with core.commentChar=auto' '
 	git checkout -b branch-a &&
 	test_commit A F1 &&
 	git checkout -b branch-b HEAD^ &&
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b37e2018a74..65b4519a715 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -956,13 +956,13 @@ test_expect_success 'commit --status with custom comment character' '
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
 
-test_expect_success 'switch core.commentchar' '
+test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar' '
 	test_commit "#foo" foo &&
 	GIT_EDITOR=.git/FAKE_EDITOR git -c core.commentChar=auto commit --amend &&
 	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
 
-test_expect_success 'switch core.commentchar but out of options' '
+test_expect_success !WITH_BREAKING_CHANGES 'switch core.commentchar but out of options' '
 	cat >text <<\EOF &&
 # 1
 ; 2
-- 
2.49.0.897.gfad3eb7d210

