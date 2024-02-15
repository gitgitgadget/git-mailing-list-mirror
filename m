Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DC1798C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989576; cv=none; b=eB15/GQI75JPm08XUzvdnmqscFrmHKPTLCBgUs/8J4L3geF20tZCobWgmrStjA1opGHn2wpSDPZQXVHXsMZ6dtSWn2KPwUJnfP4YecQG9opCHl+BL5NjSY7tFdGG0wrz5V3LqdkKaN4JXEyxwDVlc+4weV2vmCkKTNmszcAHWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989576; c=relaxed/simple;
	bh=lzzK396y4yjRTLBpJtQvnx58liBbRydKWQjO3fFLzEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCy5m+x8LnqKe3Jc0Qn3He5P9wIbKjeXegLh7VYPBpqNVCo9tFw8LRM4JzqmcTDCJVNSmpYH0H+71QDRpF8H/HL1bASA/6o1GUQPmH1TEDjgC50upjsmrU3EyS5PXooa6HxkfNDnDNgvAPibYDbxpFIFGFT2ZMlOw6OqWsRmh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eagiglCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEc8d8NU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eagiglCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEc8d8NU"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4E67311400AA;
	Thu, 15 Feb 2024 04:32:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 04:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989574; x=1708075974; bh=Tdxwly+Apo
	v+N4ennORATWMlzz1EzaAbORbA1dcAyvY=; b=eagiglCSvgQyq2Txf3CIvfam0y
	NcfwTZPbG1C991KR7LA7T4HjfChXjJh68MWauTFksdkJzackkb3r5KE27swE1CcY
	KPNEmqYodRLNNMDGCmswRUASU8vFqzoQUuKNBohYLaKb6rrgWM/ZWPzA2mmNT09S
	fyfWVVh+dMMJPWSBHDVacGtJwVkg15scG+vLUuEx0Xfhy5U6hyX5SNjR4fMQqEjR
	+lpVMKLTzjygaBIQS0LypYAfggDNgNFzXsOabjEZGCKdp6RVxx8je0c1wXZFZ1ks
	+rgf9v4wU1ruP/iLVTZHpoAGzSqV5jUE9bH1lN/kJLaHIWEfpG2Hs3IGUgeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989574; x=1708075974; bh=Tdxwly+Apov+N4ennORATWMlzz1E
	zaAbORbA1dcAyvY=; b=GEc8d8NUTcnCVxDGBKM/FsAZ4+Pf+u2Zmm85VIAQdPe2
	0E8i4bOJu48+WgYr1UN97ld7driFDmfWmChB2xV6Hs2n45XsmEhuaRwcso7K+Riv
	YGc9ISVTM50647am3cnHbo4c4GMXkbRqYh+sbWq0//nJtElCcEHnlgmf2LBPY8Ud
	4UfUn7sXwlguHLRckecBlkPartWyXo8RzTvfS7c69A5tVa4EH2ztB9sfuPRvw3MQ
	4VoNQWMdBYhCSeDoNK8OSezUkpzXCzZplY9323yeZ+e7UbT/eeW9rtvDzcaxpYml
	r0y0knIZmDEyj65w65e0NyIuKSGqUOCwcEUR3+I62A==
X-ME-Sender: <xms:RtrNZVURg5H3cbo4XiH_LM7EXKQKp_nTelnF-Drh_eB7M7AFadPIKA>
    <xme:RtrNZVnbsq49UIV_rQwKEfmEw6Gpi0dYiNXJbTAuFoV-9DYwm0fIH84UVHec1A6qW
    S1MNoUID4Jb0t8XyQ>
X-ME-Received: <xmr:RtrNZRazpW4xJEBzn68wpVg3nJpdUxmOIoByQy0z7RiZLzA12k2KJ0oH3pOC3LQRqAZHzfJ_QpdW2JS0PfG1ik7JmWCV5tBrVInC_YW7MLOC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:RtrNZYVwnmxwVc1WFv3OGSxDMK3K_79ILOihqQ0FKYb0W5Lm1YkMUg>
    <xmx:RtrNZfkqbeWAQmdgRu80tU-gCfZiRm_RwCv8yJvYJdEIWArf_TmajA>
    <xmx:RtrNZVeeidBHwMjg6-MEZ3VYoJ01A3rJe2PRY5xgCpDpZaMpwzhEdw>
    <xmx:RtrNZdjXUCzsi3accdUf33f21ySR-v81wdIZjM_vQwmVkSNA6pJv2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:32:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3358f7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:29:01 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 11/12] fsmonitor: refactor bit invalidation in refresh
 callback
