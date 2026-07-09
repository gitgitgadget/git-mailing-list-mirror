Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D2370ADF
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609390; cv=none; b=bTJn+bXDOWOpG3tTicjMxzftl76rV2ZJwhVT2JxHVfTFXz6ebV5CE3o24X2e0IJDYC4MDVZI3mAs/+5oKeiUdvBAs2m4v3btQgqt38RpEpXUdicE4i1+17P3zb5Ao9jE6dyK5CR0g7FlYJboZdIYeegpxf9lk+YYfOAN3ms7bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609390; c=relaxed/simple;
	bh=AUxUlr0F23A791cOb/62pxZ/QfnU2mIbl/TcBRx4RVw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ARafKhkCrTK7iuAz4i8Uk8QOiXJu5s57MS3A04PNQP7rufdvzq1ao2RINhriNYGqjsWI1J0/EWPu8T04ugzoMtXDotMFMEGING8uyqrL42OI8pKyM4hVbq4T5crZP+fC1B/f4oX51VM1NzECfO7PHMO9wDoi+0WjXQGiHqQU20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUjeAH7n; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUjeAH7n"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c9211d2so152567085a.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609388; x=1784214188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CAgUd9Ss0JGVtNtTktw3iPy4qr+CjvIuMq+r3w0MlSo=;
        b=LUjeAH7nbkZ/0mP+UzDcrOWRiw7/jcQ89+hqXih5V/9d2DSlRMHfjXEY7Ip83iAok9
         AxvwdavV/DyNzpWS/CTexiOlHb0AskgFm1l/UhGP7gpu5N6n3VjfJL0V60fkP+H9OH29
         a9bnOHvSDRjfx/aODskL2lbWxAeQHFjtVsqfNEBxzyVTv3O/FMsD+/kdZy61lRXk8PrB
         clsjSYfEsTvZu3pC1Xb02rm2zoXfnGyZaSobRb31U2EeDKgmZOgym1lekUxyjUw66ZQ/
         hQWAOBtxmhFs5LKyS5nwP5xMs5cOtmAlUvLjhm63Ftq7YRkYUCnW+2gvVGcrNZ+nE2o0
         ugSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609388; x=1784214188;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAgUd9Ss0JGVtNtTktw3iPy4qr+CjvIuMq+r3w0MlSo=;
        b=kTsn/s8Kq4YIz/f7rIFACkv2auEfTGcpMnXAQf9nvyNg3jLgm+HB3fO9a042yKfRfV
         SxD/FKScKqY37iH1r2ko5+5w9jXRMgnJQM78mRKOxvKGQx40dVaDGSdrsl08+bJ1jlmE
         YKEWizdFSfXlQO0V2MTOB4jnWyFBc1PSD1sgNA5xpXwK052D5JS+7g9dCID6fDBjYeRK
         zgE8eIfVj5Ms8kYi8DH6SvT2gP7LuvD1ifGwLTabQ7k05gOhF1usjPyx7whwkJyRpOtA
         9uPJpz9GbAGlWR7ru2WBZtK3Uxcccnx40Klkbat8zkyO/1pf9M1s7cXRnlLLRp45f8/7
         Vg4Q==
X-Gm-Message-State: AOJu0YxlK1PpldsDXgUOKPZVGkSKfOKN4UMS2Q38zaxTIXDl3sg3+Hj4
	JAPRgdVVhFEXo6DS65ndAy7V4CgGy/bYtg6i/W6dajjtnCL7BRHTXuhVYSzqLw==
X-Gm-Gg: AfdE7cn/3PNdE3ZesTSoL/BRrkGO1t9QZPh0KjFzDLQm2vqCRlgZ2iAJDLlZRNrVaWz
	t7mEC95TDxdG4MxHfYVlm0rqzxy7EqSd5tlMHyVtftpcK/bexGGbsbgAEGyJflWz9T9WeCzC3+p
	kbJPmbwPFURY4h2pMdgs17zrmbMMW6s0eM6bKsHLveXYlwOn8LVzJ0LaaexLYHC/u7JFRlSiV9Y
	+i3++waLbzJ40/xsi99u6tMHwiwT8AilmUsI7fJm4DPmprtjAnhomn3PFjhLwqKxiwXpsisMd/G
	vc6hHe20iFqQuFNNB7kX6AkV2v+ZDdabVxLzGdieDSzdbqpEs7xSuaVvFp/rkRvhypt+MbZi5BO
	1HQAL7AnBRk4lKvXqW/cvJ3W0BsCHXIgaMCwArKYzDIFBPVJyqHaxFxhFntoY/v7UxT1zMz1P/B
	HKh8N+EV2G09qJiuI=
X-Received: by 2002:a05:620a:2b87:b0:92e:cc01:a67e with SMTP id af79cd13be357-92ecf91af9emr821825185a.76.1783609388136;
        Thu, 09 Jul 2026 08:03:08 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ecff35229sm400997685a.36.2026.07.09.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:03:07 -0700 (PDT)
Message-Id: <679dd2e392b26b6a51f88b62d0a17cece71942ca.1783609382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 15:03:01 +0000
Subject: [PATCH v2 2/2] commit-graph: propagate topo_levels slab to all chain
 layers
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The topo_levels slab is only propagated to the topmost graph
layer instead of all layers in the chain.  Commits from lower
layers appear to have no generation numbers, so the DFS
re-walks the entire ancestry.

Fix by making topo_levels visible to all layers, not just
the first one.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-graph.c                | 2 +-
 t/t5324-split-commit-graph.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 702ba9731b..a0bca248ac 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2610,7 +2610,7 @@ int write_commit_graph(struct odb_source *source,
 
 	g = prepare_commit_graph(ctx.r);
 	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
-		g->topo_levels = &topo_levels;
+		chain->topo_levels = &topo_levels;
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx.changed_paths = 1;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index b41331e3dd..9e5ab7dbd0 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -718,7 +718,7 @@ test_expect_success 'write generation data chunk when commit-graph chain is repl
 	)
 '
 
-test_expect_failure 'incremental write reads topo levels from all layers' '
+test_expect_success 'incremental write reads topo levels from all layers' '
 	git init topo-from-lower &&
 	(
 		cd topo-from-lower &&
-- 
gitgitgadget
