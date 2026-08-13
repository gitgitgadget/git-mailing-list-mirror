Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7673F326D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644039; cv=none; b=HJVVNjLSIZ2XjRD5uf3rne7h2szkBiypWHHqiWjyWu7pXxe0t/5DmOh4ATF/SjqbawxjJKv0TVJxSi+mz/EqZlIiwekpPPA+4unWZGKdaHSsOloZFTMz0slYYkWboU5ulIqkn9v2SsspX1HKhm+GqQ0DwzWpb2lG6vqUcCaoz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644039; c=relaxed/simple;
	bh=ck7do5jiaACuDbcioQYPegG0TY08CPln40Y/WwC+Fio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQGdiiFb32waV3Lnw8ND3+E7GZNKxzXpolGP3g5E0DZZQ07lFcoTpqmd5RPLTs44/btYuUoBf0TZBP7nJWAX5JMXs5y35sX317za10li0dwUL98nxAnyZOybsiAaUG5IjGp5cpD34sHB8IZxRYtXpERnkVyO4yg+StK4aB5PyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eJeylrhH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iySW2GlY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eJeylrhH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iySW2GlY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C814CEC02D6;
	Thu, 13 Aug 2026 14:00:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 14:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786644036; x=1786730436; bh=m9qYVhSW9M
	bsZDOcdpFFTaLyjER9A2xrdQyY2WQms7s=; b=eJeylrhH7qNMLSs1mXKVefpIHz
	k9TdA41jLrS6xEdORYw1ACLnk16W90UuduGmL4sEZLEi56tW6Vv/Z4hc77rhaWPs
	LX+oDJS3Wsqe8AlzhMtAD/a8rOoElP5BdT1/2NmhXxWRVJPnlqr2a746tmooEKN/
	iUED/eve4NECelZ87hHklkRwVotxeDWo5iNlAPAce5RXSv2Obz0vqeh6Yoc+BaP+
	iS1J+hN0+f7nlBlnwk+meYi/nvG2TN5xuWMKwnQqjoXn6m7AaDMUw1gSCyIk0e/y
	gjpQM1Ef2TLoLJPUTpeRZerUOVxvBGYqKu5R2lWWUCtb1k9a9hwLVPlEULiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786644036; x=1786730436; bh=m9qYVhSW9MbsZDOcdpFFTaLyjER9A2xrdQy
	Y2WQms7s=; b=iySW2GlYu88WPehJaugL84vaikFlVjEP9vqv2MRwEbxeaqE6hKU
	08obviE7PzevBW6fpzH2GN7S+F5+RWPNT7y0gjszBGM+iD6ip9ka/jGmjEIjHw54
	5GhkFxQ4yZ5OtUcosmVtMG4VR1Ama3xhLbU1T9bPbgNiG7ZqBEfOrgtLawY3qEjC
	6J9qaNuH0qndSYSub0XIui/nTuGGqGtvYW7VtD6mw4TxXFSsY+Yi8dMpdeRtH7Oz
	raUxh4khuIoHbkkDPbeSteMRfKl9uk6miAnuhsrxQttxb74T4W+RmnMgVyvVapR5
	4F/487kRamHL04w6xjpPWgRxmjFWt/GEZbg==
X-ME-Sender: <xms:RAZ-am9Z5nANttbiBGdij2YrakRSA3SvYoqGrM7RB3lYuosFn_imRA>
    <xme:RAZ-ap_WP-8liOmjK-pCC0u_b0mdEcpwhuAdZbr8w0r8L1aBalA_ltyEsIGZwBOiT
    AEpC09P7He_osRpJlbXwkOv6KXFdueE4fJvh312rwYqdwXxAdU0HA>
