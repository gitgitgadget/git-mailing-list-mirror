Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C3335573
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429876; cv=none; b=D6VYTGDxXtF59pl8/3ezToH8416EZWNpwaNyxfZ4i97fi2Gho/5wSNMB5fvsAggWCJebJ8Aps1cfPG2rQQVnQYuRuHyR1dR4hfQt+RdWAnWSBFP+o42lr1cwC5nRMTjW7ODD7RDyltPdb4ZKQCJww5TS6VhO8BO3LybvATqdkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429876; c=relaxed/simple;
	bh=fjQZCzsCuXXyv3PFUsBMJ61dnEHTHaDq8QVNMjnzCxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXlzv+VY5zQP8YxaokZjN7cxxLREuhTImit4dHPKPY1A0tFTeRZDFX4qbtuas49nwzFnYKpz/hXyHTG6cGAYzONH/avoLFUuY/r+P6N6ljSblxEHlmsirwVzeRcRFt+LOo4F30lvrdUsv1vxyWlHgWqjCSMvCWU4uZrhsmQLFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LUX8u2pZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JE2kxK6s; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LUX8u2pZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JE2kxK6s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 176B0EC0175
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 07:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769429874;
	 x=1769516274; bh=2AKyRbklNrWjTQRhlEHmpZeQiPa3L9tXhJVzk4vgFOo=; b=
	LUX8u2pZ8Dbze6PO3oj1MODJaGUzbpOk/1ic77oUrqHoBnVKRIRNVcXf3a3aHfRh
	nXRszViRoA57Gy+oz/BXCpzjRoQcpO0HUpCOaluqSWTx0F4QQCUsSTPADbi27ILs
	niuOLP77BsoYX/VufqwNx1VveSfq+cGIoWkPYqQs/gjnjy9hcA6AAxq8Ya/r0e7E
	6Dhh6MqDySojpnEkLAQ0cbgbh4DSP0qau3Ms6kFViZMDN3DPQwk9gREZOwU2fkbG
	bYlXqonJ9up8dVi0RUGxgzutG4lTu5naJaOhvkF361IkmcIxbYNLnUfF/7L8E2Et
	24NNiAFqWAOBOjx7rhfYQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769429874; x=
	1769516274; bh=2AKyRbklNrWjTQRhlEHmpZeQiPa3L9tXhJVzk4vgFOo=; b=J
	E2kxK6sSJ66mfC1gOMsAj9Jn5GI1uL8qumJ1cMUXKVoFfZS9nH1ESlmiGyU8flgC
	VgQ2KEBvckHNz5c8MeDDWz0Z7o63Xth2rKYiXbEpLslXzdlCFLnBPW9Y+WzKM5FM
	WFOfq0kMlpxYzk9hrAZvpQYYGVdpUsk+fQhzQJMIG0rSk9idZgBayT9Wre1CFLOc
	xiPkvEqFsjRlshnbX1/VVu0gfAn1qyjftGGeC842k6x1aez0i+bbs5bEVo0HjaV7
	ZKR06MoaX8Y6sdrzPvpZ6Gk5QpDeMYX86OA9gj8FH7gAip5uQ10JBLYkRRBanFsC
	Ii8jRhGNUESgilW+85zGg==
X-ME-Sender: <xms:clt3aXuavK_4hWx5dN0WzoJAkTYWof587CqvsaI3iYLKJYfmCB3IuA>
    <xme:clt3afZcHAAS_d58jeoqdxwzsXV6_VOzMEOAKBpUaPa16CgSTKTIUNQkHWoUoRkuE
    rRv0sccRmG6K2S8FC0JcVP9yYnTMchYXxs-TJKdsaH3oBcXfUVYFg>
X-ME-Received: <xmr:clt3aQYEgwo49QOtKK9SSLGk1ct3OiZKuOfgYIr3Na3w_FZSItJak17cJN1y7DKAATe-Kzb5OUvzxxwgS4-HGQatC8kNSAhs0PmZtyESO8JPQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:clt3abWbY4EhmE02fjW5QEMHfyiIwq7ytWRulBoZiolfH7C5OS013g>
    <xmx:clt3aX3fTrcsOhXnNCJiSJp_thYDT1xNw275jFe7IlrD4hyBeNBLqQ>
    <xmx:clt3aSZjRhiSuFawFYkThMpwbupCl3dKFmC1GelC_546oyxenn5HEg>
    <xmx:clt3aapkE_0QmbpUW_A6xU-SjFdhkOQDe5C4nDK1wGGJoS-QMoIQ2A>
    <xmx:clt3aWdCenGVs7Lyf6lsjZuHBaDRK8p-nAKYRBEMM3gXA0rI1_JEKbNs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8695ecbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Jan 2026 12:17:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 13:17:41 +0100
Subject: [PATCH 1/3] builtin/backfill: fix flags passed to
 `odb_has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `fill_missing_blobs()` receives an array of object IDs and
verifies for each of them whether the corresponding object exists. If it
doesn't exist, we add it to a set of objects and then batch-fetch all of
the objects at once.

The check for whether or not we already have the object is broken
though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
expects us to pass `HAS_OBJECT_*` flags. The flag expands to:

  - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
    in case the object wasn't found. This makes sense, as we'd otherwise
    reprepare the object database as many times as we have missing
    objects.

  - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
    not fetch the object in case it's missing. Again, this makes sense,
    as we want to batch-fetch the objects.

This shows that we indeed want the equivalent of this flag, but of
course represented as `HAS_OBJECT_*` flags.

Luckily, the code is already working correctly. The `OBJECT_INFO` flag
expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
flags. And if no flags are passed, `odb_has_object()` ends up calling
`odb_read_object_info_extended()` with exactly the above two flags that
we wanted to set in the first place.

Of course, this is pure luck, and this can break any moment. So let's
fix this and correct the code to not pass any flags at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/backfill.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..d8cb3b0eba 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -67,8 +67,7 @@ static int fill_missing_blobs(const char *path UNUSED,
 		return 0;
 
 	for (size_t i = 0; i < list->nr; i++) {
-		if (!odb_has_object(ctx->repo->objects, &list->oid[i],
-				    OBJECT_INFO_FOR_PREFETCH))
+		if (!odb_has_object(ctx->repo->objects, &list->oid[i], 0))
 			oid_array_append(&ctx->current_batch, &list->oid[i]);
 	}
 

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

