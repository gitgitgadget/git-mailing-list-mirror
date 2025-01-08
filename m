Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42258202C50
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361485; cv=none; b=KxphfuK9H7gBCR0DUzKGknTvaYuCCvbaBPB6TgQiTTLt0IpWtQPw1Sml82fst2sY71tbh7926J13QrW51+dm4Ys9JWQAceIbBzF2cMjZe0PWXcY9kWeCQHHd5bJ1je51hwbBdfznNBPrZ0lQafNgoiwlINSf5pThVCHrywT8SgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361485; c=relaxed/simple;
	bh=6v6kmj6IoJTTVenBvDN0ySpPKhvA1nmYwnT31qsuLH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQCWWVOfLJNo426QgHSGrcoNorpYpRkvYsQJ7kDlEP015CLAg703eaEj9Z4LywCid9T3W63KfOoz1j9p3VAB6Z8RiAfLm82JligNIA6Xb1nOES+Zxg3m+odtLRlHC/ZVbm5XFM9v/D+T2Byy3RNykdhfPp4InhoVjhMkViOjTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiDTg47+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiDTg47+"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so1477216d6.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361482; x=1736966282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuvuFUMBdM9FyTWZ9IdBTNsQLl3Xz4xTvWGs2nwwYrg=;
        b=CiDTg47+/ZTE45GQiqrM8TB2I70gCl1AHLuc3E0IfjLtIu+F9HKAqXr8zsn7k4bILw
         qBZLzfdlHW6BppCza80eYshDyGefQgMJqinE762cd3Kmk3OSvmZWiCeYUbAXbjcj4OA+
         Xl6ijPd9On7Fn+4HypQmRf1ADZ3hSfpMRZMWieOVBUTwEkaE2sk/RmEDc7CUUQ2Ia//F
         LfwJaWBLfQqTzF6Mf0adbxESDGJKqbcS63CUrnZ+3s8n3yMb57cDdKfpFLOg7eUg81ow
         V1zxgOsMNDZv9FCrMrImf/aBdcr+hSpExoA2KGRzC9iPcGaJfux4mDVImY9k3w5TPLUx
         tf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361482; x=1736966282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuvuFUMBdM9FyTWZ9IdBTNsQLl3Xz4xTvWGs2nwwYrg=;
        b=BEGsducB5eJnmM3g222eMBZBPLW7Qnk+MHQ298MCsj7RZyoXz3+E9DeVqiCQJFJufo
         jeNwLVA++pi+oiNcDyc7cApUA/oHHWrmh3U9vgjgoSlmZPJLdDF8FmX0CMlEbs+5LMsl
         E0z4q8kjn3fSdWOLanROJ0lTRJZfdS9nAVPhsddxkofKXRRdiLNyA6oDA3PGNaxNjnDd
         JXWrow7uUawoivsyIa3cQIcJFg48Uwqzhh3ED2AhEj6WEe/gLUUlgstOPsx1hhfKsSob
         GML7vDPgsrVmR2LIeTI7210BeAMunCFy0WQB+ZMHNPEhuDTDtszV5aefc95gKv2h/Bzj
         EV0w==
X-Gm-Message-State: AOJu0Yyj2irsxeAHey2JboKMeZhczHu0gvRWre6uJQwsjqyIzal/74jC
	phT+RUspiAbBlUEPHx/QVOrS3UOEjVJ4ZSJUBktqo3CQD/vbCB6jCu9KmLfnqJk=
X-Gm-Gg: ASbGncvo2UqvBGbySnqYDWuuYnKMJZ0l3qIj50DjcE9GsXhTLDJ7k9E16FNF+dTpICq
	N2eQ5JCimals+CNb6RR8bfUxKXKdSEahnCeLTYI+p3j2MpHzsQ3e2093dVQtCCXeE1upZXmEsgc
	UAprIdQCyjESz9GdAYfMq+ZX5ZbWGtHqQMjOLSgvGeesRA6tp1INd/wu0aZiihsF02JuF7Lo1sj
	4uqvb1yX7JpMWtP8XLJaUiqwSYW1eQzsn+rC8ZZhoqk8SUEjohDO7T1EVP6UMKaX0tKJrAZYtJY
	rwU0Pvj4jA==
X-Google-Smtp-Source: AGHT+IG3TmdGZzGCuFHkQ7HzE6WQjyJsYG80HF4GGjKL1g8ImxxxjrQLu0KlTxRoFLJJPg2xh7TH/A==
X-Received: by 2002:a05:6214:4903:b0:6d8:8e27:5a45 with SMTP id 6a1803df08f44-6df9b2ddc3cmr71416526d6.39.1736361482150;
        Wed, 08 Jan 2025 10:38:02 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.38.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:38:01 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 5/8] fetch-pack: move fetch initialization
Date: Wed,  8 Jan 2025 13:37:36 -0500
Message-ID: <20250108183740.67022-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
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
index 78e7d38c47..51de82e414 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1648,18 +1648,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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

