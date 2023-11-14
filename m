Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026233070
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB70D3
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:53:32 -0800 (PST)
Received: (qmail 3605 invoked by uid 109); 14 Nov 2023 21:53:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Nov 2023 21:53:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20862 invoked by uid 111); 14 Nov 2023 21:53:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 16:53:33 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 16:53:31 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231114215331.GA12791@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <20231113220254.GA2065691@coredump.intra.peff.net>
 <ZVKkgpiFaOwwDcdw@nand.local>
 <CABPp-BEV8Mxu=4=TFN=0o9n+o69kKQfNZd_Rhr1swxqgKwd90g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEV8Mxu=4=TFN=0o9n+o69kKQfNZd_Rhr1swxqgKwd90g@mail.gmail.com>

On Mon, Nov 13, 2023 at 06:50:08PM -0800, Elijah Newren wrote:

> merge-tree is the same as far as hooks; I'd rather just not have them,
> but if we did, they'd be a post-operation hook.
> 
> In both cases, that makes hooks not much of a sticking point.
> 
> External merge drivers, however...

I suspect external merge drivers are OK, in the sense that they should
not be looking up arbitrary objects anyway. We should hand the driver
what it needs via tempfiles, etc.

That said, I'm also OK with the notion that "--write-pack" is optional,
and if some features don't work with it, that's OK. It's nice if we can
flag that explicitly (rather than having things break in weird and
subtle ways), but I think we might not even know about an implicit
assumption until somebody runs across it in practice.

-Peff
