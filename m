Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69AEC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbiCJOAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiCJOAD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:00:03 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBC12E772
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:59:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 405065C02FE;
        Thu, 10 Mar 2022 08:59:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Mar 2022 08:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=AbL3csZMC80iTzDtY7KlxloVeinJS4J/WMggFW
        D6NGQ=; b=Mum3CnGnP2+XJT42lsrHSVh3mJ1m+SOjGBAo03DH8vN5emo++zzaMh
        Cpyr9LKgSYWZDe/PuMXdxMyfInlm7RJLwe5A15VWEsO8Bl0XMEGyVLAucWzpbQgY
        FsEj9gDRWZ3qiFeB2jMrrnVD25BcKhW6mrRA75+QNJyWTrgYUKLT0GjDwGwr3sc8
        cB/Kct8tLWc+YXK/5NlhTXPetxb2yIUr2JEmNjXr7Cnkh8HqLapH9r4q7BtZxMFr
        tSEcrt6kfYyPLmHAU9mAVl1md+Kc9kyW5PVvqwVX+bJyRWDmuvn/YGOBlQXwPpC1
        q8rjtFhK8/IhFOguT4okUYZcjH/xs1Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AbL3csZMC80iTzDtY
        7KlxloVeinJS4J/WMggFWD6NGQ=; b=boe+tHzWrMPWHB50NSfYy2+YigV0fnNZY
        vku0SSl5Ma5NAS0yL3cnDNUGSBtJvwj/1ioohC8Kwao2ErxzdFsFOLVWm2Wi91yg
        r0RSuE61iavEwMN0P5geIAiPXfKIxxm2qPbKdHaG2gmjt2DWiVNaexagp9dh52w/
        Yrf/0g5Fnxn8NX6yk+YfY6ktnyHKunXc6Ke2P4fSru9Tc8pTol80Oy8Y9qMkQqxO
        MW74/fmWNtKSUbUaeXDC0CF30YjjUvxkNDiq4hSSh522WKE8+kbDhPeNriCAp4t8
        sslcvhynK63VNMmDYlB65WGi5gLckL/h/e5AlWVAPz2t/ZMTmO5zg==
X-ME-Sender: <xms:IwQqYlR9Cwu7Cd-ob6SunacltpZrn_6ryD0dyDUT96MT27OiurtNjA>
    <xme:IwQqYuzw4693pU6Dc3SbCVVgIM80_IxKRLO8BGucRp7e1HL0T2BlyCiPiNlEdXoUv
    TmdDpcxFQlhhGR8EA>
X-ME-Received: <xmr:IwQqYq30cWcehm2UKED4PDZYaqf2tvuVRnGESEhPt_FVxLjSJjynTJ0Bj9y8PXdN-EQvSHXcSZREwlkm2UfTZw-nt1Xpwu9-D8616UV76AIyxWXOfHjC91gDlA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:JAQqYtAHuEdkL2JLa5e9sLg82aZIVD4d5UDW6Lg8hDB_i2JHOUncKg>
    <xmx:JAQqYuj3Y7AY_HIKX1Zcn-JJ5S4TgSHhEO_RzyNWlQsE0coCESgr9A>
    <xmx:JAQqYhqaESagx557lBnVvMtpMNYjIvXgtvusGA_QBG5kXyjdgFYc0A>
    <xmx:JAQqYmfUdpljTY7Jx6Vq_gi6iwb-dMrrIwRNT-scBiQvxt-F_H-RWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 08:58:58 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 72ba10c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Mar 2022 13:58:54 +0000 (UTC)
Date:   Thu, 10 Mar 2022 14:58:53 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <YioEHVo3GnzBl3rW@ncase>
References: <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
 <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
 <Yh93vOkt2DkrGPh2@ncase>
 <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
 <YiCkRLFxn8Pok7Kc@ncase>
 <33deae83-1afd-1645-82f3-5af14f14094d@github.com>
 <06ea3190-32d0-c792-0ae9-c5600305f158@github.com>
 <YiXfnsbGzPXffdgV@ncase>
 <94ed6a1e-327c-3f94-b98b-db019a6f5ada@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Eq2x3T7PrsJzz5gk"
