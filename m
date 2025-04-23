Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE12701D4
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445247; cv=none; b=nP9QlfUx91j+lBPsz8ONt4DxVWGHWfzqtSwWuHBdZmYRLS9w7wseuPqkteqPWhOFzH1syWGNPhXaJ04d53r18gIoS/lkGhS2N/E5X/CnFEhEyn8whl1AL6qjAa+UXFU3XNOJQ0icFWIZlYuD3kgJd8G6dEkgZzok0XN+Upets/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445247; c=relaxed/simple;
	bh=6c8L296F2sVUHikHlYxbXA4ED41ZQ9Jd7hQXv2/zHag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PevzQC3nNc9k6oIdVhiIO38w/8pzo/Ek5926qWPpwzJjPepbQ095vMx483Y0v3X8wtQ1N6cYTKwObok63AbozyNs5stYnkMktWJPeLSU3C4Y0MydCm+OMZqvEUuAchW/FX6YU6kotOLhYN9CNHq4cqMTOp952f/UzM0H6vKroQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ogOZZH7L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pX3cws76; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ogOZZH7L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pX3cws76"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C94E613803F1;
	Wed, 23 Apr 2025 17:54:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 17:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745445243; x=1745531643; bh=ucs2B9SZgS
	Z09jEvWgxmZTNDSKYDSTKNwP1Yy/Kw6eU=; b=ogOZZH7LLqx6o/7kgIlpYBFIW7
	/r4qL5NY8G0yT/4tdgfReBV7LmZyHg5VdQ/e+hzBUroxKWH6ah5zgU2sIOlCleNO
	9NwBcEMhFxu5as+lgT2+hbGQUC/azi00WxJn6dm/lp6dbcwJ011EgzELmAJu/Lxr
	XoIAjBTcE+I/7CYX0+O3FBlNm+bvmkl160tPZv7NMfgzPDxUYDvRZN5RJWrr3fh1
	Rb86w94vHB4HOjDQeedzJsFknM72AgtcgL52U16GPlha8nUsqz516YIADxb8GD7v
	lpgryvdB+sl3zPi9o1wSkBs0DWPR0jddgwcS55Fv7ianjIDQybAqEbPb2k0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745445243; x=1745531643; bh=ucs2B9SZgSZ09jEvWgxmZTNDSKYDSTKNwP1
	Yy/Kw6eU=; b=pX3cws76gVeOC7yaNjuYV58Vw5PFDwPySDON+PughRmFcFy3Zpa
	ODnGXoD3Mno0ZtN68K1BV6EjZQ4dNA2T1BKqc6/N/dPOzfnJi7Zq3XP+f00ZwOWZ
	2w7vZVZMEvMYVmboz5NrSsyFyhlBqN9MPHBUfdO6ye2QJZYlNQdlHbm/6+ZuvfQo
	NdVG2JO/88NzXED7Nce/UD8Pk9CD8Kb8UfzSZuP4TbMt0X7CmdEXtOghwLqB++bk
	g2PChaxYqFaireMEEE+ZAvYZcSkdb3hnJNwYsncBFxCPens2KFySnqxjDIX7Zv/O
	V7+8gvI4oW54wg6z/Ub/4Yu0z2M7Ri+5H0A==
X-ME-Sender: <xms:e2EJaIuLfBxotLx6xliy5C9s2xNYM2h7IbLrPxHVJFKNUWC-HMpI_w>
    <xme:e2EJaFdogHwTdg0p1SCAEo2CjJp2BcAHyaQivrJVDUJ2r0XiUb2un6VRa-Cq15_C2
    Z_7wiuAY3ykT8fpWQ>
X-ME-Received: <xmr:e2EJaDzv_vm4JIaF5HtrEgh4TFFGYi3uKvMr_kISiGjEidksQQ-rZC51DTWaD8ToYfcYvob8nOaX6VSeU93vwqvhue2mc7SYoAHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepjeekueejgeetveejteegieelueejieej
    feeugeeiteeitdelffdvffehieehudefnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e2EJaLMwr1RcSWC8u-K4wfjgLHfrvsSGhd_hBuKH8M-Y_4SIewGDGg>
    <xmx:e2EJaI9SoM8QlaW8DAH2h3Va9H8uhW8VB8B0On3hOP9EAu8BshXtNg>
    <xmx:e2EJaDU9KhBpe7UvmMczvlVkHS6AIUNlow7BxM4vqypyvn7RoiDRfA>
    <xmx:e2EJaBc_c6qw3ZYMXyvG06a-_rwRHlXWgTBzr6ZZzTpb8OQaJhbZpA>
    <xmx:e2EJaCgSCj1_1fgkNJ7aMM5UoPm--I5eFF8YnuFqG76ekxE1XdlClp_u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 17:54:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: phillip.wood123@gmail.com,  git@vger.kernel.org,  toon@iotcl.com,
  ps@pks.im
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <CAOLa=ZT+hUuvdMbES_k8Pk+dLgrOovZB4fiRjJpS2AUrRrUogg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 23 Apr 2025 14:22:11 -0700")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
	<8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
	<xmqqtt6ezshm.fsf@gitster.g> <xmqqv7quwsob.fsf@gitster.g>
	<xmqqr01iwruj.fsf@gitster.g>
	<CAOLa=ZT+hUuvdMbES_k8Pk+dLgrOovZB4fiRjJpS2AUrRrUogg@mail.gmail.com>
Date: Wed, 23 Apr 2025 14:54:01 -0700
Message-ID: <xmqqikmuwnly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> As it takes quite a lot of time to do full integration of the day,
>>> during which time GitHub CI is idle, I pushed this branch alone as
>>> if it were the tip of 'seen', and it seems that quite a lot of CI
>>> jobs are now broken,
>>>
>>> https://github.com/git/git/actions/runs/14624509129/
>>>
>>> with "Process completed with exit code 8." at the end of
>>> ci/install-dependencies.sh step.
>>
>> Yuck.  It's JGit download that is failing.
>
> Sigh! I did test on GitHub [1], before pushing the patches to the
> mailing list, so I was really sad to see your first mail. Now I'm not
> sure if I have good luck or bad luck!
>
> [1]: https://github.com/gitgitgadget/git/actions/runs/14604710114/

Yeah, sorry for a false alarm.  

With jgit download temporarily disabled, and with all the recent CI
fixes (like Ubuntu 20.04 updated to newer version, explicitly
installing gawk to fedora environment), most of the tests are
passing again, except for linux-musl-meson:

  https://github.com/git/git/actions/runs/14627488066

I would expect win+Meson test (2) would time out again; I do not
know what is wrong with Windows and have no time to dig further
there.

The tree getting tested in the above run is 'master' with these 6
patches merged in, nothing else.

Thanks.
