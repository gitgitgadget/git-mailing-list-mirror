Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17F286A6
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720489887; cv=none; b=Bn7MdYZK3bMCEtFgpMNgrOcUDF03JZTzHWdBJ9cso2nUwNgJaomLyh3ez254x4Xy2z1naPVVEXrekolFdaPKjBSJ6iiE35y48EC89pzdbYE46xulVzU0ukWu+tnpWJcCRPPQM/amMu7+gvmDzDJci5TX4XXCAVcvhXfNXXmPIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720489887; c=relaxed/simple;
	bh=971UGKGGq/z2u8escZeiBR8TlLirLfDgEiSgdw0+I5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQocVBGoPZzyWTMxxxLi/kx6V5YGzR0khBBj14mhdLrrhGkchN/AJOwoGDhERFWuuMyAI3Cw+9a6ctj6FZTehVofv8K6nytI99PGkVauncfwTMp1GSiJQy4PDMul3yu2EAZLc8a9vDOyfWIZl8K61oSeqaBHsV9vE2jP1AuCvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5uIVSHW; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5uIVSHW"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c661e75ff6so1687779eaf.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 18:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720489884; x=1721094684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9uz7CszfNLNu2iv6Sxm49zavPzB5RJpGCss/oO9GQg=;
        b=N5uIVSHWCAHSPOox3MXB3mwIxsyePkZ85R0ex4ksCU2GQSR/U0V718oYO+5G+gA8E6
         4PmEDUBh3NG1vN0mGo4KxVkLIF584SnZN/RFNMlZPlgLgZgEml7The5V6XkrGHlcnmFT
         TL0KZajDnZKqV+yRsTUDkL5r5ukmNi9q848fsp/m++xp7ZdUTE8kcZBnnAuILPANSJol
         EKfLFKwOza9OjubuQpTc/zECmx0PbMox9w3H0vHXm1m+gCZI3Nu0V/jc1U608NlHnmuJ
         899JJh4KDtwynIKrA3nIA2W5dfTDgrWuQouCf93HD28mYsFU/HFZsDcggZ+PPzX7cSmg
         uHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720489884; x=1721094684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9uz7CszfNLNu2iv6Sxm49zavPzB5RJpGCss/oO9GQg=;
        b=jFIVzFpCm97M5X5m8tNBCACThW1QpxBNx1J4Hqcgd5rTAHj7YLt9qrWCTdlxavl3hc
         X/d/NUimqrX3NeItgk9m1M6FwTJgZ8x00HGDkaW9Cx1gKI27XbCsLkS3iqAVRNUxh+zD
         zQ5WMi3E86JPpkTFgdvSWHlUwcYHelbm8i25eQjKi1aEI78cscGzSds52SHePHZQkhwP
         Jni8kx56AfOxcTkWwyvcZ+ssSP6NinXj3Z9uZGdYtwN5gAxXtQ7+jRD1mCjCGXKqqruC
         INbE2wESHO56kOmyUdpfUG0z8QZ/mh3HzRpnR0XFCWhQ8zKC966lLp2MyzfpjACgKAen
         3vMw==
X-Gm-Message-State: AOJu0YxmhfaXbjp23fmcA+TB0Z5L+OGzTX9AGQaQO2lkgIe8n6OblTn8
	bFuxfXdafvSKMXX1/6a/5I/13+GkXV8aBDayQlsi30bhEQIJEnVe
X-Google-Smtp-Source: AGHT+IH7gVjwjJIuxu3ijxZgp7UvmGFilX+P/crYigsXIilUQsVEq51M5KzwXLG+4PaJL9yoVF6yPQ==
X-Received: by 2002:a05:6870:75c9:b0:254:b337:eebc with SMTP id 586e51a60fabf-25eae9d7fcbmr682940fac.35.1720489883663;
        Mon, 08 Jul 2024 18:51:23 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa225876sm307981fac.41.2024.07.08.18.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:51:22 -0700 (PDT)
Date: Mon, 8 Jul 2024 20:50:53 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 6/6] cat-file: add remote-object-info to batch-command
Message-ID: <7lc6m7627sojdzabmz6pvaulbrcods6tqf7bnf3vxqsxzievjl@ixbispu2b3ch>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-7-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628190503.67389-7-eric.peijian@gmail.com>