Content-Disposition: inline
In-Reply-To: <94ed6a1e-327c-3f94-b98b-db019a6f5ada@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Eq2x3T7PrsJzz5gk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2022 at 08:45:07AM -0500, Derrick Stolee wrote:
> On 3/7/2022 5:34 AM, Patrick Steinhardt wrote:
> > On Fri, Mar 04, 2022 at 09:03:15AM -0500, Derrick Stolee wrote:
> >> On 3/3/2022 11:00 AM, Derrick Stolee wrote:
> ...
> >>> I will continue investigating and try to reproduce with this
> >>> additional constraint of working across an alternate.
> >>
> >> My attempts to reproduce this across an alternate have failed. I
> >> tried running the following test against Git without these patches,
> >> then verify with the newer version of Git. (I also have generated
> >> a few new layers on top with these patches, and they correctly drop
> >> the GDA2 and GDO2 chunks when the lower layers "don't have gen v2".)
> >>
> >>
> >> test_description=3D'commit-graph with offsets across alternates'
> >> . ./test-lib.sh
> >>
> >> if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64=
BIT
> >> then
> >> 	skip_all=3D'skipping 64-bit timestamp tests'
> >> 	test_done
> >> fi
> >>
> >>
> >> UNIX_EPOCH_ZERO=3D"@0 +0000"
> >> FUTURE_DATE=3D"@4147483646 +0000"
> >>
> >> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0
> >>
> >> test_expect_success 'generate alternate split commit-graph' '
> >> 	git init alternate &&
> >> 	(
> >> 		cd alternate &&
> >> 		test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
> >> 		test_commit --date "$FUTURE_DATE" 2 &&
> >> 		git commit-graph write --reachable &&
> >> 		test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
> >> 		test_commit --date "$FUTURE_DATE" 4 &&
> >> 		git commit-graph write --reachable --split=3Dno-merge
> >> 	) &&
> >> 	git clone --shared alternate fork &&
> >> 	(
> >> 		cd fork &&
> >> 		test_commit --date "$UNIX_EPOCH_ZERO" 5 &&
> >> 		test_commit --date "$FUTURE_DATE" 6 &&
> >> 		git commit-graph write --reachable --split=3Dno-merge &&
> >> 		test_commit --date "$UNIX_EPOCH_ZERO" 7 &&
> >> 		test_commit --date "$FUTURE_DATE" 8 &&
> >> 		git commit-graph write --reachable --split=3Dno-merge
> >> 	)
> >> '
> >>
> >> test_done
> >>
> >>
> >> My testing after running this with -d allows me to reliably see these
> >> layers being created with GDAT and GDOV chunks. Running the 'git
> >> commit-graph verify' command with the new code does not show those
> >> errors, even after adding commits and another layer to the split
> >> commit-graph.
> >>
> >> I look forward to any additional insights you might have here.
> >=20
> > I don't really know why, but now I've become unable to reproduce it
> > again. I think we should just go with your patch 5/4 on top -- it does
> > fix the most important issue, which is the `die()` I saw on almost all
> > commands. The second part about the warnings I'm just not sure about,
> > but I don't think it should stop this patch series given my own
> > uncertainty.
>=20
> Thanks for following up. I agree that with 5/4 we should be safe.
>=20
> I'll remain available to quickly respond if anything else surprising
> comes up in this area.
>=20
> Thanks!
> -Stolee

There is another surprise I hit today in the context of generation
numbers. In production, I found the following bug:

    signal: aborted (core dumped): BUG: chunk-format.c:88: expected to writ=
e 8 bytes to chunk 47444f56, but wrote 168304 instead

47444f56 is the GENERATION_DATA_OVERFLOW chunk ID, and seemingly the
precomputed size we intended to write was mismatching the data we have
actually been writing to disk. And I think this stems from a mismatch in
how we precompute the number of generation data overflows compared to
how we're actually writing the data to disk:

    - We precompute how many generation number overflows there are in
      `compute_generation_numbers()`. Here we only increment the number
      of overflows in case all parents of a given commit have a non-zero
      generation number and if the generation is bigger than OFFSET_MAX.
      Seemingly we have found only a single commit which matches this
      criteria because we pass `sizeof(timestamp_t) * overflows` as
      expected size, and `sizeof(timestamp_t) =3D=3D 8`.

    - On the other hand, when we write generation numbers to disk in
      `write_graph_chunk_generation_data_overflow()`, we always write a
      chunk in case its offset is bigger than OFFSET_MAX. So we don't
      care about the parents here, and this seems to extend the number
      of commits which match this criteria to 21038 commits we write
      into the file.

The result is that the sanity check we do where we compare that the
actually written amount of data matches what we expect fails because of
the different ways we count this data.

This time I don't have access to the repository myself, I only tried to
combine what's happening based on the bug message and the code.

Patrick

--Eq2x3T7PrsJzz5gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIqBBwACgkQVbJhu7ck
PpQxGA/8DbVTZ5o34C6q2/HiBIsR8/iD8n3OwWOFulpj7C+GHhtuOLhOuxIHvLwE
kHi+QfS9evIR9AM/y5mNGFP2HMASHMfmDVXcXX19kpEXqFOwyboDuujBYt2Nj3bn
YScN53Bz5Go5Yid1qKnarNsaleycTudkfPk13T6GIO52eifsWPBTSSKUQlEqadNY
2e+kWXy9mx1fvlUSRlvXbhO8uiHPi7lvNNodYbMJPHO7oYRBaxGDWtxQ8FokK6W9
tpi3sFvT4ZhjVqnv5IqAgYBPA3KnWyHmzJA1zEeqc8vImpggwSwTZ7A+Joy+4M94
94p3/f1WuqasQpDT0JoM7DK44Pf9ZLRESmN3i6uvVXnIGuLXBsdsLHpGLcjDIWnT
oBeozBozu2a9S6mqM2kqn3Iun3oua0hgI3gVTJP6ANyj1JUONSUlHhWg/pHc7p1d
p5fnkOiMdaDTGLDa/3J5zAe+zYZeQLBTKMo5frxsYBqRCCH00DVbBq66/jZbA24R
xTw4Z3WiZMb+V/DmOzuBPXkANOL2oPk7az20gYxDPSFFbaxGf+oVS4mSR4GyVFGR
/8j8hVpGbeVIm8xYy+n71IVuVQqOIeFtHQ/j7bbpQNioaT1YzNODKv2hjSWjIKxi
ofPsIAPmFGEwcpgv3FwkuWKdCdMrII6uX0Om4nZGPJ7yG4Li5k8=
=Dpt3
-----END PGP SIGNATURE-----

--Eq2x3T7PrsJzz5gk--
