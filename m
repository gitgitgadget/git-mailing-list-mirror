Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8C190477
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391414; cv=none; b=VOJfKY/gK3/RP1Qyk4QlNn5xKVSqf3EJWFU60HhURrPqwgIho66FWHPOxbkhQrlbnGcl3Gw2zAu8+4sLbjFcp8Xjggd5kCz7SNjPrI8LOxkeQK5lJ8r6MlwYcrkLhAIuWNchpyYHdUdRayTovK/VtNXQKO7qMM+M37gRo9JPA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391414; c=relaxed/simple;
	bh=+GAZHQwsNXOz5X6RBqCMGSS0jJ6zg/37nifc597U8/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZr/5IGTETMQj/nkWc8PTGizpSFNXeYUBuayCFi4B8GCgr2At4Z4ZcHStgw0Dj1/CcIqsQZOVtdnDMbcRAedCRnkk7ewKnuJqt5/hqXXzmkfrAPr7HlWWOyMEpoFi5WddMXqwzcmK1pJmys5BHo7fUzsKzI04L3ozrv/WxdTOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TaQRFngT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrvzYrF+; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TaQRFngT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrvzYrF+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 0C30B2005BD;
	Thu,  5 Dec 2024 04:36:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Dec 2024 04:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391412;
	 x=1733398612; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=
	TaQRFngTP+RLD99NZtWfzLgr2LzD78xJOFqmUVv+LFDaTVXyHaiuB/0t6Pp8+TBD
	Xusdc4CUQqwuvLZGUBZnl6EEcPMw92ffjzODaS7E3prvPFw9UMqPFrD6r79EJD5I
	WIYfwJkTx/+u+ZkwuF4FKQ8xH8pOUPVGUs7SGXOs35OjR2AShUuSmF2b+2IJNs1l
	3+2CYLCSQmmmhkpVJlVK1wXcsn/jluth5gs9f1Hs/IZqUuuHIJPQw4Snvo2JsHhi
	mMc9FFA/eELLjd3sjxwHzQ6JHdpkE7hVC/colgJvrsJx6xLWHyyMs0CkgP3QKe1V
	hcw6h9Qlx0mP2e55zmpvbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391412; x=
	1733398612; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=V
	rvzYrF+FasHtYXy69YVjTXlSvUYSVB+7BdN+p2iyP8PZSDUSFDbVlSKgJeVgJvGR
	BWI7rHvLdE6VcZaf8LGzSCZCxrS+vkR8FOA42g8pL6IbFcHhGwY/jTyuiunT+T4t
	ZDr79v1tk7yfaXY98uP1OQXl2BUfACyF+jFnyd5RhZXzS0y7Ftt9R03mjDQdKUHr
	GZTgTLERSQa8YvLJxIWlarHW4VLGpSXf9aNqXtene1x5k64hQdJ0cszjp6X4uqtu
	kgPrg2y+KSP/PrvW2itfLAXAxU9G9D/B8kk3uF7Dh/3wYAEhbfDC4ED9EO0mCHaD
	yg5Q6fgOFkC8QRnULT8tQ==
X-ME-Sender: <xms:M3RRZx0EIZh-S6y4UK4uGmO8A0tWevkdJrI7Yw4A-NmvZ7vzb1jXhA>
    <xme:M3RRZ4Hqcqgg8dTidKi3heKtQ0DhXNqV_9f0dYvnlhx8D7oZwVJSadBlEvxFsne47
    x-fWCgWKziDdfcabw>
X-ME-Received: <xmr:M3RRZx4X6vsxpp7mWWBBt2WF8DNMdW06vuh933zwhLtu20OsXRKe9chg1SDeYmDZM30E4ViroHW53xgOwSz0bxoI1-ShJ4n0J49q90WePNuAcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuphgrmhgfrhhlucdlfe
    dttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetjeehudetjeehhefhheej
    teeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucfuphgrmhgfrhhlpehhthhtph
    emsddsfiiffidrghhnuhdrohhrghdslhhitggvnhhsvghsnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M3RRZ-03_CtcgCLT39Jk7mrbA09NjHEfvMT0fcVfNCWMSSmowTV10g>
    <xmx:M3RRZ0GCYqVdHzYmShkHIHUDaSah3DMu_0CPiebeBRnwQ5F2Sw06FQ>
    <xmx:M3RRZ_93yt5rDQUztWySW_SJwsv7YcWsyGjNmJXdH2tabII3nDMOvg>
    <xmx:M3RRZxnDtfd3hT-_0h5m54lsqXd7SR5-ry75ZViYzrmm7wm9xlOkvQ>
    <xmx:NHRRZ-Nz17XFUtLLjvGYzDEslxhCGNHraSVH9QsjIzylRa9OdhBkD3Cd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 588bedee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:24 +0100
Subject: [PATCH v3 02/15] compat/regex: explicitly ignore "-Wsign-compare"
 warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-2-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Explicitly ignore "-Wsign-compare" warnings in our bundled copy of the
regcomp implementation. We don't use the macro introduced in the
preceding commit because this code does not include "git-compat-util.h"
in the first place.

Note that we already directly use "#pragma GCC diagnostic ignored" in
"regcomp.c", so it shouldn't be an issue to use it directly in the new
spot, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/regex/regex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index e6f4a5d177bb7d44345fcc25fabca1e62b0eebc4..4b09cc4e1457dc362b2c974e82a6f9739b499a83 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -17,6 +17,8 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#pragma GCC diagnostic ignored "-Wsign-compare"
+
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif

-- 
2.47.0.366.g5daf58cba8.dirty

