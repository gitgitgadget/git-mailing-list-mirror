Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20F4F8A7
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442961; cv=none; b=c4AW6/O8ZlKo9s7gzZvUqk8QuF1AOTNKFw2mo1wVUcRqQ9g2335FB1Qy5nfic7cd9cPHrgypRY/3/imLGkTFK9AycKzN+u0Guv9n76pBoJ2FlN3kxaXhciRAeQqB73MeFs7Q5b1YbN7gtPcMF2IafCGfGr+UZI/jylqNOIycyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442961; c=relaxed/simple;
	bh=pEpS4Rn067IMFD2s2tXqVUBCSYLetWEeeZQ0YE4wDxU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=be/kES8ulWIyJzD4trtAHlhXIYS1S48ef/ZOa0UkpjJwh912MnElSG85dIisYhsHniEJ0uRobz9T/txC7uTTdAkGLuOkFoWpChyPEc+PhJxWp4kznph5Bmb2yP1S8SRdornhte0jG61BDq2akMvqy/x2l0WPGY7qmlLB9le29wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bkM8f1yh; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bkM8f1yh"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b8e5d64a4bso1610446e0c.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442958; x=1706047758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OxaNJKgh9AvJM4IHM+UXdjTCzNWCqQ7vVaDczEpOVQ=;
        b=bkM8f1yhqZlpAngsMRK8OjUD22Mxg6SjIBT3cbZbHe8vJvxvUoaJbV4ckrNuHEbk3P
         QXo5kBvIUvsnOzl7UHuCYivQTTp3q2eqvC1y/D1tqcG+xi55B2CwQzM1lYAJSWYUWgMI
         AABohDh4knN/6GoyKpPhjE+xFUHL73VJgzFjGwasqgDPw0isQxv3E+PiLrSln4i2l6B6
         YYJ9LQ1JN8CN8nf9z5855PiIrksdu86OKfM4gCHWs9aJhlNUaNX2uRvdWCStP8ZXUORC
         2Y3uTdY9PejG52G2ZmodvGyD1CVg30LoK+9furg6kLZ5sLzGdkmwYrD/S+QY0MkMA4UN
         nFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442958; x=1706047758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OxaNJKgh9AvJM4IHM+UXdjTCzNWCqQ7vVaDczEpOVQ=;
        b=p8qxLOxzjjdoiyla9OjqOJ+VeAorr5Fi7z3MkIsKZrSEoekRgXfr4HrxzWkvbWwCy5
         wlpJ0OpqOF4YHQ5zpMloy1LjOKKZ9Y/T3CWxQSnx+DT4jU9dFEa2hId1hjh66/ZbtmYe
         hYrj3P45lW8PkRlOifhhK2vSUMODf1qjgn4uyVjgmVgD68fZzOMKD/wFzpZX/hwuqLWD
         numQHyMqgjR0JXg7zGYA4h96BdlB85Ym9CddeBiB9ezfZYbRXuuwQGwrZC8RKwgwCTt3
         2UmI9RvJ4VnzWCqHt6+C8IEDYv57eHXsbyWwP80ZcCoTwhCMZqOuhaP8NI6cpuYqS4Mc
         vFGg==
X-Gm-Message-State: AOJu0Yzl12c30uS8f/GXTPi4zCGTZUnExdre1qUuPJg2jBKvmpIPQqFH
	ViLyDNqeoqJeex4JWDwf9BHdWn3km/7IMLK4w0z2Mre85cyo2w==
X-Google-Smtp-Source: AGHT+IGnqaaFV4qs8aMwOOpfZxviKM2yVeW6PjOSS9vLIZvF0TgENfYsoN+cLYsSz1fiuupNUnBcSg==
X-Received: by 2002:a05:6122:1827:b0:4b6:e6e1:49b3 with SMTP id ay39-20020a056122182700b004b6e6e149b3mr4026357vkb.17.1705442958349;
        Tue, 16 Jan 2024 14:09:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u4-20020a0ced24000000b00680ec916840sm4537246qvq.118.2024.01.16.14.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:18 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 05/17] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <1fc8d2828d8a40ce04cea646b43d03871b6a224b.1705442923.git.me@ttaylorr.com>
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

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..3375392f6c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -5,20 +5,8 @@
 #include "bloom.h"
 #include "setup.h"
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_info(struct commit_graph *graph)
 {
-	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
-
-	setup_git_directory();
-	odb = the_repository->objects->odb;
-
-	prepare_repo_settings(the_repository);
-
-	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
@@ -57,6 +45,23 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	if (graph->topo_levels)
 		printf(" topo_levels");
 	printf("\n");
+}
+
+int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+{
+	struct commit_graph *graph = NULL;
+	struct object_directory *odb;
+
+	setup_git_directory();
+	odb = the_repository->objects->odb;
+
+	prepare_repo_settings(the_repository);
+
+	graph = read_commit_graph_one(the_repository, odb);
+	if (!graph)
+		return 1;
+
+	dump_graph_info(graph);
 
 	UNLEAK(graph);
 
-- 
2.43.0.334.gd4dbce1db5.dirty

