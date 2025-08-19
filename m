Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FA1AF4C1
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568355; cv=none; b=J0aYHhMrpnuizwLj0+syUTeJphyB0ZMg7U+yIkABHSZ4ztjvAgiASXQY9bcWButNhQE9Fvp1iXeSP9bdJIeIvKfqtXtXCVvkrtav+msWNrNhehbwwGC2kCYU01lF3Gy0n7YWNFq6b/cpOP932uZ2I6WDEVxFYfG9VXfqDhJieeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568355; c=relaxed/simple;
	bh=s+pVsz+1l8ZQ6j23FNBKvl+3pSOlE8ZM0J0erztp0vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Th8adC9ymfjPq3HurFEalw+a+7YqJ2Hn86M0q+/rflS/M4Rme2jZfKMKTb+SpqghdjoNjRWU5giVvNrJQaune4K3VxaWjwfAfzCFFF3B5fODGqpMcQefHwV0yZ9VruIYzrMk+dJN/j4XKPMvk3x9+7pfvatvFwBmzhUg1/X/Bjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gqcPdf+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tz3ofVWz; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqcPdf+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tz3ofVWz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B84987A02BF;
	Mon, 18 Aug 2025 21:52:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 18 Aug 2025 21:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755568351; x=1755654751; bh=sPelx0z96a
	1W6z7/VKpKJglrDABRCM5vxnmfENFgpLM=; b=gqcPdf+T95TQh9ovlkXDFWM9yi
	HVAav3JY+ml62/y9r6V0TA5vcCFc4DkqMPql1eiJIEzethvqKTUqw2ojZ2ZHwiQN
	aynkheRKClX6Svidy+j1+ZkA8fXJzosxyV2KqteTR6gvUmL054kFDz9PS0l4UhVK
	Vxj7SWN5bFV+LYwY4Yt2UZcK8VD4T/OGhAE7pVlxT7kJy/R5bK/a+hqpfVvCH097
	LmcxkJVpquVYi36xydse2f3su8dxmSi4ybs/qTAqXpkwL8NlfbuabfHZSOr87ZdK
	WRA2Asc7B5iSmWP/Pb2z/nkszCGmwQOHH+VUD5HMk1FSz/t2LEse4dYw/fTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755568351; x=1755654751; bh=sPelx0z96a1W6z7/VKpKJglrDABRCM5vxnm
	fENFgpLM=; b=Tz3ofVWzYDsFGc1oy9hT0a9hLhZxPurVyym+Ye0EzuF5lcCz/AN
	51J+mEkgDlK4dQnRhGeAs6ccW4f44dU9l4dRaFT0dPENhIMb5InkZgJHOP6Xxlcu
	Jx/8DGCIVaSAqfROhL865lVYhRYvDmxcip8VoLb0gGAL/wfwNbXRQpWFPhrtzJgK
	fKvunwsuN69HKzhP95ypPs+VRKzhk2F81mACZGTpXUiJyRB0yd+UyQM+QJ7C1zVi
	RmInY2mAZqHw7YEqiDAN27OodXUekr/ATTewjtj9QVPI3ZaEU/swGc9YEVWnvv9b
	zdWdp23FyCwcUn9O5Y2gM8VvMBoC5au0lGQ==
X-ME-Sender: <xms:39ijaCLZEKsM_r6wr-uHszL8I4NguwXd1knsI93z2Mmu8KdARECScg>
    <xme:39ijaNYHF9VbZboymzSJwtAOpio0e4fcd58m8LZ_5p9tOM4GHKNW3vlP6YMivvYIH
    4MRB50Zha02-ZLG1w>
X-ME-Received: <xmr:39ijaMId6yERl7XfrS_U1Dxa3z4-76FtCZJmMksDbZVAI9Shz24eu9zuwHA2I1wAO2SxHKDExlwRXQHvTUErF2YUtQ7NYU335qlg5vk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrrhhkrdgvrghrlhdrfigrihhtvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:39ijaDBzEcPXx_GQUzEM1yHHMVEQ451pLc5_FwR2zYh2IFaW_mni6w>
    <xmx:39ijaJqsvJZtwQgkT2TFgbXYRZ7TftpsKLgcxGdVk_bDljMKahJkNw>
    <xmx:39ijaGjjMsnl4TKHoRmPw3gWtxDPj5LInB28Q20sIUPhAxMlxSmfDw>
    <xmx:39ijaOADCZrMD3uiDjk3vBl7KIpITiNSBU9qbJW01j23JtaSwpHLRA>
    <xmx:39ijaOBjXayfVB0KkEWT0ea0VRbsF0bViQFFkBsFx4a1stBkkCfvF4oe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 21:52:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Waite <mark.earl.waite@gmail.com>
Cc: Git Users <git@vger.kernel.org>
Subject: Re: Jenkins still uses 'git whatchanged'
In-Reply-To: <CAO49JtHLs0yCAmNX-2VO=0mC-u4JKPWw86Lg+xe1pV6Dr6YZWw@mail.gmail.com>
	(Mark Waite's message of "Mon, 18 Aug 2025 17:45:26 -0600")
References: <CAO49JtHLs0yCAmNX-2VO=0mC-u4JKPWw86Lg+xe1pV6Dr6YZWw@mail.gmail.com>
Date: Mon, 18 Aug 2025 18:52:29 -0700
Message-ID: <xmqqcy8sgjs2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Waite <mark.earl.waite@gmail.com> writes:

> Git 2.51.0 has deprecated the 'whatchanged' command.  The git client
> plugin for Jenkins still uses the "git whatchanged" command to generate
> its changelog.
>
> I hope to release a replacement soon, but am only starting the
> implementation now.
>
> Mark Waite
>
> Message sent as requested by git 2.51.0
>
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.  Thanks.
> fatal: refusing to run without --i-still-use-this

Thanks for letting us know.

Please note that "--i-still-use-this" is merely for you to buy some
time while you update your ware to rewrite your use of whatchanged
with something else (probably "git log --raw" with some other
options).  When you update to Git 3.0, whose release date is not yet
even known, whatchanged will no longer be available with or without
that option.

Unless we hear so many reports from those who needed to work around
with "--i-still-use-this" and realize that removal of that command
is unfeasible, that is.

Thanks again.
