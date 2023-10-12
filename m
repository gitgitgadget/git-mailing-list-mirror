Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F95CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 11:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378020AbjJLLEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbjJLLEg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 07:04:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95FD9
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 04:04:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A41BD5C03DE;
        Thu, 12 Oct 2023 07:04:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 07:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697108667; x=1697195067; bh=5o
        UTTFayqh1EomIuDcVi1vGk+Z2CcUp70l3W5YFs8Lk=; b=GYtbM2GaK4Not+c5JI
        L0XfsdBrGZp74GnIjI5fBB3Q65d2+hPmxNGqT1z7dk19q2/2pN5oxUTl/qOH1pXQ
        OJ44UwqGAKcW8Wnc/Mmm9QMY8Eh5v6N2yFN8TC2MaQCYxxfnJrVEn9++KFgOq2ZC
        1BL533wPF3hlOgEhGA0n+43lkOAEiwPh3PZyPrk07Bom/e/r1M6ydZ0cDy549dWg
        R78GF/TbRpXmD2VxN6/ccJp9nLsUYyMpoWA/Ul2uPBXMUIC1MTV1icVBKQrbG6Bj
        Fc/GM4vFgdlwQyf4/1fRCqns8BdQ+U1oz8B7SnO3KpfD8pr6x0+28GfIUCW0k94E
        9cZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697108667; x=1697195067; bh=5oUTTFayqh1Eo
        mIuDcVi1vGk+Z2CcUp70l3W5YFs8Lk=; b=pxeYlOHEXnWW9QT7uoD9djRSlSC3z
        WtF03qwcnDLnPnmDZ2hpIGpHOYWkQ46IYL8jyQagAewb24oc73NMbth9oFWlDgX/
        aUJFYbrrDyBw8Sj/FCK/rrwEMURgdB/huRMzEI+SXvY1VnWah47pQR096gQdVw6f
        qPZo67MCh1S42OGtT5yGZPwClOBmmzq0+DauS8g6PqyqmhDlkdXO9RdJTwjcBwZw
        /c61BjpnbVLv0oMhs+hecRsth3inDUeRbjvwjkf0o0XuzPHl8kkRyhgYwdHyLPgw
        /1qNw8MmDztf1+qa/hOwPAs3Ug80Wprn1oalmA42DZsVeEsGel0xT1a2A==
X-ME-Sender: <xms:u9InZVRFEsW0cFrQG6i9xj0sROp-ahn6FrfyS9w9BSgoRnIlLra3Og>
    <xme:u9InZewYd1xGknFE64Q53kw-qGey44X3Eg0dI9TGsniy59NeMGcRDJ-Ak9aPlyxrW
    EauSIDDgodKcsNGNg>
X-ME-Received: <xmr:u9InZa38CfjNwkC47ZlbHCKCLRWntfQO3vTLwMGvtKEig9QI-wP-QI3r0NKH6sKtsqaWVLfGpaf8Om4WGLBU1RiW9CyMWWra7QViV3V2Kuuq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:u9InZdBvo8_uxsdBgy1Db-V_r8HXtnWJBwB8-mkKJyEsWlZsQZsRbA>
    <xmx:u9InZeg_D-__yxbIUqcmAsY3bA6p8OcRLCiwR-UfHPo-K-PCVtw0kQ>
    <xmx:u9InZRpCrxfQaV3LXmFqiGd-dHitaR6z3QreBsXReq315ByrdmvapQ>
    <xmx:u9InZSal6rr3PCESAzwwFSNPfyNhXJ_yhypmRumhqlhYADha_XUb3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 07:04:26 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 6d498745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 12 Oct 2023 11:04:24 +0000 (UTC)
Date:   Thu, 12 Oct 2023 13:04:23 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
Message-ID: <ZSfSt4tXx8sE68Bn@tanuki>
References: <20231009105528.17777-1-karthik.188@gmail.com>
 <ZSTs3BUVtaI9QIoA@tanuki>
 <xmqqil7etndo.fsf@gitster.g>
 <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
 <xmqqbkd5nlq0.fsf@gitster.g>
 <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qbNH1ecBcc9Sv8JS"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qbNH1ecBcc9Sv8JS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 12:44:27PM +0200, Karthik Nayak wrote:
