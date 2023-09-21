Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8242CE7D0AE
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjIUVlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjIUVky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:40:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E5311C1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bdb9fe821so19660287b3.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695331047; x=1695935847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTb7TzYI2DyEHfKUbW4Ox9S+QM3620XaX/oBcW4DPH8=;
        b=m2xLQLIu4lnBXnmjXzqwweYDQfGmL8YpKV56+tsbasx8WxDfbK8YjybAaLab0A7JA0
         ZSqif9gKKlampIAkGocdwjTJ4Q1EU3obPu/UkO385FR8mLH0pq8QeHQa6amW/7zpxVD6
         O8TDQgoP9U/kItHKlI16uicGornYWrF7/e3fdyLKoTi2iMgG7rdRd8gy/oveh4zlGZHh
         22KDs2iJ0labHA/+B4obdG8Uv5AM9B7U1MhnvpR095RIcLkRcDB1dA6VxuzVewzb027F
         XVrVAXKZ42u5TfwezhcFo+9vu4zXuMv6RpbPTacp168tI4I4Xg/kYH+vv1GMdu/TreRv
         fhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331047; x=1695935847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTb7TzYI2DyEHfKUbW4Ox9S+QM3620XaX/oBcW4DPH8=;
        b=wGahJGZEGqhJj03GaKHwXc+ovhxo+T6/ZeWopgtCfMgoJOsjSdKxnHvjw/Pdr2EAj+
         2xhjwq5cTWVOz+3gLai4oy/p+2SXhUaVZTkdBppRrWBqSCPtL7YVDZbKASb5UG6x/Rpj
         6tY7rCa+AzZ5CbWjG+hGoERgGZMyOD3gpTB0q8Z93n8PyjgwImIfc2kBebplSA4/5rG3
         i4ZuZzqclZDfl4TSjBvzMk2A6fdbEKtfNP46WTvC0xhvNyypeeP9dj/Vr3EGswwtJreu
         hXm2Z8mbUlQIlN5JluBxtqfM7o8VlhHMo4aOaxrR/178r/rJnaHsFU1/I3rEbaLPSJxi
         bFgw==
X-Gm-Message-State: AOJu0YwuKHu6KDt/wpTP+fEKHByJ1lT2koEuqfr+HMFucze9lEvZ5FgS
        W8ytGmCECzD7MyGoBgfJRDeFg0+863qvnmpu8JwtQcIewbnLbmiOYIskPNWPa6FmQgfNlwM0EDU
        NlW3WZLASY/+QuHfs7chIiS8bxDH+bB0gMC4YOesEdjJOu6GbFI6g2tl+yZ4gKds=
X-Google-Smtp-Source: AGHT+IFG7EOwBdKT6y3NVjJO450/vsfj3Lo5G4VIYTW5z8AWxhdBHdvGm16u6V3ZB/XwYgNAfadmV0k4ZUb1Qg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
 (user=steadmon job=sendgmr) by 2002:a81:9f01:0:b0:576:8cb6:62a9 with SMTP id
 s1-20020a819f01000000b005768cb662a9mr96609ywn.6.1695331046829; Thu, 21 Sep
 2023 14:17:26 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:17:19 -0700
In-Reply-To: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <cover.1695330852.git.steadmon@google.com>
Subject: [PATCH v3 0/5] config-parse: create config parsing library
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Config parsing no longer uses global state as of gc/config-context, so the
natural next step for libification is to turn that into its own library.
This series starts that process by moving config parsing into
config-parse.[c|h] so that other programs can include this functionality
without pulling in all of config.[c|h].

Open questions:
- How do folks feel about the do_event() refactor in patches 2 & 3?

Changes since v2:
- Added patch 2/5 to refactor do_event() into start_event() and
  flush_event().
- In patch 3/5, we can now add do_event_and_flush() to immediately run
  an event callback, rather than having to do_event() twice in a row.

Changes since v1.5:
- Dropped patch 1/5: config: return positive from git_config_parse_key()


Glen Choo (4):
  config: split out config_parse_options
  config: report config parse errors using cb
  config.c: accept config_parse_options in git_config_from_stdin
  config-parse: split library out of config.[c|h]

