Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78B3F44FC
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531828; cv=none; b=LsIv3lCgc4AAF1sMHan3fptSsXn0qi0v4nyUXSjDF4RnvhI0qMa+trS5Pzs0QTW6E1rN8ogHbcPeZW/tWx3Iyci3jAeHjupMi2nTMovDzKiWVQ9cEg2UbbIUlRL7fNrvOok8nCHFFZySmxdojj3CW5I1nYpFZMegsXx0jT3cUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531828; c=relaxed/simple;
	bh=D/CvAsYGj90w8RVx15F/Vi9zaw/sgNGF5uJwQVfoQZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5RgV5l40Nxq+sVLTZtQ1zS1H4faJKexZ2rioLyu9Mu819j1ziBSOAuyUvPLZXzZ+Mq+lAumk8yUG1qrirAm0FZFjHne5wEF+zbTzLiOK31HbOdp50o1FDp7mqs1WVst1Z4gHCsHyIsnD3O04q328K7utMfHaaRqD+rCzHzfWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jsErKXLq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WafWaf1K; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jsErKXLq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WafWaf1K"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FD09EC001C;
	Mon, 15 Jun 2026 09:57:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 09:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531826;
	 x=1781618226; bh=v5tGCaWJeyM+3eVkyzR6iOLDFtfrsBwc0xaUcASS68o=; b=
	jsErKXLq3WBAi3nql489ystc8nlV3nSgx3SrH/CxrMjgyCGYoVexAv6oweQc0tj+
	twrJ881dMrszvJDupYd9Ii50FnGyf6nf6DPj+rXY2bqUHY0uiZEa9GSCCVnR+vJu
	dmexg6NbY/nM2mnrESvptdprX56pISIaZCu4g2rPJuFoMCw6CpoYftwwhodM6Dn3
	P2hAtlXb7xdn1cepxnrX6eTSOl/w9zpwopVrMpalz5cEync+UbICshQ2GyXmEJ5S
	4W2nLg/Annq/kKMsO3/JllvwM8y3c+H/Im/XLTDqxEcgScUPsUZ5q0eg0jJWqpeu
	eoLEXhfNXqiL8nBDRRWtvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531826; x=
	1781618226; bh=v5tGCaWJeyM+3eVkyzR6iOLDFtfrsBwc0xaUcASS68o=; b=W
	afWaf1KqZVsAUqvYJnCUwb7GlizKiR61vh7lAwporMHxkCmy/LDF03Igb9llG1nn
	hdRuWLfN7UU23r6Szfx3yzgGiQJBPt3QsT3BOvR+7DrxJq3LaTrK2nPJ14WldAdq
	wt2Xg5iVx35xNcw9+uvmUq94XftLJ2P16mVNJtdKJGEpsHOpiiS6favcpS6UqUQU
	m2K5CnBv9dDEmvRcUwPo44B8uIMludhqbNbDPvzYD6n79XFlTZeZ+Jf+Et9IJ16O
	GAX9ssZxee0l9esRsbRJa/cD6VbfeWH4hs28eh0UhDreED/MP/fWXrF2s0dN3w/t
	n0y3T5WRNqIwewUBK7W3w==
X-ME-Sender: <xms:sgQwajX2tMmwmn8OszMoT2xbI0abhqU8-A_wJh-e4_lRskotwEHAxQ>
    <xme:sgQwajBq7hewBZoqW1QuUYuKWW3Ft3PgPoYbanRqGJqQXUN-VSKsKbgqpBWrsgiVF
    tbFPRfi6UivQlHTGyyTOzGvry5f67I92G1ADV8khh3KsWgPXHsD4Q>
