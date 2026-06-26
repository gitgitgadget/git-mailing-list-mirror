Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13D3BE647
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503063; cv=none; b=lFvlc0QDqRVD7z281Hm0g8jeyHJjWPawnFt0bLxrXkN7U03seq4ezAVeKo7jZVkJ8NN4gD1wRnQXPUcJzBRbIEjt/uNg2Atnp0xR5Wjh0idtIKucZBOCHIsRtT3yirJVTKlzlEy8hbms0sZR/r80LyGLXWsTsdH0e7VLSGziCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503063; c=relaxed/simple;
	bh=+qfXLVDd2daMQKLs1OGXhf9bcS6Nf9isubxRi+2/8+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNghqatwc0/b66HSFrpDGPmyN1riEAqCWD8rS8y+vgHo4MWwH1C0TxtaCO/Mofr6Kd9dk6ktcuUxRNNitxt7y5G+yg5KfotiJtXxn1AJfVf50SM6+wSwbkx2964HjL4olJmlffs1nmLh22bZf9ubAdynJZT0+xd8qAqHoqGEVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LaPfDMnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fK/q0nIi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LaPfDMnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fK/q0nIi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 86F1F1D0014F;
	Fri, 26 Jun 2026 15:44:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 26 Jun 2026 15:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782503061; x=1782589461; bh=F6qEjSw1+H
	Xsl9vXUGqbXbXb+UHgN50CvX6NSWjYhKw=; b=LaPfDMnH+/mhLUWyxXCqRS/dSE
	ZRhWJB1D/d7rHOzqtMpC9+fBKMLjPqBhJmDmMHrKpD8Uuob80XFkyhqhTQq2DJEf
	IY9OJcnrqatcB5hLPK/xFBooAmqUVYJP89XEw7tYexBxM0H+ERH7Wf5SkEhVBUOE
	9z2rkr8qvKvA/1qIkM1xK/nGDcUgV7WrMh1o0JDe7nZx/DsuD8H2Oi2DA/G4omLK
	7Q31gdHpeIgxeo10fTPsejyQeWWfaJS8D0jRWB+4hqYlumU+lAXLLqAGvBBPOIEz
	WWc/0E8pVDRBvNcp96807455URuACEpeTeWTM2a+UdIriNQW8tjM8lg2YCjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782503061; x=1782589461; bh=F6qEjSw1+HXsl9vXUGqbXbXb+UHgN50CvX6
	NSWjYhKw=; b=fK/q0nIirDAYXQhVz2tKDycsQ2cn0oOLcORmCfZxwjifbShjSQm
	YLbmwPakm2GXWmBoP3s53zXgrZAY53C/kULKuuopFyi9Trk8zX6wBvHN2hOzwmFd
	x/cC/oXA1fQHzWsDYrWv5ZSIJ4tYGb0QZg4Ulb1WfIJwNs90EINpaYdGyf9Q6Xdm
	MB6pOQBnVwU2S5AC9PGtEQExvZodtcc8RFDmVpnwfXpvSEgiga1xLv3aY6TOGbzi
	FD2EyhrFAPgxxCSV5UAg6drG8YKVvFdTJ28YAITvyHmSk6Urxjqw86YxMMpIWXFu
	7pfg9O6xvoFpV5Z0iZfbWb0zLIiZxt7wn+g==
X-ME-Sender: <xms:ldY-aiJklRIW1hH69AMOVzAPJsojukveY7gWLqMvMn9CZbQbntLI-Q>
    <xme:ldY-ahAVFwiNuzqkccR2-QN2nQ3MaMI5oqMSMfBmGzhT-M8wVnBZeKyn2_Je-_M37
    bVH27fYXX4tgKLK2BP0QA9Y7k-mMtYyesaHEdwaHII-RgrdFu-m>
