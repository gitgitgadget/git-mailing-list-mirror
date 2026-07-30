Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D63FF8A5
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403224; cv=none; b=DkW++iuLSCDJ8sMJGmGZsBYu525SU0fDNG+st7TGcAF4sRwVH9jEW4PHcId8zpm0sZPPLayX2+SRHEyg6FP1Ioi5gkIM0Y8c1b1w8MeLhxTy2TYaOnFQptq3UwgGYPvBgeMmrBZ5teJ52OP8RJhaDnLyriNVjNCZ1lBfNGsWGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403224; c=relaxed/simple;
	bh=UM2NdZIB3QMuVq1T1C4jwduY2J3zyr1i2KoKK8/u+d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaUBNdmVEyVP0ZlUO5mhElNX+H6MUpVeNimXvmcqfHIFMKvwc0WZB0uZHq5EhnaEl3L8shZpMRIAP1MJmF0lxLN5H4a2KBS7b1Qy4UCBD0O4CNFTQW8cs26bTcMc/jBgyKErmGzDCwZRJHeCJgunDVp/uksJr8+4RVRLp7Nc06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OCkYq08G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vrcj4AIm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OCkYq08G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vrcj4AIm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 858877A01C8;
	Thu, 30 Jul 2026 05:20:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 30 Jul 2026 05:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403221;
	 x=1785489621; bh=IMJNTcZst1rokpSYYy0Egy7nLVNWqNZ5Im/Yb2qgZew=; b=
	OCkYq08GN6bhxK9Qyn7Kn6frpnsfRfZmjJbWewLhvUnexiDfJGNFQ3BcJiWxGmJe
	MJlxMSUHf4tkSM+EKMsA8XzF4mzccYWAzE/DiWvMxDRR5FEq9YixhM2zaJe1Kxd0
	9mhuzCkzgvlXKrAJx7MqstbPTqGniRp6Xog6zIBGI1Dji+C7tyQYCnx2AxWXV+sE
	g2L8JQO0TsvpWdstssk36sasqmOdL3bAcTuEcFUnTCMsXsQqGss9Hpsvrx/cv192
	X6YSvI2O+4dQR/RX/tLXRYcHvAvsC/ci51ddMbCiZX4v83v2Jnu5q/Fg0HwaU+en
	AX9qUteEN0diS0FBYubQAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403221; x=
	1785489621; bh=IMJNTcZst1rokpSYYy0Egy7nLVNWqNZ5Im/Yb2qgZew=; b=V
	rcj4AIm2aKIR52dMGRf1pQrnvwf41t1g4H0419lxTghpNSyQp88U0eqTK3mLQWNd
	N+NI/Bbj5pvMbikcjVSEIK63OLYpzgeViWeJsGw+nVybdcHP/ajXRWYKkyuLikKD
	aRINNQTaHLuKcoPyAMVpGBTVlbLUD18XbD+96IRIBoImvkI/Z0yCsH6Ga/ipKRmn
	d5PnzkWTBPq2kyHJ6077B8ZwOTnWQl2dQe1/3lGnxzQUHkgJRzX6fT0MYJ0nfj/t
	coTkxr6pLkXZ9A8RUKh+McHvQhJt/K0piHx7qRbuV2dCnKCgIRBnMAh7uYWjv5gy
	HTeSaTFflGmYfDyTFoERg==
X-ME-Sender: <xms:VRdravTVtACWO9RdIbF_lqs4FC-6Li3dFSE3zAwCTCBips8WXGWS7m0>
    <xme:VRdrajUx3MwgDkBTwkYHw-WlILi7q-xJVE_Vpb4_oFBiHidrBD8OWiaE8b5hpz3ea
    XejAJQ8YMh1XFZMNqyMvY9Tf_HdwCNpUshL5aHPCV-_NB3KE3vi>
X-ME-Received: <xmr:VRdraodm8OdP-y3Rcbd9qFlqxi21g_IYjtyAM20JAfJ1RgzlbbNOIyxX9z8lxo7_0-PeM7GHUncYF3FDOc70p_c141U8rrDVhSA-1lSa5v1NFIjoeI9IEm8>
X-ME-Proxy-Cause: dmFkZTGXAVUv4Q4opzhy3jIgSS8da54ex/37IIodgSfWX2RpuheOVh2wbqCusuyZ7XOq5A
    jNZOZqTQsq62sCypvGM0mTgFKa+XNGGnolotaJ+YkiooVaWzu6Cw3rHUxaQRyZ+lI1LZmf
    N7R1398tX+iKpL6geV76/h746tJ4MexwRT9x7PrvG9kGop2d+8c+uQ3WH5eisakZ6fLKvb
    +tGkMxd0NIz0q8spQm7upKF6jQ6f6jjN8HfG89atl5YeQFTggvdRAY496w7JZufgeRJbs+
    XhgnAU4XWrphW7E3/paKyM/8W56QkENHMpbm8n/3M5jRHNTXzT5loVfPkCn1fimexeyHGX
    Hm0KdZ7p/vTuAMt6y5w9CRZW/j/bhLQMClKMB3oJ1VhIDC3Dn0bh4LFwN4YAY/9cHqIyGG
    KV1UkQN2XCbC5GsNiJYP0en2DxMjLxo7SrgwKA1NnAO9PK3MMamGmaQt16v7lepXAiKZQu
    WmHIfxeQs0BnchjqbqZ4N7xAW8CJmCwrZK8+019AMQoLG6mT0//dZtPiOaJQAzzmp3ZRxV
    sBdNDEjvQjeqrAWMdcGks8253vvgsdcC+Yur0sUlqbzxz/U3bEToKMZk/vMcCqAyUt2GC9
    82lFebpB+V/Lx1Tochy+TuxCa632dx7x0bFM/ucdEJKz8fz4ft5Jj20ycMYQ
X-ME-Proxy: <xmx:VRdravKmeWH2SNxNFlqOIglL1kYHS_spOHuin7W5NNbdkGgsDvRQAA>
    <xmx:VRdratywYRFrURe6FcABhPDJYNSEdSqKOf6ijkEnioyyw158YEBNMg>
    <xmx:VRdratur7w9snnPvKW6KDPdKiCfvWig9cQgOtdFe17TKLAWSFiA8kQ>
    <xmx:VRdraoDqXT5y1HMovSRNsn_TZl6-8mB_-hUxo_CAIR1GVVr9izfdtw>
    <xmx:VRdrassTOjvbggAm3-Cn6km35IAJJ0e5UX2uGos3JhpCBqd5tTI4khuJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:20:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v4 05/11] doc: interpret-trailers: explain the format after the intro
Date: Thu, 30 Jul 2026 11:18:18 +0200
Message-ID: <V4_trailer_explain_format.ae7@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
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

