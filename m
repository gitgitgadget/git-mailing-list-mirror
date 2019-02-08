Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698D81F453
	for <e@80x24.org>; Fri,  8 Feb 2019 23:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBHXxY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 18:53:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33956 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfBHXxX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 18:53:23 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8EE060737;
        Fri,  8 Feb 2019 23:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549670002;
        bh=GzmF5qmzOwZlfq/vDAdOFuzN+yK8wpLd5pfRUBanIi8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EGjjriCOo4bhKCyzNGr5s8ZCDhqX321YPMFVl01yr0QBcrrgipUlQVd3DmpeFGmYa
         J7vvQDmGpKIabsl22rb6sp12J5UF1EfcvPEguuueeu4Jnizn5nFXjNvfiWew9zzXS3
         Ulbfxrf9kNuPlXDOkfhDLHQrJvED2tUiGC6udaYoF0B0SrjD6vnwnE50rrayNLMPmK
         Uwr48m/M6PaPZZBVxUfdrf0IYRLHz7olRD2Tq4oNJxNW7Kcmpmuz0ETqnuG43a9Nkg
         w9Iloq6WqfDlX3jEDhybsCFvunlrEVHMlf6gGetKMj1YhQkyQwYCNyg6HKJPTkCeyo
         HRmSlZ5oVgykwphwV1j6Sn7u2rnS4GgTqJfC51hLLSMkC0W/vhYtFHdduw2szj/co0
         /7V0CPpaFNtPoyCbploYk2tl3ZDbXOXlHCg2hjwHZ/U66e5M4NGculAAX3LwwRL5h0
         3WHheNpVUGZz+gN0W+gXYtyrQ3htsKhUHXSO4bopXCDU7Lf8N9I
Date:   Fri, 8 Feb 2019 23:53:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, kewillf@microsoft.com
Subject: Re: [PATCH v1 1/3] read-cache: add post-indexchanged hook
Message-ID: <20190208235317.GI11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, kewillf@microsoft.com
References: <20190208195115.12156-1-peartben@gmail.com>
 <20190208195115.12156-2-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <20190208195115.12156-2-peartben@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 02:51:13PM -0500, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>
>=20
> Add a post-indexchanged hook that is invoked after the index is written in
> do_write_locked_index().
>=20
> This hook is meant primarily for notification, and cannot affect
> the outcome of git commands that trigger the index write.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>

First, I think the tests should be merged into this commit. That's what
we typically do.

I'm also going to bikeshed slightly and suggest "post-index-changed",
since we normally use dashes between words in our hook names.

> diff --git a/cache.h b/cache.h
> index 27fe635f62..46eb862d3e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -338,7 +338,9 @@ struct index_state {
>  	struct cache_time timestamp;
>  	unsigned name_hash_initialized : 1,
>  		 initialized : 1,
> -		 drop_cache_tree : 1;
> +		 drop_cache_tree : 1,
> +		 updated_workdir : 1,
> +		 updated_skipworktree : 1;

How important is it that we expose whether the skip-worktree bit is
changed? I can understand if we expose the workdir is updated, since
that's a thing a general user of this hook is likely to be interested
in. However, I'm not sure that for a general-purpose hook, the
skip-worktree bit is interesting.

> diff --git a/read-cache.c b/read-cache.c
> index 0e0c93edc9..0fcfa8a075 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -17,6 +17,7 @@
>  #include "commit.h"
>  #include "blob.h"
>  #include "resolve-undo.h"
> +#include "run-command.h"
>  #include "strbuf.h"
>  #include "varint.h"
>  #include "split-index.h"
> @@ -2999,8 +3000,17 @@ static int do_write_locked_index(struct index_stat=
e *istate, struct lock_file *l
>  	if (ret)
>  		return ret;
>  	if (flags & COMMIT_LOCK)
> -		return commit_locked_index(lock);
> -	return close_lock_file_gently(lock);
> +		ret =3D commit_locked_index(lock);
> +	else
> +		ret =3D close_lock_file_gently(lock);
> +
> +	run_hook_le(NULL, "post-indexchanged",
> +			istate->updated_workdir ? "1" : "0",
> +			istate->updated_skipworktree ? "1" : "0", NULL);

I have, in general, some concerns about this API. First, I think we need
to consider that if we're going to expose various bits of information,
we might in the future want to expose more such bits. If so, adding
integer parameters is not likely to be a good way to do this. It's hard
to remember and if a binary is used as the hook, it may not always
handle additional arguments gracefully like shell scripts tend to.

If we're not going to expose the skip-worktree bit, then I suppose one
argument is fine. Otherwise, it might be better to expose key-value
pairs on stdin instead, or something like that.

Finally, I have questions about performance. What's the overhead of
determining whether the hook exists in this code path when there isn't
one? Since the index is frequently used, and can be written out as an
optimization by some commands, it would be nice to keep overhead low if
the hook isn't present.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxeFmwACgkQv1NdgR9S
9osO4w/+MLrkKfoRw6D5n2J73glxl7W21tTmHC2hNZymh8xSJemhyDVqWKXUNjjR
fbdq3bs08yDK44SqK9cGtXGhccZGM8tAbAXDm1GslWjMr0zHjzPtbqfuQbQI5QoK
9cE2w76B6lPqoa/V9V+6TJd5ITigXFBBW2N3Ig0V7icLS2n9XbG02hvJzjMsEMw+
gJr++5Fe62sMjZNCw5hTg9U9ri7A+z7IYOnrud9ZuE4zzKMeUepodw1dgEH1r/+B
LeqPJlfkIzb70KRPaNV5xJIXr8zUKHMnCDX2dF/Bb9hb2uRXVpyNzsmTaQRVtTlB
VRTbX4HhuV/wf+TzEMV3vyAEmzOiPvo6PGTDjh6kN3f9MCTCqa6HvwsaiWuV+Tf/
3F+aETQ0B8jaSrhEDqPrTMkAOojGgSvzlQMwkr/+M8lUfDtkGXOZtwW94jzfU272
S6Gldgw1o1572VSDgAE9vbsXqL961g8N+UiAarVLXFHqi7wGsRxiCgWlxJ90qRR6
0b1JRfJMcZ/Ri5YqzS44OzMMPZrH7+wDHELrE5oHusifsyLsxG71PhUzL8qbLoR5
4yljTkkwmB0TXF25hMRY+zPidbncaAMM7PvU+IvdL+wTJGJE+ODcN+IAycOtDM0f
Rj/S4StR5kXeE2ERj36BgiCVgfdxYGR94TsBbJGK97xbYePl9Iw=
=6eFy
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
