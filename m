Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47151C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 08:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjD1IwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjD1Iv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:57 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB649DF
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 01:51:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 02B233200805;
        Fri, 28 Apr 2023 04:51:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 28 Apr 2023 04:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682671898; x=1682758298; bh=dj
        sqO/AQn+3B1bAKvt6cITtQq6UB8hVfdQEYwathxaE=; b=SnyeHLoCpQvKTjc+U4
        0VBQTX0sPnf6usXHA6VnSo1gbAurzOq+0pjslqsVw9leEHfexZDsGk09BSrPD5FH
        /pt4U6TGU0XGFKP+kDKNOgVnEZ9oXQRdBfwPjzjqaed00oZoRuPFd5wj84E6tG0t
        d7u0Lwqhpln/zgIurNEZKsLIeuzdybYKIQjIMr/Wqmj9VtqdJX+bFOcA3thZrFKJ
        2ukzSVqyXYXLiqtuLlYd9uzJl+lcSpUmx+PRbBoHogTc2hH0AGpNRCz+qp49AC1O
        e9IZzBHnsJtIRxxZF2KtmayRInzKqLHi603z2hk2s4tKqR8GcPgdj0nBXxaCsK3b
        hXsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682671898; x=1682758298; bh=djsqO/AQn+3B1
        bAKvt6cITtQq6UB8hVfdQEYwathxaE=; b=Ey1ZXIhYZl1/FvUPqALWqpX7Fwyto
        hwiLnNS0ERsQN9i0qOR+zCoQATLeRTtqwrp/SVm42GNt0cjGC6wczPJNPlL6qCyu
        MHRQBVyKxUB0izZyKKmLQUmxmj3AflnmcWwarSAfRhAsb+mE4N+TAYApSURCnXJC
        ohMomq7WWz+gITzGEkENsd+dOnb43Kmt+NWHMQdfQFxUbhJ5wmTtK60//MCzug8v
        Zw8tB1MOI/tzorIJwKC6mLu7OBo88VdEZ7FFoqcTH6+dxdZZXsKaHaD2NuNP0AMc
        R8dNOtwX5j7wt1gG7fbJEmLw1Q3zNLW3offBW6S4SxMI6znDzpkJ/QOYQ==
X-ME-Sender: <xms:GolLZPkI45_AEH9rIWO9N58iFtuOUa_87c7i-1gTErvu04TdbnDv5A>
    <xme:GolLZC2kPIkGDGCGKiQfrFE4vYkngaBzvgKbRbqEN8AnEgWHCr82QlzNJwi_irMNd
    M6IzEoJeXF8uq4V-Q>
X-ME-Received: <xmr:GolLZFqtLkHkoDYqejR6AmOHmyYD-xOKth3RUHrU0PnRVhK9PUbdOX44kVY4Y_5atMjhqP3SQQ0mfgx_njfro9aw6pO3pfL9r5S_2itQLkix3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedukedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GolLZHkXetDddlmlJs4VfLfQ9AFtjikR2ZPtKN0r8BH6z5ANqZIKmA>
    <xmx:GolLZN144kIBC4wq6sMLC61jDjuZLNcBf79LHsKlwgYskixDk8qdpg>
    <xmx:GolLZGugpoV7dXOoIG8u4WvS2BGPMFKeNyUvWToB-czo94oqef9yQw>
    <xmx:GolLZO84JVvOGxD0U1MJg67H10P-AOhkfMiqPZUetJweLU6mGlNALg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Apr 2023 04:51:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9dfc00e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 28 Apr 2023 08:51:04 +0000 (UTC)
Date:   Fri, 28 Apr 2023 10:51:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 8/8] fetch: introduce machine-parseable "porcelain"
 output format
Message-ID: <ZEuJFOBCdnCLdGc5@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
 <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZEpVSrz-uUcfN_3_@ncase>
 <kl6lfs8knc9f.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gQUFoi2Je1yJ2eU0"
Content-Disposition: inline
In-Reply-To: <kl6lfs8knc9f.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gQUFoi2Je1yJ2eU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 04:20:12PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Apr 26, 2023 at 12:52:46PM -0700, Glen Choo wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > So with that in mind, I'd like to continue ignoring this issue for now
> > and just not report the remote that the ref came from. But I'd also
> > argue that we don't have to restrict porcelain mode to single-remote
> > fetches: it can still be useful to do multi-remote fetches even without
> > the information where a certain reference update comes from. So any kind
> > of restriction would feel artificial to me here.
> >
> > Furthermore, I'd argue that it is not necessary to label the format as
> > experimental only because of this limitation. With the refactorings done
> > in this and the preceding patch series it is easy to add a new format in
> > case there indeed is somebody that would have a usecase for this. The
> > "porcelain" format should stay stable, and if we decide that we want to
> > also report the remote for each reference in a follow-up we can easily
> > add a "porcelain-v2" or "porcelain-with-remote" format.
>=20
> I agree that the current form is useful, but it seems quite likely that
> users will want the remote name/url at some point. In the majority of
> cases, the user can parse the remote name from the updated local ref and
> if they want, they look up the url by asking "git config", but that
> breaks down quite quickly if they have a custom refspec.
>=20
> My suggestion to label it experimental was meant to give us the freedom
> to change the "first version" in backwards-incompatible ways that we
> otherwise couldn't. We could say "here's porcelain-v2, use this and
> ignore porcelain-v1", but it would be even nicer if the user didn't need
> to think about porcelain-v1. The idea is that we could call it
> experimental, see what users need in the wild, then make changes without
> having to create a new "porcelain-v2" mode.
>=20
> (I realize in hindsight that calling it experimental sounds a bit
> insulting. I thought your proposal was quite sensible, actually. i
> apologize if it came across that way)

