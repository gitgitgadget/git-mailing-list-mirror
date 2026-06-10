Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9240423A65
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103464; cv=none; b=uEY/G9VveGmCsNq80MiFDpedbuVb6CO9Fdl+WJzvmhpXooyWjHvGWsD8/qtorTnsvPgIeMAgd/RR8eZnIVq0TwTA4TKZzLS6HKjm/vgfCNRLme4s0oE4IQHF1HPDgXnKwW7B43KfQxK6qlbxUEgwREBI1Uf7yfMsLikuYnm25Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103464; c=relaxed/simple;
	bh=iLfqKNiMcDMFgoLIRYd00nuTMtmufsp6dcO5cdNZUOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEa1M/wTf94aKgg/0s1LF2AHHM3SpWlmGay+wKfq1dHXD17mR1ggxBLcvn9xIWzcanYhV6TTCoMpDaywIhk0RoqWp/oX+FVY4O7wPUbu0L0ykoICyejj+Z9KWqhi3tM1kn4ioz+RCxZirIo2KYHjfdU24Udo7ZpDwgmzUE2Nr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BK0pDa9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FazMuVLA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BK0pDa9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FazMuVLA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 305721400089;
	Wed, 10 Jun 2026 10:57:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 10:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103462;
	 x=1781189862; bh=ZZ9fxFf5Qy63bJHcRtf0pg1nuvfiVulmPcTNi8Aa9Sg=; b=
	BK0pDa9sz6W1xhB7eG3vHC/q5CL7w3CSeJ2dw6tWYG+vYobqf6eg26SUXhHcSLLs
	IKtpi+VUzM17CtNyAbwwmZkd7gJI6NlS+ywNq0S33tX+c2E43F3x5nHYnFBu/VQJ
	y2mb02r8jw8mXE61f3cQcFOBKZTbglAVelljPILOCurH9jUArMLWiXPcbbuz0UGN
	PjIb8B7X3U13zCJvUemffudyWRxvCj/m414lJUrvt1uiF3GVzJTzS1zNQtlR6Zbj
	O+4S/B7ZOXaxkOXZdi3SKUQfktn0NdF2lfniPgn0rx9RmyFIIPNmKPT+Gy8CpK9B
	46AgG92oH2Z7Yam5z+Ldlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103462; x=
	1781189862; bh=ZZ9fxFf5Qy63bJHcRtf0pg1nuvfiVulmPcTNi8Aa9Sg=; b=F
	azMuVLAR8QOcckn+MgyNX6fi1C3ucW2ylTeqVAojNf8l6kUn/wNUIt5dEfG+vSZA
	IWvoeiCr1tFMqMFkaSEMEMQRKObakw2knQwcMnk+/xrcrfx0ghwLowQoIQ834lWL
	drHtuvZqK6OCYArjuX3fTxoScqSHcDfZ7H690PVLDLefPtGbUgST10DPfTPvBkwL
	KnmVYxuVKDHCvVbt+WvDHj8Anz5u9ZaTgAiRJhZkWD/no1Dwj+TuiBd4oObSbUCx
	csIrXtj+KNYyEmtjzhtXPoVXpmeI8xef+Kr7zm0fbJIkMnhlJrv9aWFHU65/Z947
	G+9oWpSePMHRbnhUtFJ8Q==
X-ME-Sender: <xms:ZnspaoCQbNhnY4u_MdeKVpsxh5k6FjWLm0gYv-Lk76tHDt-iVWI0rA>
    <xme:ZnspaggmoL6pD-laeapaK8rTM9uyYsmboJT4xgnKKFyKqBwY5LPWNoa5k25emS3cv
    yu0284vYQ7DYkCyp8mjRma80dBFXEvlYE839M8m9qExZgiF4gTgZA>
