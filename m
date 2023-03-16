Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD2BC6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCPPGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCPPGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 11:06:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA947B9506
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 08:06:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3F3623200302;
        Thu, 16 Mar 2023 11:06:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 Mar 2023 11:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678979166; x=1679065566; bh=Es
        PVI1ICM3o0aI0qdu8rL9o0uG4JRlJ2Yu28WRed0SI=; b=oE5tClx6gQEV5KVLVV
        Kj97BKglst1V396jJ/Pw0IwNNYW/u+UZVL0Dh4GFE325fW123IR5vXkcJDerGswz
        tOL5ai/fgmtmvcPLRO7pWbSCrw7CVQOaqa3ccZibnZnbw380047QqdPsXWFAF/gr
        VJnsiyPBZw9Hh1WjK60u5qXXYPxeBE1vEdwt4oOfnklT1nm47Vx7bLDpQBxURfy1
        G3bTpLL/B6tbRo8uJ1414HiqL0NwFpOW+VHeIbvfGunqqKC3xGNvGxLJdEx9Kw84
        uEoKlhcb/SdVGW4Tyt+bywMUttiJ+Q3VzuJ+p1gK2dT4RuTuF/Yr+DBEmSNR/9Ub
        K/yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678979166; x=1679065566; bh=EsPVI1ICM3o0a
        I0qdu8rL9o0uG4JRlJ2Yu28WRed0SI=; b=An5oHiyS4QUKflGLo5E/GQvNyBNs0
        DawGpud+VuQeq6MKp2PS/88+Xso74lyVztC+5EQwNxMaAyelmLgRpWAMORgCY2/1
        xBWonNLe9nILyRIUr4r0ZRxC967SkyA5boheS9ySG3G0cGGyga/ZG6de1sQ5fa/Y
        Le9ywfQekxOEI1Bz5UxS1HG+jI2A+bTJFpy17CcZv4IkwOcLJJxJCjl1n7xGOkt/
        q4MbEmPi3Tt5f7gNYbAIPbEfvPQhjUuwfvaOSq1z+xUsgk20O9Eo1rKxrpn+bQ65
        DV2Xa4el3juMLQBycWXbrIddC1oD2+I1PpD+jKaqAqbxWLiNnFsXTBE9A==
X-ME-Sender: <xms:XjATZAT9GTLRJCe4PMZI0w-CgIN-QfO91BFIGyj4Uz2SjiP03tTStw>
    <xme:XjATZNxuCK5yNERD2e8RAoHsc384C4zvpmY7EPkeH3IBZGUYLbsfC-y2s1CIU9xgQ
    nVULER11HgHrGSi5g>
X-ME-Received: <xmr:XjATZN0zYZ-AqjW6SV6_9-Mp9hY0u25iA30uCEbo_Zld5YYuKUzKH2jPvW8q_PKXlRSR0S2ZMXVje_FoAJCSrvwIBeTH7qgywtxolHRzX70RlBE3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XjATZEAPm-s6u3Q4xHtvKcZQQ8I7ee9L4F02O7iPJejSb6WVqbQggg>
    <xmx:XjATZJjC_GvG-nvfFwvqiR80gST1bIZBsVav1S_caNI0_29PEd21Qw>
    <xmx:XjATZAoHesZMVsIkkDNga_PGlBXfPwbxzoCjf7EsKcGo2lRcUmbsYA>
    <xmx:XjATZJIP_NQfIjKrbvvdWFJ6jdYxh7RmTM4D1cFtYypjAr-GD42cLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 11:06:05 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6e995823 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 16 Mar 2023 15:05:41 +0000 (UTC)
Date:   Thu, 16 Mar 2023 16:06:04 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] fetch: deduplicate handling of per-reference format
Message-ID: <ZBMwXAnEnD5QjsFE@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
 <xmqq4jqlocqf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TaPWvnDK8vUSGc8B"
Content-Disposition: inline
In-Reply-To: <xmqq4jqlocqf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TaPWvnDK8vUSGc8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 03:45:28PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Both callsites that call `format_display()` and then print the result to
> > standard error use the same formatting directive " %s\n" to print the
> > reference to disk, thus duplicating a small part of the logic.
>=20
> Hmph.
>=20
> If format_display() were a function whose role was to prepare the
> contents on a single line, it can be argued that it is caller's job
> to give a leading indent that is appropriate for the line in the
> context of the display it is producing.  "store-updated-refs" and
> "prune-refs" may be showing a list of refs that were affected under
> different heading, together with different kind of information, and
> depending on the way each of these callers organize its output, the
> appropriate indentation level for the line might be different.  So I
> think the current product format_display() gives its callers is
> perfectly defensible in that sense.
>=20
> On the other hand, if format_display() is only about showing a
> single line in the tightly limited context (in other words, both of
> its callers promise that they will forever be happy with the
> function showing exactly the same output), then this refactoring
> would be OK.  In addition, it may even make more sense, if that were
> the role of this callee, to do the actual printing, not just
> preparing a line of string into a strbuf, in this callee, by moving
> the fputs() from caller to callee.
>=20
> So, I dunno.  The result of applying this patch leaves it in an
> in-between state, where the division of labor between the caller and
> the callee smells somewhat iffy.
>=20
> Thanks.

I totally agree with you here. From my point of view this "division of
labor" is getting fixed in the final patch that then also moves the
printing logic into `format_display()`.

Patrick

--TaPWvnDK8vUSGc8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQTMFsACgkQVbJhu7ck
PpQxjQ//ctAgmLGm2PykJ38cNkzwkvXlPdgU73oDhKCmQZFV6dgXORMULAXw1PeJ
GpQFk5Sopj7BnrCM9jsSg1+6XSog0xVXd8fhQMZIBWX+IFng+9vI3JQIxZUoDYbc
4HKbAYhVGCg7hBW+AgKaFcg6bjb5O74QWvf279jSAOO75ONigY3GQUlao7dyfOuE
ioOeGE9CPc1DLUGQwXg5H0XcPqc1WQb0OcBygaLiJLUj/uadLbjPKqEcYdK3A0DH
qiY5XeDaLNPHwZ9oMdqVISC6Sf85vJ1cvPcwKWu2ACrRudwzoYtOi/YlGJDppRGv
UDlszUThq/dmBIZfuqppj3vA4Q5PXXxA46kBJqbk3vtgRi60WTIMLp0Cys0bCuoK
0ryQwRCs9H+Qp7m+MFY6+3u2/EKMXN68yf+TMHzURkNTX0dd/+1xAJFaAWIkO4ZC
fkmfi58RqiaX7LyCOJg/XDBOfOamJR/hGQpMpGZuysYSfy7rSLopgCuWQ+jKICyz
dpEB3wMsYM51ewytr48bpR4K47eWrRtjeTz/pk7T9mqGsySx/jB/12AtW0QrMn0D
lSBILAboVDGSCSQC1T0D9L5dSN3r7oWxp/TorqwzPl5VKCJNi1uXSIp5fJXBjOzk
76IfysEUgK4so8YGrbMeJhmheALtuVdE0iG3bMq9QW4/zplhSR0=
=l38v
-----END PGP SIGNATURE-----

--TaPWvnDK8vUSGc8B--
