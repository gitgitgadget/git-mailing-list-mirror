Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05C22B64E
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803284; cv=none; b=lMZjx4JUV0olCnZAZ7NCMf0u0fFveqU/z4PY29x9g12/IijJeoJGbf5LxkAYX1H7h0CUaig6xak7bOBzMKMH1pSTIZZpEEGGNmKYzR56odOaee4tMY9c/X8NGiVA+c2SUNWeZgjk8+D6Mx4FFK4s3h711aUkHQQdh+s2sBVAqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803284; c=relaxed/simple;
	bh=wme0/2v+9SxetocemfimWhgAYlPFLXOfODm9bK2QzE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG0ehKHp4GMUuiqXqWZunhXDoarkO8tJ3ZYZK/Db45xEQq/v4a/K+MgapRew2PMYh2F3dXjpsS+zBZmoY7o85LFrU5D4LZbTeGtYHWxkD0lAqVcyhrxqwd8FeKFkTjT5Y3cIM4MmhP6MK7iey+zA1tRsw+7kLlrRW/hpDcuWQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSs1onS8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSs1onS8"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbce8d830dso8732036d6.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803281; x=1730408081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GZvsL+XbLe8xiJ2w+vtlhDVwFqQp16RXVGjAYOjvQs=;
        b=QSs1onS8ZhTcFTbqupsQUnlqSxGopdKPaHFZ/2uJyGUfw9NhUWEz6mSyC0fqR5808B
         3N7DUN9AQa9yJH2Znpjij+KZW0fB/cvG/qH+yEsdJOu0uOzDVbxI+/KZHI05lMAlYVLP
         M/1zevDT6JZzrwUceLNNkVI3otwqeqH5DnItqq1cuqO9gw3LWemnVLlZZmyi+zqWtxKG
         PuITyCPuDk+ltwMtNhaaFDcSu1tO56Kzzqu6rbFxo11ObJ5AQ8iObJ5Rv9jdG6H//9tL
         ae1l55w/3kTN3hAm2c5oLEe47k0LTWk6ffQdTosO7RQbsRWLzLoAbCcPjAZtqcoRtNPC
         OAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803281; x=1730408081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GZvsL+XbLe8xiJ2w+vtlhDVwFqQp16RXVGjAYOjvQs=;
        b=GnZQp79C3HZiLAUruzBe9Iy9WGrJVDNQBFtHBGYLW6yDA5a/2onlrdm9FILXajHBNq
         hM+Redd89E0T4i9RJV7fxPJqT304rIdEwrvFnRm/ezyWFfguHLg+6LWbdOAOe23HyYkn
         4qkQEhhqE7TRrj0F041vIujM2gu0m3vpe/+bqIhYX1FjgR5jnZ/Xu8YH6NhNZ17sDmJI
         PIJS0Om+y76v3LuBQeLFLY7ECavR9oCj6Q4meHnCor+Hs53iIO5Gb7zZmX5wq7urFI/c
         oHdaSIB39+g8wIv+mlEV2m6EaR8oRr8V3rOQZBWWWl2BZGOATd7ILagmgNWAjFPw22sC
         5cfA==
X-Gm-Message-State: AOJu0Yw4wcqDct1816pv8UAGoRmAVyQ1gz4rcSt9YQYzXOYZktSBjrIT
	bYC0j4E4/wqbT+2yrI9P5hNgZhzlW4VWyOn21PHt4vJh49FSxHF3fMriDCsy
X-Google-Smtp-Source: AGHT+IHNjz+aj6ySzC4XcBLhOSr7Rhi+crl44bkdQLgLGXNC7fsoe909J9UiL3MuBUh3ivlvWR3/KQ==
X-Received: by 2002:a05:6214:2dc6:b0:6cc:1dd9:296 with SMTP id 6a1803df08f44-6ce33f3af22mr99605106d6.0.1729803281187;
        Thu, 24 Oct 2024 13:54:41 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:40 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 2/6] fetch-pack: move fetch initialization
Date: Thu, 24 Oct 2024 16:53:55 -0400
Message-ID: <20241024205359.16376-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized
in FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 756fb83f89..800505f25f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1700,18 +1700,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-- 
2.47.0

