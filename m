Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12423B62C
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098250; cv=none; b=TwBVGa4eQsl7uujrF6M6658Y5zDY0sVYKyjedozDMaqblSrEAzPTMFynYS95wEeoEaWZDyFN+gou0X6F22xrJzU6au1NDkJCTmD9tOe8LnrCCGKs21CExCuDlrwi2QONvxXQP+xY6pPlgebcWbaK14Zu3hnOZfp4j0kulONCY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098250; c=relaxed/simple;
	bh=1gN3O2GMsOtnyo50XAjl6h71HyGbkscHiv1AlgMsgyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OGUAdgJzd++wJ1lBs/vEQ7NSzmbFA1H1WRBp/WxETdcXkxPHPhZM0iJmatd3i8bs3zmSJBN0Pts7ri5GT6kv82oIqB9C+OOFetIlANJ2RYZCRoBlvaT26SF9LLMV5t0pHnDjcWbmYWanp50DMrCdy4MJUMHDKkQObuxhCIFR9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LlpQVJzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dp15AMNk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LlpQVJzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dp15AMNk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A0AE7A01AD;
	Wed,  9 Jul 2025 17:57:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 17:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752098246; x=1752184646; bh=qISn83GPRc
	fGj8ed7CxfE1WQzKzdLCvy5Om4apGG+w8=; b=LlpQVJzkmgE3aTRb4CGbXlniu2
	UN9Da3Swhz+U+yBsSG2nh0uXj3zMr+duyA0u86KYIObM9Work7sGWHEHArOsfwkW
	eAykgypMD9f8ruexMTboWdgyRFzYMuoS0H1qEheatSnXS0FZtTXfV3bFZz+dEA4X
	irwP2La5BKxZJGDwTgR8I9oxXdHPjOR+I+3kcOO6TcINTYusihTDIdKecmMmXcR8
	dX6JortVtSjgw/o4oR/9GHNbA9IXw0BNOxpldqq7AI/vWcfHI9xAhw5jYrCe7Myv
	ARQUmJ69eIY9x4cgw48IpOxQkcPLM9q38ddtpD3HC9B5I+/RqaCc6nz6AwIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752098246; x=1752184646; bh=qISn83GPRcfGj8ed7CxfE1WQzKzdLCvy5Om
	4apGG+w8=; b=dp15AMNk54UO/f1+FM9KJ5z5ThoPCHtMjb2aAkIZIHY7Gkq5wmi
	5ol00WbUSxQ8uk9VKzVP4ffMH1wEzWQDohM1yy2FaoIjJ51bWFoxjGHy7YgRTFDZ
	aqWFHPS8uwP71y7ihXdVCznJIXCcUeRn8NGslpFJ7DaeP9mR7KVSlazOTVs9316p
	QbnuYCtTueidRkyU4XlPT+zVL/2n4K+7WXVmJViK0ckUO0TD+Z3i6MgOV+8WOEOv
	ra5K4cp3Ud2X4vuvZvCVKhS7Y1QPJslTStdE3XNKr2Q1fZgTLiJ6tpCCQdJhpi1R
	HuUPJoyJceFSwvKgAY9VHRFRuWz4H8lZzdw==
X-ME-Sender: <xms:xeVuaA4wnx0bQuep6AQwfNiEad7bqPL91x2vtekjCBZZB5kiyjXIKg>
    <xme:xeVuaPflH_7hiKa1tjPrb-ioFGgqy4V2oE2kjjucRTdezi_XFG999XNOsj7qtVRx6
    ScPeWKWw7Dtaqoqkw>
X-ME-Received: <xmr:xeVuaF5ClJy6tOSOEDdZKgZdniLY7wtcapdpXCnkhikcM4KF9pVKzv-cw40G_76udrPaoZuG26WLKOklC0utlFjSE-r-lCDn68vw8JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    ihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xeVuaGuKHdk82nOW3V-B5doZPCJW8aqLbZPSj4yiB-JHYZh3lBYNNQ>
    <xmx:xeVuaFhx4bJbIX-S46ONPTp00UcIq728Cu_bvDipCusOoBfzA-KB5Q>
    <xmx:xeVuaBquzPYcCrDa2QHXzE9miMQ3j82htBnzq-5semFgVuHZWaoFaA>
    <xmx:xeVuaCt48pOsZW9_WZRgAwPBsna6ng1r7IMPBc9xqStaWy1ppD8t0w>
    <xmx:xuVuaPOlQO7xaa3tlGn4t6GoPUJlJrAxYiFY00FzWQ4XopikWRTP71so>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 17:57:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>, Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "Derrick Stolee" <stolee@gmail.com>,
  "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/3] Introduce git-last-modified(1) command
In-Reply-To: <20250709152628.1644521-1-toon@iotcl.com> (Toon Claes's message
	of "Wed, 9 Jul 2025 17:26:25 +0200")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250709152628.1644521-1-toon@iotcl.com>
Date: Wed, 09 Jul 2025 14:57:23 -0700
Message-ID: <xmqqldoxauyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> This series adds the git-last-modified(1) subcommand. In the past the
> subcommand was proposed[1] to be named git-blame-tree(1). This version
> is based on the patches shared by the kind people at GitHub[2].

You do not have to deal with it just yet, but FYI, another topic in
flight renames away a few bloom API functions that this topic adds
more callers of.

If this topic needs to be rerolled after the other topic graduates
to 'master', we may need to see this topic rebased on a newer
'master' with something like the attached patch squashed in, but
because the other topic is not close to 'next' yet, let's keep these
two topics independent from each other as long as possible, and let
me deal with this trivial semantic conflict resolution, at least for
now.

Thanks.

 builtin/last-modified.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 466df04fba..2beae026cc 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -47,7 +47,7 @@ static void last_modified_release(struct last_modified *lm)
 	struct last_modified_entry *ent;
 
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
-		clear_bloom_key(&ent->key);
+		bloom_key_clear(&ent->key);
 
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
@@ -77,7 +77,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
 		if (lm->rev.bloom_filter_settings)
-			fill_bloom_key(path, strlen(path), &ent->key,
+			bloom_key_fill(path, strlen(path), &ent->key,
 				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
@@ -138,7 +138,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
-	clear_bloom_key(&ent->key);
+	bloom_key_clear(&ent->key);
 	free(ent);
 }
 
-- 
2.50.1-382-gda22511645


