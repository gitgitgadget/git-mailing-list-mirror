Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24F390CAE
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116928; cv=none; b=t97giQQXFUAe52masXZqgmaZRd8JYGMSuXQRtR9mQjYSbdduQgaHcCRMJEmHywvAVrklQ3wceYDcBUwjfF5b/AnfEi5oFtmydlpoow88OxtwB5H9zg6rrWFC0u7kiIXApIp5hU2dF+e3CCu3OtgWFlbzKXvvrOWVPf3WGADThq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116928; c=relaxed/simple;
	bh=5ZcrLdNjsxRxcgdvVa5RXmdXmYGwGQQ2N04+RIdHK3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q64OsLrHFzp/+4+tk7LGItqQ2/JjoicU4LPtKqBcWchUgHGUgVpYOFjl7pQlDWdxXB56BmK2Sj/dNeT4iJia+1PrLPba85L41nHAHeM2FInwuKzpytflE+HwI5RvVZ83R2IDJa7k8akaUJBpLTx1XvU64XXF2zcK6cK9BuJN9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SFJbcpzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfqmM2ML; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SFJbcpzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfqmM2ML"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 67A6C1D000D4;
	Mon, 22 Jun 2026 04:28:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116922;
	 x=1782203322; bh=Qh/vm1eHLDVI7/CY5OB47Bo4GfeDcyIgXY2JtDbznSg=; b=
	SFJbcpzDqo/ZOxXwbS70rr8mHut41wUKDdPo+xyuPB3hdD8tnduDETEgm3YMqH+G
	w+Sndg87Tg0iGA1ngUsYW47N2EV9lcifY9rmfzhrqZNz8eWp2y+UBe1OorBiEj0E
	gpnMzn3YTJs7pkM4ToBoxmBVwvgoL5l0a8ZtHziH8JPklM7UOotpBgohzcedFkfE
	SjowImFUovwf5EOoqraLY4gt1Mdkvjy5l7e8rRrTGuzmJPE2J66Ytj15fyg4wDUj
	2WWt3KBdD05nEDfWKNU0UayOyG5oV7VRzTwUsUFvV703X/5BgUUhTsiJJ4QncSpW
	HMICwfUsg049R+maYNyIxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116922; x=
	1782203322; bh=Qh/vm1eHLDVI7/CY5OB47Bo4GfeDcyIgXY2JtDbznSg=; b=h
	fqmM2MLLtV6b2cs5OBrFyJiAtrsBmCzNjc2NQhNclq2uzzkg4LfWx4iLPK6zd4QQ
	W2prPONMVjGG+JPoakPKLcOm+mjTmA9mwclOo25AVLzyTNOBTTiQiuslHuINZYPf
	hfC7yR+XjkuSOlQt4+2NCjFGTrb4YVXbEV5QjmwLD2rJw9uY6WGAgYFLQHio4EmO
	SdUumqLZflMKIZk3CX45pSctdRQa93+ZvA+caanqOotmLIBbcrW4eLLF5qA5JMnC
	aIXMJYtc8VKLLNDT77+xaZGXKPf0d7Cv9DwoGGCh/a5LAo+nmPmByVlNi2oXMuRH
	e2OG9rPqXEi7pOeA6RGhg==
X-ME-Sender: <xms:OvI4aslAq9-UhP3HYxurIwXifCMy-l0n9ns0_o6RfHq4FBzFGsmA6g>
    <xme:OvI4ai3smYKEHR_xzy_RR6Bj9GvxZHzRiKsnrdzxljWoG8wV0bMl58zurizn8FTSa
    anTxOtxB9qeB6y4MqQWdI9mQ4e52tK6q04rTYx1cR4EFcMGXb5ZWA>
X-ME-Received: <xmr:OvI4avoKIBP5c40BtXVUkqY4gfUUWT2n9QHxZg5Pqrcbvu0zcx33gVMRIaF5BN_aco9ecdb-s-au6Ydl-bV3xoE1G88BZZsFGGepXakQ0w>
X-ME-Proxy-Cause: dmFkZTEgEeRgh6uOul9Opk9J4xCXqIod6AC6JstWWC4SySG5YH0Oc5LLZEfe494s5qjvmq
    FzeKu1zmmYflnYxBkbpNTOrGRBR7klFQ3Wq8E9miSgfFgeN/pdLpZtlSzx+DmiwybLU1c6
    hM5EIn6bmYoR1tnhEtwaSAWBKPYel1ZAAVie+W+PZ5CV9NzvFhqafAYRRUd59TkNUycgIA
    LTVt4YPvkzLPxHah2XrMREuxrabnxRVMaYOKRU9dvHQPsO7uozLuP8evr7b10ZUjTJSh4h
    gGYOA6eznudBHV1XDJ/Pg9PKpiNKwGQBdZP0ix4729lKMDxZ/jSsSngmUaqqPSJJ5wJDk5
    AAMJdQkYx1UApvP+z4hdCqKyjhq+6D/DKOOe5hDEu8ZCtTmHFQv29vzAynGs7E8CmU0WYo
    SAjsVwT9DqN1vKnPlPaAlQf/Xtks0f6RyksXNhByQBO9zNj0dAOIpIhcQ5sjbkAQYKxd1n
    OjJm9xVHIpxVlTj//HJc6kSjCFLVZqEtQQP6N/frgzGq/TV7HSNyZWWnbzEFZUv1J9thV9
    8eiL5E9kfp8NxwOfzgn4LHu7/eBAkS1/Wdh7aJG3BccVE4fxviXP+uJk+TypFPZsmyt18V
    AqJat3HS2aWTb3mydOQ+MgJPLl5DmnfFDTz95rWdRzzoPXEa9+Q8FfNwGVhA
X-ME-Proxy: <xmx:OvI4andWGbJ0C5BMiCIs7YSs5Y9jI5VmVQHgjEtjHmmM1OoInnZDbw>
    <xmx:OvI4amrwbS2RMgHmqnXjuoxOzAEKXBrAtYgPW9u3r2I_QSCSufrpjw>
    <xmx:OvI4agHnHPrg68ytBY_Hg6w1g-pETzMry67woXX4l5dmj4z-YNCisA>
    <xmx:OvI4autUsNCgHWCGDwwPbKlZyOk7RQVngsZ7DvzQDVk99HGQ4BkshQ>
    <xmx:OvI4aiscjzIi8TzdzZyBTd7ujXTiYusrC5mOhrPyUYGs-MtW8LiDCSxs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 881bb443 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:27 +0200
Subject: [PATCH v5 05/11] chdir-notify: drop unused
 `chdir_notify_reparent()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-5-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
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

