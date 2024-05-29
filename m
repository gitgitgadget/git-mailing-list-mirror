Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CE169377
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968884; cv=none; b=jTQxC8lrfGIB93+VMCeUR+LMw4G9BtiGSn2y2LnxK46w+4LqZOUujBsc6LFXTQlUAIc1sQVRge8lU+ZrlFlCUfW1vkiEltkFopXLIr6Lf1mWSxo9NOc0WpjiF4DES50994JWPCcpJjDaXBKHLJyo7e02gIofP1gjEBNp30kBZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968884; c=relaxed/simple;
	bh=5BpekW5D74lEVVDdA9NF8wr5lFRync0o1CvQHI1c2pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkndFmsQkuZVbdBfBOo8AMsjpF3p0JUm/8PM/AMnlT7rlJkSH2cbMHM3d6KJQoFMj7+UgzcLZdeePgZisaj7uUkJ3GrCNKvAbXBUVm7qt/0ueHzN/h88vcrbmNici059EUGjllR5hB2X2esq+VPYeic24l8CCM0aOEOP0EZ6QHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eA3MlFnE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRLI7FP+; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eA3MlFnE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRLI7FP+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9D32F1800165;
	Wed, 29 May 2024 03:48:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 03:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716968881; x=1717055281; bh=OiN9R/EpTU
	A66AzvTehAPpn3Sg962OltO0Ldw1yEss4=; b=eA3MlFnEV6WVyT8NZtVG0rwO6H
	u+STE5SpIyuVtWMU7bk/0PiLG3JBn9teNFz82zDd1e7I77lfkjf2hEtaoplJ2whr
	QzfBZ68hTrqfm2t+e2SEGa0fMnDmwtACIW4iYyeJHr9SIV4SjYUWNHPp7swJngkn
	jLCzVBTklGju3ew/LSGT6VwEvphPQwA3psG+n9dMp69vMXOdAxoqkVSFjvQxWOw2
	vPZyBHrUGDjqMCmYVVnfAEsbo8NfrlSmTubJV64eQH5IjDKnd7LqE7d5/YcY4rPG
	3tuXg2PwKTUO5Si/TTyWkt3KAlMr/x85cwmPG5B7DVhek20jzVREEzXO5F1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716968881; x=1717055281; bh=OiN9R/EpTUA66AzvTehAPpn3Sg96
	2OltO0Ldw1yEss4=; b=RRLI7FP+uJH7jB2rMzLorlS9o1yzCb1ViEa+KjgSHk40
	IFThf8XuxGh/ybLcp2tDxflWeZaSaz26l0/nOmlc8ZOK3xe6ozxiBFoAZe4Ken9I
	BsgpsOMexfy8xFZf9Dvxvvr8Nsb4FR4s4mrRqgOEqTfYKaKNZLFWnQ5Q8m0CTU3v
	IkY8v8w9Nv5bz7o/Y7jJu3Qn663IDpqiVwlStN6q77fdch/lLYrObmGyV9JeUMhK
	nmybEaiYWoQzqGjQt0qXtWqx/rV8c6hfEvj4vyF4M+/JrMFiGjho9nZfqpVnWnsd
	3lrWogUVm3r52SpKYblfzv8adp98QmPvoZRPif+eig==
X-ME-Sender: <xms:sd1WZrRuuiSYap2UKsH6miPFpgdc3WxCY8MLCzx1aB7eHmjQ3T9bew>
    <xme:sd1WZsz2vJD4ShKxkUykE_-STmzSpi33v7kg_woF64fcSjhz546aq9undzI24vSRW
    o1oXnwG2suoc4vxgw>
X-ME-Received: <xmr:sd1WZg21oMkT_WDKlMSn6RLVI12aUBxrIyeEP_ZoEMV9ThFXolnfNA-osRv9OfvMpGYvYO2XKDlqF2fDkmqf5eSUUEOlSbvBgeikKiotFT00oNAu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:sd1WZrAw9q53unzGIq_rQywG0H2rmGj0GXJMgaKMecqrJ7-2OC0baQ>
    <xmx:sd1WZkifFG2z3Jdkw79CqsK7bn5OKOZxzRiJHqLObWKP9zHdrANf2w>
    <xmx:sd1WZvodKcBDGnocK5TZF8cIyDt06Mp81L8AknlZOQRyn_FdOSLTGw>
    <xmx:sd1WZvjwhaMazZhChEoBEi9Fx32L5wJXC02fWWns11sXwtLW0KDCNg>
    <xmx:sd1WZntNyVjhqN7GOtXJ1Iuc4VECDm0oexmSuN3xjVFLiU7lp5mHTuEC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 03:48:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f86e02ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 07:47:46 +0000 (UTC)
