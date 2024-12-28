Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE63635
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735374489; cv=none; b=EXtCPXxA8ou1cge+D8ZEyrYEBHyvbcWz/es0V9KjtCLQ2sxpFFAsrloenCwsN4xm5wJDQUk7pZhpXXSS9CRjPLduTjhjhKJHdDOYZ/OpkSwpWMBfoM+DjOBYmAL//FlCGsn6l2KFRkjEpF2CdEthRKc9v7QDJc3xhzehGUXKPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735374489; c=relaxed/simple;
	bh=dSnctCudF1tSZQ0egB9YGhpqRYF5ffJavtOf/0CtAP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQZq8HGrQhGBQek7X+ZgVr6ZO9grtDUQyUgA/yUIYk9GC4gcs+xlNAI7o+r+Qj4+YXwFvEGox65PenrNXccC74XMDEE0GUdoS8EVAb2cbqjJ/n1Gg50UCMa0p1FOx+7+KQlQQe54DlZCx8jtjyUcMudZL0ceODzHrVydM7DnDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xk/9jefK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lf617azh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xk/9jefK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lf617azh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 91ED11140143;
	Sat, 28 Dec 2024 03:28:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 28 Dec 2024 03:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735374484; x=1735460884; bh=sbD9B+U4BG
	AXml0+AY48ayr26J3IUxkDQcB+7vvmnco=; b=Xk/9jefKj3XZ7a0jJyvq7AtdOy
	UiXGwhNemL3t7dWacAsiWgDawArfCrlVHth/IQpzJFtxfirJY0sKikP6PB22wu0w
	ehvDTEhYbJTB8qd2JCkDe1gCFFL3cMrjg8wGMoraLpfr5D17dE77yhqma888LRkh
	iOCddWAAhoaSE6d33irArRVCmSJuQys9CgdSq2EyIoNZQ3C13nQLxUwdyhvUS2YU
	F46Zah46Zv6FyHgiqCJhXYH2q8uNhE6/4vmaqsNv4bbBd7e0zYalJ+Vy3vYlzOva
	LCfe+TY9HvpMZByQC9WWQ/BeN5hy+w9XiHhwcXDidN0h5N+2HC1wqrI4DedA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735374484; x=1735460884; bh=sbD9B+U4BGAXml0+AY48ayr26J3IUxkDQcB
	+7vvmnco=; b=lf617azhpNZ2TMC5xbChel+pAZg1TihYRxVDhj+CSni0c+pVxC4
	QqkdiQ7DJJOxUYOyOT2gJ93W2No9oqGf9lCVcHtS28fwnQzWQ8EL6mp5UItgxTIx
	0LQrQCLmvmPplSNw0gViDQTZN09MIfs7Czs4s2n+mi/ICFnTK15nuOJKofXZHDQj
	RPMZlUQGuy7Kyvek4YjObBbo0bFe76A0FMEZLcKOb/STINyGYbWIqie0IgJUeGC1
	bhbRcRXmwFoACZDKXCIQiPCIOJdbLNRnOPwJ+9/mWExa7bPA8RtXtZp448tdMoCs
	G9Zjau3NJj04I+geXnlY/50Sn5Sba4rVy3A==
X-ME-Sender: <xms:lLZvZxqO924yQtzNLEDymrbpVOFEQBHNKFXUdqqsUiXvRcNj1s0i3g>
    <xme:lLZvZzr5AH08pC4YHl2cWlqOV4WiGOdTL2iLA8TkF1ocLoHQ84C3tgTX_Vza5oRo5
    SM1T7-ZfgF8Fy3NfQ>
