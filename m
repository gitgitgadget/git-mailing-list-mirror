Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA7FC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiCBN6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiCBN6G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:58:06 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFDBB7
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:57:23 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 493093200A2A;
        Wed,  2 Mar 2022 08:57:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 02 Mar 2022 08:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=WYcW/tVUrJyivw65ooErZStS2nRNktybsLYhaT
        +ni7Q=; b=hc3fxMDGW9x3x4CQCt8GXqVgPnSE4PaElnILkgkVd2UoGlv6wWON8s
        S6LO/j8P5bbzrNpuAu2nuBslEKbieRn8FmpYqgB5Yi+CDmXgBWbtUvRLFdB0bjEV
        AA+mTDCQcpEyaIlzbdUcQNbLkqAF49fZ+kkK9tY8lutntZ/f4pZcv+OA10/iJDdY
        tBu/qeKey/9YQeNnmlOUSfSYa/cl/Yp0aKR44yIlo+DbWOse94szAFXzW87Jynth
        pul4fdPMoyHhMySZ89gULuJcK6XiAIQJZzBaAHfdEkfgCdA9WCwnqSU01/Fxl6sJ
        OCSzxYDwyMQyijrCmY7ykr+G46j1fyUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WYcW/tVUrJyivw65o
        oErZStS2nRNktybsLYhaT+ni7Q=; b=hZQRj2o2nY6Gqqa+5BRCbxCrl3IxxdN2U
        g+tyPyEuMV133gVYks+uCyzP3+OS8U3e4eudqIPaYOBlj5LKbWOvfazDjTgqlatL
        V56HuUijx4BtEbrQhCbwboo6bZYMFrHevkdee/+rHS0/XDokAehEhF6IiP2Zj1ZD
        e7hMy44qxz2VAr4lswMJEMm0gYSIzB/pzGCh/Vj11Ff2VtAtCEdmHVKd99q8bE3D
        wtZgUe5SaH9vXhh4ZjbCNWEdsBvrJcqENFf80tbuqjf7job9XIT+zHKjAa4aNfNt
        4qZwoL77HfVBI/9WtEyKo+3d8ockoM970keqNe+iNtCjZWy2c/QsA==
X-ME-Sender: <xms:wXcfYmlMN3EXj8S-JPhy3AxzVdLJtI9Ma6gRC4CSQ8eIb2-l39j7PA>
    <xme:wXcfYt3686kxAIFm7YeLSm3pCFtGZjSqVLTbxQMaRN1xkmbZZWH4XmJATXn1jpnXb
    1yYaVDZiORMaqJa_g>
X-ME-Received: <xmr:wXcfYkq2YHHc31wdy7IVTYbsIrG1Vlk2Y2oxbpdUNY9myQu2AF5Y21H3d-GM7GXp-DywZ2Ua7BwozhB4PhL-x6dSaqnO_MBh-GZk5nfiasXFjArL7Tr3BQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejjedtiefggeekgfejheevveejjeevuedvtdeikeffveelgeelhffggfejjeeffeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wXcfYqmFD6dxxxHjRVlEs5GmetiXRn3TBVGlr0YD4pPR8jVZnkSc6g>
    <xmx:wXcfYk2DwRUPZJwU5Jj9S_lV6N3DKndFo3Clq5VJ6OKJn04-lHTPLw>
    <xmx:wXcfYhuyPnF3iNEoC2Ck2I0SebFHLlUJAH2SSXX1hlucj0a19bwhXg>
    <xmx:wXcfYnRz0S9fScqtWSGjICiBwFBmI8KQIeZlRKEHvAPGI_QmRadQFw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Mar 2022 08:57:20 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3371541d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Mar 2022 13:57:17 +0000 (UTC)
Date:   Wed, 2 Mar 2022 14:57:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <Yh93vOkt2DkrGPh2@ncase>
References: <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase>
 <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps>
 <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase>
 <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
 <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hUKd3d7OGK9aaliO"
