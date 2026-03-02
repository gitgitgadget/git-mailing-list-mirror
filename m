Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9193F0772
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463394; cv=none; b=Oynfw/n9UXxH23UZzHuCySkAEgsO2hLKGz/lsmOnxoiAITPNAPNiOUwpSNQi5BJmq4Ie4c5L1tGw7tngdicKifle5fgXt2NkYWdSdLVtJt2a/5RZCo/OmDNxikgL6fJHSB47t0dOU1qMti80fWiA3G+Gb3KfH6SwrSJd5417tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463394; c=relaxed/simple;
	bh=MszxJmDYxr4TcglCbkKInaoZfPXZ9NngMhPERAqI2sQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XTkDgcd7PbacIpZkpbXdwJDN8DvUKqN95StF3ZR06VUTDl6p7b5gwhjVEqiZM9XWMErxoZJvYbKnn7OjDrtZDI+d+blVyk72U25ZmrXSHKkfnUnTSF4uMnnOJ6Sm8iP5rukeYWX2yyllNb0f6o+8+UWjsAA3/g2RIo/S3T3Z5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+ALocto; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+ALocto"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4398c7083d7so4019148f8f.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772463391; x=1773068191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MP0J763jGMJ6LYopqfobm7CW3jW48qdaSM0pC4/2Z9g=;
        b=W+ALocto8U86PXk/Rh6wzCAscNQOUH5xonbsEeC1LA5c37h/KtjGT2rOH+lijWTZih
         0YEXKPFu1uPqqA9sPUDuhqHGo6C4LebbcaY9sWe/r2IXeYDC6lzn4guCMKWgfy3eCLLm
         rO6YPzcw+TgbUayuU/Q0CuAonSLa3Das4wdh2n99dYgQRquxYQggMGpi+MnJn+CESy4p
         IyIYlkOm07M/d+lW20yzyIdONiqWqWGqw4RWwvVaE1divqScP8GYa2PUpO7i72fmbLWX
         EajJoi+dQqCYvOCfMGw8k89MxnUAbyCmxXgT80GORCFf5kVInfETJjZEk2O3YI3w+Be3
         eTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463391; x=1773068191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MP0J763jGMJ6LYopqfobm7CW3jW48qdaSM0pC4/2Z9g=;
        b=AOFhY7H9Sk7Ttv5YemwgeGYQPLNgzmIJXp1Z8RrSiey9BCNAmzbpgEnIrV0BT2Z8eF
         ZCxMCKipasqwUmFZPADweU9yUMqzcJ1Bp79ISPlJHKuDyLoKppX2wVOihxM6+gbMokYJ
         JvDrda/uCakIwCS2W/mVhSuP/bZQmEmRF+d9TLoNhYdLvUhvmFdBfuBW+QAP75acsGZM
         /taEZrVVZY0auk5Kgs+gvfSIV41XhxEvHHgKjiy++9G92HqCh2+GduOuo8JcChlc0JG2
         LTWZLNP2FDEkTiZNMxdNtj5up9YOoVQ+9LcIaQN46Pdj1oaLEkhagnY9fUuXBL/gH6Ff
         mh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5XZycmuIjIafTSGdPTuaZu3kV+tz+/wDN6cFD9GHOsNvbz3IETsgCmFZup4eHx66hVms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1OapFTbsbCzJe3ZYpyWay6RnL20YjfjTVzjkV1J+0o5CyQUJ
	5c7pGKvEn/KBMxyAXdec88hvpQmaXpczOOU520bQGTKn+3cbE2lYePw7
X-Gm-Gg: ATEYQzxMbj+cd2oXcJ95F2g6JvNiec25NaQxQKzDkF3m0mYvnDhjNlrH+3qnYW6TGJL
	Mb1+ufBF7eem0PPIZQOSMhf8gTSPV0smaEDr/lQklgi06TnHCZRBAEFYKrgCzOCunS1/dBzoDOQ
	3KwddGycxVvMBpc9mKWwgjOXLcJLPlU8xrzO6VATEQEtwIZ4O2WCDGCgrljXQR252cTEJrrXTep
	lP5lT71rBXgwh1fkdeax7xMlQbL15p2uzcqixurW5M3GZOqj18ey1cr/JemNGOgdkfkNIDO9I3L
	EwHbOfrTyMVUnhMMZ6N3x8/DfxST7LT3qktm0s9Dqg7mlbQFSXaYgPzayat21FANS44kfoEo+sK
	5Qwl1Dy/jTuvQMY7Ufts3SYeP23eLIkDUZd4De/yZWFgJah2cLRmw4bAmL33n+9OlOgKfuh/VS5
	7g2QQ4bsXMe1eZiFhzQDE1ylkNeLRKUzLu3xxUD0v9u9sGP9DAM2zqWHmeFLPeCVL3eNoKHDlT0
	YgG7krmOzHYWHtW
