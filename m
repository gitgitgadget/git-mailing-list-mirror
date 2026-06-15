Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB933065D
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528396; cv=none; b=DO0+qKlgrzZd73VnZXtCAwdjjuZi7+csYoAMtqFZHb02S9uiXAXOAQTIalycfkvTPI+jOKNaeOZDAxeqUYohaAcEkwTzPPM4AMQ1C13pR5McLDYGppsXFOZAXMoKLzfljV0x1A0/I7n6lqGAgnJmUt3zOS6uyQjJw/rX4xq/blI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528396; c=relaxed/simple;
	bh=tuLwXao1ddH9P23LqJVBjtb66axDrAX3cSu4l5tTflY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pznbYOgER0RqbVH4590j4y5izj2NP+LIegleCw9ft4drFe7c2zy1vNVjMDqlRmUKzGM6x1lFsmwDF2fGEbbF8bi5LVmVDveoXPUrhF6l3jBqdO5WAxOcTJG6URUZlu/Cj36IfZPreUSzH2mHbs2re5RzNoMZBL8LqplRls7V7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a3kkYAhT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+JEow7V; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a3kkYAhT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+JEow7V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B8719EC01E0;
	Mon, 15 Jun 2026 08:59:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 08:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781528393;
	 x=1781614793; bh=+duuHPKw2fj/j3P427nI3uEhlQPNcNR+tvk+uototLU=; b=
	a3kkYAhTG2cVZY31cHF+K93f8I+EjKCTGzMjC6Tj64+ZeyEZ10jeD9mt988TG+za
	QgmTvw3mHOCaeZhi+xp3EexQuAqFQGHtaIQhJNiZ65shBTzLlGEwqwrh9v+3Js9v
	RQa7kf9q/3HspEc65uKjXGY8B13/UXDMURjlseoq7SVtiTvQCXg1/Cl7ivR0ev2e
	x2cv+Kc85HUn3VC97aYP6k19jRw2GNDDMXmpn+8UwDTMYRJJd35/tXU/v7kSa17l
	xypDbuDs/cG//BU5aYjWrRKpeP00iQuqQMad9PeJA4c1gavrPM3p0PqNw8LZEVAu
	ZZcQYASSqhwlXl699K0i3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781528393; x=
	1781614793; bh=+duuHPKw2fj/j3P427nI3uEhlQPNcNR+tvk+uototLU=; b=R
	+JEow7Vh78/4Vo877jyOjInwW34dqvwYnd9Byn94SfrGn6mN3X2/Dcz6Y72y3HSo
	eCS7aS0JZxhyFDXnz9qk52nAzSTMMXdKqtuGRxPrWK8fxUeN1QQLLaOE6kfx1Q1p
	NqtnnM+znrTLDiYA6yqaDtULeeo/KrDAleAyiwUkrCFgLg0DvTTwsGzQpgaLOsiN
	P6LL6Bh0xyjtt39Q2ASff6E5oB2IAPMCG+DSnEwnM7kOXrkapDC/exknP+TzfprG
	JBAVkc6Cxm79rxI7p5q/l2nqGy58ZAa1ZYsjXjt8R+0rDr/E6QZi1E5ws5khajle
	D5eMZBa/+q8o8Pbl3+vMw==
X-ME-Sender: <xms:Sfcvagds8BwmXxrN16CfpKpWUIWO-6AEc_YjilwAalKH8XXKWlYV4Q>
    <xme:SfcvanL-bAmkQwNMONeCdAMRdHSvEWcLA68Y4jHxkMn-b2mJzpjbLABx08sdREE6c
    3ZmJHzovXN260MyWdiWfNMjxBool1qi95BkSJAfrx-ek8P30ZXY>
