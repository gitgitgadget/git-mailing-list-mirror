Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D11E529
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416875; cv=none; b=bAwkt7w5ZAahiHnxQUce5yhdYj7djwaV4mS19Q32bSJFkanvLiPhAAJv+d59KY0rbB9GvyVhGSYb/HNgeD/IFUk6cpv3m8AfvhS/EbLZjPf2eXi0WIK8TSPVYsfo6fSrfGJ1BQ5ErrcCTm+0c0xppux2qGFR/2scMyjUNVd5XVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416875; c=relaxed/simple;
	bh=KO8x4UIea1UTixej4TTq7NwbEVFgfFWwlVOzxfXLKGg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SNKG1nOdyxSOZ8dCBj8CBFR78VfbhY2ulhbJc9/EOfDj2MnErMChQGkmWyjbFs5f4Zj5jTNWMzzCO1sBRK+44QtiL46PMM4dyp1O34noe9dXMzRmd47nKjy6LKM/Z9c5Xo8LC0iFV3QHKS6+/iLtONELfaa1H+lNuIc6Ec4xlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeRmn1Jv; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRmn1Jv"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso64797921fa.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714416872; x=1715021672; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GO+tOUmuBkiUdvy9qw2u9Jorx2A1eER2qooaBbP59g=;
        b=HeRmn1JvxqR/R77TVz27WG0OIEWWEk4osQbndDQGV5lSK9drjLEolnXuyjmWz6lgT4
         nYSaKhpDWo0d33pS38JEFL1hnZ/hK63V+8Lr74YWl3S66T8RqAiBFpU6TA5eHefG8ucK
         YNwM8NRdo7ZRKTz8YjjBX7caVOHDNKuAcYPLKEOTBlcOEmQrQe64T8NkvVL5dk0DKlGo
         uIw4p8aarZmsSlZPmyIlMXgRnJIRZg1anIVPWESsIkSFwEcKIfY97wpNdd15GDwvTJgb
         7JfP5Xfd87BlMu6tbaeDOr9+ZjON6CAqGJw1Dj6vCbhySsT2WZJK/9ceDfQibgVrXn4y
         XNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416872; x=1715021672;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GO+tOUmuBkiUdvy9qw2u9Jorx2A1eER2qooaBbP59g=;
        b=CCwjfWbYlPTNmwwF6nbEqb0fiyrRi1iDv5YZcoah57cbS935X7cWemBcNjzX5nfU20
         Xn0+4gZHfmbOv2bMakCbq3fOe6UuqmisIcJe61CUsjShjujgnsQMr4TOxtH4qIOlCV93
         rJbITP2ZDw5toBHVeXhARQI5mp/RTx3Vkm2h/kVR2371V/icwNz8XzYVLLC5z08SSi2S
         wwSuqJbS7jtEW/CPeN1HC9mWmxMsxFWogymNeoyOlf/A7Iinu+mrha+BHx0qFZYR626L
         FJQYf16ovWddpIhdJAN+LJ6NFzmf6ygnNluMYQvwTp19ybV4wvuxaWEdlqUEztG+b9I+
         exLQ==
X-Gm-Message-State: AOJu0YyVVCECh40xvA80zdmVHZM5rTbkCsIlzU681XCo0SOOZcJGFeQU
	w9iJbbFN2hMW9JbWpJYjTpjDL5+5TbOBB1RCIk0nxwt1i5beElkbiq8kDw==
X-Google-Smtp-Source: AGHT+IFNwB5UfB59/zhe8ZB4JDK4LLp/X17WC7VOzxvbjwjAfL4bOoflEv8kG9R0m4ZPvVbH/vyDLw==
X-Received: by 2002:a2e:7006:0:b0:2df:84af:27cb with SMTP id l6-20020a2e7006000000b002df84af27cbmr7318202ljc.24.1714416871273;
        Mon, 29 Apr 2024 11:54:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0041bf685921dsm8527182wmq.0.2024.04.29.11.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:54:30 -0700 (PDT)
Message-Id: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Apr 2024 18:54:20 +0000
Subject: [PATCH v3 0/3] builtin/tag.c: add --trailer option
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

Follow-up patch taking welcome feedback from Patrick and JCH.

Since git-tag --list --format="%(trailers)" can interpret trailers from
annotated tag messages, it seems natural to support --trailer when writing a
new tag message.

git-commit accomplishes this by taking --trailer arguments and passing them
to git interpret-trailer. This patch series refactors that logic and uses it
to implement --trailer on git-tag.

Also Included are updates to the i18n files, since the git-tag patch changes
some strings that are subject to translation. If I am out of my lane here,
please feel free to separate or leave out the i18n patch.

John Passaro (3):
  builtin/commit.c: refactor --trailer logic
  builtin/tag.c: add --trailer arg
  po: update git-tag translations

 Documentation/git-tag.txt |  18 +++++-
 builtin/commit.c          |  20 +------
 builtin/tag.c             |  41 +++++++++++---
 po/bg.po                  |   2 +
 po/ca.po                  |   4 +-
 po/de.po                  |   2 +
 po/el.po                  |   9 ++-
 po/es.po                  |  14 +++--
 po/fr.po                  |   2 +
 po/id.po                  |   2 +
 po/it.po                  |   6 +-
 po/ko.po                  |  10 ++--
 po/pl.po                  |   6 +-
 po/ru.po                  |   1 +
 po/sv.po                  |   2 +
 po/tr.po                  |   2 +
 po/uk.po                  |   2 +
 po/vi.po                  |   2 +
 po/zh_CN.po               |   2 +
 po/zh_TW.po               |   2 +
 t/t7004-tag.sh            | 114 ++++++++++++++++++++++++++++++++++++++
 trailer.c                 |  12 ++++
 trailer.h                 |   8 +++
 23 files changed, 237 insertions(+), 46 deletions(-)


