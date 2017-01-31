Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D28C1F6DC
	for <e@80x24.org>; Tue, 31 Jan 2017 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbdAaIeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 03:34:37 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58888 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbdAaIeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 03:34:36 -0500
Received: from localhost (i59F7870A.versanet.de [89.247.135.10])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 1B32116C848;
        Tue, 31 Jan 2017 09:26:45 +0100 (CET)
Date:   Tue, 31 Jan 2017 09:26:44 +0100
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v4 0/5] urlmatch: allow wildcard-based matches
Message-ID: <20170131082644.GA560@pks-xps>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
 <cover.1485512626.git.patrick.steinhardt@elego.de>
 <xmqqy3xstdh9.fsf@gitster.mtv.corp.google.com>
 <xmqqfuk0tb3j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <xmqqfuk0tb3j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 02:52:00PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <patrick.steinhardt@elego.de> writes:
> >
> >>  - I realized that with my patches, "ranking" of URLs was broken.
> >>    Previously, we've always taken the longest matching URL. As
> >>    previously, only the user and path could actually differ, only
> >>    these two components were used for the comparison. I've
> >>    changed this now to also include the host part so that URLs
> >>    with a longer host will take precedence. This resulted in a
> >>    the patch 4.
> >
> > Good thinking.  I was wondering about this, too.
> >
> > Thanks.  Will read it through and replace.
>=20
> Ugh.  When applied on top of 4e59582ff7 ("Seventh batch for 2.12",
> 2017-01-23), Git fails its self-test in t5551 #31 (I do not run with
> EXPENSIVE so some tests liks #30 are skipped, if it matters).
>=20

Thanks for letting me know. I didn't have any errors on my other
machine, but was actually able to reproduce test failures on this
one.

Embarassingly, I forgot to zero-initialize the `struct
urlmatch_item`, leading to undefined behavior when searching for
configuration keys without a dot inside. This is the case for
nearly all keys, except for example the ones with a URL inside.

Will re-send a fixed version.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYkEpEAAoJEBF8Z7aeq/Esbv0P/1/ZcOFnsTAleZuaeJ5Ck6/K
SETggE8kSztu7sM7Add/I+o3/Kgs7JnKKqV616fbCW/E+td/eimKcTFM90nfctsr
KCrofjqR5SaBT6znhwz87gQl+3uulqxGAfAkq72hC1iMni2UFprHLssOKT2AiOHS
DNfZdhoOYXG/ucLTIprm/oL7WQQBEZfxKbuIx6GB3tFM+gce/Pd4uSn/pvGFKHCY
tedQBOTaISOtAH3RGKbgNGUCfmD6CUXBxaQhxtqA594ma+8Ne2TikS8FmeerZ0wf
6ABhQ9kQdTNcOpCxtVsSf8hoW3Rg2uBHggXs4SATIk8D7VxDPc/T44bqIW1xlMRt
Xyi4shFtxNaMrRFC432Oroql8AVIWXBmkjRO8OeLmIcZnmUxQcGEX5fmh+it2ZTP
egypdCiIgx2qMHhc0kermcKjNulj5gzG+W226gWPdUB+2EtN6fQt7yE821SJmmj3
AeX8clL7puxW6Aw5kBND48MLUQJ6PfH1hcvX/xAoc4WI5QhcnOaB6iaS53Ro7iRw
HcVFG/9L9HGzSd95mnFgB7MfMIQhUYgsH8fWQJHqMouzecC5BVZDlFz5zEL5hnY/
dTwjuq6erSz7UotYsyUgmYF+arGvrlpP7Ng/u9dNTorqKr2U25vPjO5bq7SgtRR3
MJ07Dwz6FEMVdKG/J/0j
=Wahw
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
