Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3E3587A1
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224316; cv=none; b=gf6SwLZ1itWNpqWvAczntcCpUYoIR/LQSyZRkxlWpMUSnxY3l/thJ7zV1+M8M2JBbwUGOaLQw3ymgILJ0c8pgv80HhcCgZUio7E+BqM95Cs2uWAS8xsk+HiZNxVR+mL3NEpODOLydUrafIji67q7TfuZjbuQI1PIHHwe5Qkpqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224316; c=relaxed/simple;
	bh=f3wexoEDkjF+EKuMPs7w1wrqBULINFIlhzhJJAirlLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvyfhXxuRqRxeTlolXeGcmXzyTzf+KyoB3KwHQ62Kva/yBegBLhtzx3s56+OqiruPyypgYL1PPu6PrEcJXYsJ09k48/xSlUH4LDsJ2BtdXvjION8CbBUvx0gSfXft/Es31ozBkW/iP9J/sq9Fp0lF4OqgkdZm0tWFDonxhcCoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oRP4npl+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JG7C5n6j; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oRP4npl+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JG7C5n6j"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E1A1CEC009E;
	Mon, 12 Jan 2026 08:25:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 12 Jan 2026 08:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768224313; x=1768310713; bh=PRuP6SeGW2
	ir3MUILUglbBbMPNaUGnLLj5guxhWQhg8=; b=oRP4npl+KOAec3KT0cp1KDVkcN
	/sftuymRFh+vh1MA9DmX1yXbUcMbRE2qGHEQxWcapN8thPz0dsw4De9fPvNLuIEm
	j6yCseOrs8hnNg0OOh+kTPW0Xb3p25QtNT+t23BTf2eNoIujGBkzAxt89C1aASgl
	jKNPeMgRR1MpB4OlMQw9ndQVtqEJ0NQuxx9nKtugVi6GMWvllpupgkj7LVsOCGrB
	3DtSo9YWP6CgWyKNS3+uL+wicxxol00F16XOux7/wWGcxnww9VcdXVudrU+nwZAF
	A+tUR9a+shxM5V/F3d5QDpRyqNF8icTOiDaaSxjf1MVvS5+Pd1DOkbtlMoJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768224313; x=1768310713; bh=PRuP6SeGW2ir3MUILUglbBbMPNaUGnLLj5g
	uxhWQhg8=; b=JG7C5n6jHl5roolZc/OZVOeRl5Zc8EGy8rzoFIEiRKLwU25PA0e
	vZ+dCHAxQ1UrzxU0KG7DhH6k0uhha3MBY6g4+0rzfGJbg1p+acSBKuprFEzas+Vt
	PiW0Wmmf/SqYmCnPMgOZi3FTfbpHiNZv6Qq4zoILjg+//8Aqz1RQo3wogYrrh9aH
	Xn0XIKLSxAbQsuCw0UuztHSbgCyU3QwU47SjdcplZBHsInPRrWFjFCY2n+M3NAUx
	GCZCfQ04L9zhW7iIEWgYSdI6RZ4gOXV7ILllixhwYQk9goGWvb+oo36zgwedFf4p
	3Uvx0KhBUn7ezcnkgto1UkC1D8yJo45PctQ==
X-ME-Sender: <xms:OfZkaTmSBV0yHtmIdlNzi-dXq8cGpK6u8JTH8kpsgaJT23XiWASW6A>
    <xme:OfZkad04eTqSbrCnTTLFkFYMf-Rd4qvtBqqmAI-iUt2RsHwC7wX5V7HHWcxAyIeJg
    IDvzrOipGPbu6YF4pbxoQMvmlY4_fwO-L8gJ9AvFZ4cYuTrn1C5jIg>
X-ME-Received: <xmr:OfZkaerRWU7t0JIZMaMDAKhgi_517GxG6ZzyCWvnvK2VsDj-O0TeYbWV1n8nmVbxBD1HHTjBhMlas8njcAO6ejCrZgOAXfxPZzZ4LCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhhrvg
    ihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OfZkaaeqrlcEggBC5NKxPkDYZDQ53DRHdMHv8geDdK9mu3KLGdf-ww>
    <xmx:OfZkadro5ROMqAQh44GKAbKzUmST3thU0uO4pLNxK03UobwjP70viQ>
    <xmx:OfZkabFOpguTXbAh9-ugxy8WP4yEI24NJJvjhzoNJz8RIbvFy1RkGg>
    <xmx:OfZkaduamfGTEaIvqXWCRNQNvXnPQeQ-v9Vhf2P-SoRdBKpVcwNfuQ>
    <xmx:OfZkaaLAlNQkP4HI4s0yZIs_2C9lecLWNczCAuDZZk906RUha9j6vNHi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:25:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit
 code in tests
In-Reply-To: <aWSv8dlt32xg14e1@pks.im> (Patrick Steinhardt's message of "Mon,
	12 Jan 2026 09:25:21 +0100")
References: <20260111202137.257405-1-shreyanshpaliwalcmsmn@gmail.com>
	<xmqq8qe3pxvm.fsf@gitster.g> <aWSv8dlt32xg14e1@pks.im>
Date: Mon, 12 Jan 2026 05:25:12 -0800
Message-ID: <xmqqpl7fnetj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Jan 11, 2026 at 02:50:37PM -0800, Junio C Hamano wrote:
>> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>> >  	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
>> >  	0012command=fetch
>> > -	$(echo "object-format=$(test_oid algo)" | packetize)
>> > +	$(echo "object-format=$(<oid_algo)" | packetize)
>> 
>> The construct $(<file) is bashism, that does not work if your shell
>> is not bash, isn't it?  If you used a variable, e.g.,
>> 
>> 	$(echo "object-format=$oid_algo" | packetize)
>> 
>> that would make the result more portable.
>
> There's no need for the echo at all as this can also be written as:
>
>     packetize "object-format=$oid_algo"

Yeah, I failed to realize that this is a(n unnecessarily) convoluted
use of command substitution inside HERE-DOC.  What mushroom were we
on when we originally wrote this crap, I have to wonder ;-)?

Thanks for spotting it.
