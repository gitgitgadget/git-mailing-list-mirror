Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51E218E91
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422437; cv=none; b=XCZF0yUYVsFBX1C49yRmwZDayn+6s7oEsG8nQKazuc5S6PcSV7q2DxjFhDmb7X3L0U6aLg7LGoLVzwzX3qSuLBNzFIo8oeV9v0t9zWmLbv1MqbZ7pckgXRcgU88QWLDCSBIHXCYrJ5F3pwKdLK9E9Hpxn3bPrgM0QghkR2zivJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422437; c=relaxed/simple;
	bh=YgtBmvEfAGEEx03Pd1Hx/1u11jjddTLaf0fAFMDg/nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByUNpiR5zzT526YcKEVOnYgaQB6EhSdEIy5l/j+43yJ1hySZRK6k9t5Yy7rYLq6JIc/ue0Ecz+7ZKAAE//KZPKaY09bjF3m+gtGcVB8DOZTSDsOkb0ictP49NEVxw1OTU0n+Xbowd6jprMAjvDynjmaCFqypu3Yl9RivuEBfpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xt+ugFCI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIQ7AsT3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xt+ugFCI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIQ7AsT3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 150B51400206;
	Wed, 25 Mar 2026 03:07:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 03:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422435; x=1774508835; bh=vZmbu6XiUD
	bK4cKKtdxxFBzEL0nmyqi2B/OjD197+0Q=; b=Xt+ugFCIusJqt1/P7ZwLxHe7N8
	VLOcJV5aGBPhC2BDin7SV8Vb+UdaWg9IWFIC2QmXbfC3TlAby0duLJ2VDlXgHd5F
	cPUbgS8m0AU/YiTcytvoSjpODTRSiHoXOq24HxKdiF0H7WKt7wNrTkuAcP6ahIoa
	tIhSP3QnEp6+mFsDlUNrfbxbuoBQGMlHJQVyDqMkxY+modNiWD53CRNYRtCeNsK4
	NW/gFI996xXiow5gZmkYd1CQW14O9DkR9Pmwph8v8PB9QmYG2gRUxTrZbG3vSMqE
	RNaI8sOi/tw60fD5RtwaX22JS3fI/1GyIsOzddyWAYp41nvdoArVr9xeUilA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422435; x=1774508835; bh=vZmbu6XiUDbK4cKKtdxxFBzEL0nmyqi2B/O
	jD197+0Q=; b=nIQ7AsT3uWm6/bCrr5o7PXZoA7NVcdVNMoo2t3tCl37XhjlJqgL
	VIVbJywAxHmoRbdKrQ6zdBAZJOcdJ7+czn8wzOQLNh2nBE0SbXH2OQqVaIHpp1qC
	kbw6sssk3iohlDAS5TOm0jvGki0rqkmcS5DQKrkbX+MJrCencRulKLLANR/F7MF1
	sVOqE5cWIvIjFQtE5eXvDq73j0mXH/uBBzfBPD38hP2b7hvPEnS9NZZywHvw95gY
	Pqn+GEBjx8Dfr93TR2sWhw2e3AH+M6XT07xRoGzUJgQtGUUBibGTYpuZM0S9n1Jm
	ui5mRQcfhg2vrX9hBpCDjRKwIso/XOT63Vw==
X-ME-Sender: <xms:oonDaaBgkq1ojS68OZkIRoRVoAyexRj3wti7Xso7p_ROHXxlvE58jw>
    <xme:oonDab_bdO9VaIuHxciwkUlsPt8UxthLRkzvrqy-3CR9dWS7hveBzKo_gwONYF8zm
    -JbRgu1ZUr8Vyprl96EYGT3tK5K9m3gbjZRyaDF2jfNfU3O3hLBSw>
X-ME-Received: <xmr:oonDaa8ywVzxdCgSfX8ywGNPjFbbTiDMl8BGwQlHgZfqVQ2ibRSa0xqh6JuuRoIt3LzpETTBQfKh2KKyvVl1kk-FJlyw4LNlPLzv4EyfyXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oonDaSdS6nX99w2a6cXgycmkuCbiIOo3nAgQ4d7H7Ayy-nk2gVD0AA>
    <xmx:oonDaTGA6bKHgsvDBYfzqVX4dyu-ZhijX0SygDuIFtE9RjYPwi4Uhg>
    <xmx:oonDaQccVayNX2xnwSp0dmXJ5ROZ4fYpKUHsCVvMYDkcTOpuJ_PzJw>
    <xmx:oonDadFCsi1QBZNbZhiIj5A5pMzKd5ZmkOAyPEoFekb9-bjsB6Td0g>
    <xmx:o4nDaQIVSJE4lvzksfpvJFHLu7mBDUyQho9cvLKU9X9X4po9_sZ5YWXO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:07:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8e0a2fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:07:12 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:07:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: Re* [PATCH] t4014: fix call to `test_expect_success ()`
