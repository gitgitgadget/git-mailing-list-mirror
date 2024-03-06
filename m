Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078F3E48E
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729941; cv=none; b=F2Pr/4sGM1Z7sb+Bf/gz08l47MI1Q6yXxS2iMW3pUAeNyMB492pDiMdD7XKWQnhgowytlEmemwmuX0mjJqCHJaYDTdvE0wEtu+V8US028ev5uBL45rit0UkK7B5BdN+0yxPlK12aSgCPy6qlsnWfmoUw5L2G8iDj/kDH7wzpsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729941; c=relaxed/simple;
	bh=AYIOvDTdb6r/NGMzFntdEf00Q0Z/2hxUpaBs4yV8ZTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAgMnt8bf+yCtsQoRcAkC2AsWwmJU6dUxvByPY4TdO1lbkInuABENXEc0dRn86XY/nCkGMrHkfwBvbi3wiRug5IS5riioC28LI18SaI54eQ9oyEc5TJkQWVrRSkc+C9Z16jf/y4X9ru4NaiIcycDUsIKqrgXTixpRDLjtChYYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R3bJpR4E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f9mf9B93; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R3bJpR4E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9mf9B93"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6E4271800072;
	Wed,  6 Mar 2024 07:58:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 07:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709729937; x=1709816337; bh=l4zEZ1F2Fh
	FYgTAlo8zsC9q/El4nY2r5bkBnnWzaJX8=; b=R3bJpR4EFJsg9E5JTbFiEjtvmb
	BTqwJ1BLSoJruTm2hL9g5bNaI5lqNchpwWUMU/GChDuqgKjB5Az49oAk82fpT/6Y
	9Hs0P0gJkZ3+V8758n96d0xCvM32HXbmyuNoskK7nFQo3T+/iidYTaqFbLgxd3JJ
	BJdeSeSbht0owJr7gzEIbbFfc4eyszOvxc3yjdlh2SIGR3yLJom7R+wltUhZndCo
	tCuCovqukP+GsVvrgchKO4R6r/UHSCtkm7MPgXvJf94r57FdSQzFL/R6ZNBfJcgF
	9NPS1e92U+95/0jc4rllomDevSzkdJ4pOFAijlJJD1rDNm0GSmjE0I9umcTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709729937; x=1709816337; bh=l4zEZ1F2FhFYgTAlo8zsC9q/El4n
	Y2r5bkBnnWzaJX8=; b=f9mf9B931bq8bMSIWk4FGmXqanlGIN9OZSZiRnE6LR9s
	XXhCYRKGGKjosrBic1u+cDAGHkyu71KlMP+jizy8oms6yJYjGd/gzhHY1q5H2IP6
	YTjdtjZ5PY06mvyuDSdkPZ9C5zkuZNKNHXolAtGZXE/oKPoWoqYkTp5ckYQWvuIX
	nRagwcAsBxtPYC5kQkkk4xpDnUgKs62aN9dinZS+QTJN0oA3ymtGNc3Tev9ioRcs
	k4yvOmgd8ntgGEXuNZecsTnywE/keQTi2dNVb8FR2rQXEJe8eJK2W6PF5uM6PylZ
	gBypmyy21ch1X/PlPpYWXUcbbsO3ep6ACxJSvqE9cQ==
X-ME-Sender: <xms:kWjoZcRrSRVyU_IRkdC5Fmojs2RQSFfaFJ-rahNF4pmKHRdZx7iCaQ>
    <xme:kWjoZZwWu5_CKGMudZuXLK4DezfyMjikdDAqiuzF877wl9qTCVEpgOFkTQKWar7xA
    _xeuwOeMyQOPRVpgQ>
X-ME-Received: <xmr:kWjoZZ0gKTDv4SvCMp-fftmgEK7bV08XIi0VB0w14AyliaXO53C9ORGLw5U7M9DKQ59g0Mg4x6hAg-3-3eBczZEIPmYnCGWKrBgGCcCr1XEqFyHG-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kWjoZQBdb_CMANDn92J6ZkyWUZVKDgItzSS5W_P0elw_HPunHBi1hw>
    <xmx:kWjoZVhdPGXg-2irQM1h8zgyF64VTkgAdve4FGSBiwjHZs7AMeTZ8Q>
    <xmx:kWjoZcpqlzQe6eG_r9hTbhqRUPpjAOVAk7o0_EmrLfX3_ohLlQRCNg>
    <xmx:kWjoZTY-eNKJRfR3UwOmxw_BuCYHiZ0dAB5KrUwOfIQomIevTgJq4zChWsQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 07:58:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4d2e91e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 12:54:26 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:58:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v3 14/14] fsmonitor: support case-insensitive events
Message-ID: <ZehojvoI1UOJmcD3@tanuki>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
 <ec036c04d1b003385683f0ed1dec80cc3bbfb813.1708983566.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S76VTrDTYwWxV1YV"
Content-Disposition: inline
In-Reply-To: <ec036c04d1b003385683f0ed1dec80cc3bbfb813.1708983566.git.gitgitgadget@gmail.com>


