Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F972C0274
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465200; cv=none; b=ZA/v9T55Q9mCU+cDU8vCwN2Qui/MTdKIoaffIqrdq9DhxlAxQ/CZq/+jOmYqj1CEcP9JbV43EoBvZKgbnfHe4Ta6mWX8fK2oV+cmsMHeETVsf1taLdrExVwbk9xLvUfHFa0hiH9ZHoWfgTKsTzbg7m5TC4x3F0MuOa04hFaH2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465200; c=relaxed/simple;
	bh=8ZT3wblf1CYPEuF5RFxRUx4kiWgCOGAzmoE9w236NSA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=PYRGtUbKEiSKSIVAo23v5ylsQUEpcYifTMFuRQ/dLD2YjA+e4XeADwOv7geeYNFFQVNgcPuScc/KJTVS7RrB6PWp88He3T3XrkzB1FMU6JKmu1KOmjv4sz4oFtUZbMPx5Y8jfWqglx9EQsH+ZLyBG98EYr5ZSqUupHOkL5fAj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TQMGpGyL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJPG4BY3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TQMGpGyL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJPG4BY3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E6AC61D0010B;
	Wed,  3 Jun 2026 01:39:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 01:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780465197;
	 x=1780551597; bh=6to0C1PHy0UeV6rduRjSIcm8XrpFmU6dLKStAgBjlGU=; b=
	TQMGpGyL/S5Own+jJxUDql0tbwxfuxaN5AF/aRH8TL3FW/LbFrd8rfMLJXZ8rl2u
	yW0mHxe59PbbYU32rgNt4VB2PHHCT8c/4sKWAklkh51dnUoNcpsWgxRePjbIKePN
	nCQqgHNY3GEbSzHKQkk6vLvxyJosmioW/mPAIFfo6I9GuGwU6lqj8ZtV82gyPPh4
	4ZKtdF22prxNoVusxoJ3FKQ+LxfZ4JaW9xnvhbUytIrDpwOYS972nR6PzPYf80BN
	X44z6mK1VLmBbF42JeVmLOtliTRBf6l4jrJYwX6MzbxDv9NPWiM4iRHSqHKoCYjz
	zPfurXPm91uTcwl9ADyYAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780465197; x=
	1780551597; bh=6to0C1PHy0UeV6rduRjSIcm8XrpFmU6dLKStAgBjlGU=; b=M
	JPG4BY3GXiRaf8MNf8/cIF/9wObH+OhKN47pXSWW0g4JDKrKK4cSgZRJ8qFa1/Cj
	RUM/bL4l7aKs0WP8kaAZPPFH7B3bgUUwToCaeBlB6LHosKxQMMmh5jC66z0IxYsV
	Ear3hmqhWZmMiIpwxM58qMDPJv+oHZsZVSIiIKzQs1oHE3ilLk19u1qa2MOZCiP7
	iua82tQwBw0/XR5xkya0LYLdWR/iiacCQB9W3oNeJh6DuNPUWFFuDDqOBwmm9+0Q
	Wrl8z+wJqy2NCaf+IF5j1WdXljFCzeJ3/EdaY5YYln3GMoxlvCbE1vup1KaZ7TG7
	TK4mjMzFZULLAQ4GOdJEA==
X-ME-Sender: <xms:Lb4faoKTX68b6RzmKV0a8ebz0qLWjn068MMz8Pvucq73SBVhpZxp9A>
    <xme:Lb4fauI5pBpvgCzwrLMFvON-mHqvHSg2E4ATDzrGEmTpi5REleq22crVPi4qJKeF5
    dMiYGgUevmZZgjqBmr2erFCeDfYcTK7gBj28at7JHfA0d9swE8eiQ>
