Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50E231C9F
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081314; cv=none; b=CT0OVyK6NmFB3G1EL3+tCkBKJFg9wKaHgC+pjlpStDqqp3DNXVbJRQmMdhOKteb51SsbQu2i8mgR2IDY6TrJy17AAOR1zFUWH67i1q0B/accush7FzDthat3zKreLWb3GVyQj6q6dYal0YPTmQPreZMvB7R+WZcQOqCxKgIUvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081314; c=relaxed/simple;
	bh=4OGkZo4dwmucNz0eOGG7yhoFjXJ3l1dw9xpyfuvQARQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7fGoEkUZ/jJsEzAw01jlP9w+lZ5wFpBm/wiIUEMZbla0ta+Gqbc+vZN7UOEDvlqt17UIN6zvvsgeXayj77V/PZL/utI0beIFGnU4I3f14o4mAihHQjnfp14AHC9MaS4dHA+h7nnhitms9pZnbZWGOojSx+kkY0iawcqWFFusb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B/LNhqxI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B/LNhqxI"
Received: (qmail 9888 invoked by uid 109); 4 Oct 2024 22:35:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4OGkZo4dwmucNz0eOGG7yhoFjXJ3l1dw9xpyfuvQARQ=; b=B/LNhqxIrqGrYnEnaKd5fRSNpcZkY4xyhRGyKM14xaFBx4g6h8SsreDkMiPFnoPczA9Ta7cV2UINMb7MtXUCH+R5pcxVQyTTU70bvEFP9eQBeyAj4Gp/p72fUQGBjdsRAMGOTjeoI4wDrfD43kG942B0OgGQkGAzTsAxhWC/fcB8yf83ddq0kj0AjUBUYr/U8UNii3+e/Ix3ynP57qAuLG5dnNeCuQ+llzpNcMRxDDxNqNmtRYpnKePFenTcmMVdh90KrMKSZN4zX3QwpDo+LHatM46KQlc9NL0HWOi5kbClkmEKfQMu0djle3bd9BWP7EVfaABghc/2ZcJZgEiI8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Oct 2024 22:35:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14487 invoked by uid 111); 4 Oct 2024 22:35:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Oct 2024 18:35:02 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Oct 2024 18:35:02 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, ps@pks.im,
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] pack-objects: create new name-hash algorithm
Message-ID: <20241004223502.GA580885@coredump.intra.peff.net>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
 <xmqqiku7d0ut.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiku7d0ut.fsf@gitster.g>

On Fri, Oct 04, 2024 at 02:17:30PM -0700, Junio C Hamano wrote:

> > Derrick Stolee (6):
> >   pack-objects: add --full-name-hash option
> >   repack: test --full-name-hash option
> >   pack-objects: add GIT_TEST_FULL_NAME_HASH
> >   git-repack: update usage to match docs
> >   p5313: add size comparison test
> >   test-tool: add helper for name-hash values
> 
> Recent CI jobs on 'seen' has been failing the leak-check jobs, e.g.
> 
>   https://github.com/git/git/actions/runs/11184876759/job/31096601111#step:4:1886
> 
> shows that t5310 and t5334 are having problems.
> 
> I randomly picked this topic and ejected it out of 'seen', and the
> result is fairing a bit better. t5310 that failed 228/228 subtests
> in the above run is now passing.  I didn't run this topic alone
> under the leak checker, so it is entirely possible that there are
> some unfortunate interactions with other topics in flight.

Maybe squash this into the final patch of that series?

diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
index 15fb8f853c..e4ecd159b7 100644
--- a/t/helper/test-name-hash.c
+++ b/t/helper/test-name-hash.c
@@ -19,5 +19,6 @@ int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
 		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
 	}
 
+	strbuf_release(&line);
 	return 0;
 }

That seems to be enough to clear t5310 on "seen". It was not noticed in
the original topic because t5310 was not yet marked as leak-free in its
base. That happened in fa016423c7 (revision: fix leaking parents when
simplifying commits, 2024-09-26)

-Peff