Message-ID: <Zc3aQ2qoK15w9dkp@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <7775de735f41bdc601318cd15c3414f12b361a0c.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+pIvqn+89pnjiSg"
Content-Disposition: inline
In-Reply-To: <7775de735f41bdc601318cd15c3414f12b361a0c.1707857541.git.gitgitgadget@gmail.com>


--P+pIvqn+89pnjiSg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:20PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Refactor code in the fsmonitor_refresh_callback() call chain dealing
> with invalidating the CE_FSMONITOR_VALID bit and add a trace message.
>=20
> During the refresh, we clear the CE_FSMONITOR_VALID bit in response to
> data from the FSMonitor daemon (so that a later phase will lstat() and
> verify the true state of the file).
>=20
> Create a new function to clear the bit and add some unique tracing for
> it to help debug edge cases.
>=20
> This is similar to the existing `mark_fsmonitor_invalid()` function,
> but we don't need the extra stuff that it does.
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index a7847f07a40..75c7f73f68d 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -209,6 +209,20 @@ static void my_invalidate_untracked_cache(
>  	strbuf_release(&work_path);
>  }
> =20
> +/*
> + * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_inval=
id()
> + * but we've already handled the untracked-cache and I want a different
> + * trace message.
> + */
> +static void my_invalidate_ce_fsm(struct cache_entry *ce)
> +{
> +	if (ce->ce_flags & CE_FSMONITOR_VALID)
> +		trace_printf_key(&trace_fsmonitor,
> +				 "fsmonitor_refresh_cb_invalidate '%s'",
> +				 ce->name);
> +	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +}

Same comment here regarding the `my_` prefix.

Patrick

> +
>  /*
>   * Use the name-hash to lookup the pathname.
>   *
> @@ -240,7 +254,7 @@ static int my_callback_name_hash(
> =20
>  	my_invalidate_untracked_cache(istate, ce->name, ce->ce_namelen);
> =20
> -	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +	my_invalidate_ce_fsm(ce);
>  	return 1;
>  }
> =20
> @@ -312,7 +326,7 @@ static int fsmonitor_refresh_callback_unqualified(
>  		 * cache-entry with the same pathname, nor for a cone
>  		 * at that directory. (That is, assume no D/F conflicts.)
>  		 */
> -		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		my_invalidate_ce_fsm(istate->cache[pos]);
>  		return 1;
>  	} else {
>  		int nr_in_cone;
> @@ -412,7 +426,7 @@ static int fsmonitor_refresh_callback_slash(
>  	for (i =3D pos; i < istate->cache_nr; i++) {
>  		if (!starts_with(istate->cache[i]->name, name))
>  			break;
> -		istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		my_invalidate_ce_fsm(istate->cache[i]);
>  		nr_in_cone++;
>  	}
> =20
> --=20
> gitgitgadget
>=20
>=20

--P+pIvqn+89pnjiSg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2kIACgkQVbJhu7ck
PpQQRRAArFc7s2Ywbx0I6vRvIMRmsXgG/Usf2RKOGE0nKBXZPUkKTsD9eXVEBIGO
1eHhWu7sGovPVlN/vf5rec4H7+rzRhM07iOWrv/nW1cO4E9SDNKkBLiJEyMg6e2O
Fa1y78GZUotS7XF7blOf2A6OuGzAGUAd+iRFVPfM2sz3+VyFmxZlVoqW4XISIrqe
FZ7RIaUUFF//jkGyae9eWIiMG91JzvYOXJAiHPcK4ER79tKrFRrimPBaa6Reo0ue
VSH5qIyLq1xC+nRSEVadXHW16KKzftVX22V/0fXHRRmHYRy8DIDzUdVg2yG2o+61
PPsaFLf00Rz9SDZOcd6sBlyLha8zBBT8Zgv+7xxZUdoclhH3pqOolVs2r2Xg+N3n
62e2b5Hi2g/p841oQG7gA3cfEB6CEWrB4lmQ7NYjf9UoxM8+VuWrhPiYKkiwIogu
lNG5V+t1wCPZeSAUVkwoN+dlSgcHpqK7ZWha/w3GR2GKK0CQWGWoYzdblEEhkwkl
yQjIjNPx+uaHJU9VyGl1FFb0/RUdqx0WIcTPsxUbdkHzo3yOxyEhQROFZv9zv8RC
1FiTqxw+pPg4MqeVTDWbh07hwZ00I81R1bHzGzVba6OCAbZMKe7cXL1zFEiKl61Y
EgewJtZviiPMiNxzGvyKksg6jEwHldAcNDbxhyidlhGpjV/eb6g=
=RBb0
-----END PGP SIGNATURE-----

--P+pIvqn+89pnjiSg--
