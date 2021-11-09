Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CCC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3930361181
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbhKIL3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:29:00 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54827 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245748AbhKIL27 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Nov 2021 06:28:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 954E25C0199;
        Tue,  9 Nov 2021 06:26:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 09 Nov 2021 06:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=HA16qC5FLzWkrBdIjJGai0SdFWG
        RMBtrdBBVwwk3x9A=; b=qyPGh3WWYp2DoP2B1HVMgWdBf/IBTdWupKbknOche9W
        TQNs1gIEIpCVsavuVn7w0Av4e7wrmh/BzJCK2bvTUMA5KjYsa+4pWg7QstP8NYPD
        //r1sirY3pJEMW7n4tMAGBnEeCv4+KiiY4f3TvcspNrBrmgUEvV5XpNePx4znnWk
        h2mrT361n/T3i0ozZ68lIq1g3Txy7xgi7mulWDDf/GP0KLzItdhpzaMF2Xx94Apr
        Uz8d6sJ/Lv3CzMqUuZaYDCqQe6SLd4HP11wiPz6qR2Tb8xLgHsboyjZeXg661Oii
        1reN1xgUG4u2gipyj2yrDipCiesn8GJD9SO68SkPQ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HA16qC
        5FLzWkrBdIjJGai0SdFWGRMBtrdBBVwwk3x9A=; b=KQNSd4TAWayS7P4q7W8f1l
        kPe5PP/ETqc3jXl8ru2+lF525tYGQ8QD167Hdud4NpzeEKTLiigmvd3yS6DqryAv
        qTSWURsREfeLRCai9HwQy3DMcCOIw7A3J1Em2zpd96F4oF08CE7FRxBx6aF3BHJi
        kms3YF2J9AKrDaDROabj+gNIFCq66gm9tmAEY6js5CP+QN4juV7MJJt/gfzazj0O
        CqxSaLofKAwJa9DwikviBQiZdV+vqGBsiBtaneExp7FmlLz0Poo6hCo4dLZUn6eM
        z/x8zme2aQel93xld/cJGxrOw3fYTzdHA8aQFvSM8NUHKRCyzCTZ324WF55SBi7w
        ==
X-ME-Sender: <xms:1FqKYdPbhBecC-OXkkC8pxAmXRARWPnbAtBliAdj9rjbp82KSeb5lw>
    <xme:1FqKYf9Gi0nmHGmseIuOP0FOtgub2w7iYLMWZl3-AxjyN9XPR0FA1tgnKppxg_o79
    Piav6idt9J-V9E4mA>
X-ME-Received: <xmr:1FqKYcSsiv6qNaTfRJtK6EfDW_v9RJk486yxodXLCL04lMNxX-cob5VqaKAYbUvHnVUKsg6w1KI43dLvXtYjcNOVmF2N7srNaFriI7XtluL4FLRis_H6egNb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeggddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epiedvjeefheeiteekgeejveefffdtvedvudfgvdeuheeffeejfeetudeutdefgfegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1FqKYZsT13mcOJhxyHvsihT1fICFngLPcqodWcjCjB_PinqzVsrKpg>
    <xmx:1FqKYVdfWNUULVgc2UMp7ikHU8bPcval0twuM5C00z1KICta-IzhDA>
    <xmx:1FqKYV1eYxP7QJg6Jq74UicVLlhtaGqUlkWq4MMuwdGzv3YlDHqfWg>
    <xmx:1FqKYWpg-fB-5EjfrK4vGfT_NaeKBYD7wePB2eW05w4CP2IAOq8kaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Nov 2021 06:26:11 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5cd5fd5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 Nov 2021 13:11:48 +0000 (UTC)
Date:   Tue, 9 Nov 2021 12:25:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <neerajsi@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYpauqpBDVzOo+Px@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
 <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
 <YYT6tDyfBbwot2br@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UUqAsv8D7n7/4JFK"
