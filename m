Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE0331EA0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126628; cv=none; b=r/JFfv8LOwsG1EZAdQT1QwuCoSfiMqBuVxkKe0Qi0KZc2/dOFRCg5e0mSCpAX5XASeVCL3LOCi64yuf5UgEBM0PCPDZ7my/hBu/0/GU8E51g3i0YA/P/BmsZXvtOcGJZPPhKkw+kfpNCxikGjtt/8jXqQ6uLnBg0NDtue9Z+Ru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126628; c=relaxed/simple;
	bh=jPBGY05vkIY5Gg55UMFZ2pfh9r2yX/NVdrpZ+O2zrZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhvfu8BEB+svy1M8sCf/BsTpfle3v0X5QzjgPzPmvCGzf4fbBTaH7d6AiTnCigIBVVRYVxwhnTpdjipfoGFnsMQ1oLLx2v3V2fLWxMsQeddEwDDSQ9caDuF3vt2MdrUH9H52Z2jCv4bfBNe87ZSqEpjfpR4nAQv0utKaCdkLJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=0rXy0xYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di7Y8gYr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="0rXy0xYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di7Y8gYr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EDBB11D00073;
	Wed, 10 Jun 2026 17:23:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 17:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126626;
	 x=1781213026; bh=OZ9guw69pg/RxMzaVEmAVvlOzTQcxiQRIz4e9K8UF1w=; b=
	0rXy0xYkma25vZnDikPCg+C4jZ100MvvlFmenRpZ4Io+usRh3fe8nxNg+3tSiv5I
	HyawBJC0hO3WMzOwGVSphJkiiic5MrZoRzLiSZUUbWX8L2lVAhtiBhzBJzDHGkQD
	DpPrY8jNhCITn5Y5PcAb0qRh2LjwnSRuLCOVZSeH5AtI/quoTHJc7/Qb6DHJFTBV
	gbm8wNA7NizlyxRUpBozXHMKzlyUSybCpMEAXAqluMs1grRDIfALglcywqVNtSQQ
	PvdhcMISLK+YuG3qFbbb6u2Ed7WKq77jBv8nquckW36fQuObEl+JlVgpdyOkTEtl
	Q8xqS2sMwqHG7+eOK4OEmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126626; x=
	1781213026; bh=OZ9guw69pg/RxMzaVEmAVvlOzTQcxiQRIz4e9K8UF1w=; b=D
	i7Y8gYrUbyovI3Jfq5DdVcphbhOBKLYPbJIzMpKi3h8tiUKQaBmjcUwVxb31IYzK
	2iYQMDufCroHQqvpUty5dwN0TwONxi66AM0X457EFOd4fj7ESnb56NrfBJNs/qhs
	Vrppx8HJrQFH8xAiSHJroANySHrRRFA926vkEL2uHHzPVaASkKYWT1fBgITkeBhQ
	T/81WlMeKyp/i8z6DeU1SnIym3bi3CTTLFnds1TaC9BbJ6dMLJJKNB4RH7zlxAuC
	43L2hdvUFxGZIbwHEXkkATYXN4QmqW5rXYHnawEiOxblrMEasM3IrDpsF7quG7jo
	QX/P7RmLWWHMwjvqEwnbQ==
X-ME-Sender: <xms:4tUpahe5oY3dx6KNA-plYJ-jxCkB_2iU-76IY8H0i6sYEwT3IweXRkY>
    <xme:4tUpai66yySG0ZsVXmuLFXsSOyIP9-MmVenZ9nNxho64rcpqkRo4d688wM-39OQ2S
    2DG47rFRUVwK6yPgt1953G3JEJ21XfsZy6cgd4hZHPMO6FC6usk>
X-ME-Received: <xmr:4tUpakX0LoN4WPZCaKsT2eJoMrBp63x0PHPukgAaL5fFKWNmgofZCHxLeA89sZeA_C648437CCBv2JE7oPNS8KFczFDRPQsKHkHb-UIkPK6atPR5oKzv5s1zwg>
X-ME-Proxy-Cause: dmFkZTEDRODY6dncr8bwhGw7lNbUcvIuw71usLJEASv0TjdvNKHZWp+zgcK79ciH8LAFkK
    RjGz85sZ4jlm9hztF50LVadJ7XfD+Akj4xQSajRCe4XOSfLcDlYpyRl+pHUE8YBho0LeVr
    8ZkkAuPQOV4M/Guz5wr+pCVS3PUyAcesj8ZI2ljgB7D4ViX1RlPY+MJgJYgDp0Z34iyso0
    7+KJAy495+nDsA9DgtUpI5obFv+GuNRc8dX0zRAHU8I9HbcYfMm3lefOfiSmf3Rdv0oCn2
    1FJOfyVqDrXCnv6yDq7SmQMBU67V+HOnk2WDN2OHXFLwqgp0GflLmxfl8F9XPyxzXUAXUZ
    4ylhswffpurXNw84BDbGfYJhOPVkoxele9RA5zT/GyDYwughGdS4xGSLvbZFsGlPe9BupS
    uxLRwn+Mytk+Yzc69VSfvA1gF2ihpFb7kB5hUjK4QlFWsJAdFL+Qvz5dIsTciakhAS8Ibz
    7FwfEeh9wMI9FkNVkv8AOJ7mjs5lkDAZ0KJc6R3dmKrHKbgj9RNBfPvFETmiEeKSsFSI5L
    Y1A1gfBrau2xUher0uDg5lQDECfh/srcGAC0IyA8GbjXiAqtAEXPMNpfUC2kjZDhunn7g2
    Ab50G8PU4wXa42peWzTo64m1DwaHWwgGk5iR4HkUTZ3oXTOSHuZhnwuRrNjg
X-ME-Proxy: <xmx:4tUpah5v_fN4-7lb53JjmjAOh9Dl7-SYi3LzaPAoy79Kz8QFZTk8PA>
    <xmx:4tUpavoS227BQ9UEIGhTghxBFsQq6zdQr40uMIOJTH9Z_GV-7yOOWQ>
    <xmx:4tUpaknP-99HB59DNQvXAaN34jNNrzgc_Lhr-vwLHXTICO46CMBoIg>
    <xmx:4tUparNOxw35EJtcf0vdD3uRGwbf_69zHD4lrT8h9Dj0y8ULH-3dFg>
    <xmx:4tUpaqCmcjzJYDguE4CNqHlJV-msSXeU1STnJb7E8HlE_luUXyNSmvp2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:23:45 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 07/11] doc: interpret-trailers: add key format example
Date: Wed, 10 Jun 2026 23:21:25 +0200
Message-ID: <V3_trailer_key_format_example.8aa@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
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
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index c35fa9c688d..f215cba4bf0 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -405,6 +405,29 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
+* Here we try to to use three different trailer keys. But it fails
+  because two of them are not recognized as trailer keys.
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

