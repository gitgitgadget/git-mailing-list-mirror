Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E042E9EAA
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074820; cv=none; b=P3nwJd6in3V2j3Y9Zb+xZHjta59XF5ONW1RQ/EUZVVSghtXMwBTtKAUvNobsuBsZYeV+aW8I89UwOogiWlM4aP7pkHz5Zu/Er0sXXhRo1tAGdQ2vfA9Qx8W/4xF1GtolBITG+pd4noQJkc31f55RIWxRtzz0/9JWiYzcDeCP5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074820; c=relaxed/simple;
	bh=M8ln5t2xl48p0tJhabL8TBA3bXPaByS8U597rT5XSMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WHn90COpHf8tLCJ9uw8+C6TY3UcYjOM+RD6+INyKK/obIUk/qEmD+S2g3gse7u8rQrbnKZzrHcw47Cxaxj6irTdeR3iM4rE8UfydRGhAXzmcxeHPqcvwhjW/07+0Yd3GAj2dR9cd6DvYoLJyZMGFV73tnVWtatcI6K5SrWVSi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brnr5Dtk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brnr5Dtk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cf214200so45534905e9.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752074816; x=1752679616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fihTItO5cSeDvqCA9qClvOFV2c/AF9gvlTx3P/Pgn8I=;
        b=Brnr5DtkhCoBL8CDMRn0n/Q4wc7XYDEWu+Q/4Mt/srT4IugELk/jfbVVlsGINgyRHo
         eU9en5oVUWTcANMWRZ81wDNYeHSR/5WjVb27oOcNKeD04K40f6+X616L+mx9T6jifAWN
         z71O7IDRrZLGUJQhdAbCQDT6aqtaXT1bsUzmieKb5S1wrAf7Z1/KnLbTP5BTfBpIzG1o
         hWhoI45+DlK4atWwv3EvBOrIlUo39njsLtAtq02H/QeGYKKzzhOwLzB3yrQtd9gDBjvz
         q3kzeK7WqL1KDngwMEeGXxsvlV4+R++43yJVW2UKlSmNd9r5u6bUBS23bYsd6qXjromt
         yTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074816; x=1752679616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fihTItO5cSeDvqCA9qClvOFV2c/AF9gvlTx3P/Pgn8I=;
        b=XyQ3H6XRHAMusc3kuIvhOiF198LpKgjxM7Fw4wSAinfqhZ2bb5hWxVlWKcKtHJakg7
         3NIkXmrf+hBQ7tW7wYUtEKKbzxp3Hvd+ZQRxAa+WBnIIEHQRcJ9V2GCAIc5EyCnntwmf
         BGx5TkVB3cv1zFlY+Ltqu0p95TPtmSjJkBZ+Z2hNb862Qv0DhzZbX2Oigt16A+rL6/48
         WzAmJ3MQ7twalgA7rue+ax01QzB2VQwhjMyI/E0S/QH6EzjnDy5oOFp7+ReCYefiZ1c0
         CK7ge64QGEkQARCGnV+B8uyqmC1xddRJD/SHnToS/dI22pWUSeChmlPBqgFFy697bNgt
         I2qA==
X-Forwarded-Encrypted: i=1; AJvYcCWgnkovEj1PSaBY2WFxovHZJkME8GcMELx1KJlXbnleib7GsBkr3+KggiAisVWJA1fPx5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7kvMMqu9dmhiKPF4sn14JujYvy+mhB9ll0ctytp+dtHqS3WJ
	UWO5UUjkstLIPAtr4CcUEjzCqx9uvhBON5T+JN3K4k1kzAAhMB1vRYp4
