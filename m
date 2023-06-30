Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64677EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 11:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjF3Lig (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjF3Lie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 07:38:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5258270E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 04:38:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D60345C0FFF;
        Fri, 30 Jun 2023 07:38:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 30 Jun 2023 07:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688125097; x=1688211497; bh=Cf
        X6lFZaHKRBEdH6YFbhU9wRHjxANFcy6tVGZRWDjaQ=; b=hGnLpElLU8D6aYbfbp
        nX577npKLjVHKk2JGsiNecgDjamSAGvFui6GgPh53S0XU8ybnX/ilC6lj9MzQMDA
        +OqL2y2dIbOIRvfSiYY4/Af3b07Ob8/isDiP1F/NCbmQRBz3JGRYjVcYBBKDo0aK
        ZJEUfsAJIi5UsJs01yhdmVQ6LRq3+f8r1YLm9YN28sNaKgEG/SjsQ6NPRWn2OxSd
        vrpwq9jPiBI7pYGu61pNZXK03CrMGCWGBfo6B5G8yelPNZR1e+ZXKXnthRVg+r6M
        IJGGxMfvnmcIXoF7jIe2Q5CX70YEcMPSqNYEaIocP0poytvphXC3dfAOyp1HwahT
        8CGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688125097; x=1688211497; bh=CfX6lFZaHKRBE
        dH6YFbhU9wRHjxANFcy6tVGZRWDjaQ=; b=Ox+K0hJ29945tF5AqZ2uM+oSWrDje
        gE2y0jOWsfXKUJbo+bd3eeTvi0iANC09uUzKMeiBE3aI3+1iJkOC48CmJIi0Z3nC
        WVmtjoOkI9K3GscQy5cW8Ws1LBbP1gW2kLxnai1y77w/HbIJzjE5nJvABiwJK2sK
        5msyPllH++qw1yhIk8jaPNadK/+T2sKEAfksbucexo/PM1TT2Gsn5Eu46zwI6qf9
        nVRBAqPKGs7evwGPuu0synwQbsImhkugJY+cIlbdNqwrDoTG74qeHjQaJCuaJyBg
        GFqsgb9bz50i8oZynqjxAFsPufq6+v4HKn8D0UhJllo1sRPI7E5GIRnpg==
X-ME-Sender: <xms:qb6eZA54-o6q61-KGcRRBepuCnWWltl3qT9ovjlfKeUnErZdl1KFjg>
    <xme:qb6eZB7OXwEWTBsoV2UqHgx3KechWx7CFqIG6Bl41eHPQXQpQiIEV_MCRlz19qQ5U
    vSCtJgvCVrck7jYlQ>
X-ME-Received: <xmr:qb6eZPcOAqi7C_xx5_klpNXPWd1O-dFq5O3J7jX2w2FmQbYsRDSgYgBhQlma8bn0r5gfjDSirO8-BxsjvF8xIGddyDBNFP47_a038QHcMjWB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvueffkeeijefhheehjeffiedvffduvdevteefheefhfeugefgiedvleeftdekhfen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qb6eZFK16aS4ChEtMnD2ukUzOG3NieazJo5FWxdYI1zg5ac6ig8l3g>
    <xmx:qb6eZEKkRbC8njFJ9q31Cf9H3IURZ8SmjJUDFrhAVdiR9ih5DCRVMA>
    <xmx:qb6eZGzY-MiHZkka5rN4AONZI0QeA9d5TzwnSanLtiWPT7itlKl7cw>
    <xmx:qb6eZLU3VHKiHgDxZt9-F23u9mEIZZortWO8vUMJ_j-LQC2xNi36Pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 07:38:16 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id aecaaa44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Jun 2023 11:37:37 +0000 (UTC)
Date:   Fri, 30 Jun 2023 13:38:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Adam Majer <adamm@zombino.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
Message-ID: <cxakwc2qnqgnh3hg7oufj5qoizu7ltw5qqbq44aafxr5syssm3@4e6eziwdt7jr>
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g>
 <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
 <xmqqa5wh9adg.fsf@gitster.g>
 <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
 <vt3cizczmwbcpgktwrkr3jbiwhee37rt7m243hnkzxik7gt4m2@d2upsqoxtlgc>
 <5880fe56-aa98-64ce-4d91-ca078d3a7354@zombino.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gagavb5t37igvjs"
Content-Disposition: inline
In-Reply-To: <5880fe56-aa98-64ce-4d91-ca078d3a7354@zombino.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5gagavb5t37igvjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 01:25:06PM +0200, Adam Majer wrote:
> On 6/30/23 11:31, Patrick Steinhardt wrote:
> > Indeed, supporting SHA256 is a major effort on our side at GitLab. Most
> > of the work isn't really adapting our production code, but it's rather
> > that tons of tests were written with seed repositories and hardcoded
> > object hashes. Converting all of that isn't all that hard in the general
> > case, but it's a tedious job.
>=20
> Hi!
>=20
> This actually reminds me of a funny story from my side.
>=20
> Earlier this year, I was testing various frontends and how they would han=
dle
> SHA256 repositories. All of them failed, not surprising. I even managed to
> lock myself out of Gitlab by importing a SHA256 private repo into my home
> project -- every time this project became visible, it would result in Err=
or
> 500 from the UI. Today (few weeks ago), this appears to be fixed -- the UI
> is just broken, so you can't see anything in sha256 repository, but at le=
ast
> I was able to delete the project.

Yeah, thinks gradually start to work. It's kind of satisfying to see how
more and more things start to fall into place.

> The repository was correctly imported and I could clone from gitlab, so t=
he
> problem is mostly "just" UI. :-)

