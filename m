Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22EAC433E9
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 07:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D8C64F18
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 07:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhCRHdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 03:33:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58963 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhCRHdM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Mar 2021 03:33:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BBA135C007C;
        Thu, 18 Mar 2021 03:33:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Mar 2021 03:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=zZQZV1e+umkn1xvhZCwsqOAkehn
        ZFFF5NLl3c4QQl6U=; b=sDROBRrtyEDSHfc+0Rz1c+9kO9BiR/Inw5dakpQotpD
        HnbzeGinuczo+niSNf2uVWP2RAbkX1lj63nVMS0wHYH7/+pQiwSD6QfO4SCgKuPM
        Q/msoG5B2yJjl2VIQrURysi0NCffMKlzKE4AdtloDLny3bmS6pkTqeSqwHf5GWe8
        WPAuJJ0zPYvmi36XwSytg45HFAPizHYszexuranLmLlInTfkkYhIxtDbN1pghqvH
        ni0NnRFZxaq9n6j/+mvZgeJejEmXSbr90Exepqm5L0+JSF8ZrpCKgFRh8Y9OMeGP
        1wr55wM8abKHI8nmF439T1yMHTl3EA43NVdZTFORm1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zZQZV1
        e+umkn1xvhZCwsqOAkehnZFFF5NLl3c4QQl6U=; b=q1mjjbQAZ/AleDaaKAInM+
        A16/766rGr97U4l6DLy43AamNqenvMvuJFgzRzn70PvmyKwG5vWY6zoC9QrU3ttE
        hoh0OaC7p2n8J30XaCVSoiWEXDmqJgN1+eancVW8Ekbm2FHIm/ppKEZs5XWxzzoY
        WNC2E6GwmLxZ3ybPHgjCQ7L0RO+8FMeyd4f57FFb5KduCOlM9C2bGrf9dIE3PXd1
        YVIWf4yl5PITBVZicZ2NFqNJ8dqwslXdV43RmsgutS8T9OSBRSyv0WkbQaf7aSvT
        9z8zHWrLe2IvDZ9oztEq1ogwM3BTlfu0X3wg0PMT4nXb1XPVfrTLKPEdc5kQnLFg
        ==
X-ME-Sender: <xms:NAJTYFYHbp4gWuMsFEUaFSNXauzocbdvIGqhd83yBWNLi4XDEFlCEA>
    <xme:NAJTYMZ_ru5cy2Il3lx9Y3ew3DZLQ9WQiQsXSRpZGA9o0fYSxEpMeAIMdMmwJaZtj
    _j7cRasy7KV7SMBGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeejjedtiefggeekgfejheevveejjeevue
    dvtdeikeffveelgeelhffggfejjeeffeenucffohhmrghinhepghhithhlrggsrdgtohhm
    necukfhppeejjedrudeluddruddvrddvgeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NAJTYH-jAN2azzavqMFNtHwvMzzAJssDlk8FZWAPij7XX6TXhYxCbw>
    <xmx:NAJTYDojIcyzecC4D4bTJO5GhBTJaqV6YtBe_YqiKpNEMBv9q-N-Fw>
    <xmx:NAJTYArgfbGNOwJGa77SaDwya424mDTVIc-uqy0vbQco8LxFWNvmJw>
    <xmx:NAJTYHQRSY0bd_RiPswJmabgzRq9fZBtTIB2meAqbq7zPL1fcLQjKg>
Received: from vm-mail.pks.im (x4dbf0cf9.dyn.telefonica.de [77.191.12.249])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D01424005C;
        Thu, 18 Mar 2021 03:33:07 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 859237ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 18 Mar 2021 07:33:02 +0000 (UTC)
Date:   Thu, 18 Mar 2021 08:33:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Waleed Khan <me@waleedkhan.name>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Bug: reference-transaction hook for branch deletions broken
 between Git v2.30 and Git v2.31