On 24/06/28 03:05PM, Eric Ju wrote:
> From: Calvin Wan <calvinwan@google.com>
> 
> Since the `info` command in cat-file --batch-command prints object info
> for a given object, it is natural to add another command in cat-file
> --batch-command to print object info for a given object from a remote.
> Add `remote-object-info` to cat-file --batch-command.
> 
> While `info` takes object ids one at a time, this creates overhead when
> making requests to a server so `remote-object-info` instead can take
> multiple object ids at once.
> 
> cat-file --batch-command is generally implemented in the following
> manner:
> 
>  - Receive and parse input from user
>  - Call respective function attached to command
>  - Set batch mode state, get object info, print object info
> 
> In --buffer mode, this changes to:
> 
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue
>     - Call respective function attached to command
>     - Set batch mode state, get object info, print object info

So the problem is that there is overhead associated with getting object
info from the remote. Therefore, remote-object-info also supports
batching objects together. This seems reasonable.

> 
> Notice how the getting and printing of object info is accomplished one
> at a time. As described above, this creates a problem for making
> requests to a server. Therefore, `remote-object-info` is implemented in
> the following manner:
> 
>  - Receive and parse input from user
>  If command is `remote-object-info`:
>     - Get object info from remote
>     - Loop through object info
>         - Call respective function attached to `info`
>         - Set batch mode state, use passed in object info, print object
>           info
>  Else:
>     - Call respective function attached to command
>     - Parse input, get object info, print object info
> 
> And finally for --buffer mode `remote-object-info`:
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue:
>     If command is `remote-object-info`:
>         - Get object info from remote
>         - Loop through object info
>             - Call respective function attached to `info`
>             - Set batch mode state, use passed in object info, print
>               object info
>     Else:
>         - Call respective function attached to command
>         - Set batch mode state, get object info, print object info
> 
> To summarize, `remote-object-info` gets object info from the remote and
> then generates multiple `info` commands with the object info passed in.
> 
> In order for remote-object-info to avoid remote communication overhead
> in the non-buffer mode, the objects are passed in as such:

Even in non-buffer mode, having separate remote-object-info commands
would result in additional overhead correct? From my understanding each
command is executed sequently, so multiples of remote-object-info would
always result in additional overhead.

> 
> remote-object-info <remote> <oid> <oid> ... <oid>
> 
> rather than
> 
> remote-object-info <remote> <oid>
> remote-object-info <remote> <oid>
> ...
> remote-object-info <remote> <oid>
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>

I think the sign-offs are supposed to go at the bottom.

