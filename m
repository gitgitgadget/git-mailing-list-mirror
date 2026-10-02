Received: from mail-qv2-f40.google.com (mail-qv2-f40.google.com [74.125.230.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBC451071
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930024; cv=none; b=m+klV9so8I4POpWjphfs6fXBULc20xDcZ1Kk3E7dBAoPvodisDRBWKSZTlvFDO4pfh+mHxUspv+BP6JrD7kt3BfzstX539LkUtvgQuBeFzPs2wPaIryL/WOt68+havgaYMZqrb1DH9EhYZHDfv7mTuySrYRUjejPLA9WEVDJV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930024; c=relaxed/simple;
	bh=daPuBZxej5Tbwwfw+uX+pdJy2zKISZLcmSbLGDOXpxM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YJFMcjYpUzRwkEy1oSn+/5WCx36M9Kj2QS9ziNllYy31MrwtZBIfIJbwE2iGI1SU+HI++1Y5L/L+XM848bCA4IDt1u6CPU0cuxpuWcM55IGyCLBu6D5t9hiQB5hly/h9URTy9lQgZh4GaDyzfH1jUy/XIdVOeQF5kXpAZILM0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTbvEHy6; arc=none smtp.client-ip=74.125.230.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTbvEHy6"
Received: by mail-qv2-f40.google.com with SMTP id 6a1803df08f44-917a3545923so25361806d6.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790930021; x=1791534821; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mt61OoTv8AC0hKQRW1/JUbxzcBWeExNkI2Fl80rCR4w=;
        b=bTbvEHy6qYBO+9mVQD+h+gSaDi6ggZedGdhpDj4EeE9bENDPSZHxPYTtnqHVtPe0eT
         69e1SScMdqDsJQlQigYNa/+7FN7bPGEQ2l8gb5TFxZqjBnap7r4QemdDY1QJSbPR15kt
         0HAE55Ta0k1k/rmBe61345hAZVkzMLKgvQT0jS+aVqQ/CPxJGqm/cUAAAnQ01kfCoi71
         E+sWTq25MOg5so05NWLgxG1+2J64q6WZgG7axcEoHXW1ZQ2u/KvILRo3DTI2LvodD/ZT
         2mEg8w+1N2woR0RHcWGR1jx2n8nUY9yPNr5wL0NzTrnG320r2GznEaPjx2l5Qh0tiZwj
         Jr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790930021; x=1791534821;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mt61OoTv8AC0hKQRW1/JUbxzcBWeExNkI2Fl80rCR4w=;
        b=v9JGFHJNT+K/2YQIf1BbUHNV44lRiIsLFfPHBx+61ndcGtO6uDTwB9w9Lhj7t0Ti9c
         K6zVMbss2d+u5g5XXQrc+PkKAjzSgMTQM1ZkTzbVeDm/gS0D6siuZmtXxrkdVx34ApQ5
         i3id+cy/QNU+7HDf8xciqXAoYx3xBkbMx3iLzjjAzhis/vadmkiXQ/y6mRJJQVUyHAYv
         ex2BzfHH2ArF0c83I3QMmF3xTmWeYEN7E62PTk/SCzq1j2zalZwXMUdJAENFFC82kdgY
         HIPmPzBLiXy29kwx7xQ8I9GM3DNCQcuAZhFaMFi17pZwaovMdRpqLaRPG8aRGrtq7MYr
         qlGQ==
X-Gm-Message-State: AFq9FYIC4ejjZTkAObAuOE9TALUta6b8VoFEOS3wLFkdcrorL5m/HD+6
	acEzAQyCk2qF2giHd5IpVVtvf9JkJuaMnnHoQT4qwXMfGeAEP5MBEV6PAWcvoM4b
X-Gm-Gg: AYBFou1oR0ol+E1lJBhvc7aFLc9c9ir3VK2a6toI7hIvCshYJdiM0ODMfThRFEG/m5S
	FvRMKXgHutkqc8k4J8CkiqYl+0vfZuATJMvo0WhDMPWLZnmtb5uDLJCAQy0fPPnsemnZCVuFKdN
	BBIi/ct5ilz0hQ4jswYp3icG6RSDNuBKAis2I3tv1GvKJ3nxsYsJN8VmAVRk5P0N3Apo2UTzuDl
	9xeHvgBKAFrjww8MuZX87hRUPexGou6TbossohmO2xx9jOuJetYeyVBnmTT7SjHRQP+XfovQVdq
	12xuBG/FWzgLDKfXE1Brh80MR5/vi5XKCKYtqMdtBx97TO4SZqsOb/Qvcb8sGorcfdXQzkchZaY
	M8ZKdzdBjOKgnVeVrRNzpg9TqyouDZnmvq2eV+bG3EErVA0demrlxdi6OC/+J2IMDi940j5/MiE
	ajyQsTYQ4d/4fC/G/f5LPTVf//2+WKoh9sadVkwFMnpFWmXKwQXKxU1qAAGDV9FRvB3Wv2mq1x
X-Received: by 2002:ad4:5fc8:0:b0:917:a1a7:6367 with SMTP id 6a1803df08f44-917bff2b03fmr43108306d6.1.1790930020968;
        Fri, 02 Oct 2026 01:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.159.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b19424sm14634646d6.15.2026.10.02.01.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:33:40 -0700 (PDT)
Message-Id: <36cc3ff3b329375d9d87d7ffbaf33b019f91b4b0.1790930019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 08:33:37 +0000
Subject: [PATCH 1/2] test-tool read-graph: add commit-info subcommand
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

