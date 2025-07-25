Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27B1F61C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420393; cv=none; b=cmbVxVZQkAYGmhTKfGP6cg35k9xWA7bcVdGkDvF+YyhrANtYNgBCHvIHe/iXwkQNdnHvNsUtBJ8tLCYc3MKDrFu/oM2y4JiUvlzPjTYwpm7VI4m4J8jV5sqSuQSTY6KpKxEIO6BR/dBV+TanDNBlIgswW4GbvckiZ8vA/oWOa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420393; c=relaxed/simple;
	bh=FiHE/GN9yF2vczhvCcJcwuzZ3rKaVsFC4LqDoIcfpN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOLs/O0AOw81vtR5caCGaRuwvU4KeX6qPo/FJR0/LKQ47DLXtwjxV5ai+eE2ywv4H5nK0VfbFyC2WBcIe8Hg3dQ/HhERBtS9+pBFU4see1uXsnMdOr3hWrgGtV3APRnEcXCYOXIYoxbUhS2l7VP5C2FriBG8NqPDqGFQkzlqkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gx/ai/DV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gx/ai/DV"
Received: (qmail 23755 invoked by uid 109); 25 Jul 2025 05:13:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FiHE/GN9yF2vczhvCcJcwuzZ3rKaVsFC4LqDoIcfpN8=; b=Gx/ai/DV3PNJckkPJIziBVu89hz7Rc0pOcjt481TkZSQzD5wT0rmkXxgNjsAEFvIXA+sADuiGAQk6h0aP7jeziAqGjiZRvLWzwnj2W4My1aj9Yu5NS5emdBICVMEGb/odNkqfJO0z3e6l3brD1S2f/eUlR3FhAOZrQVzx+L5f774j/XwoxZTc11K5VDPRZ1hC8INb5Q3tI6LL9nXjLBABaGqcbCi9t4wljndtyFMe3HQ6M4wBV7sudxeLlH1Loocdh13B3a91Jb1aFYELe7YCErX8tAc+XKJFeg9fpTSZE66rp+Qx8KgiPncXksNLJKqCN/uXcthN3pRm4CFI9nsZw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 05:13:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15971 invoked by uid 111); 25 Jul 2025 05:13:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 01:13:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 01:13:09 -0400
From: Jeff King <peff@peff.net>
To: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t7510: add test cases for non-absolute gpg program
Message-ID: <20250725051309.GA3003751@coredump.intra.peff.net>
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
 <20250722190922.51183-3-jonas.brandstoetter@gmx.at>
 <20250725043043.GA3002998@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725043043.GA3002998@coredump.intra.peff.net>

On Fri, Jul 25, 2025 at 12:30:43AM -0400, Jeff King wrote:

> This second test seems to fail on Windows. E.g., in this CI job:
> [...]
> Should it be "/d/a/git/git/..." instead of "D:/a/git/git/..."? Which we
> could get by using $PWD, I think.

Yeah, that is it. I found a commit with some prior art, and here is the
passing CI result:

  https://github.com/peff/git/actions/runs/16513873854

> The earlier one using $HOME uses D:/, but this one is different because
> colons are meaningful separators in $PATH.

I do wonder if that one needs to set $HOME at all. The test harness
already points $HOME to the trash directory. But maybe it has value to
document the expectation.

Anyway, here is the fix as a patch on top of jb/t7510-gpg-program-path.
I am also happy for it to be squashed in, since I think the topic is not
yet in 'next'.

-- >8 --
Subject: [PATCH] t7510: use $PWD instead of $(pwd) inside PATH

On Windows, $(pwd) will give us a Windows-style path like "D:/foo".
Putting that into $PATH confuses anybody parsing that variable, since
colon is a separator character in $PATH. Instead, we should use the
Unix-style value we get from $PWD ("/d/foo").

This is similar to the cases fixed by 71dd50472d (t0021, t5615: use $PWD
instead of $(pwd) in PATH-like shell variables, 2016-11-11).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7510-signed-commit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 95d2ebe277..1201c85ba6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -458,7 +458,7 @@ test_expect_success 'custom `gpg.program`' '
 
 	# `gpg.program` does not specify an absolute path, it should find a program in `$PATH`
 	test_config gpg.program "fake-gpg" &&
-	env PATH="$(pwd):$PATH" \
+	env PATH="$PWD:$PATH" \
 	git commit -S --allow-empty -m signed-commit
 '
 
