Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6EC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 07:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiBNHFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:05:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiBNHFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 02:05:16 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4757B3D
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 23:05:08 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 335AC5C0118;
        Mon, 14 Feb 2022 02:05:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 02:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=7oQvUshIP6us+Z/8Ct9diMiim44iPAO4I/Cso+
        SCAPY=; b=qCr30ncMkgrg2E56mo+GUh3RaGS2bQb+jlcnWtSWSADb2nl5TebaLg
        oXySIRepeNqf6VAK4J/bPsjcO4VASDwLjtSljrstdmKofUlzQ/NgnVZPf9xU0wod
        ORYHlOY59z7/D+8C6h/QxNiHbQhOcLY3NdmCHLqphmksjvQtECQigcTV+F5SWNc0
        R4CfC8gFH6PgLBU/sy5jzMXcRTmDH835SDSkFUn/f93lZw2csGHMjeJwBBxNnfop
        LdU4I0aSB9EcJAjRUjAc0YuBR7jwONcOdZUwRmi8+ZcbAK2Gu96rDml5BUs5Xzxj
        jhBkOHLht1XJ4b2KJmA/CosAIbrXk9Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7oQvUshIP6us+Z/8C
        t9diMiim44iPAO4I/Cso+SCAPY=; b=lJw5dk3IcDqz2+TOU78BBeN4ujJr0mV3E
        YQ4AWBiqBpmpmRjyefxtoXyRDX0bAB0MYQMpvvwZCukd0YQMYJvOv+RqREPRD12y
        k1Ar67w3/e3MVVVsPOV9sFuToI2cQa2Oq/33W2T02XCz6v1/+tyhKUott3/uJucH
        ai9fgJmMlUWL+wMo7d/R30m5TOEwWIwIXa+a6BWruuDqEiF7+RypXMV6pxsc1Ex7
        hjy20vY5Yvy76Z2iHFUWgYdYW/ufURLazGgh7c8qr+ZJXYaRqBm7G3jHJsT6zaGC
        FPcc36G5sXBLoePL8YeYWmjZ4mWkNxXdIeq3Y0yIWYPgp93zkig/A==
X-ME-Sender: <xms:If8JYovRoCG2PrFeKf8mSnkwplAkCZd2tVA8TXXYo3IUlkb0aBarJg>
    <xme:If8JYlc21stkQtgipfMjF3qrsoJnSakUeXAXWazwjth7R6c6veTjdzV5lEWa9oP_l
    BP2Q0w0phYoJzeAvg>
X-ME-Received: <xmr:If8JYjylm8BjGNImEEMlqYWnSXown4sQDEcMWQi9CDC2wwSYFemGqqwF_QfZti-jd2IwiYQ61MVWhk7xXBOpuYUTzc09Cw-Phca9iBlziF5UvOzdZ1EullI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetteegffefgfffjeehjeehjedvlefhkedtffegvdekfeevkeettdefudduffegieen
    ucffohhmrghinhepthhhuhhnkhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:If8JYrOu7HiduabsdwebfBTA816P79iMeF0zCIPl8P6LDPulfrgMiw>
    <xmx:If8JYo_4AqUuiqL8otfFKh2aUt71Cbr0t5tSkjOej5I8nazUVq9ztA>
    <xmx:If8JYjXrTpTIo2doIPHWms5Qq3lBDYONQRGfYdvXEbk3eONgzTAydQ>
    <xmx:Iv8JYlMEpp9SfGm1jMnSCOp9lzBAy8-WmnhpFZsG8sKjxiA1NXArPA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 02:05:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 27eddc28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 14 Feb 2022 07:04:59 +0000 (UTC)
Date:   Mon, 14 Feb 2022 08:04:58 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
Message-ID: <Ygn/GvLEjbCxN3Cc@ncase>
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
 <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g>
 <xmqqy22u6o3d.fsf@gitster.g>
 <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
 <xmqqczjt9hbz.fsf@gitster.g>
 <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
 <xmqq35kp806v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aC2mGRr+6Tq6qwa7"
Content-Disposition: inline
In-Reply-To: <xmqq35kp806v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aC2mGRr+6Tq6qwa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 03:15:20PM -0800, Junio C Hamano wrote:
> Neeraj Singh <nksingh85@gmail.com> writes:
>=20
> > In practice, almost all users have core.fsyncObjectFiles set to the
> > platform default, which is 'false' everywhere besides Windows.  So at
> > minimum, we have to take default to mean that we maintain behavior no
> > weaker than the current version of Git, otherwise users will start
> > losing their data.
>=20
> Would they?   If they think platform default is performant and safe
> enough for their use, as long as our adjustment is out outrageously
> more dangerous or less performant, I do not think "no weaker than"
> is a strict requirement.  If we were overly conservative in some
> areas than the "platform default", making it less conservative in
> those areas to match the looseness of other areas should be OK and
> vice versa.
>=20
> > One path to get to your suggestion from the current patch series would
> > be to remove the component-specific options and only provide aggregate
> > options.  Alternatively, we could just not document the
> > component-specific options and leave them available to be people who
> > read source code. So if I rename the aggregate options in terms of
> > 'levels of durability', and only document those, would that be
> > acceptable?
>=20
> In any case, if others who reviewed the series in the past are happy
> with the "two knobs" approach and are willing to jump in to help new
> users who will be confused with one knob too many, I actually am OK
> with the series that I called "overly complex".  Let me let them
> weigh in before I can answer that question.
>=20
> Thanks.

