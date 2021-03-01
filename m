Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE160C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BA364E07
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhCAJe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:34:27 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55261 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233450AbhCAJeZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 04:34:25 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 930042D0;
        Mon,  1 Mar 2021 04:33:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 04:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=W8xXTigcCcwHTY/1mItP4+SOFQN
        R62Y4/6ddAxvNI9g=; b=pq1kTCZNZqHQMNLH6ML+rVXSBN/PMiKD2bOpSiGOGn1
        r5ZZp7OBT/FOdIiiyF1DT71CQVRhILA4kzFWnqqUnpUzTSH79nmnTHwhw9NQF7rx
        DfcdJI+8HO+owlvXczL+DGNeS4sfMnwqzTosyfXRx4RjCf4FjbEakiJDhPQrDleW
        ABs7fVadZmNkU/KuKixOnZD10gWa0EMPKIOF9DhkkF8o5Qx/v8t1YSLpK18ETceB
        v719ANVadgU4Htc+0rkr8pd4GGIPzwI0tuvfkp8tSXVTNOXE9z9DPQlbMrqdfH0d
        1IVmUSgzGNEqhQFVdU45TJYsayzsxYzRHs5zz38EwaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W8xXTi
        gcCcwHTY/1mItP4+SOFQNR62Y4/6ddAxvNI9g=; b=PqMhpJwYyyf0BR0PZWxleo
        sfTax9DbwirDeOC+jk/6I747PxG/QXHQ/ImDWDLuqgZXJeUbAeZ5tg2Lke3R8G9O
        IONTVqnb+klpAiVfdFZ1qPzQkRSs4wLRa5mcEB+0x0D100p0lhiNuMyFsrHogHO7
        DCFCClYtLex4/Ueg3pWXFLjMECcXsQyIplGllxXuQwhMzambwVhCcaRb33igvsOl
        Gbabopr4oABL5j9pNViELmYQzSI4DMHD/R3J36Yna6uoleTf7urp7q100T2GshZW
        JFclxspttkxxHfiIV0N8ix04v8MttmLb1irgAbwxfnouRPTFR3wEqTGbyAY2nFzw
        ==
X-ME-Sender: <xms:7LQ8YCKto9Z-lMRuYjSmaLhjMtiB9zn8EzjP8bDDVuXq60jUeMedsQ>
    <xme:7LQ8YKJfi9CD9gtU7tMB21-uBh5EiO9pcMOUqv4Hyvv95H0u_vpqPXzjIYKzL8WpL
    99-3vAVx9zz-t--pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7LQ8YCuc-595012TGGhCmGGJzCb2O_FqKwhte14zkgXqoE3P2eQp7g>
    <xmx:7LQ8YHaM97I6LygLyl3Jt-gPOVpT_f5usGE_PFLxO7rsQZmiy7udDQ>
    <xmx:7LQ8YJaWpKj07sLuZpzd2tLpAoeVUr-4Ai7C87ni6hJhrBjRxaRvgA>
    <xmx:7bQ8YIxwi4TlnlcbfKxjoODY7q2UD7Oj5xfhJ7LzS2y6X2G-ZzD-aQ>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD04B1080057;
        Mon,  1 Mar 2021 04:33:31 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7f49820c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 09:33:26 +0000 (UTC)
Date:   Mon, 1 Mar 2021 10:33:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] githooks.txt: Clarify documentation on
 reference-transaction hook
Message-ID: <YDy05NMxhfSKbGtS@ncase>
References: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
 <YDiPP3Ml73igpT7Q@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivKkem8IbVfbFAhP"
Content-Disposition: inline
In-Reply-To: <YDiPP3Ml73igpT7Q@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ivKkem8IbVfbFAhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 01:03:43AM -0500, Jeff King wrote:
> On Thu, Feb 25, 2021 at 06:50:12AM +0100, Patrick Steinhardt wrote:
>=20
> > The reference-transaction hook doesn't clearly document its scope and
> > what values it receives as input. Document it to make it less surprising
> > and clearly delimit its (current) scope.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >=20
> > I've been postponing doing this simple doc update for far too long, but
> > here it finally is. It simply clarifies its current workings and
> > limitations without changing anything. This is not supposed to be a "We
> > don't want it to ever cover symrefs", but rather to avoid confusion.
>=20
> I think that's a good step forward. We might want to say "does not cover
> symbolic references (but that may change in the future)" to make it
> clear that nothing is definite.

Fair, I'll add that.

> OTOH, I suspect adding them would require a change to the hook's stdin
> format, so it is not like a hook could be written in a way to magically
> handle them if things change in the future.

Yeah. Hindsight is 20/20, but this should've used some kind of prefix
with the explicitly stated hint that additional prefixed can be added in
the future. I've got myself to blame for that, I should've known better
to make this more readily extensible.

> > @@ -492,6 +493,13 @@ receives on standard input a line of the format:
> > =20
> >    <old-value> SP <new-value> SP <ref-name> LF
> > =20
> > +where `<old-value>` is the old object name passed into the reference
> > +transaction, `<new-value>` is the new object name to be stored in the
> > +ref and `<ref-name>` is the full name of the ref. When force updating
> > +the reference regardless of its current value or when the reference is
> > +to be created anew, `<old-value>` is 40 `0`. To distinguish these case=
s,
> > +you can inspect the current value of `<ref-name>` via `git rev-parse`.
>=20
> We should probably avoid saying "40" here. Maybe "all zeroes" or
> something.
>=20
> -Peff

I wasn't completely sure how to word this and thus opted to do the same
as the other hooks. Most notably, both pre-push and pre-receive hook
explicitly call out SHA-1 and the 40-character thingy.

Maybe I'll just add a patch on top to also change those to instead say
"the all-zero object ID" or something similar.

Patrick

--ivKkem8IbVfbFAhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA8tOMACgkQVbJhu7ck
PpTiiBAAhbCe9LZLixfWOh6hTCVZMaJ49ye1pjGdbu3KPqyclatuGjssOSzEmEyS
KQEUZT4qh0s95FIsKS7S6tsFSt/6ho+cz17MkVd9hTmH9WKTpRjwXQZvehxOPqdI
/vMvr/kZTS0kLnV1Rsjmgoh9hJgcZVcB5Qg13hV5GEdkWizgttmZakHwxzeyu3rr
hAv9uYkfUsJfbWy5VIyUjUCkpsHeVJe4cyWO97fQ0mIpoacaf39dCuuSsRulWbnI
Il9aFgwMorTvLcehfF1OxGH2lIbIRyjC2+yo/XTWiNmjXX18aWpJeceO9WJqdZlb
YZEVNEM20nnn74BU7W2SxwxKVONUPHj/zjrFNSYEM27Jm+4RtJE7om1HjEEhR9xE
H1G37sW7omOrQJm95dPL5r9hEHnD0U0CivaXtJMUWRSr5nFzXsGpn5EwUI6DVmFI
7s+HxpGdWrp9n5YwfWjHa3WFd8PMs24CcCQsTm/V0kSoixrz7Ism0qWVSh97aQP9
C5LnTz15i6T3wUKOPkInA81/mixxv0EDM1lAWn0yxr95BnvtSFHonizT8P8snmGr
5qaXgVCMkK1dxSfdbUwKTzrDIbKuVn0mBt6bnVL13Jt5350V1fUPLAuwggbSjql0
WhELAzKgFuhr4uX0PQx63LrpnUVMSF1SI2h+bp8n/SUZVtAu6Xw=
=ZcUr
-----END PGP SIGNATURE-----

--ivKkem8IbVfbFAhP--
