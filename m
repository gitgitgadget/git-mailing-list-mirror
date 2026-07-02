Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0647ECCE
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993668; cv=none; b=Rd6ZGVwUrlP9XFyQBU1pK7/QD1pdD+rHxVMbrdGyFvTYxIjg8W4qR6/q/WbYkPmNs63fOIDan0n7XH5bTA03kCP8ZTwsFiEb79qluARRN8ILJy/s7Kp3Plbt0a1JAWf02vuxonSdAnqnHrQgNQHf68hzmrY89G9dw364NjQL7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993668; c=relaxed/simple;
	bh=kkHsGdjwTQvUNCmrlzK0gv3qNx9fDxi5AZqiXFY54ck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AHeJW9lKDp1XXgyivDD1DwAWj8hsUu6AQD37i5NSmWgXKf2iM8e04BnUv5yPsx7SWFLWyWfJ2m4PMS11xOFlWpK/ykBeOZqQNoJ7a802PvDt9vx/yJL4ivPzDCYN7Fy+urEs7IHG3ykzQChRZSt+pPIbTwSKxEppPDG9BvKJC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IlIEdRdh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEupGzSN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IlIEdRdh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEupGzSN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F387D1D000B6;
	Thu,  2 Jul 2026 08:01:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 08:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1782993665; x=1783080065; bh=Yy2Nna54AB
	r4eQdrtWX99ReO5pNWCTCAO8vu2Am3pXw=; b=IlIEdRdh0ZuYXgftxvUVPx0qHg
	bItQM+83MuhaOzVPBvHPrN0sgv+YJLxhd+XIeSJ6/STkuzzJOkTCn8LRnGourlRp
	puinVXkvOG7EvGCGBnL0YQ24NZdG7mNmT+W8QpHO56wK9/36qSq8M+R/6Iz7y5yx
	QuqvFufeS6qMGRVWid6+PUSIIgCFd1B1al7zLtrah8NtAjcJtD2IlSYOkTpfAAQM
	erK2SaQA3P66jbdcxp7NYxqhYmE3eMynlTwxR+2H2w26WD2mc7wVvBODSxK9Kb3y
	CSEMEzUTNSEkD4WIei80FerCSimJ1tiswwRbfi3FJKDce1NhaRTgL4lXa65w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1782993665; x=1783080065; bh=Yy2Nna54ABr4eQdrtWX99ReO5pNW
	CTCAO8vu2Am3pXw=; b=JEupGzSNzpcFt3BxaA94AnLppUFAXcwoIAlNCgQirHQG
	3gZftpgDs/QqBquDBMEQ2HozyVeqvxGTD+Rd4LPm2/+5tP9bEX8PhtyhkEHRTS+r
	iCTb+72UYLF0b4dWXGRBFp3ZSYFgVyGMY006LVPUqlzYG+AS5NvP3EiVrCv6W6qf
	z3Oq6oT/SiLv5wz+Hx+jOCPwl+SkFnc6WFxVDNdKrL/NuUnAg2JAkFitVpkAuTrs
	axKRuVEz76ppdSglRXP80TR4bqhk9C6LVBHc3rfxzEaGm1JsZZllQGyPgJrnFQy8
	jS7QhOaYWFYTZxiHUDJNK2PhM8dCRizqpXZhRPDwoQ==
X-ME-Sender: <xms:AVNGaoOBbn8IaTJV71Nwa2xsz54_lnjP_Qk8S0vJirUkhrIivtEMNQ>
    <xme:AVNGambO_jpAGFlfn7n5-9ygK4CQxJnAmJqECFFQEXfDLOHyHxnnkBfHO7HTw8RkA
    DYIMar6Lw9jihTnDhwRf7Ty96lg8RpsUkPJgxGnxw6rGH5Z9JxG1g>
