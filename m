Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2B49C4A0
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399614; cv=none; b=NJ0aa5FVyniIj01LlXOugbh1XMCGSQbi19HpHneU2u81/2Dx6ApIG4i+FlC1CuW68aoywVgkEuLPNvJWA64itIrmWYR6NItlMnepZ3L30wAvvwA949hcwGbkftH+Hx5CBEtmT/8crcCQ2figmzp1P/NcOXEB6KKcMfvIqBxavaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399614; c=relaxed/simple;
	bh=wF9/dsMuRrUkNcucLuscixqKcYxj+GPtyWdsygfFy9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzjh+zFMJY1QubeGmNfLEK6gHcFa9yigo9wBVgh6lK0WUkxItnspwC2dWG0Wlwndw4kiPD9/7QTUARbfoBUgZ7FATXHob+0yYRubiEoggKZpGmZt0J4766XJ1+Y9QeLGGoU+et2L8ZbgmnaE5Mp5U4Az+2dvmS0CXktVX15/bnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OmQRgi8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRFGO9zi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OmQRgi8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRFGO9zi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DDAD7A0070;
	Mon, 14 Sep 2026 11:26:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 14 Sep 2026 11:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789399612; x=1789486012; bh=XYkVk93aBO
	ImpIYzo8Fl3M9ssQINFqwj1ewFCzsSMRU=; b=OmQRgi8VIsgtbT5ObYdjtUsqWq
	wTUTwZi8qlmGz8KGMpWrxR6ZLoOyDLE03GorOGw/Gyv8KTqYkmE4LsGss99kWxqj
	AAfh+vO/McU2yqcZvCYu4HRDO4Q2qzr9C9q2zVXbjN9V9O2U4VggLDdvbeHvRNQN
	MkvmpZBLSJgHWiZjHShGIVTRus+Tr9LDWVm1AI+FEswvPt9pWFV+bKcG05aZcbGG
	RVpHi1lKGiK0AJQsDOEqyXbgoyr+r+xDQ53D3Bo/z6Ufx9bYr3JMmFO2qah0YQvo
	jMeMq1xAGOH4/5zZjxiWUSQeuYXzUrdtJAGS3A6kx7LNS/0Gj7F/msLYfzMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789399612; x=1789486012; bh=XYkVk93aBOImpIYzo8Fl3M9ssQINFqwj1ew
	FCzsSMRU=; b=CRFGO9zi82oLTr/J/4fH6pTDkJQmGdX8MVaEtS2VozvEDwkKCyA
	uK6GrCBQOp/S08iOR36BoCa6wQPsBB63VUEjd0Sp8ECRfITbOzV0OVsUtJQ0CPvK
	mjDp26c+NoFimH2cqxHMgLCJI0lUqatA8mISVY7OMtndiGcTtlZasSyVqh7jyrUC
	zQgNoLYIWrFd7/SgEtsZu+mce8Sau3vMbShW7o0y3QVxIGk+1+hael3tzPm7j8OG
	tir9IbYGIve40TwdwqP2ULkyFwTNqb5gORJikwI6/ik2JCHC1yxsAhrER0c/0HqY
	pgL8ctF+4AfwkGLihEa79k7GbF2TshoTvmQ==
X-ME-Sender: <xms:PBKoajTVtoa71LZnvsZiFQdqp4N80azVZ5vXropVkjKOjCDCuxexwg>
    <xme:PBKoarw_hKaBetAUapMTmMmno0dqebOlf5jp1fjg3wlGl3KN_AMbhs4TAX4sbc5B6
    V_GslTJb1WkfFV8za_U-N0xgfk64tI-B8QBXDZ0cZrfKi4O3DHzSKA>
