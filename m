Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D771F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeKMBcP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:32:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36574 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:32:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so13976750qkf.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IlBxpWDTc8/NjGvl3HUIbXVvrs77aHKakMBSYvATXXs=;
        b=CtLvMXbNXErGGqxjQaSR2Po+q3XHmQgp4NlvtL2HCXMYnY4nSG13U4Zk8tb0ZjIdaT
         TDIaHaodi9NYU3fnZgpeE2JIWNjUfmZt7pvavav9WqR/Mr2F97VjzOEtdLKSMte96Guo
         UlgmqVsYaHC99bYhej7UFXUcMtgEH+1x/8vdpE7jMnc5py436LXUUf+ECjoJ33ZUsl03
         Nwj+LqwQ1GItOk8mTnkPkI5IqoxbRd4kDlsUMYsS4m4lzLi4bmemaXh0OISuOoHRxM4/
         bCjyekmwC76I/krreU5Az1tPliHjZyoiHx4ZAPESeSQ409eE8i7DCU5z/15SRfOP9sXm
         OY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IlBxpWDTc8/NjGvl3HUIbXVvrs77aHKakMBSYvATXXs=;
        b=RJBst1omb+EM+YxB9ukVTCI0O6YHAaVTb7/oyu8qXbmzPlVGytFoYbjyJsI1/VfLdH
         VGPWm3lm+bMvCefd1K0JueENnPY1Wm74EIgqJXlWN/7b6NCwwCwY1HGLebZSuAL9+iK8
         28uLbQlvtUkjpaSRoTfz/mBeRK53t7JQ/0/HgXIIGjF9phGo0OEGtBQ/wMJ+X00/IXcE
         EPAGjBAh9UribHJZdEfNmHIAJBI0AqnUiuevAbGSsdcgVFJ8+MaW5GBgNYYj0b/FYcvw
         EW2IAEP3RwGVwF4RC8c5xy+hDBkrm9yo5Issr+JzJG9jteg82bV/LX5WswjGT2hsM4oY
         UbYg==
X-Gm-Message-State: AGRZ1gInJxPzRSNM4Hns7S+RUdo1J1V4srT2933vZzvymXU1AXQwSC4L
        5kMLZbydFDAlWYn06Y3wOv8=
X-Google-Smtp-Source: AJdET5cPuqRxh462YEVTkAGYuuLAHA0ctcvg8G6iV+UU2huotSi4hBXZ1N6JMZfnusvhN0foNhS/aQ==
X-Received: by 2002:ac8:2729:: with SMTP id g38-v6mr1427105qtg.168.1542037108509;
        Mon, 12 Nov 2018 07:38:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id p3sm10832457qkp.48.2018.11.12.07.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:38:27 -0800 (PST)
Subject: Re: [PATCH 5/9] handle alternates paths the same as the main object
 dir
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144935.GE7400@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56c50f51-5d9c-1166-75b9-418e384fc672@gmail.com>
Date:   Mon, 12 Nov 2018 10:38:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112144935.GE7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2018 9:49 AM, Jeff King wrote:
> When we generate loose file paths for the main object directory, the
> caller provides a buffer to loose_object_path (formerly sha1_file_name).
> The callers generally keep their own static buffer to avoid excessive
> reallocations.
>
> But for alternate directories, each struct carries its own scratch
> buffer. This is needlessly different; let's unify them.
>
> We could go either direction here, but this patch moves the alternates
> struct over to the main directory style (rather than vice-versa).
> Technically the alternates style is more efficient, as it avoids
> rewriting the object directory name on each call. But this is unlikely
> to matter in practice, as we avoid reallocations either way (and nobody
> has ever noticed or complained that the main object directory is copying
> a few extra bytes before making a much more expensive system call).

Hm. I've complained in the past [1] about a simple method like 
strbuf_addf() over loose objects, but that was during abbreviation 
checks so we were adding the string for every loose object but not 
actually reading the objects.

[1] 
https://public-inbox.org/git/20171201174956.143245-1-dstolee@microsoft.com/

