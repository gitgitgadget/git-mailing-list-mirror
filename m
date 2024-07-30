Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91A195FE5
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328293; cv=none; b=QMEv3yYtbNwBE3k2pBU21gBGxl5mwr8kHzQnUM+Kspyq8B0ZxpZXbDmQL0ayhtrQ9d6/z13OYf5rj18ir3G0E3qSNyiv1sMEOPAwXJvkrb4kWzkYkpv/QGN/3ar57RcfqE/vvIlsRq6KZTEFqvGZvIGlnFl1PVRMCXzJcPx1AzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328293; c=relaxed/simple;
	bh=teKTbe0WvTgFoWmaf6kMr3udLnvF8PMfA+c41UN/EBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz531zLcBf1+7MmMTMVq2mlSeWDPf609aFRBqo7K4erYQIt7h/TD8z9a/ZBqIJKPyH+llbi2WXUboQ1uUNMzODYIHWJjEKbA9etUo9UCNagi30C6ihAo2xfpl/4S/V1ndmKsUXlTG8NHvdpYToKYG2qmRu1CY2IZtUqTasRZ6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T2uCINWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeOmatwE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T2uCINWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeOmatwE"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 72B2111401B1;
	Tue, 30 Jul 2024 04:31:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 04:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328290; x=1722414690; bh=mxi7ph+Kiq
	SO3NzkThfWnuK6+UAJ3dSCtmtJrOo+FfQ=; b=T2uCINWwJE+mi2fK8ttkpipYCM
	lJ+GaHVmoINybvTi5q1ll+6j+6ulsGaunTOzEzvl5fh+901RacnhsnENjKZSsFSx
	aLLqqUKPHjxlu/pPOtQmFHoU3G0+i7wU1AztGH/tgzAbIqjiockj6s+AEz1u2Hpg
	ngPUZEAJ7w93QQ1+AadmOwMbU2AC9ZU/2iwgCtrtcHrz59nUgNJp5BWIbcJ3LY1n
	CFhDysfWf98wgG9gyQOHsPv4jbpx/6hcVYCWbSQL3zH9w2rb1tSW5EvdNY765UOW
	MzfadCYss+mkHtQzi+LjXZ/wIch9JcquQm0/51P9gX9vUzTSMO/YbciQH6Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328290; x=1722414690; bh=mxi7ph+KiqSO3NzkThfWnuK6+UAJ
	3dSCtmtJrOo+FfQ=; b=jeOmatwELfFSK10nRtDpdnpzF/7DLfbhrGJ+sSfYf1Kj
	YBSetS+UJ65Xct6YJ62kyqqgPUDkMX/GKwAmEf5+wNNC78VeYNvVM8imBi1kqDNN
	nTvzZNcVB1qpqHbwCP0x56+Y+he/AzhOwWfTS7kZLCFnMw5TxE0S9j+mRz+7F4PH
	LDimTz0o6u8XhofreApfc7DC2vz84ozjUamMd4wiuyiFbJ/9qMBp9uFavCsqHXD0
	x0Se/haS3sOK/Hg4Nv2wJeN9/DLarqSImB8R6VgFV4WZ0kyal3KQmi5VRaViJNSt
	nHspwavPBZJoB0rTvNz1LGaS1q8tnCLaWgzOvilG9g==
X-ME-Sender: <xms:4qSoZq0EHOhYZzpfUypogaDPUhkGRkx5KXMETbKi_IFOKcgb52lklg>
    <xme:4qSoZtGHk50t5A-S2hqdgeN766X_tP7s5ab4heGhr7z1msykosDi81nfqgYzjPhVr
    goaLrnvtGkhqFaVVQ>
X-ME-Received: <xmr:4qSoZi7y4g2HwD9bXJuc6DpRYxwKDdVHo-fUK9y82jB20SAYeYcp2b1VQkoqKU8J4k9VysAfM49-rc37pcGR9vFk0uxIRFxu6EjJRhynhsOJeQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:4qSoZr3dgTpDlvLkFMHDRXRal7ojSswAl3Kf38Ae9t2lowwByOcsmQ>
    <xmx:4qSoZtH7AiNDbwV4eq8GRGnMmQHXYG_atptrF6ZEhbXvVxGmwr9vGg>
    <xmx:4qSoZk-aFXq4u6eqr0RgOhrfCNWwlZp6D-7EloY94dUL_fiDG0jlZQ>
    <xmx:4qSoZik_R5mSYY8SZcqJh4Ymbc2Zkf9iRY8C59v-Y50cNr474seuYQ>
    <xmx:4qSoZi7v99ADnMuutUpzdoTOSRnaLNtl0QNSjPF4frlldjr2SDf_Zv_1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d847da7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:01 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 04/10] fsck: add refs-related error report
 function
