Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BE303A35
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837431; cv=none; b=hsiyTI3zXyX9iPRB6/iKE7P5V8ZuKzFNoLSnlz307Lytw4Y42gp2rSqLb5xx+MeTJ5lCUgYafPCTOfwyCGrNERuzqwbbT2/oPorqJnc7DuskmC4nu743SAMX8Re5ZPmE5JIKYg5r/LiMe4UiA9uPz6YvEZrrbsDvaePB+xqS744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837431; c=relaxed/simple;
	bh=4UcijMFhxx+G59fG6JeSfOO8bQprS4B6MPHjBJL4150=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2ybbFE1+7mCVaUH3OMMK+Z6tz2S15y0j4VjxAcoBZYggfZ/4BJ2oT82wUpQZ2UB3t7TJcAQzs20gs+fn0ayrrJtCXwvgI0sCDWSM6zZEF0IMXCiPY2/iGxVjT8ZgwIqlwf5ZHLzXqMjtgaS/ThBU40wb0Yi4ObVc4cWrNJjH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U+QPAO4E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q85Cf9+L; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+QPAO4E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q85Cf9+L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA9307A01A1;
	Wed, 11 Feb 2026 14:17:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 14:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1770837428; x=1770923828; bh=i2jeGcYXEYgB2anhmMJ/9AJDdqBIm3PJ
	4oCmmmfb8HQ=; b=U+QPAO4EgqcdmUxzmonGjIy9YtE3zMPzYM2RTjYywfQAD+9v
	uXATCX2YRdvSS+WiEhtn+BXkr4Z++FRrgoHXpucx4FhDJ63NvgJLWsUqL2jd5r/P
	a9UggxRJ0Fm0GLA3VBqfkKMNRBDGRQu+T2JhVNLWUecr6kJ9QizVEclnZWPrjfYw
	chnz0/bmsyBAkvLKyeRyfCF660mMxl7Bl84BTV5NNjrebO5VaNWeVgspweVl/P1o
	4apA5pV+cmlQIIP1RQ6wWMMyy7fk6ZMPCKTsF5kcD8yu9u1k7q8wTxrZIHNJG/9R
	Dk8ZcyjQRllOICCR9OUbDdIqkDbjnGgaPTu/fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770837428; x=
	1770923828; bh=i2jeGcYXEYgB2anhmMJ/9AJDdqBIm3PJ4oCmmmfb8HQ=; b=Q
	85Cf9+LqGGhHZIXldvnWFwqdCznM3392A9ykBTlmO+Ire29sjujcMmQCYSi4R6Ww
	uZpA7a2XXV9LNrP5BVUxyQTQKEKXoeEDm5pGvhT5eBXmCbvL38mzXTXYpqfqaIju
	HQsz5+t0PIAd6d6Vh1yDLhWXwEJX9AQrSGy1eZ+qDLZZY+fumr0/g9NynEIX+lFM
	NBi4vWHgFNDYhv22CtopQoNJ5uhUbmP+FRBHbmCUeV5tmzqGqi6qL/TVj7rlpZZk
	uTyQ5/GTjqJxyExm3P2GYqpoCUJW+DAkqPtCojMy2M2pNYGrLyig247jniIsjt1A
	9PSFTHrlAUcK3AWLi7G7w==
X-ME-Sender: <xms:tNWMaRcNA3T872kbKw_ERKeAiQZVNVmhk7EikdM9kAVs7eTn9VIvFw>
    <xme:tNWMaVPc1v4WgjRIgqUwrtDSLB6BbV0NeflbUZ3yWryTLyJ_rBOLaQIP4P7hOeiOm
    CGpZVpPHIaAxEgn8c3W6rsDVKteHdF5v5YkDkh5Asrm0gwV2t2D>
X-ME-Received: <xmr:tNWMaYJXO9YprqJTPcCppuL3i84UXSvzn1NcL-TueCDF7T4QNvLrkulNOs2R1NohpKgG1NiOVKriqEpkOmj1m0At7ajpdpcOXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:tNWMaWFXlRfe6xWbZ17veZs3A7CkB11OIGX37ixq5kvgE-vvaGrOgQ>
    <xmx:tNWMaQTYScxiI4MXqTJ43FRzLvFgdMT8XzeUSBSfGGan2A_TyVnETQ>
    <xmx:tNWMaSF9zIzswY6Ks1pYplOfd9dV0NkqdTSq9KrD1DkhB2wZBwSAXQ>
    <xmx:tNWMac-ffX_MvQBEdJoTv6wxCR7S2q1sKq7f7k9_mgwsyjhdtpttuA>
    <xmx:tNWMac1yL50lI6tFVCNoeCTd71IjFAX29-QKbyXMOfJU8YAAy7P13Q7v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 14:17:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: document NEEDSWORK comments
Date: Wed, 11 Feb 2026 11:17:06 -0800
Message-ID: <xmqqms1ft7il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We often say things like /* NEEDSWORK: further _do_ _this_ */ in
comments, but it is a short-hand to say "We might later want to do
this.  We might not.  We do not have to decide it right now at this
moment in the commit this comment was added.  If somebody is
inclined to work in this area further, the first thing they need to
do is to figure out if it truly makes sense to do so, before blindly
doing it.

This seems to have never been documented.  Do so now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index df72fe0177..b358d6bfb8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -33,6 +33,15 @@ Git in general, a few rough rules are:
    achieve and why the changes were necessary (more on this in the
    accompanying SubmittingPatches document).
 
+ - A label "NEEDSWORK:" followed by description of the things to be
+   done is a way to leave in-code comments to document design
+   decisions yet to be made. 80% of the work to resolve a NEEDSWORK
+   comment is to decide if it makes sense to do so.  It can be a very
+   valid change to remove an existing NEEDSWORK comment without doing
+   anything else, with the commit log message describing a good
+   argument why it does not make sense to do the thing the NEEDSWORK
+   comment mentioned.
+
 Make your code readable and sensible, and don't try to be clever.
 
 As for more concrete guidelines, just imitate the existing code
-- 
2.53.0-247-g50a2c88be3

