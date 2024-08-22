Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F32D611
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307561; cv=none; b=EDGUJrtOzoVAft1+FrafEAw6KYCck/+9tb5Zmio1j8BcGnrn3e/i8CvVHzYrzVIPPkG4BTKru5Xlj6m9QOn4hJIdykYvOVR/72Il6maYyuiIDmthZ+3pw3kjZGXB1OFLZ7RFXRrbQd4dhT+4aV6JhjWEXrkPCTBB7K23Tm6mF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307561; c=relaxed/simple;
	bh=YDUura2jJNQXK2MhjpIg6Yi2worMkDqiyoooNhAPJ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8QrJE+zGJEpDufjKH9KG4BhHlfkUoBJPAKwgCTnbaTiVcWc1Ph5djpQnD5SbYOp/4rP3y7RsjKnlfdzgAA9bhM4HhtfMxNUUGkV7MMNcZow3lqbZYu9B3gFvG9I7Tvlcaj6BRwQcywDroaGF27wsAAAEdMXKPdbZ9kW8DLOW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GL6x9/V7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=la8d9j2B; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GL6x9/V7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="la8d9j2B"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BAEA21151B89;
	Thu, 22 Aug 2024 02:19:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 02:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724307558; x=1724393958; bh=nGVC89XpQM
	orglOjM6pq6maSWCdA9nWgq4fTidHKCEE=; b=GL6x9/V7VQIkzO/YcQWOgkUnph
	JcwActnO1BGKz3mY198PS4KzSyjFezPJfFfQzc1n2hW2npe6iK4Lhf0s/CIhucSz
	qhzozA5B3qFgbWly1EcBqInpzAhu8wq/H+B5knRwQ9/0IQXUnEUl5uAPeM9DKDQ0
	c2Zdptc7bBvjKiYcgkY7gqqfKd5UhE41ov7NmQaX8vNxybUP1RDjZGep6WsMB0dI
	USRNx6ime2ik4lfk0i1nfhoyJ0o9Uk4sFPD9x4JzV0KRGjKFUFUlFA8N9XAnwRg0
	2gBegaPeSD0yFE7XqdeB8kVHfOI1qO2VzeCVXVtyR/PYbDHUtGbwwOkzOOOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724307558; x=1724393958; bh=nGVC89XpQMorglOjM6pq6maSWCdA
	9nWgq4fTidHKCEE=; b=la8d9j2BBmysGPXMnb7dANuYr01rtmI0+WPCbvNj9rt7
	U/PmrNpMkmMczN7Z5Zyv84VhyDnlTzqnW48t4Q8zrLZlVuFBNMaD/2SOsoFkCjTi
	h39Lf8fWA+ME02rm4Eb2fb+wpt1vfF/ZB6MxGh9uPDNFK8UmIWxj5Ysw+80VRw/w
	FskIMGsWSzRanDRqrL9QGtVbpmBL6D+4QZqqe3ZWQEdMxCFLsr1wSZCha+LfWuLh
	bnww2/4nrlORwPGGKX9osDg/7jp+SqfJqTgmPu/P3vAxmt8irX/NbPokW8O/a5aU
	TlHGFROJS2bC6KgAuXucrcPFxv3SqtCOl0gUp+S4/Q==
X-ME-Sender: <xms:ZtjGZkixfGygvt6c31NjEgXXEyuJIIAbEayqbjGKM_Jle-4a8Fn4LA>
    <xme:ZtjGZtBHtF4qUIs2Hvnt5YhgYjlmhQwyWn5t0PqQ7hkOaLBKti6HJgh6JTK8nUraz
    6bhYA8b1ppwmzGI6w>
X-ME-Received: <xmr:ZtjGZsHLZ9bPas1y1RVHTtWXs6LF4b_3awndqM4km_1PsQ6rZzulJGEoNAZyE_uaIksiyQEmxoaX6dMl1vszVhRMJ69Eu4Q1co1w4GWdnm6J5oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZtjGZlSTEAT9Vzttm5A3qmMT3RYrS5sXGAJPAT6iiLyC5HkrbynHyQ>
    <xmx:ZtjGZhz3H4Xzx73at5qHscitV3bb7Hz-Ee8iuJDMInwn37oUjqoQSg>
    <xmx:ZtjGZj77Vf1icAYkGvKQvYLpVGRVglR3_vOsbFfq6vcyhVyo90aYuA>
    <xmx:ZtjGZuw-G_E5LlC4c1TJj91x8gwpDC79IXl_A-yfAiqVTcRhuETSlw>
    <xmx:ZtjGZon4GIU_L6ff5Z5Hyfe3fkIi55vdYlTRYyzh5KQu4ABpNMesW8VA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:19:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7143315a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:18:42 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:19:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de, james@jamesliu.io,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
