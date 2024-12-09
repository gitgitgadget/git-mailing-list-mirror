Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC272144D5
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725032; cv=none; b=MqFbgXCGw7/nfjNrBpRUxMkTgKiTsbiTEPn9oE7WKy6GsfS8wsFBdClUFMi2V4UR/fI5a6btWnjtrj2OPlTetyPShTPOWSBNrem4Ya8KQEN0gPNdzbu0yCX9lUdkrAacaq64YwdTifX7NJbKMMpfJzgDqhGIBzK08ow/TkMC+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725032; c=relaxed/simple;
	bh=p7+qfUz8q9xy0acJ5/g/MZtFkzVyXKyfgKcK4hBMrUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMimuQefDLUztCahMoPW0c1vzhaH7ROlLWWJih1STJVldg8exizUkmTMDAu7dxAPTiE18oCyJ1ubveRsxuCFsI2AUj+qSW9QXC04L8GT9ihT1NWlZnCQ68OgnSKndNE4zL7f6CynfNVgtvVwSxaUJWHh/vsIQ5msQmN1b/t6vLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hjv0opCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JL328j3O; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hjv0opCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JL328j3O"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB35B1140101;
	Mon,  9 Dec 2024 01:17:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Dec 2024 01:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733725027; x=1733811427; bh=ZpxWp3IVhv
	iEk6lYRbGL3LiqEC0u6kix/TeGkdwlz9U=; b=Hjv0opCLZ0X/cMs8NlcNsenqGs
	k3XHl1Qof++CCkJ2GNfRHiRQ0it8bqgaTbjyKodYlrcfWXObd94EFXc7tvQfrQJf
	QHT4j7Zpq8I+eKF2mYTUMW1Xs4ZUF2lkl2//SJfU27Yx6vj31IogQOcxByxFMbvG
	aJOixSDl7cG0H4dmE0CmLckRjilL4uWYxelRzciWfhdKFARGShb8u2Ijtdou+3dQ
	AVveDOOWM5rFPLFkaWlcGkndb3xZkeUBUYcykWO5Xy5sCInov87RjkjNU+s47iZl
	7DfyEz0b1QqNL7FABmpgkuQLTIPWmxT3aqIdGfyInf8l8mHkJVz2JXmCYOng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733725027; x=1733811427; bh=ZpxWp3IVhviEk6lYRbGL3LiqEC0u6kix/Te
	Gkdwlz9U=; b=JL328j3O1MBxgYqLjBgzWlPWfPJwSruY6eqWRsydck3m6NlVz5Z
	i+ysrmdeObgukCL4FlkvgecdiRUX1yd5C4b8ISscFU9sbCHZCo3GjMk5baDl8aDC
	lm1BWyTkEj5aONN1kg1MLQIoQ+rivO0hxldZX7CqBSZ2HFM1Z378nWbObQcqV7es
	pAAWmeLjdk7LK+cJ3YPG5hIri/K7q6wuJYa2OIoNo7yjfnjMI6lBoGXOSFRroero
	hAJHg7vL1yRsiEf6tnwYKoUDmHj/wO9fV0EimozhUNesY90QjsJZPnFBBswg8kLE
	9JNVyxSoN5gKoRUPEP6cA37ppGyHH5GI3wA==
X-ME-Sender: <xms:YotWZ2o6tDFAThYYy21ABIxxN2b_fIS7MklZrlIQMB7HZemZGFMkhQ>
    <xme:YotWZ0o35iOWdLYRSV_-eiXebEqUEqM9ySrTKvbORcf2q2YFQUWlBFC6U8XgSj8VC
    S1e8OYH0RNT0G-e6g>
X-ME-Received: <xmr:YotWZ7NeSjoRYCp2tmzG8qON-nRxCcLDkGDbnHgceEre-JlyrXzTovBUOfVNRxrvHUekO8Fm1MpdUNInlo0BiemNkZogQxxiACQwiOzAAtlrQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheet
    gfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:YotWZ16Qpm5-369vv2PjJn6BAExjheMDDG2eeRN23xIO6VMM0lEwXw>
    <xmx:YotWZ16wi5loUTaOKKDfHFga8EJjVUJ6IzsA_a4xGWPXGDP9RKJ5rA>
    <xmx:YotWZ1gofXyMeABlLxYXeMtI9pUlGPHAweYG2S0OUDxkxCqQgqXLoQ>
    <xmx:YotWZ_7ORmdo80CLTZHsmeVWXuSgsScssucUdQzftxxmUAyW1n6Dqg>
    <xmx:Y4tWZxgBjhySck-Fo8D05i6J7eKRNGvsFdi7Ki0GrN7-_kxHkJOSCg28>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 01:17:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b53697ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Dec 2024 06:15:32 +0000 (UTC)
