Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE772E7F0A
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792777; cv=none; b=Mvczn0ALcJ5msbPGf05qYHean+D++cVi6jGswno1TVUvr23NtnUgvF28YCdkKhQ+w2zhHXk0GuLNHMGIBD72zL0zRfoNC+aNQpimbBlZ07dMnTQWWKoxvGuPTi4+FVzvR1LNUhlhtpN2kGOJkRe7TWmlUruXjmU48Jg+ZrYmZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792777; c=relaxed/simple;
	bh=P+GIHALqDcUTmGSWim4RGJ3a8eBJHwOPx5KMsqGdvhw=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type; b=kNKJi0CBz6IuA15WriAao1xItsS5cwlTs5xnUMQrtr1WNrsJ4hN7fS6hw4Nd/ZbsT1NPzE5z6pECEcUWSyxn4BZpHAbf4lBMSjgKw+eSaCAKJPDF/jbw9PyS7MCR1wlGAJwrrxMEZdDvs63/CYD61YvdvzVPntq0qbk9CoRpjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx0tHAUH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx0tHAUH"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423610ec93so837204b3a.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781792775; x=1782397575; darn=vger.kernel.org;
        h=subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIZUkhk4vt0d/I4F/SPm3ugJgsLI/ZsgToUwwDvmCok=;
        b=gx0tHAUHr+h0AIlSbU8DMqXkL30CQNRpun/KRMkQo2E8OWErbYDTjRVnLD4mfMuqjS
         LYMOXZkhu0MMxnWaCaM7S/qWWkjVdvZAvCGDlFGPnFIe4SiPSrJMxETSH2+NTb2vIake
         h8wnDXwhvc4Fx8sLQJuAeotgr2LsmZo/H3gldLCK23XwGuFqNoBrk9m3P+jP0IDF6VKT
         1rRB0B2aSXidHYJq5Bge9NLfJHkySJ7fsyWlHgh7cVcTUa66A3+e5DkebOS+s1920dPq
         KjEsU5rOJEFvhoKObZTxQbXdpmHIphkZEs9ApG4VqqBtEOJUSdQZRvLcUJXw2tVBgVM+
         uQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781792775; x=1782397575;
        h=subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YIZUkhk4vt0d/I4F/SPm3ugJgsLI/ZsgToUwwDvmCok=;
        b=ffpUjO/7nR5GLdB35w61wNmCbAZwMZGXXJUsrNrf0kcCWKzb8q5cduMXGOjFZZbjWU
         fRgnAmhBQbLfZi3l0Dm4QIiMs580q+0llk1YZla/py1i6pd3P3T/5uQtD9qsM4+uHsqF
         tNAq6oVQiNrSmgMSIGYoeSv9iZGh/RjrZA7OBfuhdFocfRDgbaNDB4mqUnwcQ/8IgY8A
         CYRrItMRaztZzI/aviljPpIRVQ2k852gdV2Zjiu5MMcdh4FHlF1OzEs05F6HtR27GV0c
         LIX//l7Ga8qR5hWw+JScPH8/+qmqoKIHaycflwS0KSr4ahHEbThn9g++YucVD3XFR8MG
         /HbA==
X-Gm-Message-State: AOJu0Ywc3PNmX3yrI0fwuymzpR+XrYXgWNvJqJMJh//JG/NO4y/fgFs0
	36nffMiNjdLDfEDeiT7CMgCQ0ZdGQupr6MAhixKuj/MNG5REFWZi+RyC9lfgrA==
X-Gm-Gg: AfdE7cke6lYVplm+gAp2DoZhz7YnY0ozqMX32gucjNbf1qamhpamHwt5fnNGCzmnWUH
	DpRYleBPq+wFceKI0hQZbPkYL68eSJN2bQqxqhWRxqtX0kesRnQGhVUghWTbEqC5ZH9li+oDfKd
	uXhnPPFDenJMlvnZxsED76gsXCqfkxM6seZ02fwNEgRYg4aR0a/3Sdf6hXWYXcv6oq3zGXh1/Jf
	Pst2zz+HjroFMoKfcGCKzxRQWUl40Gn/9w7QE2hGRm6+i3OVSLPDTlFpZXx1HPOYDeJo4JaIB+/
	Jqe85NkQg02WnwgC4Z/NnfYe+A7n6jq/Z6fXIZtwN9dSuRgSgmL6uM8TyGvD+wWnq3zBvJ9fZj1
	3JLJPXUJMeaN8I7XPSy6ZZktYUR3rcc+Nx2GxZ4BGJmCX7uhV6kl9rhiKI3VkNI6R1D+qskkAyv
	FKE9jo12obmIEKfEI=
