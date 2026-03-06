Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156F2F6565
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808860; cv=none; b=SVdiI9k3HyPh7+XhebDcNrz7EDRm2xy2MNU7e7Y9C4jg8B8dsGKWAd98he5LbwUnP9JYdSb0EzPCZX6+BHTFSLrr7L3LBgqO0WcvODE019+Ce8Es6X2Vr9qkSaIlS/AjkNSuwZRjqvWSvQjivyQNbgcGWq72JHnyyJiL42Y4cAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808860; c=relaxed/simple;
	bh=RdAZfiu03vGxlEp+qu7UFa2hBxt5IWsoy7aQDiQ1JP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcmhzgvH8YDkGL5ZolPqN7v0baCkS/o6txtR/FFS3G//1fuKyBFS9Z+5V8Ew2sXEsQOhXtiqato2GQ3ZdfJ44ciIwnX5XW1t6GwbofF2XazGX+Sq/nB27HHnqV0+rLvP318lMJ63xIQwRXf4QqdEqfCRgtj2S7EWXAJ3iBlXTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGsyeOau; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGsyeOau"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so892606f8f.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808856; x=1773413656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snQaHFXI5zxcaaeeFqAOcn0kA9HARqttjchmMyuSKEk=;
        b=HGsyeOauzGaWEP9bemrP+054yiE2yI/jbgtRGjp11BlxZePxzpmsXx7Uqb7Zs7aXp0
         P3SyEVot25bom+nZLAUfOu57+A4u0E2Ymdc7lqdqybm9Xf4vwaZSiYU3RzI3xr8sTMX/
         Gfp3zqtfMtRYUIjhjY6ZImLbv7e8S3sBmacOgjoCl8cB8r0f7236aOai+0fEirstxAgV
         +bsw5EIYZuvIvLQ4I59vRKSwxWMsqviRLU3ew2bOTEr069WZjvdEE6tSCfydHEoK5H8S
         X67049ICSqr2DNGc6yn1XyNfii3xdD9Lf0jj3CEvwYxvsUJm/5SoSnWlOz/J45spNeP9
         ey5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808856; x=1773413656;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snQaHFXI5zxcaaeeFqAOcn0kA9HARqttjchmMyuSKEk=;
        b=WqdxmamMM14MbDs/tsc2KPx4RCOw3AarfTUf/folGkbt7a9xeEdx0kqbrT9uV3GKln
         iiGbej0cHn9dI22kX0xR5AG3pyx33zQ08r9vVMMO/QfzptRCfpqsCvrr9KzRPndIJxey
         wFZJg9o2p1eeda1Y322qUuDYUVt0klXthY7jWHVxKiGPSgOGNyb2lp7ZHlGh1remW85D
         JHLyBcxSKr8bIwx6rhL1v2vd5yuZVG7LR6coip50Ez8FHaYVkWCP/kY4TMFxZd/eIeBT
         iuQIRTyAxl2OhpwjggMgZ6LgDIWaF1IKiAz2MbizmiLRvroi8fb56GSvdl41FOgHjIhI
         iS9A==
X-Gm-Message-State: AOJu0YwZpfJRem+VrXdIuKcLuCKSAORuHZ6rmHc1nfoeF/VRyjXEPeGb
	0Wi1szjkPYR9iJvXkZh6pE1oOYwynUfA3zNkGXM9Ec/S2isXPPfhJ6K8ee2EPA==
X-Gm-Gg: ATEYQzxo/6XIba+OGHbbJDqmSffKOLm96W/bp3e7auqxOdP2Eui7M5juUnVSbV/c0kg
	MK+wCy1ifGyTfhM3IHyDCuhkAGRTzWQDW2CZ7rTeemp0+IJZSHsAT6GSDuAXPnojLeXE38bjJAK
	7GAVe3GA+3JTy3Qt5uSju6QMd23TJ85b6VuJ9+AqI+0gaa2v9zqdILejLTcb6vFBDbTvVsM2QnB
	Z8SjxxGam1pwGWpOQ76ppx4VPT137jPboLGsJdDkVKzquwQlr1wOaUkcTLv5xQrnGclTa9ENsRo
	sM9oi6+y5uyLb687S8+bZ6fSeFb4mra/9VR5BgVYQJoegbxp6PNgFeqW6Jr+5T61AMNaoDSRWlf
	/l+CZa6tt+Uq4Miy43Y+RknQkoqxJLTi8jWImbYxIq25GRt/UPTtC8YIi7e+jlCkj31ruVpzKUl
	1j98ExblIR3zIa4lwZ9gyGk0kb9MU=
