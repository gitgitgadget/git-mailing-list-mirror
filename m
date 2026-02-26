Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64269364947
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124320; cv=none; b=k2NxLiJ32z7II3MzFMpkIx+2AosboQ+lCAn21K27YJZV9KkAVisaqGxObmwNLeJcBzDgIriDdm4w4Y2GGiugylJW3VxwumPe92nHSSKMIwNuemlqB1d1UxwoW/Q0pAKFTOyXkfJV4HVBLwopB39TdpV+WlqnW9S244uFK+cw+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124320; c=relaxed/simple;
	bh=t1JcMOlZRvbyxPaMim3ZYIe9fWkMzXdtL3VUNYJ3BJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJevgaGh7ulnOQ7Beu3u4vY7UrH4NMg82cVxRhFTtE4pmBRYChM0smZp1YN5wxuYGi45eiii6Kw31bEI/vMMfqFvUqcy3YYFyJrzsl3X4uOJXIIZe2vniX6w8v7t2lxOzX7hD1qKBcMqAcAWHxjP2dzSY7ZOKFkP8v7hcPmgHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DpA1NV85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nil1fSTJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DpA1NV85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nil1fSTJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7359FEC08E1;
	Thu, 26 Feb 2026 11:45:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 11:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772124318; x=1772210718; bh=t1JcMOlZRv
	byxPaMim3ZYIe9fWkMzXdtL3VUNYJ3BJk=; b=DpA1NV85+fOMDQMUOLEfgIrOyl
	gD9joFTFoj0A5TOQ0AcsVK9y2v/m/i319maYux8QqPLKu4q2ziOLWqgMusxMzn/F
	Y0TIP7ct/PyWQz0OXd1NrCoaCZvZiKHsRL5uuwnldRw8LDhrk/Xib9owY5rPG8yL
	3S2msrcK/Ye31/46ebk4qPFoUkQahEidx1RcVeqSOLRFqq9sQMDe93dMmlHyUJV5
	/BXz77N35U052+4e8JVnyUtk0jdpwvAl5xJhG0VEBoMMuRBsAORyCXZq646iLeM+
	7DuKrQe9gTpPrcyVW1oKAwNpRTpPiLgtKsYQni1UzS4KGu+GTj3gxBzj8fzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772124318; x=1772210718; bh=t1JcMOlZRvbyxPaMim3ZYIe9fWkMzXdtL3V
	UNYJ3BJk=; b=nil1fSTJLRm4UKoyj4MceFfEbf/qCN2yAI+HcKHxJ00fUn/sVTA
	+XkvnD80htYXRbkdtI1cAsyVmOk4SXUL5shZ/LjcxFGboD+VZeu+am4+CulwrZUx
	1GQb+4L9eQqJ+jJ79p0g6+URpr54hUA352Czu242cIXGy7qp/ymWstJw37Pk75fW
	JETTPf8Vtg+B4dEbiSpRCCtwFbrr3XBX9uuacWXEBapdD8Uo0wHMUf5H/wB4C4aB
	lLaC88SpQgcr8TbPenKmwVtFHGtDJ+yMYDRPpD//uPYFwwWBuGTYP3ihFlnvS1RL
	PNU6Eb7fAXuNN57I/FUmnKzJHX+9FbHx0Nw==
X-ME-Sender: <xms:nnigad2j3weYf7DZcB7TLVO7PKD3S51mkKJhREebWFtCemYKkgE3Tg>
    <xme:nnigaa85WhhTrnOWtI5faMDsu0QShKecRo8a42RXtaJ_l-vywS-UGVP1bt6-KIQIJ
    kMJkbxEo00UZ-pA_WJqzIO_IvmnaAKFd90_CMYkMxYMi9zzjmX7>
X-ME-Received: <xmr:nnigaWNcpADm0RW9eXYZF8fW_DeCDxLOj955onrGrRnzr8D_C1N7bERPuyaHojJj-ceaf-0rkxm47PKYHOmdat2-m5v8ebnCww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nnigaWdy4Xu5M6e_aXq_xorS6LJE5oNVXLARonq5D1ALgW69DORK1A>
    <xmx:nnigadX8z0m-iuAIbGLOkRNAqIO-uLjQs0RjQ_KFIU6alEhM4htdzg>
    <xmx:nnigaWheDhnWfb-3octdxN4-eWjk_VOniQuDG2ZqmVIs0yoThHivZQ>
    <xmx:nnigaU_qCCLITBaav92ledStjrbrIik8yl-yocKaz4X6MBDf78R5Zg>
    <xmx:nnigaViWMoO1TI0hKB_6ammHFow1lAF4ErPrTqsGdgvMLJpfPs7UhdU8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 11:45:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  avarab@gmail.com
Subject: Re: [PATCH v3 2/2] help: cleanup the contruction of keys_uniq
In-Reply-To: <CAPvEtrfmgq8f2z7tAvR-oCEYoiG2B+Pj9EqjUsKuewnO73tVPg@mail.gmail.com>
	(Amisha Chhajed's message of "Sun, 22 Feb 2026 15:17:19 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260221162359.43336-1-amishhhaaaa@gmail.com>
	<20260221162359.43336-2-amishhhaaaa@gmail.com>
	<xmqqwm05qsei.fsf@gitster.g>
	<CAPvEtrfmgq8f2z7tAvR-oCEYoiG2B+Pj9EqjUsKuewnO73tVPg@mail.gmail.com>
Date: Thu, 26 Feb 2026 08:45:16 -0800
Message-ID: <xmqqjyvz4foj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

>>
>> The striking similarity of the body of the loops in these two
>> functions bothered me enough to try writing this; the result does
>> not look too bad, I think.
>
>
> Agreed, I was also not very happy with the similarity present at these
> two places,
> especially the wildcard and tag part, tried to convulse them into something
> singular. It again started to look like the original so ultimately
> kept it like this.
>
>>
>> By the way, I'd really prefer to see contributors *NOT* to use
>> undeliverable and/or bouncing e-mail addresses when working on this
>> project, as I'd always have to edit the Cc: list to avoid getting
>> bounces.
>>
>> Thanks.
>>
>
> Thanks, I will take care.

Thanks.
