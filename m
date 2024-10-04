Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9C1FAA
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022395; cv=none; b=ioEEvRCwQqLiw4YhL0r7oMW/ktlm1J/SXoQF1PkSaCs1Em/sY8dqprqQizkpDU+mvDaWPi4vHr5cXz/eqr9ubfBtGNAS/1MOG8k3Wr+YzNPN4iYWs/0/wsCG/f+y5LOAwzVHql93Fa2koA1eGMDLQQKRORwTtKyfWu2HIbG6P7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022395; c=relaxed/simple;
	bh=2oFwZlDxEDvf+QoDSEXWx5pe4FaNk03JUqMbvCAY/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2ScERHd26S+L/JN3E3TFbduHWkf3s0WQKsgPhNErw5IIQsNapsd7912gVsQNxZRzGGsgiUvYBVx485YE1w+ZImLwiQaxDO+l7JugUwnRBhf1p8LQGld4+yXvv/fHoKphOPNh9ge+0Xet/g5ZfFlYDo2fMfMUDGHKneW/XyhV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hPhX8i92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkJbNHT5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hPhX8i92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkJbNHT5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CDC7114025A;
	Fri,  4 Oct 2024 02:13:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Oct 2024 02:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728022392; x=1728108792; bh=ye5OQ4zS6E
	JAsS14N3AbUGxV1V3FINE5vvNlDA2ikZk=; b=hPhX8i92oPJVVoiZBMAWNKGCHX
	rGY0T+ucrFlRsIMWT7TfQVHaddQJHW95m6SWY0/TJqkrmquHBSJUUN+To6BQH7It
	GJFwXyMDNAU1xvI8QLghkkXMn8UiMyJtQITjnqOtCtJq8v63FsOcgCZShpCQlJuK
	P/gXIHxeOUq/A7IL7Kl2sivFgdN1bwGk1dVpmfdVG4afEiSYwCGTHq67BNc81lpI
	xmt8hWUd0DyBMv84iwVza1dUalW4jx1UcTduMigr0/Ib7xci2eyPa5eWU5wNNaIr
	DvspoVUopsu640RNlxr5hscQoA2EBIf0oohuZ8WdrdlY0XKq4hv7gZtsvCXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728022392; x=1728108792; bh=ye5OQ4zS6EJAsS14N3AbUGxV1V3F
	INE5vvNlDA2ikZk=; b=kkJbNHT5AXI1maBKV5rLMSoVtzKocbon2K5IXb9pgJQ4
	2fy+5BdGqY1i024XQQj6MBEpnksmfdd18fZLmXdYKzWXMfeEFRJWMh2QynmE/dK+
	gWha0KKh7zX/O2hT7hcMRwjL2PBmLyzoNPTWcHL9NTWveCPooR7n0VKJPt5+eJoD
	mDPIjfInYyHYcVpKWIYjEEuC1UYLmwiYKk0rxt2NWeF9d6EATmTLgoO8l2xXinm/
	BsUVKQAPTjLysTpQkF3qLElywaGZnf+yF76TIpL3h8ZhEZ7pcJ8WwZCCmwNpvfwP
	gmzAyxjrvLAGYXweSuSRemFBfAjQyIP8nvPNjXl9wQ==
X-ME-Sender: <xms:d4f_ZgR6OL2k8rM5dKwkM3iiLgjahEVU0jBf1PARS_BNeWnBONocKw>
    <xme:d4f_ZtynUYpZcmFVkAsj6vDd990Iuohu5o5QJfhLPGCGETgLQ5Jaso8gIm6XOdiov
    mQ-mHIczPGX1k3x9w>