X-ME-Received: <xmr:lLZvZ-ORLB6k4ipA7VOmoDG8aV7TDnxL_c7qFYBao6Ng-gqCJuF2wiNNt7-UqmNHEE08dqfxN_LiAyfXgZnzPUt0pXCn1w0wBC8Kz4n0e670GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefhfeeftd
    etleeugfdtuefgtdekuefgleektdehgeeikeduudeuveeghedukeffnecuffhomhgrihhn
    pehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:lLZvZ857M4Dk7s7odGzbEwj2ykrNU1Sp1xEmXoKBsfh6TlWOQ6N0-w>
    <xmx:lLZvZw6PUtka0MgdPCQy5oPMiIjI-woU6Tyh9jkGdBnxjgv7uOE8KA>
    <xmx:lLZvZ0gZfDpNjrYNFm9BtexDaeMh8W7MnwoWGu8yJrnIPlI9UjxTcQ>
    <xmx:lLZvZy4Fi5ZDvByO78aG11JyhV8FaWOVpjaeV8gGmeq-GwTJlUsqUg>
    <xmx:lLZvZ-lfw-IsRMdUdsKzAuavTmRbXeXaM_3I1Eok_NDTl6Q-tubF9yaJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 03:28:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99a1e1c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 28 Dec 2024 08:26:13 +0000 (UTC)
Date: Sat, 28 Dec 2024 09:27:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
Message-ID: <Z2-2dbYVuuLxpNmK@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjww65i1.fsf@gitster.g>

On Fri, Dec 27, 2024 at 04:00:38PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So perhaps something like this would help?  We are no longer making
> > a comparison between two integers with this rewrite.
> 
> ... and this gave us a first "pass" of the tip of 'seen' for all
> jobs since for quite some time, like a few weeks.

Thanks for your fix. I'll have a look at whether I can include a 32 bit
job into GitLab CI for improved test coverage here so that it does not
fall on you to fix up things like this going forward.

Overall, CI has been in pretty rough shape recently. Besides the
mentioned failures there's also been the issue with flaky tests:

  - t5616-partial-clone regularly fails on macOS. [1] This seems like a
    race condition or to me:

    error: unable to open .git/objects/pack/pack-029d08823bd8a8eab510ad6ac75c823cfd3ed31e.pack: No such file or directory
    fatal: unable to rename temporary file to '.git/objects/pack/pack-029d08823bd8a8eab510ad6ac75c823cfd3ed31e.pack'
    fatal: could not finish pack-objects to repack local links
    fatal: index-pack failed
    error: last command exited with $?=128
    not ok 18 - fetch --refetch triggers repacking

  - The leak-checking jobs fail quite regularly in t0003 with something
    that feels like either a race caused by a leak or an issue with the
    sanitizer itself [2]:

    ==git==17055==ERROR: LeakSanitizer: detected memory leaks
    Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7aa0d03c7713 in realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
    #1 0x7aa0d0221f69 in pthread_getattr_np (/lib/x86_64-linux-gnu/libc.so.6+0x9df69) (BuildId: 6d64b17fbac799e68da7ebd9985ddf9b5cb375e6)
    #2 0x7aa0d03d9544 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
    #3 0x7aa0d03d96fa in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:614
    #4 0x7aa0d03cb2b9 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:53
    #5 0x7aa0d03c756a in ThreadStartFunc<false> ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:431
    #6 0x7aa0d0220a93  (/lib/x86_64-linux-gnu/libc.so.6+0x9ca93) (BuildId: 6d64b17fbac799e68da7ebd9985ddf9b5cb375e6)
    #7 0x7aa0d02adc3b  (/lib/x86_64-linux-gnu/libc.so.6+0x129c3b) (BuildId: 6d64b17fbac799e68da7ebd9985ddf9b5cb375e6)
    DEDUP_TOKEN: ___interceptor_realloc--pthread_getattr_np--__sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*)--__sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*)--__lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType)--ThreadStartFunc<false>----
    SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).

  - Windows has been quite flaky since adding it to GitLab CI. No idea
    whether it's the same for GitHub Actions.

The thing is, the less reliable it becomes the more likely it is that
people are simply going to ignore its results.

I'll try to have a look at some of the problems on Monday.

Patrick

[1]: https://gitlab.com/git-scm/git/-/jobs/8671168627
[2]: https://gitlab.com/git-scm/git/-/jobs/8671168849
