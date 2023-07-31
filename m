Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC5C04FE0
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGaXtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjGaXtp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:45 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563210C1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:43 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbbc4ae328so38979845ad.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690847382; x=1691452182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z/kKDv37yp8q+ycFekkS1P/iBtmSQup6cLJMzfCBV4=;
        b=pYwFHDkSby5UtTneUQoriYRdYqlZq5SCtyqSkBQQ84ZqciyTqRNl1usw3t33Adu/jh
         3mziCyjRkNyZOEH3kpvQ3Bv/Dl/wwDdxAZ3wscZnKyEZ13zwLNZ/6mC5qjJlVJ7KeEo6
         sxNxiLZvcjYuFDwvyo9VrMNdNQyqi8SgSbSwj2Uibol0Ir7DcmR4Rhj/uG/APV3D5qip
         HhkJTEPbrTdxXVGueUk7uS8+Srf5rnzV5WI6uqJDFGGOK4BFifnpyAiaxcG1axHrWaFl
         0kBep7PCHlW2V0B7QG4TjOUr1IxxBOvTQ/E3SKIcrGnVunc6YWonA/OOBKOyJIjwXCHs
         mhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847382; x=1691452182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z/kKDv37yp8q+ycFekkS1P/iBtmSQup6cLJMzfCBV4=;
        b=d3TlcTBUnRXEKmruFEA+t7O4kPRJculCb9h/1znFDNyTp/YZ1xSo5DFK3AxBWHMlK4
         5rxHQGicGzBJ+IVS3zN9nyig1u3O16bg1OUCuV94SETIAzPtdXXbYF45W/K8p0378P4C
         /4kEwIaYSTRmGqSs7cMscp5EVacYjWFvl6Y45sclRpsyr8HZgv+EnRdX5PTCtbTSioqo
         mRFyiw881dpifFMVglksbTnd4UN1eVjDIPNCwWx7GpBGLpC3473gKkEp78xsdo27/FHF
         h5L2KEOrA7YgHrGKkhMWrBLqMSjM4DpYw3xtozGwfkvG5cu7S4e8fPWcFH/nmr2I43tB
         JM0Q==
X-Gm-Message-State: ABy/qLYBlJEme3Dcpv8UDHRPNXKJyzM7wwvXOqSOz/1JirRIaYmFlySf
        Fp50uAq+svxmypFFhzND0FkKD3XYC2myLSKVpjUm3aSUTSWpB+maZvZ0pAnWy4aOcDi/MAqCLEn
        Fw4Egoy31mBZpJnXLM4WRebl+oDOoBtJPI0ZonMtli40CqbUENw5CZDodyjFRvOc=
X-Google-Smtp-Source: APBJJlHZkeGI6qDI629XxhlWciV0q9EsmLumN12aqI58BPiK4vF5BcNMkpk4Q6/u1ryyNzBkmmAm1otV4hn+VQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:ea08:b0:1bb:c7c5:3eb6 with SMTP
 id s8-20020a170902ea0800b001bbc7c53eb6mr47992plg.7.1690847382358; Mon, 31 Jul
 2023 16:49:42 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:46:37 -0700
In-Reply-To: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731234910.94149-1-chooglen@google.com>
Subject: [RFC PATCH v1.5 0/5] config-parse: create config parsing library
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll be leaving Google soon, so I won't be pushing this series through to
completion :/ As such, here's an rfc-quality 'reroll' to demonstrate how I
intended to respond to the comments on v1 2/2 that discussed where the library
boundary should be [1]. In particular:

> - "respect_includes" is in the library, but callers might want to opt
>   out of it or provide an alternative way to resolve includes.

I've punted on this altogether by removing "respect_includes" from the options
accepted by the library functions. As 2/5 describes, config_options is quite
bloated, so this split already makes sense even without config-parse.

Initially, I considered turning the "includes" machinery into a first-class
citizen in config-parse instead of having it implemented as a separate config
callback, but it turned out to be much more complicated than it first appears.
The biggest challenge is that as "hasconfig:remote.*url" performs the additional
pass over the config files, it performs different actions - from the starting
file, it collects remote urls, then in files that could be imported via
"hasconfig:remote.*url", it forbid remote urls. This 'action switching' didn't
translate well into the lower level machinery, so I opted to leave this for
later.

