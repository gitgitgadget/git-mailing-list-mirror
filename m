Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF488C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DD661361
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhGNB6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhGNB6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:58:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D8C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:56:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gn32so591248ejc.2
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g1nMMospEiwg3wZwoafH/6DEZW09NuMEsgoj9Na6/6Q=;
        b=WriEA0ZwYZ4DbIHos5U0hBjdRKjQl8x4dGePjrMWl+w8pjUjOOyTlLKsmpcsfoKlBe
         TfhSgMaGbmPSdpHe3/9dKHle6z4kWbRg8zxeFXmCOUwRbc1rGpDcKPml4eDdNa/Fpeab
         7+1ltU4iv8fgbyyCas9iQBTg0A/TMnIF3KP2XLh22Uzoueh4QWi21W/+BH4nxcJRbaFX
         XD3oCagWgQMBl47JXYx0K/bw+kqB2aGi0h4dAf2nln1voyxX/XHYYDQGDVQw+ZXOhJ/U
         Fik/dRA0rkfj0RtPw3a5DQG2leSlKRetevPkFTeyFrISONi6E4lstqHr5UvwWAkbjvjP
         8QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g1nMMospEiwg3wZwoafH/6DEZW09NuMEsgoj9Na6/6Q=;
        b=SFRFEQpXNpKHGX7rR1IPfxKO/CSYzC3u+WPyIUT0JW4jBb9pZv+OZ/ySvyazby2+h0
         2iLnGrunl0x/eFcdq4nIfWAsyIBiiKwsgB7ttY2UmLWWItiGIlub+bpvYK6kq/m634Br
         GhB0hKh0o/X7TB+uS1AUL5lSxLIQ9kLzwUZDAzf3g034U8oABKSA3GXNkVipJDk/uZe4
         aBdH3+K87kYnIWNYy68KGQ7EO4EfzZ+7ky7obMrjUeRGwz4O+nM2ephr++1LebRmJcRm
         r0kFvERsbKTpUojYXNpP1v5C3BA5qXbySpJpvy6BKLCkUjl0BKNaFfzLYu2+qdMZFsnu
         JqAw==
X-Gm-Message-State: AOAM533xCNUHA+8bEusz6dfHYbBfaM2H/3o8EujGsmHVrX36aVTCCL/e
        4C+UVQZAImQXCn+ZCilLYPU=
X-Google-Smtp-Source: ABdhPJx+EZqQfUVn0Rx/sWiwcJtFf49Ap9gP4i1v0YaVIJPdYG/YwYqRZZoH9jRm5afWtQWUM0PnTA==
X-Received: by 2002:a17:907:381:: with SMTP id ss1mr9096439ejb.404.1626227758689;
        Tue, 13 Jul 2021 18:55:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jp26sm187446ejb.28.2021.07.13.18.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:55:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Date:   Wed, 14 Jul 2021 03:39:18 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
Message-ID: <87wnpt1wwc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Sun Chao via GitGitGadget wrote:

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index c04f62a54a1..9a256992d8c 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -398,6 +398,18 @@ the largest projects.  You probably do not need to adjust this value.
>  +
>  Common unit suffixes of 'k', 'm', or 'g' are supported.
>  
> +core.packMtimeSuffix::
> +	Normally we avoid writing existing object by freshening the mtime
> +	of the *.pack file which contains it in order to aid some processes
> +	such like prune. Use different file instead of *.pack file will
> +	avoid file system cache re-sync the large packfiles, and consequently
> +	make git commands faster.
> ++
> +The default is 'pack' which means the *.pack file will be freshened by
> +default. You can configure a different suffix to use, the file with the
> +suffix will be created automatically, it's better not using any known
> +suffix such like 'idx', 'keep', 'promisor'.
> +

Hrm, per my v1 feedback (and I'm not sure if my suggestion is even good
here, there's others more familiar with this area than I am), I was
thinking of something like a *.bump file written via:

    core.packUseBumpFiles=bool

Or something like that, anyway, the edge case in allowing the user to
pick arbitrary suffixes is that we'd get in-the-wild user arbitrary
configuration squatting on a relatively sensitive part of the object
store.

E.g. we recently added *.rev files to go with
*.{pack,idx,bitmap,keep,promisor} (and I'm probably forgetting some
suffix). What if before that a user had set:

    core.packMtimeSuffix=rev

In practice it's probably too obscure to worry about, but I think it's
still worth it to only strictly write things we decide to write into the
object store.
>  core.deltaBaseCacheLimit::
>  	Maximum number of bytes per thread to reserve for caching base objects
>  	that may be referenced by multiple deltified objects.  By storing the
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 3fbc5d70777..60bacc8ee7f 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1437,19 +1437,6 @@ static void fix_unresolved_deltas(struct hashfile *f)
>  	free(sorted_by_pos);
>  }
>  
> -static const char *derive_filename(const char *pack_name, const char *strip,
> -				   const char *suffix, struct strbuf *buf)
> -{
> -	size_t len;
> -	if (!strip_suffix(pack_name, strip, &len) || !len ||
> -	    pack_name[len - 1] != '.')
> -		die(_("packfile name '%s' does not end with '.%s'"),
> -		    pack_name, strip);
> -	strbuf_add(buf, pack_name, len);
> -	strbuf_addstr(buf, suffix);
> -	return buf->buf;
> -}