X-ME-Received: <xmr:RAZ-ale_X94CJIAFrubQAdlowvBoIFpf13rkZskKjZMSi0Q0ilrSIVzHrKJWeYrT309VWvBR3qvD_pIujX1i9J0CIb-PgFznLA>
X-ME-Proxy-Cause: dmFkZTGcL8JDxyWbmHeONwVrfhINZLBeC6R/myrXa7GGgKkYvvUkcO4TwzFAXe6o8hqHg9
    tXfvYss90+K0eRSy0pBdZSQUfJSlFBOCLAgxhU5FpxHE+sk8rgjUqaH/acrySL9jpw5BZF
    LaWndBGL7UD9zoq/HXJ+7jWlIfktCrGcWyfnQ5KTiEPeZ9L6y69VUr75WSXZT7PxqVkFq+
    yAPTJyiWq8NsO52YiuM6tWbb1HhDxd5y2mPb2aXIS2+YD2gJiZgc/G5BY6d+XKn5Q6eD+H
    fdaad8U9rtTwwn51wqmiFD9JoKCiXFRDHKJkc6f3y6yZyjckV0fzTUvUquGw3VqiZhW7Dg
    2tYO/EVJzQKqYEXnTWkCo+DFVI7OzrJxJL6K/6htKUTYJSrb5QNLc+MeGE/jJnm5lGpskW
    ObQS7aLVt9qTkeZeijUxK5btz8HQvgi/ol8u/kwQZxjfy57jAocFA/xueRSR5o4rgV35lt
    5TbG8rYYXv4sUU5HNLAt/nGoI/GmCEvi+3xRHDeWiu5ELsj7LVjWZGskERgve05vYuyTrs
    SAIevF9x/mh1BDI7jijpW3CFDnmTMeQfxKMzHbMhsipA0wXu27sryLmjqCLTGP9iGW8aoT
    Y1emzRyEqiABHTN6kcEnhthv58GtbhpaBTeaHJP8eYiYQYstMFa47XonkNLg