--S76VTrDTYwWxV1YV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:39:25PM +0000, Jeff Hostetler via GitGitGadget w=
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
> Update event handling to optionally use the name-hash and dir-name-hash
> if necessary.
>=20
> Also update t7527 to convert the "test_expect_failure" to "_success"
> now that we have fixed the bug.
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c                  | 121 +++++++++++++++++++++++++++++++++++
>  t/t7527-builtin-fsmonitor.sh |  26 +++++---
>  2 files changed, 137 insertions(+), 10 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 3c87449be87..2b17d60bbbe 100644
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
> @@ -202,6 +203,113 @@ static void invalidate_ce_fsm(struct cache_entry *c=
e)
>  static size_t handle_path_with_trailing_slash(
>  	struct index_state *istate, const char *name, int pos);
> =20
> +/*
> + * Use the name-hash to do a case-insensitive cache-entry lookup with
> + * the pathname and invalidate the cache-entry.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static size_t handle_using_name_hash_icase(
> +	struct index_state *istate, const char *name)
> +{
> +	struct cache_entry *ce =3D NULL;
> +
> +	ce =3D index_file_exists(istate, name, strlen(name), 1);
> +	if (!ce)
> +		return 0;
> +
> +	/*
> +	 * A case-insensitive search in the name-hash using the
> +	 * observed pathname found a cache-entry, so the observed path
> +	 * is case-incorrect.  Invalidate the cache-entry and use the
> +	 * correct spelling from the cache-entry to invalidate the
> +	 * untracked-cache.  Since we now have sparse-directories in
> +	 * the index, the observed pathname may represent a regular
> +	 * file or a sparse-index directory.
> +	 *
> +	 * Note that we should not have seen FSEvents for a
> +	 * sparse-index directory, but we handle it just in case.
> +	 *
> +	 * Either way, we know that there are not any cache-entries for
> +	 * children inside the cone of the directory, so we don't need to
> +	 * do the usual scan.
> +	 */
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
> +			 name, ce->name);
> +
> +	/*
> +	 * NEEDSWORK: We used the name-hash to find the correct
> +	 * case-spelling of the pathname in the cache-entry[], so
> +	 * technically this is a tracked file or a sparse-directory.
> +	 * It should not have any entries in the untracked-cache, so
> +	 * we should not need to use the case-corrected spelling to
> +	 * invalidate the the untracked-cache.  So we may not need to
> +	 * do this.  For now, I'm going to be conservative and always
> +	 * do it; we can revisit this later.
> +	 */
> +	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
> +
> +	invalidate_ce_fsm(ce);
> +	return 1;
> +}
> +
> +/*
> + * Use the dir-name-hash to find the correct-case spelling of the
> + * directory.  Use the canonical spelling to invalidate all of the
> + * cache-entries within the matching cone.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static size_t handle_using_dir_name_hash_icase(
> +	struct index_state *istate, const char *name)
> +{
> +	struct strbuf canonical_path =3D STRBUF_INIT;
> +	int pos;
> +	size_t len =3D strlen(name);
> +	size_t nr_in_cone;
> +
> +	if (name[len - 1] =3D=3D '/')
> +		len--;

Nit: this could use `strip_suffix()`.

> +
> +	if (!index_dir_find(istate, name, len, &canonical_path))
> +		return 0; /* name is untracked */
> +
> +	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
> +		strbuf_release(&canonical_path);
> +		/*
> +		 * NEEDSWORK: Our caller already tried an exact match
> +		 * and failed to find one.  They called us to do an
> +		 * ICASE match, so we should never get an exact match,
> +		 * so we could promote this to a BUG() here if we
> +		 * wanted to.  It doesn't hurt anything to just return

Nit: this comment is stale as this has been promoted to a BUG already.

Patrick

> +		 * 0 and go on because we should never get here.  Or we
> +		 * could just get rid of the memcmp() and this "if"
> +		 * clause completely.
> +		 */
> +		BUG("handle_using_dir_name_hash_icase(%s) did not exact match",
> +		    name);
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
> +			 name, canonical_path.buf);
> +
> +	/*
> +	 * The dir-name-hash only tells us the corrected spelling of
> +	 * the prefix.  We have to use this canonical path to do a
> +	 * lookup in the cache-entry array so that we repeat the
> +	 * original search using the case-corrected spelling.
> +	 */
> +	strbuf_addch(&canonical_path, '/');
> +	pos =3D index_name_pos(istate, canonical_path.buf,
> +			     canonical_path.len);
> +	nr_in_cone =3D handle_path_with_trailing_slash(
> +		istate, canonical_path.buf, pos);
> +	strbuf_release(&canonical_path);
> +	return nr_in_cone;
> +}
> +
>  /*
>   * The daemon sent an observed pathname without a trailing slash.
>   * (This is the normal case.)  We do not know if it is a tracked or
> @@ -335,6 +443,19 @@ static void fsmonitor_refresh_callback(struct index_=
state *istate, char *name)
>  	else
>  		nr_in_cone =3D handle_path_without_trailing_slash(istate, name, pos);
> =20
> +	/*
> +	 * If we did not find an exact match for this pathname or any
> +	 * cache-entries with this directory prefix and we're on a
> +	 * case-insensitive file system, try again using the name-hash
> +	 * and dir-name-hash.
> +	 */
> +	if (!nr_in_cone && ignore_case) {
> +		nr_in_cone =3D handle_using_name_hash_icase(istate, name);
> +		if (!nr_in_cone)
> +			nr_in_cone =3D handle_using_dir_name_hash_icase(
> +				istate, name);
> +	}
> +
>  	if (nr_in_cone)
>  		trace_printf_key(&trace_fsmonitor,
>  				 "fsmonitor_refresh_callback CNT: %d",
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 830f2d9de33..730f3c7f810 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -1051,7 +1051,7 @@ test_expect_success 'split-index and FSMonitor work=
 well together' '
>  #
>  # The setup is a little contrived.
>  #
> -test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on =
disk' '
> +test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on =
disk' '
>  	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
> =20
>  	git init subdir_case_wrong &&
> @@ -1116,19 +1116,19 @@ test_expect_failure CASE_INSENSITIVE_FS 'fsmonito=
r subdir case wrong on disk' '
> =20
>  	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
> =20
> +	# Verify that we get a mapping event to correct the case.
> +	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
> +		"$PWD/subdir_case_wrong.log1" &&
> +
>  	# The refresh-callbacks should have caused "git status" to clear
>  	# the CE_FSMONITOR_VALID bit on each of those files and caused
>  	# the worktree scan to visit them and mark them as modified.
>  	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
>  	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
> -
> -	# Expect Breakage: with the case confusion, the "(pos -3)" causes
> -	# the client to not clear the CE_FSMONITOR_VALID bit and therefore
> -	# status will not rescan the file and therefore not report it as dirty.
>  	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
>  '
> =20
> -test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor file case wrong on di=
sk' '
> +test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on di=
sk' '
>  	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
> =20
>  	git init file_case_wrong &&
> @@ -1242,14 +1242,20 @@ test_expect_failure CASE_INSENSITIVE_FS 'fsmonito=
r file case wrong on disk' '
>  	GIT_TRACE_FSMONITOR=3D"$PWD/file_case_wrong-try3.log" \
>  		git -C file_case_wrong --no-optional-locks status --short \
>  			>"$PWD/file_case_wrong-try3.out" &&
> +
> +	# Verify that we get a mapping event to correct the case.
> +	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1=
/dir2/dir3/file-3-a" \
> +		"$PWD/file_case_wrong-try3.log" &&
> +	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1=
/dir2/dir4/FILE-4-A" \
> +		"$PWD/file_case_wrong-try3.log" &&
> +
>  	# FSEvents are in observed case.
>  	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_=
wrong-try3.log" &&
>  	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_=
wrong-try3.log" &&
> =20
> -	# Expect Breakage: with the case confusion, the "(pos-3)" and
> -	# "(pos -9)" causes the client to not clear the CE_FSMONITOR_VALID
> -	# bit and therefore status will not rescan the files and therefore
> -	# not report them as dirty.
> +	# The refresh-callbacks should have caused "git status" to clear
> +	# the CE_FSMONITOR_VALID bit on each of those files and caused
> +	# the worktree scan to visit them and mark them as modified.
>  	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
>  	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
>  '
> --=20
> gitgitgadget

--S76VTrDTYwWxV1YV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoaI0ACgkQVbJhu7ck
PpR+7A//UFoqdRy6MynNstqvKcCG1ZFqMtrtUzttE8LMZg73W4qSBrTODJbRSuXC
xKHkQtyvY8OvAyhFMYIsCKpTibro8BIO2h5VPVcWW8NB4ErKkAGEZoNbFr2iG6CN
1sI4TiRTtCwi7xSmp3oNfyoeeiKIl8mofmQSeYQYK8IFZ7CwHE37HZu3CweKcGEE
1sZkSHPjJxdHs9gS0rkNnMIOpRzPUTfwskpujv/8rhnCrh5XRu+83T7Gp/QnXGga
sdEgEj91svSNwKd6ngImDHnwmlOvh+c4IFWrQL3fXOSW324NqrTssh3DcOD92LMN
nbZHjgcKNDEIHB7RL/0FBa9JSapNqmgf32gf5SZBV+TRRop+Go1jOw/UacGwyXlx
BgP8OMdxpAR0bQ1B09kKAYosY1NlmAhEBEkqasmi6CNAZtJDnBhIj0xFHrNMr89h
/Hy6gz0wDwG+bDpgyxVmH6XvlD62UMVurzLsQQF/OPXdKZGQMumN446s3iBK+vcT
TLgCPtHlSO3o9YAs/Ud0LiEs+4lyqIdOW6BVVgSyHD0GID4/j2nO/1hbrT3IhEYW
QpuVOvWK9Dblam2qg6Wrc5WRvj2dB+rlqYBolFXxcV6akgDnAPX3dfmX3p0UzD0F
EvEbBZLUVMAWMiEC2Kwx+73M7XojPsPw1uSfVvNbFvpdRQF8zZw=
=q2yn
-----END PGP SIGNATURE-----

--S76VTrDTYwWxV1YV--
