Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC8C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjEKLGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjEKLGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 07:06:00 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D5FA
        for <git@vger.kernel.org>; Thu, 11 May 2023 04:05:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1EBA5320077A;
        Thu, 11 May 2023 07:05:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 May 2023 07:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683803154; x=1683889554; bh=3C
        07qItPHmNItep3ufULtKr4aOYtZK7TeovO/2ZWD2o=; b=Vp4VwNVEEduUrvcNJE
        0qMCmMRXcd0MXvWDCaUjKI4DPs4XwFkL3iJ6wpsdVW79Q7cRHZRqgv6rzeEA1lot
        x8N2rFYpTT4r0LDh2056pt344dCRgTupaIIFhfoozP/TkvetY/CU8gkjdpAmay3N
        F7hAmnI/rD/403u7DLudkjlo2WUlS3+oIrFQUGUlAZ/oThFzlIiB1n4nmEp0Wuzm
        Mgk+eu9kwZNxuyKUhBsa6fI2a5VP3aaL9LqQiTzh/CvTsbnfu+OB+JVrM82jgnxs
        GEzh86rC6fcL+QWWqXe4uj39yFwIYjVXM2IvE13GAKxSm5t5wWKkUTAKE/VWjUCW
        I3Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683803154; x=1683889554; bh=3C07qItPHmNIt
        ep3ufULtKr4aOYtZK7TeovO/2ZWD2o=; b=Trj7L3zOvTkplxt+sDHPzLfxs2tAS
        L/XWJPTLNNrIM3ofrNhJMMTptwfOM+IZ2NBYXN1Bu/UlrtRHlkE9cwfyvORz1o17
        5S9DjEwLD9NeVj3y3DKLuiHtoiGfMRTVuPVqTY9gyaZlHpAUBapkiXnS/WXQpUkf
        ivqGNdANSKb20c1OtTbobpXLpsKCGm25YVU9cwWm9GcXqHuTB5BruRwHQQZp2GRJ
        P8XM0/gHhLz9HI2SCR97NxSFR/w9BD77QOso80CeL2ZiJA56Z7OImMLgqGtdKM5A
        LXDXzPrBvFTy78V7LBcR1LIpUIBhOu5Cw3HzuFhF6NmX7cpFfLJM6ni9w==
X-ME-Sender: <xms:EsxcZJGxNWwM_eGUyYuLzPsKpYXGkx7CKJ21r5oDFl5i7I5p0OkwlQ>
    <xme:EsxcZOX8Bgj4kHLsns6puFo1YRZQTBR38Y3jaAPR712hl4dsy7x3LvEV4ubQW63fs
    f8IvS6e4II38lZXTg>
X-ME-Received: <xmr:EsxcZLLDq2L0M4u8X_7lyvPfIsf6Exsz8Q8u86nYvLz2VfPHLYhvr7njZEJNiSx4MJsk4JZmIMO3vv0rLgRKQLM_6HIrj8rshmpZgMYi_Ldv1kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EsxcZPGq710cfC9qSvWbFpD3BsuZCXFd3VdnV1KRFW0tJt2rJ-Wh6Q>
    <xmx:EsxcZPUSECNHFOM7v-dvvC6RsiFPp-yxWCdv64KNceb3hg9HbqxFJw>
    <xmx:EsxcZKPMos8LK9Dh4e83QPPflWLpw1qyc7Y7pznUw87CQASWkxcQEQ>
    <xmx:EsxcZFyE0wh53lsdXLKLOJLj7ClW8_2qBoUZ2Rc5mCQkWjSzLB0fWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 07:05:52 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e5c47bbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 May 2023 11:05:39 +0000 (UTC)
Date:   Thu, 11 May 2023 13:05:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 0/9] fetch: introduce machine-parseable output
Message-ID: <ZFzMDCK8rprq6qUs@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
 <xmqqwn1g3vvk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rf0+lhspH3HjE1te"
