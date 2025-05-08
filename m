Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA538384
	for <git@vger.kernel.org>; Thu,  8 May 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727731; cv=none; b=q8Naic3LtgG/UirDj66QLRRrOLm5XWILwN1hXEZQCaoeIuqtnRYOTr3+OcOrfLMGa9WMwVI5HgwSEOMAZdCRGuBrR6cdEunyclrmkci91UzuJLnr7dqxBXb1zlIOt/c3BFVeAp2iUtyZaxs6HzogYXuzdOO1p2UPBj9Goho7ZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727731; c=relaxed/simple;
	bh=Uynr/nb+W8lbis3CYzww72IiabLBgx7l2gLstJlGvNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdjfFVpoomMZBU24GMB4fc33OiVdIlRAItxxrnFPaT46304Lw4l3sRjvA0wiuDP/6oVnhpUZj6EvMuqOe4hYx8eWvVP2jxVwP9knRnXpyu/lphJz5gyiXfA20IjCB2lj7yDOVoJb5EE5dYzV2pbc7A0WAhmnsAWZNV/wSaGmegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hdSWqHVr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huDeV2vm; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hdSWqHVr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huDeV2vm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B4EC11400EB;
	Thu,  8 May 2025 14:08:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 08 May 2025 14:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746727727; x=1746814127; bh=zoa3MEfwTI
	fbw+Xg37hYgUMzzC16WjGPN4V7gmPyUY0=; b=hdSWqHVr+1wsCa93VdxHb/yYl2
	GAqvDLC5hvZfRe3xZYabgoOlzQH0/fJAyKceQVWq1S7v6VEaNZKbVll/UR18lrqo
	kIBq/DAW055lt3OpswK6zh7B0+MLcI8m6z7UOjpPZekKfzwY+O4H0/LKhvSY5ufw
	UUKCXuIRCsyoz9lUqGm22qItfLrwLYpFS0x1agJ8W7FcN4iu+JcSw5Urh/RE+N9H
	Ov747sSxbSSdv6dXg738ZoMqsodIltXSRcDBLthxOyXVC3Qpom00t9v24Gl1+pq1
	tDVillshMHqFkS91cnz2tYCaXD/8KeOrxhQf0ciuHc7kCgQXB13NPkPx7iYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746727727; x=1746814127; bh=zoa3MEfwTIfbw+Xg37hYgUMzzC16WjGPN4V
	7gmPyUY0=; b=huDeV2vm39Rc8WpuU3gF808itamRTKdgWtudM94zuRpBJH6IIZr
	9tHv7+0fD+XlWuq644LlXzL4MbMNpO/c8hsHwHDYG7JKTPuDzC/y4zxPeWunVXmO
	khYZRh9OI6qOeIPxY65YuVj6gWluR9ci7J10miVpaj0e1Wx6+2inRQ/jhqBpwvzk
	GeTCijKF1a7XxOL3B4iP5ZQ7iKIVKpkwwqgLRR8br+Zw1oadANAAMJfGub6frGr2
	acf4hYz7bA1TghtBsNI22hqD9se3rBhDbgpuGNg8+I8/YYC3Ib0RBTCLukNqIxIq
	BvhaaKS2cTyePanxi9lTU43DPnrXyE85vOQ==
X-ME-Sender: <xms:LvMcaEAtmkhgR39Kai_qo05qoTcgsNwV9vIdfODCCRIefF85jpKI-g>
    <xme:LvMcaGjgQu1HMKveWAe9er0LdEe4lr2eWtrYzpCNE5XrxI2SpQsQJ08tfe5kkBqmV
    yQ4C9iwhsn2s1o4vw>
X-ME-Received: <xmr:LvMcaHlUVyIl-lkUei1adHJIsTx6ZpG0WdCCCIquE3dXXUerbDQh8aSALzw7m77EGvjdnmxnulMj51lW-Ix8a1j4tidZJ8h5fH2N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LvMcaKwZgyeZEuSWCNPd8AKiRCthLRGvzEGlqwYGdtdByLd58Qm3Fg>
    <xmx:LvMcaJQ6tqp6zE8QBmknxBhy61dQdyt_A1te9CPthOA-aYWa9Id8Ig>
    <xmx:LvMcaFaFjkGjOrydCcA2fmAZe4wco6TB2Lk9fzTXkpNs1Tpl0cv81Q>
    <xmx:LvMcaCSbX-eeKbeVYAP-dQxCJ1xpihEfirSs9E3ymaeYwQ6-pI6Ylg>
    <xmx:LvMcaBHDMy0q9IQEIbZSGKmZMq7pE3wuxqFAm7-JFIuNOZEXtH4wlsZM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 14:08:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Julian
 Swagemakers <julian@swagemakers.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  sandals@crustytoothpaste.net,  Zi Yao
 <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 0/3] Improve checks for valid_fqdn in send-email and
 update documentation
In-Reply-To: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 8 May 2025 17:14:26 +0000")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 08 May 2025 11:08:44 -0700
Message-ID: <xmqqzffn561f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Hi all
>
> This series of patches mainly has two changes:
>
> 1. Improve the checks for valid_fqdn in send-email to be more strict and
>    compliant with RFC1035.
> 2. Update the documentation for send-email to include examples of using
>    OAuth2.0 with Gmail and Outlook, as well as links to the credential
>    helpers for these services.
>
> P.S. I have used `git-credential-outlook` linked in the second and third
> patch for this email!
>
> v2: - Improve grammar and add missing "" in second patch.
>     - Separate footnotes and the trailer block with a blank line in the first
>       patch.
>
> v3: - Change link for email helpers since old one was too long.
>
> v4: - Improve log message of first and second patch.
>     - Update valid_fqdn check in first patch to allow one or more <upto 63
>       octet run of alnum or hyphen that does not begin or end with hyphen>,
>       separated by a single dot in between each.
>     - Revert the documentation regarding sending patches to a mailing list
>       in the second patch.
>
> v5: - Simplify the regex in the first patch to check for valid FQDN.
>     - Fix formatting in the second patch to make it more readable.
>
> v6: - Use backticks for ~/.gitconfig in the second patch.
>
> v7: - Clarify the use of `OAUTHBEARER` and `XOAUTH2` in the second patch.

Much better than what I came up with ;-)  Nicely phrased.

Will queue.  Unless there are issues pointed out by others in a few
days, let me mark the topic for 'next'.

Thanks.
