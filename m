Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8043BCD0A
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681557; cv=none; b=s740+nfWfczDXzwfGvKF3ZZhpofL2YGw3ncrDSEYrmkNxSWqTpUz7WZ3nJJOn/HiDqKTVgllDEgjE0YVF9qY8JlTWo0NkodtIMYNMjj4UmDQ/G2qgid0USkWXhZVzPlEIMphUOkUQ5sSdiri3U4cvpGH998WWDVx0xgXjQFHh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681557; c=relaxed/simple;
	bh=EKk8ztO6BkAlN/rPts1ostm6f23a56B4YDfMsfR2G8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGqwgdzdX8rDGXFu7gZmmeVIIM69KVMGDbmY5fzBaMd6VmZDkoGzjqUJPRgnagIEG9+Rj/SyRrDgkir1jaVvm6WD7qFVlH5ZxWiK0KwSXaUHGCFFifhxuvGdD2FrQoOX6Zv1T08HT6QVw2T1vMj3yAi2SmjpGL+XkktjhunBOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qk/QJRJD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+cnZJNX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qk/QJRJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+cnZJNX"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CA30F1D00082;
	Wed, 17 Jun 2026 03:32:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 03:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781681553;
	 x=1781767953; bh=srbu6NCMbvWnFIf2q3khjJiO7FrS6KhqsXQ36MofVdU=; b=
	qk/QJRJDRWHusJ/ngo+f3RXzjwXv8cQt8yHPtZyO8A44+z7/CLkexsxWts3HxO6c
	ZtTujb9SYS7i8+3/KKn7k/GofUgMcJoQMo3I/OzQCoGMR6uEDErnL+6DjGPpLdLa
	nUFwe0nf0tDxnSRLxtnzzMR+Kmhij0clH1gotc8ku0lQ9bzc9cYUS2uhXTDMUtKN
	nFFAOjaA0MSN4637XMsykM4ojUgZu7dj/0xinuAgAXET9WHhhb+Lcmr1R+FwMaBh
	4SQXfgCYkAg0PrdYsCV+oo5wFGjaXL/le9oUcfs3X5cwMzakD/R8V0uO7r0h9Q1Y
	3A19RdxC3ZD4iWFQCGhEsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781681553; x=
	1781767953; bh=srbu6NCMbvWnFIf2q3khjJiO7FrS6KhqsXQ36MofVdU=; b=G
	+cnZJNXYwzAbCRlnSd3z0bPdADQwITR9iBbBjInh2OkZFbeAY2n1GQqIuEJPLMqM
	d5lrkpBLWRFnnO6QmCZPwNCCHnrhHbTHDOIN4Ttz0mKBRBxfn8Jy71wSxIFMvNWa
	L8ttiaKUkIY7T+o1JLU2zkMz2NIPip1s0N3lBIp4gcr7GcLiRsgUUv4VFQLBZNmx
	UyfStZ/FoMaSDaoo9u7lK5Nyrp72/1wDHekDAuTGUFV5n6c0N+z4NPPSb6aW/vyN
	1Af6IC6wPC0anVaGlPp3e6hC2gn2IZcPqXoVn9OnmUiBgiqA6wjyLuvE9LBSAv7E
	U3T/KUup0THg6chIt8mpA==
X-ME-Sender: <xms:kU0yavsI9h6rTTG2S6pKSk2vQWpGhLTS_C-tJvwP2aQFA4UwJQxRQA>
    <xme:kU0yamf0ygSF1fxRAWy45GDzFeypqriA40gWgjy1buWBQryfqqrAKp3Ej-LH4562w
    YRtC1xEJFhsjrRq-0gC2n9mEJmCRg-ekv4qqaY_isYrDBGrX3HM>
