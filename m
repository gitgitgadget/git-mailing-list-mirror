Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B11495539
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589126; cv=none; b=qkjv3Sddcw628kNJ3ODpB1jKdO8+WA6HOt3gFPFQQc/GYug6LbNYGYwE1V2bcTX6t/4VFEHWhoE7m5bU05iHgS3awAp0r6cmhI0Ptwt060fk0j17BqzuEUe2+9zGregp9QoO3lxMxkxM45PrqgEQ1mwiBX8igfYmCtHpcLwK/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589126; c=relaxed/simple;
	bh=CwRhShpAL7sOygI+y4ACUCzqvFJLmSzKeF2jaowSt1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLcav6sYaGSrLNh9GpxqgU8u5O8Gq2i70ifQ4cb2nWhDt1PmFec+WIlT85wg+jRQPew5GdvXpJbZw0HRQGUj36Tdm1obKq76T/jhHPd95vgLocLypo+WFvbZuo08phQ+19tQTgyZbQIzmFdj0FaQgCO8P30fT93krlP7Ojpnggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UAIxFFTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nBMfWftR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UAIxFFTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nBMfWftR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 692E3140001D;
	Mon, 28 Sep 2026 05:52:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589124;
	 x=1790675524; bh=aPuE9oeQKVQgsj9fnCu7YTCanTP/YuCo9XWzBFP61ek=; b=
	UAIxFFTDEeaPRxp3l9cUjK3s6yd+K/DNcpQh/HzOG3+ta/jOA+EcvJEWImduTma2
	xu2vyFnnxLQu+/v3JhwVcYePuFK6MSV5GkKbQrFOM2yVaUMxVq9x39+s5gmNGmjR
	SklGaW2KJO0cdzPn0jMVkofxSwLqDfqya/mfkLUAttqALfTOcw+6k5ILjkXp5zln
	fS50DNwdiAAEZsG0mrS5vwKTgDylZFpn3CBTga0OdD3F0mSQyGb/LPWkZNZeGNPw
	haHzRCNep8QAXZlYy4b5fG6vEjxB2iyv7rkTiUNmDsGxrBIECqef2u4TJF/EDMrv
	yehokTEEWAuklKImRrgHlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589124; x=
	1790675524; bh=aPuE9oeQKVQgsj9fnCu7YTCanTP/YuCo9XWzBFP61ek=; b=n
	BMfWftRnT9Yt0HRyH4nJt6V6NnljArRHeKybDPssAX7OdJWz3pUp4pR8PGD/o2Tb
	/penUSQqJH0LsWCHYlK8T9JIRcer8sICb/El2wjIAMluFhIxadUYZucR9v+XXrxK
	PjVs28g1EyhBZqi/jjE9griCwLsnabho+HMmUhRRFVNV90iREyItEOLp36Ss4HcA
	MllG8qsb3tTquJgZ5KrgZd1AH6dHWfpU/zkPrRSrl2Lgpnf5UXlEDc6BCOVk/ri1
	5LRmxQjiD3jhyhWOxLAmi/Rqgbstj0WuvK5hhX5BfJk7wxExalu+l4oqzDINvB+e
	wkl/X4pDaGcwoaSLhUIxw==
X-ME-Sender: <xms:xDi6aidPkQgt3MQih6uXcLuM5jVHdimty97LiOYSZNnoKCQgIiU35w>
    <xme:xDi6ajq1wa4QaSl_-WoHtEkbD65wnx2DFHVrKr-txZct3yJCtZYadx0xpf9-b7MV1
    kB4y0NYOziooVrgCZ82-Ze-PpbnVAnhIwQXJ2y66fn0er3WH9XScPc>
X-ME-Received: <xmr:xDi6ag5OQgM6kbUZ18qbOWGEJHyDsa-uwRujl6iVFONfg8MYNV2H9A>
X-ME-Proxy-Cause: dmFkZTFf3wbZ+K2hbzfSgpgETsMz+NBy3J6MpFvFZYdyyTeL1iI2BFDj1IOSxm4OYKC0H3
    1Aperekeoh01XU/Affr9YDGewK0XTpFuAvdOqXRnkn1hAQOMt6Cmug4wAR/cLjxT0+YYyY
    V0ix31kC1wU9qb1Fc8l0wzUB6/ndZQ/KZS4bdHqUX1yu2WFUdfLdGcye3K8VFjVWdme6dj
    VB+FbRki+xZ7UJmHTn7m2FhlNqt4gn7r8JRqnyPx9S2V0Cn7eSTMCsJkqZ9Q8z0sAb/7of
    tUBRJGNrdn5okkLUJRR2FTKTF+T7dMnEgQWAA9cfkQE6WEt+aDQyOttxx4ijBJAJTShyfq
    F03l6pw3fJMZjauHhqFlotKKWWFDEWAwUXMgkrd8RmxgNuovoy/izqyZi2edM/knLV5bi6
    l8/YPU7ypkvyhRDPCEEQjxwARYB79Kfr7PO6Bu3ZrUjvhpoElwzi9/8qRuDTfuLPoq4n6M
    t1AF9MxaIf79LH6IX887Teg1izjoJd/SZC+0nL14PVu77/USJkiCvFUc5rwYqIhnQRppIe
    v2KVffWfH/NVyRIxEORVhK0P9IKENWiMOZtckiQ9xJCHMeOy0DeZ2oxNXiOBj68NvYE+4Y
    eFhbfFfxxGV2CXghMkiY4UAT1Ae53eGh/yQzVzcsDXrwR57F5OsWTK9ukucA
X-ME-Proxy: <xmx:xDi6appTDvf_hLALy4vQP-5jD-uVCeuUiLvk1QpNaO3pWmdT_DjmFQ>
    <xmx:xDi6aihwjxjICP36w35MU9YMbi9FLjhIRAoicpm4hHCbXAGqDLQPwQ>
    <xmx:xDi6ajIySHOR0blM7UUClcpwBHOtevq3pY_LnZ3ZkufS7LZbuE47XQ>
    <xmx:xDi6aiBVwQJqP6aVMnKauX0vRzHzahVbXBNgunHHLvWm1TukPOPHcQ>
    <xmx:xDi6aiHRCF8OFJ58H9hTSYPAlwLk-UHCTSN04YIXAjg6JwCIaPrmWclk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:52:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf11feec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:52:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:08 +0200
Subject: [PATCH v2 7/7] setup: enforce that passed-in repo does not carry
 relevant state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-7-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In the preceding patches we have refactored `create_repository()` so
that the passed-in repository is not used anymore to propagate any kind
of state. This was done so that the parameter doesn't act like an in-out
parameter, but only as an out parameter that we initialize with the
state of the newly created repository.

We don't enforce though that the repository _cannot_ be used to
propagate state anymore, which makes it quite easy for state to sneak in
at a later point again.

Ideally, we'd do that by having the function create a newly allocated
repository instead of taking a repository as input. But unfortunately,
that does not work because we end up calling `repo_config_values()` when
we create the "files" ref database, and that function requires that the
passed-in repository is `the_repository`.

Instead, call `repo_clear()` at the beginning of the function, which
gives us a clean slate.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/setup.c b/setup.c
index 0d0a4abbe6..fa39219d6a 100644
--- a/setup.c
+++ b/setup.c
@@ -2858,6 +2858,9 @@ void create_repository(struct repository *repo,
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
 
+	repo_clear(repo);
+	initialize_repository(repo);
+
 	if (real_git_dir) {
 		struct stat st;
 

-- 
2.56.0.rc2.329.gd58861e689.dirty