Date: Wed, 29 May 2024 09:47:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] midx-write.c: reduce argument count for
 `get_sorted_entries()`
Message-ID: <ZlbdrczSqKgueK0g@tanuki>
References: <cover.1716482279.git.me@ttaylorr.com>
 <07dad5a5812794be6e355b1e0eb3722d452f292b.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HKd8jXHLAaP8H4G1"
Content-Disposition: inline
In-Reply-To: <07dad5a5812794be6e355b1e0eb3722d452f292b.1716482279.git.me@ttaylorr.com>


--HKd8jXHLAaP8H4G1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:38:06PM -0400, Taylor Blau wrote:
> diff --git a/midx-write.c b/midx-write.c
> index 03e95ae821..ad32e8953d 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -299,21 +299,17 @@ static void midx_fanout_add_pack_fanout(struct midx=
_fanout *fanout,
>   * Copy only the de-duplicated entries (selected by most-recent modified=
 time
>   * of a packfile containing the object).
>   */
> -static struct pack_midx_entry *get_sorted_entries(struct multi_pack_inde=
x *m,
> -						  struct pack_info *info,
> -						  uint32_t nr_packs,
> -						  size_t *nr_objects,
> -						  int preferred_pack)
> +static struct pack_midx_entry *get_sorted_entries(struct write_midx_cont=
ext *ctx)
>  {
>  	uint32_t cur_fanout, cur_pack, cur_object;
>  	size_t alloc_objects, total_objects =3D 0;
>  	struct midx_fanout fanout =3D { 0 };
>  	struct pack_midx_entry *deduplicated_entries =3D NULL;
> -	uint32_t start_pack =3D m ? m->num_packs : 0;
> +	uint32_t start_pack =3D ctx->m ? ctx->m->num_packs : 0;
> =20
> -	for (cur_pack =3D start_pack; cur_pack < nr_packs; cur_pack++)
> +	for (cur_pack =3D start_pack; cur_pack < ctx->nr; cur_pack++)
>  		total_objects =3D st_add(total_objects,
> -				       info[cur_pack].p->num_objects);
> +				       ctx->info[cur_pack].p->num_objects);
> =20
>  	/*
>  	 * As we de-duplicate by fanout value, we expect the fanout
> @@ -324,25 +320,25 @@ static struct pack_midx_entry *get_sorted_entries(s=
truct multi_pack_index *m,
> =20
>  	ALLOC_ARRAY(fanout.entries, fanout.alloc);
>  	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
> -	*nr_objects =3D 0;
> +	ctx->entries_nr =3D 0;

Nit: I think it's a bit surprising that a getter function would modify
the passed in structure. It's also a bit puzzling that we assign
`entries_nr` in here, but rely on the caller to set the corresponding
`entries` field. I think we should either have the caller assign both
fields, or we should rename the function and assign both of these fields
in the function.

Patrick

--HKd8jXHLAaP8H4G1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW3awACgkQVbJhu7ck
PpQMdA//WF349ghpZePeDLfiA5ed7JDxjVLzO3Mz+y50lRaqBqaT2u29+AgpJs6a
7XT4fMem+rF7wLeCVy2v1w+q8nmoav5NpSiOmM5cVHk2qLXS+ZwKqzuP6KmIZxg9
2cxkwkmDG+Jkzy6H66Ilh6Sxh8R66uwrdP4jhn1REXc3WtVOVl2wbtmNgg1lGz7t
yVh7r+nmrorVSwVuOdT5Wr1wArDW6NUl5v+dE0Q2P60kkdD0dFQs55jYNbH8D7om
LPSmsDqlsO8f4CVtYh3h4jZW8J5EonkQbBkHfKh2aBnW5naeZR1xhNbrdfxE+9JQ
pQA2AuPgCuaarg/4J+JmpbZzUI63NgevNjXqd4I/7vjS2XDRjR6dwGAVXBGI4OgH
5nyT+CT1Gl7M9IOT5A9CXFEZXA88bbIfSBRcfDUG5d0oyai05+RBXYV44IUM0xBD
qKNdexDC/sFPdhkv2tXf2zf1U4yBgU+xqBJZnqjUZW2hy8K90Hsbpxvj8aeuAme1
yAchRFzOQApf+OgZxrzanfaqTRQMGaonuS8jVFz8oiK3FbsaZ+In3kMDOPza6uEI
50jMXRMZhiYDuzuDzdG8kW4PowfTTnDINo9SJTQ0WjOza2aVcY82tyI9dqPnDQPy
Q2tohTHkXArPK6nIyPAUV96x6i+szXPLUhMVlJ1K/3UOvEAVns4=
=cTSt
-----END PGP SIGNATURE-----

--HKd8jXHLAaP8H4G1--
