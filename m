Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C31E5B72
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051911; cv=none; b=uBHAOn/ueXPgfKGbJCAEo4gxmZAqH/Qv3Dg3q2j/+DhVTI+3yJE8fEOHKH2PJf9ihmP61tc5KxJZvRaF/iibH9LqUr3AkgYOzGwDt2cJIbmE64V05qWy8Nn2CDT1pkJ42qMJD8qMRBjohDj6KJNNE2lMNJgMuHDJ06m7VkZdlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051911; c=relaxed/simple;
	bh=LE3+hrxDJtH4pQu6IjVBOYdt9MgXInQnLIKVL7As+Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoCua0pXPUO7S97dPyA1yGdrBn+ezUv1dD9f+L2/Pwee+BlgItD96fImWoBS6ioAj3AEhantjwk6TNXmsM1tp8T+AUyfD7tbAXq3XZ/VHVT4GbCp4gQt4TRKJrJkio7D2M+X68YnYAqE1skQW+Fd5DXLQIGU9VsTlrHnGVUBMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LHtzAfgJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HT365xZ2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LHtzAfgJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HT365xZ2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70F1614000B9;
	Sun, 24 Aug 2025 12:11:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 24 Aug 2025 12:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756051908; x=1756138308; bh=oHST1gblQ2
	w3dSIAWxSlpfYw18fjaVdHng5MoAOz4zU=; b=LHtzAfgJPKVqXQdr1HYvi79UL/
	OPsP+TQvEMba4eHQnZP672rNFyttqXEegfgFSMjn/ZBIQsxdTLWQUAPyIOsPkNRR
	bLfcFfwX5MifHSeSZ6CrGIWrOJ/B6RFx4/nO0NE0ZwRogFZum90irRgiRqREm2IN
	V8fcTU61yEnqGcqb8VQxHfVZ3FpO0rrUjtIwr5A0Vr3cb0+ilPhwU4EY+CUqO4Cl
	vDMqDqa8xUEmHlelt+p7lwBZz8wwAtgs4koTSjVnh5wMbtx/fa/BQNG8P0osbjBX
	+D+xCijmZzqhnTTQNO/XqkOjZJD48WUfp78jBHxGVyrjXF7MvVaaBEjkcNpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756051908; x=1756138308; bh=oHST1gblQ2w3dSIAWxSlpfYw18fjaVdHng5
	MoAOz4zU=; b=HT365xZ2mwzh3mBQLnbn2Pu6OaznJaqExuMEyoTGTY/JsLoCnWA
	bj/EqWN5UDYIGTVxAuZjj0G0RgtS4YE8iL8K8XvSSlrfKRVEGL8usfIJJhtsBFIR
	7bAPhQH7jhk5PSpK8FyP7fAXJnnNATCkF1i1v0z4l+V/VORHdtiKK4kx0cTcx9om
	RC+NDuaA+2CcVUDWJLbL5G/L1wxELk346iFVpJk1DUEf/laGL4w0fLjKIcmPJJXd
	39wWECeXhzEHrGo9F6CllK7uBW5mnn+vone0UyHeZ6MnYA/x1vD2E5iKTIvH0iec
	+qONETkIInlGi7G0i6jDqSaE1aZOMpkXgrg==
X-ME-Sender: <xms:xDmraCrU3UOwxK6Ut5kGj6EHYOmw0DfbZ5iP4CVNlE6jL2b5frXVlA>
    <xme:xDmraJFsjH0xBXzWjivtVJChv04x8VyBgciBkk-yCpDp_oJMuwmsBTxLKVNi20etb
    IOjSpezmA3FiAIOow>
X-ME-Received: <xmr:xDmraHrv7VXm9Wl02gUVBKqdf1SE4d-qtCyP54paQOVkQzEupyzs0hOR5kYxADXuP8M0EvoQLHrvziXgZSeFZIHDGnwTvdomt70y5SM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohesfhhluhignhhi
    tgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xDmraCZiZFLBQ7CK00MriZlPCqiULqLTTl65A28vrGw3zqTlnF-DCQ>
    <xmx:xDmraAUNJEOdJlz2XPEmfeyYp21za_lGLOYefv4Dbtyq8F7DW2Sydw>
    <xmx:xDmraL9_sF7WQ8ohLY5ajs69-uqZ4yq0-MVGyJMLa1sdbBTgPuS0wA>
    <xmx:xDmraJ8Czkh3GkgiS3eAjYp2mQzkRt96UNlLuxFWbPR1gRhdw_i-OQ>
    <xmx:xDmraDGsKuU9qdOiSgwGfj9p8L_P7nPg16w89GjPKay4PF4Uyr19N1ot>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:11:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  Nicolas Pitre
 <nico@fluxnic.net>,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
In-Reply-To: <08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org> (Johannes Sixt's
	message of "Sun, 24 Aug 2025 00:03:29 +0200")
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
	<86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
	<xmqq4itxvi3z.fsf@gitster.g>
	<08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
Date: Sun, 24 Aug 2025 09:11:46 -0700
Message-ID: <xmqqsehgu2bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> Operating system folks may have worked hard to minimize the cost of
>> system calls to gettimeofday() in order to help applications that do
>> so, but I somehow feel even dirtier to hear proposal to do so to
>> replace a signal that we set and forget, to be reminded once every
>> second.
>
> I think that ship has sailed already. Look at display_throughput(). One
> of the first things it does is to look at the wallclock a.k.a.
> getnanotime().

It can be fixed if we wanted to, though, no?  Instead of doing all
the computation for the latest lap, and then decide not to show by
looking at the progress_update flag (set by the interrupt), we can
accumulate the total in the progress->throughput struct until we see
the progress_update flag, at which time we can look at the wallclock
time, compute the time difference, perform clever division, etc.

> That said, I am not very happy about the new calls introduced in
> display_progress(), either. I'll see whether I can produce some
> performance measurements.
>
> I observe a behavior change with delayed progress indicators that I have
> to understand and fix it before I can submit the cleaned up patches.

Thanks.
