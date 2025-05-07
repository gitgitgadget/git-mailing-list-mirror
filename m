Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A38202F6D
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602510; cv=none; b=cAd9XIW9D92UlpDbUuOj3pmD2sY6q5BfoO3mpguIZSmO7sRHUQlm6REksT+aY7Fk78Mc0URN9dE2Crmv/NU10+cj+K9/T8kHXxfC/+qsXvN/WoNbHUjsE2ryP39jRCJDtBzWhdtG32tLYzb8NcPbssFSKt8XLIWbFOnr6RccuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602510; c=relaxed/simple;
	bh=jpQaS8vmaXgS5FItQCJBwF3Ib39zuAgCX9cftUxrSXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHIFhaQI29vFK0DcbLMvpvXrm9yVIXlMuoD35X28LDa1eqZ/2N24gS8ImahIfQs4YKYCo0dl+lJzIxHCZ8HSMF3d3pgrgBxxomLzmGnyNS+vVoICCFUZisuVV6AUDvTCcWjQtBwv3vy//P0VYIJJ3Vv+Vh7TqD+a2h0MZ5GO+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zzq4CWKf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gzj2avPW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zzq4CWKf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gzj2avPW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BBE1311400FF;
	Wed,  7 May 2025 03:21:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 May 2025 03:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602507;
	 x=1746688907; bh=el3zysiXZDQoyG5mKkI718guaOuVSM+4FB5y4ahs0FU=; b=
	Zzq4CWKfqmqOu+bSI91KRjj6DP9A9S2VhsKqig6ibyWpvnhIGMCZ8zSsU3xAnz0P
	ZW0PVT76FqRtsmlc7qx7v/wmrtNte/DDFQ9JMUEf5s1oG65+QQKucDQOD6shDOtj
	geidq/d7IriPdoutJ5MpGiYkxbX6EZ8VFWkEO9WFdLiFZQUoGFhMv1wlYTcN1EBk
	BpWUMQdz7KuYHCLI6kZX0wMriUkLidGmvl6dS5ROnCvyvLhJ/v9o4PLtX/ozOycf
	OjIlw7clBi0RB6r7aXWwmWUyxMDFgFLGjatF8okxw2NKwP3GK/gIwRIGnrS0FuBc
	A2j4FveCH5a9c01oXVDziw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602507; x=
	1746688907; bh=el3zysiXZDQoyG5mKkI718guaOuVSM+4FB5y4ahs0FU=; b=G
	zj2avPW7K5Qlw00TUIwM+BeG4Aze8Hla2/vkFQzXmiNToNRImGFMcEg132B689bv
	LhzU3HFdeOh8ikItxJg/wWIxOow2KBOW5gH5D/vE1kdSjoh2PHEfyFr1ZsfCvsrS
	wfNIbfnaewecjDusGzwuWzrjJW66K6zP668SaslupqeSaD/d3/YOIpPZTBU/u5Z8
	AvGGXHwsiQxpWp521Q8KKaKBj1FJVVm5Hn6n7a4ZUE6d5QjDNz0k5T8g/PJXWRD0
	QTRGmrfz6Re9ROz5kJOuubyDlSSfZRRAwyE07kIHqYt3qlUghpPzoQHT5xNg1xeP
	T8RStEe99sh1yl+bc/hXQ==
X-ME-Sender: <xms:CwobaMk7SJ4PFuWTYcvRQkOycLigDQp3KOzr0o9r5qmx74hJ1fbG_g>
    <xme:CwobaL0muv2zEj9Y9Yig-1KsXoMSN1kS1FFebVs0T4jIKqiIF0SDt6qWQt1C8HfyN
    fnJys8jmFP1xsygJw>
X-ME-Received: <xmr:CwobaKqkrNrDXxeRUJEHvjrddUgGLi1HqYQuDQNHwXSqhrrCfdFjCA4VM0njoFc6fUkZIBfGfYaZY-HGS_UrMBvhYjt_sx4x3uxGl5x4uY6QYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrgh
X-ME-Proxy: <xmx:CwobaIlEDrWC9mJ3Ys1K03Y6f3b2VliDbTBPAR5KY_WmB6xYToxj2g>
    <xmx:CwobaK0INiFu8rUPwYpu1LGCWsIoCIjt3LRkEN17DPuqr5nh70HDqQ>
    <xmx:CwobaPu7LzY39vK7JlL3H-gGuuSllIbHjGGQSErNvhXy9Xu1EYrJug>
    <xmx:CwobaGUdOF2XI3trd-lXNZB50fu6cwYz6LLwzIvSFliCm5NsUz2-YQ>
    <xmx:CwobaGYm0c91F2voxKhqi2UmFzT_4A0GlhSgu7M1FLrTz5ryqbeSnThW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4993ad4a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 May 2025 09:21:37 +0200
Subject: [PATCH v5 1/6] builtin/gc: fix indentation of `cmd_gc()`
 parameters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-1-aa5fdfb82891@pks.im>
References: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
In-Reply-To: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The parameters of `cmd_gc()` aren't indented properly. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d5c75be2522..a73ec22fb18 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -724,9 +724,9 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 }
 
 int cmd_gc(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	int aggressive = 0;
 	int quiet = 0;

-- 
2.49.0.1045.g170613ef41.dirty

