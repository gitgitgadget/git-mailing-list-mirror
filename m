Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30D4B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306175; cv=none; b=fDRjkbGPmdyqLa2pIa8EVi2uNceoQPpy9uPkavZ1dopFchJ/lvfK3abPwHS+iFAAhrHUq2rJD0GDQavGkgMCa9uhd/ubUrXyuQfZ2Hct5lV78Pmagd1oRMuJHg7ibyod/J/VofmzNKSmSp5gy0qhK9411fZWT9r6PPoeb10Ii3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306175; c=relaxed/simple;
	bh=ZVvRWSFLkCOvbjBFPdl8ErtlpNfEpeDnFYMRFFma+qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRcTRqKNLAWR7T7z0VgTG44fA2VrTDk33QAa+BmUmh4JH7egpflKiFwFslDuBnKFKLtIwlUPcsrSXEGvFkIvAJkS19Ca+l4NJOboZmvuvgYb4E3gj8NihqUtdl3+o2jE2qZE61lzr4XiZX+3ELAHQ7MS7oXKXqkM7P2fUQXXFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LB/UbWpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VE9PxWVb; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LB/UbWpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VE9PxWVb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 11B691D00028;
	Sun,  9 Aug 2026 16:09:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 09 Aug 2026 16:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306172;
	 x=1786392572; bh=g95CV+b6TgiXhzUmZbFP81/c8WX2kKWmyPL0aZHO9Ug=; b=
	LB/UbWpkWco3R8GyWp0wuM374TV9Qn49Up1vVUE79EYKt5PpVg5zJI+JFC6Hmeu5
	nZEePKoUT7eQJ17v2cPN1en6Up6Z2YU5vKKwAFdOQF7ndA68COF6Gj/Xo+jlmJhG
	wmE6i/YjgmycbxeOVb2/g9OsjyLt7w91CRw6BuNfhvzXpOAAaehwlLcdrbl8tfNH
	07PYSy/TkaPNClh6vIRgzTF920PYmC7kPoaze+mCx7YafEKw8YPE+tsqaP0cgBNo
	nryf3BctS5fYVC6eZLmXQ07lpteA4iJOw+adIe2BoBg9eLaXnQGgT2uUmCm9dMuW
	iA1PK/ChcowkQgkQsl5l0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306172; x=
	1786392572; bh=g95CV+b6TgiXhzUmZbFP81/c8WX2kKWmyPL0aZHO9Ug=; b=V
	E9PxWVbnT3I6eUeOtrRfpDgpeAXxiJrv9WV5eSK1Lmnvxq6d01yUJ+cbWmZtG71S
	j8/I7YqlEDIQIHvMPhLGlZoUnNBbBF8iKsGTvaiSESu0PEmm4lwrAChddFdkVzDx
	gTkOiJlWQKIYuzpWZmPemIQWvovjxeIhpNBJTq13RvIM7v9LhR5ClRJ53xP4cmZf
	k+uAYRVrxPy0k7dWbg4Z6s4avgJ5L0iN14Idd2G0hs3BWQyF+fE5OE2p7cUfEjq4
	Cmxcpjnv9v0ViS4nK7IlLa07Z/s5B8mnDQMVW/+NAgDRwdlZiiw9GYfX8WFwhZBJ
	NZ8n8cpBTTN6D0XRi4Igg==
X-ME-Sender: <xms:fN54apqq8M-HsQdeLN5ihXw_Up9M3i-TVabfM2K9vSvCwaSe1foHiyg>
    <xme:fN54aqv6HyP2v8FK99grI_BTJenWU_rXRSIN7yNwMlHMzXeALDo5hoLm6ZMG3PkCR
    WNgys5ucPLT0iPs0ew67ZKBXBYzXjB53J3ToSpvaAmh5sZfdZ5lSA>
