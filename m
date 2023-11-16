Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F7B3
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 12:17:58 -0800 (PST)
Received: (qmail 26018 invoked by uid 109); 16 Nov 2023 20:17:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Nov 2023 20:17:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18405 invoked by uid 111); 16 Nov 2023 20:17:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Nov 2023 15:17:58 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Nov 2023 15:17:56 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org
Subject: Re: tb/merge-tree-write-pack, was Re: What's cooking in git.git (Nov
 2023, #04; Thu, 9)
Message-ID: <20231116201756.GC1146561@coredump.intra.peff.net>
References: <xmqq34xg5ek3.fsf@gitster.g>
 <ZUzcmsfJe6jk4fTk@nand.local>
 <xmqqpm0iy00y.fsf@gitster.g>
 <14bdff31-5229-bbd5-3715-f77f52b832d5@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14bdff31-5229-bbd5-3715-f77f52b832d5@gmx.de>

On Wed, Nov 15, 2023 at 01:57:00PM +0100, Johannes Schindelin wrote:

> - The scenario I want to address (and that I assumed the patch series
>   under discussion tried to address, too) is a very specific, server-side
>   scenario where many `merge-tree`/`replay` runs produce _many_ loose
>   objects. Quite a fraction of those are produced by processes that run
>   into a SIGTERM-enforced timeout, and the `tmp_objdir` approach would
>   naturally help: unneeded loose objects would not even be added to the
>   primary object database but be reaped with the temporary object
>   databases.

Thanks, this paragraph helped me to understand why you are interested in
tmp_objdir in the first place (as opposed to just doing a gc-auto repack
after finishing the merge).

-Peff