Would be more readable to split this series up into at least two
patches, starting with just moving this function as-is to a the new
location (just renaming it & moving it), and then using it. I don't
think there's changes to it, but right now I'm just eyeballing the
diff. It's more obvious if it's split up.

> +	if (!strcmp(var, "core.packmtimesuffix")) {
> +		return git_config_string(&pack_mtime_suffix, var, value);

Can drop the {} braces here, per Documentation/CodingGuidelines

> +const char *pack_mtime_suffix = "pack";

I can see how having a configurable suffix made the implementation
easier, perhaps that's how it started?


>  int fsync_object_files;
>  size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
> diff --git a/object-file.c b/object-file.c
> index f233b440b22..b3e77213c42 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1974,12 +1974,41 @@ static int freshen_loose_object(const struct object_id *oid)
>  static int freshen_packed_object(const struct object_id *oid)
>  {
>  	struct pack_entry e;
> +	struct stat st;
> +	struct strbuf name_buf = STRBUF_INIT;
> +	const char *filename;
> +
>  	if (!find_pack_entry(the_repository, oid, &e))
>  		return 0;
>  	if (e.p->freshened)
>  		return 1;
> -	if (!freshen_file(e.p->pack_name))
> -		return 0;
> +
> +	filename = e.p->pack_name;
> +	if (!strcasecmp(pack_mtime_suffix, "pack")) {
> +		if (!freshen_file(filename))
> +			return 0;
> +		e.p->freshened = 1;
> +		return 1;
> +	}
> +
> +	/* If we want to freshen different file instead of .pack file, we need
> +	 * to make sure the file exists and create it if needed.
> +	 */
> +	filename = derive_pack_filename(filename, "pack", pack_mtime_suffix, &name_buf);

You populate name_buf here, but don't strbuf_release(&name_buf) it at the end of this function.

> +	if (lstat(filename, &st) < 0) {
> +		int fd = open(filename, O_CREAT|O_EXCL|O_WRONLY, 0664);
> +		if (fd < 0) {
> +			// here we need to check it again because other git process may created it

/* */ comments, not //, if it's needed at all. Covered in CodingGuidelines

> +			if (lstat(filename, &st) < 0)
> +				die_errno("unable to create '%s'", filename);

If we can't create this specific file here shouldn't we just continue
silently at this point? Surely if this process is screwed we're just
about to die on something more important?

And lstat() can also return transitory errors that don't indicate
"unable to create", e.g. maybe we can out of memory the kernel is
willing to give us or something (just skimming the lstat manpage).

> +		} else {
> +			close(fd);
> +		}
> +	} else {
> +		if (!freshen_file(filename))
> +			return 0;

Style/indentatino: just do "} else if (!freshen..." ?

> +	}
> +
>  	e.p->freshened = 1;
>  	return 1;
>  }
> diff --git a/packfile.c b/packfile.c
> index 755aa7aec5e..a607dda4e25 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -40,6 +40,19 @@ char *sha1_pack_index_name(const unsigned char *sha1)
>  	return odb_pack_name(&buf, sha1, "idx");
>  }
>  
> +const char *derive_pack_filename(const char *pack_name, const char *strip,
> +				const char *suffix, struct strbuf *buf)
> +{
> +	size_t len;
> +	if (!strip_suffix(pack_name, strip, &len) || !len ||
> +	    pack_name[len - 1] != '.')
> +		die(_("packfile name '%s' does not end with '.%s'"),
> +		    pack_name, strip);
> +	strbuf_add(buf, pack_name, len);
> +	strbuf_addstr(buf, suffix);
> +	return buf->buf;
> +}

Just have this return void?

>  static unsigned int pack_used_ctr;
>  static unsigned int pack_mmap_calls;
>  static unsigned int peak_pack_open_windows;
> @@ -727,6 +740,17 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
>  	 */
>  	p->pack_size = st.st_size;
>  	p->pack_local = local;
> +
> +	/* If we have different file used to freshen the mtime, we should
> +	 * use it at a higher priority.
> +	 */
> +	if (!!strcasecmp(pack_mtime_suffix, "pack")) {
> +		struct strbuf name_buf = STRBUF_INIT;
> +		const char *filename;
> +
> +		filename = derive_pack_filename(path, "idx", pack_mtime_suffix, &name_buf);
> +		stat(filename, &st);

I.e. the "filename" here isn't needed, just call derive_pack_filename()
and use name.buf.buf to stat.

Also: We should check the stat return value here & report errno if
needed, no?

> +test_expect_success 'do not bother loosening old objects with core.packmtimesuffix config' '
> +	obj1=$(echo three | git hash-object -w --stdin) &&
> +	obj2=$(echo four | git hash-object -w --stdin) &&
> +	pack1=$(echo $obj1 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
> +	pack2=$(echo $obj2 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
> +	git -c core.packmtimesuffix=bump prune-packed &&
> +	git cat-file -p $obj1 &&
> +	git cat-file -p $obj2 &&
> +	touch .git/objects/pack/pack-$pack2.bump &&
> +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.bump &&
> +	git -c core.packmtimesuffix=bump repack -A -d --unpack-unreachable=1.hour.ago &&

On command-lines we can spell it camel-cased, e.g. -c
core.packMtimeSuffix[...].
