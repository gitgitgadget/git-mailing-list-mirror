Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977A23099D
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820934; cv=none; b=Csye0h+iHC8Hh2q6VC34zVhli9fIAuQ8jTZWJ4+FtvC7hXv7bagh4F0jKBkxEMldpXZyuTSDPX2ChG8GUN+2uxiY2qLzuKtcqrIdRyd6WS7+Pwweu56vFj1Tkp7CunRcG0vhT791RFKtggmd2mg4Hl7C9ThQ/pq1pv16LC/3NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820934; c=relaxed/simple;
	bh=oy+iaXiMmM84hDo7DxxaWhndetO6EGObYaamJNh+o9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjfQsMiPYmTwMdrCDPVUN8/U/0yswTMhsoVmvlcKkGOr3J1gN5hYA7D5h7H98GNIG0mix8DcxzfOntFJgmaf6UMQGa2m0/4QQJA+dNFocWHDveyL05TfnpWNU0qsRBazEPr55suEW4uW990Vce0BBU/sb3sRRCTlbR+8mGpLMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH6ygbDv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH6ygbDv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be49f6b331so12806485a.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820931; x=1737425731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wcwduh7LRa4FEws+DIm/+UbfjxIpsiyJp4QGheW+KI4=;
        b=GH6ygbDvKEJC2CArpG0eP0UyGmmL1dX8E8Jr+BxoqvQ+q/3+iUUBBJaM31KjuXigW3
         bXapMHh2IUNjZdKakx3Pnb1XEppGYtIoBgRweEmcbHbiUdl9b/5ulku+88ydvnr94enj
         FKOy9CU3VvkGDshSMfMOZuFBAA3rSPxAgdScHsMkj2pGmkB4YrjSHQ4qv5pzqYcYYCu9
         Az4aaKFrpZIl5V0g1D06STDY+AExjZ+x7F/+CdN0cZZcQbI7o/i3QCwYV6T8Uib0NQfr
         ckvg0LzeCTPt1co0TEE+16w+0TMzzJGxRmYSvdBtq9MzjRtixRmjwmqifJn+NOtUcq9P
         EvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820931; x=1737425731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wcwduh7LRa4FEws+DIm/+UbfjxIpsiyJp4QGheW+KI4=;
        b=YPF7HfmbWy8FTk4+gOtRx0St8DX1BHCmtwpZj3lpzalJpb5iNxaEeDkxG/QfHDlTGE
         JEuYlugLTVcwV/eJaSkldyOIsgoKLkXgRn5QeFzTsLpXjSOkuL90nRqw53O3kYsWCpiM
         ewyMKhObzXAsWeDjxz3dpPHiZ3q6Ib9avxNSRE1J4ZJC6BF4B6UM7tK6W7KQb7dTzOq/
         JZDgTB/uhhE8uRSrM7CVxRH8VaKuZJMeAfcf9KilIGh+aXWH2uH9h03TyAWfqE+HePjc
         x2d9I4lcS4UdKXnGRgw7oFVl+OZiToxj2mZehp5s9J61Uc8MjksTr6CL4LievHjmFP6w
         mhZA==
X-Gm-Message-State: AOJu0YzSdLpaU1Kf0DppZo5i/ZwMCnQyW75tTyzmvEEdViJ16G7T5+MG
	2fnWL31Xb0CitQ58EQiV92JWn9/ecAzvySSQ1bZJSO9mfBwMa7jCCJw8+Sfq4GI=
X-Gm-Gg: ASbGncu9OIyZ7wujBHLMrCASBxmydGYdQElrdED/yQdbVvRos97HOBf0W+n/cviMxSI
	MI+6CPRz4YIC4JHDiQymoDTSFv5R6xTrmivzesccpiKSIXtLND+jgdtfyFZQvAn0KgHMnY0XfEq
	o5a28Aiwy/xxkcecuitc21hr3/FN6tfy6BlwOJIM2xKU6w8HwsLIi3M+2P1N1/gLauWYrSpp62l
	+5J57ef8yd7goeNfU+ARwpEsepCJ08gqWdv0q9rYbVR6o5brhMN481GfFZlybPYLFqGnhYyMre+
	EgHxurU=
X-Google-Smtp-Source: AGHT+IHc8Njc30/EFpbbc8t5824J3FTWQMROSOWTP1/T/hEpQpx937EFFomtWD/pKEFffd5eWZUbBg==
X-Received: by 2002:a05:620a:2444:b0:7b6:d8aa:7ef8 with SMTP id af79cd13be357-7bcd979e1eamr3123553585a.37.1736820931015;
        Mon, 13 Jan 2025 18:15:31 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:30 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 5/8] fetch-pack: move fetch initialization
Date: Mon, 13 Jan 2025 21:14:57 -0500
Message-ID: <20250114021502.41499-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114021502.41499-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
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
2.47.1

