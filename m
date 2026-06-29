Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4870345731
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718504; cv=none; b=MeN+hHxlBo6WPWSBk5AhlpKUJJ9S35K7OzNG8eWkksHMBS+mzIiPekLnRDovCLyUVxM3/xuAn7PWaH5qSaGiMcQEHXqHWtN7q6ZGXv/ZMGpWHpV3Q0sPDtUUFFM9S8HtSvcVg0INEKZe/kwrRz+RI7y0p95+PzC744JQxQOqOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718504; c=relaxed/simple;
	bh=j5y7pJ5hv0ZBdexNx+xR1jBKcHYwnRu/Q9/3WVgdbMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiSYGnHGMmXUVskIgi8KmFqwWHkkW0R/QYbFmT7RCElEBm3agwc9x63h4K/7iUGZZdc8fQ9nG95EQAeSwCBT7UFVWauxFDufKtBpd3nFhRwam0OAm3nr9jRJokG6YASTcbTXOK0oRTtABJtEOHSVef8L2kmnAQ427tQL5BQg3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r+AYONns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ed10Jcww; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r+AYONns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ed10Jcww"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E101D1D0008D;
	Mon, 29 Jun 2026 03:34:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 03:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718496;
	 x=1782804896; bh=fegKt+98qPNWp2UxFnaQfyTmdsd0tOWggCSy5a9k3Qw=; b=
	r+AYONns+3u9HqB+41mSh0iFe4CZi/AmiKF9ZcNE/zsQ3sD4bQPpYnrzsx23IJN+
	++YByoM4Ngk1qz9s1IHJzTQmjsKSpTFZGFzSQBrXZ2OjmJUP88pWlS8K0RfQSBBE
	aD8pdr05XispO7JOnGeB5TzgTfYSZ3W+GMTVAcLqr+xKlXEMxWVTEwVaxJACOTJQ
	VrwTJxQmeNpuaRQqdGqsW9DgRsCnf6cf6cmxQVZHT1nLxnfF77mVtsy6t8R9/m5z
	5ss72BNixIty9+PhifGeYx2lna7c8d3RyEfl1XEjwU+q4dGrYzP8tyQiB+dkU4dG
	tfCi2WObG6XOQDyAlixO5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718496; x=
	1782804896; bh=fegKt+98qPNWp2UxFnaQfyTmdsd0tOWggCSy5a9k3Qw=; b=E
	d10JcwwmxJQU5Gk/NE5+QbmVB/FhCH7SKqUABaV2AySODAG0B2tY2UksCj65kEgg
	0cWhI9wWCcKJ3QN1P3UhechLiVh7eeZeOVUCrK/LGT38/Pu69jaD5KXFfqiG3A2B
	qHSO0O/CLsqVOoq3ox6/GFgyUQL4DZA4AhhAxa4J4xQUDNOg5opQuN+VQVPbws8h
	jq2tfhqWt1P8sHEP8iPufFEaZtBrFyskODWr2Wz2i9o4OefJZxx+Bnp6siW451xx
	FutlAEgT5pL+s9d2B3o5/9/MgjvrC4nSAJnzNraEcaNI+kLDzVebeIGTVwAH97y3
	ej08ExpbjKssE5MO5sjtw==
X-ME-Sender: <xms:ICBCait4Pj8OCnXAs4nIG4_wDzidGiznhGRGNAlSJbEc448ayoYbnQ>
    <xme:ICBCagw8IQPJug8jFVm5FY7UmiiIf7ZXm6j3kHf3qa08m9c-2SdHzFHJUJuhd0tIE
    nlMzdu4gScIKoTsYUjxUZjBUEe1tLCwoHY8FHlPxtbXMvuTzsj_Hg>
