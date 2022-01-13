Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFFBC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiAMGLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:32 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47785 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229839AbiAMGLb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:31 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 122A63200E5F;
        Thu, 13 Jan 2022 01:11:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 Jan 2022 01:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RRps0LIx5Y2yhoxIhRtuTz9KJZC
        A7UvuJgTGcKWwoJk=; b=UVk0yVRuQqTME5CeBS5cgPexgzW7qrmmuwHOebYqcdZ
        KE6Kk9162XtmX+sjHn0owvQjY/4ZOlYm9zGlwFwOAHMI582qY7Ze6g7h//eynes+
        E0XAh4cc9BwfgrBcW81QOizVJzOOiRC339E+Ji+sp3Yqlx7yomaXUPrn3U7ggEzE
        8zMaOt6nxmJhqCOaF/6T4icB/2CViq1xGsJR4ZHfcXuamsqsDI620XzArHMOtdFk
        UPCnClbyr+GaIddNVe8uFkT6mjPXaof3NB4wXqvIURoa+p1bNQIKgB7v7V1Hh8iK
        8/LoKoumTvAKgAgZ+U9zNrKz34p3EZQzUYCbdYUna/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RRps0L
        Ix5Y2yhoxIhRtuTz9KJZCA7UvuJgTGcKWwoJk=; b=g1cZ7woKybuy+xqCD7C8xV
        H1unsg3woBCgYZThXfA/5PQvt9eNfoywF35Dt5f1R9hVgWztqaYwjr5ODuT+lnlk
        XdV06O6l05NZ3jwI93T9FjZ6AkebVbHkYj0b5/pZJgUXmBvJJLurxshAEuttCRH4
        fgpsaNGumGwMk+Eznp7H2mX655V6pctewVetsD7vgQvOwk9MO5kdmH5gEboSlOtm
        svckXbM65E8Vr/8kfkVzCFfoaHrYRM1OCrap1fxEP34g8eSHCyR2RgiQbK34tJHU
        ITOrraMyYLWweBK/qZl/njowUaq5WwyVZZw6xX8gd8x1hpHIWXXI0euLtxAUhurw
        ==
X-ME-Sender: <xms:kcLfYe9fPRHE2Xu7JrMM7xpKLSXUrB87y_bdWytatPyVdynJyma1Kw>
    <xme:kcLfYeuunHXALN4SAzpSN1Vja_ucEgV4FO8HpclOH7UrO41PxcFJxdN7B5k7fHjrj
    TXLJkNSd3XTB3ApvA>
X-ME-Received: <xmr:kcLfYUD04doJFmIxxNQWpeqd2S-8PFd92u5mhrgqVKNTTSvulvsrNDLTRJOYjmG-pPBo8fQDR02-bvJAsD2NkNGeXwc0xJXzEge_kPFvfouekb2KIWFCHJ-N5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:kcLfYWfriSOQJB9fuXwbsQpvGNJz2o3WzalIhNiXDmGuHcxfS_8sSg>
    <xmx:kcLfYTOJb5yZ0Qqhnp7v27viF-tYFDVHfcF-E7DcFnB7-sCyruXEdA>
    <xmx:kcLfYQnZqwZPhOYvUCRW4M9lxbpVBPRjWdx1ASRg_2UgtnNrjhZxNw>
    <xmx:kcLfYYovtsFrt0ubjEfEqH17veLg9yYirQIrUWu7tMqmyY8DMddbrA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:27 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 679a90d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:22 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 0/6] refs: excessive hook execution with packed refs
Message-ID: <cover.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PnDstMQ7uy3v9nLX"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PnDstMQ7uy3v9nLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of this patch series, which addresses an issue
where the reference-transaction hook is being invoked twice when
deleting refs both in the packed-refs and loose-refs file.

The following things changed in comparison to v2:

    - Fixed some typos in commit messages.

    - Improved the subject of the first patch to more clearly highlight
      the purpose of it, not only say what the patch does.

    - Fixed a missing declaration for `struct string_list`.

    - Clarified why the last patch does the right thing even in case the
      ref only exists in the packed-refs backend, and in case it doesn't
      exist in either of the backends.

Thanks for your feedback!

Patrick

Patrick Steinhardt (6):
  refs: extract packed_refs_delete_refs() to allow control of
    transaction
  refs: allow passing flags when beginning transactions
  refs: allow skipping the reference-transaction hook
  refs: demonstrate excessive execution of the reference-transaction
    hook
  refs: do not execute reference-transaction hook on packing refs
  refs: skip hooks when deleting uncovered packed refs

 refs.c                           | 11 +++++--
 refs.h                           |  8 ++++-
 refs/files-backend.c             | 25 +++++++++++-----
 refs/packed-backend.c            | 30 ++++++++++++++-----
 refs/packed-backend.h            |  7 +++++
 refs/refs-internal.h             |  1 +
 sequencer.c                      |  2 +-
 t/t1416-ref-transaction-hooks.sh | 50 ++++++++++++++++++++++++++++++++
 8 files changed, 114 insertions(+), 20 deletions(-)

