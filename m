Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FC0C433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC23264EBD
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhBYG2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 01:28:33 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54015 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234029AbhBYG20 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Feb 2021 01:28:26 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3435F882;
        Thu, 25 Feb 2021 01:27:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Feb 2021 01:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=UPjv6G8mG+OnDysGbEA9QdtJ3EP
        C038+vkob5qWBwJk=; b=UfrqBWocOL69OYWltIsemQ96mFRZscwzdcTU2ShDPBP
        1AGxiRga+bHdA5Urxy5J9wGA7yaae6XNbBTb6JY9Z3hO2RKvHs77LpTUnQPXOWkp
        uFwxzwNYIEc9ATIn9KhgIoMQ1JKOKJ0isICvCEx9JASns9vOW7Cj7VEFwOvKln01
        QY2/cqdvDC527yZBBipQt+i4pHhuKgUr/WZ6LUgkVKjZHfFcrhdxSN2ixJygoQ0q
        +AaRcvdkzVQsGcU756oFu9YfouGWMwfh8tVly+c83E682EML3L6FoYGod0gCNvk3
        MNfIF4OKh1Td1G9GOFgWVWbKuv9xc0w1UKJ4qUkdsSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UPjv6G
        8mG+OnDysGbEA9QdtJ3EPC038+vkob5qWBwJk=; b=jSXV21EeUUyv3+Wucue+EW
        OwQePcCLDD1ry05o2o08zT2jpnxvarn/n3+4Ok8W4jpEbdBpKEHHTLufTMtFs1eo
        nRv9wLHrav5/DbY66w33RQMY7/T1xWQU4CUvPLQMBhE2kuKtko3cR36YF6T/BWqY
        NIKHRZoe0hzzjKE4eiCs5jtUD7jHSw4/BeXyCFPrG+GgZ2wsJk7voFAfbgWB4Uv8
        HrIKXuxvKXXKw0L7JpfOW9hiZPc6Ifj1aKfHqsRWjVsv6L+D3L2nTag2S1bJti7f
        TaOtSETC4x7gtxj+f/OldzxsK3aQx3vjlBemzl8jYVcsTQ52Rrs7wtMR2I1PoJMA
        ==
X-ME-Sender: <xms:VEM3YPGI7PvZarWWHIDZDzkNepQ1fCTribwOSeAIv4SmCdM2rjrifg>
    <xme:VEM3YMXw4ErRczufBeGfc1tn1LrEAiGBn17seAODXNChT3BOwXiL4HxkZAuYJ7yzI
    cT_uIfoV8QNiv2crg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeekgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudekfedrvdefrdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:VEM3YBLaE707cDvEno-_IixxUpcLBwhBcjQB7Lm1l4Nx1wQQLdIWBg>
    <xmx:VEM3YNFx20A6Rw5i9tg165dgszE00gPjUqSpA_lbbvJXaVoWjhrY_A>
    <xmx:VEM3YFUAoSwd9JttSnCwkdZKRhkI-AYcvmJH3pI666StKBxLEPT5cA>
    <xmx:VEM3YGdn5462UxCx2PaC_luH12JuBeo5yjTyFR4qqjg7FLIXHUd_3g>
