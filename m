Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21148033C
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905765; cv=none; b=LRdLU58v/UzaZ/uHNV6TGWdwGy6gPmPslFcnV/EVdVd8MpzzRHfFpjJs5seOAMJGOON3MkKNr2avgW9EJJRPYTJmWNGnw1eR/06qlQBKGf/3mSNwxzS6AQJviI2pvDbtcliMEqFqReDEIX6/I0LbL49Z2reV5V2/Jq47jYeJB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905765; c=relaxed/simple;
	bh=Gsx8+Sx2KF6SfWac1RWNNs0Qtk/p4bzB5QfFDcysBj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMHm/FFY5JB5Y8Kb6k5thliOdAxWzl8oj/nNZbkTnZO4uLNW+AgIicJ8TSOLP/IDYKmPUO/TX0u14qYCQQ0drOUSHNwsSK1RjQbf5RQFxcYvwdngna5mZ6B+syijns6U0l3JJ92yj+sDMWztXxqFNKTf6h3Ie5W7+dyccXIu2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nlG/MWnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1A5E0st; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nlG/MWnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1A5E0st"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8128CEC0112;
	Wed,  1 Jul 2026 07:36:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 07:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905763;
	 x=1782992163; bh=BPYjtlMCOaSwvym0ACqVy107DI9EiFeDgySEqz/z/V4=; b=
	nlG/MWnUYstG8kySzJXGsUwU3LP4yGMi34anZWrwzX6dKPXx27ADRATKmu+tp+Jl
	pgLN9Wy1SdaYlQpWbV1/xg+zkUW7KscVbaKkW4ebZIMJgd+ffuEHYimxTVPjHfGH
	LsqSWScu6RuigSUXOVRXtiI1h55CM1q/tow3GA4yzraCZb7ny/q8nmZVI7sOpEHw
	tK8ajkXPQhnU61tjd1i20QPfz3MBcqk0tvcW8ueTOlL35eNBxeYC7qkauXeuTpLW
	iKNIF1DQ5q/iZmeuQ5xgP883bwttDGOLEN4vTZgOh0qi1mr14OKsRCgsoQDmpgoS
	rrbeogW2aFHCw9nnWbwQUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905763; x=
	1782992163; bh=BPYjtlMCOaSwvym0ACqVy107DI9EiFeDgySEqz/z/V4=; b=X
	1A5E0staKQo7z68AqAfC3Jwj8b6zLlD0TZvzajzrYbR+Zu9Slx3ZbyrCa1Vlgjzh
	Gt3cVr/ZzPzAjRBxnEpzaBiBgU6pz+AcZRrfFlUppaptN9min7mxMPUFQ1xHuaTr
	S+tGtm7hAlUjJbR3AnOJyQU7UtBxL7MKC77Y4mJeQwROp9UJvwHlBkkuKIlSlSJ/
	Hb5xG5uuYf3skAWY16b4wAanxtDkV2QWsK6T+lRNV4UyFWdpIn7f78u1FBp+jHwg
	dndnYULpuDHGu5QftZLm3ubrElYERGKguJpXDsAQ2JtV0w+P6X6uPpqC55jy0B6b
	jt4ykZqnmyEfVVn3u41iQ==
X-ME-Sender: <xms:o_tEaqwObcpRSYvnHoLXFB-qaSDBvClyrXmyTsYGm_93Mmk3sUgXkw>
    <xme:o_tEavk2G74mW44Z16YjfhkEhD2M8n6n2I9_kINgypVX5qdH47MtSez0KApnnTcNF
    5EcQL-YrQwNCB9efFxEEZa_4rL3ILcNysE4Ha8V20LQp1XBtj9jYw>
X-ME-Received: <xmr:o_tEajnt-2ZLcpSouo-2cls13pqGYPeg7CQu7PAuAuen6oMq-KjbfsPfol4GXtSjVEsThp9Yu5xCuA6Ou-L-xdEXJKXfyhgzbVDs0gkWgr0>
X-ME-Proxy-Cause: dmFkZTGP8olTVfG0Etc6nFuMxuNYYzTE1D5oBGUXdKllgwcE9joDINGsH1hHrnm4H6GzJO
    QNfRWXvQl+AscTekTq8UIGQFvBJwhFyDsAs1tImo0nIZSHDx0eUNAXuCCkSSntihhY4d7O
    Vyye8u0iRWrSW6AyTVhIvTj7D9MUHrVqoNVtNgPZa7Nr48ylZk5ypeJEXondhxghuT98I1
    3wUe6KzuZTtdDuOQGSz6IiyItbLYGnTaj/0tt4uDhIfAcjapKc0LTt/g3/g+H/njIiZCCh
    pW+DTMp8qO5ecPmIjUnC0Mii7PYtN+3mV5FJLbJ/+Hrr+xNp7r7lP4CCQC9kDtIARDqYhD
    HtaJ3+l2LPT7p1TINOr5Hh3QZnogGrAJUEFYJ12teWshK2eai45b8TlyIITLtljPNF3NfW
    jH845CZ3ZYdfUDBSFvBAgJIDVIhAbeCRgizEFFXR06HkmdpvR2l+TTTxHxiUwG5Dlg3fhH
    vpM4ejb5xy4eY5Ba0210vxr/Jci0C+7qyHE4atANe+lxnD4XBAneAfIzTeg/c2/kJnl/Y+
    XozJ+6Y8uWG9/VT0/ikreajrGxYtEQzGLo/JBwCET/iV1cgiW9RqyDaWS/FFplmh9dZrJt
    ycPdfACD+Ai3sTIDgidNC7SEacUETzHmYc22AH+2aAg7E73UpMyi3AoZwL5w
X-ME-Proxy: <xmx:o_tEahxWId5CikajIN7B5JwIps_EHXNY-B-jLMHBXA-5is_NDhUqig>
    <xmx:o_tEaopIZz8iXMqfaHTe5V4TNjzNV0K8NNgGwC-2tRva0xe_cGQiBg>
    <xmx:o_tEag7jK1SzXOHPjX_-sUNfVohoy0xGycSR2tdhBGxbRRfmg2-PAQ>
    <xmx:o_tEavcc2qTuqoNDGxWy8bcPipOY2_60nUejPeaL_AU49JiIJLJSgw>
    <xmx:o_tEahMkTiFF2Ss0T6dUJBpYw0JytISY3TCStfXIH6Arb3roWfzyOBq3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:36:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d595396 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:36:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:36 +0200
Subject: [PATCH v8 09/11] replay: expose `replay_result_queue_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-9-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
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
2.55.0.795.g602f6c329a.dirty

