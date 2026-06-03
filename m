Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943853FFABE
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469954; cv=none; b=GvroqGCsv0UWmtnVjxH4CS0Dlio0rH7kGiRoKTc3IjvPcXFmibIuFfzgX8C2UmcSxx2Evn3uFmABw71E47xfs2sO8iPnWRUFRdMrGXiQ1ed2vapiusj0vll2EDLck0gJKL8ufMu39yu0WF3tB9kfdkhErqipbLRqLqqFs0izc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469954; c=relaxed/simple;
	bh=an+mjaPTZZtseIY/cwO9ttB6hgP8cOVg3ijA+1JffrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFW8o3qouMS3LNFGRxkU4AP54wer25hPiy+I4aUjYxny8V6IJAsducUFAsQc7kKFY8oOdvhV2CP4cEXQOKti4v3L3sVr6eZWFQJSgsblilp7NnxEyAS3cTznTOAZ5YhVt1pk43RwiR0KejOFwnvI6iEKj8j27OjaC1dGsHpb/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRaM913C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bK6PaMFQ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRaM913C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bK6PaMFQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCDF77A0128;
	Wed,  3 Jun 2026 02:59:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Jun 2026 02:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780469951;
	 x=1780556351; bh=Fbv2hAyjJYJrxTPavEVD20IiXXKwjkMJTGFJMS2J7TE=; b=
	YRaM913CGeY2vF/ImsBUwt4UU0uKxP1Miu3BEW8Kx7E4rmdd5r/6LJDKxOuTevNs
	pJo2uAzbgw6490Xs5J5L6bhZ9JOmka9E6jCATJKBOA488FPWOAd4BGlJhfESEMmq
	cy1JGg+KzyPs06CNdjTjYSegklQW+ps5iECuKflVyFO37tLbMqYsKO6WWA+NfIYa
	K9b6CDtIo2j2t6IuAn6Xo5LOu8BBCbkNzbbxdhSQssNNH6OoGxZfslVXRso9suqo
	dnL5eYKFX5VvW/xBWVP9rlsMqnQPiuoA/iUUy9ymPmTwskILvhZ2AdLwanOtT4V5
	jK5zEm87b2tSQmqxiGHfxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780469951; x=
	1780556351; bh=Fbv2hAyjJYJrxTPavEVD20IiXXKwjkMJTGFJMS2J7TE=; b=b
	K6PaMFQaR+UykX51SlYzrFHvdtZ4fHA2aVag28MpmVcdIJPrwfxAmARqzcZzSFEq
	3JZ0OAHx/eHbsSGo+6mj8/ItYwweCKWaE6jz5zWtdnHTOQAv4iNdn8mWCS+TTuj6
	JWzVZcb5cacofjP573wHoDS+DNI12vVy6pV1Rfk1u9dE6a7tR1yLsvwfaxxvPtP4
	qUi+OkUICbGcWkpYRlkzRJ99p9aWf8Kucl67c+0UtT+v+Cx9JgZFg2+BuQoXYHtL
	nK6Clbb1V4npapDy51UabGVVxF6EgFWUCXmX1XQ9SNUo96fBtRbFtxI6tfs4WiqU
	SDyJc2qw3csO3Nxaq+JRg==
X-ME-Sender: <xms:v9Afatj-5JApDiZgycDILYuC8SpaTx8OuQKKusQhBJh485nIEryWuA>
    <xme:v9Afaji8NzNRd47q1t_JCcukPqxr5Bag9hH583g2p0ssg0I1AcgseDQUjeX9DsN7E
    d1qYv0zR7nDsMxZDX0b6--cnPFJJ_UaM30RpIDLuW_JYILO9jSq>
X-ME-Received: <xmr:v9AfatIwiyoRCXA_VT--rweXDBofE7V3UB1gsiBXfLmtSqe6JUCResGSdsw8Jy-rurjTxYucoWw_W71jHAWSIbWJsQ4bWLH0e7uIACGZPDUr>
X-ME-Proxy-Cause: dmFkZTFE9XMyIIG2Be5lB+B7m/h69VJGtBI+KkRpohOfFQFvkDBt25qnG3+36xWOD35VSj
    MkgThNzKgIZYLKCdkUmn62+EV/W47nL3gphA8UgFc1w/fyaR3iVZUVqwVv5w3H6HFi5cNf
    SUyn26HTC6scKUysEozxrfeCBXIOQUxxq7UrQ6yJCwDtrRAI9IFXIj++l9zrpxdQ4QFx6Y
    ZKdn8Q8C+gvB2QQib5kj68M11+R28qiE9sXDl/7QL5Au7CzJt2fIOn/xGIJvfcK/Yb+NBo
    28cstpCmM+QG+hNy+7bCrqJpb16TyI8OeZQ4zKtykXPP1C1Y+sE2xCi7p6lMjA9/6qCceq
    DNVneuA+2WJwK2zF2OOtJUFMOV6QCbzONLBgcdh9Aij991VI97NxBWld7dRuuoNu3xcMLc
    8tlYF/4aDjEs+/qZrqIpRdtcoaqcYFj6gxsJBOb9SsbUcWQk1k0qWArAreWJwvu2y7hnWI
    0tjxaJoP6KaVq5rmM3y0hjYdy5C9BOrnibyeyMy88mrET5rhyXAA1EhVqx+pQTTtdYGyd/
    YQ4yxdq9uBmYK94BKNw4l0r09QSyejC32gt2tPAvmkK6GuQBVp7AiB9Va9ofrtfzstebzq
    r46xpUDpWTGpGAD1Z6x5ItlkS/Rekjh7aKQzXPeN1SLo92GwbjgJ4HyMvetg
X-ME-Proxy: <xmx:v9AfaiHPtEygt5ie4ciTS1NyjrbV8ZG1H4P5npOE2D3CrZItSd41lw>
    <xmx:v9AfahQfuQE05rIbrbu8ZAnnKmYQGkwfSdaTzu3hqzRhqgE4LxeS7Q>
    <xmx:v9Afaud0nwNGD7aQVsu9f-WrsQl3jSoHyhUDVkjWbK_4VN0-gB9XBQ>
    <xmx:v9Afagqroy1rzDMJC9yT1Kcvom7DEJS0wXGxv6hyQPl-Njk9YKivXQ>
    <xmx:v9AfapWWjmp1eYEdrEN2zRiilPv_y431SbsarbhF_xdkRH5-YTqlP87Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:59:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2ad9cb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:59:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 08:58:59 +0200
Subject: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
In-Reply-To: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.15.2

The "MyFirstContribution" document recommends the use of deep threading:
every cover letter of subsequent iterations shall be linked to the cover
letter of the preceding version. The result of this is that eventually,
threads with many versions are getting nested so deep that it becomes
hard to follow.

Adapt the recommendation to instead propose shallow threading: instead
of linking the cover letter to the previous cover letter, the user is
supposed to always link it to the first cover letter. This still makes
it easy to follow the iterations, but has the benefit of nesting to a
much shallower level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/MyFirstContribution.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index b9fdefce02..069020196c 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
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
2.54.0.1064.gd145956f57.dirty