Message-ID: <YFMCLSdImkW3B1rM@ncase>
References: <CAKjfCeDdSRk5QwyYduvbQvz0zC9FCZ3+5bseeOmZBOULxZ0D7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stgq/mSDWH8XpnVQ"
Content-Disposition: inline
In-Reply-To: <CAKjfCeDdSRk5QwyYduvbQvz0zC9FCZ3+5bseeOmZBOULxZ0D7w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--stgq/mSDWH8XpnVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 08:42:10PM -0700, Waleed Khan wrote:
[snip]
> It's pretty strange that there was an "aborted" reference-transaction
> from 0 to 0, especially with no previous "prepared"
> reference-transaction, but that's not the bug in question, and I can
> work around it by ignoring such transactions on my end.
>=20
> Notice that as part of the branch deletion, there is a
> reference-transaction from a non-zero commit hash to a zero commit
> hash.

Peff has already answered the first part of your report, so I'm gonna
concentrate on the "aborted" reference-transaction invocation.

What you're seeing here is the fact that git by default uses two
reference backends: first the loose refs backend and second the
packed-refs backend. All writes typically go into the loose refs backend
first, and in most cases one doesn't need to bother with the packed-refs
backend for these writes as loose refs override everything that's
existing in the packed-refs file.

There is one exception though, which is deletion of references: if
deleting a loose ref, it may happene that the same ref in the
packed-refs file is now unshadowed. For ref deletions, we thus need to
delete the ref from both the packed-refs file and also delete the loose
ref. And that is in fact two reference transactions: git will lock both
the loose ref it's about to delete and the packed-refs file, then delete
the packed-refs file if it exists and finally delete the loose ref. So
typically for deletions, you always get one transaction which does only
force deletes of refs existing in the packed-refs backend and then the
actual transaction which does those deletions for loose refs.

In your specific case, you try to delete a reference which only exists
as loose ref. We still set up the reference transaction for the
packed-refs backend though, but only to realize that it doesn't need any
updates because it didn't contain any of the refs which are about to be
deleted. So what happens is that we simply abort the transaction without
either first locking the backend nor committing it.

This particular issue has been biting us at GitLab, too: at times, nodes
were getting those weird force-delete-only transactions in "committed"
state, while the other nodes didn't. This did cause errors from time to
time when users tried to delete refs e.g. via a push because the nodes
tried to vote on different outcomes. It took me some time to realize
this was happening in case packed refs were about to be deleted [1] and
that we now implicitly started to depend on whether a ref was packed or
not. For us, we "fixed" it by ignoring transactions which only have
force deletions.

Patrick

[1]: https://gitlab.com/gitlab-org/gitaly/-/merge_requests/3146

--stgq/mSDWH8XpnVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBTAiwACgkQVbJhu7ck
PpQ7rw/9EZSXcfXYKSo2LpsNPDtfgCn1zufR9GXQSpoFWN6O6Q1sC0jTVUzB6oeO
a0wVJ6lAAQTdzuHTz9eRhAH5BQn5+Hflmz2Xts7/eIM2Kj4Kz6h8drDAIv4WV8D+
OLQlugZnDp+Opiu95ReF2OZwUKC1bruMpy/oudFowx+kKkRU8WJR25wmsRQbkJgm
q+gO4Nn6hLfVZJb7F9Nbb77zJ027pucL0rjR0Ddy0ApPgmsyRfaZuAlfuD7AEGL1
7sZsXK0wrepAzmpBiRM5BL7n7Y0gxF3+muKIKICGedqff9+xwpWkBk73JdgskubB
tZI5MdBHT8HmguXSAP/bHhuzXTIJ7bthpTyaYmg8HUFQj21HpuhBvyoRgaLzzvo0
RDope3QVwhEJ3+lMoz7h5w4Hw6NmUfYjY7j7HK/d6t70vFp8gfjSJqwjIEPRdhuN
MMdPn3K+YggvmocOXHmstat0uKHgkXYtbEx6P2A+LgiPPU3BB+TFLjvTO0aE8wAL
jqUhRwQmLyR/7Ox0ttw/FeMxCNAniuIlSLA4Uu6q69Wgu7gLSpuIDWZrddvVQVyZ
GT2tXfHavAwMz3knxLAdX4Ikt9wnSo8wuOZWejHI6yqQwI8K1AUrfqB7KP0cnBDJ
ro9pL6xt598fNk8MeT/F/9JwcHUG4UEsDuodWZg+ko2FiVmnEZI=
=Cls2
-----END PGP SIGNATURE-----

--stgq/mSDWH8XpnVQ--
