Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50173381EAA
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291130; cv=none; b=lbO3+rGJAQijXzWGTEHA/lDpgHqnFnRp3I0mqlT2CawjpT7HwkJV3o873cQx8TWXRoGo8sPqsebKbst2U3H0E5MTkelL/NZGzGm2drdmEEgDYicSFTNI2MFb0OA2HJH5hufOVqi/uyNi8H2IwRlbKHyBVcInvuoVVamos+F0dxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291130; c=relaxed/simple;
	bh=OOkj71l4YtIruTul0vy8caRWMcbJtwgZ5pNNCwcTMYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvMCuXBIabRh+WakUvzFNhXN2EyS/PvFTMurG5jdRZB2sup+5aCqhQC2x0nW1nsFCejpqMZa3b86D53DOHM+hYj77swMHog26b97PkPfLAwQHhLkbwDtIE+c4Ci51loREl/2jkVtmDUktxTwZ3FdUkYspwxuH/OK1KHEbRnKCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V6ftKaVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RajjXdgZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V6ftKaVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RajjXdgZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6853CEC0273;
	Fri, 21 Aug 2026 01:45:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 01:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787291127; x=1787377527; bh=0CFCDC7Z07
	bHybDh8Q7oNxl3/TYKlVZApp3sg7ER8c8=; b=V6ftKaVk8OHXoG3ZM/XoFyXFdJ
	VL6WEVLdOpa1wMZ0fpoVAiNyMR9vJU0B56nEAlsRf2ImizUY6aMyuQMP5agW4qIG
	1UgCdjfIvn7pSuD9GRtGGLKX/ptwTy1yY9U2PncqMSejogTdyMBvifCF1KxZNABu
	Gi4sWSnqbuDKhaAm/6UnO81spmfCU335QPy9Whv009Y9JGy0UmQBGKULIQ2KZhBs
	ugfc9czzXGp1KKpvXTJo6NVhCFjxoXKJmYcPTpJJAElrhCrdSbsv/tJVqy4HLZSv
	1SqkEe5IDJ87qDbbNC3gPpYxttGc7ulHNkvx0eve2n7qOwfV+ZGrN+tzc6qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787291127; x=1787377527; bh=0CFCDC7Z07bHybDh8Q7oNxl3/TYKlVZApp3
	sg7ER8c8=; b=RajjXdgZJ2WopffAHSc1xOG5ccfvBBngnBkIVWJT62cQKhR11Nq
	yr70YH/spzag3HbmgYwHez3CTR0ylr5XCiK6TkhIYK8jOiUq12qu3aDW2PcwQjZc
	nlRzS5mOQ/x0szp2lpo1EgV0dhms+X4Sk51D2Fv+WQJ0DHaF37R9VO3sHCDknJjQ
	bMeXHV4IxfZ0SmbufuCGQF5Ap4sXbDzrCPkqi1pwLPf8gNODPbyvJ3UfqpIkohCJ
	mp/IPmhmHH1GPWtjoPfm0d4iCeFBbuk2hOiCVXhb+LY2VYcXdQelCcW8IyCk8pDc
	nxet8hyFQYHwNQvLUaGl1QABg4xGVJb9MPg==
X-ME-Sender: <xms:9-WHanxOqTmyBRBufoAboyd4wR0wQD39iT12J2igEfe5hqdOfnz-cw>
    <xme:9-WHamvKuz2UD4LDiHtF6HbIj6KKuP8UlNbfqJifNkT5owk37CfavNXHStX0TA3KQ
    9UGfptmDXxn0lEl7aR6VdyhFZ_RJjsIhBohuTThXZBKwwjTt4-83bQ>