Content-Disposition: inline
In-Reply-To: <YYT6tDyfBbwot2br@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UUqAsv8D7n7/4JFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 05, 2021 at 05:34:44AM -0400, Jeff King wrote:
> On Fri, Nov 05, 2021 at 10:12:25AM +0100, Johannes Schindelin wrote:
>=20
> > > So this will definitely hurt at edge / pathological cases.
> >=20
> > Ouch.
> >=20
> > I wonder whether this could be handled similarly to the
> > `core.fsyncObjectFiles=3Dbatch` mode that has been proposed in
> > https://lore.kernel.org/git/pull.1076.v8.git.git.1633366667.gitgitgadge=
t@gmail.com/
>=20
> Yeah, that was along the lines I was thinking.
>=20
> I hadn't really looked at the details of the batch-fsync there. The big
> trick seems to be doing a pagecache writeback for each file, and then
> stimulating an actual disk write (by fsyncing a tempfile) after the
> batch is done.
>=20
> That would be pretty easy to do for the refs (it's git_fsync() while
> closing each file where Patrick is calling fsync(), followed by a single
> do_batch_fsync() after everything is closed but before we rename).
>=20
> > Essentially, we would have to find a better layer to do this, where we
> > can synchronize after a potentially quite large number of ref updates h=
as
> > happened. That would definitely be a different layer than the file-based
> > refs backend, of course, and would probably apply in a different way to
> > other refs backends.
>=20
> We do have the concept of a ref_transaction, so that would be the
> natural place for it. Not every caller uses it, though, because it
> implies atomicity of the transaction (so some may do a sequence of N
> independent transactions, because they don't want failure of one to
> impact others). I think that could be changed, if the ref_transaction
> learned about non-atomicity, but it may take some surgery.
>=20
> I expect that reftables would similarly benefit; it is probably much
> more efficient to write a table slice with N entries than it is to write
> N slices, even before accounting for fsync(). And once doing that, then
> the fsync() part becomes trivial.
>=20
> -Peff

So I've finally found the time to have another look at massaging this
into the ref_transaction mechanism. If we do want to batch the fsync(3P)
calls, then we basically have two different alternatives:

    1. We first lock all loose refs by creating the respective lock
       files and writing the updated ref into that file. We keep the
       file descriptor open such that we can then flush them all in one
       go.

    2. Same as before, we lock all refs and write the updated pointers
       into the lockfiles, but this time we close each lockfile after
       having written to it. Later, we reopen them all to fsync(3P) them
       to disk.

I'm afraid both alternatives aren't any good: the first alternative
risks running out of file descriptors if you queue up lots of refs. And
the second alternative is going to be slow, especially so on Windows if
I'm not mistaken.

So with both not being feasible, we'll likely have to come up with a
more complex scheme if we want to batch-sync files. One idea would be to
fsync(3P) all lockfiles every $n refs, but it adds complexity in a place
where I'd really like to have things as simple as possible. It also
raises the question what $n would have to be.

Does anybody else have better ideas than I do?

Patrick

--UUqAsv8D7n7/4JFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGKWrkACgkQVbJhu7ck
PpSogBAAq1mMiL+DK37iqpUwQcT+V1hoIKsXXDptXbcmcRPntdSmFz9eDFKtJBaG
uVzgrsPM76Vv7Y8I0LLCzqyLqVSrxHDoq0uU7dBH8Gady0LMwXAOhqBp1XxzKRFX
mMNvDe/QRlBZiRlUgtgHn2H8U+CnLqdgIuTLGef/mMx9K/lzUtVvRoBwbNpUFU2t
lT5QNAmBIkLrA2fndm3iYohVXFN+7V6ga7jNbVS4p/qzUNxKErJQuDCdlkFs4QTy
s/LC9YOhqRtyyS72mB6aRyDRKEaqCeFcdARRCQEcRXshKQY2cYF9iS6Btvt6ie9E
Db2aYaOH0T2ZN9pCawomqnXu98t+qAHkzjKQuaqYPahRYMjedvx0eB9E0SFDiSAI
oFX+Ju9Dxe/BxOpC57GosZ85oy91aTp0w/3Ux3UBoNO6XGiOuSubQxbpt2zpIcQF
43Yrc28Q2SGk8Sxi74AGqrn7blsHKziHFvR1u+a6k6k7Q7kh6EiN6BQWBTJmTvXL
jESsQJ3+6prrM2VDAgus8oj2zeCNYiwKrOH5h8w/h/uIdeGOP2ot6zMTskVguHPN
VmCQ5hfBLAnhu88NjEllg+ZmfeeHK6azdPVMHowXrFWEwm4l5qN4sTnIg098S7oI
+P0lPn6jgtsykE3SsfwhfdUe+QVCt5ZuOlzkVl9OaAKrP+SP1kg=
=Qrov
-----END PGP SIGNATURE-----

--UUqAsv8D7n7/4JFK--
