Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCDC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780F964EBA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 05:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhBYFvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 00:51:02 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56831 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhBYFvB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Feb 2021 00:51:01 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 84DC75C00C2;
        Thu, 25 Feb 2021 00:50:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 Feb 2021 00:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=+84GoLOLOYFQd3fGvgG/IxZA0VWdWUO7BjFdrQjlpAQ=; b=j57VxdPMGnZY
        MLwIgLX2PPojmd+9ElrKc93OZWftWewjbPoJojYGr7fxfaWMPxMR6lBL1ESU+XPE
        6dPEQhtwBp2gTOviU0QeqOUWUIYpKIR1RBr3npcWt3QvNDfBtThtzx0AAkMlV+W+
        OIDRqr/Xpz8yt+wVoWtr+I5JjiOAp5o+PnlVixGm7r061t3TZjMOOcTDlsTXo0bh
        xIfafI/NJ80Zu9t5lZL+znwsPRYHenR4fUMnC/G+0plHcfMeDLfI75P1KAnPuYPQ
        AZcuO/Qmj1H0rsssAI/XsUBfUn7SBmaFcP5Q8t3SeXk5OE1HSmPs0u4A5J0UgsuG
        62e+nroblw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=+84GoLOLOYFQd3fGvgG/IxZA0VWdW
        UO7BjFdrQjlpAQ=; b=VW2b/BkUeSKcHKiDsSbFW0+m0L9Xa+Wg0KiGNrfSP4r8H
        hAV3MrF4wCiX5FYaTVEBYCIigSp1CUrx408COs0KPBpvZ0cbxi9Xw0TeuyW2Ow4B
        a2ZCi61pSJwXzYHPE9oFgo0Twmd8P4cX5MDXUksMQR92NaOyYPHpdyjMVFof4bxB
        0O1zVNSImfgGCyrMaRFa6yWbTN5yZdTlW3yh4xLC+UojVEOWXdfXW3nvmJIgrJj1
        azLqaPdKmbnjm7MfNMVCm6hLVckMUCI6IjxSQVsJQJ7NaU+mF2YjnxwaDJZmi46E
        fK8PkrkhMiAuBmyXHbv+ay51e/t4w/y4DKXHJFLdg==
X-ME-Sender: <xms:lzo3YMn2s7PQkQIlGMrX-eAUVdwJSTNB7uZXlEQ9QMClB7IZIlQNBA>
    <xme:lzo3YL3Fmkrl26wgHHGqClF2upktxefFaRQrVXSKQL48dauMCNW9hTWquurLciEfi
    grfp6TTVLDU-zRwKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeekgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    eifedvueelfffgjeduffdvgefhiefgjefgvddvfeduvefffeevfffhgfekieffnecukfhp
    peejjedrudekfedrvdefrdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lzo3YKpXKvlk_PvtOu9iBBQPa1IXP5VL13XLIuDifCniqZDQ3wLYKQ>
    <xmx:lzo3YIl7ZaP20QIWfCtHHasyTxTgT57tcptam89D-zK4wB2hL-XQ_Q>
    <xmx:lzo3YK1zwqtyOWshQcvQQCoqXWz-lWfbyXcQ0AtwxLWoFRubM7JlXg>
    <xmx:lzo3YP8O8yTT6salNSa3SkZq9H0Ey4RuPJ46VUfHZCdNfSqWSgGglw>
Received: from vm-mail.pks.im (x4db71709.dyn.telefonica.de [77.183.23.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EC6B240057;
        Thu, 25 Feb 2021 00:50:14 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a153fba2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 25 Feb 2021 05:50:13 +0000 (UTC)
Date:   Thu, 25 Feb 2021 06:50:12 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] githooks.txt: Clarify documentation on reference-transaction
 hook
Message-ID: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Vsysje//cUo7yg0"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0Vsysje//cUo7yg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reference-transaction hook doesn't clearly document its scope and
what values it receives as input. Document it to make it less surprising
and clearly delimit its (current) scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've been postponing doing this simple doc update for far too long, but
here it finally is. It simply clarifies its current workings and
limitations without changing anything. This is not supposed to be a "We
don't want it to ever cover symrefs", but rather to avoid confusion.

Patrick

 Documentation/githooks.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1f3b57d04d..b01de04702 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -473,7 +473,8 @@ reference-transaction
=20
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
-committed or aborted and may thus get called multiple times.
+committed or aborted and may thus get called multiple times. The hook
+does not cover symbolic references.
=20
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
@@ -492,6 +493,13 @@ receives on standard input a line of the format:
=20
   <old-value> SP <new-value> SP <ref-name> LF
=20
+where `<old-value>` is the old object name passed into the reference
+transaction, `<new-value>` is the new object name to be stored in the
+ref and `<ref-name>` is the full name of the ref. When force updating
+the reference regardless of its current value or when the reference is
+to be created anew, `<old-value>` is 40 `0`. To distinguish these cases,
+you can inspect the current value of `<ref-name>` via `git rev-parse`.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
--=20
2.30.1


--0Vsysje//cUo7yg0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA3OpMACgkQVbJhu7ck
PpR7IQ/9E/ORs0GLiUiY5gT1EYi4nJ7/fStIzUM0yJZL2oLDMx7GHjPCSeAUhaZZ
S/8QuS7Tw4DBQiVVBkhutYuX/IkVnBV6j3+9DEpmOOKVPQP9jNiqy/hUtIYQaxPf
ETEViEnC1RTDab3PAt+lnSu9pG0FuRMv1EblwM2z7rlYsYe1KafYLIlinDzm2VSi
TvUBvYIxKSBh1iDOem9VaFcrl2rlehYnQXVnefAD5F1lwVbZlv4T3kLBW1MlNwn+
SLUuP41fAuqaz7ohyoaQ3WEk9EhQve1Ye5y1TecFvhLSWA2gphCALWlKVqWlHdoZ
Tl8QKaYhmn46Q1Mc8OM4zQLWp8WhE8YEHezui+7ge0hNYrr+XNzxFi4msBPYfHSJ
gAnZF2GobPbAxyccleLDoYFB5C1RMTlHbJPcagqyooo35/Re+RhDQa8XvAW3v3LU
BF3hpfGjgbs+8i11RSPOQZmR4Kk858ei1pJVt/HKb7ZPkuAsFrm4kl857TuRMCNT
SANrqTqFHjYUPrAYfPTwAbtpTxbuphxU2mS2Bwmyc7gklf446l9CMx0idl7Ug2M8
1+F+JfguBB9jW98x+TGnImbbbE3sSnPZtgqOjtLz5ink3jYHMvb44OXzzsW8AOHS
+zlqPesmSUc/Z9hJQv1JdlC4Ss2kiqd4P4Dz+t7Ppq0amY6WtmU=
=UqDG
-----END PGP SIGNATURE-----

--0Vsysje//cUo7yg0--
