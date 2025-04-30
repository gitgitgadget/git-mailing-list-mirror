Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6297262807
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031450; cv=none; b=l78ry8R6cftvFMcyOnV1s9+psK+HR8XJxfKpbn3UkFa4iQrbKPQCzKDllpq4VNDWWVXVOZdSsCMJEd9CEIPS9sHAezUNFgLf3zt171RqyVRwPJZv/NBacJNrOtZuIfCj20BkafD88uoeTsyGiXgv3gKQXy4fHd843cw22jlDUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031450; c=relaxed/simple;
	bh=fRISpLBvzzQeDzlPq1ZmRw66uAYZq1tfKkdRnzK+GJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=plcDMnxEh6WNYNcwJx6te0f1ZyH8fG+EiwaIpUlsjR3+Cs44YNQxbpuBXZBXalXCh33Bm8P5hjVi8LRQ9PFhPGZsIgEdAWKHMSjG/APPCstxAGMJApTPAW9CrWoptPCppsofoY/YykCpab/JSK1br4M67MGU97zzTvv9SyGJPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JcMlpHOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9U36QkO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JcMlpHOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9U36QkO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F3F5611401C4;
	Wed, 30 Apr 2025 12:44:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 30 Apr 2025 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746031446;
	 x=1746117846; bh=VQAKIOTdPqiEJCWL2u4SWaMnSvIOLgP6CNqwC6MtwJ0=; b=
	JcMlpHOjPZ6cwFbqWwzHGpZvIHsCwkwWkRZetMFhX6armB4xgkNmZbE1fNVL4UB2
	RC60ztAD/dvxDwZ9Rpcc6ChOMurYWSexUcaFynq1QmVupp1bBOqost6M/EUMo4Pm
	dDIeC5RswgMS8coCBG96I6unHiYX3mTk7mVB/2tLGYChFKaEXwhdmSSoDwWebs0n
	h7Qy0dpBnapSyM8wxNK2ZmJCRDHtlViRsMO7sUZRBIacsIxaarauG+n0fsQkybTF
	y+pyqhAWecX/dVXeMJNLGawjpde7my2y3Ua4LXWSX1bS/73bAkQk7223r05qqn+u
	0lYQsrqNecv1wF+hMc2SYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746031446; x=
	1746117846; bh=VQAKIOTdPqiEJCWL2u4SWaMnSvIOLgP6CNqwC6MtwJ0=; b=T
	9U36QkOrNuhzM/IL+PeF8YEpPB4aNlaE4ohmARtuSdY5YFHhj0bEci95CFkXNEdo
	rhvSyPS1tksKsDugweXTEbF9fslnZ7xiE0AqE2ER4xtovrusZu/e3dqbYhc/M/83
	ZXdMavSRGKWwSswvQzvMKR1Unbr8ChTfAykcOKj9BAX90B/ebLBsp8bEdebkJ3sr
	GVmwZjdI4lbYNoodwjJxiYRfewlQh0CYVTK+wyl3Nrtw01MA8XC4z9WkOzQBvhIx
	jIAp0NvSj3/P7T1pOkmWOUZiQSZPWFLpHaofVDX37T785Gko7Lo0zWTBI6IxTP7o
	9n1mTZhGVxwZN+i4zdocA==
X-ME-Sender: <xms:VlMSaL1r1YAQw6N28m7Ezh68C2ZU5IKmezIdTFZjTSfjfjHEoc-KRQ>
    <xme:VlMSaKHJ3BnzAW7zaDBfhp6MtwWQtacPl4QiSer363sH9bhooxn39CE_SfCjiCXON
    Yf7ygpatn1zYK-7Lw>
X-ME-Received: <xmr:VlMSaL7X9NUzEXwCfQx-fTT1cn74kz34dMf-cot0xYMCvmcLRBf-ITjE9HE65zhiZMqFFIhw-sTM1bg1FRB2p5EnsfPhPcfZuqwm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrdhmihhklh
    grshesfihsiihisgdrvgguuhdrphhlpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VlMSaA38H__agYcJju-5wYMXSthBqn0F0cXO9sW_GV5iAb6HvyF7xw>
    <xmx:VlMSaOHDUTvDym9XqORW_N5pLdx53w819QieXThivJivXJpHQCO3ew>
    <xmx:VlMSaB8pH-pGeZ22adhvKTwYDkmaZ8Oo0Sk_nojEXlaJY2_WQk3n3g>
    <xmx:VlMSaLntZ-tzGK2JnkKgVIC_1ws4VP_u6GBiyI104CO2N7hB9K2jtw>
    <xmx:VlMSaJFUyTHA86CpPCHCiENpseEE1PlMl5_901nUyQcwrQexQ58st_mN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 12:44:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Marcin =?utf-8?Q?Mik=C5=82as?= <m.miklas@wszib.edu.pl>
Cc: git@vger.kernel.org
Subject: Re: basics - auto staging?
In-Reply-To: <10c9da5c-234c-4a40-bbff-91ba820dd970@wszib.edu.pl> ("Marcin
	=?utf-8?Q?Mik=C5=82as=22's?= message of "Wed, 30 Apr 2025 12:18:24 +0200")
References: <10c9da5c-234c-4a40-bbff-91ba820dd970@wszib.edu.pl>
Date: Wed, 30 Apr 2025 09:44:04 -0700
Message-ID: <xmqqbjsd38h7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Marcin Mikłas <m.miklas@wszib.edu.pl> writes:

> when I execute
> git commit file.txt
> (by listing file as argumentbut without the -a switch) for a file
> file.txt that I have made changes without staged them in the index,
> the changes are still commited.
> Is there a way to make this work like command
> git commit
> without committing the changes that are not staged in the index?

I do not think there is.

The "git commit --only [<pathspec>...]" mode (which is the default)
was introduced as a variant whose blast radius is much smaller than
the "git commit --include [<pathspec>...]" mode (which was the only
mode before "--only" was introduced), but what you seem to be after
is a mode that is even finer-grained one.

I do not offhand see a reason why such a mode should not exist.  It
would be called the "git commit --cached [<pathspec>...]" mode (that
would be listed next to the existing "--only" and "--include" modes
in the documentation), by taking inspiration from the name of
another command "git diff --cached [<pathspec>...]" (i.e., use only
the contents already added to the index), if we were to add one.


