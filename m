Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4C3F1AA0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411388; cv=none; b=Bgg+Gc2mW2NBrW3UfLVXIIMTQfHvRCyr/8HMdkLyaJ+LJ3koIyKw6bHoc0MfCFSS3r+mWSJujNsNYnxyfs+ePbRLt9i6HHd5iNP+Le8J4FvAQXfQNqboO/h/ZSzCFkFTFUMxDinEKBgnhbVAB0uBw3TXiXLjzoROYbdwcJMv8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411388; c=relaxed/simple;
	bh=2/dcnbqGJPlXsFAAu3fUGGXJAQm3LEdFco2O3h+Ne5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrmOb+1P4G44hhILgAYZFI1loY2Fk6np/UCVCg+VTeo7oXfZbJpf2OGHMPYu8A6RjVinUjby4nqCzykqiyhkx0LccBgKn+gDMyQy8+SvZQ3e+yHQ2TZoDh1JnZIG9Bd2616xKEcYuzu6k3Vv9R7JS92AHDFMva8hom0uHwdMl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OZksNmYG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnCvQ2jy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OZksNmYG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnCvQ2jy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CAB57A0183;
	Tue,  2 Jun 2026 10:43:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 10:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780411386; x=
	1780497786; bh=1d6/0c9xwy7BlYpxmUyuXqTdL9PiJch2vSqc8eQHjTw=; b=O
	ZksNmYG1J7bBLAIiNn+pUlRL0uPz7dpNTNQedxAZe6L+cZVKbh7L5t75N995pK8K
	8S9KVtlXiineyrLDvHN3db9yUlIXlDCoOPQjsxrciVheOsFtZWKtD7+/L8lM+3IU
	EFCex3cANWiQRaY4WKOk+TVttm5O3Oz1LE0oBvoKeq24vpGwUHYcVIqBICIehBMU
	ek4zdBnAJehCKuxJcWBTVbqf/4PoDumnks/mGF2g+c3VoLri8mTH093VT92ya1mx
	YTA1bwkl1NtQ3bzrpuhw2JhGzfN93MzZdn4ft1IUXzX/XazJi6TAKhg98JkULoaO
	gNo4AqgC0fQQhCXvOuEqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780411386; x=1780497786; bh=1d6/0c9xwy7BlYpxmUyuXqTdL9Pi
	Jch2vSqc8eQHjTw=; b=YnCvQ2jyJ8ygXYppLMzE4woV/1GG3/2tnt64PNsKK3PM
	5YNZO8q1eECgneS0/mS3SUQQbTP0HKyKAHjtzZXXZjYitqd0IhUNwwdZloUwrH08
	E/a3PcqmehpcBzOhfV1kBQKHGEAuIKvGgTIZi3pRrxBCosyR/KcNIFzue3P3f1d+
	ctPZe8HwPFZp1G5j6X+rto6zd78NL89FWtHgIloP5/c42rWWZN7Q4Ks9ZItFT+Hl
	57cO4MqfZYrKMaEboVpklG8IClQUsq3EtgDnGTm92Q8K4YJqwd2uWgqUEKrC7b0K
	W7APquZIWHZqnkhL3I6HfemiMsR08RLBDba0ecgWYg==
X-ME-Sender: <xms:-usealSuFIeGvSZIWbD203-hkrjYVTyqCMtKg0owVORB51OTQ5gWDg>
    <xme:-useakxRcX4nxCn2noSrNJR55aUQmKDyLoDZAnre9YnxeRMT0EjVVj4JDY_YNVQIv
    _7zPpblGUu8JFponkRtNog33vWdWmFGcBZpm6Hx6uk--9EZM-R0Yw>
X-ME-Received: <xmr:-useaofborOhULio7kbxncrXd1x2ztuJrKKtZkkR-1Wp4ndNExy1AqO2i2nD8qPcWODfZncjlJKyHa1tJPGetWY8hoSqhiPRgKgP>
X-ME-Proxy-Cause: dmFkZTFEOtWtXvjSicVy0bkeqWQgm0qDJoNebj2mC5YDgPADcJJEmArcpYRaDf4Mmj5VE+
    HEXXh7yQcNUk2b+hsqWS/zatEVyOGu/LjDxqQ2wFsYSAxC0e93ove+PdVz654coY9e+KKs
    ZJCCf7hNERo7BUNV2iylo1j4jZiUuCOU8o9BuW7V0KigQjZmcK35YBT2oGGqJhKFTVyIkD
    ljrLFrzV12KJwc9tca5SI48rjHrNpQnIcwSOEEQCpzqgYPiwkhptzfEfV7E74j9p537xPi
    DEyoPxzuWHdcO0TaNgqBPSDWjDHQRO/leIKT80v50Jbp+M3Sx2N5KE/MDaj5b5XCzJLQCB
    XYc1AVgaXsyiaqIofZFTj9EBwpbt8iqJ+nOOzN95ixBWAq6FttBzN3s3kYqT4cqgpiP3LM
    FFHzMYVqazVu/fL0ppC1QiicvmhdbIcNSIDRHmFkb4DK51zRPnplomHkhNl+7y7817V4St
    YNL3Bx/taE4oieZoWrkD8kmgvpNtupbGJgJLDkqPb0ziwI98wfHKKLz99gzjzKCO/xxlFm
    SuUdRYHya6yXORJ5ZEKT1vBI+ndptfoFpXSUuMMpzIKECVcSaEoH2p0bxC/1oHXl7rPXIu
    d7z9t4WgjoKXcNJ7mjWuDbkgBMmOlzZVTZLu1ZGAWT/eNGnAHtQd2YoAnhlA
X-ME-Proxy: <xmx:-useaoIL4WewyQ0zWJinrb2FFKiy4YMyydZ5J3Tshdbm2NBUuMoQgQ>
    <xmx:-useahEwx6xpR8kOFm03tQ1O6RSjpw4Hyj3wQu8eC9-Li4dpl6ubpA>
    <xmx:-useaqqoQjH8Bg5Jp7fJA6DJuW4jW2jMg1Xvz4XIQp-BwRR2mg4tpA>
    <xmx:-useaiQ_N6G_FUA86l-7WNjNp5B4E0FjRL3lncXOJdca6wyYQBqA3A>
    <xmx:-useaop2IwFXCJb9JOax9mJA4QfbPLTNzyvFsFpE5GZRd84NHqYAKBFv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:43:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/2] Small updates to SubmittingPatches
Date: Tue,  2 Jun 2026 23:43:02 +0900
Message-ID: <20260602144304.3341000-1-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-591-g9032776dcc
In-Reply-To: <20260602090808.87837-1-gitster@pobox.com>
References: <20260602090808.87837-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently I gave some advice on how a cover letter should
try to sell the idea to widest possible audience, and then
I realized that we do not seem to teach how in our guides.

Here is a small series to do so.

In this round, a few typos have been corrected, and improvements are
made thanks to help from Christian, Stolee, and Patrick.

 1/2: SubmittingPatches: separate typofixes section
 2/2: SubmittingPatches: describe cover letter

 Documentation/SubmittingPatches | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.54.0-591-g9032776dcc