X-ME-Received: <xmr:Sfcvalzymt6Rqpy0-kPnQLVydkZu0EwryWvYcu7w1IThtqQGA1lkxV3TiJKGOlpNOsCz5_EOWuc0KcxLkRws6A4ZJmODeC69A0fcBOjbQQ>
X-ME-Proxy-Cause: dmFkZTFAP/RsZ2ztb9AFRZGcJMRJNdbOBXbN9v0CSQgdBTUTVcQ8qWNLB8qIF1OObPmZyV
    ERwPxR4CgVn8QaQDXt9X6AD+fLqccdWiEkzALJBZOUBueDgC8PrPXdEHIrKeIHW/rqqjrk
    btm2o/+VEdg+hJVtJJz62wkfui/htRPqyjO9xhY80n3slmc3JJ2nfqZ5Byu/DUX8vPCtny
    u+2IV/hzcG3Ljvy41AT1k89srYmDWW8pOuHPs49W//nJGXJVLcdKJGFpsnnN0AcJGmH5O4
    /4gsDHsrcYVSRuJjFzakFcWcyU4UDacH3JtaVEx5S/Ns5q+PGxumY8Pq4x3PWLjWxg2TRa
    4GtpNissj+8wKpax8wUNsFaq0MlEmuqLpdj1nYLO4BUcRZS4SHZz7tU0dkk8q0SjhvJrxy
    bKoJIBoIbvHpMVTnfodA5e8gNRezQKmrp1eBQ/15QQyMh8IIfjO+NVmVU16CFX3tR7Pcip
    4JnIO9fpJViqGKJReYDhv3dAf+I7clQK6YGcki0i0y38CkTNIuYcoQG4aRNmdJAWpVDZ0P
    UAnOVbhte6n5Zg9GG+QykTVFVCqkPoK8HNg3zH5rEkcUomhm0dTt+97Hlk73Ajl5BPNN2N
    nWoiq5jEey9VMm79LkLPFQMCURsTzIRzFepN0mFv4tqyj0x+Ubgq+f/vmvlw
X-ME-Proxy: <xmx:SfcvaluPKUTpdDb0YRXTOJjX-j82T7jTLMESSa7ONjq5aA5lwZuKhw>
    <xmx:SfcvagDIaDerd8AhRPvPj8-SP5d-Mek3z69mAyZVXWgsxHYflBUhYg>
    <xmx:SfcvavEOGZM-BDc9ucqhu3rpnkLSL4NYUvLxH2EnSqoZs09Zo4gDrw>
    <xmx:SfcvaoAb6lx9RLaJkaz8_HuKFRwRbcTt7E_JAa8jT7Wny2Hk6rmZzA>
    <xmx:SfcvauNlI0v2g34rLTI6Hvjrm1zEf_JwGtycbfItRWalYhLHcepsW0i8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:59:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a09a56ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:59:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 14:59:41 +0200
Subject: [PATCH v4 1/3] MyFirstContribution: recommend shallow threading of
 cover letters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-pks-b4-v4-1-22cfca8f19c5@pks.im>
References: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
In-Reply-To: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The "MyFirstContribution" document recommends the use of deep threading
of cover letters: every cover letter of subsequent iterations shall be
linked to the cover letter of the preceding version. The result of this
is that eventually, threads with many versions are getting nested so
deep that it becomes hard to follow.

Adapt the recommendation to instead propose shallow threading of cover
letters: instead of linking the cover letter to the previous cover
letter, the user is supposed to always link it to the first cover
letter. This still makes it easy to follow the iterations, but has the
benefit of nesting to a much shallower level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/MyFirstContribution.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index b9fdefce02..984b7f5aa8 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -790,7 +790,7 @@ We can note a few things:
   v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
   three patches in the second iteration. Each iteration is sent with a new cover
   letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
-  previous iteration (more on that below).
+  first iteration (more on that below).
 
 NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
 _i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
@@ -1214,7 +1214,7 @@ between your last version and now, if it's something significant. You do not
 need the exact same body in your second cover letter; focus on explaining to
 reviewers the changes you've made that may not be as visible.
 
-You will also need to go and find the Message-ID of your previous cover letter.
+You will also need to go and find the Message-ID of your first cover letter.
 You can either note it when you send the first series, from the output of `git
 send-email`, or you can look it up on the
 https://lore.kernel.org/git[mailing list]. Find your cover letter in the
@@ -1227,8 +1227,8 @@ Message-ID: <foo.12345.author@example.com>
 
 Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
 below as well; make sure to replace it with the correct Message-ID for your
-**previous cover letter** - that is, if you're sending v2, use the Message-ID
-from v1; if you're sending v3, use the Message-ID from v2.
+**first cover letter** - that is, for any subsequent version that you send,
+always use the Message-ID from v1.
 
 While you're looking at the email, you should also note who is CC'd, as it's
 common practice in the mailing list to keep all CCs on a thread. You can add

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

