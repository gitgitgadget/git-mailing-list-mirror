Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041F346FA0
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834340; cv=none; b=TgFMxLGPP5bRfeZNGH4YYVrqorJumSQ0M+/5CEot1HUfn45V7YDK+To/T4DH1eKsnn6svfUL4QVd7guLlXLx8ZXpIGL4FqlFXDu43wDflh+U7QitIUkEzDjht7n4m7FIQoGIf9NaQWnXr5VoTvHRfMWCuLC6GqoR2EILz6yhHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834340; c=relaxed/simple;
	bh=QMoV+3ZSaJ8ucWA8ynxpYmQbmGyfak2eM+kK+Y1sDTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9o03MYJ16kPj1vwbu7h5F4MskHVneD9gVGBy2mJ8PZ11lzGuUUdXYoP+gl2hxLyChoXga+fd0fUXB/a2NfMnnSqeH33g1VcbgjfYt/EUZcaTZFOCd2wMKt09BtUP/kg4/lci6WAY2JTxNGgm4hIB71+dca7JGjRDGe45zrsJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cZyRItlj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKTdK6Nu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cZyRItlj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKTdK6Nu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 43C54EC0554;
	Fri,  6 Mar 2026 16:58:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 16:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772834338; x=1772920738; bh=ox694qA7y7
	sTrFr8ZLCIaDURBDF1/4pVtGeSsOTGQ78=; b=cZyRItljjUBH9rxK4BkLlSEEZU
	Erphkjp/x1l2GOXb7A3IRW+Ce9D2G7IOA9rEbsYlsnFYLn/kJDjVLsuGnhYu8NFw
	0ZhxzdHBqIrTt/DA1zOJ1k6Ve/iC/16GahkN8n+5RzNyY6wv6esc9Y94mBt4hCFY
	PsMx2kPSA5EKfGtD9FXRdhWHeXj1/Ft2FeU4rhAwgBCVAbTMjYrT0CbZqQjh/v+8
	NYl7Ye5ULsdkX2dDKX5rlWgbuRg8Q+5ePTqTEH4sw0ffAAEyGyubUjd/jmBlEqcl
	be+tp7tjV/aw4CG0gqSyOWzY4cgYUtCUtadh+dPytNXSyZrGbQR9woe+Ti/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772834338; x=1772920738; bh=ox694qA7y7sTrFr8ZLCIaDURBDF1/4pVtGe
	SsOTGQ78=; b=DKTdK6Nup7995klIjU71W+BP8Y2xAUdJEee6MK4sliPvYSrYb+E
	QyDWIVFYkA/Qidq5H6o+OWowLntaFGvT4RtuqLkPyOsJrnW2anTQSIO6EkELEVGN
	xi3AKQyVNQbRo4lQ92ICxl2cxlmBHjk9ULATRVgraixG5GPPrYXN8FQOMc1xOtcw
	AVJSYw3GUUaD93JdQeaHWKIZWSVeOsqGEPRIzRRy7werfJkVp0nYkBoDUaCW3WZl
	r3MDGIL5B7opaHhIg2VIPDr3JBkb0c+sigNS6b1yYoSk9w0fTYNVGhcHgkQnPUBK
	masc5sixxPz0SWoWDBIS9mx5fYmTukBM8IA==
X-ME-Sender: <xms:Ik6racbLNSGfyru2RXscuy0QasjTfhrx9a7qG74hOqpopK0zflfAXw>
    <xme:Ik6rae2eVbmY4wPn37MtKtU3mGqQa9or2-Z1BAH9fReVxmR1NFdOHq3l977s5-XM7
    POeWLEvgubyol1vAyTW43Kd9BbzsrYNHYK9fZ-2kObHfmLKF1_TFg>
X-ME-Received: <xmr:Ik6raUWhNxOE1yrawfRUzxNbexwxOTs2_LTcU2Z0RCpiWzhluN7kmxTL4DvqW13WgSjePA98JE2brN6isB-cteheRKQC8EwqCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ik6raQUs-pM3yPmjaUXM5Z8t16A0c97TzGsabtmL309DRYbFGhrZ4g>
    <xmx:Ik6rabe3Dhr__9dP2VhLyHHB4KxYzFJoWtISpyIyoDr4kmK58e8aZA>
    <xmx:Ik6raRUkmGrVMpKod-LKmMb3PaofkYHBmxv-2JqPNARymAevXPfubA>
    <xmx:Ik6racdEYfqZYAOsBUMz50nZDJzTj8YFR4yvYnr2z23zIX4kadYS5w>
    <xmx:Ik6raW1TGcZTTsiHY9u4fEybIvtla234TudFhcZzg9eApF1SwWcSGPzf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:58:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] clean up a few things
In-Reply-To: <CA+rGoLdzfPiKx8=4qboU1h0hg6z=j904sesWV_6UvYrE2TvWVg@mail.gmail.com>
	(K. Jayatheerth's message of "Fri, 6 Mar 2026 07:29:58 +0530")
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
	<20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqms0m2hn1.fsf@gitster.g>
	<CA+rGoLdzfPiKx8=4qboU1h0hg6z=j904sesWV_6UvYrE2TvWVg@mail.gmail.com>
Date: Fri, 06 Mar 2026 13:58:56 -0800
Message-ID: <xmqqqzpwy5zz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

>> Hmph, they look identical to me, and more importantly, the previous
>> round has already been merged to 'next'.
> ...
> I just noticed the commit message actually had not change,
> that was a mistake.

Whew.  I was afraid I was hallucinating.