Range-diff against v2:
1:  0739f085b2 ! 1:  abbc28822b refs: open-code deletion of packed refs
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    refs: open-code deletion of packed refs
    +    refs: extract packed_refs_delete_refs() to allow control of transa=
ction
    =20
         When deleting loose refs, then we also have to delete the refs in =
the
         packed backend. This is done by calling `refs_delete_refs()`, which
    @@ Commit message
    =20
         Extract a new function `packed_refs_delete_refs()`, which hosts mo=
st of
         the logic to delete refs except for creating the transaction itsel=
f.
    -    Like this, we can easily create the transactionion in the files ba=
ckend
    +    Like this, we can easily create the transaction in the files backe=
nd
         and thus exert more control over it.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ refs/packed-backend.c: static int packed_delete_refs(struct ref_stor=
e *ref_store
      }
    =20
      ## refs/packed-backend.h ##
    +@@
    +=20
    + struct repository;
    + struct ref_transaction;
    ++struct string_list;
    +=20
    + /*
    +  * Support for storing references in a `packed-refs` file.
     @@ refs/packed-backend.h: int packed_refs_lock(struct ref_store *ref_s=
tore, int flags, struct strbuf *err)
      void packed_refs_unlock(struct ref_store *ref_store);
      int packed_refs_is_locked(struct ref_store *ref_store);
2:  629be01d50 =3D 2:  9dd172a757 refs: allow passing flags when beginning =
transactions
3:  550d89a323 =3D 3:  be826bae3b refs: allow skipping the reference-transa=
ction hook
4:  b52e59cdac ! 4:  662a6e6244 refs: demonstrate excessive execution of th=
e reference-transaction hook
    @@ Metadata
      ## Commit message ##
         refs: demonstrate excessive execution of the reference-transaction=
 hook
    =20
    -    Add tests which demonstate which demonstrates that we're executing=
 the
    +    Add tests which demonstate that we're executing the
         reference-transaction hook too often in some cases, which thus lea=
ks
         implementation details about the reference store's implementation
         itself. Behaviour will be fixed in follow-up commits.
5:  1539e9711f =3D 5:  d83f309b9c refs: do not execute reference-transactio=
n hook on packing refs
6:  0fbf68dbf4 ! 6:  279eadc41c refs: skip hooks when deleting uncovered pa=
cked refs
    @@ Commit message
    =20
         Fix this behaviour and don't execute the reference-transaction hoo=
k at
         all when refs in the packed-refs backend if it's driven by the fil=
es
    -    backend.
    +    backend. This works as expected even in case the refs to be delete=
d only
    +    exist in the packed-refs backend because the loose-backend always =
queues
    +    refs in its own transaction even if they don't exist such that the=
y can
    +    be locked for concurrent creation. And it also does the right thin=
g in
    +    case neither of the backends has the ref because that would cause =
the
    +    transaction to fail completely.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
--=20
2.34.1


--PnDstMQ7uy3v9nLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwogACgkQVbJhu7ck
PpQl2w/9FAcOg2OjITJ1D7yBYK0kZ2Z0gb3wH4+ZhQQf431P/J3pSWn8bJeA4GYp
Id4WZw3T7ot4I2t9tw3QgksOn0nMiLfaQFixOeI+WZNYUp/93yEU19aM51INS26D
w3Un5r2pMEu440JS0moirs7sLLHOe/KEm/vi/rk6C9a49pKGwlBrI6OxBRkG35tm
AmKSiOhTXjK+o16w4lBsfbP1/SkEDuRnp2D+iDxAtNyDraU2Fv/VsmkHqJK6RP2n
qeZkLaEeMKz+06G0EgzNM1ZAIvNNwLGQz7GzO+2TPUQrrePTI8507+WKdWblM1/t
sLotkjPx/4b7L7/NhF5vlMSEcztHFb0aatgdogdFm1LIQWbBtwwdyMKI/CssbgBp
4le1Lcn0jnw3KWZmG4dAO3sNtFftv/3PhKSgjuQC1vhFJvMdAl6AC5Vhrfay2LPF
6mczrpPn1onaZnUF4rpxLvkJJNQ9fCJ9h/Zmuv+Zteb9urLYvhQSDuBt2Qc6KTOt
7kZXzxuqXFFHafFWxjdPGdb5QwAHBNcos0gFsM+GXMBvU4aQi0gDRNWn3qNYh7O4
HJla/nD0gnI08IPRJWPjcvv4vaqvFtLScK9dlJaTRiwFfXK2wVoDNZJV7USpiksh
XWPd5UdQaPbHej4vr666hfGD6lN0LXIpa4iaLcfnnOclX+GBo0I=
=pLTf
-----END PGP SIGNATURE-----

--PnDstMQ7uy3v9nLX--