X-ME-Proxy: <xmx:RAZ-aqEdQvUcRHb8fJR3CFvO21XzPh3hIkS5J16OP9tlBo4BNv2vKg>
    <xmx:RAZ-arfEwsy8dREcXvtR0yZTOtiOpPjs2hV1_WaAATExKqiWwAhrEw>
    <xmx:RAZ-asE1MaTRdF3uChzgK56qzMkrEO7Z6vzPKNiBa-c8BE1gF6geUQ>
    <xmx:RAZ-asUJWm4LIZWWYOJokHgk6tYUwtrf7fTPBszYtn4yGlDPYSZ3DA>
    <xmx:RAZ-ahhdB7L5BN5m5kz2Obw3GW0erbbp8Nb3uBIEx83xoXzrHG5xrYJE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 14:00:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] bundle: generate packfiles via the object database
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-5-7dec431ae7cd@pks.im>
	(Patrick Steinhardt's message of "Fri, 07 Aug 2026 12:45:11 +0200")
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
	<20260807-b4-pks-odb-generate-pack-v1-5-7dec431ae7cd@pks.im>
Date: Thu, 13 Aug 2026 11:00:34 -0700
Message-ID: <xmqqmrupsxx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
> data that gets appended to the bundle header. While bundles are not
> part of the wire protocol, they are a transfer mechanism for packs all
> the same, so convert them to use the pack generation interface of the
> object database as well.
>
> This makes the pack generator the single spawn point for all pack
> streams that leave the repository, leaving only local maintenance tasks
> like git-repack(1) with direct knowledge of git-pack-objects(1).

Nice to see that the series aims for completeness.

> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index bfafadc984..de86e092a6 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -69,7 +69,6 @@ static int parse_options_cmd_bundle(int argc,
>  
>  static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
>  			     struct repository *repo UNUSED) {
> -	struct strvec pack_opts = STRVEC_INIT;
>  	int progress = isatty(STDERR_FILENO);
>  	int version = -1;
>  	struct option options[] = {
> @@ -92,16 +91,9 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
>  			builtin_bundle_create_usage, options, &bundle_file);
>  	/* bundle internals use argv[1] as further parameters */
>  
> -	if (progress)
> -		strvec_push(&pack_opts, "--progress");
> -	else
> -		strvec_push(&pack_opts, "--quiet");
> -	strvec_push(&pack_opts, "--all-progress-implied");
> -
>  	if (!startup_info->have_repository)
>  		die(_("Need a repository to create a bundle."));
> -	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
> -	strvec_clear(&pack_opts);
> +	ret = !!create_bundle(the_repository, bundle_file, argc, argv, version, progress);
>  	free(bundle_file);
>  	return ret;
>  }

At this point after we determined startup_info->have_repository is
true, we should be able to rely on "repo", not "the_repository".
But the callchain starting at the create_bundle() function might not
be ready yet.  Let's keep reading.

> diff --git a/bundle.c b/bundle.c
> index b64716f252..09afc465c0 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -325,50 +325,52 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
>  
>  
>  /* Write the pack data to bundle_fd */
> -static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
> +static int write_pack_data(int bundle_fd, struct rev_info *revs, int progress)
>  {
> -	struct child_process pack_objects = CHILD_PROCESS_INIT;
> +	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
> +	struct odb_pack_generator *generator;
> +	int ret = 0;
>  	int i;
>  
> -	strvec_pushl(&pack_objects.args,
> -		     "pack-objects",
> -		     "--stdout", "--thin", "--delta-base-offset",
> -		     NULL);
> -	strvec_pushv(&pack_objects.args, pack_options->v);
> +	opts.thin = 1;
> +	opts.ofs_delta = 1;
> +	if (progress)
> +		opts.progress = ODB_GENERATE_PACK_PROGRESS_VERBOSE;
>  	if (revs->filter.choice)
> -		strvec_pushf(&pack_objects.args, "--filter=%s",
> -			     list_objects_filter_spec(&revs->filter));
> -	pack_objects.in = -1;
> -	pack_objects.out = bundle_fd;
> -	pack_objects.git_cmd = 1;
> +		opts.filter_spec = list_objects_filter_spec(&revs->filter);
>  
>  	/*
> -	 * start_command() will close our descriptor if it's >1. Duplicate it
> -	 * to avoid surprising the caller.
> +	 * The pack generator will consume our descriptor if it's >1.
> +	 * Duplicate it to avoid surprising the caller.
>  	 */
> -	if (pack_objects.out > 1) {
> -		pack_objects.out = dup(pack_objects.out);
> -		if (pack_objects.out < 0) {
> -			error_errno(_("unable to dup bundle descriptor"));
> -			child_process_clear(&pack_objects);
> -			return -1;
> -		}
> +	opts.pack_fd = bundle_fd;
> +	if (opts.pack_fd > 1) {
> +		opts.pack_fd = dup(bundle_fd);
> +		if (opts.pack_fd < 0)
> +			return error_errno(_("unable to dup bundle descriptor"));
>  	}
>  
> -	if (start_command(&pack_objects))
> -		return error(_("Could not spawn pack-objects"));
> -
>  	for (i = 0; i < revs->pending.nr; i++) {
>  		struct object *object = revs->pending.objects[i].item;
>  		if (object->flags & UNINTERESTING)
> -			write_or_die(pack_objects.in, "^", 1);
> -		write_or_die(pack_objects.in, oid_to_hex(&object->oid), the_hash_algo->hexsz);
> -		write_or_die(pack_objects.in, "\n", 1);
> +			oid_array_append(&opts.haves, &object->oid);
> +		else
> +			oid_array_append(&opts.wants, &object->oid);
>  	}
> -	close(pack_objects.in);
> -	if (finish_command(&pack_objects))
> -		return error(_("pack-objects died"));
> -	return 0;
> +
> +	if (odb_generate_pack(the_repository->objects, &generator, &opts)) {
> +		ret = error(_("Could not spawn pack-objects"));
> +		goto out;
> +	}
> +
> +	if (odb_pack_generator_finish(generator)) {
> +		ret = error(_("pack-objects died"));
> +		goto out;
> +	}
> +
> +out:
> +	odb_generate_pack_options_release(&opts);
> +	return ret;
>  }

This function uses the_repository, both directly and through
the_hash_algo macro.  I think we could use revs->repo here.  An
obvious alternative is to give this function a new parameter "struct
repository *repo" but then we would have to worry about what should
happen when it and revs->repo go out of sync.

> @@ -476,7 +478,7 @@ static void write_bundle_prerequisites(struct commit *commit, void *data)
>  }
>  
>  int create_bundle(struct repository *r, const char *path,
> -		  int argc, const char **argv, struct strvec *pack_options, int version)
> +		  int argc, const char **argv, int version, int progress)
>  {
>  	struct lock_file lock = LOCK_INIT;
>  	int bundle_fd = -1;
> @@ -584,7 +586,7 @@ int create_bundle(struct repository *r, const char *path,
>  	}
>  
>  	/* write pack */
> -	if (write_pack_data(bundle_fd, &revs_copy, pack_options)) {
> +	if (write_pack_data(bundle_fd, &revs_copy, progress)) {
>  		ret = -1;
>  		goto out;
>  	}
> diff --git a/bundle.h b/bundle.h
> index d664b2f2d6..471da23d1b 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -27,8 +27,7 @@ int read_bundle_header(const char *path, struct bundle_header *header);
>  int read_bundle_header_fd(int fd, struct bundle_header *header,
>  			  const char *report_path);
>  int create_bundle(struct repository *r, const char *path,
> -		  int argc, const char **argv, struct strvec *pack_options,
> -		  int version);
> +		  int argc, const char **argv, int version, int progress);
>  
>  enum verify_bundle_flags {
>  	VERIFY_BUNDLE_VERBOSE = (1 << 0),