[snip]
> @@ -526,51 +533,118 @@ static void batch_one_object(const char *obj_name,
>  		(opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
>  	enum get_oid_result result;
>  
> -	result = get_oid_with_context(the_repository, obj_name,
> -				      flags, &data->oid, &ctx);
> -	if (result != FOUND) {
> -		switch (result) {
> -		case MISSING_OBJECT:
> -			printf("%s missing%c", obj_name, opt->output_delim);
> -			break;
> -		case SHORT_NAME_AMBIGUOUS:
> -			printf("%s ambiguous%c", obj_name, opt->output_delim);
> -			break;
> -		case DANGLING_SYMLINK:
> -			printf("dangling %"PRIuMAX"%c%s%c",
> -			       (uintmax_t)strlen(obj_name),
> -			       opt->output_delim, obj_name, opt->output_delim);
> -			break;
> -		case SYMLINK_LOOP:
> -			printf("loop %"PRIuMAX"%c%s%c",
> -			       (uintmax_t)strlen(obj_name),
> -			       opt->output_delim, obj_name, opt->output_delim);
> -			break;
> -		case NOT_DIR:
> -			printf("notdir %"PRIuMAX"%c%s%c",
> -			       (uintmax_t)strlen(obj_name),
> -			       opt->output_delim, obj_name, opt->output_delim);
> -			break;
> -		default:
> -			BUG("unknown get_sha1_with_context result %d\n",
> -			       result);
> -			break;
> +	if (!opt->use_remote_info) {

When using the remote-object-info command, the object in question is
supposed to be on the remote and may not exist locally. Therefore we
skip over `get_oid_with_context()`.

> +		result = get_oid_with_context(the_repository, obj_name,
> +						flags, &data->oid, &ctx);
> +		if (result != FOUND) {
> +			switch (result) {
> +			case MISSING_OBJECT:
> +				printf("%s missing%c", obj_name, opt->output_delim);
> +				break;
> +			case SHORT_NAME_AMBIGUOUS:
> +				printf("%s ambiguous%c", obj_name, opt->output_delim);
> +				break;
> +			case DANGLING_SYMLINK:
> +				printf("dangling %"PRIuMAX"%c%s%c",
> +					(uintmax_t)strlen(obj_name),
> +					opt->output_delim, obj_name, opt->output_delim);
> +				break;
> +			case SYMLINK_LOOP:
> +				printf("loop %"PRIuMAX"%c%s%c",
> +					(uintmax_t)strlen(obj_name),
> +					opt->output_delim, obj_name, opt->output_delim);
> +				break;
> +			case NOT_DIR:
> +				printf("notdir %"PRIuMAX"%c%s%c",
> +					(uintmax_t)strlen(obj_name),
> +					opt->output_delim, obj_name, opt->output_delim);
> +				break;
> +			default:
> +				BUG("unknown get_sha1_with_context result %d\n",
> +					result);
> +				break;
> +			}
> +			fflush(stdout);
> +			return;
>  		}
> -		fflush(stdout);
> -		return;
> -	}
>  
> -	if (ctx.mode == 0) {
> -		printf("symlink %"PRIuMAX"%c%s%c",
> -		       (uintmax_t)ctx.symlink_path.len,
> -		       opt->output_delim, ctx.symlink_path.buf, opt->output_delim);
> -		fflush(stdout);
> -		return;
> +		if (ctx.mode == 0) {
> +			printf("symlink %"PRIuMAX"%c%s%c",
> +				(uintmax_t)ctx.symlink_path.len,
> +				opt->output_delim, ctx.symlink_path.buf, opt->output_delim);
> +			fflush(stdout);
> +			return;
> +		}
>  	}
>  
>  	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
>  }
>  
> +static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
> +{
> +	int retval = 0;
> +	struct remote *remote = NULL;
> +	struct object_id oid;
> +	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> +	static struct transport *gtransport;
> +
> +	/*
> +	 * Change the format to "%(objectname) %(objectsize)" when
> +	 * remote-object-info command is used. Once we start supporting objecttype
> +	 * the default format should change to DEFAULT_FORMAT
> +	*/
> +	if (!opt->format) {
> +		opt->format = "%(objectname) %(objectsize)";
> +	}

We should omit the parenthesis for single line if statements.

> +
> +	remote = remote_get(argv[0]);
> +	if (!remote)
> +		die(_("must supply valid remote when using remote-object-info"));
> +	oid_array_clear(&object_info_oids);
> +	for (size_t i = 1; i < argc; i++) {
> +		if (get_oid_hex(argv[i], &oid))
> +			die(_("Not a valid object name %s"), argv[i]);
> +		oid_array_append(&object_info_oids, &oid);
> +	}
> +
> +	gtransport = transport_get(remote, NULL);
> +	if (gtransport->smart_options) {
> +		int include_size = 0;
> +
> +		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> +		gtransport->smart_options->object_info = 1;
> +		gtransport->smart_options->object_info_oids = &object_info_oids;
> +		/*
> +		 * 'size' is the only option currently supported.
> +		 * Other options that are passed in the format will exit with error.
> +		 */
> +		if (strstr(opt->format, "%(objectsize)")) {
> +			string_list_append(&object_info_options, "size");
> +			include_size = 1;
> +		}
> +		if (strstr(opt->format, "%(objecttype)")) {
> +			die(_("objecttype is currently not supported with remote-object-info"));
> +		}

Another single line if statement above that should omit the parenthesis.

> +		if (strstr(opt->format, "%(objectsize:disk)"))
> +			die(_("objectsize:disk is currently not supported with remote-object-info"));
> +		if (strstr(opt->format, "%(deltabase)"))
> +			die(_("deltabase is currently not supported with remote-object-info"));
> +		if (object_info_options.nr > 0) {
> +			gtransport->smart_options->object_info_options = &object_info_options;
> +			for (size_t i = 0; i < object_info_oids.nr; i++) {
> +				if (include_size)
> +					remote_object_info[i].sizep = xcalloc(1, sizeof(long));
> +			}
> +			gtransport->smart_options->object_info_data = &remote_object_info;
> +			retval = transport_fetch_refs(gtransport, NULL);
> +		}
> +	} else {
> +		retval = -1;
> +	}
> +
> +	return retval;
> +}
> +
>  struct object_cb_data {
>  	struct batch_options *opt;
>  	struct expand_data *expand;
> @@ -642,6 +716,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
>  struct queued_cmd {
>  	parse_cmd_fn_t fn;
>  	char *line;
> +	const char *name;

Since special handling is needed for the remote-object-info command, we
record the queued command names to check against later.

>  };
>  
>  static void parse_cmd_contents(struct batch_options *opt,
> @@ -662,6 +737,55 @@ static void parse_cmd_info(struct batch_options *opt,
>  	batch_one_object(line, output, opt, data);
>  }
>  
> +static const struct parse_cmd {
> +	const char *name;
> +	parse_cmd_fn_t fn;
> +	unsigned takes_args;
> +} commands[] = {
> +	{ "contents", parse_cmd_contents, 1 },
> +	{ "info", parse_cmd_info, 1 },
> +	{ "remote-object-info", parse_cmd_info, 1 },
> +	{ "flush", NULL, 0 },
> +};
> +
> +static void parse_remote_info(struct batch_options *opt,
> +			   char *line,
> +			   struct strbuf *output,
> +			   struct expand_data *data,
> +			   const struct parse_cmd *p_cmd,
> +			   struct queued_cmd *q_cmd)

It seems a little confusing to me that `parse_remote_info()` accepts 
both a `parse_cmd` and `queued_cmd`, but only expects to use one or the
other. It looks like this is done because `dispatch_calls()` already 
accepts `queued_cmd`, but now needs to call `parse_remote_info()`. 

Since it is only the underlying command function that is needed by
`parse_remote_info()`

> +{
> +	int count;
> +	const char **argv;
> +
> +	count = split_cmdline(line, &argv);
> +	if (get_remote_info(opt, count, argv))
> +		goto cleanup;
> +	opt->use_remote_info = 1;
> +	data->skip_object_info = 1;
> +	data->mark_query = 0;
> +	for (size_t i = 0; i < object_info_oids.nr; i++) {
> +		if (remote_object_info[i].sizep)
> +			data->size = *remote_object_info[i].sizep;
> +		if (remote_object_info[i].typep)
> +			data->type = *remote_object_info[i].typep;
> +
> +		data->oid = object_info_oids.oid[i];
> +		if (p_cmd)
> +			p_cmd->fn(opt, argv[i+1], output, data);
> +		else
> +			q_cmd->fn(opt, argv[i+1], output, data);
> +	}
> +	opt->use_remote_info = 0;
> +	data->skip_object_info = 0;
> +	data->mark_query = 1;
> +
> +cleanup:
> +	for (size_t i = 0; i < object_info_oids.nr; i++)
> +		free_object_info_contents(&remote_object_info[i]);
> +	free(remote_object_info);
> +}
> +
>  static void dispatch_calls(struct batch_options *opt,
>  		struct strbuf *output,
>  		struct expand_data *data,
> @@ -671,8 +795,12 @@ static void dispatch_calls(struct batch_options *opt,
>  	if (!opt->buffer_output)
>  		die(_("flush is only for --buffer mode"));
>  
> -	for (int i = 0; i < nr; i++)
> -		cmd[i].fn(opt, cmd[i].line, output, data);
> +	for (int i = 0; i < nr; i++) {
> +		if (!strcmp(cmd[i].name, "remote-object-info"))
> +			parse_remote_info(opt, cmd[i].line, output, data, NULL, &cmd[i]);

If we adapt `parse_remote_info()` to accept the command function we
could pass cmd->fn here instead.

> +		else
> +			cmd[i].fn(opt, cmd[i].line, output, data);
> +	}
>  
>  	fflush(stdout);
>  }
> @@ -685,17 +813,6 @@ static void free_cmds(struct queued_cmd *cmd, size_t *nr)
>  	*nr = 0;
>  }
>  
> -
> -static const struct parse_cmd {
> -	const char *name;
> -	parse_cmd_fn_t fn;
> -	unsigned takes_args;
> -} commands[] = {
> -	{ "contents", parse_cmd_contents, 1},
> -	{ "info", parse_cmd_info, 1},
> -	{ "flush", NULL, 0},
> -};
> -
>  static void batch_objects_command(struct batch_options *opt,
>  				    struct strbuf *output,
>  				    struct expand_data *data)
> @@ -740,11 +857,17 @@ static void batch_objects_command(struct batch_options *opt,
>  			dispatch_calls(opt, output, data, queued_cmd, nr);
>  			free_cmds(queued_cmd, &nr);
>  		} else if (!opt->buffer_output) {
> -			cmd->fn(opt, p, output, data);
> +			if (!strcmp(cmd->name, "remote-object-info")) {
> +				char *line = xstrdup_or_null(p);
> +				parse_remote_info(opt, line, output, data, cmd, NULL);

Same here, if we adapt `parse_remote_info()` to accept the command 
function we could pass cmd->fn here instead.

> +			} else {
> +				cmd->fn(opt, p, output, data);
> +			}
>  		} else {
>  			ALLOC_GROW(queued_cmd, nr + 1, alloc);
>  			call.fn = cmd->fn;
>  			call.line = xstrdup_or_null(p);
> +			call.name = cmd->name;
>  			queued_cmd[nr++] = call;
>  		}
>  	}
> @@ -761,8 +884,6 @@ static void batch_objects_command(struct batch_options *opt,
>  	strbuf_release(&input);
>  }
>  
> -#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
> -
>  static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf input = STRBUF_INIT;
[snip]
