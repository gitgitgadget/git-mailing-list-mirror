Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C7386435
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379224; cv=none; b=tZVy4lg0PJwP/1CyvuOBl8neuRs17blAmRqU9tsZXtxm1tuPS8iIzGb23TJHN0udwqvnhoMevpU4OJnAxx8Vg4Qe+WfF9YHSSplMF7Mr+XB2euN1DMWhAK+A/InUtd9DsdC2wyOb25Rd708IOenahuHhJMWdjdIq/1ESaABi9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379224; c=relaxed/simple;
	bh=5ZcrLdNjsxRxcgdvVa5RXmdXmYGwGQQ2N04+RIdHK3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXMlTSugPD9Hpk4+Y7jalcQSardA12W/q7jkvYcuXN3EnQr9BRocj7rtXSSviOV3nVDU4HX/5c4eMiPW0pGZj9GLlElDwtUX4tT+QVHE9Lk7tftv8yDHVTYOdbnOqAPdz8gT7JrwyA8tcwmrrT/EOgH68g/sP/f85XCIY+5aW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mcy5/NbW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0ORc/ig; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mcy5/NbW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0ORc/ig"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5658B7A0150;
	Thu, 25 Jun 2026 05:20:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 05:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379222;
	 x=1782465622; bh=Qh/vm1eHLDVI7/CY5OB47Bo4GfeDcyIgXY2JtDbznSg=; b=
	Mcy5/NbWnpXSxw/IOS7xoRvsvj5VTrWI+qWq0gw8fPBzhLuw5fUd3Vq3PccVmivV
	GnhMPaGEmffEvR186SUlp/13EAFqZ31VbH3+9CthfgtrtPC7/oo12mPl7BYO6+yl
	Y2hp3Pav7cZHhWQ0TWTbAPjqVn5UDF3yN/InYz3pRco51QPGFa0Tfw0+0Ma9vK4S
	W45ky2phhpBUwXXmQ4svsJChf3FB5r/ROKGCkf+464ks3g3oF+/oJnwem4/2HbQa
	wsQn1+dytEATr6OMVxuyg924N4YbB4AW2XimwxkrB3TofwBUC9ZfH09X6bYuFRGS
	zL4aUPwQmo8ZkZEfeK9guA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379222; x=
	1782465622; bh=Qh/vm1eHLDVI7/CY5OB47Bo4GfeDcyIgXY2JtDbznSg=; b=e
	0ORc/igkzEUDQajV3GEiFtXMoj5ubhPhGS/ZTblt2ELNfnA2t/hk8o3StoQfL/kH
	kzIibg4aUaeXBLAiKSVxLl5wtxvDgdkiXJz2jlheI8YhHxgqXmfK9VCbb63Kaoj3
	n4JAWFZeU6WWuYboWA6NQxqmCbnutjBRgxBaTsdKyCPxO2XMdnewCujoDbH24M+D
	u6f8w84u+1oM9kysQAh+hLw+8+H5s/Kg10nRQGp0qRugSLGwEinouy1DwuRItk7Z
	CRN+zCoghShPmLq221sVL46TKj+HTJFoedZIova/RmWq1R8QlbrETpq+enVkIhuP
	CcTEmMfJq5Itd8yfFNn2g==
X-ME-Sender: <xms:1vI8aqBmOOW7iiDem9HsjtIiBc4ujqm1vBxb-TUKBKKh8NOJdGw23g>
    <xme:1vI8argy5gM5bg7m5KlBBRdi6Lo2KN6QQ0Q8mW2ivAIGIg0Fnjfj9B-uedyzKhVeq
    ArrKy3gu-poFmL12Ta5qRHRWGe6ui3OzPga5i-mqC-GcK9qTNUoiQ>
X-ME-Received: <xmr:1vI8ain2Hjr-ut7ZdAZWFeAoMw_HnpDgwX9AUxdC2B4uH5uT7S79xa11zArRZF09poqA6V7GPcdCGz6aWKf8Xy3lss0Xzbnwb99VcWx6Xg>
X-ME-Proxy-Cause: dmFkZTFDkaiEwMNfNKhUFmFqPW6+gIVtJ+TQ0x+eU1LJTAXOIoLsb/XxaWtlQqMIf9H6ak
    vv//LcI64loNAITt4OOQHOFy9WgByvNooIhJ2XlbTwdm6xBD19WPorDKcwOiR9pFZWYeRv
    2607fP2WCMejJ/uDjbOk+fpMEtTUZFFdt3j4ptZxyzkdYRLWbgeFFctod5KWBn8IP9fqHb
    7n5+J4i874CRT6uVOVvLP+BfWY7Uvc/qddGmGd+VQcdNPVInko49U8Hg7Z1CxzNqHtDkwP
    UF2JmCj+2LIZ1DRydCyM1v3SG2n9G+rp5MMnguBrnPoRL80fus1QwEoY52U10taAPz2/HI
    iSnNyT0Brl8DHG/c5WUPkrVJaTX1L9IGQInkzMDTa/Py31P1SjpW/AI0mU1rBaLR/ZCeRK
    osyibKAb0v6OsOc0vwS3UdqNr5iXNFwg2t/lWGohuP6K/0UvgAgq+Oh+q+QDKGc8gGkmYk
    TdHC6+eKjSmNk8P5hTOhBcV767Mo9Fmixn79Kt9tLn4Uxj/4a80JXzCSo6VZlLNz+Ap5RV
    /AgtaPsUFETt5d0mY4diijksEaa4eQXI2KBIwb0BdYKLUIeWtxR5C4QvED7m9NK5Q6DYnq
    peFEz0Wd7XuuD7L0MSKZrsoqywEOUFAX2b16We5xo+fQ7RRHVEzUa0vivdrQ
X-ME-Proxy: <xmx:1vI8anqzQ-V78Lh6V50lcMDr_7SzCsG9ykiUnJFWS8joDBmLgeHVVQ>
    <xmx:1vI8arE8zF7zpRYzdPTpDboZXzVVYvqRSqdG7YMGWU1SnuN3FkvLzA>
    <xmx:1vI8ajwrP5v2_VcAZ9IUT-aF35ZX0bqrusQ9bh7h0IAtw1XLxujYqw>
    <xmx:1vI8agpk-EWMtWLtM1twOroyU8BNHvRnMj0oCvRAew-CMU7T5QN14Q>
    <xmx:1vI8airnjXQ51Gab0-gJFtNLIVwOCRcuEmqkDcFAcv5EisVArHOzGJbY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5da37b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:03 +0200
Subject: [PATCH v6 05/11] chdir-notify: drop unused
 `chdir_notify_reparent()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-5-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
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
2.55.0.rc1.745.g43192e7977.dirty