X-ME-Received: <xmr:ZnspapNXBEBMBpouA_jF0luET_VO6TniTGBeNwZ4lfESVGQbyvAkHw9g7cgaIrQe6dmA6B3Ga_w6KkRy-_yLnFrYDciJ0Np7iOFiohMT_g>
X-ME-Proxy-Cause: dmFkZTFV1kQoQzh3f7iPJ7/YFd/m8dJe9AD9Yq6T8MbjiQKW6XEQnBF6koS/FikyXKJrju
    ACddczotc6v184tuD9hxB3VQCkcckp3iYYC5NIvAW2aNg1PiHj/Cmc6/VcZVl1scCsxkTb
    vwm0doE4PoD5qg8Q7OJz4225C4O4it9K4xT8VDLuPDz5hPTqTjyGsPln3FZGvO+j9ynugO
    u5a4tmf9ncQi06NsesfmrGiqUSW/ynByjWqiZyO9bZJLx0LJg/5M+1HWEGE0jE5rrqNis8
    Vsu5Yelh3VQwpbFCg0FGW3I/h32jtqrGhkCVyo7l8ARwj1CIhXyA/Phu6Atg+fGO6l+OK4
    1cKxp2+COI3/3SKIWtC8QYPjKTBdOJ/P87HMxXPdE+hhoL953HiKucebMWvivKGF88Shtb
    1zvu/cJKXYzRmf7EQA5dFVtgBl7hsFBgPvsIRw6ACsnktuUTb3zt4MWn7+ZfK/8k49dqII
    nunVct9bxy7X3oDlyVikp6IBVBqeho/K1FTJUY9D7V/ckTaiijr9deR2LWCKd0Lj0AIhwa
    V7I72zZUOtPw6BorTe+ifQ9TdRyREJGPVPuA00bBe+ErALnlNuwsQ6OqwxpzSOGFjQore2
    6hH0nyLmjqLRY01GnI7jIZHC8lBm9/fsp6XfYXt8WThTGTLbjt3cC11je8vg
X-ME-Proxy: <xmx:Znspap6k5YXF4GKrOqWdz_czLA77cpgHB9nby2pH4_AzmkEu91kWQA>
    <xmx:Znspav2IGwT73pLABMpEQXYi35enuCtq1uyV9SBfaopK0S-bVMrAkw>
    <xmx:ZnspaiaNoMmyKh3okj5gFgJ7GiflY7LHveNc2u3Xa8o8FVrbWI5XoA>
    <xmx:ZnspavDvyAaCvppyvprO0UWZ5AAa_csf4eCZC8ge9SfUMfj8FjAkJA>
    <xmx:ZnspanyT-H-WW2SPXxL46I20dqimA2eSfoJ6RLV3scuQx3BolaF9pti9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86370395 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:14 +0200
Subject: [PATCH 8/9] refs: drop local buffer in
 `refs_compute_filesystem_location()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-8-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

We're using a local buffer in `refs_compute_filesystem_location()` that
is only used so that we can fill it and then call `strbuf_realpath()` on
its result. This roundtrip isn't necessary though: `strbuf_realpath()`
already knows to use a single buffer as both input and output at the
same time. So all this does is to add a bit of confusion and an extra
memory allocation.

Drop the local buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index e69b9b8ac8..4912510590 100644
--- a/refs.c
+++ b/refs.c
@@ -3571,8 +3571,6 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 				      bool *is_worktree, struct strbuf *refdir,
 				      struct strbuf *ref_common_dir)
 {
-	struct strbuf sb = STRBUF_INIT;
-
 	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
 
 	if (!payload) {
@@ -3586,8 +3584,8 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 	}
 
 	if (!is_absolute_path(payload)) {
-		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
-		strbuf_realpath(ref_common_dir, sb.buf, 1);
+		strbuf_addf(ref_common_dir, "/%s", payload);
+		strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
 	} else {
 		strbuf_realpath(ref_common_dir, payload, 1);
 	}
@@ -3600,6 +3598,4 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 			BUG("worktree path does not contain slash");
 		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
 	}
-
-	strbuf_release(&sb);
 }

-- 
2.54.0.1189.g8c84645362.dirty

