Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202EB46D0BD
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245500; cv=none; b=JjcO8I4eCeu0xsyEM84lP4l0mja0fjoOKjJFHyRfMR0OhRDtmyE8Tcd+/qwtx7t1gRPAxlo+9c2Wc8ANMJVhSpGn4ske8sEGjdynNbK92iNnONrduPJZ7vli/95ajf73ChcPKdbVPXIlObbE3iK3/H28w84fCfVwZoW80tU0arM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245500; c=relaxed/simple;
	bh=90oyMUzmh18WlVAE+kl7DezxPSOoGxlQKTD7Y5RqFdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FUtcm9ojBbwObzOsKl8PSI54MAlLvV9HPaJc4g0CwJ1FfB8tcciW34lgvj9oa155/bbSVDkEFC3f89Q8ewfcxcTPBv27zwy8HZze/IOSOO2sHG+SuUcePhW+uPCWm6PKn8sSLfuU4K7qAxbNFsOxfwup43iDHrQ/Fo1jOqSbP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y3xkYbxb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNRauo4E; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y3xkYbxb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNRauo4E"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 519AA1D000A6;
	Thu, 20 Aug 2026 13:04:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 20 Aug 2026 13:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787245497; x=1787331897; bh=UkjETsdYsk
	VpcsVzNxFcx+Lm9pZHb16YFUlCsg53hfE=; b=y3xkYbxbrP9Yrp6cIKkd76lL0W
	/+wRIt7I6LGYoBy3hPK51WDCLFWoBFJdnaamrUonTD3m3ej4ZR23wAxqcM8NkLPd
	uRsmcqcr8pYwGcNG5uRmsUghOYALbQShl4iXb2btNDQIiKBIBwB65QwPDbfyPO3n
	kmiTo2JoVesIEO+Ym7PZoEMnyfVA7bn8repOIrMMn8qd2aselquapGdOiDSPnAtQ
	TEipz42KiVtfSlnAs+MFuopkqz3tZ7/5rvdk+7WU7CG3gITq/DVqWUkCOaJhnjr1
	SiaoUSzMoRgoV/HCWzR8Tjaz/xsPKhQH671UpTcqVPKTUJ8ciS0hX320WhcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787245497; x=1787331897; bh=UkjETsdYskVpcsVzNxFcx+Lm9pZHb16YFUl
	Csg53hfE=; b=RNRauo4E8p2AXtxCK8fHFOuU6WKaEO+ptgBwh34JD8D+hIBsh1Z
	0ZBxyO1B/ARpOSmaPuGpSr8m1pd1zEnZlACVGZLLloWV3H6/B1DHVq/U9x6MbEkL
	LflPIyVMLwI/EoKC+IZZ1/aXxkmyzNbqOuQeiapBagElUjaI3guZcf2nSle9iixz
	lRZaO2j1/9ei8mgvwqyN0g3IT7O/CJ3jQTa5d7GsxC6yZKNj1SfxTbkbutgY98q2
	DiUWHpeVmRFJJU2rH4lU63ClKDpuis142JaTT8LuviPvIKTahenR6utbZSMnm4Xa
	1Ihz8QbLyzcgEp+SZRa/7N4PhX/elzsCl/A==
X-ME-Sender: <xms:uDOHahVLj9mEpZpkcvYwP2B8f7-aMfBCQlMkmOgpOhI4WmEeLJH2IA>
    <xme:uDOHaoe8AOj4ZMTiqM03XOnv-BKc1f2Y-TWGCa5LG71GgVjc_pceGP8SERWLLJ5nl
    SDG4BXTkzAIjyPmKY458mOydzszv9F0Mz4yTUzk42HXBuYuPpoGOKk>
X-ME-Received: <xmr:uDOHalsiOPM9BgwJVNP_Bp4H7mYEg5O_ap0Iwit_QAf5vH3W_ROIAu9QaVcqpsJxg7bbpNDlI7T1yKV24DRl3VsvfsN7_TBadA>
X-ME-Proxy-Cause: dmFkZTFKxYUWtp/GutgrbzqpzsIBdIDDeEjzOfGax4adXgt25ogSWrFe/dx/m1Xzl3nGbV
    i/zS+ELbZ5ClWBBLPBz3mSQe+F2E1vKVOiXFz9qg9mZ2Hhhi3Fw8dAIw+1QDOoQlQwELMC
    Y9wkxAQSX2d04NyePZedH3IU+Q0KeWCjnAg3KRlrDfTeoyTfyClUQsgJQSq0h7Qrwqr/wJ
    dz6BB+SMOFsNILLNhkMcZsUzJ3OBgRyA8c5u4O7IGQW65D4PaOJ8dFhzlpF7HZk1IfElQw
    t0ns+RCSzHP4XU8cPOjyDd0rFwk4lOy4pR2cPp6Qepz0jEOWL37QctnZfIFr5fsxEWc/rw
    W93dhwKuPEJC+QB6n9LC6LW7JcUC1tpSYQeGGpyWzISyjbbA3U+6rhcSP4yZMo/CEoLUp5
    r4+0Uh2fFARZGVNn4C22Zn3lsF5ZimETiV8aZ/MR4NW7b51NDcssLrbRtAthR65sa2sDht
    QCVCluGWUg2j3donaGUC3ZrHcL7EefUYd1s2ry2xyVMxqd1qMsC1XorHU18VFHeuirl8ww
    xTNU+zHCP3l4z1ILBwgRKjdbEwfe7KiGYW67f6H88hc22nr3/8ZsUyk6Dcbx8mfvMXAH2l
    H1wGfPaP63chJBreGk18icZW5jmWPOhVpHSKXZZmQTUqAc9+9jQLqoYRxgzA
