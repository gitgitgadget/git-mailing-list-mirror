Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A2C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 06:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCTG5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCTG5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 02:57:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3416AE0
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:57:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 244915C00F2;
        Mon, 20 Mar 2023 02:57:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 20 Mar 2023 02:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679295458; x=1679381858; bh=I4
        qdAuu+LTPPj9cBkXKUx8grqxyN8Xe/VQKagpV6XdQ=; b=KNqTBoRoAoxjRg716N
        uhfISUDY2rV/nIxECmWqDYV6TUqPEVo19A2khes9DzYzv6yy0Q5tM2CO7wiRg4X6
        Mp6jpzVAfCI7ul6EfeGDvn4vyP1+ZsBWgNcpcWFxQgtAgn1mhps4SI6yAK6nFD8C
        rrp1aFl6IZaqu62nt8ElbIJaeY8xZG7HXzKXW3QBz/BUpYTftTkY+YDFO8ww9cbU
        3FGu18sMGqZjp3SnbW3PeHyM0ALB2T7D/J7FGn9yAKsFjhzXtUdvCJO8/OJBUSrd
        H5B+z3Xg1RQl9zYjxrxudbAD50atPXa4qTvNc9L7UnUVwebC3ZEJ5N13d3YmLuQR
        4ZQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679295458; x=1679381858; bh=I4qdAuu+LTPPj
        9cBkXKUx8grqxyN8Xe/VQKagpV6XdQ=; b=GnlqJ5Ja4ikCbGPsjbD3sS0TEmzNC
        Yie87pptOUo1arUYlWQQiK/TAG4nRy8/iUhNc+6CEGxb/RofeVn6OujoMLU5btqK
        xxFQmGEeqtuNk2JsCdasmPPVYK3x8eqbuoVHrbXdzz19IMNm5HktZpYB60yS2Ddy
        uVd6UP9JPilSKplCDMS1Zo2mIapOnghK4ao/vTEwokyX5cd6FRVvNTEjBLVCDttL
        Om73Dbg5SYRVnMaDJdTOO4cvPRQJ+p2ZkL5P/qMFRhqXFLxVZTAZwbDESTvGTBKZ
        v76OnllhE6A8zZSUYcfW6dVl7JTvaBHvAzz/h0thEqGsyj1Sj9TCdyIyw==
X-ME-Sender: <xms:4QMYZGW7g3IRh-EYpkbYQ1VEa_t8SYj2sd0I7WY6yRR83ZzZYOSTnA>
    <xme:4QMYZCmkhbuNWfbTEuuaMILNwuhigWof6N3LRrbg-N6wqpgTq0OFJ8eQWBKU5eG-_
    _Kpq92hZVrr8YsPew>
X-ME-Received: <xmr:4QMYZKYTkMQ2OVMXSpPnQrHy39EoFXsuV_J4eYVfhvfdzDDdqEwwpvQanC4E7m1_oa8-9rUMzkb0AHcLPMurYWP9d3Owl2yOh8jzrdi40xNmdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4QMYZNXt6njC4_wrRopENXXkL1aQs82T9Nb0iEUuo14dVKfvKPXAUw>
    <xmx:4QMYZAlmVMDrPu-pCn1ExBm9bsiQODX-SR_96PsZkmsps_0pgyBgRA>
    <xmx:4QMYZCckzhZGpg7gbr9dhDeqkdwVyr6PR2swiyyuuYBNry0fmbhCdg>
    <xmx:4gMYZHu_Eezs-nDo6YtXZu6NDYx34EDC6mBtDCw1pv45debBpNsisQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 02:57:36 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d7c779eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 06:57:02 +0000 (UTC)
Date:   Mon, 20 Mar 2023 07:57:33 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] fetch: refactor code that prints reference updates
Message-ID: <ZBgD3Ux34V/U/Lv5@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <20230317202449.1083635-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Iys3KBu+xlHX5Mt"
Content-Disposition: inline
In-Reply-To: <20230317202449.1083635-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5Iys3KBu+xlHX5Mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2023 at 01:24:49PM -0700, Jonathan Tan wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >     1. We want to take control of the reference updates so that we can
> >        atomically update all or a subset of references that git-fetch
> >        would have updated.
> >=20
> >     2. We want to be able to quarantine objects in a fetch so that we
> >        can e.g. perform consistency checks for them before they land in
> >        the main repository.
>=20
> If you want to do this, something that might be possible is to change
> the RHS of the refspecs to put the refs in a namespace of your choice
> (e.g. ...:refs/<UUID>/...) and then you can look at what's generated and
> process them as you wish.

There's two major problems with this, unfortunately:

- We want to use the machine-parseable format in our repository
  mirroring functionality, where you can easily end up fetching
  thousands or even hundreds of thousands of references. If you need to
  write all of them anew in a first step then you'll end up slower than
  before.