Josh Steadmon (1):
  config: split do_event() into start and flush operations

 Makefile           |   1 +
 builtin/config.c   |   4 +-
 bundle-uri.c       |   4 +-
 config-parse.c     | 601 +++++++++++++++++++++++++++++++++++++++++
 config-parse.h     | 155 +++++++++++
 config.c           | 658 ++++-----------------------------------------
 config.h           | 134 +--------
 fsck.c             |   4 +-
 submodule-config.c |   9 +-
 9 files changed, 836 insertions(+), 734 deletions(-)
 create mode 100644 config-parse.c
 create mode 100644 config-parse.h

Range-diff against v2:
1:  5c676fbac3 ! 1:  fa55b7836f config: split out config_parse_options
    @@ Metadata
      ## Commit message ##
         config: split out config_parse_options
     
    -    "struct config_options" is a disjoint set of options options used by the
    -    config parser (e.g. event listners) and options used by
    -    config_with_options() (e.g. to handle includes, choose which config
    -    files to parse). Split parser-only options into config_parse_options.
    +    "struct config_options" is a disjoint set of options used by the config
    +    parser (e.g. event listeners) and options used by config_with_options()
    +    (e.g. to handle includes, choose which config files to parse). Split
    +    parser-only options into config_parse_options.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## bundle-uri.c ##