No offense taken, so no need to apologize.

> Perhaps part of the reason why you'd prefer not to make it experimental
> is that users who might want this feature are too afraid of
> backwards-incompatible changes. I think that's fair.

Exactly. I'm implementing this whole feature with a concrete usecase at
GitLab in mind, and if we declare this as experimental then it will
become a whole lot more risky for us to actually adopt it. Because if
the output format may change at any point in time, then the code that
builds on top of it is likely to be broken.

> A different way of
> achieving the same flexibility would be to make the "porcelain" format
> extensible (like git status --porcelain=3Dv2). A future, multivalued
> "--porcelain-options=3Dshow-remote-url,show-remote-ref" would cover
> our bases.

Yeah, that would indeed be quite flexible. Theoretically, there is no
reason why we couldn't have `--output-format=3Dporcelain,show-remote-url`
though.

> I'm happy with either approach as long as we don't have to bikeshed
> about the "perfect" porcelain output :)

Agreed, and that's why I'm currently defending the "good enough" format.
It should likely work for most usecases that exist out there. The target
audience is going to be quite small here as this is not a user-directed
feature. Furthermore, I assume that the overlap of machines that want to
parse all reference updates done in a multi-remote fetch while also
being able to exactly tell which remote brought in what updates is going
to be tiny.

> >> > With these assumptions, the output format becomes unambiguously
> >> > parseable. Furthermore, given that this output is designed to be
> >> > consumed by scripts, the machine-readable data is printed to stdout
> >> > instead of stderr like the human-readable output is. This is mostly =
done
> >> > so that other data printed to stderr, like error messages or progress
> >> > meters, don't interfere with the parseable data.
> >>=20
> >> Sending the 'main output' to stdout makes sense to me, but this (and
> >> possibly respecting -z) sounds like a different mode of operation, not
> >> just a matter of formats. It seems different enough that I'd prefer not
> >> to piggyback on "fetch.output" for this (even though this adds more
> >> surface to the interface...).
> >>=20
> >> We could add --porcelain and say that "fetch.output" is ignored if
> >> --porcelain is also given. That also eliminates the need for
> >> --output-format, I think.
> >
> > I was thinking about this initially, as well. But ultimately I decided
> > against this especially because of your second paragraph: we'd now need
> > to think about precedence of options and mutual exclusion, and that to
> > me feels like an interface that is less obvious than a single knob that
> > works as you'd expect.
>=20
> My full thoughts on this are in
>=20
>   https://lore.kernel.org/git/kl6lildhlz3i.fsf@chooglen-macbookpro.roam.c=
orp.google.com
>=20
> but the short version is that I'm not sure if I expect something as
> innocuous-looking as --output-format would imply other, machine-friendly
> things (like stdout instead of stderr), and using --porcelain might make
> option precedence clearer in some situtations (like if -z is given).

I'm not even sure that `-z` makes sense in this context. If we see cases
where not using `-z` can cause the machine-readable interface to become
unparseable then this is a bug in the output format, if you ask me.
Mostly because the whole intent of it is to be machine-parseable. So if
we output data that can e.g. contain newlines, then we must not use
newlines as part of the output format or alternatively escape them. Why
let the author of the script shoot themselves into the foot?

Anyway, I'm digressing. It's hard for me to decide what to do right now.
The thread with Junio and Jacob points into the direction of keeping the
`--output-format=3D` interface, while this thread points into the other
direction. I'm naturally more inclined to keep `--output-format=3D`,
mostly because I personally feel like it's the more obvious interface.
But I also see your point, so it's not really a choice of right-or-wrong
here, but rather of style.

Patrick

--gQUFoi2Je1yJ2eU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRLiRMACgkQVbJhu7ck
PpS3lg//UNts/AFViqmQvi563ZjLf9WYbJt9BNS82Qmh20jY/6NcmJCNBg6txH47
Gy2Bxjs0WwVrjq5Rz2X7hfXJNFsbR2RxJIwT0dybLhSd9UtxnJWkRTNgW1uRFTzn
E3uQ62OLZJvugGj4VydjM8MXATyy/HiZHKhVHfemNKyf7bblZHjfV/LJTojjkHJh
slXf/RrW6larrmEp3to8VtVs1kBjEb6c+4akN2yD4u8oexB3sgqkpQ/uOwQkbI2r
4HuS7Iy/Wm9dVcltvv8AMrmJuged5nsLX4alfvKizVafPLAwqnNR6bW25Q+k/S6m
NVNy5+FX2RIJaUaHwGeN7kUcWLhJHcXWGTEWnW32CY6f9Dw/ZXNLg12uzUauPWlP
gPQ2FEbJrODsrjsS3Wrw7gk6cDqukg2D21qz59hf7cSPWLTD80o/a9GES3E0Dnxq
pu4fhq9t9EVnxlGdxq2SUSME6lzBkInl7MJs5ErYHmVW+tLvIbGykOJXVr/ATdPK
hBwvo54IdRX24gXNA1vHkc3BTl9r8bdARwWHJ4q/w+J3dpXYNG9wOfGVZBLifD1C
Pvtc0VhOID9p2kpj7GmbMalDtq/2hFOY8FRRrGtbtbpdW7AfT+4xmokiiV1+wiLT
wkDExY4s0o7NvEna/xie19NmQ8G0aCFK6MNblK8tNZUnT0Opk6U=
=Nxn/
-----END PGP SIGNATURE-----

--gQUFoi2Je1yJ2eU0--
