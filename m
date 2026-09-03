Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930846AEF4
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426322; cv=none; b=tfk7LVZz/+cj3J2X23rOl58yjENv+bo63c99w+gHVEjFv6Ga/Lkivz3tH7yjRZWUuYjaDXihpjRNc3OVah1cjB3CpxfWR+ZR+u8QLjttkCpL6l5bD91mgK7Sbpu5g99migh9m0YXIeKOxzZRnod6gCYUSAVP/c0LWigC3iLmLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426322; c=relaxed/simple;
	bh=ReNQRO8WCCoywch2901JslmmV//D9BxPXCxOP1iR428=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d6Q27thnHbH0pDR17qLtAuvFM8mjpevdqO/zvWQKZITRkWmC4BRVEWZM+OXKyeUb7qXvduYkjoamX8dWuwFWB7yE5QyGhuoFk6hPfR8TqbSQTS7X6D6C350ETVFal/4uLcEpz7dQIeRsV4pCYUFgjXxBZOCK7WnUE6tjbQlUvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JmVzy5Qs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9P1Ww7f; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JmVzy5Qs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9P1Ww7f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ACC8A1D00170;
	Thu,  3 Sep 2026 05:05:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Sep 2026 05:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1788426318; x=1788512718; bh=CrNVzHTNVT
	2L5a2EgxvszdHuJi6u45EZ4BJrebvt63o=; b=JmVzy5Qs8u9ymc9SuMnEniZEEw
	Vo0px2RK1m6dflYQpNylZEoSZuUFTwDdSLOSiFh1icJjZJRxwoOh6d8tuHh+2Tvv
	rcUpoYBNt+UaHOdirRie6EJrJ2gMmpkzAMAe2MYzydJnRrUlGEkiH080ljPOvUiZ
	uY7GyUpVN2BHBkhek5OidwOPEvDNJb938sGQDyzFeXKWo2fKF4yq25/gpswdUlJU
	Qek/ksdu6gkqEhbykotGUfCfL1rf2/tFHRW1iKZfrT3XSretBpW8PT8Ll5xDV5LF
	TyU7sgelOTtdMYMQF1KuHiC4e4uNehCl9Qf1VjLHYFvA2ffemzUgndUQTzuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788426318; x=1788512718; bh=CrNVzHTNVT2L5a2EgxvszdHuJi6u
	45EZ4BJrebvt63o=; b=e9P1Ww7fp33UMI/+tIFRpf7kRmztWpec6Gyrw9Dma4/3
	gJ6AQ1MDOXMMWcHMGW1RJ2UHY/6Sw3h+EwGdgMrdUOPq5yqpxF0CXBAE15gOgol/
	IZ+3tzr2thTfQcydIjHxC7s1I+StDMxhoUaARL5zoZrwucSI19eVRfnTKQMf3eN/
	ZOwBHEAzoLDc04z1YG/RmqTGF+hnRQga24weJI4ZZk3jAaN1HMzirjB+5z2w8mwR
	TdDA3UoaEyShhvVS/TNMioEWA9EtTmE2quzyUN4/lLnOorBJ8A5reyyA3+vD1Ncu
	fGGZeNEQ8nabOdIAHk2Hh1fL2eHcG5fwY6jQx+JCkw==
X-ME-Sender: <xms:TTiZanqsso31Rxx-8hwwSgBnQvCUsIFW9_ag8E99qUvxdYv6mNPUkQ>
    <xme:TTiZapaPS5G0X7O-taieFAzHLnG8z6h-zXz-b9Elfyw8GHzwGgTuYHu7uTWzo8aJz
    lgmgBKItwJ8hWi_hP0KbUMVk79rFvwKvfctPbaIDLM1NY6ghgodx8U>
