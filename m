Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4DC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiKGIUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 03:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGIUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 03:20:18 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9BBCD
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 00:20:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 71F915C00D2;
        Mon,  7 Nov 2022 03:20:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 03:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667809214; x=1667895614; bh=L2GRjIKGWI
        DzKTxnMwWp+CvRna+KvosYGI8OWdsCPMM=; b=ssUS00aRqQ/6FuvzlQlUkga7cZ
        YYqF0kf4ulVvNei912FkXmPAkgAsjEcTP9+HplJ4wQwKEITNQK7qVrHrBhPMUIBw
        Llj4dvUUSCDabNAzpNLRvUCutgS3D9l66P7naXA+1KzmMwFWeVmqUdPcXe9Xcexu
        AklGSF+WSiRXNe+TWq8jpALRZdOpD7w5cCQfEyxA3atSabZh3f/7wlrL1jWjPJtp
        6uYAJqEx7Ed1zG4serp0KQYpwcpVBY3YslX9OmLlgAJQd5I6a9JmkI/unbapwCgM
        P3eOEstr0vmW0i0clZFHbPJFCGUDtCwg7K8uy8mLJwH0wnCk5rWHT+kG+NXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667809214; x=1667895614; bh=L2GRjIKGWIDzKTxnMwWp+CvRna+K
        vosYGI8OWdsCPMM=; b=qNUgI/QvwnY+oKyP8Jmg7/gvkHg9dpo++lb8EjnIjH/Y
        Kk4OxmBl/RJN7U7CEaMAHL9jxeV6GZsbVE3AObwiOExA/8mxlz/P3YSzW2malsQh
        eN98r6BX09qN5105mpbYFS9AhQd4WbFcNGnLEp5kXULUOX3Y3yRcZYtkaleP6xL4
        nk+zHAUcy3XZvPIhwz/f+ns2pYXMuEfs8gcYCzx5tJotNqHC7Q6vZUlElkTEbuNv
        YPJFslICUkjiUF7AuRc5pj98HclPV1XOb9IeNLqZ9MqyoicysWgjgJbjnhF4Jr3P
        /DI2e8RFUdKEiYZ20MljT3JwhH5oa6PbfmznGlSXmQ==
X-ME-Sender: <xms:vr9oY_69T5j75rT7g76GD45Ld-CM90e8iSipCSHhgBJoQ5_Jebq75g>
    <xme:vr9oY041xDB3BQd92YUAQ_60etKpRag3iF4-q3IfWXPqvcp6DYscTVWMJihh0UzFe
    OOASHGGK0BYN2KN4w>
X-ME-Received: <xmr:vr9oY2cet8pvo_R06uSSS2UXAvRB54OzImxfZgfA9yXeW8ZUIgF4uvzdGFT-qdbsLvavauadNdfQDjCKlpcROo8cqdd2b7anmrt69cfCRCPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetjeevffeuudehtedthefhtdelvdehud
    egvdeihffhjeejfeejffehfeeigfdutdenucffohhmrghinhephhhiuggvrhgvfhhsrdhi
    nhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:vr9oYwLoH3OzTFmLI7wJmMpNP-o3uA9AFGEZBKuEBRbJ7KCpoKDAQg>
    <xmx:vr9oYzJZI4kI3h3c9HN20pfjQzfs7tYh6eMkBCqVP7i8Gxmhy5Xwqw>
    <xmx:vr9oY5yCLj1cINten3yxJkYaXMPbrkeV9wWucXl64JU6SQmzuOGcrg>
    <xmx:vr9oY70fUnA3Yrs5UGq5L4YVDLeEVOQUonU_bAQjRL8_aJQpJNqoLg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 03:20:13 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 57753794 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 08:20:07 +0000 (UTC)
Date:   Mon, 7 Nov 2022 09:20:08 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/3] revision: add new parameter to specify all
 visible refs
Message-ID: <Y2i/uJPm5KxqAdkE@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
 <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
 <Y2ZbDXYb1jGqSfTj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P/exz68XPo8UGTJe"
Content-Disposition: inline
In-Reply-To: <Y2ZbDXYb1jGqSfTj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P/exz68XPo8UGTJe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 05, 2022 at 08:46:05AM -0400, Jeff King wrote:
> On Thu, Nov 03, 2022 at 03:37:32PM +0100, Patrick Steinhardt wrote:
>=20
> > Users can optionally hide refs from remote users in git-upload-pack(1),
> > git-receive-pack(1) and others via the `transfer.hideRefs`, but there is
> > not an easy way to obtain the list of all visible or hidden refs right
> > now. We'll require just that though for a performance improvement in our
> > connectivity check.
> >=20
> > Add a new pseudo-ref `--visible-refs=3D` that pretends as if all refs h=
ave
> > been added to the command line that are not hidden. The pseudo-ref
> > requiers either one of "transfer", "uploadpack" or "receive" as argument
> > to pay attention to `transfer.hideRefs`, `uploadpack.hideRefs` or
> > `receive.hideRefs`, respectively.
>=20
> Thanks for re-working this. I think it's a sensible path forward for the
> problem you're facing.
>=20
> There were two parts of the implementation that surprised me a bit.
> These might just be nits, but because this is a new user-facing plumbing
> option that will be hard to change later, we should make sure it fits in
> with the adjacent features.
>=20
> The two things I saw were:
>=20
>   1. The mutual-exclusion selection between "transfer", "uploadpack",
>      and "receive" is not how those options work in their respective
>      programs. The "transfer.hideRefs" variable is respected for either
>      program. So whichever program you are running, it will always look
>      at both "transfer" and itself ("uploadpack" or "receive"). Another
>      way to think of it is that the "section" argument to
>      parse_hide_refs_config() is not a config section so much as a
>      profile. And the profiles are:
>=20
>        - uploadpack: respect transfer.hideRefs and uploadpack.hideRefs
>        - receive: respect transfer.hideRefs and receive.hideRefs
>=20
>      So it does not make sense to ask for "transfer" as a section; each
>      of the modes is already looking at transfer.hideRefs.
>=20
>      In theory if this option was "look just at $section.hideRefs", it
>      could be more flexible to separate out the two. But that makes it
>      more of a pain to use (for normal use, you have to specify both
>      "transfer" and "receive"). And that is not what your patch
>      implements anyway; because it relies on parse_hide_refs_config(),
>      it is always adding in "transfer" under the hood (which is why your
>      final patch is correct to just say "--visible-refs=3Dreceive" without
>      specifying "transfer" as well).

