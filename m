Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEA330B05
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938202; cv=none; b=ptenzjgsun1wPkQfGxUvnWxdamU27C7U9zZPrECyi8ZasZtGt2tlcoeLH4DMKhE3N/392BEsTqEf+XYpPwhvBtiasqoYb1VLOxkeeUngSqpgp1QPmYKngCHAzjURpOxHoD8TT4hUoCSz3Znml5sbodjovymVXj80JLx26TW1j3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938202; c=relaxed/simple;
	bh=9Qu99w2JUzvB/u8cQGwtmfOS5tQhBunoOE9BjCRjS1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yarknsnmp6qyverA5z0Xk2zn01pWuLbtijfZVjXeSOQhrJvJqfCej1DSlhyPWlXPwMxfP3tZnQw62M17/7jKRjf5wXC+L0MTxFhEVvGkNr0rq95KaK2XuF0XZWvDPuNjObrh3RZAUpcHrzW9+gvVaDvGNYyUbr/wf8MIiQBRjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQcj59cB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJRLhHYi; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQcj59cB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJRLhHYi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A1FB1400138;
	Fri,  5 Dec 2025 07:36:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Dec 2025 07:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764938198; x=1765024598; bh=o4ffmkyFMp
	W5LsSXVzyIlrudMCxufIRgglKgtPV7Bn0=; b=iQcj59cB/dem+s7e3COmbROC4J
	GzXU3eMhpy/TPjew7ZfpdWPmAnV3fpuXt4t0vdmAN52iFJ6Xkl/63brwvJH9WnR8
	49ujaoIOytl6Ya72aGv71MyK7dSLuiRQje37W91tjUloK63atAQVs+wVECQ32yzV
	DfKNrVweLFwipmMx9NRVSzQINJ/7Ix0BwgQyg21E/UTVKd4R1AQmjHRyQaWzSQUD
	oxALdmzxsu9DV4cetNLFhgcBRoMqOzECX7LN0jrZNEkJeeKanTGiLJA5gq974Z4q
	2zI7J9iKT+kQ8XkmMSfvBxMTL2YuS6XDFYzjozhRBLBxkawP/dTftcNOsXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764938198; x=1765024598; bh=o4ffmkyFMpW5LsSXVzyIlrudMCxufIRgglK
	gtPV7Bn0=; b=TJRLhHYistjk1RzdVmszfcGAYtBfOm6eIzdXYNtBpCS0ZA9JCWj
	iPP/VnIanXI7nATTXu1lS4YIkgCnky+lWr1HbEL9PabVAa0OZZhQOk9yh3MCwoig
	f1N9Tfi6eu/C2ozQ+16lYN8UkOHjnh8bfpxuBXULxbOu8me4EPBFS33mTg6Fpk1L
	/FsZ0wTtMzk1Q0PENMr+a5bSpFiT6JhUIVLcXtIQML687dgI2f7sMVmVakQcwVqX
	ZYWf+tybdN3bD32AjfuUhyU8BlncKcm/03Wuu3nRpaZhlZQj2yYXjhX6cdlIzW1t
	/QF5NXgnk67h6NxdqqF8HSt3YNHeEwJtuwg==
X-ME-Sender: <xms:1tEyaQ_Xvmd0cO1ODqy6zd76l-VLpqsQtQIgHxmueKaQ3dfpkajsDg>
    <xme:1tEyaeuq4L3xcpwryJ3ARffibObHb9dVs3o5F7L5lB_UsyqiP43zYMAI1j7oinuep
    gm16m3uYbZeRErMt-mOXOb6E6efmG-4J2Hpd4l1wZs8i1pH7v1a>
X-ME-Received: <xmr:1tEyaTreJEFSNsUKeJavECyqsJSaoX6n129JvOu7BqEXBeWrAIfrjCUfbSk6nvVpdHr29RMa1gff_8dd8Jz8P3q6yAyqr-U5OC8rYAG3yG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1tEyabkDrS1znu6eCg1k3BI6JSaMJYdL7WiRxqTS6II8w_DO5R8NLQ>
    <xmx:1tEyaXxJVaq9UcJDB10pXFJ8Q0HYwClthXwy7E5pvYv9ROuA1GgMOg>
    <xmx:1tEyaTmdPQpt1QlGUoHKX61okq-6vudx2c5g0eolwcXZXkh2hVd73w>
    <xmx:1tEyaQfanfFa_zBySPFFszROdz7pHmTFZZNHsq9EeQwnhq2YwHOOwg>
    <xmx:1tEyaSgAVvjpYR-ElcEy3WMdWD1ZXFFsdaG7e89Wt3up95oTCzv1C1fc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:36:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8110dc5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:36:36 +0000 (UTC)
Date: Fri, 5 Dec 2025 13:36:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <aTLR0YXqRO63GkJu@pks.im>
References: <20251204172132.319360-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204172132.319360-1-aplattner@nvidia.com>

