Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02E37DEBB
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379827; cv=none; b=QX0UTbq/t1xrEaDMqa/DHSKxhdgTYEMHlbyDVtwctJMEhVujv9SxFKJccWOmSIVV4zrjQPYfweALrfzfQBMBOAXhLLBdHuU3TiVB2lb7qwqOQ99/xTcRrPGYF2+ICvjl5bFWE2WDgHF135uMcTgOfDsuua6hDzwbHlv7DcKyEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379827; c=relaxed/simple;
	bh=4AGmdzQTJOz6dEsBuoYMIw7nIvtzYhOKy5jAdJo0Z0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dyfBvk0uFtZGznZSuCQt+RvG9ugZoParT5EBGKER6eKA5SqRaB21GDHKjMRALkOLMWn2O712xj1PRZxAFHNF3qkyPpB7jJ5BlZFqyojLzDzFug8HWT//sONGTKq7lBS6xt31yTr1Nqb0Se6DZuGUATwTA7GuM+k1iBy0fUsbrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lmVOhuhj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFrzAdYB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmVOhuhj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFrzAdYB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CB5F1400363;
	Wed, 29 Jul 2026 22:50:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jul 2026 22:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785379824;
	 x=1785466224; bh=uSzoddczZSykUNm23DutrO15Q8EJMg0Uiu4wP6afWxs=; b=
	lmVOhuhj0q48euXW1iNBPq7wEpn8X3xCCuFdL0ky4RFMEdtTzH55R7zTCi1ZDYUV
	k3M7m8Be4LJnwFreyh4RSb9j3ODFozS7cTQCOCkxcnVuimrAxrjdV1s/WbqqGGB1
	029x/LgUKGedybDkkh7Odhh+lMHij3rBw1xkmIJMYWC4djJvg/NN2Y+kuL5IHKHM
	+mJ98rnS6miULzUmyp25qcXedg9/RHYgi4hvPOvx+xoHquAxlFqmxZKUIWPKUGVR
	hR5Ob5oFR0JJSzH2ychVZS+Lhuq1IvGv6lhAUmyzpkqPNN8TmhZJONMmC01H69po
	g9LeEwzGVonZVyg8Xy696w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785379824; x=
	1785466224; bh=uSzoddczZSykUNm23DutrO15Q8EJMg0Uiu4wP6afWxs=; b=Z
	FrzAdYBToE1qo+nuF0ECsymc6rfP3hxvljAqLKfvGkXWfJyDTFMux+Aa+50yV/OD
	sbHe+wk7XYaiUyx7gYs5ayvhhJ/lchRywiPxX1VG3wTVVz48XEIy+W6nLGFRSeQm
	QRhohTBmzejZsnXO/vjR0e/9R4icbfVJMTbJjzRQYJ5TlrOoC+orIkbyIWT9Ws0F
	IFhefpbwP8OzbxXZF9BxqRuKOWgB6SHG6lrZArCMaf6ihmOhrHiaODwF/LwjvzRP
	DOTL8WT2XQjytlbpYkDA8flsgm9/TGauE//2tDJqsQqdW/wEpdUYVV4W15r/wsLD
	EvEdGQAF7vZ+qP2xCoOVg==
X-ME-Sender: <xms:8Ltqai3b7smyqEzocQkP_0hTWRS_MBheYOp832X6lsuS1C-NBZanjw>
    <xme:8Ltqasi361iMftr0gmwV9rKylRBoHrDnimSlGAL5F3WxkO7Bfy69_42qpiWsRbgg9
    DWKZJC-GpNFgodm9ZBZJQcZttIO24jMCixxM6VueuFW0vBhTC40IA>