- Repository mirroring is comparatively flexible in what it allows. Most
  importantly, it gives you the opiton to say that divergent references
  should not be updated at all, which translates into an unforced fetch.
  It's even possible to have fetches with mixed forced and unforced
  reference updates. So if we fetched into a separate namespace first,
  we'd now have to reimplement checks for forced updates in Gitaly so
  that we correctly update only those refs that would have been updated
  by Git. We'd also need to manually figure out deleted references.

  This would be quite a risky change and would duplicate a lot of
  knowledge. Furthermore, merging the two sets of references would
  likely be quite expensive performance-wise.

Also, even if we did have a different RHS, it still wouldn't fix the
issue that objects are written into the main object database directly.
Ideally, we'd really only accept changes into the repository once we
have fully verified all of them. Right now it can happen that we refuse
a fetch, but the objects would continue to exist in the repository.

A second motivation for the quarantine directory is so that we can
enumerate all objects that are indeed new. This will eventually be used
to implement more efficient replication of the repository, where we can
theoretically just take all of the fetched objects in the quarantine
object directory and copy it to the replicas of that repository.

[snip]
> >   fetch: deduplicate handling of per-reference format
>=20
> I'm not so sure that this is the correct abstraction. I think that this
> and the last patch might be counterproductive to your stated goal of
> having one more mode of printing the refs, in fact, since when we have
> that new mode, the format would be different but the printing would
> remain (so we should split the format and printing).

I already have the full implementation of the new machine-parseable
format available locally, but didn't want to send it as part of this
patch series yet to avoid it becoming overly large. But I can say that
this change really did make the end goal easier to achieve, due to two
reasons:

- If we continued to handle the per-reference format at the different
  callsites, I'd have to also amend each of the callers when introducing
  the new format as we're going to use a different format there. But
  when doing this in `format_display()`, we really only need to have a
  single switch at the beginning to check whether to use the machine
  parseable format or the other one.

- Currently, all reference updates are printed to stderr. As stderr is
  also used to display errors and the progress bar, this really makes it
  not a good fit for the machine-parseable format. Instead, I decided
  that it would make more sense to print the new format to stdout. And
  by having the printing-logic self-contained we again only have a
  single location we need to change.

I realize though that all of this isn't as well-documented in the commit
messages as it should be, which is also something that Junio complained
about. I'll hopefully do a better job in v2 of this patch series.

> >   fetch: deduplicate logic to print remote URL
>=20
> Makes sense, although I would need to consider only storing the
> raw URL in the struct display_state and processing it when it needs
> to be emitted (haven't checked if this is feasible, though).
>=20
> >   fetch: fix inconsistent summary width for pruned and updated refs
>=20
> This changes the behavior in that the summary width, even when printing
> the summary of pruned refs, is computed based only on the updated refs.
> The summary width might need to remain out of the struct display_state
> for now.

Fair, that's a case I didn't yet consider. I'll have another look.

Patrick

--5Iys3KBu+xlHX5Mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYA9wACgkQVbJhu7ck
PpRXCRAAqIvO8TaamkBaO1li33K/z2gF3ERJb7cz0HQ9mc4mPTIbW1023RpgMRBF
WPa4ANZ5xya3AQSIwXMK5K7MNKh5fDyk+8sEUAGKYfhdSsEqwkbfwCOU7xXGoRVs
oDu8ckKRs74ItEEKk01IhmaU9E1L0xC1zTcYCd3E+/GRnezOa9TLPRCWyTTCsDhF
WULdFtPUqGzdwmP3vHyCfKC41YiTQnk0tGKmJljF+7B8k9Dx/o1ZCFvHCzYSUrsp
0u2QJfeTd5bm9MJiuwulCzMt4XJcthObyq9PlPYYQtcPyYSRJ6p3dUSmqwgrKE+5
eO+FPG6zCTmr1MMISxxrUFxjMxQrQdVsj9pyObt6qDcmDQeCpjH0qP3f6ZjeCdQ5
BeKd458ciLQLZpqr1RAbb58TC7hocDW+PyH/GRMBBhlCdHEIgABRvoCvVfWAdW4p
PmdaF1hTfqR2lEFFjtfpzWkHXLUylS7iduqEr4cNS4sJO45em55CRfzYmZKi7ZPg
qqOzjRD/U4zEpo0DKnJXT15pnB4JlQ+/oJ9ThY4DwGlkhlVJ6ltw/GZtRKdWcSdm
RBHg1zpt0GNAQBRvUkI0Zyy1b1g9gBj9sn0Xcun5BYZ6TGjqiEALsU8Y2xSws12C
4qrjbWrMx0h3VsLXXLpVzWoeYwrtsGuaWD5KVUOy/TZaElaARg0=
=34cY
-----END PGP SIGNATURE-----

--5Iys3KBu+xlHX5Mt--
