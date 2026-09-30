Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEF2D3A75
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807950; cv=none; b=TtIImMOSmVSHgeuFnzdWrKC6mvNeg/4bEhyai8+uRhV6bXnRua1jxQlUyi+FZC8hTM2F+CfhANuWWG8z36SSyrp0JvrMdrsLNzyK3gIpI4eP6CPygLiaHZHS+px5pCSE1Hljp3m2PVVnkLk2FVQfGz/zEU10okk/WtEaJAqD244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807950; c=relaxed/simple;
	bh=TCYFe7w6SXEwbHqRByYaZO5UOpAKTxBDo2BnDpb2Xnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpxt0oKbla3ZqZGUEMD7IFupuqX9puKdTzfOxZF7Rw7q1UAjYBgsGr6MSRcqk7uzB8dbZPt1obH/QxbnMe7AQwbtFfcG0bZvEgvCump4tfI0MSK6AmOEExWcT4UwnfH+x4gK5bw3/9SA7fnPw2Xu/Fi+BS3BiOFsnnScQCVEzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gKAETSRr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gKAETSRr"
Received: (qmail 7921 invoked by uid 106); 30 Sep 2026 22:39:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TCYFe7w6SXEwbHqRByYaZO5UOpAKTxBDo2BnDpb2Xnk=; b=gKAETSRrOyOxPIYG87+X2ag+ohstlVh2Ka0PRj6wwoOiP1TQsDr5OiNvkDa0B7bpN9fBbq/Gyvsp+pwX4pJ8dHOQqL9BwOkEXAnRv3Y6htouSlOy3+FNh9+tcuDI0TNVaUm/CXcaVeH+qI7UsX0aaFceiB/dTll5CcN2W8eWHX30R3WT1m6M0yyLBjGd5LcTNw0TjfHK+0jLVVrd5143zCwbceVVxQB72BOIosIvwCop0imzqxI5XciZYpFgLBWAnfueQjW/uMWryrpH6Wt46C6ijIRgpc206Mmn8bUqVyEOl749tr+2PtZfwNYKVJbDS7LFWUCAz894wovdXqolIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 22:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19904 invoked by uid 111); 30 Sep 2026 22:39:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 18:39:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 18:39:06 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] object-name: accept @{p} as short for @{push}
Message-ID: <20260930223906.GA763270@coredump.intra.peff.net>
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
 <CALnO6CBR0XJUJR=2e5kUM8Fk9aV5uz+QxajRpnFFVTEkFfJQ3Q@mail.gmail.com>
 <xmqqbj9e8kb3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbj9e8kb3.fsf@gitster.g>

On Wed, Sep 30, 2026 at 03:07:44PM -0700, Junio C Hamano wrote:

> @{u} existed since the inception of @{upstream}, as we can see in
> https://lore.kernel.org/git/20150331173740.GE18912@peff.net/ which
> is the first iteration of the patch set that added @{push}.  It is
> unclear what was said during the review of v2 [*] but in the review
> of v3 https://lore.kernel.org/git/20150521045233.GA26507@peff.net/,
> nobody questioned the asymmetry between @{upstream} having a
> short-and-sweet @{u} while @{push} lacked the corresponding @{p}.

I think you have to go back further. Another contributor proposed
@{publish} with somewhat different semantics, and I requested that it
not use @{p} to avoid confusion between the two. There was also some
discussion of @{pull} (I think as an alias to @{upstream}) at the time,
which would further increase the confusion.

See this what's cooking and the actual patch threads around that time:

  https://lore.kernel.org/git/xmqqoazpt45p.fsf@gitster.dls.corp.google.com/

I don't remember what ultimately happened with the @{publish} series,
but given the time-frame and the contributor, I can make some guesses.

I don't think either of those name conflicts are under current
discussion, so I don't have any particular objection. Just noting the
history.

>  * https://public-inbox.org/git/?q=gmane:268185 would have given us
>    a good way to find what thread Peff was referring to in the cover
>    letter of v3 iteration:
> 
>    https://lore.kernel.org/git/20150521044429.GA5857@peff.net/
> 
>    Unfortunately, we are getting 502 back X-<.

I have a local archive, but the v2 thread is not enlightening. :)

-Peff
