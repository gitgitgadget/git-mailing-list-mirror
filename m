Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A1155757
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856484; cv=none; b=u08Twr/3yTNwxezg1oL8HiJCC97Y8VF3lrvmC0XTuZ/4USXjXhahfOlYyvE+a14fFMkNg0pnrbFHkzvcVwd4aoY2SGjGsxmpi2oYpkw3RxWaqnC5tWGQjS77tf5Y65hAwfGR5J+dNddTfcVpME0O9Y4ZIlfvNZNsfNMV1V4IabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856484; c=relaxed/simple;
	bh=oiXpF0oxkOeOXKH6gQ/+Yg9fbS5qQDDRxFxeA/8XdKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aExF+FMuIscUqYTAXBWN5uHkGmOQZJbsKwuTp3CNUQD3EIDYWcuM8lLqQwzUPFeSB0//jBaaK6hLwb4pEPIrXZhswCN6KK3fByGlKNumv6+z4Q35QKEIfDb6DPEHURDsB7/UdhHyUpMfJ/uqdBkQLGaykqaE8u9chEPhnUnYiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEcX+Dy9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEcX+Dy9"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb38e86cf2so451741685a.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856482; x=1772461282; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZgU/MahiXqxFGpQQqToNR0ngzTRutVNuYDENpThLSs=;
        b=CEcX+Dy9AqxpuYWEs332RsJ5ysGUMSzv7KEKCX5ArVpSR8ugeutREo5Omi42nqMyc5
         lJrPVcwijnWhuxhWoxEwYY8kk7FJ+q0s0LxIKdkbr/Dm1QvvXJGSpbJKDOY12HlTwlO7
         +Cz8zNMaoV1VNo1V1GCr3FX7J5UbXdC2y9jiVF0IknZ9LVsifbyEmMO1yyzRnE9BqZs0
         RW9mLFznOrQLSH4Y2XweiZd9Cw9GnJkB31HwBG9U0FzipsUQUvpnDqWa/qix1wu/JnTq
         zuWy7rGIqzOqp03yHZo9eUBgi0v66rV9AHK0ze7Js0F6FYewyw5Cpm+h/WBY1qVgeGMv
         oEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856482; x=1772461282;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZgU/MahiXqxFGpQQqToNR0ngzTRutVNuYDENpThLSs=;
        b=wS3va0jgob1yr20PdTYaO4rBypflszh8Wao4Vwc3rK4ydWvaZA9K6I9juScuprYzvV
         og97+nhXZ/stjuUyt+SdPYeqHHfy38UD3cP4p8S3S284EBzU4FcXuqhiIpz5zspp4hj6
         KZP131kfoevO2P6RROrOXt9U0MfwtRjLsawZd5SIBwTayqbwwUlPlZDJGG02FPF87jDK
         EyyKqygDIP49+HHxV7mADLP85x4lD9xLOYyEdFtkSEJjAbxAhni16epoPuihj+XfsgKW
         0lvSaZoHgHA30qEzE9NOBasOpLkHGCtV0mx4CtCic9Z3FKNG3w/mAQE4lvco3gqKq8O8
         qzfw==
X-Gm-Message-State: AOJu0Yyd1jyLZX722sWUEo5EfDq4rCrh7rWjo2LwxuGfwTv2wEEhUvKi
	/w1Mk5eioLqgzKUKKlsDciVxMYBrZU08Nc/Te6YcOeqH74uBNywkmR8YXWITuw6T
X-Gm-Gg: AZuq6aLteBhdHj8DN6bIPMQJeFMWU1yAYzAjpn1UvMgbol0MwciI5x/YXDco7J7Y75b
	af+LoMRGY+iV5wuzz6BNgSPDeTRIkKTuNhEuBBlMI/ssLvqBXesXa1C2btmHxOvCvnycESsWI72
	OtWAqqg0ZNKR2Fumux3hyakgctdpmvMwxHpPZ0MyRw2zjm60IBEumZTfNyaw73YQG2EprgLbP1b
	/2/CDvsEnZwOQQZZbo3+HG3O9fecN9znxcRC0lrdrIo/whA8SGA05AZ265MC1Ys8UC3r/lDARlo
	gi277SP4jWVM1Oos6EPG2HydqdBMPfdZnCBCAwTH6J92uxfrrmu+uuiS/zv/MH48/P2ARYNuw1e
	vk/46LW1CPUm1B5XOVV7vYWu0DtOHPTF34A8dKMINaubVSc5f/5CHdDJx6n5u4vgBo8wtiVJGmt
	Vs+wBj6pEqHYXpyy2kouR8YCniNDz/mMdGXg==
X-Received: by 2002:a05:620a:4505:b0:8c7:1106:1a44 with SMTP id af79cd13be357-8cb8ca92db1mr1105443485a.79.1771856481624;
        Mon, 23 Feb 2026 06:21:21 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c8b52bdsm68485586d6.22.2026.02.23.06.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:17 -0800 (PST)
Message-Id: <1751181950734d2571ef85a419ef62000458bd39.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:06 +0000
Subject: [PATCH v2 6/9] repo: add aggregate structure totals to keyvalue
 output
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Expose aggregate totals alongside per-type values in structure
keyvalue/nul output: total references, total objects, total
inflated size, and total disk size.

These totals remove the need for callers to recompute sums
externally.

Keeping aggregate and per-type values in the same output format
improves script ergonomics.

It also keeps machine-readable output aligned with what table mode
summarizes for humans.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index f92c209469..cb70171412 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -824,9 +824,16 @@ static void stats_table_clear(struct stats_table *table)
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
+	size_t references_count_total = get_total_reference_count(&stats->refs);
+	size_t object_count_total = get_total_object_values(&stats->objects.type_counts);
+	size_t inflated_size_total = get_total_object_values(&stats->objects.inflated_sizes);
+	size_t disk_size_total = get_total_object_values(&stats->objects.disk_sizes);
 	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
 	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
 
+	printf("references.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)references_count_total, value_delim);
+
 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.branches, value_delim);
 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
@@ -836,6 +843,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.others, value_delim);
 
+	printf("objects.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)object_count_total, value_delim);
+
 	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
 	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
@@ -845,6 +855,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
+	printf("objects.inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)inflated_size_total, value_delim);
+
 	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
 	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
@@ -865,6 +878,9 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
 
+	printf("objects.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)disk_size_total, value_delim);
+
 	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)max_disk_size, value_delim);
 	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
-- 
gitgitgadget