Received: from vm-mail.pks.im (x4db71709.dyn.telefonica.de [77.183.23.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id A4F33108005C;
        Thu, 25 Feb 2021 01:27:31 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a79232f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 25 Feb 2021 06:27:29 +0000 (UTC)
Date:   Thu, 25 Feb 2021 07:27:28 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Yaron Wittenstein <yaron.wittenstein@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDdDUILUUXA1ytva@ncase>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
 <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net>
 <YDc3dinQ37FY8fhD@ncase>
 <CAGgn8PfdGBuB29Gxba6OmhSagjqwH2DNUv9XyJnXUhcKpJZBsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EpLjqSAA+7Xs1ion"
Content-Disposition: inline
In-Reply-To: <CAGgn8PfdGBuB29Gxba6OmhSagjqwH2DNUv9XyJnXUhcKpJZBsA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EpLjqSAA+7Xs1ion
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 25, 2021 at 08:01:11AM +0200, Yaron Wittenstein wrote:
> Thank you for the clarification!
>=20
> Is there any plan to support such a case in the future?

I personally don't have any plans to do so, but I can see usecases where
it would make sense. So I wouldn't be opposing any such efforts either.

> Also, I've observed that the "post-index-change" hook is being
> triggered before calling the "reference-transaction" hook (with the
> "prepared" state). It seems not intuitive to me since the index and
> working dirs are being updated before approving the transaction. (the
> HEAD still points to an "old" reference while the "post-index-change"
> hook is executing).

This is something that cannot really be helped though. The
reference-transaction hook directly hooks into the reference transaction
mechanism, which is how git updates all references. So we do not really
have any control over when the hook will get executed: it will simply
get executed whenever the reference transaction itself gets prepared
(refs get locked) and committed (written updated refs got moved into
place).

And that's by design: my objective was to catch _all_ reference updates
such that one can coordinate across multiple git nodes which all perform
the same action to assert they're moving from the same state to the same
state, regardless of whether they're doing a git-push(1), git-merge(1)
or git-update-ref(1).

So what you're observing is simply mirroring "reality": the order in
which git does its things here. There can be arbitrarily many
transactions in a given git command, and the only way this can be
changed is by changing how the command operating the transcations works.

Patrick

> Thank you,
>    Yaron
>=20
> On Thu, Feb 25, 2021 at 7:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Feb 24, 2021 at 04:03:14PM -0500, Jeff King wrote:
> > > On Wed, Feb 24, 2021 at 10:21:55PM +0200, Yaron Wittenstein wrote:
> > >
> > > > That indeed seems to do the trick.
> > > > I've done a little experiment and saw that when doing git reset the
> > > > hook gets called.
> > > >
> > > > However, when switching branches the hook doesn't execute :(
> > > >
> > > > I don't understand if it's intentional, since when I've moved to a =
new
> > > > branch HEAD pointed to another commit id.
> > > > The only workaround I see here is using the post-checkout hook in a=
ddition.
> > >
> > > Hmm, I would have thought that the branch switch would trigger the ho=
oks
> > > because they're updating HEAD. I wonder if that is a bug (or lack of
> > > feature :) ) in the transaction hooks, or something Patrick did
> > > intentionally.
> > >
> > > -Peff
> >
> > It was done semi-intentionally, or at least with the knowledge that
> > symrefs aren't covered. This is mostly because they're not covered by
> > the reference transaction mechanism itself.
> >
> > But this again reminds me that I still have to update the documentation
> > of the hook to at least make it more explicit what's currently covered
> > and what's not.
> >
> > Patrick

--EpLjqSAA+7Xs1ion
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA3Q08ACgkQVbJhu7ck
PpT37A/+KUWNaCLqH5e3bDFzb72BAk8HGgUnf1KYFz1cHZkUBBT1dZsUkxn4mXRi
+49BrWIhJWU8u71V9/az48/NoQxutjvQ5PELEtb1B4iETvAjoQKEKG38fs1pFe4I
nF6eA7amtfMU7zWPp9M+D/0lafZVXLKVPXp8YwFM1sUVT0nituYkGaV9xH0p216Y
2tKyCq6jS4cxh9JP4fqL+0DYStUOqHJZCVD+yN2KH7/vGh5xwARbYgN04bu/SLDo
BzazmgbxOSFn0/uCrro+td8XfD4nVjwVFyagMsUEkSOxg4hgQBQpgWp/kqPyyGL2
NzEosK6bAG7h81RILsUXrPTgi5F54po1vtUjbyH3cQQ2cUMB9NKV9cUmOJ4zBW0M
qPii3ikwHwcMcEWD7E8yCMYKRjCLWNqr7Gw6OCEWyQY9r/D8624b1jCnaRe2Pxx5
yM4hD9u/NG7Twx+VL8zjvhaVmDtMkKHsbb+RXTB8sMme7fA7mQvi/ci3QMQCkIsD
BuxO1XY4LZHL7ciQU+JHBDtC+c0ojkYMsVBdxn++cfKM0hlENH1zHvL7WRE3Map9
DiiXBpOSZmWeDJYqEu2/de9KKu0Oli4OBCvma1m3FqEuMqz3zk1jhi0GPjeuBAty
Lo9Or+2ZbW6iuASIDJnk+BMMb401ZT8rCAhgbsYz2dkqCXvtnjI=
=yAgp
-----END PGP SIGNATURE-----

--EpLjqSAA+7Xs1ion--
