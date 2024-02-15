Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D71B7EA
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989585; cv=none; b=LD/AtaDvzSqXrws7OI+HLVHnb2gjnObezLS1+lx2JlKyMx9kxwMGIR9fiRKYTlI7eK+Ule1R1zrdaydN/N5IhPZii5unLFxETFDFwEPkNpqE+wYTjJmyQV/fQYo5q6TfP1kmSiBvZE5Qy1RVvFps3D8W1xWoJgOnxG5UtuwX24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989585; c=relaxed/simple;
	bh=UpZHlrX3cmk1GqwPRorFKeTm5nEN/NCISkplebcq/M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuIKh1/ymU3UotTW4ntYSU2E9tfaAkVaY4Ltk/fom5CGTw+IHLX08sJks1i5zGAvmU13ohB4fIXsTkJJKp55tCGkXO4HASOw8RIY0hLf8LwF4tHjaT15X+AX7hjm72WNLmkfsWB3PEGgsFO13L+eDqg7bWnfTZGQaqVRnMAygFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iN+wJAl3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y45Ra+aG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iN+wJAl3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y45Ra+aG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 52DBB11400AA;
	Thu, 15 Feb 2024 04:33:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 04:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989582; x=1708075982; bh=9RCBQLjwDk
	4Hs6MoCcZDRVxqfGvoh3GUjgYypjkwR94=; b=iN+wJAl3xSbnzWLWycb3krdWI2
	oM3s8oTTN1Igc2XcC3QRiRenTdb/Of+NZuAaViQyoniVqF9MiPXfDyoxjKC9htHu
	cKCimNX9zu2FaNLH9M1CT69OqZyBl103weoJpP3LWpb1Q4uHJgWWT+5K1Ay2ysQU
	IcF0b3+CSGXn2T+53VIci4/dOJV1CWbz3J0Fnrleq2VvLofvX/3+QMIv1D1AN8gv
	WbaYRM0sPl1Om+24IiRk+wGgPWQfZNx0/9FkGub/FS3GHMyms0b5/fISiwHscqws
	3u5wEB3lqAM4AxcNuGr+yoxbw0XyHBulivhLOFBF4etYv7q+/301ohs78OlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989582; x=1708075982; bh=9RCBQLjwDk4Hs6MoCcZDRVxqfGvo
	h3GUjgYypjkwR94=; b=Y45Ra+aGOOI6B7W35Lo3bbhnl+WsWJoxvem5Ps8OsM6H
	4tZkyde0npkmoqov1TdPjnpUtNn1kM3ozS5xZPp72Gc2EBfKVqR62DJsQxXQimjK
	QoDOzEoOsK4xflFy12XysEhMRysaSbpDDNQ8ZBZVOHqP0S95JOHp+0b5gUtcTyT1
	SfU/LNMDy+hR/2ajyyl8lz3MBiNxbEXuZYulyXuBFObkx/VrawUguHJzH6c3wRB6
	MhP22hXqhVO9NL+09t/ulwxa2wGm14bsDbtLiBkGeA0F4BNrjjkp5bkcUDl42sE7
	WmKrhR5eE8/tTXiGQ+Cm0jXiabPWgfKbYS6G10NpaQ==
X-ME-Sender: <xms:TtrNZaM40vLLFsnXVNRiLhIbvcfmFR3rO3rAF85aI9jnYrwqALnRpA>
    <xme:TtrNZY-rnhovCwe-OeDBi8hw70EQxhx6LsK1oq9cMFbNKFyKitqj0yySsU4bc6fWn
    UV0DOF1aczK18rbDQ>
X-ME-Received: <xmr:TtrNZRTe5QTuONbgCLrAaus2pwwk3d9FUYSyL4jGVEZKlNRPt5mrWPH3TkWhZ5aQX2a2KcRjgTyvnqv9uJS4mk2IEKZEY3Y7j7NiCHuBifuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:TtrNZavyuPK4pQp_jvO8zk4PhlNx8WUwTX9jbyfm8M2JWVmBnwVHJw>
    <xmx:TtrNZSe5rL5t84G0RcqBb5MjaxbrCYHy2jDz1t5nJxgsxznNBWjTug>
    <xmx:TtrNZe17vmAdfEiQI0A5243bfmY6T5Uenf787AjsuXGRzRr6h3m1EA>
    <xmx:TtrNZS6Sb8lPi0GwTHlNWxzbcG8Fv_EuNvk4WT6FOFTLZv9dl4xL6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:33:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a05bdd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:29:09 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 09/12] fsmonitor: refactor non-directory callback
Message-ID: <Zc3aS0Top36mf4wi@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <a0cc4c8274c108d231816ac981781d9e3cf8fded.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5c8pax8XSzZMNByM"
Content-Disposition: inline
In-Reply-To: <a0cc4c8274c108d231816ac981781d9e3cf8fded.1707857541.git.gitgitgadget@gmail.com>


