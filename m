Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276C3B47C4
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283941; cv=none; b=Az9bFlvt2SGInJWuyGQZ/+Z8MbFYsAm2IcH/lNbBLlPGyLWvL6Nw0Rz9VsWERLDBT+dW3XRkp2S0V+meFtPO+CfNE31TRd433rWcqkiXJpQckTAKjU7rizKKScs6OLCg5HMcvpa4labnH7xJbyhY9SQPkK7q09yoZ1UAfKUOPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283941; c=relaxed/simple;
	bh=2gZimfs4+9ZPDVTM/wDsi66N5QeAl2wzBtj3uqeF60Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riFXPT+sJtAU6VfsWVMtljQS3cgRSV7TTHAl1r9S+tn6eeVcZTG2wMRj/+e6h2c6guR8Fl5Vxh9nUDT+nJHW1bKRgyaw90PJzuazqV8MBuwNgsbovjRO64cUhkVMEahai+vGmtOxzxmI2Lna3+52JQKWJAgjl0t0mLhoLOJcajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBBCZh9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oD2zsOWT; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBBCZh9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oD2zsOWT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CEF914001F4;
	Mon, 23 Mar 2026 12:38:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 12:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774283938; x=1774370338; bh=dWuJZ6lZ6X
	e4OJAbmucX0PSCnOJAaQaslYLYPnH7/Jg=; b=TBBCZh9SJ8wyGIhTjSOAOIMOrz
	ParalEYg7hobz+ST2On13u9AphsqMJcJn0q3YI97qTvIpuC/QHzol1c1IxHXzepE
	T4TIkbO2JFhf47MRutazXyxFdkRvLVu4T/Ddzpq1RkuEG2C1zoxxsSyzbAqiJIdw
	MQMgrhFtFa+jgGOFun5kd37POH2JGGyfE8IJpi5/pSFVKmPApMZeWmLHQY2+BtjS
	sbT6Kqf2XRjymdtEwk63ShCR6jJxFNqv4IH3g9duEJzkX/rnv9YQWcxofIbWOHqD
	2CTaZdLNZJjSGqjcXPM9ziEFoGiWUxBdwBx40+a6eQoAjhdX+KAUTyWEt05g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774283938; x=1774370338; bh=dWuJZ6lZ6Xe4OJAbmucX0PSCnOJAaQaslYL
	YPnH7/Jg=; b=oD2zsOWTliraahMhHUcFxPHTc+KCAdbBVkZKYa4k/p/41V+acNa
	mC605czkt+DvARUWIA0duT8+uMfmAwtEC73ftlKhQWRGbMJm0RtnbgysjZ0J4dQj
	WRX4wfk0h2P+oWvBP7iE8xNT1A3q/CeJ4JtmxEjwzsAC3WY+dTUnfRNh4GlHXGBW
	b6N/OlXxHGPWA4/sF3ErsIQTKfefIpNzggYKeCDldyNs59lG4t1kUuiqRq42SGSe
	2O2ek40AMhQ+/n9A4xpntgxZ4uAtJ7irpl/52RzXwbh3nPO1ymTaheFRmy9OgTvF
	juVu8/rIlQW+kaGQidu3S0WJj4gDsvGINzw==
X-ME-Sender: <xms:oWzBaR1p7xBauZzvQ0UdoOJtVcqsc72QuQmjCsKi81gBXD0d20JrRw>
    <xme:oWzBae-1SHYKOq9dJlJRn_jlNXjkUIKNMb9cFSl85vPQk7rmCFnvH7hAQ-9qYuQAd
    tCIdkyx2rn-27xsRVH31AWLDF1qdaQscvoT1T-dBe_kQODBZr_gow>
X-ME-Received: <xmr:oWzBaaPD0E28DNE4PaZYNJi0K4CvvZdjAeMxVj_F8Bmp925TsP4WDG3I0M9nB2WNSh15ZgFj4H1Evk2_DyeEY86WguttQ1aESg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgefvddtheduheef
    geduieesghhmrghilhdrtghomhdprhgtphhtthhopehstghothhtsehpvghrthhurhgsrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oWzBaafojOtqovY4BDeOByRd4BPo2KiPYlxiqyjtMzkCoCCqqwFcIA>
    <xmx:oWzBaRXWDmU6iHNbyfj-h5FgphU9HbtONPl81CpwHXKYppck0sq05w>
    <xmx:oWzBaaheAPGYhD92yBaeCMJ2Oz8t1GzkcuBBoWvq2UkFFuLogrGj4A>
    <xmx:oWzBaY-FTDuyMH_osrzkfuii7FZV2KLyTjTCxYsU1D1jYcCS8rmlgQ>
    <xmx:omzBaXiYqxyXzeSG0mk9-pBak4K8I6MBR9YR-m0NroLHndqmiwe3KckN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 12:38:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Tian Yuchen <a3205153416@gmail.com>,  Scott Baker
 <scott@perturb.org>
Subject: Re: [PATCH v2 0/8] some diff-highlight tweaks
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 23 Mar 2026 02:01:39 -0400")
References: <20260320004138.GA3653623@coredump.intra.peff.net>
	<20260323060139.GA10215@coredump.intra.peff.net>
Date: Mon, 23 Mar 2026 09:38:56 -0700
Message-ID: <xmqqfr5q5wm7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Here's a re-roll based on the review from Yuchen. The two changes are:
>
>   1. Added a missing &&-chain in patch 3 (which cascades into patch 6).
>
>   2. Avoid length(undef), since old perl versions will warn about it.
>
> Patch list and range diff below.

Everything looks as expected from watching the discussion from
the sideline.  Looking good.

Will queue and mark the topic for 'next'.

Thanks.
