Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE7135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337182; cv=none; b=PwWDzm/1gYm6ESZXHouB/0MXhKu4eOKS5yKrvQdyxIhQVPTGpusRVjL5+C3YHlqh5gQV+rzbn4JO86se5hUMA/Ho3OIvRFy3qG/2rYMqySdBZBCHigQZFIbrWem5VO97Z6upGahliaMbVFI+pvYnVqwLgymwytRUcI5Nu6milOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337182; c=relaxed/simple;
	bh=+3EpfMtQkIkpOp8Ehg03cv+DcM5OgbcBEWSRDjl9VSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaMbqKnCoxygvH/wndCDBE+yEViMvzl5BoJjQts3FcD1lJYbwmh/iMNOK+t3XCTmWo66yzu5cqdm5F6FJkU+SIOprkshFOqMbgBVy/xt9DXppGn5wRM00CjXyJiJSFLcuHvJ3DNRRThcJM+G/N4jsPcECQK4zpb4s3GTKvS1ySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=h6HyTKiC; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="h6HyTKiC"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d55e2e0327so284714b6e.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337179; x=1719941979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kLqU5sGy/a1eA9Od+3sZKP2rDOvtSyQ5DTW/Kis1VA=;
        b=h6HyTKiCGHkSjB3oXMSREbLh6QAxfGdBFCxXr+HcWGuRa0rUF2catpgLdwJcvATYkE
         RFtolH0rTreiWfyESgCtev25KrBo4kN4wKc7DcDAlDnO2QmkrshTwvnG3YBwCY5Tb36W
         nABFvzecsRTETxh3qcCrxR/C+HkWsS3jyeyh+aT4x68bQEm80ZNHlG1zGU0oYrAuxtvJ
         JzVhmtafjWhMmqe+3xkcxc+3DxtDe9ywcEYJuQGKHzbQj+/PXWjpt2ZuoaHbPlX3tejY
         jg1970FqvkridL52T6tqB6u8MDNp0H2nVbW2wfuvijNYrFzdWBWdd7uZoROnfgAbxVCr
         8UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337179; x=1719941979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kLqU5sGy/a1eA9Od+3sZKP2rDOvtSyQ5DTW/Kis1VA=;
        b=gYS59XJenik8XR21zkIRRtciKHOOItA0G8uinadu0M+L4fqBRgW5kcPzc2LjDkkzL0
         pRDSeMql/rdBjCW3foZQ68/P+Df6/y37TLXqTMhkUZgqCdeTUxnc9UA1qtMB25OILZuY
         OPBKvgHeHyqgsR5r9BG7wo7wklqohxQ2LBignYHPi+bSk/3eDIrpH8SVr6GcBqMCxGMH
         Juj5eep3twDB7v8XwnF93JSzwH1yzxpze8QZjhWDvlAZIvsGba802niykeJ9KQiZuexd
         gdGhaWdKm6i2qGFzudBnDVIaAjoiuyLyBbb8z/K8L6FQpYEjI87yQpuXOnyIzAwll7s9
         7ONg==
X-Gm-Message-State: AOJu0YzSfLcUb6Bxio6Q4YkzN+VN9B51YiVEx5iwC2wknTtExvChUPNW
	ZmKjSMU61DryrLHM5E7g+hXKX5F32bFBsM8MjOdrIGdAqzfVZzdV8tXN8JHQPSOmNEfGl7jdMAe
	jc/A=
X-Google-Smtp-Source: AGHT+IFl+u9eSt1FR81BHCjMH3t3X370AOHwrLNqjMCUcnHxOSHbm0+7ZbtJXFqMGSGCOgdInwejeg==
X-Received: by 2002:a05:6808:300f:b0:3d2:2721:8a7e with SMTP id 5614622812f47-3d543b1617bmr8912034b6e.34.1719337179437;
        Tue, 25 Jun 2024 10:39:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f6ab41dcsm9530681cf.78.2024.06.25.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 05/16] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <6e7f317551d31ee38bfb2b8abe8268898158b161.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

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
2.45.2.664.g446e6a2b1f