Date: Mon, 9 Dec 2024 07:16:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
Message-ID: <Z1aLT-Hcq2iMWH11@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
 <20241206-pks-meson-v11-25-525ed4792b88@pks.im>
 <xmqqikruswtd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikruswtd.fsf@gitster.g>

On Sun, Dec 08, 2024 at 12:00:46PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > As support for Meson is still in-flight we have to accommodate for
> > conflicts with topics in "seen". The following conflicts are being
> > addressed in this commit:
> >
> >   - ej/cat-file-remote-object-info adds t1017 and "fetch-object-info.c".
> >
> >   - ds/path-walk-1 adds t6601 as well as "path-walk.c" and
> >     "test-path-walk.c".
> >
> >   - js/libgit-rust adds "common-exit.c" and "common-init.c".
> >
> >   - ds/name-hash-tweaks adds "t/helper/test-name-hash.c".
> >
> > This is somewhat painful in the current state where Meson is not yet
> > part of the main tree, but we'll have to live with that for the time
> > being.
> >
> > I've split this commit out into a separate fixup-style commit such that
> > it is possible to test this topic both with and without "seen" merged
> > into it. You can simply revert this commit to test without "seen".
> 
> Now I had to reconstruct these "fixup-style" commits and they appear
> under ref/merge-fix/ hierarchy in my broken-out repository published
> at https://github.com/gitster/git.git/ (and no other fallback URLs;
> it might make sense to have another repository for redundancy, but
> it is an unrelated tangent).  In addition to these listed four, a
> newly added ds/backfill also needs refs/merge-fix/ds/backfill to
> adjust.

Okay.

> What I noticed while performing this exercise to place ps/build~1
> (i.e. the series without this step) immediately on top of where the
> history leading to 'seen' has a commit whose tree matches that of
> 'next' is that we need some "distributed" (read: put the burden on
> topic authors, not on the onwer of ps/build topic, and not on the
> maintainer) way to make sure various list of files in meson.build,
> t/meson.build, and t/helper/meson.build are in sync with
> corresponding list of files in the Makefile world.  It _should_ be
> automatable in theory, and to help those who develop against the
> current practice of treating Makefile as the authoritative build
> system, a Makefile target that tells them that they added a new file
> to Makefile and removed a file from t/Makefile but they forgot to
> make corresponding changes to meson.build and t/meson.build files
> would be very beneficial.  We could run that target as a part of
> "make test".
> 
> Of course, those who care about keeping CMake build up to date can
> add something similar hooked up to help others help themselves.

I have the following change queued up in a local patch series:

    # Sanity check that we are not missing any tests present in 't/'. This check
    # only runs once at configure time and is thus best-effort, only. It is
    # sufficient to catch missing test suites in our CI though.
    actual_tests = run_command(shell, '-c', 'ls t[0-9][0-9][0-9][0-9]-*.sh', check: true).stdout().strip().split('\n')
    if integration_tests != actual_tests
      missing_tests = [ ]
      foreach actual_test : actual_tests
        if actual_test not in integration_tests
          missing_tests += actual_test
        endif
      endforeach
      if missing_tests.length() > 0
        error('Missing tests:\n\n - ' + '\n - '.join(missing_tests))
      endif

      superfluous_tests = [ ]
      foreach integration_test : integration_tests
        if integration_test not in actual_tests
          superfluous_tests += integration_test
        endif
      endforeach
      if superfluous_tests.length() > 0
        error('Superfluous tests:\n\n - ' + '\n - '.join(superfluous_tests))
      endif
    endif

What it does is to verify that test suites wired up in Meson are
up-to-date, and if they aren't `meson setup` will fail and print all
missing or extraneous test suites. For code it's a bit harder to do as a
lot of it only compiles conditionally, so I don't have a solution for
that yet.

It also doesn't execute as part of `make test` -- if we want that I'd
have to implement it via a separate shell script instead. Which isn't
too bad, we'll simply have to agree on a direction. But the logic will
execute as part of CI so that any discrepancies will be flagged.

Patrick