X-ME-Received: <xmr:PBKoat0YzO47r8EYly7TNo2h3ww-QKSfILpgpbunkqkNYNmzJ-mM6a9a8r3jaBOmmKHQpkuIswgsYdE3p_7ylL8t-SxuhFJswEjV>
X-ME-Proxy-Cause: dmFkZTFqhlUmncHLsIOQNSVriuCGaGX+9/2BAFXyYJosYYlzZ3zJjiSLdi/Ibp5A/pGDQh
    GwTmA1PMAHc9nartG4pD99SXqEX4sQ9WJPAbPOLOpyhLmvcfrma0KBKD5jgg+WNmXa3m1e
    1FYS70N5QDOqCxM5NSGSxYsLK8geUZDP2OpGrNa/goqU5VKEjKoR7b9Foa2UYrqhGEDFy2
    QtcL9AEk/fdKcZb3GIafsqTK4NCyAe9otdn/QgsmouYHJyEut5QXctzY/76U6QAAvUe/+i
    EpJwBEhjDpwDUw3QZfqhjZ+HBTragVV/PM+cF3IMe4Z13Zo+Jbvo5aYrKufsNdx8ZMYknT
    2bhC5YOOnZYtb2PPo4cOmUZwqVBqCcv2lzcnUMZW9W7IVsO0f7ZNS98Gxok8nN7Y8RAGZD
    mKcyrMrGyat5MyHX8F9xa/Rq1eQUSoWVaQayuJHcG9/0ZCdDTo9HKX3MKwLx+EZY6+272W
    roEbGCl10iTtf07Ly/4XUQPCZx1h54mCOhyW3rnp6YCyyLpeYQsf+d1eYA1qwTbpaGrN6q
    d23S2BVdl7c60oOUi5TsBF1bQAKqpFSE+slVbLz+JcsomYRI/73ZzPb9aEtOuN+2yZ7WHf
    ObN0JQaueiHersdzXQvIWxsScgYeu3JOIad3c2mq/xRX+e3TGEemkn9NY6FQ
X-ME-Proxy: <xmx:PBKoah4yGXbliFhhjQ-cEnxESm4t0E-i9jmMyHOX2EO1HIkIERIBAw>
    <xmx:PBKoaoWAqtCvS8H__iKuwVr_U_Lyl5WybbiwOPyALH-EwlOSZPERRQ>
    <xmx:PBKoaoCEQidBs-5iR5IsZClvflbfwb8lleN8RlzobpZv2p1GncInDQ>
    <xmx:PBKoav59SCiPVMcZRYnFVcUbILPXeGcYfytDODCKk1QYs5zdSrJl7Q>
    <xmx:PBKoao-NXjeDFOvtDVL4DoOCpt8vpd2Ql6VE8dbwAqZ4lGTkNya9gRh0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 11:26:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] connected: add incremental connectivity check via
 rev-list
In-Reply-To: <ebe6c90cc58b9e1f64c9bec4a18e8cb3ce9be1b2.1789379276.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Mon, 14 Sep 2026
	09:47:56 +0000")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<ebe6c90cc58b9e1f64c9bec4a18e8cb3ce9be1b2.1789379276.git.gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 08:26:50 -0700
Message-ID: <xmqqh5jr7t1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static void verify_blob(struct repository *repo,
> +			const struct object_id *oid,
> +			struct verify_state *vs)
> +{
> +	int type;
> +
> +	if (oidset_contains(&vs->trusted_blobs, oid))
> +		return;
> +
> +	vs->blobs_checked++;
> +	type = odb_read_object_info(repo->objects, oid, NULL);
> +	if (type == OBJ_BLOB) {
> +		oidset_insert(&vs->trusted_blobs, oid);
> +		return;
> +	}
> +	if (type >= 0)
> +		die(_("object %s is a %s, not a blob"),
> +		    oid_to_hex(oid), type_name(type));
> +	if (vs->exclude_promisor_objects &&
> +	    is_promisor_object(repo, oid))
> +		return;
> +	die(_("missing blob object '%s'"), oid_to_hex(oid));
> +}

I wonder if this is_promisor_object() call comes a bit too late, as
we earlier already have called odb_read_object_info() which may have
fetched it lazily from the promisor remote?  Or do we globally
disable promisor_remote_get_direct() call somehow without having to
pass OBJECT_INFO_SKIP_FETCH_OBJECT flag?

> +static void verify_commit_tree(struct repository *repo,
> +			       struct commit *commit,
> +			       struct verify_state *vs)
> +{
> +	struct oid_array base_trees = OID_ARRAY_INIT;
> +	struct commit_list *p;
> +
> +	/*
> +	 * Parent trees are trusted: boundary parents are already
> +	 * connected, and earlier incoming parents were verified
> +	 * first due to the topological processing order.
> +	 */
> +	for (p = commit->parents; p; p = p->next) {
> +		const struct object_id *tree_oid;
> +		parse_commit_or_die(p->item);
> +		tree_oid = get_commit_tree_oid(p->item);
> +		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
> +		oid_array_append(&base_trees, tree_oid);
> +	}
> +
> +	verify_tree(repo, get_commit_tree_oid(commit),
> +		    &base_trees, vs, 0);
> +	oid_array_clear(&base_trees);
> +}

Do we assume that we do not have to deal with repository corruption
in any graceful way?  I am just wondering what happens when
get_commit_tree_oid() yields NULL after parse_commit_or_die() finds
p->item is a valid-looking commit object but the tree within it is
not, and we end up passing NULL to tree_map_add(), perhaps?

The same potential issue may exist in the get_commit_tree_oid() call
outside the look at the end on the incoming commit's tree.
