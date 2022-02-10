Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B34FC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 12:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiBJMay (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:30:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiBJMax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 07:30:53 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD91121B8
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 04:30:54 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E2E9E5C019F;
        Thu, 10 Feb 2022 07:23:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Feb 2022 07:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=2zfIgB5o5/nNFbkpU57MGQgF84aQui4IPvOBF+
        DvK98=; b=FLIO18NJ/fr1M7RNNFc4XM1DSZ///4cTVxzI9BzCAfrrGbw4aHMVwV
        KdfJ9lxNdsk9tiW3kqsVGeOUgrO7mIJ3kT5CZ+af9LSdDGJPoPdyBOZvoN6WqO/2
        IpVYjXHodEQ0zpBT+nP89R5x0GtZtAnnBeIHRv//SksYJvUibbH35e+nu7k/sVvj
        uNilRhntCrzoFIiIaC/LAJMJ6w5R244mEVE7fLyepwannQ+o/Suz38dOgiBiKDTu
        HOOLZJXS2hnIWQAHAEIs0nh4ahwdS9C19I4CWXqMWkfneWKSvfhISBaDjFP5mpKO
        U3RqNrHFL9pn8+BRRPWVw8g9VvjnQr7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2zfIgB5o5/nNFbkpU
        57MGQgF84aQui4IPvOBF+DvK98=; b=M+6OorkOZ3aZNaUNxefuKWuV8thBXV4nE
        3Cjh5Fl25GHfRJD7DtKU6ckFLpgIiFdqGvV//u+V+nVOUTM0aIDA8KBf95sfoV6I
        UdhD77521uJ3yfmvFHou+i30JfaHASlJxkscAZXVR1GZ9kgzrJz5y7e2NZ8HPh6v
        YlxJnyPjhcVGs2FXtehjKKNeh0nSuTYfWOSHS056cxidri0EkQuqtjLHmA0engeI
        UCP8l6kcRyObFFPe/LaLDB7oMYbQsCBvPrejYhMUnfY3ivJaRPmBItgBHnOBhRck
        dWm7x0EO5wlrZzCc6az6ddU0bwEvjya/Mky9O5/gE98DvDBv+o4sA==
X-ME-Sender: <xms:zAMFYqWj1u_tWiqHryCk0p3_vCRz-dimGhhh8HbMD5wr9Mj33ipCgQ>
    <xme:zAMFYmkHfC__eRLFVnewqsvH1k1uI9gKdxyy5G4uw1w6nYFLVrZICjEL3uJBrTF60
    hqh1ND5QS7UdqRHTw>
X-ME-Received: <xmr:zAMFYubVo4Dp22f61BpHFY8vM0dIf27Xt0ZhLdsW0SR1Lra7H0AkbvvkR6MmiB0ZMqUIYfN7hlc_Fri9FY8QNnVqNOLoBOjyNEPm0e12C2uUU5fa-YOPLyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:zAMFYhUj2uB8p1CkzxKDUQjdH8V8C5l70ECHzyswm8x9vp0D-WRm6w>
    <xmx:zAMFYkmSBYJ-WCGN2er75Ab1QJfYJdU82Dldk0fbP5G-pUg06I358Q>
    <xmx:zAMFYmd7_wdmFo35wzoyEQW9hV5womI_R-Oysa8r7Q1bVlRpxfvHjw>
    <xmx:zAMFYpw_63DQA4-W31-MIFjhxiW3xcsz0nN6tH14LvKruIgrvnfG3g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 07:23:39 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f9d70873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Feb 2022 12:23:38 +0000 (UTC)
Date:   Thu, 10 Feb 2022 13:23:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] fetch: skip computing output width when not
 printing anything
Message-ID: <YgUDyLhO7UykfbF/@ncase>
References: <cover.1643364888.git.ps@pks.im>
 <cover.1643806143.git.ps@pks.im>
 <4b9bbcf7958da6db2be771f910974a6bffb2d94a.1643806143.git.ps@pks.im>
 <CAP8UFD0r2ZnGCAjkQcLfEZCvxHVFGSWeAC7vSat7V7-=rhiGeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZgJ+Beug7xTIw2S"
