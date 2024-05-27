Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965217BBE
	for <git@vger.kernel.org>; Mon, 27 May 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792293; cv=none; b=tNnB1Ivx7tn0ygLOdQzUaicmObWlcWcNMTflpkr1DcPI+tXZ9WT2mRmFKl/zEHE/8QSheaC8sz300ClO8KjxBRW+NYykVm+O+DhxBnf3DrAno1YvCL2AWpBhkKURpalNdVw771eh4OhbOMAJhON1z7ILdIB2q5iRTV17AGlgB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792293; c=relaxed/simple;
	bh=vkPocuYFElEJyZPHe8AVF/hpNqn572N6CtkdqzgLIWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK2BUzM7GXpQvjgai4gcR7hyCwfbMR7rmnGP9ee1eKCq3mh37VdIrSbDy4RmORB7TE8pEQCg2U8aHKZDQ2bKTYjUBCNn5AC6U2FmfBMj95pLvdOp9q1RmfiJu4iAVFp0Ghhp8scsnVq0KVctgHZo63gj5TuL22fDHPC2s8Gn1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AKaKLbe2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUvK2IP6; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AKaKLbe2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUvK2IP6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 206241C000D0;
	Mon, 27 May 2024 02:44:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 May 2024 02:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716792290; x=1716878690; bh=M6jMwH6KB/
	RujGI2uK0Ki4n7H45AKnnPMcE/dnFkWz4=; b=AKaKLbe2n+q6s2ndGcyuNvrtk7
	EiQQzPMUJ5e5PaRYi8O/A/ZoAtOLFrPTpm3ocEevQ9H8kqew7B0cWfS4WDpx+5PR
	8LaG+/lI6iabsX6ksc7BkgHYviz7UuTUuk2p7tMq6jZ4+Rbhty0ha61vRG3+9r5d
	JU/kEMEF5vsvFIng2I4poEOjWyRT/YQsIR2IauwNDZ3WffR9Y1lqDyWs8fRYaib4
	Vhs8/K4FHVV4N62X/O7OfUWGh5Ot6G9Htcs6Caj146xcLJDqwwRSddSDPbLdaTiz
	oz6Y8nnmDRxfV/zR9bLoAgdd/TthF03leR0HgF4/gYIraOfdNawRIRxD8F9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716792290; x=1716878690; bh=M6jMwH6KB/RujGI2uK0Ki4n7H45A
	KnnPMcE/dnFkWz4=; b=AUvK2IP6x9uuUkIV/bCoXQ7Oi/dz70J9ucekmDB+zVWg
	5PotdYaJ+LhVL0+r02REKj+swD2MYq7m+XGBNJ8KcJ7WX4E5zBEPAujqy3YArgkM
	q2rCZ45CO7KjP8czEZtZw0DkJesWfTU5wSz8v8EyCBX2Gax3HWSijEFL7V0uM8tF
	hm4n7uFtcK16ihr7Mr6+r6I4Fk01UsPq+G/xEo+L+IeWF20yCmkHL5cT7RIfuiaC
	zhzdrPhGeR0M3cOdg/lEtEH3rE2kdz0RDk05EchnI3RieUeKIgWxvswJFD6ejqcx
	tuW5v7Lvjus8s2kFtsHxEGta7BwQCrpRxsCgIwp+5Q==
X-ME-Sender: <xms:4itUZvFQvbTRT-O9diAbGoLsVwLAVwjLqGs_062csRlvWCOBjr_STA>
    <xme:4itUZsUYdu9zrIefGy1c7Pqh4AVmM1wR9sLr-icyVIR3jB1h2zvGooF22lai2ZW6Y
    ZYW9v5bMCIzCrvfhw>
X-ME-Received: <xmr:4itUZhLihbJKWewU8BaGn58kUzNUFQlFgHxZr9Szzwzq85hex_wwVJnsKtKjLkHF21XGcBl_iNRRaSXCGpE3DF50eD1Yn27xwQywgp0dEzAxgmCUcxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:4itUZtHZmJWRY-rTx-TERuM7gd1nJ1WsURljmKE8rrprHwVU1QbUpg>
    <xmx:4itUZlVItkxCCiMP3bjR_WpZtvcaSlM4fT7ymgubd8QCmcizvSHEyw>
    <xmx:4itUZoPG21PPQLC5s9KSNNwO2QNkbyV9dsencPTUsZJ-MRNEIVCUWQ>
    <xmx:4itUZk3JTjaUugjZPqFI2ZpC3ekEOYfLnzKbY9sg4nTX3MNAr-uNCg>
    <xmx:4itUZrxUQS8cbtooKmn_stCh2vy61gjzUEcA9L4eD77Q5_axOoB3wljG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 02:44:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2852464d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 06:44:39 +0000 (UTC)
Date: Mon, 27 May 2024 08:44:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <ZlQr3tsDTSOGvFUQ@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>
 <20240525044635.GB1895047@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KqlJbt9svDjhVH5H"
Content-Disposition: inline
In-Reply-To: <20240525044635.GB1895047@coredump.intra.peff.net>


