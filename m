Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A149804
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669676; cv=none; b=M2DksjQvJBQ8bFpPNQula+ARHa2IUQpwLc6b5Y5kNsbfnAJ+b8PEmDsYREjEm8IRNoTDOgTyO3qTT94Oa15fW37omSDnsrzpcvwWiyqhhqSLmcPR9TyVhPy0uDo2CbdjOiTC6Q1l0s+n0ywr68yuxvi98JrKJECUQyA18e5wPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669676; c=relaxed/simple;
	bh=yxnBWi2808nXPLZ4LjbqGpUuXYcb6mE3QkKpaZycu7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTX+Qp4RS4q7S3Z77mibindtRzeWyqrxU6qeWJOdorW0fSdVVZWjf7sy4u/xfJoeDov64JbKmQffbg6W3+4f+7Ii1Q00OYkf5VHvBmWuN9y/sQ+h9MJu44fEOPfu5WOxpl+CWl/Z9jI1+CcbEbdR7cIS7dF9zCzNTZnZfH5l+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bVuq8QXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtAAqOZs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bVuq8QXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtAAqOZs"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2485F13800DC;
	Fri, 11 Oct 2024 14:01:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 14:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728669674; x=1728756074; bh=uAla/0iRvd
	z0RR9+l8OfM0323sbIw+ecMBuJLm8KcPw=; b=bVuq8QXBC9YkDLLFUHIHYLoYKj
	7RNsXh0cJGhX0nJCQa6B1NC4iVXdr9MTlEfEz9CwDdcV62wH8Sv7Heg+B9zeKuS8
	iovysBD3dV0tvfMLoQyCWjnqpeEvPxRi4xet0osVrTblQ7D0YlB7UqD/I9i7m8tf
	PefK+JEgzyDx2KT6dUmLXjGtJced+8CnbyvQbhAuK7JrLFWt5zS/u4xvdgwrxJnG
	fhwn+GgaNamXyfXRTgdGuIW5pHLwI9nOqieKHAilUoAgE87XDpfyqwfsCSESefbd
	paC13e0+ND7p2i6TpwXKiVFc2z0YKMrWrKMaYW/wm2xG9GZCs46qCR1n2qGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728669674; x=1728756074; bh=uAla/0iRvdz0RR9+l8OfM0323sbI
	w+ecMBuJLm8KcPw=; b=FtAAqOZsLGtvz5icRYehUIyjlZ2DhaVn42dc+6GgfADD
	FNJNKihuyWkqMNezsQF7btID4la7/tPH0vnBk84HM0cAa3W2rv1yjx7cISiTe/Tw
	jTFf6DWDAP+rHI0GVKCMVJfqtg2eE71ukDEPVG6fatHMnEfSrxoVvph+ZB4ychwR
	O0Q1RW8wWv0A6J96iWCYLMsjXpEiHL5uiopoXVkixs2Vl9eWAGILzrYdUggEbZ/0
	o+Iw0Md9tsQgHd21TKE5IAWlqKuFvgZH3gvPJpp2Sd0uXb988p4XYk25Ae3UhTA5
	ldiwbSmxW65G0pZsRyXWinMPVdZeNLaLHNa2RVWpbg==
X-ME-Sender: <xms:6WcJZ_1ZDtohpWGj6bWP29P3UzV9aqd65E-ZdnhoQMKKAHW5t-Vk6g>
    <xme:6WcJZ-G6J2CyLj8RnYYKqJwFWXtyqA8TuEKB-fQlwZhvtguUmGvQwRYaIiW44_MYl
    DgVpGZxgiyA5z2IHQ>
X-ME-Received: <xmr:6WcJZ_4Pnf9kQiADcx4Byr_Su1WN0BhnVdaEiXxghyRAcFOhL69OtQXPQJlGgjatrDrNhIqTkrbo82_Y2Id38lw-unM8KF0CU478Jf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvght
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6WcJZ01vSTkWsxB8Pqj2wkal9gu0amyo0tbYGr6KNZjoPzu0IcsHRw>
    <xmx:6WcJZyFWg_ud4rkyNVrqXaU201nIHEusxs4y2riKGybcrA6rekF2-g>
    <xmx:6WcJZ1_un5uhux74Fyvm0amqaJKoRt9LcJx9tYNsvJD46pz2yMfogA>
    <xmx:6WcJZ_lpc4eLr5mawGVMvJ7wEJ9Fz5nUgDe5EBN9Xed7_68Mv6pywg>
    <xmx:6mcJZ_NO7MtuNqqfsE5orEEd2UC0aMKDgXCH7LgfvuM3-NMQ9fe3b0WX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 14:01:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,  Koji Nakamaru via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] alternate approach to fixing fsmonitor hangs
In-Reply-To: <20241011090051.GA563709@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 11 Oct 2024 05:00:51 -0400")
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
	<20241007055821.GA34037@coredump.intra.peff.net>
	<20241007060813.GA34827@coredump.intra.peff.net>
	<CAOTNsDwwikiX3u6DG=+4hn+mcgfXzzDoqR3ZFVEdGi=mPGQbpg@mail.gmail.com>
	<20241008083121.GA676391@coredump.intra.peff.net>
	<CAOTNsDyxmRZ155vV-Jh=1obMnR+F4ExY9B136fiGk0Vd23-zrw@mail.gmail.com>
	<20241011090051.GA563709@coredump.intra.peff.net>
Date: Fri, 11 Oct 2024 11:01:12 -0700
Message-ID: <xmqqiktyecyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Oct 09, 2024 at 01:03:14AM +0900, Koji Nakamaru wrote:
>
>> > But I've cleaned it up for presentation here, so at least we can look at
>> > the final form of both and see which we prefer.
>> 
>> Thank you for the new patch. It prevents to start accepting requests
>> until starting fs event listening and simplifies the code flow. It also
>> has sufficient comments, so later everyone can easily understand how it
>> works. I also tested it both on mac and windows and it works correctly.
>> 
>> I think this one should be adopted :)
>
> Thanks for reviewing, and for all your work identifying the problem in
> the first place! Looks like Junio has picked up my patch and it's
> already in 'next', so hopefully these 6-hour CI timeouts will soon be a
> thing of the past. :)

Yup.  Thanks, both of you.