X-Received: by 2002:a05:6000:2285:b0:439:ba69:101d with SMTP id ffacd0b85a97d-439da354ccbmr3925773f8f.1.1772808855850;
        Fri, 06 Mar 2026 06:54:15 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:15 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 0/6] rebase: support --trailer
Date: Fri,  6 Mar 2026 14:53:26 +0000
Message-ID: <cover.1772808594.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <20260224070552.148591-1-me@linux.beauty>
References: <20260224070552.148591-1-me@linux.beauty>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series adds support for creating trailers when rebasing, along
the lines of "git commit --trailer". Patches 1-3 refactor and libify
the code to add trailers to a buffer, patches 4,5 update "git commit
--trailer" and "git tag --trailer" to use the new code and the last
patch adds support for "git rebase --trailer".

Thanks to Li for working on this series, the main change in this
hopefully final iteration is that more code is shared between "git
interpret-trailers" and the builtin commands that add trailers via
a --trailer option, see the range-diff for patches 2-4.

Changes since V7:

 - Patch 1: Added missing sign-off.
 - Patch 2: New, refactor create_in_place_tempfile() in preparation for
            moving it.
 - Patch 3: Move create_in_place_tempfile() in addition to
            process_trailers().
 - Patch 4: Use the libified create_in_place_tempfile(), initialize
            trailer config earlier and validate --trailer args for
            "git commit" and "git tag". Library code now calls error()
            rather than die()
 - Patch 5: Unchanged, apart from the effect of previous patches
 - Patch 6: Small doc fixes, initialize trailer_config() when continuing
            a rebase that was started with --trailer. Report errors when
            reading trailer state file.

Li Chen (5):
  interpret-trailers: factor trailer rewriting
  trailer: libify a couple of functions
  trailer: append trailers without fork/exec
  commit, tag: parse --trailer with OPT_STRVEC
  rebase: support --trailer

Phillip Wood (1):
  interpret-trailers: refactor create_in_place_tempfile()

 Documentation/git-rebase.adoc |   8 ++
 builtin/commit.c              |   6 +-
 builtin/interpret-trailers.c  |  91 ++++-------------
 builtin/rebase.c              |  19 ++++
 builtin/tag.c                 |   7 +-
 sequencer.c                   |  52 +++++++++-
 sequencer.h                   |   3 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 147 +++++++++++++++++++++++++++
 trailer.c                     | 184 ++++++++++++++++++++++++++++++++--
 trailer.h                     |  36 ++++++-
 11 files changed, 463 insertions(+), 91 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

Range-diff:
1:  b2685e34c22 ! 1:  0d08b361995 interpret-trailers: factor trailer rewriting
    @@ Commit message
         This separation makes it easier to move the helper into trailer.c in the
         next commit.
     
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Li Chen <me@linux.beauty>
     
      ## builtin/interpret-trailers.c ##
     @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