Content-Disposition: inline
In-Reply-To: <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hUKd3d7OGK9aaliO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 10:25:46AM -0500, Derrick Stolee wrote:
> On 3/1/2022 9:53 AM, Patrick Steinhardt wrote:
> > On Tue, Mar 01, 2022 at 09:06:44AM -0500, Derrick Stolee wrote:
> >> On 3/1/2022 5:35 AM, Patrick Steinhardt wrote:
> >>> On Tue, Mar 01, 2022 at 10:46:14AM +0100, Patrick Steinhardt wrote:
> >>>> On Mon, Feb 28, 2022 at 01:44:01PM -0500, Derrick Stolee wrote:
> >>>>> On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
> >>>>>> On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
> >>>>>>> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
> >>>>>>>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
> ...
> >>> So the question is whether this is a change that needs to be rolled o=
ut
> >>> over multiple releases. First we'd get in the bug fix such that we wr=
ite
> >>> correct commit-graphs, and after this fix has been released we can al=
so
> >>> release the fix that starts to actually parse the generation. This
> >>> ensures there's a grace period during which we can hopefully correct =
the
> >>> data on-disk such that users are not faced with failures.
> >>
> >> You are right that we need to be careful here, but I also think that
> >> previous versions of Git always wrote the correct data. Here is my
> >> thought process:
> >>
> >> 1. To get this bug, we need to have parsed the corrected commit date
> >>    from an existing commit-graph in order to under-count the number
> >>    of overflow values.
> >>
> >> 2. Before this series, Git versions were not parsing the corrected
> >>    commit date, so they recompute the corrected commit date every
> >>    time the commit-graph is written, getting the proper count of
> >>    overflow values.
> >>
> >> For these reasons, data written by previous versions of Git are
> >> correct and can be trusted without a staged release.
> >>
> >> Does this make sense? Or, do you experience a different result when
> >> you build commit-graphs with a released Git version and then when
> >> writing on top with all patches applied?
> >=20
> > Just to verify my understanding: you claim that the bug I was hitting
> > shouldn't be encountered in the wild when the release , but
> > only if one were to write a commit-graph with the intermediate stafe
> > until patch 3/4 of your patch series?
>=20
> That is my claim. And my testing of the repo at [1] has demonstrated
> that it works correctly in these cases.
> =20
> > Hum. I have re-verified, and this indeed seems to play out. So I must've
> > accidentally ran all my testing with the state generated without the
> > final patch which fixes the corruption. I do see lots of the following
> > warnings, but overall I can verify and write the commit-graph just fine:
> >=20
> >     commit-graph generation for commit c80a42de8803e2d77818d0c82f88e748=
d7f9425f is 1623362063 < 1623362139
>=20
> But I'm not able to generate these warnings from either version. I
> tried generating different levels of a split commit-graph, but
> could not reproduce it. If you have reproduction steps using current
> 'master' (or any released Git version) and the four patches here,
> then I would love to get a full understanding of your errors.
>=20
> Thanks,
> -Stolee

I haven't yet been able to reproduce it with publicly available data,
but with the internal references I'm able to evoke the warnings
reliably. It only works when I have two repositories connected via
alternates, when generating the commit-graph in the linked-to repo
first, and then generating the commit-graph in the linking repo.

The following recipe allows me to reproduce, but rely on private data:

    $ git --version
    git version 2.35.1

    # The pool repository is the one we're linked to from the fork.
    $ cd "$pool"
    $ rm -rf objects/info/commit-graph objects/info/commit-graph
    $ git commit-graph write --split

    $ cd "$fork"
    $ rm -rf objects/info/commit-graph objects/info/commit-graph
    $ git commit-graph write --split

    $ git commit-graph verify --no-progress
    $ echo $?
    0

    # This is 715d08a9e51251ad8290b181b6ac3b9e1f9719d7 with your full v2
    # applied on top.
    $ ~/Development/git/bin-wrappers/git --version
    git version 2.35.1.358.g7ede1bea24

    $ ~/Development/git/bin-wrappers/git commit-graph verify --no-progress
    commit-graph generation for commit 06a91bac00ed11128becd48d5ae77eacd8f2=
