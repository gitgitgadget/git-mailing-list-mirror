Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1852FC433FE
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiB1PTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiB1PTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:19:14 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B605522C4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:18:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7ACE03200AF3;
        Mon, 28 Feb 2022 10:18:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Feb 2022 10:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=9HEpEFO7ITVntOwX8n6I4NEwsNCu9zY5zKPI9H
        fSTeo=; b=ggLNsL5oBkuOpNs2s4RVoPjSlYXSPZZESaV8BrpMJJij7j0/8RUeJv
        CjC2gF4r4dFQyRyy0Gdz9c6gUyvLxjKOsmAYR18fubgeKIUjH49EUcWmYqddFDni
        BqRy9ryc6Wlzj8rOGQJxLbQ+sZv7WNihuqTHdLwIBzdTRLcM2Tec2yBt+b3x8Pj/
        Z7ri34L/zfky4tAMfHtQTMXIKnTyqnWEE7IgGc6pLz0NXw2nvQSpGmnPVvOLT8kb
        +gbad3hVYJuqh8fq3n6uVlC2hjj+/OBfxajYwcHWRQp/mNbyi6g6qBTFFBl+rfh+
        Awf4ona7nqZ5rlVM1I16QR7XHUAezKlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9HEpEFO7ITVntOwX8
        n6I4NEwsNCu9zY5zKPI9HfSTeo=; b=e0rQEAHSFpAuFWOXJg/4FE9kdZzy+lGNr
        JHyj3Ea1dKUuatBOYaNWZwKJt8H9xS0PIMdsfcL1qLTqfZmwBacWUNnM5CNXmgN0
        qztK48tM+bQHb1TmFzD1GLFUPMWY6L1AnM3lMeoNXtcdnF+EpiN3T39P4xzSDRUQ
        fiWGtMjwv0LDp29dnck9T227Yyp/UnB2u0IFFmS+kTGlf6VH62zTglb0eMpysWVp
        b67xGcRC6JcOlvkyVgmKehFxseQvjC7/Y3fvYz1xiu2/x42jNNVn8IJAQ2Hzv2YM
        hyI8ubMesM3mUr+074sEkura0qqCANRlqKWEOlkAfDOshsKGGS1lA==
X-ME-Sender: <xms:xuccYpFV__VUrAMPYmZK6V-vBHfPSs1E1h7D7AYvQlSffKmx_DONEA>
    <xme:xuccYuXQOQwRwBiJ03eN069ZMGfBBN5HtozQAE-GplkrMNniAWzG-3lVWvXNMMjzr
    m0HKp3ozmJzRRcuzg>
X-ME-Received: <xmr:xuccYrIHyEaaG78ovW5cK0TtpZ1Ca8Md7orRX84dAqbsEdBAPaTJHTR-6Soe_9_L9PbO3mSHt0x5e-tdyuf0-uXeGF7tPQ2hMBZ-95Ha450CoNgr9cjYaVrFyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeevudeuieetgfeiveevgfdtueeuveevgeegvefggedvueeliedvleelleekuedvuden
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:xuccYvGeEJP5pE2B9ixUpjA5K1wAkr7bLhaO53YhpUqCkr3yAF696A>
    <xmx:xuccYvX2T01ZmhbQDNx0oWlMn2F423dB12nQIILRyhBjBcXAiJW2UQ>
    <xmx:xuccYqPgrmOh1oa7lJOUfPwWS4Da4ZpK0Fgef6yt7HBqc1LqkS5M4g>
    <xmx:xuccYlyIfInE0ht61bVrBLPHYn_0A57tQOzYsFbMPkV2zgyAFeSwEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Feb 2022 10:18:29 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1dacc414 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Feb 2022 15:18:28 +0000 (UTC)