The UI is a significantly broken right now, mostly because the request
routing logic still has a maximum object ID length of 40 characters
hardcoded. So indeed, most of the stuff in the UI doesn't work unless
you do a few changes in the frontend. I should probably just create the
merge request to fix these as I already have those changes available
locally anyway.

But there's other parts that are in the Gitaly backend that don't yet
work. There's some RPCs that parse object IDs, but still use the
hardcoded SHA1 hash. Updating them is trivial, but as mentioned updating
their tests is tedious work.

> The most likely frontend we'll use for our internal project is Gitea. The
> sha256 support is in progress
>=20
> https://github.com/go-gitea/gitea/pull/23894
>=20
> From the size of this patch, you can see how ingrained SHA1 assumption wa=
s.
> Most of the patch is just to remove the hardcoded elements, including
> hardcoded SHA1 empty-tree hashes and assumption that 20 bytes is enough to
> hold a hash. And I didn't even add sha256 test cases...

I guess most projects that started a long time a go made the same error
of taking SHA1 for granted, so they didn't bother writing neither the
production code nor the tests with swapping out the object format in
mind. I guess we've learned our lesson here, which also means that the
next transition (if there ever will be one) should go a lot faster as
the codebases should be prepared then.

> But I have to say that in at least one occasion, people are bringing up t=
he
> experimental nature of git's sha256 support (per current wording) as reas=
on
> not to make their tools sha256 compliant.

Yeah, it's this chicken-and-egg problem. Things are experimental as most
tools ain't got support, but because most things ain't got support we
never get any testers and thus are stuck in that state.

> > In any case I'm fully supportive of relaxing the current warning. Except
> > for the recently discussed edge case where cloning empty repositories
> > didn't create a SHA256 repository I have found the SHA256 code to be
> > stable and working as advertised. We should caution people that many
> > services will not work with SHA256 yet though.
>=20
> That is exactly true. But this is also chicken-egg problem. Services are =
not
> adapted for sha256 repositories because there is simply no demand for the=
m.
> Only when people will start using sha256 repos, will there be some demand
> generated.

Yup, and that is why I have been pushing for SHA256 support internally
at GitLab for quite a while -- our efforts here started almost exactly a
year ago, but has gained more steam in recent months.

Patrick

--5gagavb5t37igvjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSevqIACgkQVbJhu7ck
PpSqJA/+Oi6OyT7bnKLWGLbIoQExLVLsjB+OUsFD3ZAiS8d0R1bdETVUnxigtb4l
VKsuuli+jU4+dV/97axEmK1u7niqedqckaWuPHisar3G6v6BsIvU0jg2piSZwJC8
mSkcozTiz2fHCcd9pVnzRTLqRKbiDfS+kjIhKdKKzMRW8y4b9yOrIm8UD67fBaq+
9lRHDNinYVs42akhGQavhQ4OeJWbv/aiWTfDSHyp2bNRdrpLSiNFJr1M6OUiVN50
Q4y9AywomB3iPK/yKtgu9cCgLxym98ZnZSlndwA2X8vav9XbqM+G4wsm4asbPrWK
P7AqjrootJK+y0iD5IAeaNbAD0vhPaOW6Us8N8uGclT11Ra78Vf8YDx+jffPoxKg
PP/8M13tQDBlobzeUCCwX69VZn1h1y3RG4ohPMcRgjjGgJLSAyJ1mz0IAprHcz3W
kqxdSPvn5HQ+Wb4xhqBpFrGtOV4x4D9yICfai0WsGuLru7xdi6MYXhN9tseWK/4b
EPolfrAg6QwtWO++NSFsP9Jc2G00EpOZ7ajwW4QJ3GOV8idlwSvVQkzLQwZQ/e2e
tEQC1dy9MFJGUm5DI2DbGQTw5D3SV9KAHVFukVUAzPywXkKBXhOorDGgo90V7Vha
RaFnysJhPsPzb4HxAh2kWFV9X6f/wCKPNz15cKoxHocQO0nGBjs=
=Rh7D
-----END PGP SIGNATURE-----

--5gagavb5t37igvjs--