> - There is a lot of error reporting capability with respect to the
>   source of config, and not all sources are applicable to library
>   users. How should we proceed? E.g. should we expect that all library
>   users conform to the list here (e.g. even if the source is something
>   like but not exactly STDIN, they should pick it), or allow users to
>   customize sources?

I've opted to move the error reporting to a callback function (3/5), so in-tree
callers will use the existing logic, but other callers can provide their own
error handling. I've reused the config 'event listeners' for this purpose since
they seemed pretty well-suited to the task - they already respond to errors, and
the in-tree error handling doesn't do anything that an event listener can't
express.

As a result, the library now excludes functions that use the in-tree error
handling; we either teach the function to accept event listeners or exclude it
altogether.

[1] https://lore.kernel.org/git/20230721003107.3095493-1-jonathantanmy@google.com

Glen Choo (5):
  config: return positive from git_config_parse_key()
  config: split out config_parse_options
  config: report config parse errors using cb
  config.c: accept config_parse_options in git_config_from_stdin
  config-parse: split library out of config.[c|h]

 Makefile           |   1 +
 builtin/config.c   |   7 +-
 bundle-uri.c       |   4 +-
 config-parse.c     | 561 ++++++++++++++++++++++++++++++++++++++
 config-parse.h     | 155 +++++++++++
 config.c           | 660 ++++-----------------------------------------
 config.h           | 134 +--------
 fsck.c             |   4 +-
 submodule-config.c |  13 +-
 t/t1300-config.sh  |  16 ++
 10 files changed, 816 insertions(+), 739 deletions(-)
 create mode 100644 config-parse.c
 create mode 100644 config-parse.h

