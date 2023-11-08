Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731331A6D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF21FF9
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 09:02:06 -0800 (PST)
Received: (qmail 17081 invoked by uid 109); 8 Nov 2023 17:02:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Nov 2023 17:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1510 invoked by uid 111); 8 Nov 2023 17:02:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Nov 2023 12:02:07 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Nov 2023 12:02:05 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t/lib-httpd: stop using legacy crypt(3) for
 authentication
Message-ID: <20231108170205.GC1028115@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
 <f4c6c754f1e519b655d45572bd7566183d98138b.1699455383.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4c6c754f1e519b655d45572bd7566183d98138b.1699455383.git.ps@pks.im>

On Wed, Nov 08, 2023 at 03:57:23PM +0100, Patrick Steinhardt wrote:

> Regenerate the passwd files to instead use the default password
> encryption schema, which is md5. While it feels kind of funny that an
> MD5-based encryption schema should be more secure than anything else, it
> is the current default and supported by all platforms. Furthermore, it
> really doesn't matter all that much given that these files are only used
> for testing purposes anyway.

Thanks for doing this. I died inside a little while adding the
proxy-passwd one recently in 29ae2c9e74 (add basic http proxy tests,
2023-02-16). There I mused about moving to bcrypt in a separate patch,
which I think is probably the least-bad option from a security
perspective. But I agree that md5 is more likely to be available
everywhere, and we certainly don't care about security here.

-Peff
