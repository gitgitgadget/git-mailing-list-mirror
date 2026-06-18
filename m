Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36F370D79
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765693; cv=none; b=JcyDocVPezBOQq3XnhXH9C9P7SemUJN3Z9iIeR3Xz1UhEiHsJKJNGAJkoUI2wb7U01LM4qYFtTfAPtp864kEBUZSG7oWOJEJ5TDc26C1PUHYGWLni6csAN4frQZMWPT6UVyCgzBxh125wXtUAMm0GF2598s04hGHGaclYpkEOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765693; c=relaxed/simple;
	bh=VbZK6HJXUsgqbCu/eamS/S42CUwDBdkGE/t+B9rxyCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGqrzs4v1YAbYeMoXKsL/lGATphVT2Gdna/+B7fRwrI9ZeYz8p0WaRJTFa1QhirCBTBcC8ZOnm37oBNKa0ERdQLHR32HhWSfu1EJrAKtDzgFfYrF32zbQ2cEN+ZbQFhhINcV+mQxVSICnuNi9rQUGAOvqjeml5y2rrqaOzQgDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U8nb78gx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RnwJ8V7U; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U8nb78gx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RnwJ8V7U"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D64AF7A014C;
	Thu, 18 Jun 2026 02:54:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 02:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765691;
	 x=1781852091; bh=F2WAsQO5RjcFCisZK5tKBgAxSZ9aWYKjOxIicDhg6jc=; b=
	U8nb78gxCa1n0dILeVYJpaUkdO/5I3dmHwSYT2SdFJEewI7E3o3HTpFAtfGWu7WV
	HLxhW3z8gd0qmU3cRYmTM6eFCus5DKD4t+4QAFu+51FT211GzMkei2a27jVR1vst
	uBtDv3ftTstMAAUluEuySV9NLWaozlWppbrTy3pFkz/9B837Tngh3qF6tsTAVAqe
	rny9OgUjRThvnSUmEKD6G8Ew4Qy9o72K9JOlXlhYNkPZa3KAP5E/IYZ4p8rlNhZy
	ctxoVzzGOPAHFj+xh4on+NNiJDgOJCeUfbt95zS/2nsulzC1x5OH2jOvnNbZfV1g
	tUm6+q5EVHPyFgjVKvNAlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765691; x=
	1781852091; bh=F2WAsQO5RjcFCisZK5tKBgAxSZ9aWYKjOxIicDhg6jc=; b=R
	nwJ8V7Ushdy8bygECJY8HINiXugUE/mH/xO56ZfKXYUptmpzVFa2vlWSP5fkNK5j
	of9qCgTLaIMpG8DH8jxziuZzsKKoA+hdbAzEt3DjPYvdLSSklaCLp/KHfSQzjBr/
	Qd+dalUBhyxU3CxjSXaFV4JkVqValJDVBE5xkhgHhlMoDT+f3ZQO4gwrbnKWCgUH
	9daROyztVKBPxlDWwkkOevolkRuydBrrzXhhkpgT+wT7JErfex3ERD/UhB76jBSJ
	jBdVJ3LCsaybDjdXROJCVtgVgw5AD1amGgBb/3qViBFsr8IXDD3S7RlDw3G9v6di
	5f748AAs3E2r+IV21hUow==
X-ME-Sender: <xms:O5YzakODe0zNxGmLxEqng1mS_1kLG_NlsLkMC2EM1XkSEF43l_gLXQ>
    <xme:O5Yzah_WdwcbeuXU2NZY7KGqzM0a-qr_5hB4Cn-VeqS3oRW3z9jwLvaOUYNlCnj8s
    haPcG12WEGicTLbfr2Vs62egYTGI29E_fkG1LDaOdImhV1sgH2S0g>
X-ME-Received: <xmr:O5YzagQT5IzRVWHweyITcrRODyQy4hhwnJzRjx9w5_AxZNJguBJuBPB5b6jbiEX6DoXS_IS2NZDSSb1_d6DV4kcVzjBLnNqsZ9c7XRnKcQ>
X-ME-Proxy-Cause: dmFkZTFD6dk3bOvvX0yaVMjewMZkeTdhDwFjQkN7CKbrsc6RX0hrYV0S0wDnX/SLDtagvs
    OXl/+ys6J6Ef+ualX4oOCc6rpWlLgwUd+CDYp+J4f9tlVotwnOyNo/D2Ul+hiGJ2GnOpwO
    20YD1dz+jK59WSjSeqbvZIbS7LjQbwOZCvQ25fWlXFborkKwttqiF//EPtS1SKQOJhwE9p
    V3KhMGYjicitMSxnodz6t0JekyXT6bD5QV2YO0G8PEP3srRCCjxK6NZiPsNL9hezzRVkL4
    4yQ1ZKu2ng6hTy03G2N6EA5XYfWUIQofvB/33+yVj+xfadwE0sg/Gf4tc/U+tgG/YyDiN2
    R0zQG0F7j+lg3CLaiGugxH9Cu3DkUSaRsUMd2x/DUtPPL0b8f6JgiIOZFczboNb1OpVLsW
    ycFJhdmYoeeAizFJ0MnKGXmLxzNr7Gcrqw2Hdynxyz95MFs4QXp+U2r8Ij5WlVg8yWGZbj
    lGGMpJ2URYJ6YZnAFZwXhQfKns9ldchNoGhTFcmeXX2qHc7b3jwQOhAhDzJqVane/xzsSy
    kF/9aBDkN6iV9xXpgFRJsSi/Yod0i2xlieiKwCw4MIYKR31q6xsJ2y56zn6KL/o48IHjsG
    ESySt37lQJDD/wKYC/up6mNQTU3QXToXer99uAp6QkoCDmQBG8Ud95Fqc2hQ
X-ME-Proxy: <xmx:O5Yzarm-Ab-Bcwd6DEthCPYEU-NS2A0vJvcaxZdTsK2hGH0wUydBNQ>
    <xmx:O5YzaoSg5dJBaL_x3HIPnHefYX-QflX-2oI-uF6MQOdGbEdKrFOomw>
    <xmx:O5YzahM-Qtp_CvYQH5F31aQspnJc_d3K3U1EIVETR1JNnsqsr9KAnw>
    <xmx:O5YzapWTaK21KZLLBPvL788wPOSegGMSj3ZUIIjMJksVtCAcvHsnbQ>
    <xmx:O5YzahXAqZ1iodSSk77fwjhbSYjjgafJwCpuZhLcqGsDXO8DcREw8X87>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71596f05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:34 +0200
Subject: [PATCH v3 5/8] chdir-notify: drop unused `chdir_notify_reparent()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-5-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

