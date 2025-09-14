Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE857C9F
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879503; cv=none; b=CvPbqKj352wkIYEokRMOt0iOi7/Kxz9I6IxGxlV9vWUcsUpRHWnLKhUUc0vtphvvEwmuNMAoXwEod44ELUO//e6TW2RKomlWHmy6mDX7iWdnxihNXEXNBs+d6uUpI04RuQVAXtvdwNX+L+N7uwJR72H+xxahDzcCwucu7CHJchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879503; c=relaxed/simple;
	bh=30lwVhm3/AJbK2ZZ6p8q4J7Jxd8gz7hKESjrzsmuMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msSN7NhSoTepK04vqMrpp8RgMwYaItRYFXmXUojkzTaXt9+wOHj9SQEFcNb3AZRCi4/WHgzrSAtpwEgLxGmcLT0hTQ5JTwfr74kicNjaF3ExaxGBwG1b64NDcF1M/E7oUSmDvHDqsOsJlMJjghJ7p9Vas2KTK+JDFhuxpkZAejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Cs216YIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0U+hBGS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Cs216YIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0U+hBGS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BC317A0060;
	Sun, 14 Sep 2025 15:51:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 14 Sep 2025 15:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879501;
	 x=1757965901; bh=PVAKEZ7uiGI/heXnLoVOGsuRvneoIi4/eN/SraVGtpc=; b=
	Cs216YIPXwJByU2WQJkLKVFmaRGTFoOn4RrFjokFi5WJCb+1boNVeJcwQd5/9+Kg
	60YbTm1tSaCZX9df+4Dl6kZzUhTysZSZL96cTaK+d/UomjgD0aMUyUE4BqxCV7xx
	7An3QWeR/T7MBWPdYfzNLTqqlVhfjLa6CnN3pkBxSmcxF7dz4bVsSA2+P+mnAmwy
	+TRL+m5OWlsWyWb1vD8SWuMIhLsQoZXT8id4gLNbROs6SWo07mxTftzM4uW2IJVM
	Jvu8G0j2WfDL9bzRKzFToN5YJI5Ue8MiXekibrmGIDVIZ9AULgo3AfA8i5blD5Pe
	0jzN4GgD4VWCsHF4UqQfVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879501; x=
	1757965901; bh=PVAKEZ7uiGI/heXnLoVOGsuRvneoIi4/eN/SraVGtpc=; b=h
	0U+hBGSUxr04JpHtZRSMZhLOuqO5aY0Jjdhe869rp2jPrDrJLGg8COzvartdutVJ
	lLSJZ4R5igKmPdyL5fcfGWOEDBXJhFANQwwC7B3v3bQl+L5uro087IvA7jtjvEqf
	GdosiZnu7ze14hNwmxcNf/XZfiV+JU7nOG4tH2/4Ao3nWkXzGBlHG5b1jp7CSu7V
	C1b1xCWn6cD5mAIVKMhg/x4nr1I2OkEIXbdmjxtZsPamHkaBGWwIejotcJQaZa/8
	Mcbo6Gqc8/5JNHfJvDlXUz49qzYbxE8+RCz5cm/uQqwVfOhlOKsdu2349HAQrGCE
	FtqR4A5Rlf7vJPSlmTyGA==
X-ME-Sender: <xms:zRzHaFT15tCXvK9S8fKQbYl_0NVuXpVMav6T-KZYzqWQcbE4EUx04iM>
    <xme:zRzHaHNH87xXol9vUa9AgGiVMuRp0SmhxPyhezLuECH8idllfGzJS7Xbbuj_WqPwM
    k8W7GDfVWZpxgAstw>
X-ME-Received: <xmr:zRzHaLQtuIFka3ygakhiuYYiErDJ_1p0Q3jR5HpHIY6fRpGt7jkU2cELg670oOmO8c-9nJMVSqfRbc4e4pDwLoMiwqK1Aq9qGmYEoHJwyod2IaGMniu4fXPXgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zRzHaNj84FQDFBUDqCKHdp56zAfunYZLx2om4BnFx96Ucga4GZAQog>
    <xmx:zRzHaM_WRT0ySQtrLIYiAQ11si_0ArqWXBpNLlKg7tQj5h3SSOZVqA>
    <xmx:zRzHaMHmlmxgiaIjd7lVF6RT6v_O3pGkDrHMn23Kp5mA5gC5qZoL3A>
    <xmx:zRzHaHmqS-YWWKYIhLzYILY5RjZYB_GLPoBlUBYD8rFkpRvWASwy0Q>
    <xmx:zRzHaJr9m3bpGTJFDe11E_JvrDtBqEsXXJvoE5iP6C9DK5rk8ta2zpl1>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:51:39 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 4/8] t0014: test shadowing of aliases for a sample of builtins
Date: Sun, 14 Sep 2025 21:49:38 +0200
Message-ID: <a04c6ae968e6423d59558671036f21e95b97bd8c.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit added tests for shadowing deprecated builtins.
Let’s make the test suite more complete by exercising a sample of
the builtins and in turn test the documentation for git-config(1):

    To avoid confusion and troubles with script usage, aliases that hide
    existing Git commands are ignored except for deprecated commands.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3 (new):
    
    Only a sample of builtins since the test file takes about 600ms longer
    if I test all of them.

 t/t0014-alias.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2f71c3265f0..1ac739a2737 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -96,4 +96,21 @@ test_expect_success 'can alias-shadow via two deprecated builtins' '
 	test_cmp expect actual
 '
 
+cannot_alias_regular_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail... (see above)
+	test_might_fail git "$cmd" -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'cannot alias-shadow a sample of regular builtins' '
+	for cmd in grep check-ref-format interpret-trailers \
+		checkout-index fast-import diagnose rev-list prune
+	do
+		cannot_alias_regular_builtin "$cmd" || return 1
+	done
+'
+
 test_done
-- 
2.51.0.16.gcd94ab5bf81