X-Received: by 2002:a05:6a00:7492:b0:845:34ea:75ac with SMTP id d2e1a72fcca58-84534ea7a01mr5289756b3a.0.1781792774853;
        Thu, 18 Jun 2026 07:26:14 -0700 (PDT)
Received: from 11 ([111.92.66.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b009e67sm23485593b3a.42.2026.06.18.07.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 07:26:14 -0700 (PDT)
Message-ID: <6a340006.60da1a74.20db39.8f57@mx.google.com>
Date: Thu, 18 Jun 2026 07:26:14 -0700 (PDT)
From: calicomills <jishnuck26@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH] help: prompt user to run corrected command on typo
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

From 0dc9e5c4593611b75e7003e8fdbea9370524c05b Mon Sep 17 00:00:00 2001
From: calicomills <jishnuck26@gmail.com>
Date: Thu, 18 Jun 2026 19:47:12 +0530
Subject: [PATCH] help: prompt user to run corrected command on typo

When a user mistypes a git command and there is exactly one similar
command, git currently prints a suggestion but exits, requiring the
user to retype the corrected command manually.

Instead, when stdin and stderr are both connected to a terminal and
there is a single best match, prompt the user with:

  Did you mean 'git checkout neo'? [y/N]

The full corrected invocation (command + original arguments) is shown
in the prompt so the user knows exactly what will run. Answering 'y'
re-executes git with the corrected command and all original arguments.
Answering anything else exits as before.

When there are multiple similarly-named commands, or when running
non-interactively (scripts, pipes), the original behaviour of printing
the suggestion list and exiting is preserved.

The help_unknown_cmd() signature is updated to accept the full args
vector so the prompt can include the original arguments alongside the
corrected command name.

Add tests to t9003 covering:
- non-interactive single match: falls back to suggestion list
- non-interactive multiple matches: falls back to suggestion list
- interactive single match, 'y': corrected command runs (TTY prereq)
- interactive single match, 'n': exits cleanly (TTY prereq)

Signed-off-by: calicomills <jishnuck26@gmail.com>
---
 builtin/help.c              |  2 +-
 git.c                       |  2 +-
 help.c                      | 40 ++++++++++++++++++++++------
 help.h                      |  3 ++-
 t/t9003-help-autocorrect.sh | 53 +++++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index a140339999..b17e61ccc8 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -618,7 +618,7 @@ static char *check_git_cmd(const char *cmd)
 	}
 
 	if (exclude_guides)
-		return help_unknown_cmd(cmd);
+		return help_unknown_cmd(cmd, NULL);
 
 	return xstrdup(cmd);
 }