X-ME-Received: <xmr:AVNGasqNc_qNlwZyuyVHPnSMfsUOwuuo3Amy0B4OFKO7WZnzEeO-9G6PEcKBFU4vqY91TOXLDWF6q5j0TP1NSLOyTU9TcVzxzjqzrdkTu6jsiw>
X-ME-Proxy-Cause: dmFkZTFXin3t9TJasfqhwegVhKvM5Yrr++xZeGuPzJLmI5rbjdewNVJp9duBp4akG4apPo
    ZmKkPEIHXrGHT/YPliIbVGkou3+OXBm7dMlWblrll5m+BrZJAPBb30zjOyMgYLHGKysISC
    OdbFIU3s9fDUxQlCgppp0S8tKOkQkTcnileTkokp2r8XZO0m7xiZZ7JKpy/Sp68wT+R3kN
    t+gD3fP9zfBKX4Zeo21i3AGEcGJN8RynMdTToE8vo2qWW83bE+pKqQxY3o9mpaGtiKLWYr
    dl8G/dY04a8lOQl3C84otFRlMs/KEst45WdVvEgHzly/qFqzOUXBTpz5vQrgWvsJ0YbWIL
    4WHv2/O733OaMw2P65cy3qxcq8qWLwS+YpcCtKIW/DkrB2QqlKYlDw+fTGdECud6+4dXJW
    ZFR9YeLv238fuMHHF1skv4I5SPW/6sHyu4dX759YN+REzVI2aIKgS3iFUyWOmmeWNxyUF+
    lR/vTh63PfwkSsdECFuhyxJYjHObDil2t04jF9TaH/vosvZZr2xz+bG0Ra4iSv4xJ2Kxfa
    5w9JKbidpZrt2PA9ri4/tSr8s1DE7WTy+/O7a9nntXA22qpGmVp9oQK/K8JAF8WbaaNAam
    kcZHFlYSIVgyI6dCD+t9a7kj/tCgb+ySh04gl0n/l3+ovKuThYD89nLNuv+w
X-ME-Proxy: <xmx:AVNGaqZemT8UciP8bAG-a-kX2AUArl_JOcHytfGFefmSq-SRL577hw>
    <xmx:AVNGakTsv36PG9pTB0IRiDnCdysktTI9Wg6ekUY8WRINLNnMVYlMjw>
    <xmx:AVNGah4yPjeyowHxEdJ_RyeacWpaGKzI_dsA-X_6oAFOHajwk29_bA>
    <xmx:AVNGapxU_Qvxn56_8n_5GAElq4N82UOfTzyyN2sYkSBgOGRdaDSFeQ>
    <xmx:AVNGao9GMq7-MjSXRlF-GmqnRW5GkJvbwzs8jNzFmFY1pK1Pw3lVtfP_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72db007b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] t: fixes and improvements for GIT_TEST_LONG
Date: Thu, 02 Jul 2026 14:00:53 +0200
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZSRmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwND3SQT3YLsYt0S3bTMitRi3bT8Il13zxDdENfgEF0ffz93XXOLVFN
 ji6Q0g1QDMyWgMQVFqWClQFOiYyH84tKkrNTkEpC5SrW1AIF8wu6EAAAA
X-Change-ID: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Hi,

this series started out as a simple two-patch series that wired up the
GitLab CI badge in our README and GIT_TEST_LONG for GitLab CI. But as it
typically goes, tests broke on GitLab CI, which made me realize that
they are broken even on GitHub's master branch right now. Some tests are
failing in the linux32 job, and we only didn't notice because the whole
pipeline hangs.

So I had to go down the rabbit hole a bit, the result of which is this
patch series.

Thanks!

Patrick

[1]: <akIfsaVMB_S6kfJQ@pks.im>

---
Patrick Steinhardt (9):
      README: add GitLab CI badge to make it more discoverable
      t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
      t4141: fix inefficient use of dd(1)
      t5608: reduce maximum disk usage
      t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
      t7900: clean up large EXPENSIVE repository
      t: use `test_bool_env` to parse GIT_TEST_LONG
      gitlab-ci: disable RAM disk on macOS jobs
      gitlab-ci: enable "GIT_TEST_LONG"

 .gitlab-ci.yml             | 13 ++++-----
 README.md                  |  3 ++-
 ci/lib.sh                  | 12 +++++++--
 t/t0021-conversion.sh      |  2 +-
 t/t4141-apply-too-large.sh |  7 +++--
 t/t5608-clone-2gb.sh       | 66 ++++++++++++++++++++++++----------------------
 t/t7508-status.sh          |  2 +-
 t/t7900-maintenance.sh     | 56 +++++++++++++++++++++------------------
 t/test-lib.sh              |  4 +--
 9 files changed, 92 insertions(+), 73 deletions(-)


---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06

