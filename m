Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E828EAC7
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905859; cv=none; b=TgHZ6jXPyoBcsXPt77/GcgPs9Ha/3qjsbghSPOop0aD1lMrGzU9JyORrtxfzOuckpb/EbVimf2YsPJa6vFKzWZ5CoMA6n/iR3S/P90kx8sN3ZhI++2JgJF34V3Q+kr36XTo28cGsXWOITtjvupSDGq3wFitD+8PPi4zRzNxcgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905859; c=relaxed/simple;
	bh=MBQQhsOGM6PmEjz/xhN0XJfywWwOHczApDJMAYQI/V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf1ryNDDoi3vcpDWFhmc4fI2h76i4KF7daahLDo13klFz1nYnahHVj/29q+5my/GZ88oBKVUmnMvLhLnBK/sCxcVrXSJ74+wlbIfCq9TOZHxsfXgR/YZsF0D9XfOjFboUUbXFxiPT9E92FLZ4i6leaBVav6vT/MVeOhF9jFd7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ANBBH/BI; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ANBBH/BI"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771905849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlR3F6vC5Ptnc/znrGCRkFoz+O8fbybx8a46qMwFNJc=;
	b=ANBBH/BIotbf09x3/MjTYEVMv8Huo9ut9Hdd9ItrIOJl4sCmQxMEcWtKU4kUyXIKabhVYz
	7Cnc6EW15vcDSr7G27OUbkE1/fpDpSNSFXMPU4/2QfRf2Fg+kD5HC0sjgC180NSa2g/T6/
	RkbyZuk4j26jgppYjtMCvUl06Zt5HhjVFvE2mwtPM6bO1az/XSPXcTnw4RwQSAN7/QDCwp
	oM5ZVKU+XMlEZSunSjFnGMbX4ItZxfEV+ufSEj/CxGQ04rn88LCqsC101QApfRzJX/U1RC
	noTSKO3WAO0CcCnJVDscaqm8LiyNgvqLdmHC+IMu1YahObRXtP6w2fqPBs/08A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] format-patch: add cover-letter-format option
Date: Tue, 24 Feb 2026 05:03:55 +0100
Message-ID: <20260224040400.751247-1-mroik@delayed.space>
In-Reply-To: <20260220230633.132213-1-mroik@delayed.space>
References: <20260220230633.132213-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=mroik@delayed.space; h=from:subject; bh=MBQQhsOGM6PmEjz/xhN0XJfywWwOHczApDJMAYQI/V0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnSMb+vHtgurQ+RtjcmEyvRW2BhrOSfqAwGBu8 zWs3jSd0j+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ0jGwAKCRBIeX6hnBm+ 0R4OEACU1k1UR5xpcG8ageiTUTiTZLG+rIwaY7vESO6qj0MKTpo2t/bATub0lwcXUNVGzkZ5xln zJZsYAtqkPDZHJhrrrsy8TfZYDFM2+ocZzOjNxuNKNB9004NLzez/A9eKPVXFigumfl824bwO9n b3oFy+qVxIfm3wII0qB9Ei/MtlZ8bQc8Gj18rCkdhuokDMCtLBIxdzJ3SdF86eBGLTUJcyFtswp rHnKtOAdbuJI3V71m+03NC7IcGFS17nEF+b0qrCl7BTYe53+AoQhMunWRW1WSboF/jRXhqcmR92 vkEP5lqUKNc1asXZfGuzYneA+18uGZWTtDwVR0G/pLsW0B6QSY8G+ih4e0OqUF/A8pFTBkizKyB C0tfkzyoYzpPfuoNHVRStcT8lhyPkVDJYPLKklCSWMlohRZuTphQYosnTLYaASA7dPb2Pq4D1Sv 2zYFTOG2QK2t6DFe9daFxBKIHpRsgMyJ0OQFqt2Y4vRyIktN86BSZmXJ4B/HZmCM+8cMtWozMYY mrdxTkiRzqT30WAx19mY0ZT+2uhBvAgb8VlC09c+PMPmovoK2VHeCWueJuY8/1Q+3rA3zid+007 iI7RnWOVAwBBT1bYVuiXOpaavUoTllzNtmY6ItM8lhaqeC12/R9RON50IA1jpuwUIfpIsMh3ATP t+QFRf6kTl1vqHw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

I've implemented the "--cover-letter-format" as we discussed. In the end
I've decided to add a new option instead of changing "--cover-letter".
This better reflects how the config file is structured too since we can
have "commitListFormat" set while also having "coverLetter" to false.

While working on this patch series I also encountered a NULL dereference
bug in commit_format_is_empty(). Since I needed it for this patch series
I went ahead and fixed it.

[1/3] pretty.c: fix null pointer dereference (Mirko Faina)
[2/3] format-patch: add ability to use alt cover format (Mirko Faina)
[3/3] format-patch: add commitListFormat config (Mirko Faina)

 builtin/log.c | 90 ++++++++++++++++++++++++++++++++++++++++++---------
 pretty.c      |  2 +-
 2 files changed, 75 insertions(+), 17 deletions(-)

-- 
2.53.0.4.geaa3cc5f7e