Range-diff:
1:  9924481630 = 1:  9924481630 config: return positive from git_config_parse_key()
-:  ---------- > 2:  8807be8319 config: split out config_parse_options
-:  ---------- > 3:  3d4a2357f3 config: report config parse errors using cb
-:  ---------- > 4:  ff03ee1de7 config.c: accept config_parse_options in git_config_from_stdin
2:  4461d2163e ! 5:  377acbfbb5 config-parse: split library out of config.[c|h]
    @@ config-parse.c (new)
     +struct parse_event_data {
     +	enum config_event_t previous_type;
     +	size_t previous_offset;
    -+	const struct config_options *opts;
    ++	const struct config_parse_options *opts;
     +};
     +
     +static int do_event(struct config_source *cs, enum config_event_t type,
    @@ config-parse.c (new)
     +
     +static int git_parse_source(struct config_source *cs, config_fn_t fn,
     +			    struct key_value_info *kvi, void *data,
    -+			    const struct config_options *opts)
    ++			    const struct config_parse_options *opts)
     +{
     +	int comment = 0;
     +	size_t baselen = 0;
     +	struct strbuf *var = &cs->var;
    -+	int error_return = 0;
    -+	char *error_msg = NULL;
     +
     +	/* U+FEFF Byte Order Mark in UTF8 */
     +	const char *bomptr = utf8_bom;
    @@ config-parse.c (new)
     +		if (get_value(cs, kvi, fn, data, var) < 0)
     +			break;
     +	}
    -+
    -+	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
    -+		return -1;
    -+
    -+	switch (cs->origin_type) {
    -+	case CONFIG_ORIGIN_BLOB:
    -+		error_msg = xstrfmt(_("bad config line %d in blob %s"),
    -+				      cs->linenr, cs->name);
    -+		break;
    -+	case CONFIG_ORIGIN_FILE:
    -+		error_msg = xstrfmt(_("bad config line %d in file %s"),
    -+				      cs->linenr, cs->name);
    -+		break;
    -+	case CONFIG_ORIGIN_STDIN:
    -+		error_msg = xstrfmt(_("bad config line %d in standard input"),
    -+				      cs->linenr);
    -+		break;
    -+	case CONFIG_ORIGIN_SUBMODULE_BLOB:
    -+		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
    -+				       cs->linenr, cs->name);
    -+		break;
    -+	case CONFIG_ORIGIN_CMDLINE:
    -+		error_msg = xstrfmt(_("bad config line %d in command line %s"),
    -+				       cs->linenr, cs->name);
    -+		break;
    -+	default:
    -+		error_msg = xstrfmt(_("bad config line %d in %s"),
    -+				      cs->linenr, cs->name);
    -+	}
    -+
    -+	switch (opts && opts->error_action ?
    -+		opts->error_action :
    -+		cs->default_error_action) {
    -+	case CONFIG_ERROR_DIE:
    -+		die("%s", error_msg);
    -+		break;
    -+	case CONFIG_ERROR_ERROR:
    -+		error_return = error("%s", error_msg);
    -+		break;
    -+	case CONFIG_ERROR_SILENT:
    -+		error_return = -1;
    -+		break;
    -+	case CONFIG_ERROR_UNSET:
    -+		BUG("config error action unset");
    -+	}
    -+
    -+	free(error_msg);
    -+	return error_return;
    ++	/*
    ++	 * FIXME for whatever reason, do_event passes the _previous_ event, so
    ++	 * in order for our callback to receive the error event, we have to call
    ++	 * do_event twice
    ++	 */
    ++	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    ++	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    ++	return -1;
     +}
     +
     +/*
    @@ config-parse.c (new)
     + */
     +static int do_config_from(struct config_source *top, config_fn_t fn,
     +			  void *data, enum config_scope scope,
    -+			  const struct config_options *opts)
    ++			  const struct config_parse_options *opts)
     +{
     +	struct key_value_info kvi = KVI_INIT;
     +	int ret;
    @@ config-parse.c (new)
     +			       const enum config_origin_type origin_type,
     +			       const char *name, const char *path, FILE *f,
     +			       void *data, enum config_scope scope,
    -+			       const struct config_options *opts)
    ++			       const struct config_parse_options *opts)
     +{
     +	struct config_source top = CONFIG_SOURCE_INIT;
     +	int ret;
    @@ config-parse.c (new)
     +	top.origin_type = origin_type;
     +	top.name = name;
     +	top.path = path;
    -+	top.default_error_action = CONFIG_ERROR_DIE;
     +	top.do_fgetc = config_file_fgetc;
     +	top.do_ungetc = config_file_ungetc;
     +	top.do_ftell = config_file_ftell;
    @@ config-parse.c (new)
     +	return ret;
     +}
     +
    -+int git_config_from_stdin(config_fn_t fn, void *data,
    -+			  enum config_scope scope)
    ++int git_config_from_stdin(config_fn_t fn, void *data, enum config_scope scope,
    ++			  const struct config_parse_options *config_opts)
     +{
     +	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
    -+				   data, scope, NULL);
    ++				   data, scope, config_opts);
     +}
     +
     +int git_config_from_file_with_options(config_fn_t fn, const char *filename,
     +				      void *data, enum config_scope scope,
    -+				      const struct config_options *opts)
    ++				      const struct config_parse_options *opts)
     +{
     +	int ret = -1;
     +	FILE *f;
    @@ config-parse.c (new)
     +	return ret;
     +}
     +
    -+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
    -+{
    -+	return git_config_from_file_with_options(fn, filename, data,
    -+						 CONFIG_SCOPE_UNKNOWN, NULL);
    -+}
    -+
     +int git_config_from_mem(config_fn_t fn,
     +			const enum config_origin_type origin_type,
     +			const char *name, const char *buf, size_t len,
     +			void *data, enum config_scope scope,
    -+			const struct config_options *opts)
    ++			const struct config_parse_options *opts)
     +{
     +	struct config_source top = CONFIG_SOURCE_INIT;
     +
    @@ config-parse.c (new)
     +	top.origin_type = origin_type;
     +	top.name = name;
     +	top.path = NULL;
    -+	top.default_error_action = CONFIG_ERROR_ERROR;
     +	top.do_fgetc = config_buf_fgetc;
     +	top.do_ungetc = config_buf_ungetc;
     +	top.do_ftell = config_buf_ftell;
    @@ config-parse.h (new)
     +/*
     + * Low level config parsing.
     + */
    -+#ifndef CONFIG_LIB_H
    -+#define CONFIG_LIB_H
    ++#ifndef CONFIG_PARSE_H
    ++#define CONFIG_PARSE_H
     +
     +#include "strbuf.h"
     +
    @@ config-parse.h (new)
     +					struct config_source *cs,
     +					void *event_fn_data);
     +
    -+struct config_options {
    -+	unsigned int respect_includes : 1;
    -+	unsigned int ignore_repo : 1;
    -+	unsigned int ignore_worktree : 1;
    -+	unsigned int ignore_cmdline : 1;
    -+	unsigned int system_gently : 1;
    -+
    -+	/*
    -+	 * For internal use. Include all includeif.hasremoteurl paths without
    -+	 * checking if the repo has that remote URL, and when doing so, verify
    -+	 * that files included in this way do not configure any remote URLs
    -+	 * themselves.
    -+	 */
    -+	unsigned int unconditional_remote_url : 1;
    -+
    -+	const char *commondir;
    -+	const char *git_dir;
    ++struct config_parse_options {
     +	/*
     +	 * event_fn and event_fn_data are for internal use only. Handles events
     +	 * emitted by the config parser.
     +	 */
     +	config_parser_event_fn_t event_fn;
     +	void *event_fn_data;
    -+	enum config_error_action {
    -+		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
    -+		CONFIG_ERROR_DIE, /* die() on error */
    -+		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
    -+		CONFIG_ERROR_SILENT, /* return -1 */
    -+	} error_action;
     +};
     +
     +struct config_source {
    @@ config-parse.h (new)
     +	enum config_origin_type origin_type;
     +	const char *name;
     +	const char *path;
    -+	enum config_error_action default_error_action;
     +	int linenr;
     +	int eof;
     +	size_t total_len;
    @@ config-parse.h (new)
     +typedef int (*config_fn_t)(const char *, const char *,
     +			   const struct config_context *, void *);
     +
    -+/**
    -+ * Read a specific file in git-config format.
    -+ */
    -+int git_config_from_file(config_fn_t fn, const char *, void *);
    -+
     +int git_config_from_file_with_options(config_fn_t fn, const char *,
     +				      void *, enum config_scope,
    -+				      const struct config_options *);
    ++				      const struct config_parse_options *);
     +
     +int git_config_from_mem(config_fn_t fn,
     +			const enum config_origin_type,
     +			const char *name,
     +			const char *buf, size_t len,
     +			void *data, enum config_scope scope,
    -+			const struct config_options *opts);
    ++			const struct config_parse_options *opts);
     +
    -+int git_config_from_stdin(config_fn_t fn, void *data, enum config_scope scope);
    ++int git_config_from_stdin(config_fn_t fn, void *data, enum config_scope scope,
    ++			  const struct config_parse_options *config_opts);
     +
    -+#endif /* CONFIG_LIB_H */
    ++#endif /* CONFIG_PARSE_H */
     
      ## config.c ##
     @@
    @@ config.c
     -	enum config_origin_type origin_type;
     -	const char *name;
     -	const char *path;
    --	enum config_error_action default_error_action;
     -	int linenr;
     -	int eof;
     -	size_t total_len;
    @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     -struct parse_event_data {
     -	enum config_event_t previous_type;
     -	size_t previous_offset;
    --	const struct config_options *opts;
    +-	const struct config_parse_options *opts;
     -};
     -
     -static int do_event(struct config_source *cs, enum config_event_t type,
    @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     -	out->path = cs->path;
     -}
     -
    + int git_config_err_fn(enum config_event_t type, size_t begin_offset UNUSED,
    + 		      size_t end_offset UNUSED, struct config_source *cs,
    + 		      void *data)
    +@@ config.c: int git_config_err_fn(enum config_event_t type, size_t begin_offset UNUSED,
    + 	return error_return;
    + }
    + 
     -static int git_parse_source(struct config_source *cs, config_fn_t fn,
     -			    struct key_value_info *kvi, void *data,
    --			    const struct config_options *opts)
    +-			    const struct config_parse_options *opts)
     -{
     -	int comment = 0;
     -	size_t baselen = 0;
     -	struct strbuf *var = &cs->var;
    --	int error_return = 0;
    --	char *error_msg = NULL;
     -
     -	/* U+FEFF Byte Order Mark in UTF8 */
     -	const char *bomptr = utf8_bom;
    @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     -			break;
     -	}
     -
    --	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
    --		return -1;
    --
    --	switch (cs->origin_type) {
    --	case CONFIG_ORIGIN_BLOB:
    --		error_msg = xstrfmt(_("bad config line %d in blob %s"),
    --				      cs->linenr, cs->name);
    --		break;
    --	case CONFIG_ORIGIN_FILE:
    --		error_msg = xstrfmt(_("bad config line %d in file %s"),
    --				      cs->linenr, cs->name);
    --		break;
    --	case CONFIG_ORIGIN_STDIN:
    --		error_msg = xstrfmt(_("bad config line %d in standard input"),
    --				      cs->linenr);
    --		break;
    --	case CONFIG_ORIGIN_SUBMODULE_BLOB:
    --		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
    --				       cs->linenr, cs->name);
    --		break;
    --	case CONFIG_ORIGIN_CMDLINE:
    --		error_msg = xstrfmt(_("bad config line %d in command line %s"),
    --				       cs->linenr, cs->name);
    --		break;
    --	default:
    --		error_msg = xstrfmt(_("bad config line %d in %s"),
    --				      cs->linenr, cs->name);
    --	}
    --
    --	switch (opts && opts->error_action ?
    --		opts->error_action :
    --		cs->default_error_action) {
    --	case CONFIG_ERROR_DIE:
    --		die("%s", error_msg);
    --		break;
    --	case CONFIG_ERROR_ERROR:
    --		error_return = error("%s", error_msg);
    --		break;
    --	case CONFIG_ERROR_SILENT:
    --		error_return = -1;
    --		break;
    --	case CONFIG_ERROR_UNSET:
    --		BUG("config error action unset");
    --	}
    --
    --	free(error_msg);
    --	return error_return;
    +-	/*
    +-	 * FIXME for whatever reason, do_event passes the _previous_ event, so
    +-	 * in order for our callback to receive the error event, we have to call
    +-	 * do_event twice
    +-	 */
    +-	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    +-	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    +-	return -1;
     -}
     -
      static uintmax_t get_unit_factor(const char *end)
    @@ config.c: int git_default_config(const char *var, const char *value,
     - */
     -static int do_config_from(struct config_source *top, config_fn_t fn,
     -			  void *data, enum config_scope scope,
    --			  const struct config_options *opts)
    +-			  const struct config_parse_options *opts)
     -{
     -	struct key_value_info kvi = KVI_INIT;
     -	int ret;
    @@ config.c: int git_default_config(const char *var, const char *value,
     -			       const enum config_origin_type origin_type,
     -			       const char *name, const char *path, FILE *f,
     -			       void *data, enum config_scope scope,
    --			       const struct config_options *opts)
    +-			       const struct config_parse_options *opts)
     -{
     -	struct config_source top = CONFIG_SOURCE_INIT;
     -	int ret;
    @@ config.c: int git_default_config(const char *var, const char *value,
     -	top.origin_type = origin_type;
     -	top.name = name;
     -	top.path = path;
    --	top.default_error_action = CONFIG_ERROR_DIE;
     -	top.do_fgetc = config_file_fgetc;
     -	top.do_ungetc = config_file_ungetc;
     -	top.do_ftell = config_file_ftell;
    @@ config.c: int git_default_config(const char *var, const char *value,
     -}
     -
     -static int git_config_from_stdin(config_fn_t fn, void *data,
    --				 enum config_scope scope)
    +-				 enum config_scope scope,
    +-				 const struct config_parse_options *config_opts)
     -{
     -	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
    --				   data, scope, NULL);
    +-				   data, scope, config_opts);
     -}
     -
     -int git_config_from_file_with_options(config_fn_t fn, const char *filename,
     -				      void *data, enum config_scope scope,
    --				      const struct config_options *opts)
    +-				      const struct config_parse_options *opts)
     -{
     -	int ret = -1;
     -	FILE *f;
    @@ config.c: int git_default_config(const char *var, const char *value,
     -	return ret;
     -}
     -
    --int git_config_from_file(config_fn_t fn, const char *filename, void *data)
    --{
    --	return git_config_from_file_with_options(fn, filename, data,
    --						 CONFIG_SCOPE_UNKNOWN, NULL);
    --}
    --
    + int git_config_from_file(config_fn_t fn, const char *filename, void *data)
    + {
    + 	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
    +@@ config.c: int git_config_from_file(config_fn_t fn, const char *filename, void *data)
    + 						 CONFIG_SCOPE_UNKNOWN, &config_opts);
    + }
    + 
     -int git_config_from_mem(config_fn_t fn,
     -			const enum config_origin_type origin_type,
     -			const char *name, const char *buf, size_t len,
     -			void *data, enum config_scope scope,
    --			const struct config_options *opts)
    +-			const struct config_parse_options *opts)
     -{
     -	struct config_source top = CONFIG_SOURCE_INIT;
     -
    @@ config.c: int git_default_config(const char *var, const char *value,
     -	top.origin_type = origin_type;
     -	top.name = name;
     -	top.path = NULL;
    --	top.default_error_action = CONFIG_ERROR_ERROR;
     -	top.do_fgetc = config_buf_fgetc;
     -	top.do_ungetc = config_buf_ungetc;
     -	top.do_ftell = config_buf_ftell;
    @@ config.h: struct git_config_source {
     -					struct config_source *cs,
     -					void *event_fn_data);
     -
    --struct config_options {
    --	unsigned int respect_includes : 1;
    --	unsigned int ignore_repo : 1;
    --	unsigned int ignore_worktree : 1;
    --	unsigned int ignore_cmdline : 1;
    --	unsigned int system_gently : 1;
    --
    --	/*
    --	 * For internal use. Include all includeif.hasremoteurl paths without
    --	 * checking if the repo has that remote URL, and when doing so, verify
    --	 * that files included in this way do not configure any remote URLs
    --	 * themselves.
    --	 */
    --	unsigned int unconditional_remote_url : 1;
    --
    --	const char *commondir;
    --	const char *git_dir;
    +-struct config_parse_options {
     -	/*
     -	 * event_fn and event_fn_data are for internal use only. Handles events
     -	 * emitted by the config parser.
     -	 */
     -	config_parser_event_fn_t event_fn;
     -	void *event_fn_data;
    --	enum config_error_action {
    --		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
    --		CONFIG_ERROR_DIE, /* die() on error */
    --		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
    --		CONFIG_ERROR_SILENT, /* return -1 */
    --	} error_action;
     -};
    +-
    + #define CP_OPTS_INIT(error_action) { \
    + 	.event_fn = git_config_err_fn, \
    + 	.event_fn_data = (enum config_error_action []){(error_action)}, \
    +@@ config.h: enum config_error_action {
    + int git_config_err_fn(enum config_event_t type, size_t begin_offset,
    + 		      size_t end_offset, struct config_source *cs,
    + 		      void *event_fn_data);
     -
     -/* Config source metadata for a given config key-value pair */
     -struct key_value_info {
    @@ config.h: struct git_config_source {
     -
      int git_default_config(const char *, const char *,
      		       const struct config_context *, void *);
    - 
    --/**
    -- * Read a specific file in git-config format.
    -- * This function takes the same callback and data parameters as `git_config`.
    -- *
    -- * Unlike git_config(), this function does not respect includes.
    -- */
    --int git_config_from_file(config_fn_t fn, const char *, void *);
    +-
    + /**
    +  * Read a specific file in git-config format.
    +  * This function takes the same callback and data parameters as `git_config`.
    +@@ config.h: int git_default_config(const char *, const char *,
    +  * Unlike git_config(), this function does not respect includes.
    +  */
    + int git_config_from_file(config_fn_t fn, const char *, void *);
     -
     -int git_config_from_file_with_options(config_fn_t fn, const char *,
     -				      void *, enum config_scope,
    --				      const struct config_options *);
    +-				      const struct config_parse_options *);
     -int git_config_from_mem(config_fn_t fn,
     -			const enum config_origin_type,
     -			const char *name,
     -			const char *buf, size_t len,
     -			void *data, enum config_scope scope,
    --			const struct config_options *opts);
    +-			const struct config_parse_options *opts);
      int git_config_from_blob_oid(config_fn_t fn, const char *name,
      			     struct repository *repo,
      			     const struct object_id *oid, void *data,

base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
-- 
2.41.0.585.gd2178a4bd4-goog

