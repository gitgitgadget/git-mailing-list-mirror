Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD74CA4B
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753576095; cv=none; b=qe8HHCDlHAYz+0VFcSHRTszCfAnDF7FPmKIoaGBOwYEaOl0YphY3HV5CQweb9DxpYFpXDSVLbE1W+w3RUAI895cbXurW/w+4LRKzv9CuX/eW3dBoqroxJ5giTNhGHnoa/VqDc1JePpuyFQuLfJZFuL2L7WgYPXi17smDE0EXhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753576095; c=relaxed/simple;
	bh=526aqLuSaRkuFiuTxV0Z7xsS8e+P8eF5LejLAGIh3MY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e4/j6ptS17lhgNkEgM64tmTxijr77C9auIk070/bVS9P/EzQNcNXcgyE9caY4U9nrcz+YoLjhmbR/pMSCeSO9h019tLgu+f5LbrwcBa312Yi0gv3LqFYB7Qn6fDoPZA0ROQRwP3Acu8AJzDl0vqiLJi5huNtcx481mXbxWW+s5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e+G4s7De; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vk3Eencg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e+G4s7De";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vk3Eencg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 383311D0063C;
	Sat, 26 Jul 2025 20:28:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 26 Jul 2025 20:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753576093; x=1753662493; bh=Nqf3kDXGRu
	GpsLS5vqc2tqiTeYXpmpty8MeJXmEGeyY=; b=e+G4s7DeLJpsGxeZk3bqSCCVTL
	eQIrnEOjp1OVrZ24HmCOlI4Uaefa8rds8vc3KjXqQ9B5W2Kr+nm4TbdciKmL3vnq
	Hc73BSBO+VzdcoS+Q39y6B0F4xLIT0G8W8dvMR03bD/XEd39AsQA4093pYCG9Aow
	5Z9iE5pEviyM69dAKKfEQjXPbzbT2cw4A8fZh9LWpOJ5G8bAAB6TBhWZKCiLpl0Q
	SSfulXLVpsZNXlaJCt11dA3MR6gxoDRFyC9CD3/ihuB5XgQjpEvB/ypWeIdUkEBZ
	9VyvotUnJPkWt1Y/B+CzX+6yVFSaCVatW1aYLQkuryd84NdgPOVBfTHgSkZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753576093; x=1753662493; bh=Nqf3kDXGRuGpsLS5vqc2tqiTeYXpmpty8Me
	JXmEGeyY=; b=Vk3EencgRA9rSo1+APjxgowTT02cmKuwdW+JJbEO03WgcupIdwW
	wguZS1ClGX18zHWHlbm1cMyDI6bz6NtQC/OKNTr1STgOS6jBk2L2mNiL15W7jSq+
	p3Ppww6GJHAG128UX5tWIIWgPHrzCjF5wXHF+14P7qqeSksszZ2tODH0WaOE2lDh
	gitz7kAtV2/ti1jbmxbxpgH1Nk9aLk8RF9Lxy3W7L4j4SBrYkbWkBj4W2EE6UEvd
	FXP55K+/imrEMbDYQWeGinhCJfX/5SrS0qruVo7bKhPIOpFQCRwNRZz7oizOkMNK
	Fyif/JEofugnSDu/aOaZcRV7pY4iYf4SvSg==
X-ME-Sender: <xms:nHKFaHq0yWXOShSqStXKa9glCPfEzD31XdtM5jupd2EtV_eI4522XQ>
    <xme:nHKFaKHOQgSYgQZfS19QncRNfq4Y79bCjxc1qvYCbnYWXsRbTpyf1KoRoZdwl158N
    qGSzi2tbrW4LF87mQ>
X-ME-Received: <xmr:nHKFaEoQcNSNvgQ9guaPZ4-82Df3aCwr0tSokRRrsKJlOElwp7krGspnj8h_8EaehsfO_RHDae7V5HPCtI5kgBzT29bCYGL_eIsc6Yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhgvshhslhgvhiguvghnnhhinhhgthhonhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nHKFaLY6B7lBoFbaFy80azDnCdsjUWvo0FcZS-6Gae5TEo5zoIb7uQ>
    <xmx:nHKFaFWiy8nDOHvhontwVh-daL_ekVwcgP0RBoH8w2m13vwlO0mVEw>
    <xmx:nHKFaM_y8EmcFnVrUsh6_z7R83LuUlX0LOZelQsgA1qkQf2P86ezPA>
    <xmx:nHKFaG9gX01517Q30HZc8riu2nVpx2l_1JrM9AO3hqrcdCXVIQRigA>
    <xmx:nXKFaIHfB0Z-gOsZm34qx5Z3MmUp_RV_30d_auvx4OwFgKZ316cyHyxH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 20:28:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more
 than 2 arguments left
In-Reply-To: <20250726165320.4039-5-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sat, 26 Jul 2025 12:53:14 -0400")
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
	<20250726165320.4039-5-ben.knoble+github@gmail.com>
Date: Sat, 26 Jul 2025 17:28:11 -0700
Message-ID: <xmqqms8qzdd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> When asking for short help on a previous command, the user may use their
> shell history to recall a command like
>
>     git rebase new-base
>
> Then inserting "-h" after "rebase" doesn't yield the help; make it so.

I doubt this is a good idea for at least two reasons.

 * As "git help cli" says, we should be discouraging, not
   encouraging peope to say "git rebase new-base -h".

 * "git rebase -h new-base" that shows help is probably a bug (think
   what should happen with s/rebase/grep/) in the first place.

If anything, we probably should fix the "-h" codepath to

 - react and do the short-help only when "-h" is the only command
   line option; with argument, it should probably barf, saying "-h
   does not take an argument".

 - if "-h" resulted in reported an alias, it should stop there.
   E.g. "git -c alias.x=ls-files x -h" would currently invoke "git
   ls-files -h" after reporting that 'x' is aliased to 'ls-files'.
   If the alias is to one of our commands, it is not too risky, but
   otherwise we should not assume it is safe to append "-h" to the
   underlying command and run it.  Imagine

   $ git -c alias.x='!echo rm -rf .' x -h

   and worse yet, if your alias did not have "echo" in it ;-)???

The only end-user expectation we can safely assume is when they
say,
 
   $ git frotz -h

is that they would get a help on 'frotz' without doing any harm.  
If frotz is an alias to some external command, for which we have no
idea what it would do when we run it with "-h" appended to the
command line, the user would be in a lot of pain if the aliased
operation is destructive.