Message-ID: <Zqik3kQivsfetIQj@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYm2J1LeXn_1-4@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sHyzgqPtfeqpzUHR"
Content-Disposition: inline
In-Reply-To: <ZqeYm2J1LeXn_1-4@ArchLinux>


--sHyzgqPtfeqpzUHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:26:51PM +0800, shejialuo wrote:
> Add refs-related options to the "fsck_options", create refs-specific
> "error_func" callback "fsck_refs_error_function".

We should have an explanation _why_ we are adding these functions in the
commit message.

> "fsck_refs_error_function" will use the "oid" parameter. When the caller
> passes the oid, it will use "oid_to_hex" to get the corresponding hex
> value to report to the caller.
>=20
> Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
> macros to create refs options easily.

It is a bit unclear to me what you mean with "create refs options
easily". Do you mean to say that `git refs check` (or whatever this will
be called) will have flags like "--strict"?

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  fsck.c | 25 +++++++++++++++++++++++++
>  fsck.h | 14 ++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/fsck.c b/fsck.c
> index af61fa90ba..56de29b4c0 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -1251,6 +1251,31 @@ int fsck_objects_error_function(struct fsck_option=
s *o,
>  	return 1;
>  }
> =20
> +int fsck_refs_error_function(struct fsck_options *options,
> +			     const struct object_id *oid,
> +			     enum object_type object_type UNUSED,
> +			     const struct fsck_refs_info *refs_info,
> +			     enum fsck_msg_type msg_type,
> +			     enum fsck_msg_id msg_id UNUSED,
> +			     const char *message)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int ret =3D 0;
> +
> +	strbuf_addstr(&sb, refs_info->path);
> +
> +	if (oid)
> +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));

Okay, so we do end up printing the object ID indeed. But wouldn't we
want to potentially do the same with symbolic refs?

Also, would it make more sense to put the `oid` (and potentially the
`referent` when we also handle symbolic refs) into `struct
fsck_refs_info`? Like this, the whole state would be self-contained in
that structure, which would also make my proposal from a preceding
commit more feasible where the subsystem-specific error functions only
get a void pointer to this structure. It would require another
refactoring on top to move the object type and OID into a `struct
fsck_objects_info`, too, but that shouldn't be too involved, I guess.

Patrick

--sHyzgqPtfeqpzUHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopN4ACgkQVbJhu7ck
PpThMQ//SZBe7G2M7NJbcBrE2Y9CWQqdal87kJUTbB47wN1LANJlwPSAAuLqNsEN
XJ1Rn0NTlA9xsYIzwSxzog08ir0Qj6y3n7g50KZhmY+kwkFRSHNQ3c4rvQ/pNYnH
ZIfH1WrNHro2qJieFlbPTvCRBuauaQS/glPTHQYbDlRWfQFXSn3+BqEpl2omjvpf
KNv85zgK+qivvdQDwc29SGDHTEQra0PKyYrYuFgQ3DaA9Hl8AXcwW1qhC+RiWOcL
1BZPzbKkWHFk/Z3VqCm9OXdUXk4Fwi33W+aMqSUoB49eLpPe/mi0so0QWALGcjX+
eM3deIpMc4it72Lhq7G29kj4b+e8sJJWt43zGR88X4qlTTCq/APXLMGsu5uBAGGI
WkbDJYl81CoToBXpT/rHutSket+QHCJS5PfSOr8PyXn13vmX+GqNMIufTkEe499L
DLtyTMXvUe32IlChpJhLbyl7y2xCl/BRrwCkie1SvLDBNYfrhpicLl26FKro8Y4/
htxv26YN7eUcxrQAX7FpdG/rsmkda1By7Y5Uty/31x38gPBo0fCziNkweCmyJY0u
vnZX8W7mNoYGudaXUqa/UtdfVi5k56RRsfngL6+bCamieSG73EIPnYYqK/6N61pi
T10Z528R7lU/kL0CRo7JJh7BktOai87FbMOtP2VlF3T30uaMs3s=
=0fCd
-----END PGP SIGNATURE-----

--sHyzgqPtfeqpzUHR--