Content-Disposition: inline
In-Reply-To: <xmqqwn1g3vvk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rf0+lhspH3HjE1te
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 11:05:19AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> >     - Patch 4/9: Reformulated the commit message to treat the missing
> >       left-hand side of displayed references as an inconsistency instead
> >       of a bug. I've also added a testcase to verify that direct OID
> >       fetches continue to work as expected.
>=20
> Again, the direct OID fetch is a good thing to test here.  I noticed
> that the test added here insists that the standard output stream is
> empty when the command errors out, which is not consistent with [3/9]
> above.

I think you misread the test: yes, we do test stdout and stderr
separately and in many cases assert that stdout is in fact empty. But
none of the added tests are about failing commands. So given that:

    - The added tests explicitly are about verifying the output format.

    - The distinction between stdout and stderr matters.

    - The distinction matters even more with the addition of
      `--porcelain`.

I think that explicitly verifing both output streams is the correct
thing to do.

> >     - Patch 9/9: The `--porcelain` option is now a simple `OPT_BOOL()`
> >       that can be negated. Added a test that `--no-porcelain` works as
> >       expected.
>=20
> OK, this time the familiar "prepare a variable to its default, let
> config callback to overwrite it by reading configuration variables,
> and then let the command line option override it" is used and the
> result easy to follow.  I do not think .display_format is never
> assigned DISPLAY_FORMAT_UNKNOWN with this change, so [6/9] could
> lose the value from the enum, I think.  The defensive switch
> statement that has BUG() to notice an erroneous caller that pass
> values other than DISPLAY_FORMAT_{FULL,COMPACT} is still a good
> idea.

Ah, right, `DISPLAY_FORMAT_UNKNOWN` isn't really needed anymore. I think
it's still good to have valid values of the enum start with `1` so that
it becomes easier to detect cases where we accidentally use a default
initialized variable. But that can be achieved without giving the
default value an explicit name.

I'll refrain from sending a new version just to remove this constant as
it doesn't really feel worth it, though. But please, let me know in case
you disagree and I'll send an updated version.

Thanks
Patrick

--rf0+lhspH3HjE1te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRczAsACgkQVbJhu7ck
PpR7zg/3WE2aI3Yj8RHhXEaqK0z5ukqMOtwYW89r6SBfdnlbpjOkZp7oFnscsZBC
mBraxIp/c1bJ0Dlu9VWP944MzgZvLyk23FUEf8fMXm/R3ehydSwoQYympOvqqt6/
LWXek64D0va5ZsUwt/g1ykeV9AVEodmeIFIUxCVsnVzQAqwqhGZ+po+2I5/43lln
AkecD3CBciNYVJJss8vCbetan8VBSp9noulu4D/CLjdimF7rRi2MBngTQ5uh/JYo
bragfMxc5hYYBz3ZyhceMoALndK4Lj062kRW6zwJN14ow8RugzGrXKbz1bLxjaco
gIWBPuWn+fE7acn1SgUcMstli/eokybeb99g5mS67iI+RS2SZsADJTgm6ex2mAg2
QDgFTUEheWVGMXP3v94nasnjrGyydqqaMYr5IQo5kDsB8NY5yfz3r6xwN5phBWRY
5aXJWt0/rDioqHPq0kQ9eyfGyh22bFzdyZQWIe76RQOyxQhKX/xtAoNlcwomNJL2
j5Cf3wiuqZUaAvVwiy9VBBzvvkObxppnqp9XnUko27BFquto7r0P0qIdV3OaZJOr
phfgqNQq9q8NUkOkImubuXtPMa6xmgMn5QQt0wMugr76ufBzpt2tSpLozPtYZ/4o
fy8cbQA9XfExgwA6XCjJHJJu0ArwGjww4Bf2AVnwFatTUnMnXg==
=re2Q
-----END PGP SIGNATURE-----

--rf0+lhspH3HjE1te--
