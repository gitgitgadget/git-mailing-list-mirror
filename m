Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF52032C
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060422; cv=none; b=HIro8XI0J/9p43cJPV2PdLILhAyWTx8wAGUcdQSQUpiYpp8SgXXvIfSscHuLzuk7CR3GNqTlGAKDyt70MIM/gQeJHt7HAgFcFwGsqbdIGFbIbHPiukSi1ScXN1hrtNHy0ARMsDqDGzQs8YgbO1BatXOojicCiQjpE4M3URxK1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060422; c=relaxed/simple;
	bh=bHRHTbIHANozijBlW2kiQfnixLuJxyMLw/3ybYqQWAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luTWFfN8B39Zgl8CV7gXHyIuJU04g7mpwmR391XEItOZ9YXOoZ8ojMs+7gLAP5b7+owxTdZuEAmHNtciGcqtdq53UWcuChIvllncrJOF0WSuOV4x2VNzL0OLnryQY1iNkmEJ6hXZcC7erYc5Bd/lRKgZG6tfIQv7hUS4E8ktKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PO6me6dv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obGUXmnC; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PO6me6dv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obGUXmnC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 22DE61C000D0;
	Tue,  2 Apr 2024 08:20:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 08:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712060417; x=1712146817; bh=EhVGnLoDfR
	dSPMuqAINchO2h+1x/5BbqJdB7M8qFIl4=; b=PO6me6dvbKqCXAXhBo54lPclim
	/AwzuNEaYeTji3DTtQ6DFhOzbqfcMlPDaWa6hcbO8a44QYAE0Nz8ZBFMniJj8Ixy
	WFRmdU42NTImWMDUSH1zTbzOcFoX7D8csm0gtOrFs7Ye6MCHTNkGejKaz+vn71/v
	WR959ysMVEDWYLxbmdiQ8M9t8Jl841Fz5pXFjidpX6rFgQ8Sr6sM1yO41KLf+YRX
	Nigp3FyQ9A9V40GuaL7+M832JkjX66TOdDeWAy4LBwSQfGh4TwfFIpcP8G+++WzQ
	dkdTHOlRXKl0tl/6wMWrWFvR6s3kJsjyjk2SfGv5eqqQDkBmxnrd2+1N2bcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712060417; x=1712146817; bh=EhVGnLoDfRdSPMuqAINchO2h+1x/
	5BbqJdB7M8qFIl4=; b=obGUXmnCHZGsY99iO3vazviaTdXv4k5lk2GK22FVa1W9
	KBZ5uEKB7I5m3EMYcV0FJrg8Cy5km1iM7CoLgz96YVYjRShwZrEyS99NjH+WnZ2A
	hrVE7nL8vC8mOD4DmRvjpCXq7HP+DG43ci/HBlXxLi7XJ17tHmMXtndEcWlwfFc6
	tu4v9w+sc6Sfdo1HfTcHyLVrFRFPmz54ozFUg0Uf5sntdxucIe+0U/iD8hvNQ5zI
	N5xs1j7/KkPmb7yTbOfZ7Ah8aZ0/w+M1gvFJ6hrS7VJDbKqb6f0HAGeyId8odtTP
	tFeFFqZQ7t3+U0F/QkbYq/5rGzYuXkDrtUNtlBf1Kg==
X-ME-Sender: <xms:AfgLZt33etYgRMHBAZB9wsGK_ydM6-dYZeOFQErI9dpvhT9pzgFxcQ>
    <xme:AfgLZkEzvjp9xMf-XPTfTl25FuWf8aAGjrVo8m4wCR2EL1sqbrz9UszkYbuuUhV6w
    Zam1SaboWu7cyOAoA>
X-ME-Received: <xmr:AfgLZt6QVHrXiTcn1X7vzY78G4loWHV2TsLcgEgpdi2syk0U9-E5v6zTUreObFKWWvh09IWZWQ7v0Nse_kh2zeMgYfl1Stta65gWpFIdZ2f9IjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:AfgLZq2OtGXqfw5g6DJDYW6YllTOSXD_FS66Mm-ThZyLFnpEb6j_lw>
    <xmx:AfgLZgHyz0__Kc2heBDi2MqHpI20g61xMYTYOLmb7wtDXek7X8mdIA>
    <xmx:AfgLZr-MyUZ7OhaiFhdx1ZOd6xWhIuOSmot1Thq3xnrc_F9atpFVrg>
    <xmx:AfgLZtkY9gygD8os-nIgPh7mfnPczUpQaPzvHnAW-JjFN7sTxAjhQw>
    <xmx:AfgLZkArqSy6A9e9B-Kw5bm8VijXur4yRFcnnd8FRhnFvE9A_-9rEogi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 08:20:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7dc681a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 12:20:06 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] files-backend: extract out `create_symref_lock`
Message-ID: <Zgv3_K_gCkPyZvRQ@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-2-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TaJg66gZSbzeNuDw"
Content-Disposition: inline
In-Reply-To: <20240330224623.579457-2-knayak@gitlab.com>