X-Received: by 2002:a05:6000:186c:b0:439:b55d:b0e5 with SMTP id ffacd0b85a97d-439b55db224mr8091288f8f.28.1772463390733;
        Mon, 02 Mar 2026 06:56:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ab6ebe56sm16783048f8f.15.2026.03.02.06.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:56:30 -0800 (PST)
Message-ID: <e555e29f-57e3-4192-98f3-380181c81fd2@gmail.com>
Date: Mon, 2 Mar 2026 14:56:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 3/5] trailer: append trailers without fork/exec
To: Li Chen <me@linux.beauty>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-4-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20260224070552.148591-4-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 24/02/2026 07:05, Li Chen wrote:
> Introduce amend_strbuf_with_trailers() to apply trailer additions to a
> message buffer via process_trailers(), avoiding the need to run git
> interpret-trailers as a child process.
> 
> Update amend_file_with_trailers() to use the in-process helper and
> rewrite the target file via tempfile+rename, preserving the previous
> in-place semantics.
> 
> Keep existing callers unchanged by continuing to accept argv-style
> --trailer=<trailer> entries and stripping the prefix before feeding the
> in-process implementation.

This looks pretty good, there are a few rough edges in the tempfile 
handling and a couple of unrelated changes but the basics are sound.

> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> v7:
> Drop wrapper.c/h and validate trailer args via validate_trailer_args().
> Rewrite the target file via tempfile+rename to preserve --in-place semantics.
> 
>   builtin/interpret-trailers.c |   4 +-
>   trailer.c                    | 162 +++++++++++++++++++++++++++++++++--
>   trailer.h                    |  27 +++++-
>   3 files changed, 179 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 1354109e0f..d4aff68746 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -144,8 +144,6 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>   	struct strbuf out = STRBUF_INIT;
>   	FILE *outfile = stdout;
>   
> -	trailer_config_init();
> -
>   	read_input_file(&input, file);
>   
>   	if (opts->in_place)
> @@ -203,6 +201,8 @@ int cmd_interpret_trailers(int argc,
>   			git_interpret_trailers_usage,
>   			options);
>   
> +	trailer_config_init();
> +

The changes above are unrelated to everything else in this patch.

>   	if (argc) {
>   		int i;
>   		for (i = 0; i < argc; i++)
> diff --git a/trailer.c b/trailer.c
> index 0c9200506d..8e87d185d9 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -772,6 +775,30 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
>   	free(cl_separators);
>   }
>   
> +void validate_trailer_args(const struct strvec *cli_args)
> +{
> +	char *cl_separators;
> +
> +	trailer_config_init();
> +
> +	cl_separators = xstrfmt("=%s", separators);
> +
> +	for (size_t i = 0; i < cli_args->nr; i++) {
> +		const char *txt = cli_args->v[i];
> +		ssize_t separator_pos;
> +
> +		if (!*txt)
> +			die(_("empty --trailer argument"));
> +
> +		separator_pos = find_separator(txt, cl_separators);
> +		if (separator_pos == 0)
> +			die(_("invalid trailer '%s': missing key before separator"),
> +			    txt);
> +	}
> +
> +	free(cl_separators);
> +}

This function is never called, is it left over by a mistake, or should 
it be called by amend_file_with_trailers()?

>   static const char *next_line(const char *str)
>   {
>   	const char *nl = strchrnul(str, '\n');
> @@ -1224,16 +1251,133 @@ void trailer_iterator_release(struct trailer_iterator *iter)
>   	strbuf_release(&iter->key);
>   }
>   
> -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
> +static void new_trailer_items_clear(struct list_head *items)
> +{
> +	while (!list_empty(items)) {
> +		struct new_trailer_item *item =
> +			list_first_entry(items, struct new_trailer_item, list);
> +		list_del(&item->list);
> +		free(item);
> +	}
> +}

Isn't this just doing what free_trailers() does c.f. 
https://lore.kernel.org/git/ef12ada7-13ae-4df0-a823-6f428c797223@gmail.com/

