Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851863DDB1F
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700628; cv=none; b=bGDQOPDsqpb4n9Mtm+pgw9YYUTyBOAgjd6eH9GHnGXU1db17l9AvHydpbWDBgAryA5V1Wn5liRrpiRA1mi1Uc0GpJXa5QDDRcxHFkVI0R/YUko3sialOBjQPZ0gJnkhxji1D8Jm2sxRXHsXobC7GSf37Its37jFVAyOpaVlztcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700628; c=relaxed/simple;
	bh=pQYue02gxp0w/p5elZ/VFbmMNDUg6eqW4He5JXBhREs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R9z6YJIY1ms+KdOVXuHQwSraKZYU2Wpzaow3yV1eI9l6699jsEKW3l6dmuNS57CD9LFC/+NZYsEvmX0NWFS9z6tpmF1zo+6C5tEpDzmvZj2dHfkXhEb+SXaFzII55q+kcTEzaHufBpaQUuh1Tm1YpkggqH+cqvq+mFlm30RfRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev8oJwIX; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev8oJwIX"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530de452c33so2453101cf.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700620; x=1790305420; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1O/dMpeoDRusKR1l2LPsc+N+UdB/XZJmDGkSj5BirLY=;
        b=Ev8oJwIXgOc6g4NoRGejvu1YZG0VyW2tVa91D/wZrm7HRh6Xd7ochQMgfdVbCEPLlY
         DZ1zxR3l+KBnifBlzJwBzLiaE47v5xgongpvNebKtBpjcPTPAn4o69OrMGBKStDHfCTg
         G39IyOS2eyfk4rbmhqbEqJoHANn6XXRmUD5WOixCxOl8/s6Kku85504VXSdICC6MqCio
         XD0nBtwYfNhK8YCwboXz/3bTXsUiSz6/JHAJGUD/QdfzF24KVSnYG2e+6HrhlE2fKFNU
         5t52qycLegpcpL7Xsuf4FelDTffHbbe11toL7gVhDbwlgDoacJZLLyqMc+JfKiylQrHQ
         oLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700620; x=1790305420;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1O/dMpeoDRusKR1l2LPsc+N+UdB/XZJmDGkSj5BirLY=;
        b=HOUVWEV/ZEICmRZO556QqB2/clnLJDJBVeTNKs4KdcLRJTjjloDHvD0U0i5Hyppq/7
         BWxTVKrSqfps63FsxibGjlXb4kvfiIo+2lGAYbZWeKZ9WVtRbw+KmEIKapeazp0YR+Rl
         BmRYM2vsB55RdOMROwQhn6qNNnNRW6jGwJ4K8sVKjYcZ8q2EMgGGZzn5pet0poHgVUy+
         islSdTpRqNwB89HIBkISZqzspivyMLAdFvqWisquUwnWecCd4RjAAr3yghHJQVBKtiJN
         8cXpoeC9K81BtJZ+RiRTMIn4vWMBbhdi/ek8tcWYEJ3+2SylvwdzLj8isD6pb5jxNHxd
         HlbA==
X-Gm-Message-State: AFuF++mDRdU8S+ROl6TVYLmQs92iKyT/DerKEzsOhyBmKEH/PYTvHDxV
	7Ykoy/9+Wuoo20vFKk8t92QzPW9ZIVXQgQGQnegjb2NEZJSZKSND5wa6EZkiQQ==
X-Gm-Gg: AYBFou2S4a6h8svzMEVrez9FIEmQyZx8zqDDv2ajlCqFH93HK/IqbixbR4XUPsdJdgD
	fW1eA82FBJkQJjZpgb4ef7uNy5C8wR6Kw3OwS6WQXNboaeHXWTQmrkdqvpKjteZyzzq5t5aTPne
	TA92x9fUi78BchPI9CYVThH4IUYZ2Hc0mo5KaRNhs2WQ8kbyt+b5bvyYos6jAQiHiH8hsvWF+vu
	IOq9s1yPpxFaKamRVTmpuL1f+WjSm4NIYA36drKJLsqedxQBBC94j/K5XjIaY48HvEV3NojLd9H
	bKwSkUsYfowWbkS5G76uT3KFs/YOpDYBuFicpFplwEeewRzkjYMwGIFuZOnzi9sAqG9dBERvGM4
	gCBv4YWQYzN3H+ilPrc+Um6xeKuB4NCVhkDc6Pu6XpJZFKq9nsYg6usGYCtjOI0ikmcl8Gu1LEs
	8BM3rhxJC7vOWuBcijV7j8UdzdP1jOfpFx6eoo3cioEaVGT2Q14YI7OJOcO6uB75t+NE6ysEKb4
	w==
X-Received: by 2002:a05:622a:54b:b0:530:e1b1:eaeb with SMTP id d75a77b69052e-5329e287fc5mr22690101cf.21.1789700620518;
        Thu, 17 Sep 2026 20:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.198.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91258057e41sm2327696d6.34.2026.09.17.20.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:03:40 -0700 (PDT)
Message-Id: <b76e06a4672ed7881fb4ccfd389d5282a6f312b7.1789700616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 03:03:33 +0000
Subject: [PATCH v2 3/5] pack-objects: sort --keep-pack list for lookup
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

add_extra_kept_packs() scans the whole "--keep-pack" list once per
pack in the repository. That is fine for the handful of names it gets
today, but the next commit lets a caller name every kept pack in the
repository, and with thousands of them the scan dominates: matching
20,000 kept packs against 20,000 names takes 11 seconds here, against
under a second with "--honor-pack-keep".

Sort the list once and look each pack up in it. The comparison stays
fspathcmp(), so what matches does not change.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ca8255176..1fcb4ef8a5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5007,7 +5007,7 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
-static void add_extra_kept_packs(const struct string_list *names,
+static void add_extra_kept_packs(struct string_list *names,
 				 enum stdin_packs_mode stdin_packs)
 {
 	struct packed_git *p;
@@ -5015,18 +5015,13 @@ static void add_extra_kept_packs(const struct string_list *names,
 	if (!names->nr)
 		return;
 
-	repo_for_each_pack(the_repository, p) {
-		const char *name = basename(p->pack_name);
-		int i;
+	string_list_sort(names);
 
+	repo_for_each_pack(the_repository, p) {
 		if (!p->pack_local)
 			continue;
 
-		for (i = 0; i < names->nr; i++)
-			if (!fspathcmp(name, names->items[i].string))
-				break;
-
-		if (i < names->nr) {
+		if (string_list_has_string(names, basename(p->pack_name))) {
 			/*
 			 * When following, treat the pack like a "!" pack, not
 			 * a "^" one: nobody said it is closed under
@@ -5151,7 +5146,9 @@ int cmd_pack_objects(int argc,
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
 	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
-	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	struct string_list keep_pack_list = {
+		.cmp = fspathcmp,
+	};
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
-- 
gitgitgadget

