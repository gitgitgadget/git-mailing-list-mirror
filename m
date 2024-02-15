Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DD1BC3C
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989569; cv=none; b=bcJ8/U1Mkk3yfWqYBF1IqjPDf9Ted2+CWv2ksNIT6nDzrYtvfHxgai7oZ3h7PTUF8+sU2taRUdoJfxcuWEcmmOXmZwlkq8B8pLmsbu+kRLHe1EiB5Ql6zIamsmFMWYZVtdf96OIIp7ihT5D6lRf4o5zWKuOlDMIpdUalGsnQaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989569; c=relaxed/simple;
	bh=VS+YRNR8G+iSK5scxHPYctWYQdA7UZmOrhQk2aiNXAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCxR8lIljqHhK5o27X76ZoKOBVV+oLqhFL8N3KzXL67nCvMMSq0kSI2HHpytxWyxWGSq4LcFsMNDPmNRJE1U5Qmfqw/QOTpajIxyKJ1F045TsZsSXubEkrffgvDEOwJ8SJsdUf5OOX1AKNonbpDupATtB0Oy7gcmp6wFE4qVuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJTd/7iV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFIXul3b; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJTd/7iV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFIXul3b"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 4F4055C0099;
	Thu, 15 Feb 2024 04:32:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 04:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989566; x=1708075966; bh=cmeVBixhdS
	9uZdETyu86Yc7y+foAXCMvHoc6ie3tSQI=; b=cJTd/7iVgL/uHNbfMLK7QGojBY
	cy6ddSsgUC442mtlsUWLi6VkaO695XI6e4wJ5mQOfIucxsE0iSZ8BAPCw4MAuony
	zTuu1Hwo0QwOKNEfnzFRDbhuBgzuYDZneD+l+Y7BCl95tv8b6dAl19KwOeiFe87Y
	QtK2e5VjvbDTQkrtTGUXb+4/NioYyt1l0Y6/u9gqZ7DGITc8iZQyLnxQyUEBWlig
	WBfataHfGGuYThYsFO/JhsmMPMdU+q3v0N7WyUVvtjbqK+1FwBfWUvExjT1nwPzC
	5VegVzbCb7QEfI2Poiib+1rjCXMzF8Z9YDeXPZE4XgC6GQdlT/fdBQRHuxqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989566; x=1708075966; bh=cmeVBixhdS9uZdETyu86Yc7y+foA
	XCMvHoc6ie3tSQI=; b=SFIXul3bPH1olrxCgogOuxEhdoiJ6qgsr+ahGTAIFzdT
	y9BlN0EKKCJDvNOHciDR1Wo+sCuGbMrzSKdr/qDj4uqI9t0ToQDXFY+YD7TgFUJh
	3ga/glAc5G/txRklgpaK3Spt+Q7YyFKVHcqAZYqnh4iM6Cd/5EhfIm4zTbpjHFfK
	TtGOUzqw/xdw8g7XaPL7RufpzYU6smSPRZYUMPOJZwalKAMIcvp+cNbslPple5sP
	4YLxBkGMtOB52UmzqCji+Siy3GjAUaJKYlYBtQAU1LmsXHMR1Q5eIXd/YPJ7eInc
	a7GMDlTEhmGDgelzweSACgG83C8cTZ09ptIx3QaDuQ==
X-ME-Sender: <xms:PtrNZaZKhIacpSYpH1Ob9PGRECLDk3tK6PYVDAwQRqqembFrx1aaoQ>
    <xme:PtrNZdYIYy5V8LH_mIgadBix1VsXj7DjViJXvKNrnGNbAsdhQ8NwbC6_eLccjxVTt
    nQaD7bGLLCBYqNNQw>
X-ME-Received: <xmr:PtrNZU9fw2odfeHQjSGWkbWLtsG3OGQlUhowC6Xn0XfbM62RphkHdjvA7y9O4TrfBu-ETeTFWGJcDvVA5UUUkaa1Shb5Uj8yKnMolDZfe0JL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:PtrNZcr6h6Dwh5QC7XKjs-Kngo1hJj8X8a7eWie0s-msUo2C_ubE6Q>
    <xmx:PtrNZVoIsx-5DSeMRJFDrH8CpPexuHLxUgJXV56Cmepuy1XQ8S0zog>
    <xmx:PtrNZaQGmpgRtiXOn25usgvKfXO0KFnmZyxaI9jNSBF8ZMFJ3wy_Kw>
    <xmx:PtrNZc0GESDfksmyAxAPrxjmOlzGXaYM8AOQMi21AJKG8GixrQFvYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:32:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1722c28e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:28:53 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 08/12] fsmonitor: support case-insensitive directory
 events
Message-ID: <Zc3aO95bvuXXENLj@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <e0029a2aad68a60f672e74368a384f68a343e21c.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nKi5+5xSRMA3qPnG"
Content-Disposition: inline
In-Reply-To: <e0029a2aad68a60f672e74368a384f68a343e21c.1707857541.git.gitgitgadget@gmail.com>