Message-ID: <acOJmBluqb5SvjpW@pks.im>
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
 <acKqvI0EhaORjoD7@exploit>
 <xmqq5x6l2q5y.fsf@gitster.g>
 <acKx6yBi-BWUVJcv@exploit>
 <xmqqo6kd18sr.fsf@gitster.g>
 <xmqqcy0t178a.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy0t178a.fsf_-_@gitster.g>

On Tue, Mar 24, 2026 at 10:13:09AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I was wondering if we can make the test framework better so that a
> > misspelt test_expect_success would cause a louder failure than what
> > we have now, which is something like:
> >
> > 	...
> >         ok 5 - check hash-object
> >
> >         t0002-gitfile.sh: line 46: test_expect_successo: command not found
> >         expecting success of 0002.6 'check update-index':
> >                 test_path_is_missing "$REAL/index" &&
> >         ...
> >         ok 13 - enter_repo strict mode
> >
> >         # passed all 13 test(s)
> >         1..13
> >
> > when I corrupt the 6th test of a random script.
> >
> >         diff --git i/t/t0002-gitfile.sh w/t/t0002-gitfile.sh
> >         index dfbcdddbcc..d65f664914 100755
> >         --- i/t/t0002-gitfile.sh
> >         +++ w/t/t0002-gitfile.sh
> >         @@ -43,7 +43,7 @@ test_expect_success 'check hash-object' '
> >                 test_path_is_file "$REAL/objects/$(objpath $SHA)"
> >          '
> >
> >         -test_expect_success 'check cat-file' '
> >         +test_expect_successo 'check cat-file' '
> >                 git cat-file blob $SHA >actual &&
> >                 test_cmp bar actual
> >          '
> >
> > There is no indication of something bad happened, other than
> > "command not found" and 13 tests passed instead of 14 the script
> > has, which nobody knows.
> >
> > So, no, it hardly is your fault.
> >
> > I wonder if the test framework is safe to run with "set -e".
> 
> It turns out that the test framework itself is not so clean.  If I
> add "set -e" near the beginning of <t/test-lib.sh>, the first
> roadblock we hit is this one:
> 
>         # It appears that people try to run tests without building...
>         GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
>         "$GIT_BINARY" >/dev/null
>         if test $? != 1
>         then
> 		... complain that you haven't built and ...
> 		exit 1
> 	fi
> 
> With "set -e", "$GIT_BINARY" we expect to exit with status 1 (i.e.,
> "git<RETURN>" that spits out the list of common commands) as a sign
> that we have an instance of Git that we want to test is not even
> allowed to do so.  
> 
> I did this single liner at the end of <t/test-lib.sh>
> 
>          t/test-lib.sh | 2 ++
>          1 file changed, 2 insertions(+)
> 
>         diff --git c/t/test-lib.sh w/t/test-lib.sh
>         index 70fd3e9baf..4a80933487 100644
>         --- c/t/test-lib.sh
>         +++ w/t/test-lib.sh
>         @@ -1971,3 +1971,5 @@ test_lazy_prereq FSMONITOR_DAEMON '
>                 git version --build-options >output &&
>                 grep "feature: fsmonitor--daemon" output
>          '
>         +
>         +set -e
> 
> and started running "make test".  I see some failures I haven't yet
> looked into, but it seems promising.

Yeah, I was playing around with the same idea yesterday, but got pulled
into some meetings and thus couldn't finish that work.

> Fixing all may involve finding and fixing little things like the
> attached patch.  I am not sure if this would be a good microproject
> canidate for the next year.  There are a handful of them that
> multiple students can work on independently, but some of them
> require familiarity with the test framework and shell scripting.

I think it's overall not that bad, and I've got something that's almost
done. It's an easy win for students indeed, but in this case I'd rather
make our test suite a bit more robust sooner rather than later :)

I'll likely have something later today. Thanks!

Patrick