4c97 is 1623273624 < 1623273710
    commit-graph generation for commit 0ae91029f27238e8f8e109c6bb3907f864dd=
a14f is 1622151146 < 1622151220
    commit-graph generation for commit 0d4582a33d8c8e3eb01adbf564f5e1deeb3b=
56a2 is 1631045222 < 1631045225
    commit-graph generation for commit 0daf8976439d7e0bb9710c5ee63b570580e0=
dc03 is 1620347739 < 1620347789
    commit-graph generation for commit 0e0ee8ffb3fa22cee7d28e21cbd6df264549=
32cf is 1623783297 < 1623783380
    commit-graph generation for commit 0f08ab3de6ec115ea8a956a1996cb9759e64=
0e74 is 1621543278 < 1621543339
    commit-graph generation for commit 133ed0319b5a66ae0c2be76e5a887b880452=
b111 is 1620949864 < 1620949915
    commit-graph generation for commit 1341b3e6c63343ae94a8a473fa057126ddd4=
669a is 1637344364 < 1637344384
    commit-graph generation for commit 15bdfc501c2c9f23e9353bf6e6a5facd9c32=
a07a is 1623348103 < 1623348133
    ...
    $ echo $?
    1

When generating commit-graphs with your patches applied the `verify`
step works alright.

I've also by accident stumbled over the original error again:

    fatal: commit-graph requires overflow generation data but has none

This time it's definitely not caused by generating commit-graphs with an
in-between state of your patch series because the data comes straight
=66rom production with no changes to the commit-graphs performed by
myself. There we're running Git v2.33.1 with a couple of backported
patches (see [1]). While those patches cause us to make more use of the
commit-graph, none modify the way we generate them.

Of note is that the commit-graph contains references to commits which
don't exist in the ODB anymore.

Patrick

[1]: https://gitlab.com/gitlab-org/gitlab-git/-/commits/pks-v2.33.1.gl3

--hUKd3d7OGK9aaliO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIfd7sACgkQVbJhu7ck
PpSsYg/+MjPeuS84E7sQ9KNwAYGNaqu+7POD7UESz3p7bAKeuh8wUt91MGTfTmL/
+KpEfTchbF9T2U3p8wHcGYGfhkm/Oqbe9kAAdlFJ71K2m3dXazzLVQ8a4P7F2jX2
Uuh01Q0uNLIbh5tbCvqQQ4/EHomeFbkbllvj2gB9RF04oC+m5l/Cwr4PQwlQ7jZ3
2mRwScmlR8ew7TTMT3LaGPYmAXJdKIZ8gpm9urNt62NgyXxmhD99scWz5vn12tmj
UnvVS9T7YBmUwg6vEkirgXrnNjilU7jZLdo6ZoTyIdKhUJza1Wv7Dc1nzEM3qS1d
R5TVDgb0FnOu/J75urmq5KjWLwQt74xrzFxihmzYPuTl7l5iT59t9x7gCsEeUvvh
DEk5YpW6IWE/1U+N4LelVtLLvQjEazP5+vsiRQzaBBWpf/Akw4kPh05hGz3SB16e
xnSVhXmlKhsSBSlEVewKdzkfdpPWuEP3iQqR5I33JystrtQbUBq7Cn7rPk4R/rbk
lv5mcQNCh9qFBwcr/xCMtAi477wvQtQl5K3RjD33B4t1OCT0Szt26UZU3qik25No
valhczikQsQIL3YT5OFBy6y7KLInQAGzcUbanzHrNN8AmMX0iXqtljRIdEkliStJ
cLlsdegMDaKSIm2L19rEB0Rp//5LXLV9Z9M0cv2oQyyx3J3tXaY=
=9JS2
-----END PGP SIGNATURE-----

--hUKd3d7OGK9aaliO--