X-ME-Received: <xmr:sgQwasxeqBzzY7hbzt001btLCe9L0k_KTlnA5ZQuNvmlbz-Ub7xSlPCxXoc7d1fTJ24cVhTtqOvbbxFVpyy66QQ0wHGe1k4TKdqLBwOcHg>
X-ME-Proxy-Cause: dmFkZTF1FG+X5HxMGxOgCAZMy4A7SvmaeSo8nWVIUYom5oj1dQYaH7atcMinwTjrhcUyUb
    LZan+BOoi5ge9vWfhtLLsEJ6nozXuvgxf5Kre19hZamhgwR0kDzFxjz443r3LfEN0HSBzC
    eukzV1YjVJAegImryJKbJrBYtZbul/kuDL7+1mQnTd4ql7YGqXAGhhukI9FiiNwgCHqy+l
    BLSdjQUYerE20wsVpJRKZc4+wrOvLcOxsuKNhg33c7tdC3ovyr2Y8bNMARXZwwqqWISsz+
    zZJEPANDT/QdTsAiGkRM58RqOqc4pCnkclD6WNSyNVkuatZTyKu4DM5S4sdA8JUB43kSPo
    7W4WTsyTuatibOZys3ggMUJ2KjzZ8V2N726EUQ9dZc8gM5GrWV76PdHjaNJ9yzrf6epvks
    a2di1ks6xJEVK+OMt9F+UYmugm0gNARfXbpnXxQGUctVcnnLwX/H7p/Kgrt5mPfsH67l6W
    kdKkMcKEh+uDpWD7XqBRIeaqvSkIMUhx1RbUThL3KFVmBlt+xOFJ6MXwtmlgugwjYaBLvW
    Urh3NK6/kfxj8WaNGZrsHS6qqsEWnrobOoZ47KkQms7iJxosSLUGrEMqLc3SdtJJcCtlhE
    yzV06vCUGJu+UrVhu3mNY4rdoqJfNk3L7JI07RdTfZxev094O/DTBo8Y9Rpg
X-ME-Proxy: <xmx:sgQwaoAotq2-tSpMknDK4SZ3TblYxGtKF64z2C9-tqq258blV7A40g>
    <xmx:sgQwaha6U18tRSnkU9K8OdMvFypsUfENzQNiIB02xPSX-UaETuGEXg>
    <xmx:sgQwaoiAr3o951zihfN74LKkIt_IWjdp0UUrb7fF0OgqcTPC1W2Wzg>
    <xmx:sgQwar7zZsViLHd7veRwOa6dDcivtWwheJvPp5SPsHk468JM4focWw>
    <xmx:sgQwaktMj3SXv5dPc7_rhecTowBe4ZDLxNYJ72-4Wmkfq2e3aDfr-6WG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:57:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1cca66da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:57:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:51 +0200
Subject: [PATCH v2 5/8] chdir-notify: drop unused `chdir_notify_reparent()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-5-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

With the preceding commit we've removed all callers of
`chdir_notify_reparent()`, so the function is unused now. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 chdir-notify.c | 26 --------------------------
 chdir-notify.h |  6 +-----
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index f8bfe3cbef..1237a45e2e 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -43,32 +43,6 @@ void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 	}
 }
 
-static void reparent_cb(const char *name,
-			const char *old_cwd,
-			const char *new_cwd,
-			void *data)
-{
-	char **path = data;
-	char *tmp = *path;
-
-	if (!tmp)
-		return;
-
-	*path = reparent_relative_path(old_cwd, new_cwd, tmp);
-	free(tmp);
-
-	if (name) {
-		trace_printf_key(&trace_setup_key,
-				 "setup: reparent %s to '%s'",
-				 name, *path);
-	}
-}
-
-void chdir_notify_reparent(const char *name, char **path)
-{
-	chdir_notify_register(name, reparent_cb, path);
-}
-
 int chdir_notify(const char *new_cwd)
 {
 	struct strbuf old_cwd = STRBUF_INIT;
diff --git a/chdir-notify.h b/chdir-notify.h
index 81eb69d846..36b4114472 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -19,10 +19,7 @@
  *   chdir_notify_register("description", foo, data);
  *
  * In practice most callers will want to move a relative path to the new root;
- * they can use the reparent_relative_path() helper for that. If that's all
- * you're doing, you can also use the convenience function:
- *
- *   chdir_notify_reparent("description", &my_path);
+ * they can use the reparent_relative_path() helper for that.
  *
  * Whenever a chdir event occurs, that will update my_path (if it's relative)
  * to adjust for the new cwd by freeing any existing string and allocating a
@@ -43,7 +40,6 @@ typedef void (*chdir_notify_callback)(const char *name,
 void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
 void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 			     void *data);
-void chdir_notify_reparent(const char *name, char **path);
 
 /*
  *

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

