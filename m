Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024C55C03
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442966; cv=none; b=RTGRM3aXDGb29ujYtp89xOAyAjItGcJHR/fGgFK+kPTlv6rRPTEH1c+jvh38tBmBPSAE67noHY3QIGbK87zgQjq4ZIGp2DPZzwj2I4u7gaQQ0iyHziPS0X+trYoCNw6WBn45FpMDiYtpJ4Wt8mY5ImEKl4AOdr4WcSv/jl1HO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442966; c=relaxed/simple;
	bh=0IJrdJHY/qP58apoD2ow6blfL8xVKOwffsUEWgjiEn0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jcFnqK71f/Ok8CJDtU+Lzsa0p/Uy7JlVLO6JUcAcDhq0FQOhBlGTbqfvrzTCVci9lzTugpR/vGeDbRbilZYdHugiluCEUZK81CZkJMG4AtqLDLz2gXBZuMyZ8qZDgzYNPFJZJlAFK7ZYb0GN/8cwNiEHAVfx0nOyXQENsLakOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XNYtvG9n; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XNYtvG9n"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd7477d7a3so1485903b6e.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442964; x=1706047764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBZBG0DIHtLbgIsZDa4P8j7yucGn6D6BmXj75W+N4Kc=;
        b=XNYtvG9nROQIaIdtQkzYb1CXlEuoyc7NqLs1qaw4dHf3xeUbuDYyRisCubu2Pg50Jw
         RqdXMVbREC80vWizlAkRM2DvNB5NoXkUs1uuiNK0lVLo0ukdVkbGBuyqYX3gfQK0u7xE
         bef6lkIFLrUmq4uA7a+RauS/txQ2i2Zg3kkn2wuvGxQ19e3TC+0HZe54AnQPqjCoYJqy
         KA5uVZqQU9YuGWL6Y5YnE4ZPWbEP6LjbDWTuaEWKnBH9QnrwpylsrABlgWpHUUMTvbli
         dB0IAwzm1Rg1K61BwI0OEWmnzm7okDqpYEVjpJFd6m8sM3bcOmPKTs/aF8+Vwr6bTrYw
         JP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442964; x=1706047764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBZBG0DIHtLbgIsZDa4P8j7yucGn6D6BmXj75W+N4Kc=;
        b=XCk5UpP0COZBfOnIjqqllAHFa+uiKN+xKu7YseVaUDvS3qsgIjRYuEw/pmJgJbL2ws
         BndhgfrySm4MybGNsrrejl7vmZ20z4LeXfKdy7mUGMLhO5MziL6IIC4CCj15/OK/rPp7
         Wusvr3eX7D9gYpFadl2JOUavGmPM9y138cfVrxDatBx7Gg32UUcHb+xkQloHPC/rXusJ
         suKmfAFRKVaFQvBdoR+4ZqXw1Xu7zNZSmOaATfkd24NZVUiMHf1L0vUNdOe3DceI2Wdw
         ILYpWFL+oJYEHMelMcLYr4eV7hFT2EowxLqtLjGP3ZSJt4eKurPr2y+lHXewvQGOH9s5
         IIAw==
X-Gm-Message-State: AOJu0YzyVotqBaFMzin+viPJ/oYMwzbkCbRI1Xxa0LqFVpFRARMXNd2/
	M5eZazcfOrzIgSZROTsVspXxAFcgBEr7Pmwi/6OWnJRBMT8KLQ==
X-Google-Smtp-Source: AGHT+IE0iIIcyj4WcuvQ2tpzuFO2/tz+/Fz/zLcFxsJmQmtFiKg7FJet/fOEiZu/6U4eqIWeYsR2jQ==
X-Received: by 2002:a05:6808:654a:b0:3bd:727f:1031 with SMTP id fn10-20020a056808654a00b003bd727f1031mr3812879oib.119.1705442964035;
        Tue, 16 Jan 2024 14:09:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id de28-20020a05620a371c00b00783395ce1d5sm3971188qkb.136.2024.01.16.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:23 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 07/17] t/helper/test-read-graph: implement `bloom-filters`
 mode
Message-ID: <dd9193e404ef7e896d5a7e40788a47d76872b3b9.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 44 +++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 3375392f6c..da9ac8584d 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -47,10 +47,32 @@ static void dump_graph_info(struct commit_graph *graph)
 	printf("\n");
 }
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_bloom_filters(struct commit_graph *graph)
+{
+	uint32_t i;
+
+	for (i = 0; i < graph->num_commits + graph->num_commits_in_base; i++) {
+		struct bloom_filter filter = { 0 };
+		size_t j;
+
+		if (load_bloom_filter_from_graph(graph, &filter, i) < 0) {
+			fprintf(stderr, "missing Bloom filter for graph "
+				"position %"PRIu32"\n", i);
+			continue;
+		}
+
+		for (j = 0; j < filter.len; j++)
+			printf("%02x", filter.data[j]);
+		if (filter.len)
+			printf("\n");
+	}
+}
+
+int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb;
+	int ret = 0;
 
 	setup_git_directory();
 	odb = the_repository->objects->odb;
@@ -58,12 +80,24 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	prepare_repo_settings(the_repository);
 
 	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
+	if (!graph) {
+		ret = 1;
+		goto done;
+	}
 
-	dump_graph_info(graph);
+	if (argc <= 1)
+		dump_graph_info(graph);
+	else if (!strcmp(argv[1], "bloom-filters"))
+		dump_graph_bloom_filters(graph);
+	else {
+		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
+		ret = 1;
+	}
 
+done:
 	UNLEAK(graph);
 
-	return 0;
+	return ret;
 }
+
+
-- 
2.43.0.334.gd4dbce1db5.dirty