Date:   Mon, 28 Feb 2022 16:18:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <YhzkdMxrIGlNutr6@ncase>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxUu0K2JubPRlOTl"
Content-Disposition: inline
In-Reply-To: <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cxUu0K2JubPRlOTl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 08:38:32PM +0000, Derrick Stolee via GitGitGadget w=
rote:
> From: Derrick Stolee <derrickstolee@github.com>
>=20
> The 'read_generation_data' member of 'struct commit_graph' was
> introduced by 1fdc383c5 (commit-graph: use generation v2 only if entire
> chain does, 2021-01-16). The intention was to avoid using corrected
> commit dates if not all layers of a commit-graph had that data stored.
> The logic in validate_mixed_generation_chain() at that point incorrectly
> initialized read_generation_data to 1 if and only if the tip
> commit-graph contained the Corrected Commit Date chunk.
>=20
> This was "fixed" in 448a39e65 (commit-graph: validate layers for
> generation data, 2021-02-02) to validate that read_generation_data was
> either non-zero for all layers, or it would set read_generation_data to
> zero for all layers.
>=20
> The problem here is that read_generation_data is not initialized to be
> non-zero anywhere!
>=20
> This change initializes read_generation_data immediately after the chunk
> is parsed, so each layer will have its value present as soon as
> possible.
>=20
> The read_generation_data member is used in fill_commit_graph_info() to
> determine if we should use the corrected commit date or the topological
> levels stored in the Commit Data chunk. Due to this bug, all previous
> versions of Git were defaulting to topological levels in all cases!
>=20
> This can be measured with some performance tests. Using the Linux kernel
> as a testbed, I generated a complete commit-graph containing corrected
> commit dates and tested the 'new' version against the previous, 'old'
> version.
>=20
> First, rev-list with --topo-order demonstrates a 26% improvement using
> corrected commit dates:
>=20
> hyperfine \
> 	-n "old" "$OLD_GIT rev-list --topo-order -1000 v3.6" \
> 	-n "new" "$NEW_GIT rev-list --topo-order -1000 v3.6" \
> 	--warmup=3D10
>=20
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):      57.1 ms =C2=B1   3.1 ms
>   Range (min =E2=80=A6 max):    52.9 ms =E2=80=A6  62.0 ms    55 runs
>=20
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):      45.5 ms =C2=B1   3.3 ms
>   Range (min =E2=80=A6 max):    39.9 ms =E2=80=A6  51.7 ms    59 runs
>=20
> Summary
>   'new' ran
>     1.26 =C2=B1 0.11 times faster than 'old'
>=20
> These performance improvements are due to the algorithmic improvements
> given by walking fewer commits due to the higher cutoffs from corrected
> commit dates.
>=20
> However, this comes at a cost. The additional I/O cost of parsing the
> corrected commit dates is visible in case of merge-base commands that do
> not reduce the overall number of walked commits.
>=20
> hyperfine \
>         -n "old" "$OLD_GIT merge-base v4.8 v4.9" \
>         -n "new" "$NEW_GIT merge-base v4.8 v4.9" \
>         --warmup=3D10
>=20
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):     110.4 ms =C2=B1   6.4 ms
>   Range (min =E2=80=A6 max):    96.0 ms =E2=80=A6 118.3 ms    25 runs
>=20
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):     150.7 ms =C2=B1   1.1 ms
>   Range (min =E2=80=A6 max):   149.3 ms =E2=80=A6 153.4 ms    19 runs
>=20
> Summary
>   'old' ran
>     1.36 =C2=B1 0.08 times faster than 'new'
>=20
> Performance issues like this are what motivated 702110aac (commit-graph:
> use config to specify generation type, 2021-02-25).
>=20
> In the future, we could fix this performance problem by inserting the
> corrected commit date offsets into the Commit Date chunk instead of
> having that data in an extra chunk.
>=20
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  commit-graph.c                |  3 +++
>  t/t4216-log-bloom.sh          |  2 +-
>  t/t5318-commit-graph.sh       | 14 ++++++++++++--
>  t/t5324-split-commit-graph.sh |  9 +++++++--
>  4 files changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/commit-graph.c b/commit-graph.c
> index a19bd96c2ee..8e52bb09552 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -407,6 +407,9 @@ struct commit_graph *parse_commit_graph(struct reposi=
tory *r,
>  			&graph->chunk_generation_data);
>  		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
>  			&graph->chunk_generation_data_overflow);
> +
> +		if (graph->chunk_generation_data)
> +			graph->read_generation_data =3D 1;
>  	}
> =20
>  	if (r->settings.commit_graph_read_changed_paths) {

I wanted to test your changes because they seem quite exciting in the
context of my work as well, but this commit seems to uncover a bug with
how we handle overflows. I originally triggered the bug when trying to
do a mirror-fetch, but as it turns it seems to trigger now whenever the
commit-graph is being read:

    $ git commit-graph verify
    fatal: commit-graph requires overflow generation data but has none

    $ git commit-graph write --split
    Finding commits for commit graph among packed objects: 100% (10235119/1=
0235119), done.
    fatal: commit-graph requires overflow generation data but has none

    $ git commit-graph write --split=3Dreplace
    Finding commits for commit graph among packed objects: 100% (10235119/1=
0235119), done.
    fatal: commit-graph requires overflow generation data but has none

I initially assumed this may be a bug with how we previously wrote the
commit-graph, but removing all chains still reliably triggers it:

    $ rm -f objects/info/commit-graphs/*
    $ git commit-graph write --split
    Finding commits for commit graph among packed objects: 100% (10235119/1=
0235119), done.
    fatal: commit-graph requires overflow generation data but has none

I haven't yet found the time to dig deeper into why this is happening.
While the repository is publicly accessible at [1], unfortunately the
bug seems to be triggered by a commit that's only kept alive by an
internal reference.

Patrick

[1]: https://gitlab.com/gitlab-com/www-gitlab-com.git

--cxUu0K2JubPRlOTl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIc57sACgkQVbJhu7ck
PpTOHw//UYp2A6KSa5C/CKE2MrPh3eGRySUiUN2AZAIAWU/sem9tB2ZaO37JyQ+6
RKAawyDrIfbx5hK2oZielKqNjxRmHWY7knqwpsrTRQ1lbJuw1E3MfYUNFkxRkrZF
YpcAkfmRvKMEovqnzJ4Btr7J/C93w9hB8xCRakvSF5fXlMHy9/7NSYdNgfMH2C32
zjWQ0JZcvDMJQttq80IOp4lNSxudWNdAJnMpWVe3fewj0MIjJj69oILh2JH6wVyP
MmYBX2aE3EEa8/ct0TuJ/0fzeF79bdrfsbWrqzwqKgYx+YQ7f7wN3VoFbh1N8NZB
kZUBbDXXKZqKq6lj7Fyb4YkTyXvXUJzg5Y2+VY6VJB1QDz+55TgFYsZHvQABalt8
lbetuBxPs1SSqboTiIW54AkQvH4tF4jI627HReR/5EL6/+YpSvjx5H72fkLTzwIE
VV5yb6AzhjUNe/dm+MyqSlc6XEPjUMkcLs9uAqkXEfeaQKGvchJkoAitIC0vxBPL
pyXAjMOC8jvaDjOCDdOAeslAuma+kE3ufz9kSY8HKKm3yMsfAz/DKVgCpxR8kSqu
FxvGXqC7HpPsNgsdivZVAmXkBcK9ybtFmCbklFcW2UvvriaIiLU410iyfMRoD1dI
rCHGp2DNiHS+N/TzN8O2YlXyrYZFpdOTqttrxUMT5MbDGYieIyk=
=xgJw
-----END PGP SIGNATURE-----

--cxUu0K2JubPRlOTl--
