Received: from sender4-pp-e103.zoho.com (sender4-pp-e103.zoho.com [136.143.188.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B2337689
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636433; cv=pass; b=ap4zkcQZtdcRqzyTFKJ20l9RAnsCczfSt1m1wDstfpkDwTvzV3pzwJeclQtG/dwzmVDQwH2844d5pr4k8a9rfW1MGtsf816DUqAfoOmjRSatWhs3ovdaEvaqKqbyL8/2lpIa68lbIXB6SJQXESQiAY1NhFsA7UlJb6IGan8CzXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636433; c=relaxed/simple;
	bh=tyFpk44Vjd9jbZS0uw09xpE8sB+6ySyIWx9QyK7XFuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiZG2Ymuvcu3oqEVq7uDVf3qr6jBKZgSSx1gVXW0rD5uV8rgcTIOcewL0DmPPk1HFR0OgnEkCAZp5n0F86amnRxdkid+7WzIksl36B5hjgSUloIYxVg6JncBrS3teSSAC4Yhrx45+uAOzS4UAzOK/gHyQr7xbwG2tIsIU7loKZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lYnKYLDo; arc=pass smtp.client-ip=136.143.188.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lYnKYLDo"
ARC-Seal: i=1; a=rsa-sha256; t=1769636407; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hwip1PVJurtWgG+mhM3BCLthEgLeccb6kFv7FawM0Z5e57+H5kTCiZT1ujqXJb/VG9rt8Al+o8FLCRkr4Lb3B9xf1OHqUk1D4dcPMeSCnz3zDdacPt34FWSZa2qU/JZ0R8gxXxWHUiVcP001hzYzXWeS2NQH08Ej3YdlD0RurUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636407; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bQh0gNJ7VMH4bbnUgmq7GMJIw6ygyRx1qjBY5guhfg=; 
	b=KFkcz6bi9QGukaH1cbFMruqW4GvlcxxnrnEj/LoRvdqXNnJfu20NYIiYmQxLRFiNSu0nJMmc/EgLwWmrfUBwIXtoTIZEs5kUExfU6RL5nUaW6GZvPuDB6l412pGYRTkCOf4V3L1yRnil04lLQmC+CFe6q2QXk9UmMEyxBREdTEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636407;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7bQh0gNJ7VMH4bbnUgmq7GMJIw6ygyRx1qjBY5guhfg=;
	b=lYnKYLDoDgt1AAfMxTvixb2Hwz7FUvKeBnC7bnP8TyMN0bApt3sAYIROxU9BFQm2
	KOL/81oD9/nPRD5MHpar8f+0xhluct3H9ZEBwOaYDKBJwml3eC38p5on5NASv2hDEHR
	Uf5cwtO2LzvDubGWJuHUdAW9aQL9m4DvgQP+vuto=
Received: by mx.zohomail.com with SMTPS id 1769636406020573.1627068878372;
	Wed, 28 Jan 2026 13:40:06 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v8 06/12] hook: allow separate std[out|err] streams
Date: Wed, 28 Jan 2026 23:39:21 +0200
Message-ID: <20260128213927.3026875-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The hook API assumes that all hooks merge stdout to stderr.

This assumption is proven wrong by pre-push: some of its users
actually expect separate stdout and stderr streams and merging
them will cause a regression.

Therefore this adds a mechanism to allow pre-push to separate
the streams, which will be used in the next commit.

The mechanism is generic via struct run_hooks_opt just in case
there are any more surprise exceptions like this.

Reported-by: Chris Darroch <chrisd@apache.org>
Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c |  2 +-
 hook.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 5ddd7678d1..fde1f88ce8 100644
--- a/hook.c
+++ b/hook.c
@@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
 		cp->in = -1;
 	}
 
-	cp->stdout_to_stderr = 1;
+	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
diff --git a/hook.h b/hook.h
index 2169d4a6bd..2c8a23a569 100644
--- a/hook.h
+++ b/hook.h
@@ -34,6 +34,15 @@ struct run_hooks_opt
 	 */
 	int *invoked_hook;
 
+	/**
+	 * Send the hook's stdout to stderr.
+	 *
+	 * This is the default behavior for all hooks except pre-push,
+	 * which has separate stdout and stderr streams for backwards
+	 * compatibility reasons.
+	 */
+	unsigned int stdout_to_stderr:1;
+
 	/**
 	 * Path to file which should be piped to stdin for each hook.
 	 */
@@ -80,6 +89,7 @@ struct run_hooks_opt
 #define RUN_HOOKS_OPT_INIT { \
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
+	.stdout_to_stderr = 1, \
 }
 
 struct hook_cb_data {
-- 
2.52.0.732.gb351b5166d.dirty

