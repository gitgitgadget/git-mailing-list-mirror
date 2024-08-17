Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228B12FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883106; cv=none; b=j2UpTIni3vsPV9NiZHzhBZu9AODvihYstPJkMNRZF4YlHpkzftaC/CuDLUwNc1G3n5UCzB/ge1tLhfWsI/2rMqOnQqMokoq/W1dNrtCIeB8vnIR7ImZSjiKVKMnqSutN7Ix/DxLTg6Ex2YNEr0Npy8yqQG1nPqoGqq++YeoIJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883106; c=relaxed/simple;
	bh=YM7wbM9JkawGRmwjn25yfHy5eQ94hxg0DzN+OWa/MPY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBvar6kqiYgCugNDiCJH3HL4/Nd7l9Tx7iG07b+ncjtLaPQlSXChXpDbH2NoOcO6W5Kd/8GWEmcLjLXRluVgRU0KSxHLND3fhnhnrBJX+DZvcr+imiK3Oae+UC4VEj1A9Tw6qOm7jnV3z4ue0QQvwaqW5/NkF5d8fRjc9xaKPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24741 invoked by uid 109); 17 Aug 2024 08:25:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:25:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28036 invoked by uid 111); 17 Aug 2024 08:25:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:25:08 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:25:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 12/15] test-mergesort: mark unused parameters in trivial
 callback
Message-ID: <20240817082503.GL10287@coredump.intra.peff.net>
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

The mode_copy() function does nothing, but since it's used as a function
pointer within "struct mode", it has to conform to the interface. Mark
it to quiet -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-mergesort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 42ccc87051..328bfe2977 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -122,7 +122,7 @@ static const struct dist *get_dist_by_name(const char *name)
 	return NULL;
 }
 
-static void mode_copy(int *arr, int n)
+static void mode_copy(int *arr UNUSED, int n UNUSED)
 {
 	/* nothing */
 }
-- 
2.46.0.585.gd6679c16d8