X-ME-Received: <xmr:d4f_Zt14xL_yLhaV21Tpne-lMAu1baND2yeicdU_HPqzn-xr-Vmh_7vCeMYlOMXksc5p4NFyzKNZ8N4KkHwqsvVmNoEWYPQ_GiNHqxWjaU4M0Oid>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghm
    shgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:d4f_ZkBw3YEDmOcMuvtdVyW7-bZh7K4nfnGePI9TFOajVh-msaT8uw>
    <xmx:d4f_ZpgPZnU7Qa5me6nLac9R6ur41fTn3z5gYPd_IIrcsdcWdpBO_w>
    <xmx:d4f_ZgrQfV-182-AZxcrafYLWQEmzI6IIrNTh8o5-RcTzAW8OlnKVQ>
    <xmx:d4f_ZsghUJmNrGVxCb4GGpaXovfRuKR6bb97ZdhAl0_xXd-xF-hrgA>
    <xmx:eIf_ZutsiKBjJ_WCJmcf1NilA0linAus6XAP351lP3_eIrB5rEWxVIdi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 02:13:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6200794c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 06:12:16 +0000 (UTC)
Date: Fri, 4 Oct 2024 08:13:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.47.0-rc1 test failure on cygwin
Message-ID: <Zv-HbT8qrM6IYKb4@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <Zv9oIrKveu-JAGQM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv9oIrKveu-JAGQM@pks.im>

On Fri, Oct 04, 2024 at 05:59:30AM +0200, Patrick Steinhardt wrote:
> On Fri, Oct 04, 2024 at 02:02:44AM +0100, Ramsay Jones wrote:
> > Hi Patrick,
> > 
> > Just a quick heads up: t0610-reftable-basics.sh test 47 (ref transaction: many
> > concurrent writers) fails on cygwin. The tail end of the debug output for this
> > test looks like:
> > 
> [snip]
> > 
> > t0610-reftable-basics.sh passed on 'rc0', but this test (and the timeout facility)
> > is new in 'rc1'. I tried simply increasing the timeout (10 fold), but that didn't
> > change the result. (I didn't really expect it to - the 'reftable: transaction
> > prepare: I/O error' does not look timing related!).
> > 
> > Again, just a heads up. (I can't look at it until tomorrow now; any ideas?)
> 
> This failure is kind of known and discussed in [1]. Just to make it
> explicit: this test failure doesn't really surface a regression, the
> reftable code already failed for concurrent writes before. I fixed that
> and added the test that is now flaky, as the fix itself is seemingly
> only sufficient on Linux and macOS.
> 
> I didn't yet have the time to look at whether I can fix it, but should
> finally find the time to do so today.

Hm, interestingly enough I cannot reproduce the issue on Cygwin myself,
but I can reproduce the issue with MinGW. And in fact, the logs you have
sent all indicate that we cannot acquire the lock, there is no sign of
I/O errors here. So I guess you're running into timeout issues. Does the
following patch fix this for you?

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 2d951c8ceb..b5cad805d4 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -455,10 +455,7 @@ test_expect_success 'ref transaction: many concurrent writers' '
 	git init repo &&
 	(
 		cd repo &&
-		# Set a high timeout such that a busy CI machine will not abort
-		# early. 10 seconds should hopefully be ample of time to make
-		# this non-flaky.
-		git config set reftable.lockTimeout 10000 &&
+		git config set reftable.lockTimeout -1 &&
 		test_commit --no-tag initial &&
 
 		head=$(git rev-parse HEAD) &&

The issue on Win32 is different: we cannot commit the "tables.list" lock
via rename(3P) because the target file may be open for reading by a
concurrent process. I guess that Cygwin has proper POSIX semantics for
rename(3P) and thus doesn't hit the same issue.

We already try to emulate POSIX semantics somewhat in `mingw_rename()`
by using a retry-loop when we hit `ERROR_ACCESS_DENIED`, which is what
we get when the target file is open in another process. But that
seemingly isn't enough when there is a lot of contention around a file.
So I'm currently investigating whether we can adopt something similar to
what Cygwin is doing for Win32, as well. I assume that they use
`FILE_RENAME_INFORMATION_EX` with `FILE_RENAME_POSIX_SEMANTICS`, which
should give us what we're looking for.

gh, well. Turns out the implementation of rename(3P) in Cygwin is 500
lines long. I guess this is a non-trivial problem :) But they of course
have to handle a whole lot more cases than we have to. But my guess was
correct: they do use `FILE_RENAME_POSIX_SEMANTICS`. The catch is that
this flag only exists in Windows 10 and newer. But that should be a fine
compromise.

I'll try to wrap my head around how all of this works.

Patrick