On Thu, Dec 04, 2025 at 09:21:29AM -0800, Aaron Plattner wrote:
> When is_promisor_object() is called for the first time, it lazily
> initializes a set of all promisor objects by iterating through all
> objects in promisor packs. For each object, add_promisor_object() calls
> parse_object(), which decompresses and hashes the entire object.
> 
> For repositories with large pack files, this can take an extremely long
> time. For example, on a production repository with a 176 GB promisor
> pack:
> 
>  $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>  ________________________________________________________
>  Executed in   76.10 mins    fish           external
>     usr time   72.10 mins    1.83 millis   72.10 mins
>     sys time    3.56 mins    0.17 millis    3.56 mins
> 
> add_promisor_object() needs the full object for trees, commits, and
> tags. But blobs contain no references to other objects, so the function
> can just insert their oids into the set and move on.
> 
> For objects that weren't already parsed, use odb_read_object_info() to
> query the object type. If it's a blob, just insert it into the oidset
> without parsing it. This improves performance for very large pack files
> significantly:
> 
>  $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>  ________________________________________________________
>  Executed in  118.76 secs    fish           external
>     usr time   50.88 secs   11.02 millis   50.87 secs
>     sys time   36.31 secs    0.08 millis   36.31 secs
> 
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> ---
>  packfile.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/packfile.c b/packfile.c
> index 9cc11b6dc5..563fd14f0e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2309,6 +2309,17 @@ static int add_promisor_object(const struct object_id *oid,
>  	if (obj && obj->parsed) {
>  		we_parsed_object = 0;
>  	} else {
> +		/*
> +		 * Blobs don't reference other objects, so skip parsing them
> +		 * to save time.
> +		 */
> +		enum object_type type;
> +		type = odb_read_object_info(pack->repo->objects, oid, NULL);
> +		if (type == OBJ_BLOB) {
> +			oidset_insert(set, oid);
> +			return 0;
> +		}
> +
>  		we_parsed_object = 1;
>  		obj = parse_object(pack->repo, oid);
>  	}

This looks like an obvious improvement to me. While looking at the
function I noticed that we also free tree buffers here, which make
sense to reduce memory usage. I was wondering whether we want to do
the same for commit buffers, which may reduce memory usage even further.

See for example the below patch. Might be wort it to test in your large
repository to see whether it has an effect on the maximum RSS.

Thanks!

Patrick

diff --git a/packfile.c b/packfile.c
index 9cc11b6dc5..89227ada98 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2296,12 +2296,17 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	return r ? r : pack_errors;
 }
 
+struct add_promisor_object_data {
+	struct repository *repo;
+	struct oidset promisor_objects;
+};
+
 static int add_promisor_object(const struct object_id *oid,
 			       struct packed_git *pack,
 			       uint32_t pos UNUSED,
-			       void *set_)
+			       void *cb_data)
 {
-	struct oidset *set = set_;
+	struct add_promisor_object_data *data = cb_data;
 	struct object *obj;
 	int we_parsed_object;
 
@@ -2316,7 +2321,7 @@ static int add_promisor_object(const struct object_id *oid,
 	if (!obj)
 		return 1;
 
-	oidset_insert(set, oid);
+	oidset_insert(&data->promisor_objects, oid);
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
@@ -2334,38 +2339,45 @@ static int add_promisor_object(const struct object_id *oid,
 			 */
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
-			oidset_insert(set, &entry.oid);
+			oidset_insert(&data->promisor_objects, &entry.oid);
 		if (we_parsed_object)
 			free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		oidset_insert(set, get_commit_tree_oid(commit));
+		oidset_insert(&data->promisor_objects, get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
-			oidset_insert(set, &parents->item->object.oid);
+			oidset_insert(&data->promisor_objects, &parents->item->object.oid);
+
+		if (we_parsed_object)
+			free_commit_buffer(data->repo->parsed_objects, commit);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		oidset_insert(set, get_tagged_oid(tag));
+		oidset_insert(&data->promisor_objects, get_tagged_oid(tag));
 	}
 	return 0;
 }
 
 int is_promisor_object(struct repository *r, const struct object_id *oid)
 {
-	static struct oidset promisor_objects;
+	static struct add_promisor_object_data data = {
+		.promisor_objects = OIDSET_INIT,
+	};
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
+		data.repo = r;
 		if (repo_has_promisor_remote(r)) {
 			for_each_packed_object(r, add_promisor_object,
-					       &promisor_objects,
+					       &data,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY |
 					       FOR_EACH_OBJECT_PACK_ORDER);
 		}
 		promisor_objects_prepared = 1;
+		data.repo = NULL;
 	}
-	return oidset_contains(&promisor_objects, oid);
+	return oidset_contains(&data.promisor_objects, oid);
 }
 
 int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *len)
