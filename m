Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA24B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306136; cv=none; b=mQ8NxCz5IZ6HxssPjLFUVd3SzUz8VnfOEkyDcRHJJ10SqS+zpNhzlWytjrO0++lYTtoqiqOarnJXXd+OJJQuCn2LDviQaemnOvohZ06QMh1pCsHvKb25RY4AUTRVjf2dXrmCg8cCe2w5ZGUxo43u2CJmzRCqR+ghPX53melODn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306136; c=relaxed/simple;
	bh=UM2NdZIB3QMuVq1T1C4jwduY2J3zyr1i2KoKK8/u+d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZT4oCU4uU5TA2UJRKiKI9jn/vMuHxGc2fd71NEDJq4lFVB9TeVBP0ss+zj/KhAnAgvIBmO1iKWaIJ9Q1EQDc+xM5nTdLe29gZFjKls3rFC4v7wWM9VL7SnyTeVn4kYg0OQckh9Tw4n5ZPHy6TRTWo3sS85WdqEQgHgTnGrIOCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NGPKyPGp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krFJsAda; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NGPKyPGp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krFJsAda"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DD8A7A003A;
	Sun,  9 Aug 2026 16:08:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 09 Aug 2026 16:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306134;
	 x=1786392534; bh=IMJNTcZst1rokpSYYy0Egy7nLVNWqNZ5Im/Yb2qgZew=; b=
	NGPKyPGpzHYhfiL4Ef2R51f4Je29TSainEQxtavED/A75woPbloTsAB5qaFrX18K
	CAgLSxQ9Y3EC8pellQGtAsiNWn5++g0o/PWjAs8dm0c0YON9sHat6eSx+EEIP0KP
	d5zw3YCFXSnv16143hVWs7aafav/3U2MjESrapmcuLoLpvx6ZbBuAJn2NJfieCCp
	xO82d3pbxjmKGj4o+HBYLIWhzN5nSzsXkVE8xxjFy8XZG6fXjkKLQuR2PoHKgV7A
	FubU7jEwNyxc6jq/nTWz/7X4WAWIvq/i4V1QgzAQmevfcv+XAkAnFGCy+o3WnZpE
	ldVDXpuZSHRNtQnMbqqgNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306134; x=
	1786392534; bh=IMJNTcZst1rokpSYYy0Egy7nLVNWqNZ5Im/Yb2qgZew=; b=k
	rFJsAdaoQPVdA2/pGmhYeF0SAlgEUpwRGsbu6ZCMGNPo37T0TCHnCrcvj/lu7XfE
	srzpjTMAb1vzAf3fAkJ/nXkUr+noPR1V4IJixEVG8T3i6gxoN7/cZQ6lD0ptqIAQ
	bF5/9S8WS/r6Inlv0imVJmfL2MITwLrkVyjTpMmvIygGpz10iAHjDxHz5EPzXDU6
	4/lFCQ4tKQXslBAmvKlK4ncWmL2r04VumZoxEJuDWYhkBq1Kp6LBOgj1HVRyHyEW
	h7HGeN7LlrYbcMFA295XQ/bAnaG4+DbOiSjvCdyx5aOUCO+4XkzLvohPTKVR0Q4h
	WD4YcfB0119sKAq6FTb4w==
X-ME-Sender: <xms:Vd54aolbJIV7uX08zs4jXX7ajmsgR6oaapBQlbdouN60TQLvvMDvsK0>
    <xme:Vd54aqbvt73MgjnFXFa0Pbh-yLuTy6OM511B7i7yx4RnbYwPKw-bRle2NE6J1Ihjl
    Y0ojJOBmDZFiIAOINN500iN3hfY06a66EN5s0YFVROQlNcf1AxsMg>
