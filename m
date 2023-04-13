Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D03C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjDMKPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDMKOb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 06:14:31 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940CB83DD
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 03:14:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C36DD5C005D;
        Thu, 13 Apr 2023 06:14:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Apr 2023 06:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681380859; x=1681467259; bh=iZ
        5nknn8r5xs0blQNFb4rVLp0qxMv7SBGDRuKfje9ME=; b=Q8Kxe4ygsbdHJ6+DH3
        wMMrqxG2yP/YmIh3cUTFbFOdT+VgbcWm3zsOQ72UulKD7h5QKGWUU+gk5khqLyEE
        CAcz6qglNb0WTRcR0SNp3MkQJNvzSW5oY9Cg5WEPipgZs41E9SUZKfjY2VISGW8a
        rKIINviPMHRHZW5EBpSu5C+5RoboqWWGsL0KfAwLZuF1p52Y4ou/N/yUTOHXX3xO
        mj1rcrM5zJwggfdT4EGKIkqJXqlEFtbvj/8lave5ZoVg6yhbcIcZycSe7FnYP0cS
        c00zg8NMhGs+wMm9dyhIfHyvEIEvNBaPYvAmvElzt5EX3bo9cD0MBsyapkSIs6Iq
        fARw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681380859; x=1681467259; bh=iZ5nknn8r5xs0
        blQNFb4rVLp0qxMv7SBGDRuKfje9ME=; b=h2BgRA1r68nCcgw8LNu4avr9HUQxL
        abIVsWh0bEvgQjDPpLAb/l8RYoSfos/omE7m50wZ5w0TDaphQ2XkzVS/NzECE9pW
        sB0/AdYXb004sF57Ug76rlrFLhWvlPBV+qtds9KwhALvLcHr0lYZ5KDSNV5nVcU9
        MgaDaJ+CH1itVKo8p4pJ19dy5KRu7+FIjhD71m3CJ5GQU/f+gHD+rN4gk7ylOMl+
        zCRgli8l6qRCaHXHkoUCpVKi3ubvO8cO/1oN4TtlojpCoA6NP3ikaKeAHB//6viO
        pU2fSFJFnajaZSnXxOTN4eBdnGO1M/llHBkx59lZ83LdcXHLOqek3FSsA==
X-ME-Sender: <xms:-9U3ZLp9SuKUNHO2M9Iwohx_rd-2b8PVmGbIUvbYHaNr6yGeqxDFtg>
    <xme:-9U3ZFrAGsJW-eBZAt7KBZAjVx8w-I5zrBwxLL259TTtuciWAVin1W0e2JKsnOwdh
    7-BzwKoAdX5gXG5Cg>
X-ME-Received: <xmr:-9U3ZIMajQTg9UlEVRSIfRIJedMRzrhriETd9bwKjsXtiDTXMxep8Tr26MRT7pMG_A82wyaIaf9_dmQOkeChEH6z93zHqGPkeBzxcK8stmKVW_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:-9U3ZO5njQX98biSm1F9uzACJ7wKQw02EzX2wk2O2TG2a6OtagaWMQ>
    <xmx:-9U3ZK7YQNjywv5mcyFHjl38JvEbHiLeUkBEcI29TeCjXHqtjvr7zA>
    <xmx:-9U3ZGgyl3uFYF9bxbhlQlwNiVj6ZDDgyb5YxYsLvjGScoYjg17P4w>
    <xmx:-9U3ZKEN4Ubi1eSgMPoUFk4yxyoEMtACyWa64ajxeNOSmZr3pdKseA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 06:14:18 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 0c3f7f15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 10:13:53 +0000 (UTC)
Date:   Thu, 13 Apr 2023 12:14:14 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 8/8] repack: disable writing bitmaps when doing a
 local geometric repack
Message-ID: <ZDfV9gm779EsU3A4@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <b74d0a037b07706d07fad7b438fa0cb211726575.1681294715.git.ps@pks.im>
 <ZDcqIjSUMW4sKNXE@nand.local>
 <ZDfRb2PI-QJDavzm@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4i+dp34CvKpOisjW"