-:  ----------- > 2:  5a4d03ab375 interpret-trailers: refactor create_in_place_tempfile()
2:  1bac3025045 ! 3:  ab7e232a95d trailer: move process_trailers to trailer.h
    @@ Metadata
     Author: Li Chen <me@linux.beauty>
     
      ## Commit message ##
    -    trailer: move process_trailers to trailer.h
    -
    -    Move process_trailers() from builtin/interpret-trailers.c into trailer.c
    -    and expose it via trailer.h.
    -
    -    This lets other call sites reuse the same trailer rewriting logic.
    +    trailer: libify a couple of functions
    +
    +    Move create_in_place_tempfile() and process_trailers() from
    +    builtin/interpret-trailers.c into trailer.c and expose it via trailer.h.
    +
    +    This reverts most of ae0ec2e0e0b (trailer: move interpret_trailers()
    +    to interpret-trailers.c, 2024-03-01) and lets other call sites reuse
    +    the same trailer rewriting logic.
     
         Signed-off-by: Li Chen <me@linux.beauty>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/interpret-trailers.c ##
    +@@ builtin/interpret-trailers.c: static int parse_opt_parse(const struct option *opt, const char *arg,
    + 	return 0;
    + }
    + 
    +-
    +-static struct tempfile *create_in_place_tempfile(const char *file)
    +-{
    +-	struct tempfile *tempfile = NULL;
    +-	struct stat st;
    +-	struct strbuf filename_template = STRBUF_INIT;
    +-	const char *tail;
    +-
    +-	if (stat(file, &st)) {
    +-		error_errno(_("could not stat %s"), file);
    +-		return NULL;
    +-	}
    +-	if (!S_ISREG(st.st_mode)) {
    +-		error(_("file %s is not a regular file"), file);
    +-		return NULL;
    +-	}
    +-	if (!(st.st_mode & S_IWUSR)) {
    +-		error(_("file %s is not writable by user"), file);
    +-		return NULL;
    +-	}
    +-	/* Create temporary file in the same directory as the original */
    +-	tail = find_last_dir_sep(file);
    +-	if (tail)
    +-		strbuf_add(&filename_template, file, tail - file + 1);
    +-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
    +-
    +-	tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
    +-
    +-	strbuf_release(&filename_template);
    +-
    +-	return tempfile;
    +-}
    +-
    + static void read_input_file(struct strbuf *sb, const char *file)
    + {
    + 	if (file) {
     @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
      	strbuf_complete_line(sb);
      }
    @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, con
      static void interpret_trailers(const struct process_trailer_options *opts,
      			       struct list_head *new_trailer_head,
      			       const char *file)
    +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
    + 	read_input_file(&input, file);
    + 
    + 	if (opts->in_place) {
    +-		tempfile = create_in_place_tempfile(file);
    ++		tempfile = trailer_create_in_place_tempfile(file);
    + 		if (!tempfile)
    + 			die(NULL);
    + 		fd = tempfile->fd;
     
      ## trailer.c ##
    +@@
    + #include "commit.h"
    + #include "trailer.h"
    + #include "list.h"
    ++#include "tempfile.h"
    ++
    + /*
    +  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
    +  */
    +@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
    + 	strbuf_release(&iter->key);
    + }
    + 
    ++struct tempfile *trailer_create_in_place_tempfile(const char *file)
    ++{
    ++	struct tempfile *tempfile = NULL;
    ++	struct stat st;
    ++	struct strbuf filename_template = STRBUF_INIT;
    ++	const char *tail;
    ++
    ++	if (stat(file, &st)) {
    ++		error_errno(_("could not stat %s"), file);
    ++		return NULL;
    ++	}
    ++	if (!S_ISREG(st.st_mode)) {
    ++		error(_("file %s is not a regular file"), file);
    ++		return NULL;
    ++	}
    ++	if (!(st.st_mode & S_IWUSR)) {
    ++		error(_("file %s is not writable by user"), file);
    ++		return NULL;
    ++	}
    ++	/* Create temporary file in the same directory as the original */
    ++	tail = find_last_dir_sep(file);
    ++	if (tail)
    ++		strbuf_add(&filename_template, file, tail - file + 1);
    ++	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
    ++
    ++	tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
    ++
    ++	strbuf_release(&filename_template);
    ++
    ++	return tempfile;
    ++}
    ++
    + int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
    + {
    + 	struct child_process run_trailer = CHILD_PROCESS_INIT;
     @@ trailer.c: int amend_file_with_trailers(const char *path, const struct strvec *trailer_args
      	strvec_pushv(&run_trailer.args, trailer_args->v);
      	return run_command(&run_trailer);
    @@ trailer.h: void trailer_iterator_release(struct trailer_iterator *iter);
       */
      int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
      
    ++/*
    ++ * Create a tempfile ""git-interpret-trailers-XXXXXX" in the same
    ++ * directory as file.
    ++ */
    ++struct tempfile *trailer_create_in_place_tempfile(const char *file);
    ++
    ++/*
    ++ * Rewrite the contents of input by processing its trailer block according to
    ++ * opts and (optionally) appending trailers from new_trailer_head.
    ++ *
    ++ * The rewritten message is appended to out (callers should strbuf_reset()
    ++ * first if needed).
    ++ */
     +void process_trailers(const struct process_trailer_options *opts,
     +		      struct list_head *new_trailer_head,
     +		      struct strbuf *input, struct strbuf *out);
3:  3114f0dbb57 ! 4:  1f24917eb64 trailer: append trailers without fork/exec
    @@ Commit message
     
         Update amend_file_with_trailers() to use the in-process helper and
         rewrite the target file via tempfile+rename, preserving the previous
    -    in-place semantics.
    +    in-place semantics. As the trailers are no longer added in a separate
    +    process and trailer_config_init() die()s on missing config values it
    +    is called early on in cmd_commit() and cmd_tag() so that they die()
    +    early before writing the message file. The trailer arguments are now
    +    also sanity checked.
     
         Keep existing callers unchanged by continuing to accept argv-style
         --trailer=<trailer> entries and stripping the prefix before feeding the
         in-process implementation.
     
         Signed-off-by: Li Chen <me@linux.beauty>
    -
    - ## builtin/interpret-trailers.c ##
    -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
    - 	struct strbuf out = STRBUF_INIT;
    - 	FILE *outfile = stdout;
    - 
    --	trailer_config_init();
    --
    - 	read_input_file(&input, file);
    - 
    - 	if (opts->in_place)
    -@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc,
    - 			git_interpret_trailers_usage,
    - 			options);
    - 
    -+	trailer_config_init();
    -+
    - 	if (argc) {
    - 		int i;
    - 		for (i = 0; i < argc; i++)
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +
    + ## builtin/commit.c ##
    +@@ builtin/commit.c: int cmd_commit(int argc,
    + 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
    + 					  builtin_commit_usage,
    + 					  prefix, current_head, &s);
    ++	if (trailer_args.nr)
    ++		trailer_config_init();
    ++
    + 	if (verbose == -1)
    + 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
    + 
    +
    + ## builtin/tag.c ##
    +@@ builtin/tag.c: int cmd_tag(int argc,
    + 	if (cmdmode == 'l')
    + 		setup_auto_pager("tag", 1);
    + 
    ++	if (trailer_args.nr)
    ++		trailer_config_init();
    ++
    + 	if (opt.sign == -1)
    + 		opt.sign = cmdmode ? 0 : config_sign_tag > 0;
    + 
     
      ## trailer.c ##
     @@
      #include "string-list.h"
      #include "run-command.h"
      #include "commit.h"
     +#include "strvec.h"
    -+#include "tempfile.h"
      #include "trailer.h"
      #include "list.h"
    -+
    - /*
    -  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
    -  */
    + #include "tempfile.h"
     @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head,
      	free(cl_separators);
      }
      
    -+void validate_trailer_args(const struct strvec *cli_args)
    ++int validate_trailer_args(const struct strvec *cli_args)
     +{
     +	char *cl_separators;
    ++	int ret = 0;
     +
     +	trailer_config_init();
     +
    @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head
     +		const char *txt = cli_args->v[i];
     +		ssize_t separator_pos;
     +
    -+		if (!*txt)
    -+			die(_("empty --trailer argument"));
    -+
    ++		if (!*txt) {
    ++			ret = error(_("empty --trailer argument"));
    ++			goto out;
    ++		}
     +		separator_pos = find_separator(txt, cl_separators);
    -+		if (separator_pos == 0)
    -+			die(_("invalid trailer '%s': missing key before separator"),
    -+			    txt);
    ++		if (separator_pos == 0) {
    ++			ret = error(_("invalid trailer '%s': missing key before separator"),
    ++				    txt);
    ++			goto out;
    ++		}
     +	}
    -+
    ++out:
     +	free(cl_separators);
    ++	return ret;
     +}
     +
      static const char *next_line(const char *str)
      {
      	const char *nl = strchrnul(str, '\n');
    -@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
    - 	strbuf_release(&iter->key);
    +@@ trailer.c: struct tempfile *trailer_create_in_place_tempfile(const char *file)
    + 	return tempfile;
      }
      
     -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
    @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
     -		     path, NULL);
     -	strvec_pushv(&run_trailer.args, trailer_args->v);
     -	return run_command(&run_trailer);
    -+static void new_trailer_items_clear(struct list_head *items)
    -+{
    -+	while (!list_empty(items)) {
    -+		struct new_trailer_item *item =
    -+			list_first_entry(items, struct new_trailer_item, list);
    -+		list_del(&item->list);
    -+		free(item);
    -+	}
    -+}
    -+
    -+void amend_strbuf_with_trailers(struct strbuf *buf,
    ++int amend_strbuf_with_trailers(struct strbuf *buf,
     +				const struct strvec *trailer_args)
     +{
     +	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     +	LIST_HEAD(new_trailer_head);
     +	struct strbuf out = STRBUF_INIT;
     +	size_t i;
    ++	int ret = 0;
     +
     +	opts.no_divider = 1;
     +
     +	for (i = 0; i < trailer_args->nr; i++) {
     +		const char *text = trailer_args->v[i];
     +		struct new_trailer_item *item;
     +
    -+		if (!*text)
    -+			die(_("empty --trailer argument"));
    ++		if (!*text) {
    ++			ret = error(_("empty --trailer argument"));
    ++			goto out;
    ++		}
     +		item = xcalloc(1, sizeof(*item));
    -+		item->text = text;
    ++		item->text = xstrdup(text);
     +		list_add_tail(&item->list, &new_trailer_head);
     +	}
     +
    -+	trailer_config_init();
     +	process_trailers(&opts, &new_trailer_head, buf, &out);
     +
     +	strbuf_swap(buf, &out);
    ++out:
     +	strbuf_release(&out);
    ++	free_trailers(&new_trailer_head);
     +
    -+	new_trailer_items_clear(&new_trailer_head);
    ++	return ret;
     +}
     +
     +static int write_file_in_place(const char *path, const struct strbuf *buf)
     +{
    -+	struct stat st;
    -+	struct strbuf filename_template = STRBUF_INIT;
    -+	const char *tail;
    -+	struct tempfile *tempfile;
    -+	FILE *outfile;
    -+
    -+	if (stat(path, &st))
    -+		return error_errno(_("could not stat %s"), path);
    -+	if (!S_ISREG(st.st_mode))
    -+		return error(_("file %s is not a regular file"), path);
    -+	if (!(st.st_mode & S_IWUSR))
    -+		return error(_("file %s is not writable by user"), path);
    -+
    -+	/* Create temporary file in the same directory as the original */
    -+	tail = strrchr(path, '/');
    -+	if (tail)
    -+		strbuf_add(&filename_template, path, tail - path + 1);
    -+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
    -+
    -+	tempfile = mks_tempfile_sm(filename_template.buf, 0, st.st_mode);
    -+	strbuf_release(&filename_template);
    ++	struct tempfile *tempfile = trailer_create_in_place_tempfile(path);
     +	if (!tempfile)
    -+		return error_errno(_("could not create temporary file"));
    -+
    -+	outfile = fdopen_tempfile(tempfile, "w");
    -+	if (!outfile) {
    -+		int saved_errno = errno;
    -+		delete_tempfile(&tempfile);
    -+		errno = saved_errno;
    -+		return error_errno(_("could not open temporary file"));
    -+	}
    -+
    -+	if (buf->len && fwrite(buf->buf, 1, buf->len, outfile) < buf->len) {
    -+		int saved_errno = errno;
    -+		delete_tempfile(&tempfile);
    -+		errno = saved_errno;
    ++		return -1;
    ++
    ++	if (write_in_full(tempfile->fd, buf->buf, buf->len) < 0)
     +		return error_errno(_("could not write to temporary file"));
    -+	}
     +
     +	if (rename_tempfile(&tempfile, path))
     +		return error_errno(_("could not rename temporary file to %s"), path);
    @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
     +		 * in-process implementation.
     +		 */
     +		skip_prefix(txt, "--trailer=", &txt);
    -+		if (!*txt)
    -+			die(_("empty --trailer argument"));
    ++		if (!*txt) {
    ++			ret = error(_("empty --trailer argument"));
    ++			goto out;
    ++		}
     +		strvec_push(&stripped_trailer_args, txt);
     +	}
     +
    ++	if (validate_trailer_args(&stripped_trailer_args)) {
    ++		ret = -1;
    ++		goto out;
    ++	}
     +	if (strbuf_read_file(&buf, path, 0) < 0)
     +		ret = error_errno(_("could not read '%s'"), path);
     +	else
     +		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
     +
     +	if (!ret)
     +		ret = write_file_in_place(path, &buf);
    -+
    ++out:
     +	strvec_clear(&stripped_trailer_args);
     +	strbuf_release(&buf);
     +	return ret;
    @@ trailer.h: void parse_trailers_from_config(struct list_head *config_head);
      void parse_trailers_from_command_line_args(struct list_head *arg_head,
      					   struct list_head *new_trailer_head);
      
    -+void validate_trailer_args(const struct strvec *cli_args);
    ++int validate_trailer_args(const struct strvec *cli_args);
     +
      void process_trailers_lists(struct list_head *head,
      			    struct list_head *arg_head);
    @@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
     + * Each element of trailer_args should be in the same format as the value
     + * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
     + */
    -+void amend_strbuf_with_trailers(struct strbuf *buf,
    ++int amend_strbuf_with_trailers(struct strbuf *buf,
     +				const struct strvec *trailer_args);
     +
     +/*
    @@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
       */
      int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
      
    -+/*
    -+ * Rewrite the contents of input by processing its trailer block according to
    -+ * opts and (optionally) appending trailers from new_trailer_head.
    -+ *
    -+ * The rewritten message is appended to out (callers should strbuf_reset()
    -+ * first if needed).
    -+ */
    - void process_trailers(const struct process_trailer_options *opts,
    - 		      struct list_head *new_trailer_head,
    - 		      struct strbuf *input, struct strbuf *out);
4:  147595a9317 ! 5:  3c1fa9e8579 commit, tag: parse --trailer with OPT_STRVEC
    @@ Commit message
         amend_file_with_trailers().
     
         Signed-off-by: Li Chen <me@linux.beauty>
     
      ## builtin/commit.c ##
     @@ builtin/commit.c: int cmd_commit(int argc,
    @@ trailer.c: int amend_file_with_trailers(const char *path,
     -		 * in-process implementation.
     -		 */
     -		skip_prefix(txt, "--trailer=", &txt);
    --		if (!*txt)
    --			die(_("empty --trailer argument"));
    +-		if (!*txt) {
    +-			ret = error(_("empty --trailer argument"));
    +-			goto out;
    +-		}
     -		strvec_push(&stripped_trailer_args, txt);
     -	}
     -
    +-	if (validate_trailer_args(&stripped_trailer_args)) {
    ++	if (validate_trailer_args(trailer_args)) {
    + 		ret = -1;
    + 		goto out;
    + 	}
      	if (strbuf_read_file(&buf, path, 0) < 0)
      		ret = error_errno(_("could not read '%s'"), path);
      	else
    @@ trailer.c: int amend_file_with_trailers(const char *path,
      
      	if (!ret)
      		ret = write_file_in_place(path, &buf);
    - 
    + out:
     -	strvec_clear(&stripped_trailer_args);
      	strbuf_release(&buf);
      	return ret;
      }
     
      ## trailer.h ##
    -@@ trailer.h: void amend_strbuf_with_trailers(struct strbuf *buf,
    +@@ trailer.h: int amend_strbuf_with_trailers(struct strbuf *buf,
      /*
       * Augment a file by appending trailers specified in trailer_args.
       *
5:  864cf5f8eb6 ! 6:  99654d80547 rebase: support --trailer
    @@ Commit message
         non-interactive and interactive rebases.
     
         Signed-off-by: Li Chen <me@linux.beauty>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-rebase.adoc ##
     @@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
    @@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
     +--trailer=<trailer>::
     +	Append the given trailer to every rebased commit message, processed
     +	via linkgit:git-interpret-trailers[1]. This option implies
    -+	`--force-rebase` so that fast-forwarded commits are also rewritten.
    ++	`--force-rebase`.
     ++
     +See also INCOMPATIBLE OPTIONS below.
     +
      -i::
      --interactive::
      	Make a list of the commits which are about to be rebased.  Let the
    +@@ Documentation/git-rebase.adoc: are incompatible with the following options:
    +  * --[no-]reapply-cherry-picks when used without --keep-base
    +  * --update-refs
    +  * --root when used without --onto
    ++ * --trailer
    + 
    + In addition, the following pairs of options are incompatible:
    + 
     
      ## builtin/rebase.c ##
     @@
    @@ builtin/rebase.c: int cmd_rebase(int argc,
      			     builtin_rebase_usage, 0);
      
     +	if (options.trailer_args.nr) {
    -+		validate_trailer_args(&options.trailer_args);
    ++		if (validate_trailer_args(&options.trailer_args))
    ++			die(NULL);
     +		options.flags |= REBASE_FORCE;
     +	}
     +
    @@ sequencer.c: void replay_opts_release(struct replay_opts *opts)
      	free(opts->ctx);
      }
     @@ sequencer.c: static int append_squash_message(struct strbuf *buf, const char *body,
    + 	if (is_fixup_flag(command, flag) && !seen_squash(ctx)) {
    + 		/*
    + 		 * We're replacing the commit message so we need to
    +-		 * append the Signed-off-by: trailer if the user
    +-		 * requested '--signoff'.
    ++		 * append any trailers if the user requested
    ++		 * '--signoff' or '--trailer'.
    + 		 */
      		if (opts->signoff)
      			append_signoff(buf, 0, 0);
      
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
      	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
      		res = -1;
      	else if (!opts->strategy ||
    +@@ sequencer.c: static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
    + 	parse_strategy_opts(opts, buf->buf);
    + }
    + 
    ++static int read_trailers(struct replay_opts *opts, struct strbuf *buf)
    ++{
    ++	ssize_t len;
    ++
    ++	strbuf_reset(buf);
    ++	len = strbuf_read_file(buf, rebase_path_trailer(), 0);
    ++	if (len > 0) {
    ++		char *p = buf->buf, *nl;
    ++
    ++		trailer_config_init();
    ++
    ++		while ((nl = strchr(p, '\n'))) {
    ++			*nl = '\0';
    ++			if (!*p)
    ++				return error(_("trailers file contains empty line"));
    ++			strvec_push(&opts->trailer_args, p);
    ++			p = nl + 1;
    ++		}
    ++	} else if (!len) {
    ++		return error(_("trailers file is empty"));
    ++	} else if (errno != ENOENT) {
    ++		return error(_("cannot read trailers files"));
    ++	}
    ++
    ++	return 0;
    ++}
    ++
    + static int read_populate_opts(struct replay_opts *opts)
    + {
    + 	struct replay_ctx *ctx = opts->ctx;
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
    + 			opts->keep_redundant_commits = 1;
      
      		read_strategy_opts(opts, &buf);
    ++
    ++		if (read_trailers(opts, &buf)) {
    ++			ret = -1;
    ++			goto done_rebase_i;
    ++		}
      		strbuf_reset(&buf);
    -+		if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {
    -+			char *p = buf.buf, *nl;
    -+
    -+			while ((nl = strchr(p, '\n'))) {
    -+				*nl = '\0';
    -+				if (!*p)
    -+					BUG("rebase-merge/trailer has an empty line");
    -+				strvec_push(&opts->trailer_args, p);
    -+				p = nl + 1;
    -+			}
    -+			strbuf_reset(&buf);
    -+		}
      
      		if (read_oneliner(&ctx->current_fixups,
    - 				  rebase_path_current_fixups(),
     @@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_name,
      		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
      	else
-- 
2.52.0.362.g884e03848a9

