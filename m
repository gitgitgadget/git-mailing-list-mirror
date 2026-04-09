Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834FB279DA6
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765366; cv=none; b=YFDLFxJNA6URYY90JBiFyJ2i8TS5QdHqxy8dj4c5VqFtwSjdZ/ofbo4EjHdw1QU0lAkugQghGnVFCQfJm4+GccNy7YqD09MIMgWYpzbIU/qXaRFWa6LPqx5L4FaHCPIv1+RSbLiQx+HuiuFsJThBHDS2r+AySxg426UBPruuLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765366; c=relaxed/simple;
	bh=Wzq4tHJOAFEgGgvG7VaxozD1W4EY227wzF6UC8MIlkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTlj/TTTWqjF34HRvOMBVYBs4CljmTjJvuchrIBDVlZvmmdEPqY91/UGaS7oWRQJeegVRMZmiSmS9Cwpz8xEl0Pudf5P8fNR3YxuE0JRnqey79E+fKsSMOaW5oDFKzEmjx4hDpf++7RM09EwL0sfsUX1y5CI6fmYbbCeGIlgg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RoT8gbJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tKlP/vTB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoT8gbJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tKlP/vTB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 993E27A00A6;
	Thu,  9 Apr 2026 16:09:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 16:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775765364;
	 x=1775851764; bh=lpLsr3eXHihCbQUryfJnOsfTkXvGUS/xEgDvok6ld5E=; b=
	RoT8gbJwAqFxwAtW8ux1On3NJYcfFtjjWnE0gdzuK182bexviss4EtXwjTNu8czK
	GSbMCl0yXpqkEDCYy72VXCLrmkzABLYrpz7bcIqDXSif8mJRIOiPYtqtZw1pnu91
	ywvloXyHYFCoLKW9o8NqwEy/PHk6MBQUhFPq0R1RALEIVe9NIE/iZ5Ehf+CiaktX
	3EChEoUsz9wvgmKjtJaq7bpjDbF4J3NN4MYG8yUQAsRq6ghgOJvwfMtgfN2GLQXW
	0cM/v/4fgk9UdDycQiQJPtH+ucwx9oAh6oy1Yskqv4deAwqnc+uSRW/1j6bZVf9B
	t1C75C/5wN69iLwH6LKfhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775765364; x=
	1775851764; bh=lpLsr3eXHihCbQUryfJnOsfTkXvGUS/xEgDvok6ld5E=; b=t
	KlP/vTBsQiLa3z+deVofYr4PxdKgo8kESphuM3eeyBpyfQCwNnlydHXa2bT/pUpm
	Z0sPltc3W3tEqkQPHbtU7FSYB9EHwYgeUSZbOb43C075Q3XoKZ+HnJE2rx2VuShG
	1++K4isdFqDWDEqb84TEfye91JSgtYbdrMSK5O3e1lr/ClQ6Y4FXZzz26Aam3pg6
	spYxPBgwcdlIhpbH73Yn+PgXJ+h1x0F1a6e2feykVanf3dfRo6ciHxeOtNz1JoCh
	U+Q6qUXa26smumh2AfVH+UDoxhrXKWzb36Fk+aHPFynIa15z2xfvA5iQMcD5WAlB
	DKoiN3rGzVdrRx3I5VdSw==
X-ME-Sender: <xms:dAfYadJXBiUgrYz54RbFhjHFXE-Oi5IAwNxKwQVWXQjBXE1lptllEw>
    <xme:dAfYaQkIBDp06yZCxUKAl7z92PD32zXw0hKFWEXIsFzowjq6-ieMyhX-eqlTgWBpH
    Evure76a3NUATSVOjhC5ZAM1qcfsbDLHZW2I69txl7GdXZT5ZmrGw>
X-ME-Received: <xmr:dAfYaTGKub0tpZyNjIT_GDd-paGerV2p8RcYHVvAkJL-B4e9xD1XVFwMzdq4T8159BQjdtkmS7bUDiDzxwWbbDAx7Bp0deTUwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkefotd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghf
    dtjefhgfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dAfYaYFgHkb2zNVOTeTKB3PVB_lgNUVFDLVBblCLDot95-qo-B9R0w>
    <xmx:dAfYaYN48GSay5PVSL3Mb3ZPIylglxwWuOgzH5M--f0TKpuYspO3_A>
    <xmx:dAfYafGC_sN848KHy00tQhqtKLzbkPe8qbj7D9M4JEn6BUYGBR8Apw>
    <xmx:dAfYaXNQAT9oJWKYhe4oennNPbddlmx9F9Lr4CIGWPMtpfC7EURapA>
    <xmx:dAfYaROQBoYHxMk0X2tpsP8rDFwZvDzmbL2ulgOpcAOWWIPA52atOL00>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 16:09:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2026, #01)
In-Reply-To: <1c0e5ba9-9623-4e7f-b4e7-f7e3343ad94e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 9 Apr 2026 21:54:29 +0200")
References: <xmqqikaatfhp.fsf@gitster.g>
	<1c0e5ba9-9623-4e7f-b4e7-f7e3343ad94e@web.de>
Date: Thu, 09 Apr 2026 13:09:22 -0700
Message-ID: <xmqqmrzbsxot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 4/2/26 1:42 AM, Junio C Hamano wrote:
>> * rs/use-strvec-pushv (2026-03-24) 2 commits
>>   (merged to 'next' on 2026-03-24 at 7c6487dcaf)
>>  + use strvec_pushv() to add another strvec
>>  + Merge branch 'ps/build-tweaks' into rs/use-strvec-pushv
>> 
>>  Code paths that loop over another array to push each element into a
>>  strvec have been rewritten to use strvec_pushv() instead.
>>  source: <084f3b43-91ac-4553-8305-03944e97eaa6@web.de>
>
> Curious:
>
>    commit 250e977a2b0aa8cc1c8063c64c44597a166e79f5
>    Author: Junio C Hamano <gitster@pobox.com>
>    Date:   Tue Mar 24 12:26:58 2026 -0700
>
>        use strvec_pushv() to add another strvec
>
>        Add and apply a semantic patch that simplifies the code by letting
>        strvec_pushv() append the items of a second strvec instead of pushing
>        them one by one.
>
>        Suggested-by: Junio C Hamano <gitster@pobox.com>
>        Signed-off-by: René Scharfe <l.s.r@web.de>
>        Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> I guess you became the author when you resolved the merge conflict
> caused by moving contrib/coccinelle/ to tools/?
>
> René

Curious indeed, thanks for noticing, and sorry for the mistake.
