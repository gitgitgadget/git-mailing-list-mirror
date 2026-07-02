Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8847F2D7
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993669; cv=none; b=cF+FefdFim/2eDDHgSROLSG4Y9PLXOlHpYFvzo8gATeLXwLfqX2yZhubRKdeJYwPqazUCvdywLPBzoEzOCc/KICYNayJ1csgnqmXJ5rjIvZCCpgI4RwR6TszP7GshBo+Tu1L9M4aBOv1A4zQI7TSQkk2aShocqiqSaaOQmqwK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993669; c=relaxed/simple;
	bh=vr03F32QDdwRisxFkWJ3cya1dQ0ZM17+K/Jqf1IIVtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr7C8L+wMvIFQ4HWOfMCsN5CTUDGJzTJjOIaqTKXAySkgefs2cn0pd5kITEFp85GJFST5DqV2teVCab8ChelrwMs4dqCTvK4Y7aF9eD+70121A0YreaZiWFyiFZShvO9cTuUJf06gfAXeGWakbdzypl7gJsJirh69EcYpbHYF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PCol4p/B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTwupxGz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PCol4p/B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTwupxGz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 45B281D0009D;
	Thu,  2 Jul 2026 08:01:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 08:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993667;
	 x=1783080067; bh=lvzsWpBxcsC0AIb7iPQR1BzLE7Mg/GaGRy7dALk2OZ8=; b=
	PCol4p/BoyYubsA5xvw/kWQzl3jscmK4WLSFOmQkL97yVcGGBm7bdin6bYkXGmr4
	K0Wnor6TpNZLfKBxOJJ1cVQxE9TEbdZYVj1r9Ykzx1PL9ih/7zWSLG3cRrNFOx2X
	Wrl/l2irDH/Bu+Jjst8ZeuaQpffs+IxtrizNkagUn7uS6CQEmCZRsQ/JMmkGt/Gh
	bXIWdwSyPibLcjUgZDR30QbN3vqcWmPLjWaUCLKBu0y9acVxP4oH3tu0caAqfnL1
	FcigW1c0ZipFrSlAgI0JiHvxeFIauBh7ZlU9eAM4sPb81mkVtqP3vyX7Hyja+uj7
	n+CJ3l54i7br6pr1qWZfVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993667; x=
	1783080067; bh=lvzsWpBxcsC0AIb7iPQR1BzLE7Mg/GaGRy7dALk2OZ8=; b=h
	TwupxGz2Rx5zqQ1EzpSO4fci6PYM2UaJCOhYGrmCPgc884tmMiYvSMOheSfhNhKO
	x3flEd7tVOpd9iN07UDYF0mLz6cdCYMb05F8bU1xpw3ZM8JiFwRnjM7TQkLSpXmv
	MAB4kbqkaIHpQPbpQVLxwii2cYgOqsfOU/0ybYZvOfVmaSx8fxB1JzzjtfcMpO8z
	FeUBZPG2nHjqC+lQG8W4Oyl9bXlg+2INEX09dVldIu1e145jMWfsqljMsbVc7jkf
	ZKze+VIa5yRqrmaRDLF5JU5ZXrYEAphqfAfIH2gVe2lXh82womeYfamRT68nsTH2
	ZWdXCT6yqMMdKyvHZpzBg==
X-ME-Sender: <xms:A1NGajQOntEcSWg8Qi5aSbS2wiArRQOqpgtZYdD4ZxV8OE7uQ2KpFw>
    <xme:A1NGasO70CL_BNRChlAVGrNLx24tqugPgG3wsQhTO4OhO0t66XGlXRK6onWJuYNCY
    y6dWnkVlrsf0X4mDM9Gth4HiN_rNtp0tFbidLuB3Dudfo-UhI8X0kQ>
X-ME-Received: <xmr:A1NGamMs08EhAvnREQYjGjRhYsAK5cc_9KfaoETVGe-H9ATAg_kMPzbUTa9Dq1Jd_yY_ZXX4WDaL6nf8kyea4rEo6SlxSqlvpmWaQv16CXCgKw>
X-ME-Proxy-Cause: dmFkZTE5dZcUqsmEkDF0FuHykhD4Ls0JvU1KPg5sc+dwzcVSqFd90xadlr4jFJZvh8sJff
    yUAUwvNWnhdVgIF+vpXiwLUs/gTq3quha/WMNWXsCh0dbNt3Z0GLi2fHsHKrYAa8jYezj/
    VFuRt+1xthzzgIc8zQt362YKvZOlLlrRWp3r/h1kjTqzQQV2BAx3WFsUmjlmuoKQfyjJ6x
    RFUfEYworX6mxfvf6x40FvJyKFAPh6ConQ/OOF5VBeUcMZ7QWe1+Bq7LKyIgMdNrxMoooV
    3tM9GSTXd3y+2ifPeO8P7PWqHofEqjQpQK4delFtDaaRAlt5u2Z9aA8mGuDFkDfz+FZNQ9
    BGgIEtbpta8q3VIx6PaDff72bJmyg02tf2U31h2Nhl1OJ+phqu8NQd+dKcgMYrHIHEm4wQ
    eqbhN6k9/yDVVTpCgwcOnaNOMIOm3cbTA0HZDOH6D9+M4pS6zx+ruUF/kf2WrypCNZl3LC
    2oBTV7HVz1yvwRx4E7qyFQ0PB8v4tPg9hQh67wp0/cn6aDtJPFZJXP5SHLwuBkoIrmRDOR
    ou52Gjru5bulD8RUa0ZAmYOSIpvmI0blESz+WmdfWuP1INenpmb65fPkB0iTZumVfOSU9a
    1sP/gMvpNPwOlnHHnEFoLjPVWGxzkqRyClVD4ntfuBmGSeAaqp3ucEOioIjg
X-ME-Proxy: <xmx:A1NGastb2e7uU9rO6031M9Ky7sCJ53AJQiVAJx4RJ9cj5inQB6l19A>
    <xmx:A1NGagXziQ7kfOdbloYvJaMnNfybfle3sR8tmy1HhYnvzPG7VzKLwg>
    <xmx:A1NGakt4QIo5ggFafZBRTZ5bZrWEGOnHEYw4d5ny5Idd41dPKVzjJg>
    <xmx:A1NGasWjfSYEyUPrc0681rae9VYBlyjehTyH5rMz2aLachcBt-VabQ>
    <xmx:A1NGaqzXukta1B_y6BhFON8amHhaVUqoruSs7o6kvBEFUtNKB8A581BE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca369961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:00:54 +0200
Subject: [PATCH 1/9] README: add GitLab CI badge to make it more
 discoverable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-1-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

The Git project uses CI systems from both GitHub and GitLab. While both
of these systems are extensively used in day-to-day work, we only have a
link to the GitHub Workflows in our README, which makes the GitLab CI
hard to discover.

Improve the situation by adding a second badge for GitLab CI to our
README.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 README.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index d87bca1b8c..46489b0971 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,5 @@
-[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![GitHub build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![GitLab build status](https://gitlab.com/git-scm/git/badges/master/pipeline.svg)](https://gitlab.com/git-scm/git/-/pipelines?ref=master)
 
 Git - fast, scalable, distributed revision control system
 =========================================================

-- 
2.55.0.795.g602f6c329a.dirty