X-ME-Received: <xmr:TTiZanRi1pw8A6_Q3vhNH1BslgACxA_Y0JbkeCvNAt3_8qi9Hx4Nug>
X-ME-Proxy-Cause: dmFkZTE5dOmQ0fIY6/afhqIm3UTcQpGSfdgeLfHsDuFG+shCyGav+wnG2nWL1oaEjEl3q3
    knjM/Nl4CQpIX1HkHR2LouJTLsVRnivajcuxBEVMi9021W82LwZP/UXBsnDvoPHoSmlZ0d
    FoiS9o8yP0vZjlKZXGJ76dWRfLG77TJ4U/1UXuYJpJ7X3aS7xbRcsnfOW9qC/Sj2G9wNOL
    IW5M8gJBfsS+2UyCSFDFrr/Z985l8zBRjrCaPHy6cg7xJtJh2BBIkHsRJpfaZPXqemHdjc
    8xocR0zhcGnlmYOuQx9LxFbO4vSqdqtx7Wi3/LAHG6HrRaTbcxorW1o5njElG0Gh6USIPi
    H83Yp1ni0fCu4jdljkLbzciZf5fsWe/bX+BOWDbm2z+gvp89Nc9/SKR4buBUwchi9HUX9+
    ADgpzZxKAhhiHTcldI75Y209aNMvJHZzmbOgs0xYNsTaDcCltFCL2y9J3vPYMNrS1PQk9C
    CXUWaL0O9676u1aFTWPIEtV07Uwpn1GxqTs9GbwSvdlfQBNEYoOTWwXU1O83hW3TargldR
    kkIMuwL8IQNd7Xo24YIptHBNhBpHXeCSy95hADfFd/Ve7Lcgj1jDkmCR82l2pHw73POTFa
    /TRUtXCUyCUsrWMd7RmT9ER8vE2UJU0Z3rm+09Oj5oxYNXihEM4o1GI2vjOw
X-ME-Proxy: <xmx:TTiZao6kPclhvdqTcjU1nxGNJmBzA6SZE0cvHXEN4NQUPLbVYFWQlQ>
    <xmx:TTiZakyu0VU3i24KshwWwke6K5_hq3z258sC_dvPlpOrjUWzbNyTSg>
    <xmx:TTiZavQ-HubJpbrZCsybaGtMiKubYfq8XNUOQ0_4N86j9nC4dCfE0A>
    <xmx:TTiZarUTSjY7qCWR5eGwerHV8_ZzXkYUrQQCmRb5g5vQiPvaL1c-_A>
    <xmx:TjiZav-lSoYv40ZEwdPbBbYkBfwzD90WGM_L0ptJtQ7DNgGmV-Le6oCn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 05:05:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6690978f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 09:05:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/maintenance: improve heuristic for "rerere gc"
Date: Thu, 03 Sep 2026 11:04:56 +0200
Message-Id: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CQAyF4auQrm1SB8TgVYyLmVKhGkcyHQwJ4
 e4Omrf6Nv9bwSSpGFyqFZJ81PQdC46HCnj0cRDUvhgcuZY6qjE0OD0NX15jlugjCybZhwPjKHN
 Sy8p4butAvvMn6h2U2JTkrsvv6Hr72+bwEM57HbbtC5ph7G6KAAAA
X-Change-ID: 20260903-b4-pks-maintenance-rerere-gc-heuristic-763b0a9a50d2
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

Hi,

as reported and discussed in [1]. Thanks!

Patrick

[1]: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>

---
Patrick Steinhardt (2):
      rerere: extract logic to determine whether entries are stale
      builtin/maintenance: improve heuristic for "rerere gc"

 Documentation/config/maintenance.adoc |  8 ++--
 builtin/gc.c                          | 26 ++--------
 rerere.c                              | 89 +++++++++++++++++++++++++++++------
 rerere.h                              |  6 +++
 t/t7900-maintenance.sh                | 61 ++++++++++++++++++------
 5 files changed, 135 insertions(+), 55 deletions(-)


---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260903-b4-pks-maintenance-rerere-gc-heuristic-763b0a9a50d2

