Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5B3B2A4
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731987; cv=none; b=IRroZJV9GLNKY5XR+wei9wFcymsjPTpo++Xxq85vAxtnr52/n6r6q68hsFTFKxvNbjAsqqw6ZthrXy59n7SPtkFwXkN5tIbU4CwESC8LNhKK+FCujOVPtsnuukEoYq43OmlA+RigEB/4ncKq5Rt1gAmpzP1zpuA1CvmSZ+MNqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731987; c=relaxed/simple;
	bh=YojhkkpS8yNsRslcTRNUO3yF37oquk05oMd03J9Vop4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/nsBm4TTiI0QTHOabbp/6tM6eQhgtFE9sQ7g4O2ubV3PlFu5SFONNoA4a8fLIWP9QDgi2lmLBQHDHFk7uaxdYmXx9mQCz2HA5xmJ3BPJDDrdr2e7AWAsDhW8YSKseoUKWfgxFi4A6M+5Sxrb30JPbSBqh2gUnDx3rXsaneOWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JkxUUpOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvoX59oo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JkxUUpOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvoX59oo"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 06BFC1140174;
	Wed, 10 Apr 2024 02:53:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Apr 2024 02:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712731985; x=1712818385; bh=l4AYY0LCLE
	TtSCDt5jicxoYaiLf3ktUoYWpSEPMMvvI=; b=JkxUUpOMpLfb2VRvteAOCNSsKS
	Ix6pg3zyHmgytlgs237rYQAlnQ/DwiXjZrYaNdLE26nkJ0Ueeekj6LD0dTT8ybIX
	/39dDaXoLyBtJpdOb0abiRX8PK1KVuM3Z3ScDyGTnVjIGlCM+H6sXQSskJRQu8cB
	D9Deo520Dqd7RZkAt7Zf4twyfhNn0ytH1ofTsUDmIGlDnjA1ASp2+zuJQNZ/BY7a
	3ThRbVbv6cSq3nXGtI83fYT4vttuO5CCKAAuKyJIMnw8DXGrS1ZgY33HW08BXZA0
	wMyhxOCwSErRS1omASYG4ACkEViPZP5b0sdE/sCI8aUZc0YrKOMDhHL290Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712731985; x=1712818385; bh=l4AYY0LCLETtSCDt5jicxoYaiLf3
	ktUoYWpSEPMMvvI=; b=XvoX59oodZkfrE8NbuMN0BbayeoR4gCv5Ox3AbgyV230
	Rk2BC2MnoNA2WdBLUxXkpqIjy7AhxXRYwbgo0pgKj02EXv1g/8OJPXiELDRF2Jgf
	1PF1kkCwhHzfM2/9OcTR3Yt+xkaCgV6oTAou59HMYnawz3O4HjoGuM8fmcVLlZFm
	I+mPT8dznaawZY01pN/5qLqvGNUPtbZmc1YpqSpmNd77Jty7ThD3ImBtTWbT8iSp
	W8P3KZUY2bYSPWat4GQQdA/xYxJpdaPKtV6jmixhWVKs9fKDG0wZO0gVApMNDco9
	fSO5opIMhJUWE4uLl6MQwto3TQjGWctVFPBsVcU4TQ==
X-ME-Sender: <xms:UDcWZg25JVoczMtOARaWEB0KRIVqDmm0cLN8oBTcJzuDhCGk76XLDQ>
    <xme:UDcWZrGUQ2z_AcBsV948316patb29gnTvuKkTCxTt0WEjCnN7FCe7ilp7LDLy4f0S
    yyhW08LnASqLvwIEw>
X-ME-Received: <xmr:UDcWZo6t6VjK56TSok7V-RDp6Zo5tiB16nMFGqweUe6xge50S2hOTrVxSXQPgLfYxQgFnLgBEJ7gt-NtTrPORcp1b_iCwLBrMajCIairVcH9NNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:UDcWZp3lNzWt5LovMjAN80GU15mr1WcJFCnkXPv2qqXi5UHrRe4uVQ>
    <xmx:UDcWZjGWF_AMM3i6GiKMQuycsZZ68EEjBirjztBzAxtPOUeCYwZPUA>
    <xmx:UDcWZi-VDd8_drNDkfLbuzfkfwCOZCtmuJyGEx5Nn-0QtKQTBgMb6Q>
    <xmx:UDcWZolQwuiedjThpVbu2vYRiw03w2wfg0fyaXXTvMO5HM0FIlG_ng>
    <xmx:UDcWZi2t77ZiYliPWdIgX_7K8Svxit0eb8ng2BL-7pDhukidcvHUQsrZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 02:53:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de93bb53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 06:52:50 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:52:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value in
 iterator
