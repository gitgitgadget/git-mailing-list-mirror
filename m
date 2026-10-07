Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16224A5ED4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382991; cv=none; b=qTkNyxiuu1QKCN8pHV34ymvGlHiEdDx0OUvcpLl8UZuX8fjUJShB94PlC0KSZMHNQ2GRBsA3a7Swk+IG8Wm+RtLRdtSGXIlEOPha3JAE1DheiXeRUselV0D0R2L6ACi5jAvInzCWNTbSCR+Z2r5ksX6d5m1TTPe9cWVhMnPvUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382991; c=relaxed/simple;
	bh=daPuBZxej5Tbwwfw+uX+pdJy2zKISZLcmSbLGDOXpxM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rzZT1RPFCFg4aHKe9VZF7WmmfzZ2rK8WWD8y3Ic8JI/fUPuwpIL6q0aVFmHnE5oIJF8Hyr0k+VaBphzwCaziPJtKwT+95A45ubTpTOffls/5qO2re7eOmt02kBMd57jon8isGeWqMu5Si2VnSHG3Rjh/yzIt9DG+4Hap1IlWCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrFe6cQ6; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrFe6cQ6"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91957ec41e1so26622376d6.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791382985; x=1791987785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mt61OoTv8AC0hKQRW1/JUbxzcBWeExNkI2Fl80rCR4w=;
        b=qrFe6cQ6qUS/sYSE91GHH5LAB8VMe/clE7cyFBjmKucqyQWqywg35aorA0tVWC+NXq
         18nEiJaa/TgNgE8D2vrepyeD7g5XIB2HhtTf2xO/RvFHJR7f9fBdzJELrDj1dpse0sI8
         GGw6aGHs0wnHJkvCKQu0nhFoxkTHzQW5o1xHTC2iMW7g6WeeUlMP0/QwBfyBJBMjI4hS
         0VKSVw01BDtVA8GtdX/RSAZpL8pF3Sfl6cmT1DgoPtDUTSbymlqJXn8LcJ82MncyjJpt
         LcmPhcM74B4Zsn/Pwf4XV6YQEIzPuM76iPWXjC6rROt6Vyx5Fa/98D6Dj91EgpHpUGbg
         TLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382985; x=1791987785;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mt61OoTv8AC0hKQRW1/JUbxzcBWeExNkI2Fl80rCR4w=;
        b=o0ywJfbpM2kKC0hXCwP843TAUP/DgfkI3CyckINv27Rp7b3Prpnj0jEEbVmexXkKNU
         YHlM4N3UWhc/WpDtD8muOapO/vvmHr4cUVnk88NT8xSrg/brI3DZsUguT0NeWAcOOcFw
         XPkoFtDhWBYTMMTIeN5+daVA1p6hYLcDyzTZLVqBa8FVRKsdBNeP2bW8cQHHntP5On99
         MBWChFnJWjoVkFJhKHrqAA2SFr68CkqZSIwg2eJjmvBkDioWHhYk7lITXBXOu9RGCTGg
         eYSLebPynoKBR8Hz3JfScyIGNw39XNzivHV32J/VSzmXTsTilbGGYHbxAVeZledtcKBU
         qUWQ==
X-Gm-Message-State: AFuF++nrcALbPMZA92M6JZiWxOHvr1z2k3/v48dlyljLjVm8mxj82PVj
	6W1WPZBkWCLVdh3L2lGIh13EKBnKdteIjLxd2c9q1YcXFB7I/12C4+41FlVG3g==
X-Gm-Gg: AYBFou2+HCMM7RkYuY5k5UeSAuQ3ldY1hjB2PDNcI3PAUfdHgMqmQXxP/VluncyjPb3
	33xMGRoujNZN8NhBUhB8x0GAs22ghXBb909pT3X5decOIRlxCd06cTK8l2qSjgYXGzjHSax4Z3N
	gULchIDdNbXeUzHzHCKlqs/W58si1uSn4iJ5RYDTFVnT4bvQEmmLJkgkxA3koeLQQqe94feCsUY
	8sbXZ7B3EfIVZ2YOAEuXqQdbZKJgc7xrsOK1v427o/v1AaK2LDmhgds5CPmoJEbWwjzQ2SFovsB
	iipwDWA7AaTbdxGXb5kp83kcgMPeG0ZvotdMJQVBbJlviYYEH8P9agrimQAmUSs0c6jMj3NE5IL
	KlybeaD2b2Yb65XQTBbe6m5G5ND9YxSQuwnlUO8c5L8YeEtZY+pdiZrtfZQo2+OfMUk5HxAPm+d
	k9RDHP5ytZFxLhAWbIwq8cyT5IZ6+XbjimPmVwYnDGtbPJ2a0xkveuv+norTGfXstBzT9RHOwY
X-Received: by 2002:a05:6214:2684:b0:919:860d:3df9 with SMTP id 6a1803df08f44-919977d2c2dmr46543176d6.16.1791382983794;
        Wed, 07 Oct 2026 07:23:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996d2146fsm21514206d6.28.2026.10.07.07.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:23:02 -0700 (PDT)
Message-Id: <36cc3ff3b329375d9d87d7ffbaf33b019f91b4b0.1791382977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.v3.git.1791382977.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
	<pull.2239.v3.git.1791382977.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 14:22:56 +0000
Subject: [PATCH v3 1/2] test-tool read-graph: add commit-info subcommand
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The test infrastructure has no way to check whether a specific commit
is present in the commit-graph, making it hard to verify graph state
after operations like fetch.

Add a "commit-info" subcommand to test-tool read-graph that queries
whether specific commits are present in the commit-graph and prints
their generation numbers.  Returns 1 if any commit is not found.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/helper/test-read-graph.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9f07b9c25a..0ab9cf8f2b 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -2,6 +2,9 @@
 
 #include "test-tool.h"
 #include "commit-graph.h"
+#include "commit.h"
+#include "hex.h"
+#include "object-name.h"
 #include "repository.h"
 #include "odb.h"
 #include "bloom.h"
@@ -91,7 +94,25 @@ int cmd__read_graph(int argc, const char **argv)
 		dump_graph_info(graph);
 	else if (!strcmp(argv[1], "bloom-filters"))
 		dump_graph_bloom_filters(graph);
-	else {
+	else if (!strcmp(argv[1], "commit-info")) {
+		int i;
+		for (i = 2; i < argc; i++) {
+			struct object_id oid;
+			struct commit *c;
+
+			if (repo_get_oid(the_repository, argv[i], &oid))
+				die("not a valid object name: '%s'", argv[i]);
+			c = lookup_commit_in_graph(the_repository, &oid);
+			if (!c) {
+				fprintf(stderr, "%s: not in graph\n", argv[i]);
+				ret = 1;
+				continue;
+			}
+			printf("%s generation %"PRIuMAX"\n",
+			       oid_to_hex(&oid),
+			       (uintmax_t)commit_graph_generation(c));
+		}
+	} else {
 		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
 		ret = 1;
 	}
-- 
gitgitgadget

