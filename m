Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F587C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiB1Q4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiB1Q4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:56:46 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527F79C68
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:56:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 76E4E3200F9F;
        Mon, 28 Feb 2022 11:56:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Feb 2022 11:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=dy5m3euToypHaitRYoeHI8t0XK4g1e9SSRw9vr
        8/mV4=; b=P2ROOc52ada/d0kr08dPmIvwK+QerYpUHNrUeaeAv26j1UeSopJSmP
        JdlrV1ytGtQ6kqUosy0uTsxOTCvPbsaczDRUfU1DfWNxGM8v9uNykwCn77xRON86
        1YN+r1TfBLWQizdfsPHpZZitdbRDJN3E7MSMWaz5jDRCMhUXEr802jS8P/hj5XNg
        JxXN/EkB8iHLicFNg9KLj8CQeE2qRKrQAIrBiosxgJdkTKjMWs0fJyq+2eVy3xll
        3P6TP36MIYZFv2WVEK0zatbyaxw/p75llKVOAq/D3sfIIuaOosLv9DdVSTPpstWl
        kG4skCJtvcwPlbTHy+ZheG2SBXrWnNAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dy5m3euToypHaitRY
        oeHI8t0XK4g1e9SSRw9vr8/mV4=; b=YRH0fwOfN7ZmyjsvGT+ouXyMMLA/44noi
        c9BekVTX0VbcVqYSS5q3Xt2vuE5yv1Ce4OvVSK/9kjSHCGII0xNZ2cI2CAentRNg
        RRAovUtdA3wNb/RiLIj6VZqSYXeb/h/vzmhxPIJ+xCsrYHN1di5jJKNu2DEcMHey
        Ctyjjf3Sm7HwFFV0xvVP3i3PKoQRp5NLvaUcrp3kt4AELrX7XFRf/phg95GtkRuB
        HNJfIdTU4J3hA9uqm1ps0wGujd97boHi146LUUksnx1YV6KIioETGjWgbxdHL/rG
        WRA3AcJaC2JCZOulFCKNSbypzWIhgZ2bLyst1iRNHsccmr1reIBog==
X-ME-Sender: <xms:of4cYiu053AuJxRVumbz7F9CKfOMV8tAQ5lqxeLmHf6Xh6YBgX7xGQ>
    <xme:of4cYnd0IOg_CQRen3toRx2wx3fN-U2BKLymLJMfOQFVelueA1gO2V6knPIIvheJZ
    L085F8-SLdG-0cV_Q>
X-ME-Received: <xmr:of4cYtzYiIXfX11rY-o7oj2qU2u3KGqCLsouaoPFASF6lpyBrSKdFUyLuceiyzkD4CHdxJSDmIX4ecaAfuQkKRe3D9s_EltF4fQjQuJPuIsq6U7w-BDghv6q3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejjedtiefggeekgfejheevveejjeevuedvtdeikeffveelgeelhffggfejjeeffeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:of4cYtNpzcXaGPJbXvNaeeaSZM1EMqzK8X0__bQ6LKNWmfyjgD0OSg>
    <xmx:of4cYi9lUYqulCt4gUfmFMF4NX0BpRefOWuvtm4xuaDRVFldGzg0Ag>
    <xmx:of4cYlXryo-5pL6rIpos37AW-ceo_d24PhUDIBtK2Lx3JUfvctpvCw>
    <xmx:ov4cYmaxhicvArG_uDrY5eYmOvUQ7LgG_4mATiu3VU1gYwEygxMaiw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Feb 2022 11:56:00 -0500 (EST)
Received: from localhost (xps [10.192.0.12])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ab7f7c14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Feb 2022 16:55:57 +0000 (UTC)
Date:   Mon, 28 Feb 2022 17:59:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <Yhz/hsDDGNVjt64R@xps>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase>
 <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R/WgcEzUd6w0hrS0"