diff --git a/git.c b/git.c
index 36f08891ef..d379cc85bb 100644
--- a/git.c
+++ b/git.c
@@ -994,7 +994,7 @@ int cmd_main(int argc, const char **argv)
 			exit(1);
 		}
 		if (!done_help) {
-			char *assumed = help_unknown_cmd(cmd);
+			char *assumed = help_unknown_cmd(cmd, &args);
 			strvec_replace(&args, 0, assumed);
 			free(assumed);
 			cmd = args.v[0];
diff --git a/help.c b/help.c
index 46241492ce..30f32a7206 100644
--- a/help.c
+++ b/help.c
@@ -641,7 +641,7 @@ static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
 
-char *help_unknown_cmd(const char *cmd)
+char *help_unknown_cmd(const char *cmd, const struct strvec *args)
 {
 	struct help_unknown_cmd_config cfg = { 0 };
 	int i, n, best_similarity = 0;
@@ -762,13 +762,37 @@ char *help_unknown_cmd(const char *cmd)
 	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
-		fprintf_ln(stderr,
-			   Q_("\nThe most similar command is",
-			      "\nThe most similar commands are",
-			   n));
-
-		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		if (n == 1 && isatty(0) && isatty(2)) {
+			char *answer;
+			struct strbuf msg = STRBUF_INIT;
+			struct strbuf full_cmd = STRBUF_INIT;
+			strbuf_addstr(&full_cmd, main_cmds.names[0]->name);
+			if (args) {
+				for (size_t j = 1; j < args->nr; j++) {
+					strbuf_addch(&full_cmd, ' ');
+					strbuf_addstr(&full_cmd, args->v[j]);
+				}
+			}
+			strbuf_addf(&msg, _("\nDid you mean 'git %s'? [y/N] "),
+				    full_cmd.buf);
+			strbuf_release(&full_cmd);
+			answer = git_prompt(msg.buf, PROMPT_ECHO);
+			strbuf_release(&msg);
+			if (starts_with(answer, "y") || starts_with(answer, "Y")) {
+				char *assumed = xstrdup(main_cmds.names[0]->name);
+				cmdnames_release(&cfg.aliases);
+				cmdnames_release(&main_cmds);
+				cmdnames_release(&other_cmds);
+				return assumed;
+			}
+		} else {
+			fprintf_ln(stderr,
+				   Q_("\nThe most similar command is",
+				      "\nThe most similar commands are",
+				   n));
+			for (i = 0; i < n; i++)
+				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+		}
 	}
 
 	exit(1);
diff --git a/help.h b/help.h
index c54bf0977d..a8c465b3df 100644
--- a/help.h
+++ b/help.h
@@ -32,7 +32,8 @@ void list_all_other_cmds(struct string_list *list);
 void list_cmds_by_category(struct string_list *list,
 			   const char *category);
 void list_cmds_by_config(struct string_list *list);
-char *help_unknown_cmd(const char *cmd);
+#include "strvec.h"
+char *help_unknown_cmd(const char *cmd, const struct strvec *args);
 void load_command_list(const char *prefix,
 		       struct cmdnames *main_cmds,
 		       struct cmdnames *other_cmds);
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 8da318d2b5..6fe2da1595 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -70,4 +70,57 @@ test_expect_success 'autocorrect works in work tree created from bare repo' '
 	git -C worktree -c help.autocorrect=immediate status
 '
 
+# Default behaviour (no help.autocorrect set): when there is exactly one
+# similar command but the session is non-interactive, fall back to printing
+# the suggestion list and exiting rather than showing a prompt.
+test_expect_success 'default: single match non-interactive shows suggestion and fails' '
+	test_might_fail git config --unset help.autocorrect &&
+
+	test_must_fail git lfg 2>actual &&
+	grep "most similar command" actual &&
+	grep "lgf" actual
+'
+
+test_expect_success 'default: multiple matches non-interactive shows list and fails' '
+	test_might_fail git config --unset help.autocorrect &&
+
+	test_must_fail git com 2>actual &&
+	grep "most similar commands" actual &&
+	grep "commit" actual
+'
+
+# Interactive prompt tests require a real TTY.  On macOS the TTY prereq is
+# skipped due to IO::Pty reliability issues; these tests run on Linux CI.
+test_expect_success TTY 'default: single match interactive, answer y runs command' '
+	git config --unset help.autocorrect &&
+
+	write_script git-typotest <<-\EOF &&
+		echo typotest-ran
+	EOF
+	PATH="$PATH:." export PATH &&
+
+	# Feed "y" to /dev/tty via a wrapper that answers the prompt
+	write_script answer-prompt <<-\EOF &&
+		# Write the answer to the controlling terminal
+		printf "y\n" >/dev/tty
+		exec "$@"
+	EOF
+
+	test_terminal ./answer-prompt git typotest 2>err >out &&
+	grep "typotest-ran" out &&
+	grep "Did you mean" err
+'
+
+test_expect_success TTY 'default: single match interactive, answer n exits cleanly' '
+	git config --unset help.autocorrect &&
+
+	write_script answer-prompt-no <<-\EOF &&
+		printf "n\n" >/dev/tty
+		exec "$@"
+	EOF
+
+	test_must_fail test_terminal ./answer-prompt-no git typotest 2>err &&
+	grep "Did you mean" err
+'
+
 test_done
-- 
2.50.1