--KqlJbt9svDjhVH5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 12:46:35AM -0400, Jeff King wrote:
> On Fri, May 24, 2024 at 12:03:29PM +0200, Patrick Steinhardt wrote:
>=20
> > In `strbuf_appendwholeline()` we call `strbuf_getwholeline()` with a
> > temporary buffer. In case the call returns an error we indicate this by
> > returning EOF, but never release the temporary buffer. This can lead to
> > a memory leak when the line has been partially filled. Fix this.
>=20
> Hmm, doesn't this indicate a bug in getwholeline()? Most strbuf
> functions on error try to leave the allocation as-is.
>=20
> At the end of the getdelim() version (which is probably what you're
> running), when we see an error we do:
>=20
>         if (!sb->buf)
>                 strbuf_init(sb, 0);
>         else
>                 strbuf_reset(sb);
>         return EOF;
>=20
> So if getdelim() returned error and left us with a buffer (but still
> returned -1 for error!), I think this code is assuming that the buffer
> it left us with was the same one that existed beforehand.
>=20
> But your commit message implies that it might allocate, hit an error,
> and then return that error along with an allocated buffer? Looks like
> that matches the getdelim() manpage, which says:
>=20
>   If *lineptr was set to NULL before the call, then the buffer should be
>   freed by the user program even on failure.
>=20
> So should we do something like:
>=20
> diff --git a/strbuf.c b/strbuf.c
> index e1076c9891..e37165812b 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -659,7 +659,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, =
int term)
>  	if (!sb->buf)
>  		strbuf_init(sb, 0);
>  	else
> -		strbuf_reset(sb);
> +		strbuf_release(sb);
>  	return EOF;
>  }
>  #else
>=20
> That assumes sb->alloc is valid after a failed call, since
> strbuf_release() checks it. But that seems reasonable. If not, we'd need
> to free() and re-initialize it ourselves, and the code is more like:
>=20
> diff --git a/strbuf.c b/strbuf.c
> index e1076c9891..aed699c6bf 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -656,10 +656,8 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp,=
 int term)
>  	 * we can just re-init, but otherwise we should make sure that our
>  	 * length is empty, and that the result is NUL-terminated.
>  	 */
> -	if (!sb->buf)
> -		strbuf_init(sb, 0);
> -	else
> -		strbuf_reset(sb);
> +	FREE_AND_NULL(sb->buf);
> +	strbuf_init(sb, 0);
>  	return EOF;
>  }
>  #else
>=20
> But I think either of those would solve your leak, _and_ would help with
> similar leaks of strbuf_getwholeline() and friends.

I'm not quite convinced that `strbuf_getwholeline()` should deallocate
the buffer for the caller, I think that makes for quite a confusing
calling convention. The caller may want to reuse the buffer for other
operations, and it feels hostile to release the buffer under their feet.

The only edge case where I think it would make sense to free allocated
data is when being passed a not-yet-allocated strbuf. But I wonder
whether the added complexity would be worth it.

I've been going through all callsites and couldn't spot any that doesn't
free the buffer on EOF. So I'd propose to leave this as-is and revisit
if we eventually see that this is causing more memory leaks.

Patrick

--KqlJbt9svDjhVH5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUK94ACgkQVbJhu7ck
PpTb5RAAlU3RPmj2M7JIB0zz3Huya83PBXjs7KeGVANgBw+IRUET39cnujJWZHQH
feyuahAolXOkisp72gX4R7v2l8gO4q5VURco5z9+kCjozWkk3du1JdpnzeCyGOf7
0yCRBYGX9y/p0wUWWFwHY0rrDqkG0h/06vDrYOaEzBKpdHBjcHkvoiD0wytD65me
G1IRL7kPxoimFwW2Tv3WSKaXGBDlidIRcNt2gtOfUft84KI/P8e3oHfZXv3nw0hi
7xBB5/bNdFfWTWyR3A6rISocnakjuZjq4jEAfMDz0tOTgF9oHGHdEZPX9PZm/o/9
DTZ8leIEtAo8qUgVtGPKMx5x0dy59SoHY5fvD2oRfbv5cIypluqe0LwF5dU9BZRJ
Tp5xjYvRBc9cANrlIdmZxda1BLlvWL//szGLupxXpHFyD6yVgjP8sKrQyXahjH6s
Ynn13uKH5jVbcO6KgNXrq3mdMIOpjp06VA7W/WULgO4Hbr/VlpKoxFp1S0DrtCDa
brxKFXM4nwtR5HCf/9xj7YOA5QSYM1h4dUr38BzczzC48QC0/ZbA7T6U6daTkWfy
gC0ruMk3vdvZ/ijxor0Z6f3u/2Na3ESMRXHji6gWgHCxOSQu/e5n62EPgFVJ3kHF
SwWpoCICVOwGfHeTOcIOrnpr8JymSGSVgHoz4PYX/RSTEe3m/sg=
=YeS7
-----END PGP SIGNATURE-----

--KqlJbt9svDjhVH5H--