> On Wed, Oct 11, 2023 at 6:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> > > Seems like this is because of commit-graph being enabled, I think
> > > the best thing to do here would be to disable the commit graph of
> > > these tests.
> >
> > If the CI uncovered that the new code is broken and does not work
> > with commit-graph, wouldn't the above a totally wrong approach to
> > correct it?  If the updated logic cannot work correctly when
> > commit-graph covers the history you intentionally break, shouldn't
> > the code, when the feature that is incompatible with commit-graph is
> > triggered, disable the commit-graph?  I am assuming that the new
> > feature is meant to be used to recover from a corrupt repository,
> > and if it does not work well when commit-graph knows (now stale
> > after repository corruption) more about the objects that are corrupt
> > in the object store, we do want to disable commit-graph.  After all,
> > commit-graph is a secondary information that is supposed to be
> > recoverable from the primary data that is what is in the object
> > store.  Disabling commit-graph in the test means you are telling the
> > end-users "do not use commit-graph if you want to use this feature",
> > which sounds like a wrong thing to do.
>=20
> I agree with what you're saying. Disabling writing the commit-graph for
> only the test doesn't serve the real usage. To ensure that the feature sh=
ould
> work with corrupt repositories with stale commit-graph, I'm thinking of
> disabling the commit-graph whenever the `--missing` option is used. The
> commit graph already provides an API for this, so it should be simple to =
do.
>=20
> Thanks!

Wouldn't this have the potential to significantly regress performance
for all those preexisting users of the `--missing` option? The commit
graph is quite an important optimization nowadays, and especially in
commands where we potentially walk a lot of commits (like we may do
here) it can result in queries that are orders of magnitudes faster.

If we were introducing a new option then I think this would be an
acceptable tradeoff as we could still fix the performance issue in
another iteration. But we don't and instead aim to change the meaning of
`--missing` which may already have users out there. Seen in that light
it does not seem sensible to me to just disable the graph for them.

Did you figure out what exactly the root cause of this functional
regression is? If so, can we address that root cause instead?

Patrick

--qbNH1ecBcc9Sv8JS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUn0rIACgkQVbJhu7ck
PpRjgg/7B4nyngyTufs/eDZ0zM2FuWFH2NEnK+l3MMCeC8Z92F98NBSXAsf2GiIz
ty+DXuJEba2s4StqzDHhC6v/sr4/sMvd9t+FwDFhMtpFDchjyS8AJUwK5b+a1rs3
rBB2PSPDQp1Jd9XFitttn1cyhgR5AtkxkfiKeX0SFa9ppAXqAJFQEJk3Jh361U0E
pu4rOUqMeDSN81VfHJsXIJrd1aB2HiH+2Dh5JJt6bTfWjjTWqu89ziXY0o4G/bbD
O1Uxxih89MjJobJ1YndoH+OF2LePeo2cDJe2nLMlGTGV9XPk42qSOUCHl9v27rM7
US71ZeHsGXW7yXMzKkuXx9VBQ541IsGHkqcwRfAxzHLuSLXi7Fv/Jfuh4XdmmXY0
8WwS7AOq4StiSIFm67GkItut08lAjcFwrMjAZEpu2GywYsx5nWeNssV9a3c0eFYc
zQmn5u7iDjeYIBojIO9eUaKntvJacBzasnKr+0FQUzyatKVeacOhqk30UdjkjDMW
xKzrM135VXLszGhAPseKvco9uH08JrAHo/xd1bAlASaUSqHDQZzPK3yvhaWVt7Mm
r0xWjJsYMzjNuPnE/qYkS4rWt5rhJKFzy1BP3xDVFwqCOxJRxlNpXTS3PYc+HvP4
TzJnNctDBDO3on4ey//lAiamzQ74mIqw/ZsH97ZQj+YH19+3ZEg=
=QoWr
-----END PGP SIGNATURE-----

--qbNH1ecBcc9Sv8JS--
