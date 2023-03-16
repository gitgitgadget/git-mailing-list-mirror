Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91583C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCPPHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCPPGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 11:06:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F7BAD0B
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 08:06:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A9246320077A;
        Thu, 16 Mar 2023 11:06:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 11:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678979208; x=1679065608; bh=d2
        bNTRn4ZiaLgOMTAaAVaPuGnVQTFKjPyuBTFF/J8Q4=; b=DE00qJHPRpxY5N67qN
        8l9IJlk198xRZz5H/HpluFFMQDit8+4qDKZsdgYr5ZqrhdzvERB7k+aRp0gW6L/1
        oFoGkybVLaE53ipuRA+uUEwzSVrcJUjwA3QumafddpICu/xROHLR0KjGtO57kw2h
        bo1uWABhA1NaH0yF9aooEQ8nyrhigJHCUYaOdbluyPcbvM7HF/qv242MvBjs29u6
        Y8uExZMKKRoNl1NJAVdgtrihpx4YATlUIBUwiA2QaNksdrSbeMm4xIIvhl2v7ew+
        HHjmRWffDyyNVSwte/mqD4OWTqO/V9ubRY4/SVvK5yqxoOGZkiqH7Tui1Nfejy1Y
        yFPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678979208; x=1679065608; bh=d2bNTRn4ZiaLg
        OMTAaAVaPuGnVQTFKjPyuBTFF/J8Q4=; b=o4dRKIbi+NfPsvUOY8EAT52F7PEkQ
        6TksvWXzvh33a0/4TFBMVwqqXDuTI6WgG0DPBUE8E4u0lgdXk+VyOjR2mC2jSzcO
        1yksBaQaP+yhlsh1nZ7AdeVMQiNzkScwKsv0kj6k0Y58Dh2sFO2E4+hT8+NPPvUr
        C43FKof/q2r/ra2NXVySqvZM4PemP7RaM+zhfkzB+3WnaagWTBV7RjRHsmsWB7bu
        LNdl+XIIthV/cg6yEvoLD7uxthpbWU1WJinBkNrIxXcQRT3U4q+2qFsgOBABkB74
        0jQXnNbLvuo8Mjpkonv/T4IOV70XBTLaV79iuhC9oABLGtXuFeDObCUaw==
X-ME-Sender: <xms:iDATZGPK59tjNV_ISAUVMnPQ4rrKQSbcdigtHv7trlN5HF2IdBAzUA>
    <xme:iDATZE86wJZywLha-J8LZyYJPk1PhSXmu9_Iyo28NiBiE8slMnRbHgM0HNeU9m8A6
    f7x-i80jb4pVe63ZQ>
X-ME-Received: <xmr:iDATZNQlcB7FHmyhzUIclRlJvuMsuJw9UWPTi08joF205OmhWM5myb-bbDEZAhnE-oLb5-u5Ym6u9zglEEVeeHqTrgiXeFBkMB9GQTTspjV65fC->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iDATZGv_D7QO4j52Sibk2TZtyW3GuqvjLR-X3-GISUlSuODF85iFlA>
    <xmx:iDATZOemMYecOkYHtfMtAVc-7Ez56vcwZLs5LpMGoj_XOzK9d3w7DA>
    <xmx:iDATZK028tvedamRMIgmnQ3ke0P4syrTNiiZdG5xToQzvuOEu1e5Dw>
    <xmx:iDATZGmp5N8W95XjX5AM8rdX_ra-pwLS8o0lsG0xF2aW3QcACTmT2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 11:06:47 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5ae12171 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 16 Mar 2023 15:06:21 +0000 (UTC)
Date:   Thu, 16 Mar 2023 16:06:44 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/8] fetch: fix inconsistent summary width for pruned and
 updated refs
Message-ID: <ZBMwhLgGeUhtd5Zb@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <f67f9640a853b605dd1bc4be25e9988c4f059684.1678878623.git.ps@pks.im>
 <xmqqttylmww4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9V2unSEwLljJ/4wU"
