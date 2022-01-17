Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36DC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiAQHSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:18:23 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36095 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237344AbiAQHSW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 02:18:22 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ED1655C008D;
        Mon, 17 Jan 2022 02:18:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 17 Jan 2022 02:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4NqMhQCS4S2XL8Gh9lR5q0SWey9
        T23aMwWekGY3qFRo=; b=JQahVxYjnpdNhjy8Wqs91rkaGG5rpgdjE8VII650LUT
        1+zMsMQCmQduUfLIUBaus1ukAv/WbIHL4UMLDbAtWIIu7QaOGGi1HGB++s1jkPHW
        QwETKao1auC7cfGC4cjTcusp6Qb3VdQ30YXaiCz7RKd87S/fnh+xPfnE1GdjW32n
        psh5mLr8MPuBJzn6XeyE3U70o544Y2HkvNOOWJyEaA48rz88dcYeVa4xUofZ0dHC
        mI0NB4VK+dka6mmd43lAopigWY14OFLfWT6MYqLwL82NHhpQrBu4AUpeGGy5o7kB
        9dLfsii188jJIOF2n8PhIXfX8vQ2fH4+3ChMbNLnMNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4NqMhQ
        CS4S2XL8Gh9lR5q0SWey9T23aMwWekGY3qFRo=; b=hZNPmENFOXDPpqNuYVqXjo
        9F1opBSw0paxAiDUexCWGqTZ5YXDnhqlN6/xkVoSZ2iZmn6P8S1ITXeU2KFa7/ep
        KlQscQA80gb2HtziK9/xYvhCgbtgos6k5q7ZPnZ7+9iHD8RctGAKumqE6i7BQIR3
        y0FqM1p08cLI5EPmVwlUg9vNnNy5aGn/ialIK9PDFxKlvTUq80IL0khCLkx5P+mm
        xwTiioZzGJflb0Z8Z+5MevxdoozIphaSr7fbOhb31DupEDHFJ8ipEwaBzn9ieHMo
        gNSZlalagV0jNaL9TbGpT9euAwkZsz68/lvieJzsAtOW1X1bjqugZzeSSjmhvWIw
        ==
X-ME-Sender: <xms:PRjlYdzfE2o5pSW4kJZhjNsRy0bL7JjlRYWeLUlcJAjKAws_OsS8sg>
    <xme:PRjlYdQUXHRmzPC_kCxfd7PMxetnz4P-VL3p48uD_cXJYgIQGOOpTqaK_hdkHA4_t
    NL1s5I0nr51W7sIbg>
X-ME-Received: <xmr:PRjlYXWuu0gRxavo63egfuwJg9GKgZXhGqg3r4UkOGGMr9uxfxo3d8YG8cMfU5Iz9uQQFmOCl4BuQ0Ax1al6SjOMkuc9VbZ3Pd_vpW1emCPOKhG_Md-uVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:PRjlYfjRZSXm5QBroQ0E13_ER7GkSkjPQ3GRl8JYqCk08Z8etFu9-w>
    <xmx:PRjlYfD64kNmji0c_cBfIWuPz25fwpuitGMnkl4_9YibDf3ZinQUkA>
    <xmx:PRjlYYIUP8uanNvko5GY9vJKlA7XtlZlPOcR7RX1xQFu87GTvvVZLQ>
    <xmx:PRjlYa_jRQMl9Jyo5z2tcpbdkjhrls4seFZJlKwHTwpSg3krqjvwZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 02:18:20 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 710a7e38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 07:18:15 +0000 (UTC)
Date:   Mon, 17 Jan 2022 08:18:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 0/6] refs: excessive hook execution with packed refs
Message-ID: <YeUYNhJemN/hRG+6@ncase>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
 <xmqqiluv6vim.fsf@gitster.g>
 <CAFQ2z_P_SiaDbSQdAt5mSp79BnC0-k5B+X09oCVh+w--BO4_6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4kSp1kdRG8xnH/IT"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_P_SiaDbSQdAt5mSp79BnC0-k5B+X09oCVh+w--BO4_6w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4kSp1kdRG8xnH/IT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 07:24:19PM +0100, Han-Wen Nienhuys wrote:
