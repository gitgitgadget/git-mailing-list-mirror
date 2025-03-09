Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EB25761
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489305; cv=none; b=QpqSVBYDqAyz2FC+MOxdbPjdaMUH0O+e8KMAXqzDAlxU/OCoCjsQSd3v/sJq+BjhTknBfH8Jx1dgGDICr+8vrnspcJPajwuvMEcbKV2kup6Pb1RfL72BE032vT2qPLQIk3xyeEk9IiSDoECzxOy1kG8sqghQDiBhQWVzfespRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489305; c=relaxed/simple;
	bh=LCafvU40/EOxmhMgkydloWMIwGDMYSR5fgmLmnMk6OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4lx+x5nczbM23qt7wZH0cI9E+/cMQCtKNZWgjUFiBYTzJ43Flwgy3N522erutYsMH5JFDafRg3jdZHJCzSx5iV58VTTt4Hfqad5snuVu1Y+dYBnDrb5eTS2SEw/mVFNk9S7pFIaZU88MmGk/r4N0amej9yY5J7GFYA7SCFa4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b9pYPZR4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b9pYPZR4"
Received: (qmail 4645 invoked by uid 109); 9 Mar 2025 03:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LCafvU40/EOxmhMgkydloWMIwGDMYSR5fgmLmnMk6OI=; b=b9pYPZR4WDN33+Dfsfk2GzeGSraLzKVxdbArV5sXBCporCLCRRVHJPUSVMzJGoIinQ0GvtjJdUSL42/2nGB5N5ARjzs9VOF5nJgMokuoQZacB3pHlfCbEa/vupiIxtJfDjXVJkcUoSwwo5gRwXzWnYg4lo+srmpslFTmiY1eIhK6cP9bT49qX0ZyYLsvHHGeiJQkERkpR8NW85tqVMEakfWtQ3NXkse0QKQzrwjLsSRa8jPqItDw5eYezzI/Pl3YUKwb/9VmSSO90jaEYeS8XTl6GpErYMwSYe6P6oRePgDfqMEedIgagLXw9dV6QyJHWL7fmD9nURasOcMLX8XPWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:01:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4817 invoked by uid 111); 9 Mar 2025 03:01:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:01:41 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:01:40 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 2/9] t5516: prefer "oid" to "sha1" in some test titles
Message-ID: <20250309030140.GB2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

These old tests refer to object ids as "sha1". These days we prefer
the more algorithm-agnostic "oid".

There are a few more tests that mention sha1 in the title and also use
it in variables throughout the test. I've left them for now, as changing
them is more involved (and they're linked to the allowTipSHA1InWant
config, which as a v0-only thing actually is always sha1).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 85ed049627..e7629fc536 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -495,7 +495,7 @@ test_expect_success 'push tag with non-existent, incomplete dest' '
 
 '
 
-test_expect_success 'push sha1 with non-existent, incomplete dest' '
+test_expect_success 'push oid with non-existent, incomplete dest' '
 
 	mk_test testrepo &&
 	test_must_fail git push testrepo $(git rev-parse main):foo
@@ -1251,7 +1251,7 @@ do
 	'
 done
 
-test_expect_success 'fetch exact SHA1' '
+test_expect_success 'fetch exact oid' '
 	mk_test testrepo heads/main hidden/one &&
 	git push testrepo main:refs/hidden/one &&
 	(
@@ -1297,7 +1297,7 @@ test_expect_success 'fetch exact SHA1' '
 	)
 '
 
-test_expect_success 'fetch exact SHA1 in protocol v2' '
+test_expect_success 'fetch exact oid in protocol v2' '
 	mk_test testrepo heads/main hidden/one &&
 	git push testrepo main:refs/hidden/one &&
 	git -C testrepo config transfer.hiderefs refs/hidden &&
-- 
2.49.0.rc1.381.gc60f5426ff