X-ME-Received: <xmr:ldY-arDqkhzDBM7XsajucR7TiA7jTjKYnzR52iFNbJpLDWxapWmyL5ZuP_DtLDyCPUnvcZDOzeSk4suuPtB7PUdPhdd9ZpDcYmCiO130j0I>
X-ME-Proxy-Cause: dmFkZTGJZ2YnjoaTLd1i7e46PSJJP1WMG9JJyPJLp3KzWCc8s2nw13Wq3UqthWgN5nSwRE
    Ui4BboWbBz7bEB0rxYVhugjFzDNAZ4qHpaGnsOCu/TaaeSjdIjDf/mLM3OFQgv4B4sdPRE
    vW/6TruQ4P2AcuHU42MyNEwXHJKdruwMVXQqFyKkHHuJ6smSkiwrDWIp06349xwFBWOcNC
    JpjgxhywnJ4P4fj6DZK+TVphoGUMb9IB9810gXZQ/f+sZ94Q1sd1utjNoROZ4s2uZdVqC9
    wlJmFdRZdqmZEawL5fWg/YFTR6p39TA7TC+M9FLJpP1Rdit9YIra03IIJt1qIRt9BVuIli
    bhSJMtExkqSnPHAAf1+ltd4vYGFYWtvyt9AEWZ8ZXy2mYzKqStqkr599n2hgsl02MJ2NKF
    PFT4cA7NNRcBf8/DmTSKa870lWY8J4RA2UyXwEMOFtoteGaiLdM3GcYaDo9oCp5plS8MoC
    3fXooqBra5pFhPY8O2Vu8u0yKZbnvD1f9H7A+/qzJK9yfCagKCFg9+KFS9s9bZhY69j/mI
    MZBuvKx5e0HQ4xAAt/1jpr1PkQ5CkB3pgXNycRQsJa3vJv2hTw1OG1oli4PG1Lv68JE9e3
    PnmdnAj3bckPwO2IraizDj0VjoMTmhR0CzZ3vg9tWEctR+7lsVXHlu7AHQmw
X-ME-Proxy: <xmx:ldY-ajA3Sakx9no5wd1a7krSsLZpiKPEPVEKwVulTUr6v7u4-ceOFg>
    <xmx:ldY-ampcF5HDJSxYkZ52Clcx8fp_EJR4g1E7txO423pRx2a_URDL0w>
    <xmx:ldY-atnureVdtnfb6MJWzGUi2j9qQ-gCK7c_-TNJiIA3d4VqzJjrJw>
    <xmx:ldY-amzw6sMnmaqmwbO2PH26sCkPb3hGnBx-KNZBHaQ-LR4zPGiF3Q>
    <xmx:ldY-ajiDuaQ0kMCyc3G0qfYA05GJYeQdramoETMEG0NjE55XKx9N8YLB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 15:44:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33a71c0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jun 2026 19:44:17 +0000 (UTC)
Date: Fri, 26 Jun 2026 21:43:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 00/11] refs: fix "onbranch" conditions
Message-ID: <aj7WfJqsPYzJ4nLf@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
 <aj1DuUzusBUqmF_C@denethor>
 <xmqqse6ae45i.fsf@gitster.g>
 <xmqqmrwh9vl4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrwh9vl4.fsf@gitster.g>

On Fri, Jun 26, 2026 at 08:20:55AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Justin Tobler <jltobler@gmail.com> writes:
> >
> >> On 26/06/25 11:19AM, Patrick Steinhardt wrote:
> >>> Changes in v6:
> >>>   - Drop redundant condition when setting the default for
> >>>     "core.logallrefupdates".
> >>>   - Leave breakcrumb for why we lazy-load write options for the "files"
> >>>     backend.
> >>>   - Fix commit message typo.
> >>
> >> Thanks. This version of the series looks good to me.
> >>
> >> -Justin
> >
> > Thanks, both.  Let's call it ready for 'next' then.
> 
> Ah, before I forget, as the focus of the topic shifted dramatically
> between v4 and v5, I think we should rename it to something like
> 'ps/refs-onbranch-fixes' to reflect the fact that is no longer is
> about chdir-notify-parent but to fix "onbranch" chicken-and-egg
> situation.

Agreed. I also changed the subject of the cover letter starting with v5
to reflect this, so updating the branch name to match seems sensible to
me.

Thanks!

Patrick