Content-Disposition: inline
In-Reply-To: <CAP8UFD0r2ZnGCAjkQcLfEZCvxHVFGSWeAC7vSat7V7-=rhiGeQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7ZgJ+Beug7xTIw2S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 07:10:38PM +0100, Christian Couder wrote:
> On Wed, Feb 2, 2022 at 5:13 PM Patrick Steinhardt <ps@pks.im> wrote:
>=20
> > Skip computing the summary width when the user asked for us to be quiet.
>=20
> There is a --quiet option for git fetch, so here we can expect that it
> will be used to test this speedup...
>=20
> > This gives us a small speedup of nearly 10% when doing a dry-run
> > mirror-fetch in a repository with thousands of references being updated:
> >
> >     Benchmark 1: git fetch --prune --dry-run +refs/*:refs/* (HEAD~)
> >       Time (mean =C2=B1 =CF=83):     34.048 s =C2=B1  0.233 s    [User:=
 30.739 s, System: 4.640 s]
> >       Range (min =E2=80=A6 max):   33.785 s =E2=80=A6 34.296 s    5 runs
> >
> >     Benchmark 2: git fetch --prune --dry-run +refs/*:refs/* (HEAD)
> >       Time (mean =C2=B1 =CF=83):     30.768 s =C2=B1  0.287 s    [User:=
 27.534 s, System: 4.565 s]
> >       Range (min =E2=80=A6 max):   30.432 s =E2=80=A6 31.181 s    5 runs
> >
> >     Summary
> >       'git fetch --prune --dry-run +refs/*:refs/* (HEAD)' ran
> >         1.11 =C2=B1 0.01 times faster than 'git fetch --prune --dry-run=
 +refs/*:refs/* (HEAD~)'
>=20
> ...but --prune and --dry-run are used for testing. It would be nice if
> this discrepancy was explained a bit.
>=20
> Otherwise the commit message and code look good to me.

Yeah, I was hiding away the `--quiet` flag here by accident. I used
`--prune` and `--dry-run` to trigger more lines to be printed to console
and to not take into account the time it takes to update local refs and
fetch objects. But doing so without these flags also demonstrates what I
want to:

    Benchmark 1: git fetch --quiet +refs/*:refs/* (pks-fetch-pack-optim-v1~)
      Time (mean =C2=B1 =CF=83):     96.078 s =C2=B1  0.508 s    [User: 91.=
378 s, System: 10.870 s]
      Range (min =E2=80=A6 max):   95.449 s =E2=80=A6 96.760 s    5 runs

    Benchmark 2: git fetch --quiet +refs/*:refs/* (pks-fetch-pack-optim-v1)
      Time (mean =C2=B1 =CF=83):     88.214 s =C2=B1  0.192 s    [User: 83.=
274 s, System: 10.978 s]
      Range (min =E2=80=A6 max):   87.998 s =E2=80=A6 88.446 s    5 runs

So again, I'll update the commit message.

Thanks for your feedback!

Patrick

--7ZgJ+Beug7xTIw2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIFA8gACgkQVbJhu7ck
PpQPzg/+IPCLFyoM6PMaoxiIg1KaZC1j87sh6vvpmfGqm0MrRSEq8b3Cg3/GTM6z
B+eHdOlj3xX8bycVWIH5Xu4/aj2WIrKAKdwJDwIZ0Y2iibGfbiXrcvZK/yj77rGP
tRkrwc8C1M8Sj10X5zoyTXNXWdi3cDgteeFOithi8qUR7BO0jnbeMMbRied+lynI
8VJC3XizCAGlFQsr7UC1IccnOCh725CMZJCsobqkgYQ4cc/xOb7TkTAnXkCnN3Wd
UKx2U1cluCEvK1pdPm+CbdH4U80AZZ3FDZdIr4lyVHp7728DR9a/rTuukc20olz9
OvI67xDzowCQJkKJ1jb1aKZNAr3PMz3jCFx+eN7Ohq/ykX0pEqKEOm0xuyuisQtz
KX3MWF1xaL8wqJQnPz42Ja/rCBa1q/bEv6ZrFnc0Gucr7a1r7mAKw8Pc8VZtTUXA
8gIhBAlCrwXiQ/+qy6VfMeUzF642BuBD1lyRqZgbXfGmThUaQgpdzN32Rug3bsu7
wPsPY/vyoNABbOm2lAzyOM1/2l18MsiO/ErRVKXH5eXvB5uqLmqN9RJLK1XMQkRu
wF+zUkALcx9sCjoH3CdMYEYKKrfwTLra9wTVevpbZXgU/yWSeLmSdRpNdOfVj5+N
7L0PI8a4FSCk8eAcyBe4zXBHtvzfgtLMLbrtOC4kcGwbHikSeMs=
=604Z
-----END PGP SIGNATURE-----

--7ZgJ+Beug7xTIw2S--
