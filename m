Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346D1C68F
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765066717; cv=none; b=I8UoNg+pYlydOY+JRQLTAfUwUOunJTW58Sdt97UtBj6Pl29sIFkMrBnYgBTpM3VsIyimvvgzsmwztP8AoSMMETH5GlNaAA/z2UE8Za6TSpG/BJ7c2YWt1TKfHsRnHMh4kC6kM4jpkUMh911Wgut8+lHZHPbJnonJND7AzT+mbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765066717; c=relaxed/simple;
	bh=3acBDWquIo5rsk/33o1HgHhZdoPxbZPF1rBCxXnYG8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QWthvBl1bbTm16kxS4logU+PUDeQrDLlInJVMnjlHKCk3Wtn7+sMIvHJ6OhA/v8H+ulGHz/l4Ws41UCvgshNWdcxfLHOr8UH/lpsqpLv2IIGBR2ZnlSyK0LS9ZziGhcgWKiNsXd50fYOAN4Rt+PBK13AhRrBTGqJZ/oWhaUMmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ebDSZvwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkgPsf/v; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebDSZvwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkgPsf/v"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0109C140004E;
	Sat,  6 Dec 2025 19:18:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 06 Dec 2025 19:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765066713; x=1765153113; bh=sOvtLLtys+
	AIHFboJbQuEQwSc8yhFsms8c+cLdMeCt8=; b=ebDSZvwZ6vtsZWMKSmP0u1EqK8
	K9q69RKwki0tZ2kppgPC0XWTfc9s+5aAZNAvz0Dcw1m9RsDDJ7DpzEv7gqu4YGH4
	cPAXXaNgwHv0XZBQA7Lz6mmdW+ZwVINycAM8LxDWUtK4Ffp70DfkiVv212yOt8pb
	EfNJs+fByse8hdfEnuk8tGoJSu14dMvLU0aMAX3YKj6GFG3YJIyWMpTa84OSoyyF
	efWGtaBM08wzwzW476JfV92E9Tujp37CVRjFpfl4ZBD9srJ9pPlsghih6aHz3Qj8
	aqDWaTqNXI+j3zNxPpUeAfQ9YNn8MEYRLp1nBN04Wplk/auXZUhJqucjmxEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765066713; x=1765153113; bh=sOvtLLtys+AIHFboJbQuEQwSc8yhFsms8c+
	cLdMeCt8=; b=IkgPsf/vH3jW9iuDIbqoh6AP3eZSwhmzZQnwM09xh8uf+lBh+9l
	jdfs36FCbnUh+l2D/LRHGU2cxi/KvNDhq/0reWnvJraxGo8vqiIOrdtU6gn4EkT6
	/gut1P5ADLqNu1AfqA2s+wT7lvGImoEpPFrexKDAajhs76MEZqM3Mdb89oBqwYWU
	HmcHTUA/OVnytYuGHIFWLD6JZd7zVsAuoOXR2uaEICAkvRIcVPsjE81od4jS5W8t
	QWmYMeIFyGrPdKsb/5fFQvfsQ322Uz0f881SvNwtubacY7kzB60mpESK770MbCg5
	ilGT6ozak3lkAMQ1Yr8Ox5e8jh8NGp41srg==
X-ME-Sender: <xms:2cc0abmYXuoASr6Il0OvGF8x2RJdZly1nvjf0ngMcbN95uCZDqFNMQ>
    <xme:2cc0aV39N2OHL44B6iwYlC28X2vT_g8pXUVUoqyefWN3xDzx7aBag3B1aLf50DwNZ
    q58OduzKZeJU6JHqVP_TvEELV9AgR37bw8nKrQ2ITD3ZL6L4equJA>
X-ME-Received: <xmr:2cc0aWp8HjKU6jTpUwOXUVK1eb5matw5Pq20V5tm2IPHa4EHVGc7-Vc39mMeFnQHxtetgDlddOnvRqmhPxjduAt8XFo150vBIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhfuhhnnhhivdefgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2cc0aSdDmjE2x4HNDBU_kQwR0paB869ZhUefuWjez1VKqzA42iGYOg>
    <xmx:2cc0aVrXOB49tWzlRrMU3YKLban2UMiKgeLm_uBBmHR9H2Wd96uPCA>
    <xmx:2cc0aTHbPNEvQ8A4cjlcr98FFBa_PrElv-kE3POLyhry74teySu5Nw>
    <xmx:2cc0aVtt7tqJcz1jNIX9HG9eQcl4FGLmFMmDI6kHdewmQuvhbnnapw>
    <xmx:2cc0aSKLZyI7upIiA6QX2daTKajs2qdB1njpxa-LpTjsXTulZkEnuv3D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 19:18:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>,  AZero13
 <gfunni234@gmail.com>
Subject: Re: [PATCH v3] win32: pthread_cond_init should return a value
In-Reply-To: <xmqqecps5f8u.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	20 Nov 2025 17:46:57 -0800")
References: <pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
	<pull.2103.v3.git.git.1763675016637.gitgitgadget@gmail.com>
	<xmqqecps5f8u.fsf@gitster.g>
Date: Sun, 07 Dec 2025 09:18:31 +0900
Message-ID: <xmqqwm2znnzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Greg Funni <gfunni234@gmail.com>
>>
>> This value is not checked, but it must return to match POSIX
>>
>> Signed-off-by: Greg Funni <gfunni234@gmail.com>
>> ---
>>     win32: pthread_cond_init should return a value
>>     
>>     This value is not checked, but it must return to match POSIX
>> ...
>> -#define pthread_cond_init(a,b) InitializeConditionVariable((a))
>> +#define pthread_cond_init(a,b) return_0((InitializeConditionVariable((a)), 0))
>
> This is tricky and I like it.
>
> Because InitializeConditionVariable() returns void, and return_0()
> is defined as such:
>
>     static inline int return_0(int i) { return 0; }
>
> you cannot directly pass InitializeConditionVariable() to it, so you
> use a comma operator and pass 0 to return_0().  Because the type of
> the comma operator with mixed operands is the type of the rightmost
> operand, the type of "InitializeConditionVariable((a)), 0" is type
> of "0", so return_0() would happily take it as an int, and returns
> 0.
>
> This should work correctly, but it still is tricky and yucky.
>
> You may not have to use return_0(), but OK.
>
> Will queue.  Thanks.

As I do not do Windows, I was hoping somebody more clueful than
myself on the platform would give an Ack to this patch, but we saw
nothing.  I'll mark the topic for 'next'.  I do not anticipate
breakage but if there were something fishy, hopefully we will hear
quickly enough.
