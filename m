Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9AC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 12:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiBJM2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:28:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiBJM2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 07:28:05 -0500
X-Greylist: delayed 262 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 04:28:06 PST
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382BFE0D
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 04:28:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 844215C009E;
        Thu, 10 Feb 2022 07:28:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 10 Feb 2022 07:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=LF2Qr0+Ra0K2X2VH8dOKX5NWUhm9M2V6kCQeLQ
        SGALA=; b=GCpGlFDVe63MPxYO2P36Nc8l5Jp/0b5gI7aZ0b46c0lNyXzY//laCc
        dkIciT9t+CgForoGODib+Ovfwcpk97cCX+oj45ZDUBsY6M0IrUaRr9u9sjGcjNZx
        s0IWqqL+Mr22+kRzeZyerZqCr4KabanLFkhblQ61X3eDjv1tHp6qxlAM0JaVXWwK
        5g9HoIu1vn7I+EaYRlpocazvmFmdlfdDYZ1l7n8XjpAfp3Z72C+JtdAK3m/+i39o
        wm8SRv+lKnbh00dmSkGYqtow28vPj0ETnmVJyvTfzaJ5QYTOEw80JSLkoGI43wiL
        umJcYQ7XPYIrF6f+pZchpfewWNmBHkFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LF2Qr0+Ra0K2X2VH8
        dOKX5NWUhm9M2V6kCQeLQSGALA=; b=i3divHQXj+/rmSryi5H2Yt0UBgno2uDOu
        Uv7wybBcR6d3eSKRD2P2ihEG2UEZ/aYbR9TyeUZcRy/mCXQdpgJo+dbGRawZcooc
        +VDD8DppAeeqXmCuXSDCS5tvm97mgvT4D6WP2x5ZxZKU/zlKhj7/m364s6kCTS4H
        b1wfGSoP0UUXJXh2bo4y94b0cjmaMlqgWOL1ggMjETKsI9OumvEAletTw3ulxeUx
        OwSV1vpRQmTuHJtE1L5frDgYFzY8YFbMO5JP+xv5em6i1AFtp7FBhlsYABJHRBAk
        h/q0+EwsdFuEsH/C7tbt/QhyIruQv9mu2SB+e6MDevAaHiUToNYlQ==
X-ME-Sender: <xms:1QQFYmSsURZnP1zW41Vp2PfyT-TulqqnKNoNzsG1EUutK4A1EBT81w>
    <xme:1QQFYrxazs3Wn1lDiD2fr2XCo_mE6edHKvqomiRfB1KI0sEPpKxH-z44NX3-OjC2b
    SRcrv1ThGoqLPv5qw>
X-ME-Received: <xmr:1QQFYj3iEat_hrARNIwZbfQaKboePThLPlmqaQoHhg3gpnTolrLBAUiJuxnwaiVItIyAwDkaEzM7FNEjL43-bQ1zBS52jGMPCdMDVc5M43JeMzVp4QetsPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:1QQFYiCO_6Ic6KvIOicmoP3c3TxBE5t8hzNLvyheMiB-_l-nUAa7Bg>
    <xmx:1QQFYvgHRAIOXuDJkPHY3SMwpo9WfK9aGN9WVSV4GHQo52SgS4iruQ>
    <xmx:1QQFYurQpv8dwSMw5fJjhzFrdtZ321xtF_9u_eVA0uu-4YwZEnpbsg>
    <xmx:1QQFYiscW3flB_5RnKu6MHZVugQEFblsOggP9X-nlr9bXFQCzLL5ig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 07:28:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0e5abaf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Feb 2022 12:28:03 +0000 (UTC)
Date:   Thu, 10 Feb 2022 13:28:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/2] fetch: speed up mirror-fetches with many refs
Message-ID: <cover.1644495978.git.ps@pks.im>
References: <cover.1643806143.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3loII78sh8lB5QBB"
Content-Disposition: inline
In-Reply-To: <cover.1643806143.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3loII78sh8lB5QBB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series which aimn to speed up
mirror-fetches in repos with huge amounts of refs. Again, the only
change compared to v2 is a change in commit messages: Chris has rightly
pointed out that the benchmarks were a bit confusing, so I've updated
them to hopefully be less so.

Thanks for your feedback!

Patrick

Patrick Steinhardt (2):
  fetch-pack: use commit-graph when computing cutoff
  fetch: skip computing output width when not printing anything

 builtin/fetch.c |  8 ++++++--
 fetch-pack.c    | 28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 14 deletions(-)

Range-diff against v2:
1:  6fac914f0f ! 1:  077d06764c fetch-pack: use commit-graph when computing=
 cutoff
    @@ Commit message
         the commit-graph first, which is a lot more efficient.
    =20
         Benchmarks in a repository with about 2,1 million refs and an up-t=