X-ME-Received: <xmr:Vd54aqQCxnDJQ8h8bGe4-50gnEUFVOdU63UbduMjGSZJyaMYRrt4OLw8vw70IAJHBeioSgum-RsiHZ23fJIvhQkxIfREfheNSlNB4Wy3m94vaUsaiA5zGYM>
X-ME-Proxy-Cause: dmFkZTGbZ+pGik3HSuHLURGowme/Nwd5ahIX9k9IuP+iSiGiMyPeHFIesYg/obLj6TgEEE
    rliusHDaUALUJzCfxZy3TpbNuuv6PX2OB0hwyIUjvla6wxokaR5diAkZXedF94O/vaMxEE
    hKldSlRMZUcAbIqDdTLUeuL2UKGZHUfa7+TyUxRrl/QRsNHfmPJY5gVmuUCtvzMqdOAs44
    /icsChJqMCttF8pxSMTQAibjvlzdlaUeCh7OQ4UtcOehoB838w1Ml68XssnKt9wZ+bbQw3
    WGKQy+RNpM7Ud1JNDknkUPQw5I96vco1WKrjGV8tF89fL1gITLIcfCbVlQGBw4go003YGR
    mm5pvyduhM4H0Es28RYucf0zowcjMyg0eE7htbZEX1NcNAW+nD6a6lfRiVjFKTp00ZH6U5
    HvZk8lif37FjaJ+omt3FnuMCfVkgK2UKXtqGvtJ5kP4x72HQN7rkm/YmRBr0sx2SarksvX
    SVyjohjzHduqX/tZcjS/G9QKUvf7lwrFwFHicL28gDezOgTx0h9PZ6yZI8NgX+KEUx40Ni
    YB3DyJn0I94VOJ583aUaK1uJAsSFsr9JRcQKWcpbUHwrHRSAEO8IpT7Wtf/PFBPU6l+xV6
    R1rEUbQccLsgB3Rxf84IffSoOxUmCXWGN+E+AGnliJydRhY18nMg5KJaTkPA
X-ME-Proxy: <xmx:Vd54aksta5_T5pL6GykSAs93gR3HZNHYe5sT-eX70197-uSYuP6N8A>
    <xmx:Vd54asHa93deM4UKRegKKqxLSC5zH9gBO5k083tm8qcJvgNuTJJdgw>
    <xmx:Vd54alxAn9wq7o6cCaNVgmtZm_B5gQjvZM0hMVrfsO7IprXIAS5MaQ>
    <xmx:Vd54am0LeOklu-UdP7iKEP4XNAxuteW2w-ypZx5iP1f3YOKj_q2uVw>
    <xmx:Vt54aqS7D1Kycc2Fx2yIx96tdj3WktZ6OZ4PBPrVDiEoATqD5KOi9HcX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:08:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v5 05/11] doc: interpret-trailers: explain the format after the intro
Date: Sun,  9 Aug 2026 22:06:29 +0200
Message-ID: <V5_trailer_explain_format.b2b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

You need to read the entire “Description” section in order to understand
the full trailer format. But there are many nuances, so that’s fine.
As a starter though we have an introductory example.[1] That turns out
to be crucial; the rest of this section talks about the mechanics of the
command and only incidentally the format itself.

Now, although the example might arguably be self-explanatory, we can
add a little preamble which defines the format in its simplest form as
well as define the most important terms.

Note that we name the “blank line” rule since I want to use that term
every time it comes up. It gets very mildly obfuscated if you call it
a “blank line” in one place[2] and “empty (or whitespace-only) ...” in
another one.[3]

We will define the format of the *key* in the next commit.

† 1: from d57fa7fc (doc: trailer: add more examples in DESCRIPTION,
     2023-06-15)
† 2: `Documentation/git-interpret-trailers.adoc:86` in
     5361983c (The 22nd batch, 2026-03-27)
† 3: `Documentation/git-interpret-trailers.adoc:93` in
     5361983c (The 22nd batch, 2026-03-27)

Suggested-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4: Msg: reflow paragraph
    
    v2: [new]
       • PS: Suggested here: https://lore.kernel.org/git/8E736B70-424E-48AC-A6D0-9A8B091D21F6@gmail.com/#t
       • (My tardiness on this topic has made these reminders necessary,
         if only for my own reference)

 Documentation/git-interpret-trailers.adoc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index ab3627c2cba..109059f11ed 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -16,7 +16,12 @@ DESCRIPTION
 -----------
 Add or parse trailer metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
-For example, in the following commit message
+
+A _trailer_ in its simplest form is a key-value pair with a colon as a
+separator. A _trailer block_ consists of one or more trailers. The
+trailer block needs to be preceded by a blank line, where a _blank line_
+is either an empty or a whitespace-only line. For example, in the
+following commit message
 
 ------------------------------------------------
 subject
-- 
2.54.0.22.g9e26862b904

