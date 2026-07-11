Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0E259C82
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798020; cv=none; b=guafkflaP9Vf+QWpo1JdS1Oa95Z0EjgNbwMjWFy/bIEJynferaDU9OhA25iz17Tqt5p3IuHoO3iNrLmcowl/kOJhW1r6eor8cFPD6qjQtKCpgBSlMcjMkQpKhE/Cefj6pxTe/SIT6RrdMnvLSA25mvj8eXflBSuBw+LfR00MHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798020; c=relaxed/simple;
	bh=kjUiFvmf3b7oB7dnv2LZF8Mf5n9jUInznGlBfN4lYjc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdkFp71HE3YUUSjRflI92JCNYfw51kIXdyDGf8vAUneg4VbQKjiv3qwtVz7x3S4tw9eEBV1bn1rmVNEDST3rIrqaKpEsfFlyJlx204ZUlEcnDcHOVx7ErMuJLlP2s998ZGGi5BLiUaqVbkwh79GiicS3zxqGA2Q7fJofBEGQ0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z0eLkc48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HBhTr1ya; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0eLkc48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBhTr1ya"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3617140009B;
	Sat, 11 Jul 2026 15:26:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 15:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783798017; x=
	1783884417; bh=tJYwO8KlWszRj8P8p0FFqTf296RHkeZHx73XRIDXoeQ=; b=Z
	0eLkc48d2glv87I28GkAonbDRmCvZdRvJjgu0PKTuN9BbxyAT/71cy4tqrADJ88F
	0VB9G7PAryXm/nuaoa2S+IKY8eIPoQhC0ROH68fvu68C+YwneALSKjPrWlB3ynu1
	Our0QGXVnK1caqt7M/XIVA7D7wb+p3HD3lWAJupiX/CW3zch/cZ6RZr3HAwjt2hs
	g2ducwOIrYqcvP5mEbgElz0Zo9vNW97nN3Gsmw3nu4VQTE1ZDgcZsb1w6Wewn2Aa
	u3m0Jy0CdoXvyRN0d/nYWogMmc+w5fu+SaPZo1tGrV2SuZfIu6Q+p2mU/lNnfSNZ
	oWWxDBqCarT8PQTh9frrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783798017; x=1783884417; bh=tJYwO8KlWszRj8P8p0FFqTf296RH
	keZHx73XRIDXoeQ=; b=HBhTr1yakSieE6bKdsTLMLaEqFU3o8apSf8SzQTU+LXC
	G3AzirzKJiDbFqxVsPCDr314bicxo5XSzjjHeStGpD7oZV8Q8OwJIRCdfErb8OjO
	4mqVMQhXOuKcgdVJYEHgLhiPVzEdvA74QZ64aE3vP2Kl/YtlR0fJvzcBDsGsNyK4
	1lE3J99GflSB9+PXOf0JeJa2uvpAFdl6j58WSwY2FuZAE7OUtblO5u9ZrZYqtpwQ
	iALLGehhsF73xybOE+54iOgXAF/kttC0496EQxfPdZozoM0CvIZ7z7C/wgV9Yf5m
	SzhBk0Pf+b9YNkLPosXNF1WJkjHPtcONBRSxOmRH6g==
X-ME-Sender: <xms:AZlSat8pKO-SZvl95V1-fm8uadovEYydP2Yw9JarossPwvSZz7X8fg>
    <xme:AZlSanvN373oM_vr4Un4XVczwZiKmCNWpdetAOi4yW2NHfQZCc7vDZGBRsRDI72_O
    WzRxcvRHVFXVkXhIvJurXQ7eKFeXlCbTr3h1VPiuoGlqStTtEspYA>
