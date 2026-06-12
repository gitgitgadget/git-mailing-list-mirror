Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121438F653
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244013; cv=none; b=ByCJtENW6cJ0BPOzxp8zVa3wPxbgOd2a6z7PlrQt5r/FAscr6hO/+EnBHqP438u62nkZ2KP+cJNlmU/I5DCfAiI0S/TKttYnxs4YfR9Z262AbD5o5x7TD9V8Naoenr8KifJE10O2aMPphSIksTPz4WfuziYuAZVCBlufFuYloLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244013; c=relaxed/simple;
	bh=wpTK201CZn1WZ/V5+2g6KB0rKtDp0uRRkWDp22XqMoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU8b80lYJHjUAh4VFF+YMLqhzY8ReLfXgN7bUjq1/XfQcuU/ytNJHiTaWcQgj/wJxvrw4Y7hGNQZ7p24ULl+bwMrJXa2aK2LYC+GUYAJa27WuM+dEDYzv/4yU+1wEcJHF6uOfGjngk6jAKl5pGar/ZlvnYJPHEHul38HjYs9Qvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=DM2uZTEI; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="DM2uZTEI"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id C6FBE60002
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244010; bh=wpTK201CZn1WZ/V5+2g6KB0rKtDp0uRRkWDp22XqMoc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DM2uZTEIrnkLapK/lKaCrkjSV21bJak4JE6RzCtrVi2u2o2KfqxUMg4H7oA4wzhl4
	 Jo46wYE4YS5rJZG5z4TIAE4VZtuq6P4xmrr4CVNxmkbgoMqbAweFy5VIxgTz3uG8hd
	 VBrQ5Zrsz1sZUjQtHic94AtfhKwTs7YABCIaiBuA=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH 4/7] fetch: rename function report_set_head
Date: Fri, 12 Jun 2026 01:55:40 -0400
Message-ID: <20260612055947.1499497-5-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update to the slightly more obvious name 'warn_set_head', which matches
the verbiage of the followRemoteHEAD options.

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82969e230f5a..9a45e1e7a44d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1707,7 +1707,7 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
 			remote, head_name, remote, remote, head_name);
 }
 
-static void report_set_head(const char *remote, const char *head_name,
+static void warn_set_head(const char *remote, const char *head_name,
 			struct strbuf *buf_prev, int updateres) {
 	struct strbuf buf_prefix = STRBUF_INIT;
 	const char *prev_head = NULL;
@@ -1787,7 +1787,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 	if (verbosity >= 0 &&
 		follow_remote_head == FOLLOW_REMOTE_WARN &&
 		(!no_warn_branch || strcmp(no_warn_branch, head_name)))
-		report_set_head(remote->name, head_name, &b_local_head, was_detached);
+		warn_set_head(remote->name, head_name, &b_local_head, was_detached);
 
 cleanup:
 	free(head_name);
-- 
2.54.0