Message-ID: <ZsbYYo3pLUAmBU0e@tanuki>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
 <xmqqbk1l25p3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk1l25p3.fsf@gitster.g>

On Wed, Aug 21, 2024 at 09:36:56AM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Advice is supposed to be for humans, not machines. Why do we output it when
> > stderr is not a terminal? Let's stop doing that.
> 
> Last night while skimming the series on my phone (read: not a real
> review at all), I found it very annoying that GIT_ADVICE=1 had to be
> sprinkled all over the place.  I wonder if we want to instead set
> and export it in t/test-lib.sh and turn it off as needed?
> 
> The end-to-end tests we have are primarily to guarantee the
> continuity of the end-user experience by humans, and ensuring that
> an advice message is given when appropriate and it does not get
> shown otherwise is very much inherent part of them.  An alternative
> workaround to counteract the breakage this series causes of course
> is to run everything under test_terminal and it probably is much
> more kosher philosophically ;-), but compared to that, globally
> disabling the "if (!isatty(2))" while running the tests, and
> temporarily lifting that disabling during tests of the new feature
> added by this series would be easier to reason about, I would
> suspect.
> 
> > This series is motivated by an internal tool breaking due to the advice
> > message added to Git 2.46.0 by 9479a31d603 (advice: warn when sparse index
> > expands, 2024-07-08). This tool is assuming that any output to stderr is an
> > error, and in this case is attempting to parse it to determine what kind of
> > error (warning, error, or failure).
> 
> The "anything on stderr is an error" attitude needs to be fixed
> regardless of where it comes from (tcl/tk scripts have, or at least
> used to have, the tendency, which I found annoying), but regardless,
> I thought we added a mechanism to squelch all advice messages for
> this exact purpose at f0e21837 (Merge branch 'jl/git-no-advice',
> 2024-05-16).  Why isn't the tool using the mechanism that already
> exists?
> 
> I would have supported the behaviour proposed by this series 100% if
> it were on the table when we were introducing the advise mechanism,
> but unfortunately nobody seemed have suggested it back then.  I am
> willing to go with an "experiment" to change the behaviour,
> deliberately breaking "backward compatibility", if we have a wide
> support here during the review period.  FWIW, I think any scripts
> that scrape the advice messages are already broken.

I continue to believe that the biggest issue in this context is that
there is no proper interface between Git and its caller that would allow
the caller to learn about errors in a machine-parseable way. Matching
error messages against regular expressions is bad, and can easily be
broken by the output changing in whatever way. This may be because the
error message itself was changed, or it may be because we have started
to show advice messages. It's extremely fragile, and from my point of
view there is no good way to classify errors right now.

I won't argue that checking whether stderr is empty or not is good -- it
almost certainly feels wrong to me. But that's only one small part of a
more widespread issue. Having structured error handling in Git, e.g. via
a new structure that represents errors as discussed a couple of months
ago [1] would go a long way. I didn't quite like the approach chosen by
that patch series, but think that the idea certainly has merit.

The other question is why advice is being shown in the first place. In
theory, all one should ever use in scripted usecases are plumbing tools.
And as plumbing tools are explicitly not designed for users, they should
never show advice in the first place. I guess chances are high though
that the scripts in question used porcelain. That is also understandable
though: our plumbing tools are often not as powerful as the porcelain
ones, which has been lamented on the mailing list several times.

So I certainly get the sentiment of this patch series, but feel like we
continue to work around the underlying problems. Those are rooted rather
deep though, so fixing them is nothing we can do in a release or two,
but rather on the order of years. Meanwhile I guess we have to find
short-term solutions.

Patrick

[1]: https://lore.kernel.org/git/pull.1666.git.git.1708241612.gitgitgadget@gmail.com/