Content-Disposition: inline
In-Reply-To: <ZDfRb2PI-QJDavzm@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4i+dp34CvKpOisjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:54:55AM +0200, Patrick Steinhardt wrote:
> On Wed, Apr 12, 2023 at 06:01:06PM -0400, Taylor Blau wrote:
> > On Wed, Apr 12, 2023 at 12:23:01PM +0200, Patrick Steinhardt wrote:
[snip]
> > One thing that I don't quite follow with this logic is why we need to
> > have geometric_factor set. You could (somewhat unreasonably) write a
> > MIDX containing a single pack (git repack -[A|a] --write-midx
> > --write-bitmap-index), or a MIDX containing just the new pack along with
> > all of the existing (local) packs, (git repack --write-midx
> > --write-bitmap-index).
> >=20
> > So I think we'd want to drop the geometric_factor from the above
> > conditional. (And in the future, I think we typically refer to whether
> > or not the "geometry" pointer is NULL or not to indicate whether or not
> > we are doing a geometric repack, though the diff context doesn't give me
> > enough to know whether we have even attempted to set up that instance
> > yet, so this is fine, too).
>=20
> Mh. Yeah, I think you're right. I'll change it.

Actually, do we even have to care about the `write_midx` case? Right now
we have:

```
if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
    die(_(incremental_bitmap_conflict_error));
```

The intent is to die when not repacking all objects into a single pack
(potentially with a cruft pack), but to allow this when writing a
multi-pack-index because they can have a bitmap that spans across
multiple packs.

Now, whether or not we write a multi-pack-index, as soon as the user
passes `-l` we cannot guarantee that we have all objects available
locally either in a single packfile nor in multiple packfiles when the
repository is connected to an alternate object directory. So in the
spirit of the preexisting check, couldn't we do the following:

```
if (write_bitmaps && po_args.local && has_alternates(repo))
    die(_("Repacking local objects is incompatible with bitmap indexes.");
```

So in words, we die when the user asks us to write a bitmap index
for a repack that is supposed to only include local objects when there
are objects that could have been inherited from an alternate object
directory.

I'm not sure whether we are okay with retroactively tightening checks
though. I'd argue it's likely fine, because it wouldn't have worked
before this check either. And I'd rather fail with explicit reasons that
are user-actionable rather than implicitly somewhere deep down in the
callstack.

Patrick

--4i+dp34CvKpOisjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ31fUACgkQVbJhu7ck
PpSACw//dDGA7Th3HAnFNZIsq06U7aq1WWYisc8YfnwX1zp+XDwbf6Rah70SPMlr
JwuU0gT/lBSjGTXvPjasUkpIG0k8NeHP/nFUx9SbEQKFqfR1+t35zqnO1HbyXIsc
f2uj+vmRjHHS6B6gjh650ert9gjMMeL8MANo811nNcvMKFfno5jzeGTSsCU1gTFw
Osw/h2hv/70ih7IXSJzgZxaIuXYDybKmDoDUnlqRfOnes8BlmU470Vn4t4sWNhOQ
gsfA/sWI/3f4AMrYk8k9qE6n6LAKbdkYqLQD2Ab6dgCQsk941918twQ9JsIHC9bu
azDXG47RNcxuWMB7qRONpc5V27zv6k4PxH+Zsns6X9fcQxbBTKtAy/4L1Z/1A3LK
ZmExqH3CmmYhouh6hC86Ipb7u8U2CfzXPN8ZROuv41bF/KG7RYKddaIK1c9uGZc8
wo+z6qrilIy+EHe9wPr5VgtP71/WBK88+j2rvsXxWl4AzHdJ7lFJpHEp1t2l3PaG
cqQDPJrAHqLM7G8/jeeHPutty7N+q1wVoUQ7rFndDDCEACGGUXF55bGFAXKl1CNU
u3lII6aCa+mILog0/JAaBkFqyK+b81HqCZ9icnYwn9hB6kJ85TSfORtM+TPgKMqq
gLi4nexbXrzqGG7bujJb+uSWH4+OzBbf65kB+uxekIEZxjd6pTM=
=Av5F
-----END PGP SIGNATURE-----

--4i+dp34CvKpOisjW--
