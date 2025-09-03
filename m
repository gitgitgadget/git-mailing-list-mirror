Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2B257AD1
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894528; cv=none; b=qsCCymVJb++hY/ad/S/GVqfTi51QhEiFuJWE2RdPpKkeownFZsbjatNIhgUbzN6mtjYkl7GHhilkBB4X6nONeWALQ8mxhO3cVqK/sa/cVrON5TT4ruBIIy7ZWEj4pNGzoxCy5JiZQ4Ugh8slBiDZdY/Mykn/oM8mZfpuYHyn0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894528; c=relaxed/simple;
	bh=RbHuDN3frvgn+DZTd9sH2I+W5clTXD5mY4JLByzsu9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws8nylM5JEUrapTrzd1yS2aqgmaoBzoRO2N//kL9lDs3dCR6KfK3XhaczElT4HliTOr7eWqwVgWNlMymuWIKArgTe5v5sLQ9FUoXgWrv9Cb0t7UeT2ixoymSVzn8RtdHr6LG6dCl1x82jGH2zjAVCiL+I+TpFWm1mq5rgJRF6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xnhl46H0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2772JZQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xnhl46H0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2772JZQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF5B414003FB;
	Wed,  3 Sep 2025 06:15:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 06:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756894525; x=1756980925; bh=BhiVVQVVaa
	7Y43jG4WtjU5LR9wp8kOr8qUtME2Jyb2I=; b=Xnhl46H0hlOVWycj1Hz72F5n/K
	TKlhqMVG5m94kUhSByK2mo+Oh7/9mlMZjd4ajhQ8hfiBkZ91X44pBFZwZkHUZFzm
	tCQD4grg1BGe/3ReH36YgD1obMrniO3au6ByQbLhVSnLqgL85l+5/fdgLVBHHo2z
	I76NyJY2IAtjifRzGr4z9ZCRUhTPA+fIv1e9KR/5Wtjao2cSrCOzWryN+opprWfI
	y63bdASSAdMIUtzJL//buSx2y4zn/xSs+TYcFjx/HW04598xiDMlFiEF/IxcS5KP
	rIBA0GHen7FXfBIiXj8thTk30J/PgXGI+ACXcaYSpiC9obOwj12Bat4he/4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894525; x=1756980925; bh=BhiVVQVVaa7Y43jG4WtjU5LR9wp8kOr8qUt
	ME2Jyb2I=; b=I2772JZQqvkyjcx+82BvnRt2d2qArYFH4AAYaOOYMVFJ+0/zZti
	NWKGpJNyYE0LRCaUsVXkB/yulRgg/y2C8r2LhgAT8nM+2vftlllj6qLa6qnH9VJi
	DVQmFCuNUndLudCugVhUwmDdpssLwjIXVkM1KPAGbUYfhgBVQ5wwBRrj9IsaMmCE
	1CnybikbAhz6Hztrb0v2jdV4QSwqWehkSgB65612a3gmubzTL/QKZB5BBto4nKnb
	dnD3UJL044Dn78Yl5gHkSSMnOQfK+8z4g+LwXkN/rIGm63SSjUQBM368D5phFxid
	ZJ7zk5sloK1IOFLiTNbrpx09Q2q/tDi1P7A==
X-ME-Sender: <xms:PRW4aEpY8KIxfIjPoSIVsIofoEGgcos16p6EeyJBcFnQEtpm6YLhWQ>
    <xme:PRW4aGKm8oLHW_ELzu3B_IQ0r2LEjwEfNJPc0jTU4SCu5NCg_-mWJj3vbI9kFqGp8
    ugW81MbE_c9JPRi8A>
X-ME-Received: <xmr:PRW4aPoNxqZSkEgAu3VqTO9loZJ8DOMh4vDcZunDE_bQF6AX-6quJcJpLHJtRILNWbuad-v-IysLC1fWvjAX6P4ls17pjKeS-gKM9kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PRW4aGxMcNZ-zOsAKyZVUFWPYuTOX0DmaMb2T6zJVbe5fKTlUg3qxw>
    <xmx:PRW4aLPrBVLx8pO57u9JZ6aBIfdHnfVntvspGx587x00g5BaRkxxPA>
    <xmx:PRW4aD51hReNKs9U3VCG6GuvHXzI9MXFzj6o-V6tPM1cKm5wlGEHHA>
    <xmx:PRW4aMngwbuqDzTqGfML16LCEaoE4yPiLwM4DsyhxhpjUxb_cS9KCQ>
    <xmx:PRW4aCtXB8QPXUWgs__um29BsyJeO9iBJZ1-qaZ4d8BwzK0VszhnqTcE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:15:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b41b1f9f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 10:15:24 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:15:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/6] midx-write: use uint32_t for preferred_pack_idx
Message-ID: <aLgVOa96grWC3G0Q@pks.im>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <2290e27ded03866cb816be5fb6e08b83a75a6f07.1756589007.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2290e27ded03866cb816be5fb6e08b83a75a6f07.1756589007.git.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 09:23:25PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> midx-write.c has the DISABLE_SIGN_COMPARE_WARNINGS macro defined for a
> few reasons, but the biggest one is the use of a signed
> preferred_pack_idx member inside the write_midx_context struct. The code
> currently uses -1 to indicate an unset preferred pack but pack int ids
> are normally handled as uint32_t. There are also a few loops that search
> for the preferred pack by name and those iterators will need updates to
> uint32_t in the next change.
> 
> For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
> equality check. The macro stores the max value of a uint32_t, so we
> cannot store a preferred pack that appears last in a list of 2^32 total
> packs, but that's expected to be unreasonable already. This improves the
> range from 2^31 already.

Tiny nit: the last sentence reads a bit funny. Maybe something like
this?

    Furthermore, with this change we end up extending the range from
    2^31 possible packs to 2^32-1.

> There are some careful things to worry about with initializing the
> preferred pack in the struct and using that value when searching for a
> preferred pack that was already incorrect but accidentally working when
> the index was initialized to zero.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  midx-write.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/midx-write.c b/midx-write.c
> index cb0211289d..1822268ce2 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -274,7 +275,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
>  	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
>  
>  	for (cur_object = start; cur_object < end; cur_object++) {
> -		if ((preferred_pack > -1) &&
> +		if ((preferred_pack != NO_PREFERRED_PACK) &&
>  		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {
>  			/*
>  			 * Objects from preferred packs are added

Neither of these braces around comparisons are really needed, but feel
free to ignore as you simply piggy-back on existing style.

> @@ -1040,7 +1042,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  	struct hashfile *f = NULL;
>  	struct lock_file lk;
>  	struct tempfile *incr;
> -	struct write_midx_context ctx = { 0 };
> +	struct write_midx_context ctx = {
> +		.preferred_pack_idx = NO_PREFERRED_PACK,
> +	 };
>  	int bitmapped_packs_concat_len = 0;
>  	int pack_name_concat_len = 0;
>  	int dropped_packs = 0;

Why is this change needed? We didn't previously initialize
`.preferred_pack_idx = -1` either.

Patrick