--nKi5+5xSRMA3qPnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:17PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Teach fsmonitor_refresh_callback() to handle case-insensitive
> lookups if case-sensitive lookups fail on case-insensitive systems.
> This can cause 'git status' to report stale status for files if there
> are case issues/errors in the worktree.
>=20
> The FSMonitor daemon sends FSEvents using the observed spelling
> of each pathname.  On case-insensitive file systems this may be
> different than the expected case spelling.
>=20
> The existing code uses index_name_pos() to find the cache-entry for
> the pathname in the FSEvent and clear the CE_FSMONITOR_VALID bit so
> that the worktree scan/index refresh will revisit and revalidate the
> path.
>=20
> On a case-insensitive file system, the exact match lookup may fail
> to find the associated cache-entry. This causes status to think that
> the cached CE flags are correct and skip over the file.
>=20
> Update the handling of directory-style FSEvents (ones containing a
> path with a trailing slash) to optionally use the name-hash if the
> case-correct search does not find a match.
>=20
> (The FSMonitor daemon can send directory FSEvents if the OS provides
> that information.)
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 120 insertions(+), 2 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 14585b6c516..73e6ac82af7 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -5,6 +5,7 @@
>  #include "ewah/ewok.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-ipc.h"
> +#include "name-hash.h"
>  #include "run-command.h"
>  #include "strbuf.h"
>  #include "trace2.h"
> @@ -183,6 +184,9 @@ static int query_fsmonitor_hook(struct repository *r,
>  	return result;
>  }
> =20
> +static int fsmonitor_refresh_callback_slash(
> +	struct index_state *istate, const char *name, int len, int pos);
> +
>  /*
>   * Invalidate the untracked cache for the given pathname.  Copy the
>   * buffer to a proper null-terminated string (since the untracked
> @@ -205,6 +209,84 @@ static void my_invalidate_untracked_cache(
>  	strbuf_release(&work_path);
>  }
> =20
> +/*
> + * Use the name-hash to lookup the pathname.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */

The function not only looks up the path name, but also invalidates the
corresponding cache entry. You imply this with the second sentence, but
this could be a bit more explicit.

> +static int my_callback_name_hash(
> +	struct index_state *istate, const char *name, int len)

I find the naming conventions here to be weird with the `my_` prefix.

> +{
> +	struct cache_entry *ce =3D NULL;
> +
> +	ce =3D index_file_exists(istate, name, len, 1);
> +	if (!ce)
> +		return 0;

Okay, `index_file_exists()` is called with `icase =3D=3D 1` here. But is
that the correct thing to do on case-sensitive platforms? I would have
expected us to honor `core.ignoreCase` here.

Turns out, we only end up calling this function when `ignore_case` is
set, so we already do. I think this can be clarified both by giving the
function a better name and by documenting this in the comment. Also,
neither of this or the next function really are callbacks -- they only
happen to be called by a callback function.

I'd think something like `lookup_and_invalidate_path_icase()` and
`lookup_and_invalidate_dir_icase()` could help to clarify intent.

> +	/*
> +	 * The index contains a case-insensitive match for the pathname.
> +	 * This could either be a regular file or a sparse-index directory.
> +	 *
> +	 * We should not have seen FSEvents for a sparse-index directory,
> +	 * but we handle it just in case.
> +	 *
> +	 * Either way, we know that there are not any cache-entries for
> +	 * children inside the cone of the directory, so we don't need to
> +	 * do the usual scan.
> +	 */
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback map '%s' '%s'",
> +			 name, ce->name);
> +
> +	my_invalidate_untracked_cache(istate, ce->name, ce->ce_namelen);
> +
> +	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +	return 1;
> +}
> +
> +/*
> + * Use the directory name-hash to find the correct-case spelling
> + * of the directory.  Use the canonical spelling to invalidate all
> + * of the cache-entries within the matching cone.
> + *
> + * The pathname MUST NOT have a trailing slash.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static int my_callback_dir_name_hash(
> +	struct index_state *istate, const char *name, int len)
> +{
> +	struct strbuf canonical_path =3D STRBUF_INIT;
> +	int pos;
> +	int nr_in_cone;
> +
> +	if (!index_dir_exists2(istate, name, len, &canonical_path))
> +		return 0; /* name is untracked */
> +	if (!memcmp(name, canonical_path.buf, len)) {
> +		strbuf_release(&canonical_path);
> +		return 0; /* should not happen */
> +	}

So in other words, this function should only be called when we know that
casing differs, and thus the passed-in name and the canonical name
should never be the same? If this case shouldn't ever happen, shouldn't
we report this as an error or use `BUG()` instead of silently ignoring
this mismatch of expectations?

Patrick

> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback map '%s' '%s'",
> +			 name, canonical_path.buf);
> +
> +	/*
> +	 * The directory name-hash only tells us the corrected
> +	 * spelling of the prefix.  We have to use this canonical
> +	 * path to do a lookup in the cache-entry array so that we
> +	 * we repeat the original search using the case-corrected
> +	 * spelling.
> +	 */
> +	strbuf_addch(&canonical_path, '/');
> +	pos =3D index_name_pos(istate, canonical_path.buf,
> +			     canonical_path.len);
> +	nr_in_cone =3D fsmonitor_refresh_callback_slash(
> +		istate, canonical_path.buf, canonical_path.len, pos);
> +	strbuf_release(&canonical_path);
> +	return nr_in_cone;
> +}
> +
>  static void fsmonitor_refresh_callback_unqualified(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {
> @@ -269,7 +351,10 @@ static void fsmonitor_refresh_callback_unqualified(
>   *
>   * Return the number of cache-entries that we invalidated.  We will
>   * use this later to determine if we need to attempt a second
> - * case-insensitive search.
> + * case-insensitive search.  That is, if a observed-case search yields
> + * any results, we assume the prefix is case-correct.  If there are
> + * no matches, we still don't know if the observed path is simply
> + * untracked or case-incorrect.
>   */
>  static int fsmonitor_refresh_callback_slash(
>  	struct index_state *istate, const char *name, int len, int pos)
> @@ -293,17 +378,50 @@ static int fsmonitor_refresh_callback_slash(
>  	return nr_in_cone;
>  }
> =20
> +/*
> + * On a case-insensitive FS, use the name-hash and directory name-hash
> + * to map the case of the observed path to the canonical case expected
> + * by the index.
> + *
> + * The given pathname includes the trailing slash.
> + *
> + * Return the number of cache-entries that we invalidated.
> + */
> +static int fsmonitor_refresh_callback_slash_icase(
> +	struct index_state *istate, const char *name, int len)
> +{
> +	int nr_in_cone;
> +
> +	/*
> +	 * Look for a case-incorrect sparse-index directory.
> +	 */
> +	nr_in_cone =3D my_callback_name_hash(istate, name, len);
> +	if (nr_in_cone)
> +		return nr_in_cone;
> +
> +	/*
> +	 * (len-1) because we do not include the trailing slash in the
> +	 * pathname.
> +	 */
> +	nr_in_cone =3D my_callback_dir_name_hash(istate, name, len-1);
> +	return nr_in_cone;
> +}
> +
>  static void fsmonitor_refresh_callback(struct index_state *istate, char =
*name)
>  {
>  	int len =3D strlen(name);
>  	int pos =3D index_name_pos(istate, name, len);
> +	int nr_in_cone;
> +
> =20
>  	trace_printf_key(&trace_fsmonitor,
>  			 "fsmonitor_refresh_callback '%s' (pos %d)",
>  			 name, pos);
> =20
>  	if (name[len - 1] =3D=3D '/') {
> -		fsmonitor_refresh_callback_slash(istate, name, len, pos);
> +		nr_in_cone =3D fsmonitor_refresh_callback_slash(istate, name, len, pos=
);
> +		if (ignore_case && !nr_in_cone)
> +			fsmonitor_refresh_callback_slash_icase(istate, name, len);
>  	} else {
>  		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
>  	}
> --=20
> gitgitgadget
>=20
>=20

--nKi5+5xSRMA3qPnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2joACgkQVbJhu7ck
PpQDBA/9G//87Q0J7mcfgVyZARrlcAsaBbv/jN6lNo1fXEK02hFfZs2RU7NM0wWP
nHWRfmu/YwAJmZ29VvQLpvyBLf7cZSWI6xtHeVV6RVPo1bFsZT9GRzfmOQ9vKCN4
EXnQkyWdnrnk4g6SopRy0s+hY+9+8AHz8vyzz4BNYO1p9rF7yX/pIWk0eQurUV99
ZsZuo14OHLhfcnsyY7lPa9wPKMZwt21Lo9vxzdwu9P01Mpw+3O+iKscFr/QpV4hp
ojYd8WqTYFM873XjfQxW2STi5q2mfH7JY/TxZ7vvbZnYQrNCRYEX2/PGTVzMwx88
PbuWjr//OGkgRryfLrW14J6oq4msyLEKjwbyjNuQSxiF6xdjasezk5lvoINPgeY0
qCcXX6pTJdeE3MSLhQIB6nFYt41pCdliaEPN7sgVXj8YuSwJHgZw5ppdaqqTfqwr
e8bWK5Ox0YHP9xTnAnNapUwkP/zFoSbjt0WqB8JfdWYYw6VgmHgDEJ5euHxMkIeL
rM3y5wcoUCo6yKAUkwnONmyHVUcsWUEPUiKqE3s+nb+mgYS4dMM9mkhCRmcaSVKa
570sAiK7xxwKDWMYXzzaQ1kUxQjZOW+rFGoqAwZBSg6SnWJLFoDvgP59dcqHlv+T
pvMcqO/LQU/VPzWRFi6lBM2oC9JTjCWsM7uruM/gtrM+ttwiufg=
=M876
-----END PGP SIGNATURE-----

--nKi5+5xSRMA3qPnG--
