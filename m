Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BBE610C
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401829; cv=none; b=hP4S1KnPHMpvI/fE1LWmNXc/eszqhuI0FRoByxuKddQ0ouTxBRjHUR38N20/GNBWSKyhGtqhqBujXH0+/OcdWvu6zAFjXKEXRlsJoUiB64IzMtKVgrrg6GRmz8AV2o5tPgKH1dmSWK/qK/cy7xzMUVdBJHZB+ADctySUy2iSDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401829; c=relaxed/simple;
	bh=+H4rzLWAl9Eq1SJUCraHNViZvq4qWbpSWKV5odBvlNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHyT1SL64MJgu11G8rG5JogqpZ3xPqftfdE8Uj657QsykBCfC2tavYV2Dlg8LzzIxWoBINmmxfq9EsMe7ERuYuY5TBUAZbmBOWgyRzFzYAC97dboclYTk0Up8DPTJmHOXhXhbpRrxjr49IVUmFLz5GoeusH7g6gIeK61jzNNzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evj61Ysr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sN+GKN6a; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evj61Ysr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sN+GKN6a"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E936F11401CB
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 31 Mar 2025 02:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743401825;
	 x=1743488225; bh=tfUIT8pReVWa4T216ICxx6C45Luv7RgWZR1QTehctJo=; b=
	evj61YsrVs3XP68pCpPPPIJ/WP4Up6/kmtB4uwC2eaBJDf/gHZTn4U6zH4KE00u+
	xQREflUpGi0zJF+1YdS49IzxTrf9OukB+0EApZLh4HmqiZkXhjg5ID5kJW5OgMQX
	l1nTn1vjvAkIypP7EV+LXn2Dwn5ucvvHhg+IZJbnRsehRdvpGG2erqUqZaVd99Sn
	ShbvvcoaVhLY843tIRAsg3ZekAlFL1nb7PZnfQBK7wULYmJHpsevi3pJz/zwoCdb
	KtlTLjqxrJlrVjiYH39K76I7A2G8T1uPY/pqYUSdvmmWdfARbo1sdZ8UQLc3JmT8
	GSP1a2gaLvoMcNLWb0k8Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743401825; x=
	1743488225; bh=tfUIT8pReVWa4T216ICxx6C45Luv7RgWZR1QTehctJo=; b=s
	N+GKN6aVk2YnPa5UCpi9D1RGNbtWkBZXrjOkZpZEZ34t9rJCPdH8pWNa3XWy6eNO
	wDxLLYVs5PPBVrhxI8OebeSpGVzA/HzmuO7Ml9ynnef2ZtBQZJ7QFCvUJwg5FKJ1
	mjHbPFC+Lsh9vFTEeSuVI1xBK7NkE6mQmrmJwdKddXzW8iOaWBAaG/zKiv9KVypZ
	TALnR7R/vY6IEbzp6jtG+doNC4twdEfUIe41ETB/57iQ5a9bdd1O79p3QLVmdzX5
	muMx6ziHvKrVyNBcXfGEP9mEbVZ3PcY/IAWqw5KoMkejxw6SoSmTLoLNr2iqdo7x
	060/9FuVWqIYhU4dRZTgQ==
X-ME-Sender: <xms:YTPqZ5YirslFyTqhR5vnpsywoGLlEn1i140c5eP31cpcAwV-KOLUOQ>
    <xme:YTPqZwaadZAlZn8u-jaRFr8a3u_vF2MQhjKThyhlaabPeTgGFQ55CoCTzHBnu69NC
    pTkEsIU20EUzfrYAg>
X-ME-Received: <xmr:YTPqZ79QXFPIQPFIUcK4Nn2ZVASoiq8nYIoZhXUGraC2wtjscYU67PykAxafDjGjhRMIq2DlaxETclF3TMCP2VuO8aFla8927W3aPceRTb8yEL8y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YTPqZ3pn0cVuJ84CImN5chqhvU1U3AHDyT-rCcWE76qv_y0dnJJ3UA>
    <xmx:YTPqZ0pv3MmbvNgIvP8nJ3T2--WDZLkZjagONhq6DHgCNDoXqHpAuw>
    <xmx:YTPqZ9R69kO79w1JawH7bvctfewFFw-N1b7MBQGSbB4XFrf7PSCrGA>
    <xmx:YTPqZ8pVWugQRIapbpB2G32em50qIgpZeFdbAuyWIwto70KPK0CBPQ>
    <xmx:YTPqZxAoPGUApjfJO-YRqJXghaz615nvg0HmZ6JnigVu-5gpi4WFW7jC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cec9e204 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 06:17:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 08:16:44 +0200
Subject: [PATCH 1/5] t/perf: fix benchmarks with alternate repo formats
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-meson-benchmarks-v1-1-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Many of our benchmarks operate on a user-defined repository that we copy
over before running the benchmarked logic. To keep unintentional side
effects caused by on-disk state at bay we skip copying some files. This
includes for example hooks, but also the repo's configuration.

It is quite sensible to not copy over the configuration, as it is quite
easy to inadvertently carry over configuration that may significantly
impact the performance measurements. But we cannot fully ignore the
configuration either, as it may contain information about the repository
format. This will cause failures when for example using a repository
with SHA256 object format or the reftable ref format.

Fix the issue by parsing the reference and object formats from the
source repository and passing them to git-init(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/perf-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 8ab6d9c4694..1a9a51ca3cc 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -98,6 +98,8 @@ test_perf_create_repo_from () {
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
+	refformat="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-format)"
+	objectformat="$("$MODERN_GIT" -C "$source" rev-parse --show-object-format)"
 	mkdir -p "$repo/.git"
 	(
 		cd "$source" &&
@@ -114,7 +116,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q &&
+		"$MODERN_GIT" init -q --ref-format="$refformat" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock

-- 
2.49.0.604.gff1f9ca942.dirty