> +void amend_strbuf_with_trailers(struct strbuf *buf,
> +				const struct strvec *trailer_args)
> +{
> +	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +	LIST_HEAD(new_trailer_head);
> +	struct strbuf out = STRBUF_INIT;
> +	size_t i;
> +
> +	opts.no_divider = 1;
> +
> +	for (i = 0; i < trailer_args->nr; i++) {
> +		const char *text = trailer_args->v[i];
> +		struct new_trailer_item *item;
> +
> +		if (!*text)
> +			die(_("empty --trailer argument"));

The existing callers of amend_file_with_trailers() are not expecting it 
to die so we should return an error here so they cleanup before exiting.

> +		item = xcalloc(1, sizeof(*item));
> +		item->text = text;
> +		list_add_tail(&item->list, &new_trailer_head);
> +	}
> +
> +	trailer_config_init();
> +	process_trailers(&opts, &new_trailer_head, buf, &out);
> +
> +	strbuf_swap(buf, &out);
> +	strbuf_release(&out);
> +
> +	new_trailer_items_clear(&new_trailer_head);
> +}
> +
> +static int write_file_in_place(const char *path, const struct strbuf *buf)
> +{
> +	struct stat st;
> +	struct strbuf filename_template = STRBUF_INIT;
> +	const char *tail;
> +	struct tempfile *tempfile;
> +	FILE *outfile;
> +
> +	if (stat(path, &st))
> +		return error_errno(_("could not stat %s"), path);
> +	if (!S_ISREG(st.st_mode))
> +		return error(_("file %s is not a regular file"), path);
> +	if (!(st.st_mode & S_IWUSR))
> +		return error(_("file %s is not writable by user"), path);

This is copied from create_in_place_tempfile() replacing die() with 
error() - ok

> +	/* Create temporary file in the same directory as the original */
> +	tail = strrchr(path, '/');

This is also copied from create_in_place_tempfile() but it would be 
better to use find_last_dir_sep()

> +	if (tail)
> +		strbuf_add(&filename_template, path, tail - path + 1);
> +	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
> +
> +	tempfile = mks_tempfile_sm(filename_template.buf, 0, st.st_mode);

This could be mks_tempfile_m() like create_in_place_tempfile() as we 
don't have a suffix to add.

> +	strbuf_release(&filename_template);
> +	if (!tempfile)
> +		return error_errno(_("could not create temporary file"));
> +
> +	outfile = fdopen_tempfile(tempfile, "w");
> +	if (!outfile) {
> +		int saved_errno = errno;
> +		delete_tempfile(&tempfile);
> +		errno = saved_errno;
> +		return error_errno(_("could not open temporary file"));
> +	}
> +
> +	if (buf->len && fwrite(buf->buf, 1, buf->len, outfile) < buf->len) {
> +		int saved_errno = errno;
> +		delete_tempfile(&tempfile);
> +		errno = saved_errno;
> +		return error_errno(_("could not write to temporary file"));
> +	}

As all we're doing is writing the contents of buf we can use 
write_in_full() here and avoid the call to fdopen_tempfile() above. Also 
note that the documentation in tempfile.h says

     * If the program exits before `rename_tempfile()` or
     * `delete_tempfile()` is called, an `atexit(3)` handler will close
     * and remove the temporary file.

so we don't need to call delete_tempfile() if the write fails.

We could probably share this code with builtin/interpret-trailers.c (it 
no-longer needs to call fdopen_tempfile() either) which would make it 
more obvious that we're basically copying it here.

> +	if (rename_tempfile(&tempfile, path))
> +		return error_errno(_("could not rename temporary file to %s"), path);
> +
> +	return 0;
> +}
> +
> +int amend_file_with_trailers(const char *path,
> +			     const struct strvec *trailer_args)
>   {
> -	struct child_process run_trailer = CHILD_PROCESS_INIT;
> -
> -	run_trailer.git_cmd = 1;
> -	strvec_pushl(&run_trailer.args, "interpret-trailers",
> -		     "--in-place", "--no-divider",
> -		     path, NULL);
> -	strvec_pushv(&run_trailer.args, trailer_args->v);
> -	return run_command(&run_trailer);
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strvec stripped_trailer_args = STRVEC_INIT;
> +	int ret = 0;
> +	size_t i;
> +
> +	if (!trailer_args)
> +		BUG("amend_file_with_trailers called with NULL trailer_args");
> +	if (!trailer_args->nr)
> +		return 0;
> +
> +	for (i = 0; i < trailer_args->nr; i++) {
> +		const char *txt = trailer_args->v[i];
> +
> +		/*
> +		 * Historically amend_file_with_trailers() passed its arguments
> +		 * to "git interpret-trailers", which expected argv entries in
> +		 * "--trailer=<trailer>" form. Continue to accept those for
> +		 * existing callers, but pass only the value portion to the
> +		 * in-process implementation.
> +		 */
> +		skip_prefix(txt, "--trailer=", &txt);
> +		if (!*txt)
> +			die(_("empty --trailer argument"));

It seems a shame to die() here when the rest of the function uses 
error() especially as the existing callers of amend_file_with_trailers() 
are not expecting it to die() and may want to perform some cleanup 
before exiting.

> +		strvec_push(&stripped_trailer_args, txt);
> +	}
> +
> +	if (strbuf_read_file(&buf, path, 0) < 0)
> +		ret = error_errno(_("could not read '%s'"), path);
> +	else
> +		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
> +
> +	if (!ret)
> +		ret = write_file_in_place(path, &buf);
> +
> +	strvec_clear(&stripped_trailer_args);
> +	strbuf_release(&buf);
> +	return ret;
>   }

> [...]   
> +/*
> + * Rewrite the contents of input by processing its trailer block according to
> + * opts and (optionally) appending trailers from new_trailer_head.
> + *
> + * The rewritten message is appended to out (callers should strbuf_reset()
> + * first if needed).
> + */
This comment should be part of the previous commit that adds 
process_trailers().

>   void process_trailers(const struct process_trailer_options *opts,
>   		      struct list_head *new_trailer_head,
>   		      struct strbuf *input, struct strbuf *out);

Thanks

Phillip