The other concern I have is for alternates that may have long-ish paths 
to their object directories.

So, this is worth keeping an eye on, but is likely to be fine.

> And this has the advantage that the reusable buffers are tied to
> particular calls, which makes the invalidation rules simpler (for
> example, the return value from stat_sha1_file() used to be invalidated
> by basically any other object call, but now it is affected only by other
> calls to stat_sha1_file()).
>
> We do steal the trick from alt_sha1_path() of returning a pointer to the
> filled buffer, which makes a few conversions more convenient.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   object-store.h | 14 +-------------
>   object.c       |  1 -
>   sha1-file.c    | 44 ++++++++++++++++----------------------------
>   sha1-name.c    |  8 ++++++--
>   4 files changed, 23 insertions(+), 44 deletions(-)
>
> diff --git a/object-store.h b/object-store.h
> index fefa17e380..b2fa0d0df0 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -10,10 +10,6 @@
>   struct object_directory {
>   	struct object_directory *next;
>   
> -	/* see alt_scratch_buf() */
> -	struct strbuf scratch;
> -	size_t base_len;
> -
>   	/*
>   	 * Used to store the results of readdir(3) calls when searching
>   	 * for unique abbreviated hashes.  This cache is never
> @@ -54,14 +50,6 @@ void add_to_alternates_file(const char *dir);
>    */
>   void add_to_alternates_memory(const char *dir);
>   
> -/*
> - * Returns a scratch strbuf pre-filled with the alternate object directory,
> - * including a trailing slash, which can be used to access paths in the
> - * alternate. Always use this over direct access to alt->scratch, as it
> - * cleans up any previous use of the scratch buffer.
> - */
> -struct strbuf *alt_scratch_buf(struct object_directory *odb);
> -
>   struct packed_git {
>   	struct packed_git *next;
>   	struct list_head mru;
> @@ -157,7 +145,7 @@ void raw_object_store_clear(struct raw_object_store *o);
>    * Put in `buf` the name of the file in the local object database that
>    * would be used to store a loose object with the specified sha1.
>    */
> -void loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
> +const char *loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
>   
>   void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
>   
> diff --git a/object.c b/object.c
> index 6af8e908bb..dd485ac629 100644
> --- a/object.c
> +++ b/object.c
> @@ -484,7 +484,6 @@ struct raw_object_store *raw_object_store_new(void)
>   
>   static void free_alt_odb(struct object_directory *odb)
>   {
> -	strbuf_release(&odb->scratch);
>   	oid_array_clear(&odb->loose_objects_cache);
>   	free(odb);
>   }
> diff --git a/sha1-file.c b/sha1-file.c
> index 478eac326b..15db6b61a9 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -346,27 +346,20 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
>   	}
>   }
>   
> -void loose_object_path(struct repository *r, struct strbuf *buf,
> -		       const unsigned char *sha1)
> +static const char *odb_loose_path(const char *path, struct strbuf *buf,
> +				  const unsigned char *sha1)
>   {
>   	strbuf_reset(buf);
> -	strbuf_addstr(buf, r->objects->objectdir);
> +	strbuf_addstr(buf, path);
>   	strbuf_addch(buf, '/');
>   	fill_sha1_path(buf, sha1);
> +	return buf->buf;
>   }
>   
> -struct strbuf *alt_scratch_buf(struct object_directory *odb)
> +const char *loose_object_path(struct repository *r, struct strbuf *buf,
> +			      const unsigned char *sha1)
>   {
> -	strbuf_setlen(&odb->scratch, odb->base_len);
> -	return &odb->scratch;
> -}
> -
> -static const char *alt_sha1_path(struct object_directory *odb,
> -				 const unsigned char *sha1)
> -{
> -	struct strbuf *buf = alt_scratch_buf(odb);
> -	fill_sha1_path(buf, sha1);
> -	return buf->buf;
> +	return odb_loose_path(r->objects->objectdir, buf, sha1);
>   }
>   
>   /*
> @@ -547,9 +540,6 @@ struct object_directory *alloc_alt_odb(const char *dir)
>   	struct object_directory *ent;
>   
>   	FLEX_ALLOC_STR(ent, path, dir);
> -	strbuf_init(&ent->scratch, 0);
> -	strbuf_addf(&ent->scratch, "%s/", dir);
> -	ent->base_len = ent->scratch.len;
>   
>   	return ent;
>   }
> @@ -745,10 +735,12 @@ static int check_and_freshen_local(const struct object_id *oid, int freshen)
>   static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
>   {
>   	struct object_directory *odb;
> +	static struct strbuf path = STRBUF_INIT;
> +
>   	prepare_alt_odb(the_repository);
>   	for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
> -		const char *path = alt_sha1_path(odb, oid->hash);
> -		if (check_and_freshen_file(path, freshen))
> +		odb_loose_path(odb->path, &path, oid->hash);
> +		if (check_and_freshen_file(path.buf, freshen))
>   			return 1;
>   	}
>   	return 0;
> @@ -889,7 +881,7 @@ int git_open_cloexec(const char *name, int flags)
>    *
>    * The "path" out-parameter will give the path of the object we found (if any).
>    * Note that it may point to static storage and is only valid until another
> - * call to loose_object_path(), etc.
> + * call to stat_sha1_file().
>    */
>   static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
>   			  struct stat *st, const char **path)
> @@ -897,16 +889,14 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
>   	struct object_directory *odb;
>   	static struct strbuf buf = STRBUF_INIT;
>   
> -	loose_object_path(r, &buf, sha1);
> -	*path = buf.buf;
> -
> +	*path = loose_object_path(r, &buf, sha1);
>   	if (!lstat(*path, st))
>   		return 0;
>   
>   	prepare_alt_odb(r);
>   	errno = ENOENT;
>   	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
> -		*path = alt_sha1_path(odb, sha1);
> +		*path = odb_loose_path(odb->path, &buf, sha1);
>   		if (!lstat(*path, st))
>   			return 0;
>   	}
> @@ -926,9 +916,7 @@ static int open_sha1_file(struct repository *r,
>   	int most_interesting_errno;
>   	static struct strbuf buf = STRBUF_INIT;
>   
> -	loose_object_path(r, &buf, sha1);
> -	*path = buf.buf;
> -
> +	*path = loose_object_path(r, &buf, sha1);
>   	fd = git_open(*path);
>   	if (fd >= 0)
>   		return fd;
> @@ -936,7 +924,7 @@ static int open_sha1_file(struct repository *r,
>   
>   	prepare_alt_odb(r);
>   	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
> -		*path = alt_sha1_path(odb, sha1);
> +		*path = odb_loose_path(odb->path, &buf, sha1);
>   		fd = git_open(*path);
>   		if (fd >= 0)
>   			return fd;
> diff --git a/sha1-name.c b/sha1-name.c
> index 2594aa79f8..96a8e71482 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -97,6 +97,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>   	int subdir_nr = ds->bin_pfx.hash[0];
>   	struct object_directory *odb;
>   	static struct object_directory *fakeent;
> +	struct strbuf buf = STRBUF_INIT;
>   
>   	if (!fakeent) {
>   		/*
> @@ -114,8 +115,9 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>   		int pos;
>   
>   		if (!odb->loose_objects_subdir_seen[subdir_nr]) {
> -			struct strbuf *buf = alt_scratch_buf(odb);
> -			for_each_file_in_obj_subdir(subdir_nr, buf,
> +			strbuf_reset(&buf);
> +			strbuf_addstr(&buf, odb->path);
> +			for_each_file_in_obj_subdir(subdir_nr, &buf,
>   						    append_loose_object,
>   						    NULL, NULL,
>   						    &odb->loose_objects_cache);
> @@ -134,6 +136,8 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>   			pos++;
>   		}
>   	}
> +
> +	strbuf_release(&buf);
>   }
>   
>   static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)

