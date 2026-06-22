Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C7370D77
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124719; cv=none; b=RUCqfuSdOVhytQJnVP1bh/9koGtT1gRH7SzIWx+pIMzuUoBRJM2/tD47L1IymhBv1BXU5WULEK6BDCvLCzXnAvNLI5yB+JwkcoGSXwnw/aOmuYNqEL9eoeMcEdxPNrXffE2hkPzKfilv8F2zc+YBBENA7OgisOzG2cEM6kjiI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124719; c=relaxed/simple;
	bh=PYAgmKmJsx/1ixSrkI7BkhqF0NO+lAtN+ulPTr359pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAHodFWowZoxfXrIo0nVqdGSG+udG2otR7L7DfQJlGA2Rn9yUIrnhHZB2NHqQEE4I7ViERzMrtisVNtwf+zrSQr0L0LMdaXVhUk3gJ4WaAtoOvdD2IAmBq1Om70mOE7YkGbjnvZhUYPRnlUQP/5VtTF3sixyCFaiHt6XSVV5q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nimABf63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNV1LzlG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nimABf63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNV1LzlG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A99E57A0182;
	Mon, 22 Jun 2026 06:38:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 06:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782124716;
	 x=1782211116; bh=YAz08J+5rZq6eC62JOhKXc6mWwgc1AkkW5nH3uPN200=; b=
	nimABf63YT/n0NlpXqwm4cGsm8VF3gPm1OyxImR/11zhO2rohBcOvzSRh2fw2QrJ
	+rmplq2rS6LBVB32uCRMmKD+U1DEsUJSMoRuJAxUAukQUhnPwwPVw/xLoR8FNA6T
	2dDHeLIJvLuL4Led4uy5g7NN3nduWYMmq+kjKnjkMPoAp6eNslVKNP6OZMgKYfUj
	pYlpHtuxoxIRj7eLIBPNeYHFcVLvtaQOEHEgRggD4tM3K1Rl2Tj4fyaSbUo8sMIf
	YVB+toVPW18mck8+aluML26kCBI/0u9kfKgsyjk7Z/j85uZSlU4+V6oINVAkFfd3
	Iqmta276KcdB1/BgoMnrPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782124716; x=
	1782211116; bh=YAz08J+5rZq6eC62JOhKXc6mWwgc1AkkW5nH3uPN200=; b=D
	NV1LzlGM8Y03MWtFlG727SemHvuPnPaGdAwnYaxKIg/oVDrnwqnfazLuklyzpllY
	RfYUmfc2CtPJXPJ47t8bAIW/oodRoZjLukQ4ClUNJ4d/Re+SQAnW6+sKF366tZrk
	dUPe69oXiKShhmrtbXk8ABOZuDd3BP3if7XGUyuPao8qGLQN8ryJEVRr+/tkAq3H
	WHJluLWG9bhDPPeh7XALUgmSV4gt5fM0oL+EqDLZ0aCEuyd0hhKLKimut1R1QUSM
	ifcoy+x8gMOaFDc9gcxnZoKxG/o1JPy2AaR7W5xNf5GzcS5VrAuwraGzPHmHKoEW
	TWrxQdu6S5ESNSrERkCtw==
X-ME-Sender: <xms:rBA5alYLakkezXTDVpbmcvPGOtEo1oXmHmiPT5Wxdvs2NItfp1Smjg>
    <xme:rBA5aluHi3MEzkSkyFaGq7g63ewY5D3Tm-PRuaO0K1LV0emJkJMtnUigEKEwpHUhq
    S-XM3atsUPI1WkIC74ApEtV6iOPFeQAqYewlaJVQSB-SI9yCD_oDw>
X-ME-Received: <xmr:rBA5avMyXqb87QI1w8bN2xP3w8BGN7ssKNwssfyjbw6xhNT3eTyocUQ3Ajfn82za3aae8xqCtHVK_UMTGe_mnfzqWe5561k_x1lKtnLRZg>
X-ME-Proxy-Cause: dmFkZTEoih31rLqzGU14ZpeOO0CBx2xGuU2WGgiSnmXAqbnNxSDjoPvWMJzjR+inCcit2d
    UAJo6aSdjZO6fJ9y32XgtjezbJAIVcVaveKvkxbodgqZXxHqe3gJXnzMe2EiYe0pAoxRKY
    UoTHbYnpneOi13onZFkI2C0IETW0M9euvQo2NWAXeEePIgCcdInim1R0zFW/D6nHWN57Oi
    jr2bL8Z/O6Sy0h55V6cj2jgWMbQQzYMOZNP5Bj1pxEueca1Y9qm0LCySnqgI1Wx+2nC616
    refvTGzpeLjZhJgFsp7B3KuYiqmteUzq0mZ3PJ3JRkKy6QK5FuBFGKVO0EJ6ReoS2P9AP9
    QRxqBFMTRHPJBkAbWZH54vYbzKRZVo5x5xFbog+IyBaNaCGzxb4cdugWskFCucG80Y38sE
    QhJNV+NpGZqLbCU6lsafpun+NvOk/jA8nGscMrj8SPyqecxa5EJzHjd4SZ7uz6liBDO4sh
    CorDXtCEhbT+kJiKqW9PaGzFMo8whNuSRnmecjFMg70j6M1cW/eopJj3L3xbSmQvloK0HR
    OuklTn1mVC6qpSITcAoluoLes9st90B03R41tAVhwdOe9GJP9PtO1Qn3n+WJxNCX3wA7zO
    VPQEnFWlmM4m3fCY3O52/6USIvQmRCbddHYOtJWuNRtUmPvFeqzlQO7XPo2w
X-ME-Proxy: <xmx:rBA5ak4iFrm228-spfmlYSI2ZkM4iUiwIWEN0uLGpeCDDFHS9o3w7A>
    <xmx:rBA5atQlLwNuf0LHynUjeyvT_k9por7M0kqvJwKlg-B2f8ViOENe6g>
    <xmx:rBA5apCXTW0KXPQbIbIJswlxIH5UNZqfD7k5PRve0iSfYJdLcv6UNw>
    <xmx:rBA5alHEOMSxo2gRhtfjWDlT8sPBjbjos1yqsSUE2PoVaVqWw3nOCg>
    <xmx:rBA5apWK-sSxfY8f3k2Xog4aJZ_YrQwbUZyMGlHYbDI12QnJQMyBRM6V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 06:38:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 144afcf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 10:38:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 12:38:21 +0200
Subject: [PATCH RFC v2 1/2] t/helper: prepare "test-example-tap.c" for
 introduction of "lib/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-pks-libgit-in-subdir-v2-1-cb946c51ee7b@pks.im>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
In-Reply-To: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In the next commit we're about to introduce a new "lib/" directory and
move all of our files into it. With this split the compiler won't be
able to find one of the includes in "test-example-tap.c" anymore. Adjust
it to a relative include to prepare for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-example-tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index 998a1f0b42..50d46669d1 100644
--- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "t/unit-tests/test-lib.h"
+#include "../unit-tests/test-lib.h"
 
 /*
  * The purpose of this "unit test" is to verify a few invariants of the unit

-- 
2.55.0.rc1.745.g43192e7977.dirty

