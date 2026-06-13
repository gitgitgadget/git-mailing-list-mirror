Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB036EA82
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370368; cv=none; b=GUkQ9hvAEfpvjSWhIQiW0h8CJpntJ7aqSge7WbObvyD6kkT2zPEVXexyxfASd+0em4s19YjVFWHpF/v98W7nLVZpuBPJOJwJKkp+Q1qlKG1fkjPFRIOcYdwpUBfwWYFia135T+ZDDz6mm3DwlnvuATHDFz03FnOlZwYynzS/zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370368; c=relaxed/simple;
	bh=eVevgY6XCG25Mf0RAPn7DgyphwpQ5cAzp/wFnyOwMvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3DYyedJHNihP605CrScrNv9tBdg3tHhpvFY0DWO0H8D1iNsaCHX+d/AoB4XH6LDinY8QHD0UwMjKpx0uMZ4sNinQQi3OgEkrk5m3x3WyfaFuGtAiHbNlImlExp8dRLoj+MGfGj0FrSXb1tUZMNIWc2XzvhdSFz6YBBG+DSDKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=mZRqdn/k; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="mZRqdn/k"
Date: Sun, 14 Jun 2026 01:05:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781370360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSCxiSyVW4mgH6rVnjtk8M1+1sJef1XbArxJ8RSQ1Ak=;
	b=mZRqdn/keWsNiXIGkbGyDkd+NO9R7mRFy6KWdCJBuHYYy2AzwAN/Y3/cHw2v0+zj53gwNX
	192FHiOBfryVZ8sufi6kZJJi2slQHL5EponpFjF0ba9tq+EzI4Vr0uJVcN3MTPM5PampQD
	0fsZDBmpeqxybPR9T+PmWwypb09yEbaSYuYhpR79TFdDRuqN7a7iKQoKLEJx2HxkjcoJoN
	7I/dh/lsy3aqX8kX/QbXvZHoB9mqkHeR0it6GI9MD2+zNRElXcCaMShcyX+fmK7L/taUzJ
	DA6gujGt7wxJvdAJkNjFF7y9zLrEQXu/6ybm9oHhuUTJTSNyXPnKXB0pvFKXmg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [RFC PATCH 2/2] doc: advise batching patch rerolls
Message-ID: <ai2NwMS-i_UTWR5T@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <8166623d1599fca2cd4614889e4a69b2006c12c1.1781358364.git.wy@wyuan.org>
 <xmqqwlw2e8dc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwlw2e8dc.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 13, 2026 at 09:02:39AM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> > Contributors often need guidance on how quickly to send later iterations
> > of a patch series. Add a rough default of no more than one new version
> > of the same series per day so feedback can be batched and reviewers have
> > time to comment.
> >
> > Mention factors that can affect the timing, such as series size, review
> > depth, substantial rework, and how close the topic is to being accepted.
> 
> Another good thing to discourage yourself from rerolling too quickly
> is that such a practice forces you to think twice and be very
> careful before sending patches out.  As you have only one chance to
> get it right before, say, 24 hours, you'd want to make sure that you
> would not distract your reviewers with stupid typoes, off-by-one
> errors, and such, and concentrate their reviews more on what matters
> more, i.e., the higher level design, choice of algorithms, etc.
> 
> > +This consideration applies not only when going from the initial patch to v2, but
> > +also to later iterations of the same series. There is no fixed rule for how long
> > +to wait before sending a new version. A useful default is to send at most one
> > +new version of the same patch series per day. This gives multiple reviewers time
> > +to comment, lets you batch feedback together, and gives you time to think
> > +through the comments you received.
> 
> And the 24-hour gives equal chance to comment on your patches to
> anybody no matter where they live ;-)

Thanks for your comments above! Let me think about how to integrate
these contents with the patch.

> I see you CC'ed Patrick, and I am sure he'll give us more useful
> suggestions than I do here ;-)

This is his practical advice, and I just stole Patrick´s wording, to be
fair ;-) so of course I should CC him and let him know I am a wording
thief :-P, hope it wouldn't disturb him ;-) 

Thank you very much.