X-ME-Received: <xmr:8LtqaoT4WLSR1Hwtf_FTge8QVjMP8sJ9dhK1EXKku9gWOoWJSF8u-BSGZilXjU4cV5dM0mLyUUyPZPXetptDX4XYqx5NepJ9Ag>
X-ME-Proxy-Cause: dmFkZTF3pMkUZtRf7Gm3ogIeoiKltwXm/x9tgUtut0/J12XrNOTmG1BypGXSDa8X7PidPi
    kTR6jLLOZ5eTYL2jMRgPh0cOISKqDbd9TZWXqSyt+EXWCxnb/y7Suu+ZsUhxAhFnjMk1t2
    OWCD3CiMPlXhpJZHweknEJX0JZh00XFs+ZMgsjwIlmwr7W3YeGUi3pVC/+gmbs/vZ+np5+
    4Q0bq6dzwIi2iAdo4jUSqkwKWHr/eKe8teO7lwxVkSanw+U1S361OQBTSIQ518SVstdlhc
    whzecQKDvOsEZz9Y81sWB4MoEezIJawy6/fEMAwdaLhBNB3fZjJC0fdpl6s9K173R804HH
    7Ydimkm0esyoAQt/+ZTZ/n8Rrq+MzQZYFTKJ2iXsz2Pj4W98jwbK3ijhpwRvNn/2pJzVpK
    8k1LpcOwwCw4+Qq8Az3Zol4wOdTQxqTKtuf/L0htffLFMFVxdkeMBwNRNaflfgdbsGmo5l
    XeqIQRlV9dcc9Zd4GHaO32qjlSV2o6+rsbU6oVIBmEBZ8PHTWHjwfgcSjDLqMG0iKG5iZx
    mr2cJdXSn3BC0LfKtIsaLJ2tuvN2wtEFNDgspk5RsiW+KizRBVUZWPBUyTCHC2n+Uo6HmT
    DyY+WuGB6SFC9gCXzuGIpemCir3btYKHmyOy/BpRzrUyWzWGfTVCEGUUTNCA
X-ME-Proxy: <xmx:8LtqatjrojNgVWUwID_DWJBUGtUa-GcZ_lDMQ5e8H-RtvQLPYA7mGg>
    <xmx:8Ltqao72w4FQL-TUEmjYgxvBlipC6GTdq3ThxyXzUSddLRtkbRwQFA>
    <xmx:8LtqaqAPbckdsuR4zT7G6G-2fR_FsZpjl-us8tgVJlFtqBXOX9UV8Q>
    <xmx:8LtqavZwzFSK3VTsPKkEfzdnvEDZVRqMF02OZHEwhecXa5ARQnDeqw>
    <xmx:8Ltqakwm1xGPSpuVKwCXFPfkabqi1ZYVoRSB_dz0hTYUVniPzze1ptZB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 22:50:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: a/an grammar fixes
In-Reply-To: <20260729182323.1095474-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
	message of "Wed, 29 Jul 2026 21:23:23 +0300")
References: <20260729182323.1095474-1-ville.skytta@iki.fi>
Date: Wed, 29 Jul 2026 19:50:22 -0700
Message-ID: <xmqqtsphmbrl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ville Skyttä <ville.skytta@iki.fi> writes:

> This takes the stance that `*` is an asterisk rather than a star.
>
> Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
> ---

As long as the changes do not contain an incorrect rewrite, it is OK
even if the patch is not exhausitive.  I went though the changes and
did not spot anything questionable.

But I think I can see a few more of the same kind.  I didn't try to
bee exhaustive, either, though.

 Documentation/config/gpg.adoc | 6 +++---
 Documentation/git-push.adoc   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git i/Documentation/config/gpg.adoc w/Documentation/config/gpg.adoc
index 240e46c050..d4b8c1e570 100644
--- i/Documentation/config/gpg.adoc
+++ w/Documentation/config/gpg.adoc
@@ -38,7 +38,7 @@ gpg.minTrustLevel::
 * `ultimate`
 
 gpg.ssh.defaultKeyCommand::
-	This command will be run when user.signingkey is not set and a ssh
+	This command will be run when user.signingkey is not set and an ssh
 	signature is requested. On successful exit a valid ssh public key
 	prefixed with `key::` is expected in the first line of its output.
 	This allows for a script doing a dynamic lookup of the correct public
@@ -75,11 +75,11 @@ valid-before options. Git will mark signatures as valid if the signing key was
 valid at the time of the signature's creation. This allows users to change a
 signing key without invalidating all previously made signatures.
 +
-Using a SSH CA key with the cert-authority option
+Using an SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.
 
 gpg.ssh.revocationFile::
-	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
+	Either an SSH KRL or a list of revoked public keys (without the principal prefix).
 	See ssh-keygen(1) for details.
 	If a public key is found in this file then it will always be treated
 	as having trust level "never" and signatures will show as invalid.
diff --git i/Documentation/git-push.adoc w/Documentation/git-push.adoc
index aa221c3909..d05e6020a5 100644
--- i/Documentation/git-push.adoc
+++ w/Documentation/git-push.adoc
@@ -105,7 +105,7 @@ as well as various other special refspec forms:
     directs Git to push "matching" branches: for every branch that exists on
     the local side, the remote side is updated if a branch of the same name
     already exists on the remote side.
- *  _<src>_ may contain a `*` to indicate a simple pattern match.
+ *  _<src>_ may contain an `*` to indicate a simple pattern match.
     This works like a glob that matches any ref matching the pattern.
     There must be only one `*` in both the `<src>` and `<dst>`.
     It will map refs to the destination by replacing the * with the
