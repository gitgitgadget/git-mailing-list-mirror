Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13C860F45
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhIFGzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:55:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60739 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239629AbhIFGzo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Sep 2021 02:55:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AB955C00FB;
        Mon,  6 Sep 2021 02:54:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Sep 2021 02:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=TjPae/AgNq+6ZijXRc1cIj30Oqj
        ePkJFxygtiX8M4T4=; b=I2cJTyMvUCII+kRFXWo16hIMgeOVc6Ba93YnW22bjBE
        DnBt5RmZ5pGGtBnElLjthXk6nLxfuxPA+XzQOWesyjbdoORSPrVm1yvEpGazvKi1
        Lkkn/eygc1bsJB4HZyZSNkfbjXdoq+zXUT4FOQJjGlfaQ0VxA8BRtZ2Pp1oHGkNT
        KKQpZEQuJvtmNl5fc8j5pGPnsCHRDk/OvLQ05K+q7uC30fnLnVCXGQT+OiGuk4yF
        HOBdLQuQuFfvOQwMOWir0lelNOGO0nOLeMV6fY3nQxTTWSoFZKjY/U5jNH5sjx2B
        gr35d3v7iPwj7zsj4QDlEGJbXhCskAtbURnFDQLgVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TjPae/
        AgNq+6ZijXRc1cIj30OqjePkJFxygtiX8M4T4=; b=A9zGxnaB0qS8m18Uo02N0c
        xv8kxyfLtUspSALcViKc9CsOMbx1PqetHErnL/L8ADkQQ/oRL65E8QmCVkBw5z7t
        kFEAze3mcUthk0a6jRqauj242engvOEGDl7z9G+ovyRQ8TURF0fV6/r+d/02ngn0
        8Nx3hnPWxZuaC7NZ1eC6/mNtT/mxZaGu+9MP2Itc17mKXb8D9EKACmq5K+Qkk8ZE
        iFtARfENS0MYCAxSYgMoio2UtdASzr1ZZGCkz/m9HBsk0S5bMelnHo3iDS6AVIny
        Y3ncdzr1oz3/nsfkmCm53zn66ZN8sRp3D+6cj4QrhqqS1RsiKgUK4jBCHSiw3MLQ
        ==
X-ME-Sender: <xms:L7s1YcmjdYbnKazAbN5NAl98c8WFQFGHKA3yzan3_kLnlCQlAx1Lng>
    <xme:L7s1Yb1uf4TAtGFI5oHpaapt604_TP3MDU0uc0lr_X6gmxjlQo0TkUR4Gk2yViixf
    tVN_KSfgvzSN91d3w>
X-ME-Received: <xmr:L7s1YapMXNtXFY_0dYlc-C9eTMDkN31EE8uef1mHuzCwdZjyopCvNjNMkKNhxi3oUYzGGdgXaQz3bLnorIxdmeQz0Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfe
    ejiedvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:L7s1YYnMyLBjjJj_Yrv2dOSFALns0f6kT9np2TE1RjUAkpriDSY3HA>
    <xmx:L7s1Ya3w0UUQ2KPSD9H0w46Ys7n1SQ6iH_XeRw3iwRMIrkW5gB06QA>
    <xmx:L7s1YfuDAb8LRX_HzPj6TYD06SnfkUOzy9ad_2uq5SYf_7v-HfqZqA>
    <xmx:L7s1Yf9_D0OcN6NaBpVrZiIloKBwmZE3N83iDrwl9UgGucaog1Sing>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Sep 2021 02:54:38 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 92b3c718 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 6 Sep 2021 06:54:30 +0000 (UTC)
Date:   Mon, 6 Sep 2021 08:54:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
Message-ID: <YTW7JV0sCq2rqvRT@ncase>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rvtVv7RC68dThjp"
Content-Disposition: inline
In-Reply-To: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3rvtVv7RC68dThjp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 04, 2021 at 08:40:35AM -0400, Jeff King wrote:
> Somebody complained to me off-list recently that for-each-ref was slow
> when doing a trivial listing (like refname + objectname) of a large
> number of refs, even though you could get mostly the same output by
> just dumping the packed-refs file.
>=20
> So I was nerd-sniped into making this horrible series, which does speed
> up some cases. It was a combination of "how fast can we easily get it",
> plus I was curious _which_ parts of for-each-ref were actually slow.
>=20
> In this version there are 2 patches, tested against 'git for-each-ref
> --format=3D"%(objectname) %(refname)"' on a fully packed repo with 500k
> refs:
>=20
>   - directly outputting items rather than building up a ref_array yields
>     about a 1.5x speedup
>=20
>   - avoiding the whole atom-formatting system yields a 2.5x speedup on
>     top of that