--5c8pax8XSzZMNByM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:18PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Refactor the fsmonitor_refresh_callback_unqualified() code
> to try to use the _callback_slash() code and avoid having
> a custom filter in the child cache-entry scanner.
>=20
> On platforms that DO NOT annotate FS events with a trailing
> slash, if we fail to find an exact match for the pathname
> in the index, we do not know if the pathname represents a
> directory or simply an untracked file.  Pretend that the pathname
> is a directory and try again before assuming it is an untracked
> file.
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 59 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 24 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 73e6ac82af7..cb27bae8aa8 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -287,41 +287,52 @@ static int my_callback_dir_name_hash(
>  	return nr_in_cone;
>  }
> =20
> -static void fsmonitor_refresh_callback_unqualified(
> +/*
> + * The daemon sent an observed pathname without a trailing slash.
> + * (This is the normal case.)  We do not know if it is a tracked or
> + * untracked file, a sparse-directory, or a populated directory (on a
> + * platform such as Windows where FSEvents are not qualified).
> + *
> + * The pathname contains the observed case reported by the FS. We
> + * do not know it is case-correct or -incorrect.
> + *
> + * Assume it is case-correct and try an exact match.
> + *
> + * Return the number of cache-entries that we invalidated.
> + */
> +static int fsmonitor_refresh_callback_unqualified(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {
> -	int i;
> -
>  	my_invalidate_untracked_cache(istate, name, len);
> =20
>  	if (pos >=3D 0) {
>  		/*
> -		 * We have an exact match for this path and can just
> -		 * invalidate it.
> +		 * An exact match on a tracked file. We assume that we
> +		 * do not need to scan forward for a sparse-directory
> +		 * cache-entry with the same pathname, nor for a cone
> +		 * at that directory. (That is, assume no D/F conflicts.)
>  		 */
>  		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		return 1;
>  	} else {
> +		int nr_in_cone;
> +		struct strbuf work_path =3D STRBUF_INIT;
> +
>  		/*
> -		 * The path is not a tracked file -or- it is a
> -		 * directory event on a platform that cannot
> -		 * distinguish between file and directory events in
> -		 * the event handler, such as Windows.
> -		 *
> -		 * Scan as if it is a directory and invalidate the
> -		 * cone under it.  (But remember to ignore items
> -		 * between "name" and "name/", such as "name-" and
> -		 * "name.".
> +		 * The negative "pos" gives us the suggested insertion
> +		 * point for the pathname (without the trailing slash).
> +		 * We need to see if there is a directory with that
> +		 * prefix, but there can be lots of pathnames between
> +		 * "foo" and "foo/" like "foo-" or "foo-bar", so we
> +		 * don't want to do our own scan.
>  		 */
> -		pos =3D -pos - 1;
> -
> -		for (i =3D pos; i < istate->cache_nr; i++) {
> -			if (!starts_with(istate->cache[i]->name, name))
> -				break;
> -			if ((unsigned char)istate->cache[i]->name[len] > '/')
> -				break;
> -			if (istate->cache[i]->name[len] =3D=3D '/')
> -				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> -		}
> +		strbuf_add(&work_path, name, len);
> +		strbuf_addch(&work_path, '/');
> +		pos =3D index_name_pos(istate, work_path.buf, work_path.len);
> +		nr_in_cone =3D fsmonitor_refresh_callback_slash(
> +			istate, work_path.buf, work_path.len, pos);
> +		strbuf_release(&work_path);
> +		return nr_in_cone;

I didn't spot any users of this return value, and Junio also mentioned
this in a preceding patch for a different function. Would it make sense
to introduce this return value as-needed in a later patch so that the
reader isn't left wondering why it's changed now?

Patrick

>  	}
>  }
> =20
> --=20
> gitgitgadget
>=20
>=20

--5c8pax8XSzZMNByM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2koACgkQVbJhu7ck
PpR5GQ/9HxGY6bkICrwlZ0PF0MvuupgkYznBfhPzBte4Zahxg5/CNqK5gT1HoboQ
h8XawIZGWfXcxIW8Amjwn6kQ/vANHYz+7vQ2/CsRrlJEYXB+U2Avkkofyu2MGt6F
ksMnS5pmvlG72aorlfceGlLRgJNs1J9y4zYcJSc10+YvM7eSMO/iAEQV49ULSGat
FzXCka3W2oVyxMEXjgAsqtw0sKFchGWItMODccEG3tvwScNgDfiFU70iUJUIzDxA
+L8NM3s5/EapTpPuvZHizhkR1V5T5X8w+wjgmu9Yi+RINelmUYeddcZonwpiA8uh
4I6aVbvTouHHdtz6+pzifWS7Im2ydpwf4Obh21jJoY+GP7Cguv4GUUTt8JR/Aiiz
ozPCf9BHhMnu4yOS+wwrq2IdyKFYZxmJ+F7oQZ6kcpnC5p6MSsY11BjXsmdNeDeg
5AKNtwVaitKdPHv6ypiPAacwQ0ZJntbmW1WCrAbaHQg+eAd6QTOn2rAcolr8HhJO
YEP1ljglU7mSdBUdpAufh8DPUmS8dx3aWZrLzgjPVJc51GeJNERiSj2kvezNlEoD
w+dLYJHLlNyA2tYA/thod/BgrG38YN0ByjnA1ST7JJnyh9rgQJYshFG26aIGYtag
FFbepvXMWVCDaAsh54BNIvttAfuuMO2KhnOMQY+cr+pyMv8cs90=
=yIWp
-----END PGP SIGNATURE-----

--5c8pax8XSzZMNByM--