Yup, I'm aware of this. And as you say, the current implementation
already handles this alright for both `receive` and `uploadpack` as we
rely on `parse_hide_refs_config()`, which knows to look at both
`transfer.hideRefs` and `$section.hideRefs`. But I don't see a reason
why we shouldn't allow users to ask "What is the set of hidden refs that
are shared by `uploadpack` and `receive`?", which is exactly what
`--visible-refs=3Dtransfer` does.

The implementation is not really explicit about this as we cheat a
little bit here by passing "transfer" as a section to the parsing
function. So what it does right now is to basically check for the same
section twice, once via the hard-coded "transfer.hideRefs" and once for
the "$section.hideRefs" with `section =3D=3D "transfer"`. But I didn't see
much of a point in making this more explicit.

I might update the commit message and/or documentation though to point
this out.

>   2. Your "--visible-refs" implies "--all", because it's really "all
>      refs minus the hidden ones". That's convenient for the intended
>      caller, but not as flexible as it could be. If it were instead
>      treated the way "--exclude" is, as a modifier for the next
>      iteration option, then you do a few extra things:
>=20
>        a. Combine multiple exclusions in a single iteration:
>=20
>             git rev-list --exclude-hidden=3Dreceive \
> 	                 --exclude-hidden=3Dupload \
> 			 --all
>=20
>           That excludes both types in a single iteration. Whereas if you
> 	  did:
>=20
> 	    git rev-list --visible-refs=3Dreceive \
> 	                 --visible-refs=3Dupload
>=20
> 	  that will do _two_ iterations, and end up with the union of
> 	  the sets. Equivalent to:
>=20
> 	    git rev-list --exclude-hidden=3Dreceive --all \
> 	                 --exclude-hidden=3Dupload  --all
>=20
>        b. Do exclusions on smaller sets than --all:
>=20
>             git rev-list --exclude-hidden=3Dreceive \
> 	                 --branches
>=20
> 	  which would show just the branches that we'd advertise.
>=20
>      Now I don't have a particular use case for either of those things.
>      But they're plausible things to want in the long run, and they fit
>      in nicely with the existing ref-selection scheme of rev-list. They
>      do make your call from check_connected() slightly longer, but it is
>      pretty negligible. It's "--exclude-hidden=3Dreceive --all" instead of
>      "--visible-refs=3Dhidden".

Fair enough. I guess that the usecase where you e.g. only hide a subset
of branches via `hideRefs` is going to be rare, so in most cases you
don't gain much by modelling this so that you can `--exclude-hidden
--branches`. But as you rightfully point out, modelling it that way fits
neatly with the existing `--exclude` switch and is overall more
flexible. So there's not much of a reason to not do so.

I'll send a v3 and include your suggestion, thanks.

Patrick

--P/exz68XPo8UGTJe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNov7cACgkQVbJhu7ck
PpQRJQ/9F9DryCUWnl+ac8tak2UBnh/89P9SIvKCPgXEWwZNVHYvOSIe6H4UjqRH
GmYS82u3TYwSUMNFMK7cNjomFAVn0ciR4BBC/sqXJKHjATL5/U4DOWGJ5MGpbEV3
ky/acF1jJzQ7S45Gz6ljM4FGji1iWPe8sO23D3XOG+vsSDy9lFHecWi3NqZMFXsR
etc8WdlY3MX7W7iVBb7IeLRXdk1btXs4roXeijh8soyKQZo35ZpQ54mM0DQWFfK1
wkl2ob+oq+AnKjeYNNhT/+hlZRNTZ6FS1HEFfQTWKfZNIXi03ZfnivN+IH4V06oN
NjXnPYWyPbSpIkrOr89yzYRWGpF0Pm2NtGq/NYLgZFhQR7x57irqPIM5Eg96rIyo
hGhpPgTXLmXTQtDgDu0P9g3E2/rpFEL7V6f9jFAsUGClEtMHAwBT3dN6ugzVLK6F
59RkQm7AHDq7KJKzrQSvs4s8PjEsZZUC4CTZCw+DfMm2CbdjTVQjzIqwIUuRZC72
srS9CNlI6/QsdQVTBB0VfJBiqhS+k7xDzLvkdyLZPQ8w8+0JwHkLFMlHGfkHBzlc
T/zBrAtTZL7FCYj4HDuwPXZllanXyyMSHkZfOurRj31H695hyyofyzp8hw9RbY55
T7tdlw3KsfitZopqz1Zf0wpoGJfZGwwphAyW2/AzUZoxPqJHLD0=
=6KuR
-----END PGP SIGNATURE-----

--P/exz68XPo8UGTJe--