X-ME-Received: <xmr:kU0yagaQOzd85DadSec_SexHj147nN6bl5LrYoTh4tSh5oappESW0jQ8QfRKdysIPWSQh72XE4YIATR8QK_YlU5NdCIh-F4bF4Y8ezY>
X-ME-Proxy-Cause: dmFkZTGe7EbvWVLCu6VP0QoZcRUw7zM8sZOpH2ybwXQ1TlM/p09VWASLpUKkJMsGMYLYyl
    qevvODvc0Mpk/mKeh//F/G8YZpBQFK+IXop8zqB4CowFYzDDO48xWoexdze6yEnIObMJ71
    jLLWstNeSoi3qHYc6S4r7oOcNDgzfEChF0iy3h9eZc9n8Pn+UJBF9Xy/PkgtDjYepoL20t
    +Q5WFnFhWqZxGugrDjb3afMMwvqCcqmpmS6poC8u86rG518Z0zKvzb9GdJONphg/Gbpnw3
    WjVyFvBi+VQb4T9E2rDurNgucBUOrYSANtXH1enF3B/JEaxYGi+lmU3TMR9/2UKGgq3bKw
    yuMpbOog1wWN15iJ3Bo+zw+2NjVkMBxkDy5nUOcQ5C/kWUYerfdC85D2Gonuy80zytxm9Q
    Wzq6EN1VQdh9i474HEhZuNeJSrBgsqRLb9fwJjUg9Sdapegf+6uPUqt3DWyp0k8sf4vVXK
    bXZ83ScA/QHvFLmj6Fe9uILxThaPyPty3sphVbOHXcFeK5gCdSGy7ZJxFxRYAmJuoyP/3i
    bRTDJWBkDflOolJ4XqXITnhcpiO+ZhrFtNy5rclk3pZMj776UUDBcehSsyeMyz/1Cxo51X
    fNhhQiC+/k+XtkAiBz/NQEqIR2V1W7SNuMFizMF8syUZGokpsVc4TGOpA+cA
X-ME-Proxy: <xmx:kU0yapX_IylEbEJIDp7ul1nBOC1kHOokSi5NRAX3_MZh36H9b_v5jw>
    <xmx:kU0yaiguFplnLV7eM7P8GjXseSvFXRY8mZNcLxkWFh_s0L__ulx__A>
    <xmx:kU0yanWCYfZVYTGQLT249iCxe3vGGVz2eIdIqg66MSIRW-K06oOPrw>
    <xmx:kU0yapNcKhhCiGguyuJstR2-hKweSx2N9cvWeN3r55nuv0F4TQ0VAA>
    <xmx:kU0yarEwYteu6-qFZCVOKCkc8KjkoslldBWA-4s-3vHnizNWs7Sxf6K->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:32:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6c65c35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:32:31 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:32:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] SubmittingPatches: discuss non-ident trailers
Message-ID: <ajJNjOYMVDwL52zY@pks.im>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <non-ident_trailers.8f5@msgid.xyz>
 <aivvE6gVMGWhRbCB@pks.im>
 <43cd8c48-c933-4eef-a6c0-970c38885967@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43cd8c48-c933-4eef-a6c0-970c38885967@app.fastmail.com>

On Tue, Jun 16, 2026 at 10:02:46PM +0200, Kristoffer Haugsbakk wrote:
> On Fri, Jun 12, 2026, at 13:35, Patrick Steinhardt wrote:
> > On Thu, Jun 11, 2026 at 12:22:45AM +0200,
> > kristofferhaugsbakk@fastmail.com wrote:
> >> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> >> index 0b12badf86d..51c308a89a8 100644
> >> --- a/Documentation/SubmittingPatches
> >> +++ b/Documentation/SubmittingPatches
> >> @@ -474,7 +474,10 @@ These are the common trailers in use:
> >>
> >>  While you can also create your own trailer if the situation warrants it, we
> >>  encourage you to instead use one of the common trailers in this project
> >> -highlighted above.
> >> +highlighted above. A trailer that credits someone might be more likely
> >> +to be accepted since these are the most common ones. But another kind of
> >> +trailer might be relevant, for example to link to an issue tracker
> >> +belonging to a downstream project that is affected by a bug in Git.
> >
> > Hm, I wonder whether this is a bit too vague to really be helpful for a
> > newcomer. Instead of alluding to such trailers, wouldn't it be
> > preferable if we added those as actual examples to the list of known
> > trailers and then tell folks that they can invent their own ones if
> > there is a good reason to do so?
> 
> Honestly there are so few non-ident trailers that I don’t think they can
> be listed as common trailers:
> 
> 1. The Git project doesn’t need them (e.g. no bug tracker)
> 2. They seem mostly for use by other projects (bug trackers again)
> 
> With this list:
> 
>     git log --format='%(trailers:only,keyonly)' | sort | uniq
> 
> If you filter out the ident-looking ones:
> 
>     grep -v --extended-regexp -- '-[Bb]y$'
> 
> There are few left. And some can be discarded:
> 
> • Change-Id
> • Message-ID
> • Fixes (pointing to a commit)
> 
> So to address your point:
> 
> 1. Maybe this is so niche that it is not worth mentioning; or
> 2. Maybe give a concrete example like `Closes: <bug link>`?

Well, we don't use "Closes:" trailers, either. So I'd rather side with
your (1) and just not mention them at all.

Patrick
