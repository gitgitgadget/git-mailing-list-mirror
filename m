Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81486357D07
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641868; cv=none; b=CKDtt6IiUygVgU91gMP4XZu6L3vu2ZeNMsHglD6CoYfLsjqXaZyyFLNAkOrHgu1qrMDcHr8oNH9y6IdN7GEfXWMaTwSA5fdD7EPetA0pIqgA30mYo2yvZII5UZxAi1G/ERufOUuKD8yjOFIc35oMEOW96xFk35cffNtWViuUbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641868; c=relaxed/simple;
	bh=lsch0N6IUkpB7X8xRro2Nzx2ELdHKgJz0CRNM4GpBCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SFciEpHSoVCdRVqYpHoSQqKDyG69+CtGsQ2rGxWcyNQ/TSiPgFFRsKJmuSzIFHSE7GGVJUv/9xr1meUkP+3Q3A12Ivz6i6aqA4SY3//WAAM1KskmyXYpDaa8ja0EdV/FygvmDoLMcC9k2YhUYngboZpS3o28KxKct0LyiFPH0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QBeP8wkr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di7a/7LG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QBeP8wkr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di7a/7LG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54D2F14001C1;
	Thu, 13 Aug 2026 13:24:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 13 Aug 2026 13:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1786641865; x=1786728265; bh=mo
	+xuhgcF6Lk+07dkobOla2nBuYF3/hJhOrd/Ssg40U=; b=QBeP8wkrbYJR0VlAs7
	dft24lPjTl0F+RMLkzHTb6dPBOVN6zRSPWRx4V/PlVISCi7lc+EH4LQKeBwuwahz
	vLAgEUiJKGvm3fiW70e4pEkIeKcLENdkQQBEcti7RPjHl/uUWNCM1bvMCMpXYz0+
	R6UllJSRZ7reGUVnjEf3QU67IWlCXAGee9687ei6yCR/qbilbncdFrNdyZfKDB5u
	Yvm1JU6Lui6jEYJ6V1X60dq7SlP8TguPpW7qjkt97oeAnsgKI/JgI//vN8l9vhWE
	YpSMt2L9cbS+KdQb7Yv/9D64ABd/iV/SzyjoxxOQqd+28PmpRo6jiSlOpcUz7m+h
	8m2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786641865; x=1786728265; bh=mo+xuhgcF6Lk+07dkobOla2nBuYF
	3/hJhOrd/Ssg40U=; b=Di7a/7LG53VZ4OKWkX1Z0Ri7uESdnXFoAKC4vICi9YDT
	kFp4P+cAL95XILianHAD5b8sav/EKNJeVUwLtrtT2w3+yPrkAfzKgqrevOiYADJa
	kMvKlzPYVU1p1V9hb5y1txXcY11nofNjUKelSfZB1fuZHW6jyLwEbjwsQBGuc5UY
	uUtiuPHfB6Btm6959vWNO/pDnTBFZH94YnTLN87aIwT+vkyy2dcZJvJpjRI+qfJ/
	sN7CHKJ0JDabrODsE1x4mA9y/yGlnsnZ0gsztIbQoAALVDEp9E+OCHTeA1TU3Y9h
	dB2nG/a5D3Mqt0qHkZD1dbm8z8e+ulyah4V65DRE2w==
X-ME-Sender: <xms:yf19aj9FB424iAsPi8bG_OAtmtnGu7oRwf1VlzsgPDuG3-1l9EmjfzM>
    <xme:yf19alu19uROwlMFXsagjeIKK2ghHSvj4cEdQjN5PG-_kF9cOMXXfmKVcz989jyL5
    gGX_dAcIMZWDTpk3qCi-0UBxUJPFIwXCKkopw1kLKD6GMdl5tYyG-M>
X-ME-Received: <xmr:yf19aurvJ3KtXKLhyrvY5no5RQOVs9hRHpMTRXZUoiAKDhN_y5I8C7KwJpk31dJ7kWGZ0G93x80UiFSKf3RFB0awa74n0Pve41_3Nbh0DGvhNQ1EUtj4WDQ>
X-ME-Proxy-Cause: dmFkZTGWwSVUi8Zdn4gcsHtQnGbelE6N1leraCsJflF5cKROYRYrs7PDyeQLBeowCbmsRF
    AaM4z98Oi6/jHENO212932sJc33YaxOJNzwHGP6fOrQz5y2jcULYEiedlXIPMLh9egkGsP
    pFgCQsE7AEil8Cctm0NyRnt/OwoGQ/FjIKXCzrXAGPVaZd7xfBmSoJ/NfxWQ2s50wreEfT
    RYGqxTjyLyY0DJ6gn8bdzEXazmVQl942zAiAL8TGuaur+wSEiRP575dxBODZNauY1rO/oJ
    r4JISqXhEhbG64Er0/uPNRytAJb/bLVcDua+MycdmNkjGMUtZH7/wkuBaJJuyPl8G/7thV
    PV/oGrUUDLdwD2nsr02R1sI5fvFdKdwVYCsQvuVt4H7RaEz4rqE8FljPwdvu8MnjCwm+wC
    BbE3ogjIembXKWJLWsawnSRhTg/4828PBqav5aLkWWu+hmVbKmWWAVYyI+MClOPV4uG9Aw
    AE47YDlpFKVOr/p2CNwtr8ih8Sa1tJW4X3sjJECrnoLyf1E/zoCFbY6wzLxUHdQBloUZhQ
    wY8H/AcaYJSR8kRWKgVB9iX+14E5q39JH16QUGecwNDC/OX1/1JHUVeWJg7q/LrHyRQS6F
    rNRnbeFA+WofSyA0cPkWpd+iZvmGyYwsL1p0EtbSzF+aSktvJAZL4PjUhuaw
X-ME-Proxy: <xmx:yf19aqmrH7xA0AfzbTSi1-WLfx6mOiBqGMLa8QQkvFry8LuxxiphXA>
    <xmx:yf19aqxqSEXa0-b0wt7TsFyh-RcSpQaqhV7J88jKewqTrmhbGtRblw>
    <xmx:yf19aqne06tfUUUd18weUGtpBnJO1feHoJmB7Rjbi6c6Dd8V_mK_Eg>
    <xmx:yf19ardWojBDUJEwr_4lJLMtcaXAbwAS1gCnKSwb-UGe68Z3SqQO6w>
    <xmx:yf19avXeuhkjR_Y_Quo7mpl7-7duUFBzc616vM-J_BMPdviSzn9fSRLp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:24:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/4] format-rev: add --abbrev, --color, and --date
Date: Thu, 13 Aug 2026 19:23:56 +0200
Message-ID: <CV_format-rev_three_more_opts.b80@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/format-rev-more-options

Topic summary: Add three more options for controlling the formatting. Also
do some minor refactoring and text fixes as preparatory steps.

[1/4] format-rev: use lower case for opts description
[2/4] format-rev: factor option variables into a struct
[3/4] doc: rev-list-options.adoc: factor out --date alts
[4/4] format-rev: learn --abbrev, --color, and --date

 Documentation/git-format-rev.adoc             | 44 +++++++++-
 .../rev-list-option-date-alternatives.adoc    | 55 ++++++++++++
 Documentation/rev-list-options.adoc           | 56 +-----------
 builtin/name-rev.c                            | 88 ++++++++++++-------
 t/t6120-describe.sh                           | 44 ++++++++++
 5 files changed, 195 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/rev-list-option-date-alternatives.adoc


base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
2.54.0.22.g9e26862b904