X-ME-Received: <xmr:9-WHautZ85kLp4JaZFDnCotK1douvHKnE8SY3tbIX6x2i2gtOa1HE0m6JuWwlffD6ZhEFwS7EuIRYEhNaMtFHU8KeZjOCDrMZOELMoLdie5D>
X-ME-Proxy-Cause: dmFkZTE3LeLiOyJ4/nyRqP9QNSJfZKHJBWteGk83pXNZomQS0sp1jWEevWkVfFdhOpIyRp
    bawlK0cqeRJoN232UxwMgB14Rx/L2rYmmG9NUEmCsvJp0i6oEK2IX1RcgUMrIn5+c8s1KM
    s3nkonLKKftjzPMQufEv8MB8Opz9HoI/XAe3d7iSAlKrCNz/UmxW+fx5WDR+4MvcoVZwDk
    o9BHlr8kRUslHJ8LvSk+gv+cZXpxNcAQOdRZksCRNkBRwEPIjGBz7dpEnS3+SXIGatIzcV
    23+oPY2+IX4sdlCDqOd6HyVFW2kjf7Rt8KjNdzilKqEwbpQkS6L4NC0/kwwEKqRVu1Rkh8
    Fts3i/OYCQ57+gQIl4nry/TwrbrxTfUiGs7vUXjp1nSrmhY6VWxXx/lp8TcN7M1kYP4on3
    lvugFbUHtV6bf1zkWSVyMNzrVmN0WNc8eeo6YxE4pDxDm2mn6rBxlzGu+e4YTLQPhPxRq7
    2ua9JXots3p/n6p8XBivkbIwjNLKK/cR1fPpu7JflPG8RLAF8Zidphys5+2Fq4phrwUtvx
    0zDlQvwk74SX6u+7J4Xw58aqQcEv7rl1gSRDtsY12ixy0CXLgOYGq2kDBPZIix/ehFqwGO
    JpsEH8dDiXRqajB/PBYBm6/TWwkbIyfHf6XD6eehZ1EpnFLtHsUrDdTJP9LA
X-ME-Proxy: <xmx:9-WHarPu1MZ2bRRkxljbdWv8ddAAmFIYhPQBJHJI9-_d1kMqcZRyAQ>
    <xmx:9-WHas3vg6hWLec8ljzQoyqZnsJtgA4nkHmPulF43BQJJ0UTJcewEg>
    <xmx:9-WHanPJLCsygFtYJSzBDaoUYjJoPx-oP--kfWgw9Pma54uWPWI8fQ>
    <xmx:9-WHas0h5nzVh_IfRywqqlV2WxS7etEI4ux4xZFz8sWb7hQC4xw8KQ>
    <xmx:9-WHamuIW-FFshNI6M6g-dZsQi2JsNhhYRvOcBDqKaX6O37WI5gC5iqp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 01:45:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76aa92db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 05:45:23 +0000 (UTC)
Date: Fri, 21 Aug 2026 07:45:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] odb/source: let callers discern missing and
 corrupt objects
Message-ID: <aofl8e4P6BqJaQEm@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
 <CAOLa=ZSSzR+qKh4Do-F7xZQMO-pE+t4N8qM5hsbfM4Uh7i3d1A@mail.gmail.com>
 <aocNsR60-8W2A-fy@pks.im>
 <CAOLa=ZSs-9VU2eKT8DUJ7FzZCAkgRzZ6_XQZBP=x7avxpFp7qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSs-9VU2eKT8DUJ7FzZCAkgRzZ6_XQZBP=x7avxpFp7qw@mail.gmail.com>

On Thu, Aug 20, 2026 at 05:09:51PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Thu, Aug 20, 2026 at 08:56:50AM -0400, Karthik Nayak wrote:
> Oops. Thanks for the detailed response.
> 
> I think I made my case in reverse, but my original argument still
> holds.
> 
> ret_packed   ret_loose    ret_packed != NOT_FOUND ?   returned
> -----------  -----------  ---------------------------  -----------------
> NOT_FOUND    NOT_FOUND    false                        ret_loose (NOT_FOUND)
> NOT_FOUND    ERROR        false                        ret_loose  (ERROR)
> ERROR        NOT_FOUND    true                         ret_packed (ERROR)
> ERROR        ERROR        true                         ret_packed (ERROR)
> 
> So since we return ret_loose as many times as ret_packed. The comment:
> 
> > and prefer the error of the packed source in case both reads have
> > failed.
> 
> isn't true entirely. So isn't it better modified to something like
> "prefer other errors over not found errors" or something. I hope that
> makes sense?

But we don't. As your above table shows, we return errors twice from the
packed backend and only once from the loose backend. And in case both
sources returned an error, we prefer the packed one.

I think where we're talking past one another is that I distinguish
between errors (-1) and NOT_FOUND.

Patrick