I wonder whether it makes sense to distinguish client- and server-side
requirements. While we probably want to "do the right thing" on the
client-side by default so that we don't have to teach users that "We may
use data in some cases on some systems, but not in other cases on other
systems by default." On the server-side folks who implement the Git
hosting are typically a lot more knowledgeable with regards to how Git
behaves, and it can be expected of them to dig a lot deeper than we can
and should reasonably expect from a user.

One point I really care about and that I think is extremely important in
the context of both client and server is data consistency. While it is
bad to lose data, the reality is that it can simply happen when systems
hit exceptional cases like a hard-reset. But what we really must not let
happen is that as a result, a repository gets corrupted because of this
hard reset. In the context of client-side repositories a user will be
left to wonder how to fix the repository, while on the server-side we
need to go in and somehow repair the repository fast or otherwise users
will come to us and complain their repository stopped working.

Our current defaults can end up with repository corruption though. We
don't sync object files before renaming them into place by default, and
furthermore we don't even give a knob to fsync loose references before
renaming them. On gitlab.com we enable "core.fsyncObjectFiles" and thus
to the best of my knowledge never hit a corrupted ODB until now. But
what we do regularly hit is corrupted references because there is no
knob to fsync them.

Furthermore, I really think that the advice in git-config(1) with
regards to loose syncing loose objects that "This is a total waste of
time and effort" is wrong. Filesystem developers have repeatedly stated
that for proper atomicity guarantees, a file must be synced to disk
before renaming it into place [1][2][3]. So from the perspective of the
people who write Linux-based filesystems our application is "broken"
right now, even though there are mechanisms in place which try to work
around our brokenness by using heuristics to detect what we're doing.

To summarize my take: while the degree of durability may be something
that's up for discussions, I think that the current defaults for
atomicity are bad for users because they can and do lead to repository
corruption.

Patrick

[1]: https://thunk.org/tytso/blog/2009/03/15/dont-fear-the-fsync/
[2]: https://btrfs.wiki.kernel.org/index.php/FAQ (What are the crash guaran=
tees of overwrite-by-rename)
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/admin-guide/ext4.rst (see auto_da_alloc)

--aC2mGRr+6Tq6qwa7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIJ/xkACgkQVbJhu7ck
PpRUiA/9GkU7iwldPT9/FM8GyEgVomFRgKnW+bl0gwVzMRAJJQ9zuiIcQ/QzLXR7
OVfgF0gDZ0CeuwTC1YN86m0Y8DFPYSlnmbLe6tE/aqBYYv5IGc2d69rcwh89xm2X
eTcpHT4KjGuCCJsXxWVxi/ljW9CQZ0I/fZmVa5F5RhP8CAo3Ob/EgyvpcFgz++po
l1ved0nuPoNkimafnmVswQ/PYNyTBbjSeHre1apuPhr76YTTdXudy9wn4OjqPlu3
3i3mB0AAuXMHSGtIf1aL+aR53oYvKGHI1+N0tXBVvZ5y5rLqzMHWu5lj9h+6byT6
YEYC1tiaSKaBii1S1xXU7tPcKxWpPYG6yc5mESKAMaAhjT413fzLkyhncnqhNAHU
jHTp7exCxj4cQwgjxMCWIIoNPvPUk5z30ahgVHxPDXqfEf/moOraZ2BTxyO/tJwG
5aBvD4rGhQJruG07jKtghdGrYgvmGRutRsat9hVcf8cOR9iGftaStlAc6LdcrRkf
6AkTANNk5cZWIbE98RokAAQU9eTmQFmLPg2O8HC+OnX1iCct2hUC56O9beS03J3z
NJOZ660jUA1qjXZS4nn4C9SpGIYwkPFVq7Xti3haGxx2h2hwtYBcQrKhd3s2Zb5M
u2x0P4uEbmQVbNywzoHrlR7tkgfAYDZYv/Ktnc4W3Z19gFuS1F4=
=cjh2
-----END PGP SIGNATURE-----

--aC2mGRr+6Tq6qwa7--
