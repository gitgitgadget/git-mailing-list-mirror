Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398913E043
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883145; cv=none; b=Bj/gZZwJ4yOtb3QkCqqYUkRP4Xs8Q/8ZYhwV9kdmeDX2Zb+eem0FKuGW3/PF37DDrRY/QqwSyGpplh4W/BEn5qDEuQbtouhIqzhkKZgXbjQnzPjB0HflLEYtm8t8dWW2vm7U8BAGiYfmB5sJ16EHP17ZSasqWtv3naA4/mC3otk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883145; c=relaxed/simple;
	bh=+js4deg2UiqFzqy9Hetv0vix/E4gs5F3yz5a4fE78zs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nug1FwiMDe+FnE9FJnM9Dln5u7tAORxBNzhwRKloF/rcL8z4TnHOinfh3DBRMn4hxoNnykA/KdFRYxy9jfunlnrShpe1lVGDrPlOd8Eo41dtuqs9keMYUYawkkTDoJX6ylvqZl5GqdmQsYVLOwbZxn8ILlimrZaR676zYfHAQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24760 invoked by uid 109); 17 Aug 2024 08:25:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:25:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28046 invoked by uid 111); 17 Aug 2024 08:25:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:25:47 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:25:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 15/15] scalar: mark unused parameters in dummy function
Message-ID: <20240817082542.GO10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

We have a dummy load_builtin_commands() function to satisfy the linker,
but which we never expect to be called. Mark its parameters to avoid
complaints from -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 scalar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index 1fe8a93e65..6166a8dd4c 100644
--- a/scalar.c
+++ b/scalar.c
@@ -400,7 +400,8 @@ static int delete_enlistment(struct strbuf *enlistment)
  * Dummy implementation; Using `get_version_info()` would cause a link error
  * without this.
  */
-void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
+void load_builtin_commands(const char *prefix UNUSED,
+			   struct cmdnames *cmds UNUSED)
 {
 	die("not implemented");
 }
-- 
2.46.0.585.gd6679c16d8