Interesting, thanks for the PoC. Your 500k refs naturally triggered me
given that I have recently been trying to optimize such repos with lots
of refs, too. So I ran your series on my gitlab-org/gitlab repository
with 2.3M ref and saw similar speedups:

    Benchmark #1: jk-for-each-ref-speedup~2: git-for-each-ref --format=3D'%=
(objectname) %(refname)'
      Time (mean =C2=B1 =CF=83):      2.756 s =C2=B1  0.013 s    [User: 2.4=
16 s, System: 0.339 s]
      Range (min =E2=80=A6 max):    2.740 s =E2=80=A6  2.774 s    5 runs

    Benchmark #2: jk-for-each-ref-speedup~: git-for-each-ref --format=3D'%(=
objectname) %(refname)'
      Time (mean =C2=B1 =CF=83):      2.009 s =C2=B1  0.015 s    [User: 1.9=
74 s, System: 0.035 s]
      Range (min =E2=80=A6 max):    1.984 s =E2=80=A6  2.020 s    5 runs

    Benchmark #3: jk-for-each-ref-speedup: git-for-each-ref --format=3D'%(o=
bjectname) %(refname)'
      Time (mean =C2=B1 =CF=83):     701.8 ms =C2=B1   4.2 ms    [User: 661=
=2E3 ms, System: 40.4 ms]
      Range (min =E2=80=A6 max):   696.1 ms =E2=80=A6 706.9 ms    5 runs

    Summary
      'jk-for-each-ref-speedup: git-for-each-ref --format=3D'%(objectname) =
%(refname)'' ran
        2.86 =C2=B1 0.03 times faster than 'jk-for-each-ref-speedup~: git-f=
or-each-ref --format=3D'%(objectname) %(refname)''
        3.93 =C2=B1 0.03 times faster than 'jk-for-each-ref-speedup~2: git-=
for-each-ref --format=3D'%(objectname) %(refname)''

[snip]
> I'm not sure I'm really advocating that we should do something like
> this, though it is tempting because it does make some common queries
> much faster. But I wanted to share it here to give some insight on where
> the time may be going in ref-filter / for-each-ref.

Well, avoiding the sort like you do in #1 feels like the right thing to
do to me. I saw similar wins when optimizing the connectivity checks,
and it only makes sense that sorting becomes increasingly expensive as
your number of refs grows. And if we do skip the sort, then decreasing
the initial latency feels like the logical next step because we know we
can stream out things directly.

The quick-formatting is a different story altogether, as you rightly
point out. Having to explain why '%(objectname) %(refname)' is 2.5x
faster than '%(refname) %(objectname)' is probably nothing we'd want to
do. But in any case, your patch does point out that the current
formatting code could use some tweaking.

In any case, this is only my 2c. Thanks for this series!

Patrick

--3rvtVv7RC68dThjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmE1uyQACgkQVbJhu7ck
PpQlSBAAiqeU8ONvHxw4ie5n2nYGJrlBSYB6wBTPEGgsUR4uJPFQ6qMmpnh3PWTE
IG5ytnaO/VjH8tarhrvYYz9iF0cbA7PmsrOcGOxX/68XoZQt7SZ/3KN0LVWlLEjM
iH4/aPKXQ7k5e2nes0OUYScqrbqo21cDB0Jk0M3lrWaMWtBE3ALpcCNo53Yjzzld
1fmeYI5BLxetn5HJ5i0vbvJBZDggN9CLR+NpUGZfmvtLJY4abw/7qHzQ8I4nEfK8
0h63TAxO4bmtwOqJ8UK7p0MWrGOt7KYTUdUdvtckVxH6nqsxWq0zXkPlKRaY8avn
Z+CxCNX5p3W4JZLxFJonJUm8PoHziPxqgleUBXuXpNjerDOCPNn7UNkF6SMUfFBh
eVU9OHeH9cpDsT5aQT01/sq1Vw/rmZKk8CLBqlglkN95nzd9Al2GTxTiRBhlnc2J
6pmN395XfxUytPaKGMM1olzE24k1iQGDHw4EyA/4EzjPAMANxaVylZY9Og8hHCZc
zLz9dnqv2q8VlgWLScz16lZYG3YS/7o8/sU+V8EdG2EOI21Os+d9V5EieGUl79oz
xGULRpVtyL90GHYko8RB+meymufcdEyTYaZt2WitWcXE/nefjKH1qtGA/FIAQHGY
DIcSxQtvw5+DGQzrsQJ+G0ai+ixBDjefiRN+INepH1Mdkv/O1Us=
=txtT
-----END PGP SIGNATURE-----

--3rvtVv7RC68dThjp--