X-ME-Proxy: <xmx:uDOHav-MSRmqyQqqz8nqj6vJvPzXjjqGBhmrVPERR6x2PFnxUhAp6Q>
    <xmx:uDOHao3fJyvJJ1wTzQy1EU-vMq2DCXIekNoyxnfZywiG42QJyWlIbg>
    <xmx:uDOHasA2y5KOpc8riAUd0Gf_nfiCtw3260vMzVsSiXtDk7wn3NI_WA>
    <xmx:uDOHascX8GLNygLIZpfNz4GGSK1uWdl5LiCZc624qJso7K_3go2jcQ>
    <xmx:uTOHavODm3BLczZ7E44FSP9SxX9KGdiZs-j3ANw-3rFbs9Wbu_pE6AXq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 13:04:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/6] odb: introduce interface to generate packfiles
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
	(Patrick Steinhardt's message of "Thu, 20 Aug 2026 09:55:25 +0200")
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
	<20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
Date: Thu, 20 Aug 2026 10:04:55 -0700
Message-ID: <xmqqik54soy0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Packfiles have two primary use cases:
>
>   - They are used to store objects at rest in a Git repository.
>
>   - They are used on the transport layer to transfer objects between two
>     repositories.
>
> The first class is closely tied to a given object database backend, and
> as such this use is highly specific to how such a backend decides to
> store its data. This shows in git-pack-objects(1), which is used by
> git-repack(1) et al to optimize the object database, which supports lots
> of options that are closely coupled with how data is stored.
>
> But the second class is quite a lot more generic: we don't care about
> specifics of how the object database stores its objects, but to generate
> the packfiles we only care about the object graph itself. Still, this
> use case is also coupled with git-pack-objects(1).
>
> Unfortunately, because git-pack-objects(1) covers both classes, the
> result is that it is very hard to port the whole command to properly
> support pluggable object databases. There are simply way too many
> options that an alternative implementation will have a very hard time to
> support in the first place.
>
> And despite being hard to implement, it's also quite unnecessary to
> implement those backend-specific options. Optimizing the object database
> has already been made pluggable, and an alternative implementation is
> unlikely to care about cruft packs, unpacked objects, keep packs and the
> like. But we still need to make at least _parts_ of the packfile
> generation pluggable so that backends can generate packfiles for the
> transport layer itself.
>
> Introduce a new interface that lets backends generate a new packfile and
> implement that interface for the "files" backend. The options supported
> by the callback are exactly the set of options that are required for the
> transport layer, but nothing more.
>
> This means that git-pack-objects(1) itself cannot be ported over to this
> new interface, but as explained above that's a hard feat to pull off due
> to the backend-specific features. Ideally though, we should expose the
> ability to generate arbitrary packfiles using this interface. The intent
> of this is to eventually introduce a git-objects(1) subcommand (similar
> to git-refs(1)) that exposes generic interfaces for accessing everything
> related to the object database. In that case, we are able to expose only
> those options that are generic.
>
> Subsequent commits will convert git-upload-pack(1), git-send-pack(1) and
> git-bundle(1) to use this interface.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c              |  21 ++++++++
>  odb.h              | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  odb/source-files.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  odb/source.h       |  33 ++++++++++++
>  4 files changed, 355 insertions(+)
>
> diff --git a/odb.c b/odb.c
> index caf1d0f542..cd9d5b48bc 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1046,6 +1046,27 @@ bool odb_optimize_required(struct object_database *odb,
>  	return odb_source_optimize_required(odb->sources, opts);
>  }
>  
> +void odb_generate_pack_options_release(struct odb_generate_pack_options *opts)
> +{
> +	oid_array_clear(&opts->wants);
> +	oid_array_clear(&opts->haves);
> +	oid_array_clear(&opts->shallows);
> +}
> +
> +int odb_generate_pack(struct object_database *odb,
> +		      struct odb_pack_generator **out,
> +		      const struct odb_generate_pack_options *opts)
> +{
> +	if (!odb->sources->generate_pack)
> +		return error(_("primary object source does not support generating packfiles"));
> +	return odb_source_generate_pack(odb->sources, out, opts);
> +}

Perhaps a stupid question but the opts->pack_fd is documented:

> +struct odb_generate_pack_options {
> ...
> +	/*
> +	 * File descriptor that the generated pack shall be written to. If set
> +	 * to `-1`, a pipe will be created and exposed via the pack generator's
> +	 * `out` field. If set to `0`, the pack will be written to the standard
> +	 * output stream. Otherwise, the provided descriptor will be written to
> +	 * and is consumed by the generator.
> +	 */
> +	int pack_fd;
> +

Here I assume that "and is consumed by" refers to "generator writes
into it and then closes it when it is done"?

odb_source_generate_pack() delegate to source->generate_pack(),
which I presume goes to odb_source_files_generate_pack(), which in
turn assigns opts->pack_fd to cp->out and calls start_command(cp) to
run pack-objects.  The file descriptor is closed when the process
finishes.

What happens if the odb->sources[0] does not support .generate_pack?
Should opts->pack_fd be "consumed" here to avoid leaking it, or we
do not have to worry about it because the caller will soon exit
itself?
