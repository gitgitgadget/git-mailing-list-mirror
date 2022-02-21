Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7490AC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiBUH5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 02:57:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbiBUH5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 02:57:41 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448A2181F
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 23:57:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E4875C01D1;
        Mon, 21 Feb 2022 02:57:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 02:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=5A2CFYv8jgjasEDbgDR6DUZ44c3vF4H1J24TQ2
        CCjTc=; b=fyAjovAa0ExXm5GMExxmpvxDfebOgxAs9JDTFqdHhNt651FLBoWEBJ
        y4yqHuLKkAP89GmjUmdLEDoElJziE92sG1M/I0uvAvO2JbaFbe37Niob3sKO/wXM
        fBYFX2sgx/dxZsFs1QXqjXy2KGK1hqNPT7RpJa8D+fvVVOVeUj+ADxFi/lp73ykZ
        L0rj4cQxQUETXreQg47ptClJyXNX6GlLJyreuhKKnYwfR+bYrtyCCJZ8vgtfzS4q
        wuU31K1s7FqfsU2R3iLDeMN6iGDAiZDixCCZhPNeCFwhlIwZ98RrtQ8XIfsP3Jdq
        +kdJu65r0tq7TSkVmua5XSyBrZibQzwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5A2CFYv8jgjasEDbg
        DR6DUZ44c3vF4H1J24TQ2CCjTc=; b=NK0ionusH7dBWl6LO9KDEEyc/I4zIYLTd
        11pxFQQ2zFRRcI4yidfXirSLy7c34ygS6+qCAeea1C3X/pFKrCg0rpDbzBZG+SH5
        xCIokvmrR5y1umVPiKlwC9ozGUL+tzIbNKlePYdRc7+eN2LoksMVmwo8aZgfeYfD
        RFCGRtElh0+ylihP+gqasCh12tX/c0we1lENH+kKEcMyaNS0/FdFjv68tvJ6UDKk
        boc3mkHgXeeWUQUzwNDoKPBE/fKyDuoSYoI4zeXK7qOgvyiqaeq0HsOlkp0sxQwN
        JyQ0TVMtmy7H8zIubgVgd3pFfxMv0jcLxrSN3wlm85RRWOwMhGfZg==
X-ME-Sender: <xms:20UTYn2F5gYjit5Jz4rwOcwA_US4YKO3xQpCjzJZSi0388OdPfJ_yg>
    <xme:20UTYmFAR8mBv5SUvyh_RYYqLfFDAgoy3pvYWH-r8QGyb-PmKzgUPKDyXbCEb5BeZ
    _KuDe1jVxZ3SHgzgA>
X-ME-Received: <xmr:20UTYn7n-SUvzT3XTP-SSbDzUJ7qrXd5QA3TEhfyX0AkHBAT99Q7rgmhQ4WhXl4DbUJli-U8LM565wlsjR953o8k95bpTECsBSfDxwmcpZjh3HwwapgKzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:20UTYs0wbqLiG_1bd_6zG_MPSZtvTIWV8JUpxOVl4M_Ft1TC_UpOyQ>
    <xmx:20UTYqG5AijwZ585M5DQgB_EauYPImMjfQ5k8Wxb-jtdRg2Ec93dpg>
    <xmx:20UTYt9LQrs6E4yiy21Js_RdjorxSBLM7lAHZaEIln-Jvkmo4TaFuw>
    <xmx:20UTYvT5tGmzVHVmW76tMao-35Z4WA1KagQOilAyH0_aHI3UhfkSZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 02:57:14 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id da7533c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 07:57:11 +0000 (UTC)
Date:   Mon, 21 Feb 2022 08:57:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
Message-ID: <YhNF1Xc9GwGNXzhC@ncase>
References: <cover.1645102965.git.ps@pks.im>
 <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
 <CAP8UFD2kr6WJvv7eoDvytx5Q982XBXTpSTUQw5hXmRrDm-UuBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+zNCa98l1PYs8lA5"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2kr6WJvv7eoDvytx5Q982XBXTpSTUQw5hXmRrDm-UuBw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+zNCa98l1PYs8lA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2022 at 04:18:07PM +0100, Christian Couder wrote:
> On Thu, Feb 17, 2022 at 2:04 PM Patrick Steinhardt <ps@pks.im> wrote:
>=20
> > +test_expect_success 'atomic fetch with failing backfill' '
> > +       git init clone3 &&
> > +
> > +       # We want to test whether a failure when backfilling tags corre=
ctly
> > +       # aborts the complete transaction when `--atomic` is passed: we=
 should
> > +       # neither create the branch nor should we create the tag when e=
ither
> > +       # one of both fails to update correctly.
> > +       #
> > +       # To trigger failure we simply abort when backfilling a tag.
> > +       write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> > +               while read oldrev newrev reference
> > +               do
> > +                       if test "$reference" =3D refs/tags/tag1
> > +                       then
> > +                               exit 1
> > +                       fi
>=20
> Maybe the following could save a few lines:
>=20
>                        test "$reference" =3D refs/tags/tag1 && exit 1
>=20
> It would make the code look a bit different than in another hook
> script written below though, so not a big deal.

If `$reference` does not match the tag we want to continue and
eventually return successfully from this hook. But:

    $ while read foo; do test "$foo" =3D bar && echo match; done < <(echo b=
ar)
    match
    $ while read foo; do test "$foo" =3D bar && echo match; done < <(echo f=
oo)
    $ echo $?
    1

So with the proposed change we'd now exit the hook with an error code
instead of returning successfully.

Patrick

--+zNCa98l1PYs8lA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRdUACgkQVbJhu7ck
PpT+eQ/+MRRnVTjmNiuJyMfwpEzWqtngipO26/cOC6ggFr6+LYYIcip0FzS0YXSC
1UAgM+oWCFzjSS/BjZdx/6GRmipQW+rUQ/GeKwEx2sEPhjg8HmWcnAtlCQ94g5e+
g5jEVahrUjL38arO37NNAPKiuLLR5iVHlit8NdopwfhecpyqVadUdnMkOxyZaeo1
AhCeZ07n2gfD8KKJNXC2SbygToMPZ7m/otFDhHx1fN3TXRWGeOixiNK/mei9rqf+
LEW88e5GCbgDMGsjV1OkF28uBM9tza8NRRap7A+yKBN/l0H35lDn+PYbb8Mprb8v
eWDjYYdtj1mua34vkDlrgahfgYF+0DBeNoFhYM6gPvVEUkmXz6C7NXoMuiqj1jiM
SDhMDdTLt0s+M89rRpC7JaDpTX32CZqmFgZm3XyknZCpvHpZ/QVNSwjWN1kEBjBq
XIu/e6gaHYwYqwvmI5U/ELrsiGLOXtZuni8wLLBIud/KPQmLVipuY/BLPuHv18Sy
nadcCHJlo+JgDCxoNL62lIFbJWmcKSnaKCOR/eCODdvMrYyFTa37hCABPa//aXtW
C0KoM7iqQmsnWqqtjKanLz5Rsg7ToVILlD0W3V/tG8YHyD+ckUXIjg8jh1SYVjYz
YYVVZI0X4ZV59P3i3LqaUZeBTfm921JgBhjU/v/pMgFryXCMJXc=
=STLc
-----END PGP SIGNATURE-----

--+zNCa98l1PYs8lA5--
