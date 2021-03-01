Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B39C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3037601FE
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhCAJpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:45:02 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49663 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233762AbhCAJop (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 04:44:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D6D989F3;
        Mon,  1 Mar 2021 04:43:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 Mar 2021 04:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5eSJ1o9I1vIBzVIp2n9aNS4jUYf
        zDZbmzklzs+YKJw4=; b=f5cTUM9x6CsST9lpNB1TWe+oa3OfqF9pxuO7J8+vViD
        zOOjIqm4t05jT9zzjGi5nb9xUyrE5SK+3clV8jAF/Ct9vDP22T6mNcFuJVUaIQhr
        F/x2BLs45mSKKOkFqHNmM7O2F90gnbK/BW4c7kmDXAH8WnpvHWtBoL6COOIdnlOa
        ouuNw+dgUJ0Wjj/LBPWrV/37PzS8CPlfZB9lErOLDBjMnHmcMVQrfv64YRPEYTvq
        4hIURepEf6jh5/OW8LhT4FUWy8PIRcWla9/0RMefwVmp40hKy9EzQUwV2NruEhEP
        pFLoAKYqhcwHtPwB3uIxATVhljdvZ41g5hALotR9/WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5eSJ1o
        9I1vIBzVIp2n9aNS4jUYfzDZbmzklzs+YKJw4=; b=MvKerOKSES+Ne1YZjHvVqW
        XEmkQlBbHHVnDwwLrxHq9iFdiDeieBE6uitA85MmzYCWOtSJ5YUGZvFh6Qj2ehJL
        tJ6PPRk8XXn6fo7cuoDt5atn4E/7T5+MLqNQPDDyyt4l7KERkoNv80US7FabBM5K
        fLx4/+XKs1LBlMpZQJ3bSxoJiy3eZc35EJ77Z2u+uA1lD/6DXuzhJx3i/LH4qJyi
        7kcc02NPY7E9jnAsDGOhJ4QX60NwRVfb+mtDSJE79soykz03uNazGckKmDswOJ7z
        hYwb8FhESoQiSTnxICeB4QoBpFUEyrFZIHFaOBB4p7FMZO8aOklU/5+2pBJpL4fw
        ==
X-ME-Sender: <xms:X7c8YB1ovoE2RBUZJSGnNQTpspXMlZrWFHNHOEClf-pPRdnUFodb0g>
    <xme:X7c8YBiYmR3q9mtJFJ1mKS28haKIIVgOvlO2Al5qfxLXS4QvkEayOSMWvieQa9FtH
    f53yGEj89vYk7-HJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:X7c8YBegwe3MoM_sxPjh63TCuf0fQDjcS6NLyNAhwvRIDrJEkQmNtw>
    <xmx:X7c8YEnnZECA9440COZNbIJ8VKPNnpVlM4DW-u1qwe4b66Yz6Q2Y5A>
    <xmx:X7c8YKv2OrOzIzsexMdIMBFZdiPdaQ-N53By9k7nhwN1L0d2d_rWEg>
    <xmx:X7c8YCkZGB9gPwMyhTLOQD4uvFjrAR_PHPa9E7C8BfapczGwI3QshA>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97EF424005B;
        Mon,  1 Mar 2021 04:43:58 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0d355eef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 09:43:58 +0000 (UTC)
Date:   Mon, 1 Mar 2021 10:43:55 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] githooks.txt: Clarify documentation on
 reference-transaction hook
Message-ID: <55905b8693dd49637d0516ee123405cbfb58b6c6.1614591751.git.ps@pks.im>
References: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jHA/wUeX8NLMEPup"
Content-Disposition: inline
In-Reply-To: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jHA/wUeX8NLMEPup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reference-transaction hook doesn't clearly document its scope and
what values it receives as input. Document it to make it less surprising
and clearly delimit its (current) scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/githooks.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 4dad80052e..b51959ff94 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -473,7 +473,8 @@ reference-transaction
=20
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
-committed or aborted and may thus get called multiple times.
+committed or aborted and may thus get called multiple times. The hook
+does not cover symbolic references (but that may change in the future).
=20
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
@@ -492,6 +493,14 @@ receives on standard input a line of the format:
=20
   <old-value> SP <new-value> SP <ref-name> LF
=20
+where `<old-value>` is the old object name passed into the reference
+transaction, `<new-value>` is the new object name to be stored in the
+ref and `<ref-name>` is the full name of the ref. When force updating
+the reference regardless of its current value or when the reference is
+to be created anew, `<old-value>` is the all-zeroes object name. To
+distinguish these cases, you can inspect the current value of
+`<ref-name>` via `git rev-parse`.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
--=20
2.30.1


--jHA/wUeX8NLMEPup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA8t1oACgkQVbJhu7ck
PpTM/A//ZTU/eQKrEd+rpYoC9BH11+3xip4MXEqcf3rSfdHzFbWNmhtt5qvZw8kI
GvJuk9inasN+jGXdCvm7TopRyJQu5jua+mwIuArPY9cAbWMKMUnG4FQls4ASo6La
JEqxA7GsqWBwufxvvhy/ml3j5+RdSJc/gLE84WvGW3dVXYbD8Jm9yivTHX/4WH92
2r4neGjYooQ5Q0kOmDh4WusJy8p3c4LrIPIRr04ifa+HYZZcLFP5pg6iwPFDbj7F
AUspdPsIdmBTjcS+HVzUO7ZrpIdZ9Nny03IAJCeaX+ty0EkpZypimqamNO/XFksa
xia4A/dlwDqULsgXlDDYB292hpFFgDWoTMoz2Av8oW67KGm3iLjUbWsBVzMiw3nU
AxpOgehs0Q54g45WuYiJvIlkUWj+9bDIxJtALPTjHZw8gIYYEDhxQfM9q7LoX9PL
iVCK14UOJMKsGVkxDqFbasgdfm0VETjO0+ioMk3Ms/F/9ynxa9x98pcAbDOxl49V
SC/G5Ayh0icXA1q8ZvqN4VE8abRyxbZSimRAuH1EwJnqcseXGeFCFlJlhT7ef7+f
13yR+hkoXdh3GEYabdVfotD4yycjtjO3Wdf9fvNBYm9sGJJY8fZzBzXmHWcf/XDC
ApaPqikRlEmuoD0voEgcKqjrdFzo6+1IyDEpp4kbbRHFp5EsbsE=
=I2w9
-----END PGP SIGNATURE-----

--jHA/wUeX8NLMEPup--
