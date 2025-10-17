Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455333F8AB
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728541; cv=none; b=J9YQJHcBeWev0i1uuAppZhGw5N1oxMEOKX0UWhFbvNBGALjCHDoq50Yq0pe0BAT/E6HBfrvKse8MIEf/5dD1Aw5/S/0ST6xEqPi99k//thbdRj5EItucZ7jwubmz/A+hyS1ILXyFdVKd6nl03JGRvDuQopl7IKs57NQ+ZZ/1dkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728541; c=relaxed/simple;
	bh=IRUYATykhyYh3uND8CXnIQkZrZQka68/Mm0EPdl2uOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcYuopDmoqMQCfKtFwlINOpWvPRkdJctVJFZWzlg876rOru9BX48jYdzwAdquPaiHM78KN8qHTBYAjihBQNIVd4acItygMtZY1R7Ecr6KKwr1HTmf3D2AbD8TQVK5e0I+t6rH4ln9GmtA7rOqwOFhPcxtuxuYJIg49x+PUU0ZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eRHa+R/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+/cm8xw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eRHa+R/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+/cm8xw"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 500841D0014F;
	Fri, 17 Oct 2025 15:15:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 17 Oct 2025 15:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760728538; x=1760814938; bh=u0zgS2wLWe
	t9vP1dxVBTm9zZMy66kR85ixN9kgOImVE=; b=eRHa+R/3xaAfR/gHtCLfY7T1z4
	oHxJrvstVbqwxvMsov04OAB/jGlmX+qmcfwqe0//WAShQnxrIKNlFB4j4u7Avf2E
	ij/nYjKzO5Pf3I1+FMcyp3QRfnCAc2UYVjP+Ws+737o2Mac0q0n/rix/WpMxCjqf
	/YA2RRdjqSRd1meFIjCpPyGeU/qof1u6aew9uPzDrqhueKx6NtPDxXEsM+XSXDRa
	kgBnLqtsAdH/vXxmSQCh/3KoM52CM6XT/Pyj2WPTos2idSR/stsme16CsYxE8rot
	8tz0U8FV6UCHVhXomVdkj7hW6uKPdG7ongqapby7r5YMx92PsNk5QaSna4ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760728538; x=1760814938; bh=u0zgS2wLWet9vP1dxVBTm9zZMy66kR85ixN
	9kgOImVE=; b=c+/cm8xwFZfI20enuz15gsBbu8Dm4CKsrdAGHRkJgYh7gye+WTR
	RRv989pFMY+mBZPZNI1HN15Hos82T8BlO6snv9i5Blls3jA5r+lAn0gA32zEIMAx
	kNFKAf7CrBtsw3gOfQEnC/AgsV4pwLDp/btjr/iRgSwj4GOiCSXpre0RCsfyYUAU
	EcGEdXn0YyO/vcv47VqLkh6jy7S+heVTxRUL3EIZYy9hRnhdA9UyyKEepDlL+pWm
	+M1DyIoef5SQsC7hjwJUP3WPsMTCSZv8FJAKiCWOolDp4FWvZ61z9FmrgCLdiO4i
	ziWGm01Wp2P+fUjgM4XgNNfJRlO9F3Tc2mQ==
X-ME-Sender: <xms:2ZXyaGLX3_jvD7Zk48vgqBmQLkJKWp4l92V_jQdjTUZgLhljaCvNhg>
    <xme:2ZXyaJHfWCwuNbeCd6FvWt4nP2RX4_YDOt-VcBfFTI7xehLoz9_G0e3EzhRvBYQ-y
    SK5oAh47mMOn9JAyiRKxnaG-rPhzywd31IBORRT9pc944_migGGFA>
X-ME-Received: <xmr:2ZXyaFvtZ6D7FNDYXoWVX3jIfuQ8SXPx2oA4SvXRzqYlJ-Bl6h3wurSi5Z3AP-qs3c0ESNTUDnnqV7p3h9I6w8Asyxl5RsODSGBd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthht
    ohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2ZXyaAvWMWReBEBm0HwDPWUW9J0QEBycE5LHMR0sES_NPxmvtr6_oQ>
    <xmx:2ZXyaLDg7TanMgExEi8ApsGSY2VELVhPORBtxPaABPaNqLiHIac-wQ>
    <xmx:2ZXyaCM5FmxojG8JQOQ3E3_JmzUiut53qGePuBaYb18mwOnUNlSwww>
    <xmx:2ZXyaEyaxEr0ufFmVdYBk95QZvIV2_StMFLLMdzZrUXaAhY2n8vRWw>
    <xmx:2pXyaNmbEibxRUkz7mS0O3UPusDLrZ47B3Zm6oH4CJ1hEXG1YzJcv2op>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 15:15:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>,  Lidong
 Yan <yldhome2d2@gmail.com>
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <4ff55fc5-7880-b8bf-257f-3186552e9c36@gmx.de> (Johannes
	Schindelin's message of "Fri, 17 Oct 2025 14:07:50 +0200 (CEST)")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
	<4ff55fc5-7880-b8bf-257f-3186552e9c36@gmx.de>
Date: Fri, 17 Oct 2025 12:15:35 -0700
Message-ID: <xmqqjz0tz6eg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thank you for fixing this so quickly! From my point of view, this is ready
> to go. I will integrate this patch into Git for Windows v2.51.1 (which I
> am sadly forced to release on a Friday).

You may not want to.  I think I'll have to do 2.51.2 either with
Peff's fix (or a rerolled version of this one if it comes quickly
enough) early next week anyway.

Thanks.
