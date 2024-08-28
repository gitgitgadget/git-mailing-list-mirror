Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E642A8F
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818086; cv=none; b=ndhtkuf5G7ScCbCy5w/F9h3xT0N9uaX7IdMYwX/VSyxzD2uE6Jgr5JxOY5Osc5uswBqz8H8sm4X9nm7jkAhLVyh09QihGPPAMYtwz1MLvxmo0pMwxkEXGKb9vX8nT3FRkUa45UMuXtTBB/nDX/5e2YxFI2UsYCMp97B2a8a7cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818086; c=relaxed/simple;
	bh=rxwTFQLTMayFhDBFltCaH36YLS9LK5/KyPxjjQSnpi4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Be8LfWjDvT3s5qGy5QFnJcEIedXs9GP+l6Dye1WCHkNqa2wJDA3A2XZsSxPN28BU/CKduYM5+yzxWY1Ci1ek1pI/u+feKkTwMWfady/MwV4njq9O5qPGyKa5tebj20dsm1ScIY2z7mgTfrtzGi4+yryTubIop0DDyuVoox8TO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20568 invoked by uid 109); 28 Aug 2024 04:08:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 04:08:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23155 invoked by uid 111); 28 Aug 2024 04:08:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 00:08:07 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 00:08:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] t-reftable-block: mark unused argv/argc
Message-ID: <20240828040803.GA4004932@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is conceptually the same as the cases in df9d638c24 (unit-tests:
ignore unused argc/argv, 2024-08-17), but this unit test was migrated
from the reftable tests in a parallel branch.

Signed-off-by: Jeff King <peff@peff.net>
---
This should go on top of cp/unit-test-reftable-block. It could also be
done as an evil merge when we merge with the final unused-parameter
topic, but I think doing it this way is less confusing.

 t/unit-tests/t-reftable-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 582a8e6036..f0124fc3d0 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -359,7 +359,7 @@ static void t_index_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
-int cmd_main(int argc, const char *argv[])
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_index_block_read_write(), "read-write operations on index blocks work");
 	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
-- 
2.46.0.754.g24c813f009
