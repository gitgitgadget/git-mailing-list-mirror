Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AF1DF739
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091146; cv=none; b=afhTHhaNfAdpdFX7ULkxOAlYruYhb2SzaJQKvxO1Kjn4l7Ruu55qbzrObHIkQEXF6bi3FSnkJfWeJA5TFm405KriEdI9w5FqyYRoXT5aoYs5PYZq97OM446c5jngzDEkiBthIYAAT2K8rPOXt8kjlmlDZbTQI6F81qm2LDzxe+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091146; c=relaxed/simple;
	bh=Eqjs+VYhAakTHtzlC9Y1H71RlfYh5SJqGaMq2DrvFGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZEU+NApzjs+PS6v7FY0nBps6aORAEIqVljXRsNOPDRoiUy4shC/Os+VgBHyA6FW9QfiPN1U1e81U8cFh43QPIcXCNWAxiJhNglnemG2n4IdtbhW86SVFmF7vgtHD0OWezU+XHlJNHbmjpb70+w6ZrtniePpbA27emonc7x3Dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQ58SKCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcREaUVi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQ58SKCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcREaUVi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F8DB25401FD;
	Fri, 13 Dec 2024 06:59:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 13 Dec 2024 06:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734091143; x=1734177543; bh=Ej4yz+YeRr
	je2B31psJ9u41lxSSMPaJ6gnoppCBAwg4=; b=EQ58SKCC7kwHn6wdauxn6zXXPh
	ysf895i4yt3Wv7eeTt2qbnOObjLd423YCz6sOyKABSMh7/X4GQuV4ZTnVzbDy8NY
	tx3DF32J/WDKOIQa9eMqT2pIZD727wG54aCf42ssuFW3Te2LRMi4ew/nW9HogA8h
	XcJK+ZVvCU4kQreZzfK/G5TXAWz0E64VxxlYytSNz2KsKCrF+JNaMixAy2nuzEV1
	otE9trqMQazIWy79ZWtP3XOqTmt4NzGcWKTw92xY+eoe6towcRGYmkmbrYolOKv3
	SP/0E4Y6et4VDWzXK/hyEkMqSJe2gd13CSdF8Xgr7h7Rt5zTikJ7M7F1QgJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734091143; x=1734177543; bh=Ej4yz+YeRrje2B31psJ9u41lxSSMPaJ6gno
	ppCBAwg4=; b=bcREaUVi1t44Nb3cbElkJ34/A4ACtUS00OhcJcxfEgzblYf5cR2
	gT1ourpDbaYaekrgVQTOuGaidSGhh4RtDHN3pki7nIoaOYdRrUnjA1IsQuHsfZpS
	MFmGpSvddWmFH46/lF21AgjPXLeOyA7PPKX7Li2LzOZFgaSiPIOXJmTCPu0Gj7WW
	zitv5Sx6CI74STzwsakh6wIUR0XAYUjC74EagK1XaK8B65jRVBznmhjl86SmIGpv
	0Sy2kFWkRl3G/yOUJFlz1RpFmgZScHs+kECsXXar2+CLlpUNTj53wuXDOgKbvjIZ
	1fh9/9d7mcL72/TKi5PxZjQEBQj/SeZHHlA==
X-ME-Sender: <xms:hiFcZ7qsWRJT0UBFu_q5w0_PWLleLlVtwB5eo8inrBG2J-7x18NrhQ>
    <xme:hiFcZ1rDyzBlVAX16ze9y8LuqlCVagmyJD1Xt3xH3cuC7PjZZl2iFjgQND-w08Qzk
    L_d3tDHWjZL-IstXw>
X-ME-Received: <xmr:hiFcZ4NhnfL3B7UwoNguOclTuy-h0TDzJXXCHjVpW0VqLXJEP6Daf7ioQTxxgDhm7lWT1D9YPt0TrTCG-8V8Vxhq9M2eFdXIdQx_Sw5g3Lklma0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:hyFcZ-6iRXYhq-j0KcxuqVeeWamNFqBap8gK_1uQmGnocqwZVvVeFg>
    <xmx:hyFcZ673s7-aDoVckxp0jA6pocFR1UNHm-LX-FmHYGHPzT689zr74Q>
    <xmx:hyFcZ2hldQlbI7XYt_MuU9E_DKydr7qIOjMyo0sbZgDFLzfYa0LVtA>
    <xmx:hyFcZ84ulZ5yZBZEmhikYFd4zElsc1shkoUoxIeVOsOz0zvd80FUEg>
    <xmx:hyFcZ9LyD_W8TgPxUr6obh3NWJpQ6H8sf2IkhuWpL_NrN-Ya5gulnzp6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 06:59:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ccb04f93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 11:57:20 +0000 (UTC)
Date: Fri, 13 Dec 2024 12:58:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 5/7] path-walk: visit tags and cached objects
Message-ID: <Z1whdAJ4RgQlLNl_@pks.im>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
 <a41f53f7ced7a403547ce1c239c5fbb5382cfb0f.1733514359.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41f53f7ced7a403547ce1c239c5fbb5382cfb0f.1733514359.git.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 07:45:56PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -194,6 +201,134 @@ static void clear_strmap(struct strmap *map)
>  	strmap_init(map);
>  }
>  
> +static void setup_pending_objects(struct path_walk_info *info,
> +				  struct path_walk_context *ctx)
> +{
> +	struct type_and_oid_list *tags = NULL;
> +	struct type_and_oid_list *tagged_blobs = NULL;
> +	struct type_and_oid_list *root_tree_list = NULL;
> +
> +	if (info->tags)
> +		CALLOC_ARRAY(tags, 1);
> +	if (info->blobs)
> +		CALLOC_ARRAY(tagged_blobs, 1);
> +	if (info->trees)
> +		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
> +
> +	/*
> +	 * Pending objects include:
> +	 * * Commits at branch tips.
> +	 * * Annotated tags at tag tips.
> +	 * * Any kind of object at lightweight tag tips.
> +	 * * Trees and blobs in the index (with an associated path).
> +	 */
> +	for (size_t i = 0; i < info->revs->pending.nr; i++) {
> +		struct object_array_entry *pending = info->revs->pending.objects + i;
> +		struct object *obj = pending->item;
> +
> +		/* Commits will be picked up by revision walk. */
> +		if (obj->type == OBJ_COMMIT)
> +			continue;
> +
> +		/* Navigate annotated tag object chains. */
> +		while (obj->type == OBJ_TAG) {
> +			struct tag *tag = lookup_tag(info->revs->repo, &obj->oid);
> +			if (!tag)
> +				break;

Same here as previous comments, is this an error that we should rather
report?

[snip]
> +	if (tagged_blobs) {
> +		if (tagged_blobs->oids.nr) {
> +			const char *tagged_blob_path = "/tagged-blobs";
> +			tagged_blobs->type = OBJ_BLOB;
> +			push_to_stack(ctx, tagged_blob_path);
> +			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
> +		} else {
> +			oid_array_clear(&tagged_blobs->oids);
> +			free(tagged_blobs);
> +		}
> +	}
> +	if (tags) {
> +		if (tags->oids.nr) {
> +			const char *tag_path = "/tags";
> +			tags->type = OBJ_TAG;
> +			push_to_stack(ctx, tag_path);
> +			strmap_put(&ctx->paths_to_lists, tag_path, tags);
> +		} else {
> +			oid_array_clear(&tags->oids);
> +			free(tags);
> +		}
> +	}
> +}

So this is kind of curious. Does that mean that a file named
"tagged-blobs" would be thrown into the same bag as a tagged blob? Or
are these special due to the leading "/"?

Patrick
