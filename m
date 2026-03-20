Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EA377004
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007591; cv=pass; b=kFRaMAHSZpOqIAXyuOBlpVVWaAhGhorsG9BIcvUFYLRsmZh6YTQv/OU47sKK3zYe//ADok+lJmfE4a2htDovHR2CfgOHXCJN4TeLnL1Q6XBbqYdrAr18S+RFqr/5wsHuABM4999m86uO5HMkSKrzOTv+c/+qNCSYy18q8vsqKEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007591; c=relaxed/simple;
	bh=n6n2vAj8CQs2FPTJla1+V/ey5VuyiPmlAtcDJMBVE6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGZ4Bj6xexCICzDtC/d9cQzqB51OAsyi2C9Y0T/WRxnpe/RtTGQaCGUy2DWJlAzmhUwrq1ySgPjt4cRxjlWcA5PUZDLlDNZW8ISH8qtAlbtLW72rN132vWPw1nRSxRxDqkyhzGOReYQbGdY2MsTbtDn+BWYrGBDdSy1kXAmcpQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Toy1/z8e; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Toy1/z8e"
ARC-Seal: i=1; a=rsa-sha256; t=1774007578; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VoiGH9F5oy5Ola9Eo7VdyUSEwDyVawX++LXUpgNh4as7GY856JsglqB3LsC79BiQfmqxDMc5VBMyYGnQgFqwWyRCV4ISVyEtxdpZVTCMt3LO1dtE7mBcWG2i3Omt+eYXdwVU/fXjv3sCFfwvQ2Lqd9u95fdyVyJlKpIBp1Xo1zI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007578; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PG35RCzEopdDcqw5bPaFA1FDmceKwS6FZb664kdnC+U=; 
	b=aC5KvmInJqSKv+DQwUAQK3TN13/9u3fystoal3us/XgOpdF04pHMcW5OCUZMpIxMX/arpszadV7D8V8O+RsB5UN+698B+yNZw+3wYMKNhG6wVsFfdYV7rMMRFboQYoR2FStuTxSgB7TqiEkFIwtmgB27mpBw6YFhAlTjf/6ahmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007578;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PG35RCzEopdDcqw5bPaFA1FDmceKwS6FZb664kdnC+U=;
	b=Toy1/z8eL5PscsRAP46+Jndx41uliDfqcEztMQdVwvDYSG0x44UVvWcBSbnxAwui
	HtRV5kWKXvlCSsei1kfxHwzM1vfDS18DN4wnhY8zzFvgb1KgYaIYy2m3wqCPQJoWKLQ
	GDB042WFBkR+goW2Hz0Ru9xMIeUOXv37gLgiY3lE=
Received: by mx.zohomail.com with SMTPS id 1774007576515430.65164819356835;
	Fri, 20 Mar 2026 04:52:56 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 04/10] hook: detect & emit two more bugs
Date: Fri, 20 Mar 2026 13:52:05 +0200
Message-ID: <20260320115211.177351-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320115211.177351-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Trigger a bug when an unknown hook type is encountered while
setting up hook execution.

Also issue a bug if a configured hook is enabled without a cmd.

Mostly useful for defensive coding.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hook.c b/hook.c
index afa8db21a0..6dfaa7e9b1 100644
--- a/hook.c
+++ b/hook.c
@@ -408,7 +408,11 @@ static int pick_next_hook(struct child_process *cp,
 	} else if (h->kind == HOOK_CONFIGURED) {
 		/* to enable oneliners, let config-specified hooks run in shell. */
 		cp->use_shell = true;
+		if (!h->u.configured.command)
+			BUG("non-disabled HOOK_CONFIGURED hook has no command");
 		strvec_push(&cp->args, h->u.configured.command);
+	} else {
+		BUG("unknown hook kind");
 	}
 
 	if (!cp->args.nr)
-- 
2.52.0.732.gb351b5166d.dirty