X-Gm-Gg: ASbGnctDVdE592HEUDbFd6zjoc19Cx13LFJTXjFnvMIKSa9SFVPTW3B4RBMjav3AgUw
	lDRbrSWzhVzXwWNcDWqpVgOOdOFsDAiBIX1kFejtX5dfpwy9wUXxI3t8/mwx/p+Dfz2iFbKgcrc
	5ZMyx3nbSfa2w0HajRdQKVdWRQSdgcANx904mTHJ9bdJBpI/nk/1ZXYrjIJv/jN/Zz1C7+4etA0
	on22RGfrivBX7etw4ESlFnpsx0/O+fVHdCTQ3PsA6ZNe5LhW5MXE8Hokd5jrX4iC7RDKu8nLJ02
	YgsR+XfuPoR/PS2nzVXgf0lXG1Lr83J6n9fc1q0lVdLU5A13fbB7RLnJuRuL2+XbDTvxyfK0cnr
	Rju5oaJiPhnG0DTvOAPzBXhAfeqZoAIGdPN3eLw==
X-Google-Smtp-Source: AGHT+IGRIqA1BnokXvNbIA3DAVvk7PWneGqTZopVYmp/1T+f/AnVXD06UpXqggOjhwd5ZJRc1q+5Pw==
X-Received: by 2002:a05:600c:1c9d:b0:454:ab1a:8c2a with SMTP id 5b1f17b1804b1-454d5384136mr28975535e9.24.1752074815815;
        Wed, 09 Jul 2025 08:26:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0ae0sm16623448f8f.33.2025.07.09.08.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 08:26:55 -0700 (PDT)
Message-ID: <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
Date: Wed, 9 Jul 2025 16:26:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 09/07/2025 12:17, Patrick Steinhardt wrote:
> The compression level for loose objects and packfiles is tracked via a
> couple of global variables. Refactor these so that the values for them
> are tracked via repo settings, which allows us to drop this global
> dependency.

The delayed config parsing causes a user visible regression in 
fast-import. If I run

$ git fast-export HEAD^ | git -c core.compression=500 fast-import

it dies with

fatal: bad zlib compression level 500

With this series applied I see

fatal: bad zlib compression level 500
fast-import: dumping crash report to 
/home/phil/src/git/.git/worktrees/tmp2/fast_import_crash_13462

I do not think adding prepare_repo_settings() calls all over the place 
is a good way forward as it makes it very easy to introduce regressions 
like this. Our builtin commands parse the config at startup for good 
reasons if we're going to move settings out of git_default_core_config() 
we should ensure that they are still parsed at startup.

Thanks

Phillip