X-ME-Received: <xmr:fN54asYaBKPbyvUgxko-aOnxx7hwM4DinXcOxaZl6H4-WHg_YynnbU7QoosOOWAzoKTrquyNuXPLoDEEPRAZ8FsIkWfwN1aGGmy6FeiU-sX7TL5QxSyd4Aw>
X-ME-Proxy-Cause: dmFkZTGDgrJ11887wtahT2bOh7OYHsQUBgHnp9OycZqCDEYNX5Ufjd0PxPUgc93BAA44II
    4K3JRUK1n8IGY3QHnIosZnp+TKJiHUC3HOsCfTBgty9wfQwVRAj8BcVCtpdQi8RC5673Az
    RwlFGzPD8HVQuhjfthfHqTn9ng8YBO+NA1cUY6G7k74yuCagrr2gUe50/jCZjzfzptmS05
    td8pBKp1QKamNnJ1jFU+YZ+bN8W5Q8gJDQeRlu7rp3dczGUnNahSqgfh+rN9l2NjXUq6HF
    UEEiPcsIQkA45TEwZiJj4fqDyM1u+4fxM4QCyl5fNuziPGAG1B0cjqT5uyOSEMuwJLvOb6
    kgrowmICC/370vMmX5bHIt7geK9IGiOZb+HTg/fCbqImYSJtFIMcKWRqwTJiAGxkceQeC4
    L0vNa6ZdYIPBbfzJSArcNqiOQT8ugOGgY7BtAII+0NBiF2JexhdCUbFyqRZlFPuQxaHrKV
    en5Qsie1Ws3RnEkn0SrqR8rjFZk5nySLN0Y39m9+AzZ0Fh1Ol5KROMOtM4CiVMSCPnQW6R
    wxuqRwu+tZVD+8YOkIHnIXOKxXD/JKhNZmT2J1mD0uZ3ISWVAEzAS9w/GVyyuK/caAZcHG
    7Ldmyu+gO7qqcSsBfs12+0Eo8miL5pHm7YVO0JtcEJ6rgejedyA4MX3SJeeg
X-ME-Proxy: <xmx:fN54ahZoPvAkfYD4teTyjWkxBKUYE18svtXtsMjIB26mQy_yKgFCKA>
    <xmx:fN54atmjnIzB6HVbx568ndMpjMz99emy5O_FH5GfOFKcQV9GiNJBsA>
    <xmx:fN54ak23qrTa4wlXt9zBIdd6mVvPE8RvTEJoUtpMl9w6Ki3ns3eFrQ>
    <xmx:fN54al2KHpG6v1oNW45BjQbqBNcI4ELklk77qdV8j94m-I5RIpCrLQ>
    <xmx:fN54auPx_NA9OOIvsKZAKup-AYK6OtqvutIMN8Iqaw_NKKnFmlCM6yGU>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:09:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 07/11] doc: interpret-trailers: add key format example
Date: Sun,  9 Aug 2026 22:06:31 +0200
Message-ID: <V5_trailer_key_format_example.b2d@msgid.xyz>
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

All of the examples speak of the Happy Path where everything works
as intended. But failure examples can also be instructive. Especially
for explaining again, by example, the key format (see previous commit).

This also allows us to demonstrate trailer block detection with a
concrete example.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4: Fix doubled word “to to”
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index fb503cbe952..a0f7ed6fdd9 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -405,6 +405,29 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
+* Here we try to use three different trailer keys. But it fails because
+  two of them are not recognized as trailer keys.
++
+----
+$ cat msg.txt
+subject
+
+Skapad-på: some-branch
+Hash-in-v6.11: 45c12d3269fe48f22834320c782ffe86c3560f2c
+Reviewed-by: Alice <alice@example.com>
+$ git interpret-trailers --only-trailers <msg.txt
+$
+----
++
+Recall that a trailer key has to consist of only ASCII alphanumeric
+characters and hyphens, and this does not hold for the two first
+supposed trailer keys. And now none are recognized as trailers because
+the candidate trailer block has at least one non-trailer line, even
+though `Reviewed-by` is a valid trailer key. Recall that a trailer block
+has to either (i) be all trailers, or (ii) consist of at least one
+Git-generated or user-configured trailer (and some other conditions).
+And (ii) is not satisfied since we have not configured any trailer keys.
+
 SEE ALSO
 --------
 linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]
-- 
2.54.0.22.g9e26862b904