Message-ID: <ZhY3SUdrX2WifyZf@tanuki>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6YKR6+ivOGcEZqs3"
Content-Disposition: inline
In-Reply-To: <6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>


--6YKR6+ivOGcEZqs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 05:38:11PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
[snip]
> @@ -1928,6 +1928,7 @@ int refs_read_symbolic_ref(struct ref_store *ref_st=
ore, const char *refname,
> =20
>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  				    const char *refname,
> +				    char **referent,
>  				    int resolve_flags,
>  				    struct object_id *oid,
>  				    int *flags)

I wonder whether this really should be a `char **`. You don't seem to be
free'ing returned pointers anywhere, so this should probably at least be
`const char **` to indicate that memory is owned by the ref store. But
that would require the ref store to inevitably release it, which may
easily lead to bugs when the caller expects a different lifetime.

So how about we instead make this a `struct strbuf *referent`? This
makes it quite clear who owns the memory. Furthermore, if the caller
wants to resolve multiple refs, it would allow them to reuse the buffer
for better-optimized allocation patterns.

[snip]
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 9f9797209a4..4c23b92414a 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -34,12 +34,14 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  }
> =20
>  struct ref_entry *create_ref_entry(const char *refname,
> +				   const char *referent,
>  				   const struct object_id *oid, int flag)
>  {
>  	struct ref_entry *ref;
> =20
>  	FLEX_ALLOC_STR(ref, name, refname);
>  	oidcpy(&ref->u.value.oid, oid);
> +	ref->u.value.referent =3D referent;
>  	ref->flag =3D flag;
>  	return ref;
>  }

It's kind of hard to spot the actual changes inbetween all those changes
to callsites. Is it possible to split the patch up such that we have one
patch that changes all the callsites and one patch that does the actual
changes to implement this?

Patrick

--6YKR6+ivOGcEZqs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWN0gACgkQVbJhu7ck
PpR6qBAApRv0kFjiAy3RVuqMW4yLhSQzP1aeGjwUiwbcE0bbGltKcrvjUGTXafdq
rLp4xQpX1TYAV0uzwfoJ0v5ZIHePt2JYjecuOIjlJLmoG2XPqeVww8ZGQhN/wKdr
+ETiVSxxYuigLXEz4iAySJwfPjtioXFbBnzvbZRSVW/nF8RgOSS168TBYV+Y4sZu
ihX5LcZxmsM22JIzG3/bleHtNmTNzmy7sdN3epPOc5iP5vNbOgmeJ4le5GVBdbxN
U9TOoHsZvMxa4VTE+FpqBGBt9LU+BrWHOFoAD6Phm9SWPwUHplrTOyz+k3N7X47p
PqLr4HszWijMvqOzhK/zZMIRtw4ftGLsaf/Xul8qrZJMWP/QqZZoQlD3xNwN+YQW
kkH2NXhweTuFpGIASWA0CXaumTArGGB+qwADA5EBCFn4ABinY9CFshZ75GqaT2ir
/suU9M7PwVdMFJkDDcB2QiQS5ZOH/BaRMf9NtEhgy2TJFhFR3iR9nKG7W3kAKz2M
NGxeM+KBZZaiP0wtOJ8rjHpSRqJhSWg/dhJSNkJWdWfiAn29pTaTLqAtcQimvJa1
6AL45Emu4gZ2S+IeD/gCoWvOOUc4UxggS5SyzLgZWd0+KcPtoO1MUxJGrpScm+6C
ftPZPARFKURZwnlGkGFoajfy+s1rcT9AtDeiWs11c0/YPFvcj4o=
=LQ4H
-----END PGP SIGNATURE-----

--6YKR6+ivOGcEZqs3--