> On Fri, Jan 7, 2022 at 11:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > this is a resend of version 1 of this patch series to hopefully entice
> > > some reviews. The only change is that v2 is rebased onto the current
> > > main branch at commit e83ba647f7 (The seventh batch, 2022-01-05). The
> > > following was from the orignial cover letter:
> >
> > I'll add =C6var, who has been making a lot of changes to the refs
> > subsystem, and Han-Wen, whose work to add a new ref backend may need
> > to interact with this change, as possible stake-holders to the CC list.
>=20
> Thanks for the consideration, Jun. As the hook is called from refs.c,
> it should not make a difference for reftable.
>=20
> I looked over the patches. I didn't look at the bottom change to
> packed/loose refs as I'm not an expert.
>=20
> The individual transaction updates already support their own flags, so
> this change generates some confusion. Consider:
>=20
> int refs_delete_ref(struct ref_store *refs, const char *msg,
>     const char *refname,
>     const struct object_id *old_oid,
>     unsigned int flags)
>=20
> how would one delete a ref skipping the transaction hook? It will be
> easy for someone to pass the SKIP_TRANSACTION_HOOK to
> refs_delete_ref(), with surprising results.
>=20
> It might make sense to not introduce a new flag namespace, but use
> update->flags instead. You'd have to add your new flag after
> REF_SKIP_REFNAME_VERIFICATION.
> Bonus is that you can unittest the new flag using the existing
> ref-store helper without extra work. (check that a transaction with &
> without the flag works as expected.)
>=20
> other than that, looks OK to me.

Thanks for your feedback!

In fact the first version I had locally did exactly that. But I found
the end version result harder to reason about, most importantly because
it's not a 100% clear to the reader whether all callsites which delete
refs in the packed-backend via the files-backend are adapted or whether
any of the callsites was missing. By having the flag in a central place
it's immediately clear that the hook won't be run at all, which is
exactly what we want here.

Patrick

--4kSp1kdRG8xnH/IT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlGDUACgkQVbJhu7ck
PpTdYRAAnwZXn6SAt7TwfnkHbwqWGWsSxD4ZX5I0zmZokOt3pMv9poDCET37KW9V
aiQmdIcdmeJoiKCvZxjtdgn4NPos7uHstD1FH7EZ+Vya1PNHU+8alrYV4nxukhxo
zgZYClCpCizByQLC1K5JOiJOWZu2ZDJkvOJzBUVg5nllXqcu70o/SFSwWqXGLrZs
doEx/MPG5B7keIdpobzamvn2Fvv6OUQ9ZtgS2htsRoGiyMiCSS9yjfrAdYIH4uEO
z1b2l87XTXr2yZiICFvqNUi18sElYEPjuwPq2xbR86KvHlg/443zW8CVtalf+43I
+nu4+1I9OY9XtNJqcA71T3FjSqmwKAgB3zlFtTtHY4dIuuQVkKi45VH3FPOwC0Zm
EJt/hJxiH/13gQgYesbHZWwZSQLEAWgcIofsR5HuNg0ga7PdCGPEfVhlEPsbiK4L
Jz2raYENJOltf9DT/Fo71hHygkB5TxEL4MMRgpxONE5qr5Zq1uNr4rwMoQbb7lUW
Z5wueCHugaX3jIW8/TnEv1eyXDCvz1MeQ/YJr3ZwkKpc3WgGZCUMkH9d3WQagikR
kiSEKXVzDH17SSrZqRwFFrcVTBMdB2JT1/aC+gYXdejTAPqU+y0LbuQ7al2EX1mk
WwTMYU60DXjwBtKruBzaJLd0pieyjYYFjFCpSoP5muGLzKpVHEc=
=NNuT
-----END PGP SIGNATURE-----

--4kSp1kdRG8xnH/IT--
