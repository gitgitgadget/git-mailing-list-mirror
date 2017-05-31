Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955AB1FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdEaWBC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:01:02 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46860 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751015AbdEaWBC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 18:01:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E3FDF280AD;
        Wed, 31 May 2017 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1496268060;
        bh=CPoE3XAjkQikO49UK7R/Fbo6LuckDB1otbSBERYy0fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjyvPASgk0mj9zf+pVE7L3k05dvGbwaDFwB/FXwIkyRwSOlo7tUBWw+KvSx1o7+Vh
         kYNnHqxI0n+5dpXH06iUsV/rhzux72kCiGMVE5k6NGR72bIIoDRo91LVxARVp+ivoc
         xUTdriFFMOVH3ja8IurrqgqVir1yJ//0FiZhux4QURdCbRGcNvOviJc20cB0qdczR9
         CvaRZaZaDO5nMmS1jzJ2FomfxzokvrxsJbhjVaqtUEc3lXItR04r52lzB1I4R0nLqW
         kcmKGpDW6Jon74V/LfOpPeC+s0/NUsPRsIfd1uMdNDSAqYvluLX0SIvjVoB5vtzZTB
         /qUx1tDm2D46poKaFxzYPueCM8O4KH6DdWfBorYqiq2yX2Qs9ijl+JdPg5oGO8gDqs
         V/hJsUCIYCx5FH9lRFBzRMBVCrfFn6Cxm18j1dFRdZOiPR2PZYCqtsPS7k1M609CSJ
         4eWMjH5tUWLQnndxiZmaOQIoVwWTAQXnXGDCEMLsrXBtFLKdYUp
Date:   Wed, 31 May 2017 22:00:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 22/33] notes-merge: convert notes_merge* to struct
 object_id
Message-ID: <20170530185653.cfy4cbq3pmxfq5x6@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-23-bmwill@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnr3mgdpf3sfw247"
Content-Disposition: inline
In-Reply-To: <20170530173109.54904-23-bmwill@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tnr3mgdpf3sfw247
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 10:30:58AM -0700, Brandon Williams wrote:
> @@ -596,47 +596,47 @@ int notes_merge(struct notes_merge_options *o,
>  	/* Find merge bases */
>  	bases =3D get_merge_bases(local, remote);
>  	if (!bases) {
> -		base_sha1 =3D null_sha1;
> -		base_tree_sha1 =3D EMPTY_TREE_SHA1_BIN;
> +		base_oid =3D &null_oid;
> +		base_tree_oid =3D &empty_tree_oid;
>  		if (o->verbosity >=3D 4)
>  			printf("No merge base found; doing history-less merge\n");
>  	} else if (!bases->next) {
> -		base_sha1 =3D bases->item->object.oid.hash;
> -		base_tree_sha1 =3D bases->item->tree->object.oid.hash;
> +		base_oid =3D &bases->item->object.oid;
> +		base_tree_oid =3D &bases->item->tree->object.oid;
>  		if (o->verbosity >=3D 4)
>  			printf("One merge base found (%.7s)\n",
> -				sha1_to_hex(base_sha1));
> +			       oid_to_hex(base_oid));

I noticed you fixed up the indentation.  Thanks.

> diff --git a/notes-merge.h b/notes-merge.h
> index 0d890563b..eaa8e3b86 100644
> --- a/notes-merge.h
> +++ b/notes-merge.h
> @@ -33,15 +33,15 @@ void init_notes_merge_options(struct notes_merge_opti=
ons *o);
>   *
>   * 1. The merge trivially results in an existing commit (e.g. fast-forwa=
rd or
>   *    already-up-to-date). 'local_tree' is untouched, the SHA1 of the re=
sult
> - *    is written into 'result_sha1' and 0 is returned.
> + *    is written into 'result_oid' and 0 is returned.
>   * 2. The merge successfully completes, producing a merge commit. local_=
tree
>   *    contains the updated notes tree, the SHA1 of the resulting commit =
is
> - *    written into 'result_sha1', and 1 is returned.
> + *    written into 'result_oid', and 1 is returned.
>   * 3. The merge results in conflicts. This is similar to #2 in that the
>   *    partial merge result (i.e. merge result minus the unmerged entries)
>   *    are stored in 'local_tree', and the SHA1 or the resulting commit
>   *    (to be amended when the conflicts have been resolved) is written i=
nto
> - *    'result_sha1'. The unmerged entries are written into the
> + *    'result_oid'. The unmerged entries are written into the
>   *    .git/NOTES_MERGE_WORKTREE directory with conflict markers.
>   *    -1 is returned.
>   *

Did you want to change the comment to say "object ID" or "OID" instead
of "SHA1" like you did in an earlier patch?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--tnr3mgdpf3sfw247
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkvPRkACgkQv1NdgR9S
9os3qRAAh5sc9zynTIiaeqvw/8apnyN9hZEnC2MOczRRHSRVYZ/FxsjhbyJ+XpJ2
fsFIaRFoiTQHAjS/xjkUazvARI5qRZck6LemCxjV6REJUbcsBb2xp78EgJOnawWV
zXJ3hwtqxQc8pw99JgY/WioFTy4yJiY/XGaRg04HZNtnisgxWEMfb+c+gNd/bsa8
NvNAe2gVGQtNCkazOYi3cmIeW4ltcVHUJjsC2TKK3SZO7UiQ+92fzSHOOQVaSMKg
O9C9Lm0E82smyUYeTpycPdN2RzFAqn4uFadSYRDn9YiUH2Wtmp0LFXKcNE0AQNWW
9YP3MRfn/E1DbOvm0q1QuPI+Cne19nQLjw69rlUeUgQcXUygLA48GhNemykTKuVJ
h1hokdxH0ujocr7rvzmfJ4K8CdsgsY+Z3KPcD6F4Z4XwOx8gJfQ0i0ppS6ZsOYgz
RMTLr6bwmCv7glEk/Kkp8qz0GBtBAhCipuXlUWisIusDUvzEZWdFZ0YLr5BfB3dc
Lg3KXwmex0PE/GqW7i4mqDLsucSZnA1R1qMAeXFX1owdtDayqW4/cgOFROI7aYQI
mgeDBnXswido0gZnfjCZxoQe5kCLpIWZ0Y3T2hfqmZ9TCeGnUXDvI1jKz4Pu16ck
yeh+SktZ3tdoL9KEOuXJ0QFNelqrlc4TtHXrmX3r7/48Nw9VWfc=
=IhS/
-----END PGP SIGNATURE-----

--tnr3mgdpf3sfw247--