-:  ---------- > 2:  8a1463c223 config: split do_event() into start and flush operations
2:  cb92a1f2e3 ! 3:  a888045c04 config: report config parse errors using cb
    @@ Commit message
         CONFIG_ERROR_UNSET and the config_source 'default', since all callers
         are now expected to specify the error handling they want.
     
    +    Add a new "do_event_and_flush" function for running event callbacks
    +    immediately, where the event does not need to calculate an end offset.
    +
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## builtin/config.c ##
    @@ config.c: static int add_remote_url(const char *var, const char *value,
      
      	opts = *inc->opts;
      	opts.unconditional_remote_url = 1;
    +@@ config.c: static int do_event(struct config_source *cs, enum config_event_t type,
    + 	return 0;
    + }
    + 
    ++static int do_event_and_flush(struct config_source *cs,
    ++			      enum config_event_t type,
    ++			      struct parse_event_data *data)
    ++{
    ++	int maybe_ret;
    ++
    ++	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    ++		return maybe_ret;
    ++
    ++	start_event(cs, type, data);
    ++
    ++	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    ++		return maybe_ret;
    ++
    ++	/*
    ++	 * Not actually EOF, but this indicates we don't have a valid event
    ++	 * to flush next time around.
    ++	 */
    ++	data->previous_type = CONFIG_EVENT_EOF;
    ++
    ++	return 0;
    ++}
    ++
    + static void kvi_from_source(struct config_source *cs,
    + 			    enum config_scope scope,
    + 			    struct key_value_info *out)
     @@ config.c: static void kvi_from_source(struct config_source *cs,
      	out->path = cs->path;
      }
    @@ config.c: static int git_parse_source(struct config_source *cs, config_fn_t fn,
     -
     -	free(error_msg);
     -	return error_return;
    -+	/*
    -+	 * FIXME for whatever reason, do_event passes the _previous_ event, so
    -+	 * in order for our callback to receive the error event, we have to call
    -+	 * do_event twice
    -+	 */
    -+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    -+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    ++	do_event_and_flush(cs, CONFIG_EVENT_ERROR, &event_data);
     +	return -1;
      }
      
    @@ config.c: void read_early_config(config_fn_t cb, void *data)
      void read_very_early_config(config_fn_t cb, void *data)
      {
     -	struct config_options opts = { 0 };
    +-
    +-	opts.respect_includes = 1;
    +-	opts.ignore_repo = 1;
    +-	opts.ignore_worktree = 1;
    +-	opts.ignore_cmdline = 1;
    +-	opts.system_gently = 1;
     +	struct config_options opts = {
    ++		.respect_includes = 1,
    ++		.ignore_repo = 1,
    ++		.ignore_worktree = 1,
    ++		.ignore_cmdline = 1,
    ++		.system_gently = 1,
     +		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
     +	};
      
    - 	opts.respect_includes = 1;
    - 	opts.ignore_repo = 1;
    + 	config_with_options(cb, data, NULL, NULL, &opts);
    + }
     @@ config.c: int git_configset_get_pathname(struct config_set *set, const char *key, const ch
      /* Functions use to read configuration from a repository */
      static void repo_read_config(struct repository *repo)
    @@ config.c: int git_configset_get_pathname(struct config_set *set, const char *key
      
      	opts.respect_includes = 1;
      	opts.commondir = repo->commondir;
    -@@ config.c: int repo_config_get_pathname(struct repository *repo,
    - static void read_protected_config(void)
    - {
    - 	struct config_options opts = {
    --		.respect_includes = 1,
    --		.ignore_repo = 1,
    --		.ignore_worktree = 1,
    --		.system_gently = 1,
    +@@ config.c: static void read_protected_config(void)
    + 		.ignore_repo = 1,
    + 		.ignore_worktree = 1,
    + 		.system_gently = 1,
     +		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
      	};
      
    -+	opts.respect_includes = 1;
    -+	opts.ignore_repo = 1;
    -+	opts.ignore_worktree = 1;
    -+	opts.system_gently = 1;
     +
      	git_configset_init(&protected_config);
      	config_with_options(config_set_callback, &protected_config, NULL,
3:  e034d0780c = 4:  49d4b64991 config.c: accept config_parse_options in git_config_from_stdin
4:  74c5dcd5a2 ! 5:  e59ca992d0 config-parse: split library out of config.[c|h]
    @@ config-parse.c (new)
     +	const struct config_parse_options *opts;
     +};
     +
    -+static int do_event(struct config_source *cs, enum config_event_t type,
    -+		    struct parse_event_data *data)
    ++static size_t get_corrected_offset(struct config_source *cs,
    ++				   enum config_event_t type)
     +{
    -+	size_t offset;
    -+
    -+	if (!data->opts || !data->opts->event_fn)
    -+		return 0;
    ++	size_t offset = cs->do_ftell(cs);
     +
    -+	if (type == CONFIG_EVENT_WHITESPACE &&
    -+	    data->previous_type == type)
    -+		return 0;
    -+
    -+	offset = cs->do_ftell(cs);
     +	/*
     +	 * At EOF, the parser always "inserts" an extra '\n', therefore
     +	 * the end offset of the event is the current file position, otherwise
    @@ config-parse.c (new)
     +	 */
     +	if (type != CONFIG_EVENT_EOF)
     +		offset--;
    ++	return offset;
    ++}
    ++
    ++static void start_event(struct config_source *cs, enum config_event_t type,
    ++		       struct parse_event_data *data)
    ++{
    ++	data->previous_type = type;
    ++	data->previous_offset = get_corrected_offset(cs, type);
    ++}
    ++
    ++static int flush_event(struct config_source *cs, enum config_event_t type,
    ++		       struct parse_event_data *data)
    ++{
    ++	if (!data->opts || !data->opts->event_fn)
    ++		return 0;
    ++
    ++	if (type == CONFIG_EVENT_WHITESPACE &&
    ++	    data->previous_type == type)
    ++		return 0;
     +
     +	if (data->previous_type != CONFIG_EVENT_EOF &&
     +	    data->opts->event_fn(data->previous_type, data->previous_offset,
    -+				 offset, cs, data->opts->event_fn_data) < 0)
    ++				 get_corrected_offset(cs, type), cs,
    ++				 data->opts->event_fn_data) < 0)
     +		return -1;
     +
    -+	data->previous_type = type;
    -+	data->previous_offset = offset;
    ++	return 1;
    ++}
    ++
    ++static int do_event(struct config_source *cs, enum config_event_t type,
    ++		    struct parse_event_data *data)
    ++{
    ++	int maybe_ret;
    ++
    ++	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    ++		return maybe_ret;
    ++
    ++	start_event(cs, type, data);
    ++
    ++	return 0;
    ++}
    ++
    ++static int do_event_and_flush(struct config_source *cs,
    ++			      enum config_event_t type,
    ++			      struct parse_event_data *data)
    ++{
    ++	int maybe_ret;
    ++
    ++	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    ++		return maybe_ret;
    ++
    ++	start_event(cs, type, data);
    ++
    ++	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    ++		return maybe_ret;
    ++
    ++	/*
    ++	 * Not actually EOF, but this indicates we don't have a valid event
    ++	 * to flush next time around.
    ++	 */
    ++	data->previous_type = CONFIG_EVENT_EOF;
     +
     +	return 0;
     +}
    @@ config-parse.c (new)
     +		if (get_value(cs, kvi, fn, data, var) < 0)
     +			break;
     +	}
    -+	/*
    -+	 * FIXME for whatever reason, do_event passes the _previous_ event, so
    -+	 * in order for our callback to receive the error event, we have to call
    -+	 * do_event twice
    -+	 */
    -+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    -+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    ++
    ++	do_event_and_flush(cs, CONFIG_EVENT_ERROR, &event_data);
     +	return -1;
     +}
     +
    @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     -	const struct config_parse_options *opts;
     -};
     -
    --static int do_event(struct config_source *cs, enum config_event_t type,
    --		    struct parse_event_data *data)
    +-static size_t get_corrected_offset(struct config_source *cs,
    +-				   enum config_event_t type)
     -{
    --	size_t offset;
    --
    --	if (!data->opts || !data->opts->event_fn)
    --		return 0;
    +-	size_t offset = cs->do_ftell(cs);
     -
    --	if (type == CONFIG_EVENT_WHITESPACE &&
    --	    data->previous_type == type)
    --		return 0;
    --
    --	offset = cs->do_ftell(cs);
     -	/*
     -	 * At EOF, the parser always "inserts" an extra '\n', therefore
     -	 * the end offset of the event is the current file position, otherwise
    @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     -	 */
     -	if (type != CONFIG_EVENT_EOF)
     -		offset--;
    +-	return offset;
    +-}
    +-
    +-static void start_event(struct config_source *cs, enum config_event_t type,
    +-		       struct parse_event_data *data)
    +-{
    +-	data->previous_type = type;
    +-	data->previous_offset = get_corrected_offset(cs, type);
    +-}
    +-
    +-static int flush_event(struct config_source *cs, enum config_event_t type,
    +-		       struct parse_event_data *data)
    +-{
    +-	if (!data->opts || !data->opts->event_fn)
    +-		return 0;
    +-
    +-	if (type == CONFIG_EVENT_WHITESPACE &&
    +-	    data->previous_type == type)
    +-		return 0;
     -
     -	if (data->previous_type != CONFIG_EVENT_EOF &&
     -	    data->opts->event_fn(data->previous_type, data->previous_offset,
    --				 offset, cs, data->opts->event_fn_data) < 0)
    +-				 get_corrected_offset(cs, type), cs,
    +-				 data->opts->event_fn_data) < 0)
     -		return -1;
     -
    --	data->previous_type = type;
    --	data->previous_offset = offset;
    +-	return 1;
    +-}
    +-
    +-static int do_event(struct config_source *cs, enum config_event_t type,
    +-		    struct parse_event_data *data)
    +-{
    +-	int maybe_ret;
    +-
    +-	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    +-		return maybe_ret;
    +-
    +-	start_event(cs, type, data);
    +-
    +-	return 0;
    +-}
    +-
    +-static int do_event_and_flush(struct config_source *cs,
    +-			      enum config_event_t type,
    +-			      struct parse_event_data *data)
    +-{
    +-	int maybe_ret;
    +-
    +-	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    +-		return maybe_ret;
    +-
    +-	start_event(cs, type, data);
    +-
    +-	if ((maybe_ret = flush_event(cs, type, data)) < 1)
    +-		return maybe_ret;
    +-
    +-	/*
    +-	 * Not actually EOF, but this indicates we don't have a valid event
    +-	 * to flush next time around.
    +-	 */
    +-	data->previous_type = CONFIG_EVENT_EOF;
     -
     -	return 0;
     -}
    @@ config.c: int git_config_err_fn(enum config_event_t type, size_t begin_offset UN
     -			break;
     -	}
     -
    --	/*
    --	 * FIXME for whatever reason, do_event passes the _previous_ event, so
    --	 * in order for our callback to receive the error event, we have to call
    --	 * do_event twice
    --	 */
    --	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    --	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
    +-	do_event_and_flush(cs, CONFIG_EVENT_ERROR, &event_data);
     -	return -1;
     -}
     -

base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
-- 
2.42.0.515.g380fc7ccd1-goog

