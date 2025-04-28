Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528322F3B0
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871123; cv=none; b=Gk42+rmd355K8SO/ISK49hWudhDvqYuq52V8UTWJUsT2z6B1MVvgqgWfNjtsMuTo1QkHCXgn5DAwsu3HZYQwMtpD9XFiZ8KHlA/06mdBXKYJjdH1rL+jlhcP+HCPL1y1dRdvyyk8SX1rYQqOpu1RCFzXVG4LufKicZreXsYX5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871123; c=relaxed/simple;
	bh=Zv2aeq8VgESKfn+kRAU9Q4amrkq5zPMZJ7M42HMrmZ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fe/nUlaLCS0W0IuDXsjoqlQwOQhsRdh11ajmUUWRHI5fP8fBS6UaVlgCwvmoyVv4Lgo0rGzI6ufgkYMzoNIl2R/fBwdC2UuF29Egr+uf39r50Rh3mFYU01sj/R79L+BKxEx0SxAB07ADP1PLMHaTdihapmeLOFZ9KFIxwz6Cpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JxJhEXHL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=alR2jstJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxJhEXHL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alR2jstJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EDE6114027B;
	Mon, 28 Apr 2025 16:11:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 16:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1745871119; x=1745957519; bh=cPXruV2Fc1hrLNNphjmVHHQbN8XGPOEf
	wrDGo7GV35g=; b=JxJhEXHL6dCKdlQWx1h3T1m7wjsebNTKsdfT0wX9W25YzGBx
	lB3q9fzY+WfOCmC7Y8ai1u1TJc+FnfRBzmwDJh3h7PrzXMYlCf41mluku5v5xGzb
	g+JGO7N1w456K1iqF5giBths0hRkrletJD90F7ov0xaBPIbKrCQUo8gw+N65l76H
	2nVb/YKJuMwZ5dN/LJcnc2BNpbTbOY7A4rcTg5XwLVdQhfigsXx67QEO8qZBNbQP
	R2ALcHXXZ4m8Zm38Lh2sJ8VyyVwUz++NdsUvjLCbPHPPptelPV7JfivukZ4EZHTr
	5pFdUJ0jZJni3+8dX5Ut/F+gAAasOvXdFmU+Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745871119; x=
	1745957519; bh=cPXruV2Fc1hrLNNphjmVHHQbN8XGPOEfwrDGo7GV35g=; b=a
	lR2jstJzUym+HpQE1r+4Em2DDOPfgXRXt4NRwEsHWGSsY2UXN46NxK67nZNj4pkc
	XN/ixJGCpRpV2DCroPzjomI70eTNWiUltE3KQn+uEcE2QRx00jpOLoFkM8NrmWuT
	wMY37Nkc2s2x9GQJIg7CJatGy7DtXb2WII+PaNe0W7kdZ6Vrh16zrX0BDONAmX8+
	xY1ZoMkKdsH4wE6NZ6izJf30jM2rSgdV/4lYEjiAlzd4Y489/nYwssEc16bITVKt
	8yht7/LKGdu8TpmktkctznA5o8y52LvBsCUTLPjRiNHOh7gc+puyXKhMRataNcjV
	AmNh5j5Y65iTp79/iAFYQ==
X-ME-Sender: <xms:D-EPaKOK5xMl2X6hfAzhlp-qJTRvtZAJhUxI2SW7H4whDASWGZF6BA>
    <xme:D-EPaI-VXvA_zOCWbL7Y2Sz60A9m2b5A5m1pgZoFYwKu9zmeiXMV2vqmG-Eqq3lw8
    CD0W-SfU_ScqPEjow>
X-ME-Received: <xmr:D-EPaBSA2Cu8lGJpaoQNDR_iBK1dZkJH--g2NW8K_00Xv_zyQnSk65Z9rzyDMPq2C19OqBxhDrboGrnazSed-rjeAvldleOpUZHt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepledvfe
    dtfedtkeefueevlefgleetieeuffffkefhgfekveehkefhgfetjefhffegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:D-EPaKvsk937ZgnFHHq91-gLhpIgGSAdcNfmsjmhzGZJzuqXkNbA_A>
    <xmx:D-EPaCcrhfLoPzfDnwtaKjimJxW8n7ll9Fby7iUnrFjOW3Necn-x1A>
    <xmx:D-EPaO0FUwJRKSOgTxbeNUUhTjUqNr4P-Yb3ZQfHbQyl0UA0WEq9YA>
    <xmx:D-EPaG8FxgPbTySFJmlpcIogMoT4ZdeLKwoUZoGBHGgGU628nr8ziQ>
    <xmx:D-EPaGOyXaGT2gDGnuHV9EZLwY5RzZhM8394KRd61ZMpjHL1XcnkazWE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 16:11:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: response to "git branch -f foo origin/foo"
Date: Mon, 28 Apr 2025 13:11:57 -0700
Message-ID: <xmqq4iy8cagi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When 'X' is a new branch I am creating to automatically (as the
default for branch.autoSetupMerge is true these days) track the
corresponding branch at the upstream, this output ...

    $ git branch [-f] X origin/X
    branch 'X' set up to track 'origin/X'.

... from the command, with or without -f, makes perfect sense.

It also makes sense if we reset the tip of 'X' to a slightly older
commit on the branch, i.e. after doing the above, running

    $ git branch -f X origin/X~4

does not say anything.  The branch is still set up to track
origin/X after doing the above two operations.

However, after doing these, and 'X' is _already_ tracking its
corresponding branch at the upstream, resetting the branch with '-f'
again will give us the same message as the first one:

    $ git branch -f X origin/X
    branch 'X' set up to track 'origin/X'.

and I think it is wrong for at least two reasons:

 * Does it make sense to say "set up to track" in this case?  If X
   used to be set to track nothing or some other branch, and if we
   changed the tracking information with the command, the existing
   message may make sense, but otherwise, I would say the current
   message is useless, and it is unnecessarily frustrating, because
   those who see the message may start to wonder what it was set to
   track before, but at that point, that information is long lost.

 * "git branch -f" on an existing branch is done to repoint the
   branch to point at some commit, which may or may not be the same
   one as before.  If the starting point happens to be a
   remote-tracking branch (like "origin/X"), it also may set up a
   tracking information as well, and as the first point argued, it
   may make sense to report the tracking information _if_ it
   changed.  But pointing the branch tip at a different commit is a
   change that is also, if not more, report-worthy event.

Suggesitons.

 - We should change the condition under which the "branch X set up
   to track origin/X" message is given.  We should limit it only to
   the case where X did *NOT* track origin/X, and we made X to track
   origin/X in this invocation of the command.

 - We may want to extend the "branch X set up to track origin/X"
   message so that the message mentions what X used to track, or the
   fact that X tracked nothing.

 - We should give another message when "git branch -f X" resets the
   commit an existing branch X points at.  Unlike "what was X
   tracking?" that is forever lost (hence the previous suggestion),
   what X used to point at can be found out as X@{1}, so it is not
   necessary to give the exact commit, but the fact that the branch
   existed already may be significant (especially if you habitually
   use "branch -f X" whether X exists or not).  Taking inspirations
   from "git checkout -B X origin/X" that says "Switched to and
   reset branch 'X'", perhaps "Reset branch 'X'" may be a good place
   to stop.

Comments?  Takers?