X-ME-Received: <xmr:AZlSaor1kzabHIhCaPSv28qUtAOI4KTSD84hlGIjoViWrcPK60-AxoTUX1ZFAhG3Ktl2fv_Y87kHxzjim3Vo1ZJBbDytr2k2PUzBV5Q>
X-ME-Proxy-Cause: dmFkZTFJqDDiLOtZNK9IvspcieMba+1eLNTx4J7Cw7UAxOT6+ouPyrq6BGv8CmHUd2yp1c
    3LMnbIMYWc/oetxfu+mKHTLz17Exy8hCJVcRjfraJGA6VV5ICpS2oZCzWdS24PVZ+aLY30
    MyWDLG0gm/JKg0jlleOwkLmuavqw28VyOz2mUZP3kBlXWWbiFNtEgxOTnhjArRJLn4v9Wj
    kHHNDOhwlLq9Ne68NTTJxEAZclo3E+temZV1Dtje6ypm11Jz6233+i5EmhGrzCZCODkNrq
    f85z6kei2FP7RRJRW4N9tS+iJtQgbwn8ErEA7bx+HSh0jiSqZlcbsxbC3vQz5oeokJ9gVa
    8rSvcT0dvYTfvAPFwfR2yAUWZ7RlsE0zS0tLps37Sg3hn4E4w1gHfKo8bKMrEtsLm47oIY
    0y1tR3i4+SLgTnIYzaU+OIiIGlYcBItdN807k+VgceHRq+cqfyq1b+NfQCkFu7MK+bWMrJ
    xcUbwh0K0K00KauMex9I+LTuZV7JG/fvwmjhN5EIyvitTJK222V8uxtoaVhrugzR3BvUH8
    Shyq+RgCrW/zHjaQodgduxIy8Ag+UB5xUkq35jCuMGaplUj+dWQ+aDr1wgv4DDOqVJ7qqg
    4R0bvY1ptjDFsM53f2vULNOTdNgZSakYLYW9m6wljAihypEVOxSVVkb9RghQ
X-ME-Proxy: <xmx:AZlSasnQq1o-QHqPq9WuTKNYi6ryB3NVmgxSosft9uLZ5ebnRI_MmA>
    <xmx:AZlSakz5zqlYbBinrhBFbP3HU5ey4aZwRbEx9d7QFSCJ08kdbQy1iQ>
    <xmx:AZlSaslYwphUZ5eK31rZKvoWtyJXEFEn6lm0xYEaBtWfYTjbLOhnFg>
    <xmx:AZlSalcWZakt6zPNI5VJUqcIVAWJOSm2xAAe-96vbIgossODylohYg>
    <xmx:AZlSapWTSgZIRwnfxkVUzE9zHkxO9O-fRoIsEgnirk3lw5lVf-ZO-Bba>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:26:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/6] MyFirstContribution: clarify that 'seen' does not mean acceptance
Date: Sat, 11 Jul 2026 12:26:48 -0700
Message-ID: <20260711192650.2417665-5-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-391-gdf86bf5712
In-Reply-To: <20260711192650.2417665-1-gitster@pobox.com>
References: <20260711192650.2417665-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that getting a patch picked up into 'seen' is not the end
of the story for contributors; it is merely the beginning.

This is also described in SubmittingPatches:[[patch-flow]] section,
but beneficial to make new contributors aware of it early.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 988f0d4fba..5acc265589 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1534,10 +1534,20 @@ that received the `Reviewed-by:` trailer untouched.
 [[after-approval]]
 === After Review Approval
 
-The Git project has four integration branches: `seen`, `next`, `master`, and
-`maint`. Your change will be placed into `seen` fairly early on by the maintainer
-while it is still in the review process; from there, when it is ready for wider
-testing, it will be merged into `next`. Plenty of early testers use `next` and
+The Git project maintains four integration branches: `seen`, `next`,
+`master`, and `maint`.  The maintainer will often place your change
+into `seen` fairly early in the review process; sometimes even before
+it receives its first comments.
+
+However, being queued in `seen` does not mean your patch has been
+accepted.  It is only there for integration testing, CI, and giving
+wider exposure and ready access to reviewers.  To advance from `seen`
+to `next`, your topic needs positive reviews and community consensus
+on the mailing list.  If reviews are favorable, the maintainer will
+mark the topic as "Will merge to `next`" in the "What's cooking"
+report before actually merging it.
+
+Plenty of early testers use `next` and
 may report issues. Eventually, changes in `next` will make it to `master`,
 which is typically considered stable. Finally, when a new release is cut,
 `maint` is used to base bugfixes onto. As mentioned at the beginning of this
-- 
2.55.0-391-gdf86bf5712