base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1723%2Fjpassaro%2Fjp%2Ftag-trailer-arg-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1723/jpassaro/jp/tag-trailer-arg-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1723

Range-diff vs v2:

 -:  ----------- > 1:  0c9517f434a builtin/commit.c: refactor --trailer logic
 1:  d4beb7cd67e ! 2:  5b6239167b8 builtin/tag.c: add --trailer arg
     @@ Metadata
       ## Commit message ##
          builtin/tag.c: add --trailer arg
      
     -    Teach git-tag to accept --trailer option to add trailers to annotated
     -    tag messages, like git-commit. Move the code that git-commit uses for
     -    trailers to the trailer.h API, so it can be re-used for git-tag.
     +    git-tag currently supports interpreting trailers from an annotated tag
     +    message, using --list --format="%(trailers)". There is no ergonomic way
     +    to add trailers to an annotated tag message.
     +
     +    In a previous patch, we refactored git-commit's implementation of its
     +    --trailer arg to the trailer.h API. Let's use that new function to teach
     +    git-tag the same --trailer argument, emulating as much of git-commit's
     +    behavior as much as possible.
      
          Signed-off-by: John Passaro <john.a.passaro@gmail.com>
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
      
       ## Documentation/git-tag.txt ##
      @@ Documentation/git-tag.txt: SYNOPSIS
     @@ Documentation/git-tag.txt: This option is only applicable when listing tags with
       --edit::
       	The message taken from file with `-F` and command line with
      
     - ## builtin/commit.c ##
     -@@
     - #include "commit-reach.h"
     - #include "commit-graph.h"
     - #include "pretty.h"
     -+#include "trailer.h"
     - 
     - static const char * const builtin_commit_usage[] = {
     - 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
     -@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     - 	fclose(s->fp);
     - 
     - 	if (trailer_args.nr) {
     --		struct child_process run_trailer = CHILD_PROCESS_INIT;
     --
     --		strvec_pushl(&run_trailer.args, "interpret-trailers",
     --			     "--in-place", "--no-divider",
     --			     git_path_commit_editmsg(), NULL);
     --		strvec_pushv(&run_trailer.args, trailer_args.v);
     --		run_trailer.git_cmd = 1;
     --		if (run_command(&run_trailer))
     -+		if (amend_file_with_trailers(git_path_commit_editmsg(), &trailer_args))
     - 			die(_("unable to pass trailers to --trailers"));
     - 		strvec_clear(&trailer_args);
     - 	}
     -
       ## builtin/tag.c ##
      @@
       #include "date.h"
     @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char
       		}
       	}
       
     -@@ builtin/tag.c: struct msg_arg {
     - 	struct strbuf buf;
     - };
     - 
     -+static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
     -+{
     -+	BUG_ON_OPT_NEG(unset);
     -+
     -+	strvec_pushl(opt->value, "--trailer", arg, NULL);
     -+	return 0;
     -+}
     -+
     - static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
     - {
     - 	struct msg_arg *msg = opt->value;
      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       	struct ref_sorting *sorting;
       	struct string_list sorting_options = STRING_LIST_INIT_DUP;
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
       			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
       		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
     -+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"),
     -+				PARSE_OPT_NONEG, opt_pass_trailer),
     ++		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
     ++				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
       		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
       		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
       		OPT_CLEANUP(&cleanup_arg),
     @@ t/t7004-tag.sh: test_expect_success 'git tag --format with ahead-behind' '
       	refs/tags/tag-zero-lines 0 1 !
       	EOF
       	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&
     -
     - ## trailer.c ##
     -@@
     - #include "commit.h"
     - #include "trailer.h"
     - #include "list.h"
     -+#include "run-command.h"
     - /*
     -  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
     -  */
     -@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
     - 	strbuf_release(&iter->val);
     - 	strbuf_release(&iter->key);
     - }
     -+
     -+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args) {
     -+	struct child_process run_trailer = CHILD_PROCESS_INIT;
     -+
     -+	run_trailer.git_cmd = 1;
     -+	strvec_pushl(&run_trailer.args, "interpret-trailers",
     -+		     "--in-place", "--no-divider",
     -+		     path, NULL);
     -+	strvec_pushv(&run_trailer.args, trailer_args->v);
     -+	return run_command(&run_trailer);
     -+}
     -
     - ## trailer.h ##
     -@@
     - 
     - #include "list.h"
     - #include "strbuf.h"
     -+#include "strvec.h"
     - 
     - enum trailer_where {
     - 	WHERE_DEFAULT,
     -@@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
     -  */
     - void trailer_iterator_release(struct trailer_iterator *iter);
     - 
     -+/*
     -+ * Augment a file to add trailers to it by running git-interpret-trailers.
     -+ * This calls run_command() and its return value is the same (i.e. 0 for
     -+ * success, various non-zero for other errors). See run-command.h.
     -+ */
     -+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args);
     -+
     - #endif /* TRAILER_H */
 -:  ----------- > 3:  d5335e30b0b po: update git-tag translations

-- 
gitgitgadget