o-date
    -    commit-graph show a 20% speedup when mirror-fetching:
    +    commit-graph show an almost 20% speedup when mirror-fetching:
    =20
    -        Benchmark 1: git fetch --atomic +refs/*:refs/* (v2.35.0)
    -          Time (mean =C2=B1 =CF=83):     75.264 s =C2=B1  1.115 s    [=
User: 68.199 s, System: 10.094 s]
    -          Range (min =E2=80=A6 max):   74.145 s =E2=80=A6 76.862 s    =
5 runs
    +        Benchmark 1: git fetch +refs/*:refs/* (v2.35.0)
    +          Time (mean =C2=B1 =CF=83):     115.587 s =C2=B1  2.009 s    =
[User: 109.874 s, System: 11.305 s]
    +          Range (min =E2=80=A6 max):   113.584 s =E2=80=A6 118.820 s  =
  5 runs
    =20
    -        Benchmark 2: git fetch --atomic +refs/*:refs/* (HEAD)
    -          Time (mean =C2=B1 =CF=83):     62.350 s =C2=B1  0.854 s    [=
User: 55.412 s, System: 9.976 s]
    -          Range (min =E2=80=A6 max):   61.224 s =E2=80=A6 63.216 s    =
5 runs
    +        Benchmark 2: git fetch +refs/*:refs/* (HEAD)
    +          Time (mean =C2=B1 =CF=83):     96.859 s =C2=B1  0.624 s    [=
User: 91.948 s, System: 10.980 s]
    +          Range (min =E2=80=A6 max):   96.180 s =E2=80=A6 97.875 s    =
5 runs
    =20
             Summary
    -          'git fetch --atomic +refs/*:refs/* (HEAD)' ran
    -            1.21 =C2=B1 0.02 times faster than 'git fetch --atomic +re=
fs/*:refs/* (v2.35.0)'
    +          'git fetch +refs/*:refs/* (HEAD)' ran
    +            1.19 =C2=B1 0.02 times faster than 'git fetch +refs/*:refs=
/* (v2.35.0)'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
2:  4b9bbcf795 ! 2:  ef1fd07be5 fetch: skip computing output width when not=
 printing anything
    @@ Commit message
         don't print the summary, but still compute the length.
    =20
         Skip computing the summary width when the user asked for us to be =
quiet.
    -    This gives us a small speedup of nearly 10% when doing a dry-run
    -    mirror-fetch in a repository with thousands of references being up=
dated:
    +    This gives us a speedup of nearly 10% when doing a mirror-fetch in=
 a
    +    repository with thousands of references being updated:
    =20
    -        Benchmark 1: git fetch --prune --dry-run +refs/*:refs/* (HEAD~)
    -          Time (mean =C2=B1 =CF=83):     34.048 s =C2=B1  0.233 s    [=
User: 30.739 s, System: 4.640 s]
    -          Range (min =E2=80=A6 max):   33.785 s =E2=80=A6 34.296 s    =
5 runs
    +        Benchmark 1: git fetch --quiet +refs/*:refs/* (HEAD~)
    +          Time (mean =C2=B1 =CF=83):     96.078 s =C2=B1  0.508 s    [=
User: 91.378 s, System: 10.870 s]
    +          Range (min =E2=80=A6 max):   95.449 s =E2=80=A6 96.760 s    =
5 runs
    =20
    -        Benchmark 2: git fetch --prune --dry-run +refs/*:refs/* (HEAD)
    -          Time (mean =C2=B1 =CF=83):     30.768 s =C2=B1  0.287 s    [=
User: 27.534 s, System: 4.565 s]
    -          Range (min =E2=80=A6 max):   30.432 s =E2=80=A6 31.181 s    =
5 runs
    +        Benchmark 2: git fetch --quiet +refs/*:refs/* (HEAD)
    +          Time (mean =C2=B1 =CF=83):     88.214 s =C2=B1  0.192 s    [=
User: 83.274 s, System: 10.978 s]
    +          Range (min =E2=80=A6 max):   87.998 s =E2=80=A6 88.446 s    =
5 runs
    =20
             Summary
    -          'git fetch --prune --dry-run +refs/*:refs/* (HEAD)' ran
    -            1.11 =C2=B1 0.01 times faster than 'git fetch --prune --dr=
y-run +refs/*:refs/* (HEAD~)'
    +          'git fetch --quiet +refs/*:refs/* (HEAD)' ran
    +            1.09 =C2=B1 0.01 times faster than 'git fetch --quiet +ref=
s/*:refs/* (HEAD~)'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
--=20
2.35.1


--3loII78sh8lB5QBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIFBNAACgkQVbJhu7ck
PpTpmQ/9GJtt1z64ki6jfu1UBA2u7ERN7N5PhcXQEmY6bQdTqGn0QbZO/OPk/9xx
qN8Aqmd2Ng0AIFKZwBkBx9Nm65nLvJL9VwJhoSHZeNt8Mww93i4KInXOkJhcepkr
eV7Mtkt+waNGYqW9QR+COMJm41SfiIiHfYpUIarxpWuagrlI9F/DsKIg4gpeB6bt
SgeirR2K9U8KhHoAyJTfCyw5em2aY6X7f6H1zXFFzjrGLappbO8nAXKEsto2vv9H
oJKURwyBxdlBliEvdwUCUdAjIQW2Dl8Q0jRcngJ6KiOsAdqSbuwDD5C4K67M++ME
1ShuHmc0EhUQGLAYV+CPRAUekt92RptQf+WuYw0VqtVK0xxMQ1xvUcbrjm9AW6xG
vlVRlNjeb2aVr8fGO08NzPTnJG8f5BzQq/9hqAlwFg0Zs9tS0q93PyuXxhrRJPTt
OjwJGA894Wv1U4V8/appoRCTwWwiB5vrhgEjp73BTAPynZna7ICTOtVGYEI3FNQz
hJdhP3qYT4eAGz7yQ2+XKLvMSUgTN+9Mty+234iF+P+LYwn6veyiXB9r+YmsyMig
cSkLclG3+uRgOqAJQj9j0RpzAUpZvZUICsvgTaVXpUrE0pqVY4GDFLFJaQIIupl9
6eDscNZe+xp0iyf5k2VKTydfXUWY4SxRUYkAMz8ZSf4X4k9eqx4=
=UPoZ
-----END PGP SIGNATURE-----

--3loII78sh8lB5QBB--