--TaJg66gZSbzeNuDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 11:46:16PM +0100, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The function `create_symref_locked` creates a symref by creating a
> '<symref>.lock' file and then committing the symref lock, which creates
> the final symref.
>=20
> Split this into two individual functions `create_and_commit_symref` and
> `create_symref_locked`. This way we can create the symref lock and
> commit it at different times. This will be used to provide symref
> support in `git-update-ref(1)`.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>=20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a098d14ea0..3f0f9521cb 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1920,26 +1920,39 @@ static void update_symref_reflog(struct files_ref=
_store *refs,
>  	}
>  }
> =20
> -static int create_symref_locked(struct files_ref_store *refs,
> -				struct ref_lock *lock, const char *refname,
> -				const char *target, const char *logmsg)
> +static int create_symref_lock(struct files_ref_store *refs,
> +			      struct ref_lock *lock, const char *refname,
> +			      const char *target)
>  {
> +	if (!fdopen_lock_file(&lock->lk, "w"))
> +		return error("unable to fdopen %s: %s",
> +			     get_lock_file_path(&lock->lk), strerror(errno));
> +
> +	/* no error check; commit_ref will check ferror */
> +	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
> +	return 0;
> +}
> +
> +static int create_and_commit_symref(struct files_ref_store *refs,
> +				    struct ref_lock *lock, const char *refname,
> +				    const char *target, const char *logmsg)
> +{
> +	int ret;
> +
>  	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
>  		update_symref_reflog(refs, lock, refname, target, logmsg);
>  		return 0;
>  	}
> =20
> -	if (!fdopen_lock_file(&lock->lk, "w"))
> -		return error("unable to fdopen %s: %s",
> -			     get_lock_file_path(&lock->lk), strerror(errno));
> +	ret =3D create_symref_lock(refs, lock, refname, target);
> +	if (!ret) {
> +		update_symref_reflog(refs, lock, refname, target, logmsg);

I feel like the resulting code here is a bit hard to read because the
successful path is now nested into the condition. This does not really
conform to our typical coding style. Exiting early in case the function
returns an error would be easier to read.

> -	update_symref_reflog(refs, lock, refname, target, logmsg);
> +		if (commit_ref(lock) < 0)
> +			return error("unable to write symref for %s: %s", refname,
> +				     strerror(errno));
> +	}
> =20
> -	/* no error check; commit_ref will check ferror */
> -	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
> -	if (commit_ref(lock) < 0)
> -		return error("unable to write symref for %s: %s", refname,
> -			     strerror(errno));
>  	return 0;

Also, is it correct to `return 0` here in case `create_symref_lock()`
returns an error? If so it certainly requires an in-code comment to
explain what is going on. If this is a bug I feel like we have
identified a test gap that we might want to plug.

Patrick

>  }
> =20
> @@ -1960,7 +1973,8 @@ static int files_create_symref(struct ref_store *re=
f_store,
>  		return -1;
>  	}
> =20
> -	ret =3D create_symref_locked(refs, lock, refname, target, logmsg);
> +	ret =3D create_and_commit_symref(refs, lock, refname, target, logmsg);
> +
>  	unlock_ref(lock);
>  	return ret;
>  }
> --=20
> 2.43.GIT
>=20

--TaJg66gZSbzeNuDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL9/sACgkQVbJhu7ck
PpRTXA//W8c/Agf1xcrJAbTnveDaHKckCuOV1uzp8RwcJLSTEY8MCvS49h7MWVFr
NnF2wcppUr8Xkpq+3EDFd3219Z9QVqLu80dzXow5MQ05Qz4JDLCoqC4GUBoabjYe
TKYl4g/dUx0jjaaI5/Eml+x/dS/2EVCaB9sX/ZmxYkjdamz++m3h2VhWyP1eQWyB
8zQjcyZ5BYvAR3IpvstRWBcokTfBDAnb6q8IdS+/ZXmZtoyvVSepgwmfOEsAM7G4
iylrIiGcxMgHBdE7m3WATA/PxVD+NxttTSqaVucGOoXbnh+KLd1yxmdZg0r7AuO8
ZclABHBX8+AZ0lJSSMSPDCyyO0qdPr4ghf/J1QTx0IACGK6HJpTzL9kl142cMGzJ
KVNrHCbBO2zGbUxp/KycJYLJsuYYQc+wgRWRSk95pcRXrCD9STCoaWlCrCBba66i
4fJE//6W49c1q3MJ8m9AXytirsGkzIs6lMMiiqadjiLg3mj3QX12sUkM81ukvkv+
lraZO24nzPGrjzNjGh9X6QHtVlp+Ql0E3pYfy77UrR1aU5EJEoSY5wWjPbBZ7CoY
n/O7ZOzA22JhzDmWvgSxhukJSmBdMYeMWPp2rtDb6hSqFl88hLNB7gWjHBeR8f0N
7zNby0EeAO7NzRnuhgLE49OK3ohyBmYgSUfSj/FmcXT0p4Wd39c=
=UYfX
-----END PGP SIGNATURE-----

--TaJg66gZSbzeNuDw--