X-ME-Received: <xmr:Lb4famWnjnDjAntmfhrh5S7g5ZVZVgYMIv9fwyV-NU3TTQc6ajCReJtNmXptoOWomulJU_m3w0G6pJgef5BaG2U_eF3YPknRf5L0BogDKAWG>
X-ME-Proxy-Cause: dmFkZTEACh2P50draBxBO2i7WpT6844k7Ukw2ys0h+fJh/YCrSoDfoDyL61kq9yShgBIRm
    QHljtoLMClQCjMtuaJpVXIXx28eCsUFYnr74b09PVBYdcWtHCMLCgJtT62GM83+umOMWAm
    tQlHgMBuO6d4JmVlSxpWU3yJ0XsKkTEmxe/cz/kth+F5+Apbfgo4HFLfT1vpRJcAkoFzoC
    cHA7JRKk39UCZZ2EInF9uikZKtG44bNcG8UQ3OnW63tYMFoJDTRuTn4lD4dlocLuBHaQyG
    wvuIhVNc85I2mTn5Mx/saB3JMMy42NGyuDWuYSL9s16c0zcKnoIYktZwwRnHR1TlZv61qP
    S9AG55x7i+fSWlW8V4cKel8DNV9lnUbWgXOLwjyP9Fr427Ql470lFWY0uNEQsbaG09wuqT
    yldzJEUeYkbupIon8QhZMP3AGGr+U5zPeXhY9dFPw/RD4gF10f4muo0AoiskhVRkzxilEe
    j5Fe1YhoWA/Y7W/dzHadCi93HpCPKDq7PetOSC8LJVSwUr1NJglYlR2nzDNT7O8B2JGmcE
    6HaHpMpmLwkZUE3UDp6WJmCNZEwSn9kF+qP0zlDxBmboKjpTnvF3sRO08v/AjeW5vafGV8
    pBveD5/iOmbPXxapoGiFY/DfjJ4fwHj7Cb1zEGGsx0RrsC5wid4tjUp76orA
X-ME-Proxy: <xmx:Lb4faghNGCbqHm6OML_YEjb7G-sUyskDFT978-BnLyosjB1xHILmQg>
    <xmx:Lb4fah96tOpzgBXDhr1TLGzvc7Vk-v3UOcZEEUAEh90lh7kDMAmrBg>
    <xmx:Lb4faqDEuyhZ5Ga2Igwk7Ju0-eDrzRLaAtFxKDHrJvHzzgrUnhtpng>
    <xmx:Lb4fauIqr-mJgSOyY8kh_aY8F-rxHyea-6klspElKyU3MB-D7sqn8A>
    <xmx:Lb4fariKXqAuI9c-pIttmPzIdRK8d8Xj1kd2GBXBbT7PzNmWPuiD0NbF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 01:39:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7a4ee8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 05:39:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] t: fix broken TAP output
Date: Wed, 03 Jun 2026 07:39:43 +0200
Message-Id: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB++H2oC/3WNyw6CMBBFf4XM2jGdEmjiyv8wLAotMhqh6YNgC
 P9uwbh0eZJz71khWM82wKVYwduZA09jBnkqoBv0eLfIJjNIIWtRC0L3DBhVJRX2vGDUDqcUXYp
 IojKajCpNLyDPnbfZOK5vzZdDah+2i/vfbgwc4uTfR3um3ftl5P/MTCjQtKXRUlNLpbpm9cwva
 LZt+wDAHfM6zwAAAA==
X-Change-ID: 20260601-pks-t7527-fix-tap-output-105da1d73df0
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes another instance of broken TAP output that
has landed via 4d11b9c218 (Merge branch 'pt/fsmonitor-linux', 2026-05-31).

As this has happened multiple times by now I decided to have a look at
whether we can fix this class of issues a bit more holistically. So this
series also contains a change that makes prove bail out when it sees
invalid TAP output, which uncovers a small set of preexisting issues in
our test suite.

Changes in v2:
  - Fix waiting for p4d, and deduplicate the logic that does this.
  - Link to v1: https://patch.msgid.link/20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      t7527: fix broken TAP output
      t/test-lib: silence EBUSY errors on Windows during test cleanup
      t/lib-git-p4: silence output when killing p4d and its watchdog
      t: let prove fail when parsing invalid TAP output

 t/lib-git-p4.sh              |  4 ++--
 t/t7527-builtin-fsmonitor.sh |  7 ++++---
 t/test-lib.sh                | 10 ++++++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

Range-diff versus v1:

1:  09977059d1 = 1:  18b4fc7b81 t7527: fix broken TAP output
2:  162d3d42d8 = 2:  8dd921534b t/test-lib: silence EBUSY errors on Windows during test cleanup
3:  4ecb8cb1ce < -:  ---------- t/lib-git-p4: silence output when killing p4d and its watchdog
-:  ---------- > 3:  8b343176fe t/lib-git-p4: silence output when killing p4d and its watchdog
4:  95fb0d07ae = 4:  e69aa0ab79 t: let prove fail when parsing invalid TAP output

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-pks-t7527-fix-tap-output-105da1d73df0

