Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0119E960
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677376; cv=none; b=Fr6Sd/DXYMxRkXGWN/VJAgFD8ZKYhzZy0VUzNwQyCyYrzDsp1orF1iQ+LMj05vKtkdU/kTFiHZkwX8JG28DFC6C3Vyha0idX8rxlRU8tBgulwL7orD7kcuUYXoJZgRhNHQCd3HYialTeOGM/Xm7K20sweWsD7/kWJngFt4+Yr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677376; c=relaxed/simple;
	bh=0afEIPFwFguXF3VlitR+Vs3Zw/6EAyvohz/wu4WJMYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF4SNW1jRuKq7a6zrD2IO+Asv5TAx8s0FKWOwiefezcCviUx6lVeNjNTh6vtiuQyR4CW+1EpAH00jsAmCWj1hniEvq2zTx8qrrsL6toDLypHRmEc+Xr3heqZCVSm6cDbGB6+sxNOZYdgiEmF9QMH/G3Ul1nOuqwU39Zn/CLwC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=niNRq+pr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkGl/yyW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="niNRq+pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkGl/yyW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F6E01380205;
	Wed, 23 Oct 2024 05:56:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Oct 2024 05:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677374; x=1729763774; bh=t4u51MSTZn
	B6A6Dk+SiIlcmo7nnmvhv6uDe0u0LmA84=; b=niNRq+prDL478BcbQIKF+auv34
	5WtEkNDmDjNTkyuXD13WjUGaiEOtYHYDwlme0hlRcFfdbPJtTWrSru1P1hA6DE3D
	pKvEOxuIyx32GHYoYlPXaVLhmjn8jsoHfVy7cZBfpeErOz+rSh0UENIpRs3Exlzr
	Y7sEEFT8YF+TAVdu+208O97VJwHnNJ7h8DjQlQUYw553K+9+FrqKZ35TkV8Z3YJH
	E7PP3c2stGQOodnQPmVRsD1nASZdPiALf2nSx139RD+QTLEFpEO7dxz9dF8DiVpZ
	rHInPoB158ZW1g8gFl7fw6BsQYnjUaau3mPelJmGY6UNktpiwuIbuMm5UcBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677374; x=1729763774; bh=t4u51MSTZnB6A6Dk+SiIlcmo7nnm
	vhv6uDe0u0LmA84=; b=nkGl/yyWxssU2TR1Hf27Fqr414t1dt5M4hJjTJ+ogCu9
	xQ/5GKrCIgzUS+oNpZwMzQSTPfa0DuRqNsA4p/wIU8f9Nn48VmOsH93YCX5RUf0O
	1Z1cVoY2mY0LIjEci5cNcLOluanW0RKKk1CzAXdMic+I3M8PfqPFkGDxkOMy5OTe
	tpp7H+GLOudIX9VnISxAmQPOl12WpL7hJPT2xnhtvIFcCdIanYW3xzlTzEBkT8MM
	3R2kkPA1bgZU58S9ZPmaK4Of0Zy0XupDdMYj1nTw8q/ZWF23ucBvf3iTIH5NKUV7
	1q+q796A/KUTviRgXWqyUFto9SyxXxPZNl1b9ysbtw==
X-ME-Sender: <xms:PsgYZw27WhNjw9vj828wzDv4l_HOWKmlTWXRWlrI5k8NHQ0Y9fGFJA>
    <xme:PsgYZ7Fuob-FlDj5I0EY_VLswZWMcgRGXaraEPwoMPuM4z7OcpaBB5NsowONUwAtR
    xgTOezup82U37PWRw>
X-ME-Received: <xmr:PsgYZ45_uyGuhYNDJp5_iGtqp7y3YVMxPbKEzvNjAJvKHWFZzxwPB082H_BXOIr5aE2z-9Kc69SLNl0rC65IrbPHP6Jh15F1x90FwA7GvmQ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PsgYZ51POtGLeWxGafJC2LifwVOu7seDPw5AIQ3Jkr8m9UJ0-NJIdg>
    <xmx:PsgYZzG4WkCutRaDFdPZY0DLApIa55fjxZFdUELPG-AF7IybVQXM3Q>
    <xmx:PsgYZy8PL7QEXnh-TjUPCjKPqS1IJZTY9CM8aw52zbwtum3aByESEg>
    <xmx:PsgYZ4lCnzNMMJpm8o243DUNlFKmktAm8rpu4ilqPWogNBQ9d2yM4g>
    <xmx:PsgYZ4Q6-G43P9aqyp8rkKE-4qcR6ULNR1pmHrkyQ1YSrKJtuPI9PLEW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:56:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06b1cbe3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:42 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:56:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 6/7] reftable/stack: drop only use of `get_locked_file_path()`
Message-ID: <74afe30974dd800337950c3cb14e97e2a111b635.1729677003.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

We've got a single callsite where we call `get_locked_file_path()`. As
we're about to convert our usage of the lockfile subsystem to instead be
used via a compatibility shim we'd have to implement more logic for this
single callsite. While that would be okay if Git was the only supposed
user of the reftable library, it's a bit more awkward when considering
that we have to reimplement this functionality for every user of the
library eventually.

Refactor the code such that we don't call `get_locked_file_path()`
anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 67b2117a112..c1a4e25e3a2 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1493,9 +1493,15 @@ static int stack_compact_range(struct reftable_stack *st,
 	 */
 	for (i = 0; i < nlocks; i++) {
 		struct lock_file *table_lock = &table_locks[i];
-		char *table_path = get_locked_file_path(table_lock);
-		unlink(table_path);
-		reftable_free(table_path);
+		const char *lock_path = get_lock_file_path(table_lock);
+
+		reftable_buf_reset(&table_name);
+		err = reftable_buf_add(&table_name, lock_path,
+				       strlen(lock_path) - strlen(".lock"));
+		if (err)
+			continue;
+
+		unlink(table_name.buf);
 	}
 
 done:
-- 
2.47.0.118.gfd3785337b.dirty