Content-Disposition: inline
In-Reply-To: <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R/WgcEzUd6w0hrS0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
> > On Thu, Feb 24, 2022 at 08:38:32PM +0000, Derrick Stolee via GitGitGadg=
et wrote:
> >> From: Derrick Stolee <derrickstolee@github.com>
> ...
> >> diff --git a/commit-graph.c b/commit-graph.c
> >> index a19bd96c2ee..8e52bb09552 100644
> >> --- a/commit-graph.c
> >> +++ b/commit-graph.c
> >> @@ -407,6 +407,9 @@ struct commit_graph *parse_commit_graph(struct rep=
ository *r,
> >>  			&graph->chunk_generation_data);
> >>  		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
> >>  			&graph->chunk_generation_data_overflow);
> >> +
> >> +		if (graph->chunk_generation_data)
> >> +			graph->read_generation_data =3D 1;
> >>  	}
> >> =20
> >>  	if (r->settings.commit_graph_read_changed_paths) {
> >=20
> > I wanted to test your changes because they seem quite exciting in the
> > context of my work as well, but this commit seems to uncover a bug with
> > how we handle overflows. I originally triggered the bug when trying to
> > do a mirror-fetch, but as it turns it seems to trigger now whenever the
> > commit-graph is being read:
> >=20
> >     $ git commit-graph verify
> >     fatal: commit-graph requires overflow generation data but has none
> >=20
> >     $ git commit-graph write --split
> >     Finding commits for commit graph among packed objects: 100% (102351=
19/10235119), done.
> >     fatal: commit-graph requires overflow generation data but has none
> >=20
> >     $ git commit-graph write --split=3Dreplace
> >     Finding commits for commit graph among packed objects: 100% (102351=
19/10235119), done.
> >     fatal: commit-graph requires overflow generation data but has none
> >=20
> > I initially assumed this may be a bug with how we previously wrote the
> > commit-graph, but removing all chains still reliably triggers it:
> >=20
> >     $ rm -f objects/info/commit-graphs/*
> >     $ git commit-graph write --split
> >     Finding commits for commit graph among packed objects: 100% (102351=
19/10235119), done.
> >     fatal: commit-graph requires overflow generation data but has none
> >=20
> > I haven't yet found the time to dig deeper into why this is happening.
> > While the repository is publicly accessible at [1], unfortunately the
> > bug seems to be triggered by a commit that's only kept alive by an
> > internal reference.
> >=20
> > Patrick
> >=20
> > [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
>=20
> Thanks for including this information. Just to be clear: did you
> include patch 4 in your tests, or not? Patch 4 includes a fix
> related to overflow values, so it would be helpful to know if you
> found a _different_ bug or if it is the same one.
>=20
> Thanks,
> -Stolee

I initially only applied the first three patches, but after having hit
the fatal error I also applied the rest of this series to have a look at
whether it is indeed fixed already by one of your later patches. The
error remains the same though.

Patrick

--R/WgcEzUd6w0hrS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIc/4UACgkQVbJhu7ck
PpQuQg/+P+/JpIcEnEz74CErEQWgvCXMA/q/3CIhHDWbNNsl/QBpzgaXBYTjVS/X
m02JEjBLe52BzOqZZxVoOqYYt2EjYrkw75KVn/99YluhHBHx+WIKx3j2BWaKmq5B
KBZWBSlI8A1CYATKaQmEcLbCmIPyuFsrYAqNp4bZFV/5KkQkx8ATENXnu/iSqhlU
+DjL0S5nTgh2PDYQ8jjVUL/rKhgZFJ07gohhYfmNpqXQMJ40vNDgE+CeLqD/PfPF
2zmxfUPUvqMvqf+5BBHijqy6V/MvrhFKgP6FuoLB6PmsK454cAZ98yatT418yal1
dXdrV++lxrvBnrt148l+tP+9FCyRjlql4lBJDDQjPMwiCWlCXNS3e036gfD52TZF
/Kj9hL6uncsv9oNmGssXhTxTP0opXalllit+u4kvJyG9G3YxPapTR/hSOrW6VQOK
3r9dNwhEliWnNMlTDVD3WXoBJFjvL4vtEvuGckuZSrvmUZ6l9MOwFa9Rhaust9+g
LLuBo7bYjNTVnKskjjzBqQXU968i+ptmb+uYPrVfXwKTPqc04KIr1MkzGRegOC1F
cMRTDAyvGcNRjjHK5uWVJXYTTYUHmhwUrDkAw3wy7ve4QJVPTMeNobdoisJS5MoO
mwCIDYvXJM8dSJvzZ7yH0+/km0XXqo15uV6pOQZw164iCgLxm+8=
=gWBB
-----END PGP SIGNATURE-----

--R/WgcEzUd6w0hrS0--