X-ME-Received: <xmr:ICBCalAon1qKnMPlZ7PSr-Rsumgueg1SQ4Gizgb2KKEbdhdYzXdSq0QidiEyZI8tCvDfQb4pu3XiYbF5sHKyUixS8HRMdhT6Lc8kQgIO3wju>
X-ME-Proxy-Cause: dmFkZTFtwW+jrswXR2sqyckO9gfZ6S1zTRV9x1AzwWISv4S5GQeYD39MCLhCSYQ9JC/y1c
    npLVZAirVrNTDUG1FfT8zRyjFPxjOq0YkCBphiDhd6Zl2+0Va0Ji8672uuvoNsAlkGjsby
    /fpKLxAigNdSSgUGAMPe7yYIrMRwQgGv7NtTZwjz2PJ6yYgwdXm3wmBGV/T77ZZzeNQp0Y
    xjkn2eSgvSZkg2YACzeL7DjzkuCOn39jFCLMTy7TykXuW8I/lMeMnQFpj0UOayI8eLXeRj
    qqFffAyn+OnBbxqYZqQ7RhQj+Dm6PQXec2R+tuZcr19NHYptTidYIpqKU88o0gD9KRksn/
    EXgA0DYg/Ht7GgLHFgUcPikxvhoCTLmtLGFT4uOaYOuXbbIDbRyqzJrvoBNlD4oVSanXRo
    Sjrdj3pPJG6Ovo4YNCwF+aq1DZeG3Rm3I+nefm0nmKJGZI6nE9aY0xGe7OWKJm3IvYzzOl
    afyZnxqyFN0+u2LxiUhOSBT6xDaADtYxNqsIzQfgx/oiDmqslvtZOR9g5RgdPH+5KgeBSW
    CS9i5Km+nEJQMAE0uGBDEKpdqfE2gvyoBuTSw0p0mX70mqxKpqqjLQHMveHjUh80mPd7rG
    DJUjG4bs9VP6WoLMJieqoSCItojDRaK6c6pekNCRsf20FaRSCe+oylzYRRzQ
X-ME-Proxy: <xmx:ICBCauco7KzYSlmoLSp091vOPsWAySlaaDVRQw99EHPzTpLJwL3OWA>
    <xmx:ICBCavlqSeIfbh6R91y4vcvPe8v0c9dwy5oNAdsjjRRE772Ixy47Gg>
    <xmx:ICBCalFGuNm-AyO7AKHnHHo-qQAunVAHEXrXnQt-YW1yxPaRmq9bCw>
    <xmx:ICBCan6Skj4x3aBRKsbrC7BRic4Ah6at2Ky_ZTfA7e24QJGRpmX3ig>
    <xmx:ICBCasJKL0KOyoQa5ewQcivheeWc17127O9veJCzuafp7dWoN6fT3Hjk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 899c120a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:35 +0200
Subject: [PATCH v7 09/11] replay: expose `replay_result_queue_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-9-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Expose `replay_result_queue_update()`, which is used to append another
reference update to the replay result. This function will be used in a
subsequent commit.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 8 ++++----
 replay.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/replay.c b/replay.c
index 4ef8abb607..7c8433107b 100644
--- a/replay.c
+++ b/replay.c
@@ -351,10 +351,10 @@ void replay_result_release(struct replay_result *result)
 	free(result->updates);
 }
 
-static void replay_result_queue_update(struct replay_result *result,
-				       const char *refname,
-				       const struct object_id *old_oid,
-				       const struct object_id *new_oid)
+void replay_result_queue_update(struct replay_result *result,
+				const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid)
 {
 	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
 	result->updates[result->updates_nr].refname = xstrdup(refname);
diff --git a/replay.h b/replay.h
index 1851a07705..da83b65345 100644
--- a/replay.h
+++ b/replay.h
@@ -80,6 +80,11 @@ struct replay_result {
 
 void replay_result_release(struct replay_result *result);
 
+void replay_result_queue_update(struct replay_result *result,
+				const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid);
+
 /*
  * Replay a set of commits onto a new location. Leaves both the working tree,
  * index and references untouched. Reference updates caused by the replay will

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