> Note that the refactoring is mostly straight-forward, except in
> git-pack-objects(1). Here it is possible to change the compression level
> via a command line option, and that option of course should override
> whatever the user has configured. This creates the problem that we need
> to be able to see whether the option has been given in the first place.
> 
> This is done by using `INT_MIN` as default value. Any value smaller than
> -1 is an invalid compression level, so it's quite unlikely that any user
> ever passed that sentinel value. And if they did we would have died
> anyway.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/fast-import.c  |  8 +++++---
>   builtin/index-pack.c   |  3 ++-
>   builtin/pack-objects.c | 21 ++++++++++++++-------
>   bulk-checkin.c         |  3 ++-
>   config.c               | 38 --------------------------------------
>   diff.c                 |  3 ++-
>   environment.c          |  3 ---
>   environment.h          |  2 --
>   http-push.c            |  3 ++-
>   object-file.c          |  3 ++-
>   repo-settings.c        | 38 ++++++++++++++++++++++++++++++++++++++
>   repo-settings.h        |  2 ++
>   12 files changed, 69 insertions(+), 58 deletions(-)
> 
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 89f57898b15..2733c6ed7fc 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -992,7 +992,8 @@ static int store_object(
>   	} else
>   		delta = NULL;
>   
> -	git_deflate_init(&s, pack_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&s, the_repository->settings.pack_compression_level);
>   	if (delta) {
>   		s.next_in = delta;
>   		s.avail_in = deltalen;
> @@ -1019,7 +1020,7 @@ static int store_object(
>   		if (delta) {
>   			FREE_AND_NULL(delta);
>   
> -			git_deflate_init(&s, pack_compression_level);
> +			git_deflate_init(&s, the_repository->settings.pack_compression_level);
>   			s.next_in = (void *)dat->buf;
>   			s.avail_in = dat->len;
>   			s.avail_out = git_deflate_bound(&s, s.avail_in);
> @@ -1120,7 +1121,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>   
>   	crc32_begin(pack_file);
>   
> -	git_deflate_init(&s, pack_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&s, the_repository->settings.pack_compression_level);
>   
>   	hdrlen = encode_in_pack_object_header(out_buf, out_sz, OBJ_BLOB, len);
>   
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index dabeb825a6c..d302bab9de9 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1420,7 +1420,8 @@ static int write_compressed(struct hashfile *f, void *in, unsigned int size)
>   	int status;
>   	unsigned char outbuf[4096];
>   
> -	git_deflate_init(&stream, zlib_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&stream, the_repository->settings.zlib_compression_level);
>   	stream.next_in = in;
>   	stream.avail_in = size;
>   
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7ff79d6b376..62096c1fe03 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -379,7 +379,8 @@ static unsigned long do_compress(void **pptr, unsigned long size)
>   	void *in, *out;
>   	unsigned long maxsize;
>   
> -	git_deflate_init(&stream, pack_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&stream, the_repository->settings.pack_compression_level);
>   	maxsize = git_deflate_bound(&stream, size);
>   
>   	in = *pptr;
> @@ -406,7 +407,8 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct hashfi
>   	unsigned char obuf[1024 * 16];
>   	unsigned long olen = 0;
>   
> -	git_deflate_init(&stream, pack_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&stream, the_repository->settings.pack_compression_level);
>   
>   	for (;;) {
>   		ssize_t readlen;
> @@ -4803,6 +4805,7 @@ int cmd_pack_objects(int argc,
>   		     const char *prefix,
>   		     struct repository *repo UNUSED)
>   {
> +	int compression_level = INT_MIN;
>   	int use_internal_rev_list = 0;
>   	int all_progress_implied = 0;
>   	struct strvec rp = STRVEC_INIT;
> @@ -4892,7 +4895,7 @@ int cmd_pack_objects(int argc,
>   			 N_("ignore packs that have companion .keep file")),
>   		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>   				N_("ignore this pack")),
> -		OPT_INTEGER(0, "compression", &pack_compression_level,
> +		OPT_INTEGER(0, "compression", &compression_level,
>   			    N_("pack compression level")),
>   		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
>   			 N_("do not hide commits by grafts")),
> @@ -5046,10 +5049,14 @@ int cmd_pack_objects(int argc,
>   
>   	if (!reuse_object)
>   		reuse_delta = 0;
> -	if (pack_compression_level == -1)
> -		pack_compression_level = Z_DEFAULT_COMPRESSION;
> -	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
> -		die(_("bad pack compression level %d"), pack_compression_level);
> +	if (compression_level != INT_MIN) {
> +		if (compression_level == -1)
> +			compression_level = Z_DEFAULT_COMPRESSION;
> +		else if (compression_level < 0 || compression_level > Z_BEST_COMPRESSION)
> +			die(_("bad pack compression level %d"), compression_level);
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.pack_compression_level = compression_level;
> +	}
>   
>   	if (!delta_search_threads)	/* --threads=0 means autodetect */
>   		delta_search_threads = online_cpus();
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index b2809ab0398..3ea181baf93 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -171,7 +171,8 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
>   	int write_object = (flags & INDEX_WRITE_OBJECT);
>   	off_t offset = 0;
>   
> -	git_deflate_init(&s, pack_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&s, the_repository->settings.pack_compression_level);
>   
>   	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
>   	s.next_out = obuf + hdrlen;
> diff --git a/config.c b/config.c
> index 095a17bd429..b7d1fa90fbf 100644
> --- a/config.c
> +++ b/config.c
> @@ -71,9 +71,6 @@ struct config_source {
>   };
>   #define CONFIG_SOURCE_INIT { 0 }
>   
> -static int pack_compression_seen;
> -static int zlib_compression_seen;
> -
>   /*
>    * Config that comes from trusted scopes, namely:
>    * - CONFIG_SCOPE_SYSTEM (e.g. /etc/gitconfig)
> @@ -1466,30 +1463,6 @@ static int git_default_core_config(const char *var, const char *value,
>   	if (!strcmp(var, "core.disambiguate"))
>   		return set_disambiguate_hint_config(var, value);
>   
> -	if (!strcmp(var, "core.loosecompression")) {
> -		int level = git_config_int(var, value, ctx->kvi);
> -		if (level == -1)
> -			level = Z_DEFAULT_COMPRESSION;
> -		else if (level < 0 || level > Z_BEST_COMPRESSION)
> -			die(_("bad zlib compression level %d"), level);
> -		zlib_compression_level = level;
> -		zlib_compression_seen = 1;
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.compression")) {
> -		int level = git_config_int(var, value, ctx->kvi);
> -		if (level == -1)
> -			level = Z_DEFAULT_COMPRESSION;
> -		else if (level < 0 || level > Z_BEST_COMPRESSION)
> -			die(_("bad zlib compression level %d"), level);
> -		if (!zlib_compression_seen)
> -			zlib_compression_level = level;
> -		if (!pack_compression_seen)
> -			pack_compression_level = level;
> -		return 0;
> -	}
> -
>   	if (!strcmp(var, "core.autocrlf")) {
>   		if (value && !strcasecmp(value, "input")) {
>   			auto_crlf = AUTO_CRLF_INPUT;
> @@ -1802,17 +1775,6 @@ int git_default_config(const char *var, const char *value,
>   		return 0;
>   	}
>   
> -	if (!strcmp(var, "pack.compression")) {
> -		int level = git_config_int(var, value, ctx->kvi);
> -		if (level == -1)
> -			level = Z_DEFAULT_COMPRESSION;
> -		else if (level < 0 || level > Z_BEST_COMPRESSION)
> -			die(_("bad pack compression level %d"), level);
> -		pack_compression_level = level;
> -		pack_compression_seen = 1;
> -		return 0;
> -	}
> -
>   	if (starts_with(var, "sparse."))
>   		return git_default_sparse_config(var, value);
>   
> diff --git a/diff.c b/diff.c
> index dca87e164fb..45c0bcd2bde 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3307,7 +3307,8 @@ static unsigned char *deflate_it(char *data,
>   	unsigned char *deflated;
>   	git_zstream stream;
>   
> -	git_deflate_init(&stream, zlib_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&stream, the_repository->settings.zlib_compression_level);
>   	bound = git_deflate_bound(&stream, size);
>   	deflated = xmalloc(bound);
>   	stream.next_out = deflated;
> diff --git a/environment.c b/environment.c
> index 7bf0390a335..dbb186b56d0 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -16,7 +16,6 @@
>   #include "convert.h"
>   #include "environment.h"
>   #include "gettext.h"
> -#include "git-zlib.h"
>   #include "repository.h"
>   #include "config.h"
>   #include "refs.h"
> @@ -43,8 +42,6 @@ char *git_log_output_encoding;
>   char *apply_default_whitespace;
>   char *apply_default_ignorewhitespace;
>   char *git_attributes_file;
> -int zlib_compression_level = Z_BEST_SPEED;
> -int pack_compression_level = Z_DEFAULT_COMPRESSION;
>   int fsync_object_files = -1;
>   int use_fsync = -1;
>   enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
> diff --git a/environment.h b/environment.h
> index 9a3d05d414a..4245b58af6e 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -150,8 +150,6 @@ extern int warn_on_object_refname_ambiguity;
>   extern char *apply_default_whitespace;
>   extern char *apply_default_ignorewhitespace;
>   extern char *git_attributes_file;
> -extern int zlib_compression_level;
> -extern int pack_compression_level;
>   extern unsigned long pack_size_limit_cfg;
>   extern int max_allowed_tree_depth;
>   
> diff --git a/http-push.c b/http-push.c
> index 91a5465afb1..77670774713 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -374,7 +374,8 @@ static void start_put(struct transfer_request *request)
>   	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
>   
>   	/* Set it up */
> -	git_deflate_init(&stream, zlib_compression_level);
> +	prepare_repo_settings(the_repository);
> +	git_deflate_init(&stream, the_repository->settings.zlib_compression_level);
>   	size = git_deflate_bound(&stream, len + hdrlen);
>   	strbuf_grow(&request->buffer.buf, size);
>   	request->buffer.posn = 0;
> diff --git a/object-file.c b/object-file.c
> index 2bc36ab3ee8..0afd39dd346 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -769,7 +769,8 @@ static int start_loose_object_common(struct odb_source *source,
>   	}
>   
>   	/*  Setup zlib stream for compression */
> -	git_deflate_init(stream, zlib_compression_level);
> +	prepare_repo_settings(source->odb->repo);
> +	git_deflate_init(stream, source->odb->repo->settings.zlib_compression_level);
>   	stream->next_out = buf;
>   	stream->avail_out = buflen;
>   	algo->init_fn(c);
> diff --git a/repo-settings.c b/repo-settings.c
> index 195c24e9c07..1d3626018a0 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -1,5 +1,7 @@
>   #include "git-compat-util.h"
>   #include "config.h"
> +#include "git-zlib.h"
> +#include "gettext.h"
>   #include "repo-settings.h"
>   #include "repository.h"
>   #include "midx.h"
> @@ -29,6 +31,8 @@ static void repo_cfg_ulong(struct repository *r, const char *key, unsigned long
>   
>   void prepare_repo_settings(struct repository *r)
>   {
> +	int pack_compression_seen = 0;
> +	int zlib_compression_seen = 0;
>   	int experimental;
>   	int value;
>   	const char *strval;
> @@ -151,6 +155,40 @@ void prepare_repo_settings(struct repository *r)
>   
>   	if (!repo_config_get_ulong(r, "core.packedgitlimit", &ulongval))
>   		r->settings.packed_git_limit = ulongval;
> +
> +	if (!repo_config_get_int(r, "core.loosecompression", &value)) {
> +		if (value == -1)
> +			value = Z_DEFAULT_COMPRESSION;
> +		else if (value < 0 || value > Z_BEST_COMPRESSION)
> +			die(_("bad zlib compression level %d"), value);
> +		r->settings.zlib_compression_level = value;
> +		zlib_compression_seen = 1;
> +	}
> +
> +	if (!repo_config_get_int(r, "pack.compression", &value)) {
> +		if (value == -1)
> +			value = Z_DEFAULT_COMPRESSION;
> +		else if (value < 0 || value > Z_BEST_COMPRESSION)
> +			die(_("bad pack compression level %d"), value);
> +		r->settings.pack_compression_level = value;
> +		pack_compression_seen = 1;
> +	}
> +
> +	if (!repo_config_get_int(r, "core.compression", &value)) {
> +		if (value == -1)
> +			value = Z_DEFAULT_COMPRESSION;
> +		else if (value < 0 || value > Z_BEST_COMPRESSION)
> +			die(_("bad zlib compression level %d"), value);
> +		if (!zlib_compression_seen)
> +			r->settings.zlib_compression_level = value;
> +		if (!pack_compression_seen)
> +			r->settings.pack_compression_level = value;
> +	} else {
> +		if (!zlib_compression_seen)
> +			r->settings.zlib_compression_level = Z_BEST_SPEED;
> +		if (!pack_compression_seen)
> +			r->settings.pack_compression_level = Z_DEFAULT_COMPRESSION;
> +	}
>   }
>   
>   void repo_settings_clear(struct repository *r)
> diff --git a/repo-settings.h b/repo-settings.h
> index d4778855614..f60900317cf 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -36,6 +36,8 @@ struct repo_settings {
>   	int pack_read_reverse_index;
>   	int pack_use_bitmap_boundary_traversal;
>   	int pack_use_multi_pack_reuse;
> +	int pack_compression_level;
> +	int zlib_compression_level;
>   
>   	int shared_repository;
>   	int shared_repository_initialized;
> 