Content-Disposition: inline
In-Reply-To: <xmqqttylmww4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9V2unSEwLljJ/4wU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 04:12:59PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > As the abbreviated hashes may have different lengths in order to be
> > unique we thus need to precompute the width of the summary's column by
> > iterating through all the objects. This is done in two locations: once
> > to compute the width for references that are to be pruned, and once for
> > all the other references. Consequentially, it can happen that the width
> > as calculated for these sets of references is different.
>=20
> Hmph.  Use of ref_map vs stale_refs as the parameter to call
> transport_summary_width() is to come up with an appropriate width
> for showing the list of stored refs vs the list of pruned refs, so
> from that point of view, an appropriate width for each list is
> calculated to a different number may even be a feature, no?

I'd say it's not. Look at the following output generated by a `git fetch
--prune --no-progress` with a deleted and an updated reference:

    From /tmp/repo
     - [deleted]         (none)     -> origin/to-be-deleted
       82307bb..107b50a  main       -> origin/main

Before my change, the width of the deletion and the reference update are
calculated separately. Given that:

    - we don't even display the object IDs for deleted references

    - the width of the deleted reference's column is static anyway.

I'd argue that it's not a feature that the widths are computed
separately. If it was, you could just skip calculating the width of
deleted references and just print them with a static column width.

The current implementation tends to work in most cases as the column
width is based on the minimum length where all abbreviated object IDs
become unique. And I assume that it's the same for both sets of refs in
the majority of cases. And in the other cases I guess that nobody cares
much anyway.

Practically speaking we could go even further than the current version,
as I now compute the width across _all_ reference updates, even those
which are deletions. But theoretically speaking, we could just skip over
any deletions completely as they won't ever contribute to the column
width anyway.

> I do not mind either way all that much, but a change like this to
> update the presentation may want to be protected with a test from
> future breakages.

Fair, having a test for this would be great. But what kept me from
adding one here is that the column width depends on the length of the
longest shared prefix of two object IDs that are about to be updated.
And I just have no clue how to generate those without brute forcing them
for both SHA1 and SHA256.

Do we have any mechanism for this?

Patrick

--9V2unSEwLljJ/4wU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQTMIMACgkQVbJhu7ck
PpTKYg//dViI65/A2Bb+jEdSjQezqm2bBwY4WDdsixEe2NjHi6268W0MoTc+qVWN
KpqJphUSP0VabagmJ95Gvr+0n9Nypk+VRYpMIOXIsq7CLafgrJfBqDSvARVZ2lqc
T7RQ1U85Vh3rKtcunKMUE8cuUY9jCtPGjX5CQ2OebcYSKiJOH0wyZqURQPKaRhHI
hPAhm3xERwFmezTvMegX9xwb9EwpzhM2jWDsoBRLmXfxvW+jQsSwzy6nG7lj3vgg
hRmiGsPu/OOFthiZWwNgrhN27efme4029QJ/8REP/Ff5pQ3GxaIHaDbQLiE/mUzS
w5Ee1g+vsgfAIvf/4B60i/y9EX+jwSxdrHFTy1/8Ley/U8mNjXFwNEvNJxQFBlMf
z+fgfa7JqDMHJd04QB0/96RVlCH4BhTUyPhmat/I/h1gQ0EMEp/tvy4mZPrdVshp
wYltubxOLTfDyTGwAV3jN7y4EdgqtqDSpYTM5IqGyRqRJeHzMb0sEYYXL0q0dbV8
/shWoMEWg8DOmcME0peJe32VHLgT8/XsdNjH3BwykJWbaAS/Es7nHUoJl5uKs7gd
L1/vbB8VsArbcDHoo+dSvINs64bbwxKfGcJoYxxYMP4/A4Alsgm4oJn38RmUgSjk
pZqG5rliYR1LXR/P5i1Bv114KAMhlcW5EijjnHyL3457YO9JmOc=
=8Xdp
-----END PGP SIGNATURE-----

--9V2unSEwLljJ/4wU--
