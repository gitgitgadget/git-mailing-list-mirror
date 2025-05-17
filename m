Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741CFBF6
	for <git@vger.kernel.org>; Sat, 17 May 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747506263; cv=none; b=PfqlAqqM7Sbb635IAMpws4btOB3t8pPQ0ibfGhnr9v9hN/66lZxNjd4ze5ZvddVoFeC9dNleQcMy0Q1QvD85NJ0KNFNSgv6aXKZy1zSCdDrFERfUGqv2qGwWYYm3U0o4EW/JQ7VwsEX76IDQNYOd4tknI+VS/A78cjgbYFlz9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747506263; c=relaxed/simple;
	bh=qQmzzCJjBF98tlV7LHkLyzWt+z88GG7nncJdNql0lR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QP3+4iwuF23QICHiy+Kro93bzaFvjytuaPVInTFVur5wu5w8mDzjg2fB9aFeIWxPJsygC/mEHvd/zFwgXRoxkBpM8/LxMvYvsPODpVUgn1FyHf6NDMze+X6q1f50usPbGUIUh0cH4LZrpW54ED2sQsp+kNED4cJO7WgXS6bVaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g4yL/ks5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BShpo+xe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g4yL/ks5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BShpo+xe"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3643C25400DB;
	Sat, 17 May 2025 14:24:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 17 May 2025 14:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747506256;
	 x=1747592656; bh=GAwmrL/ezr6kdH0Iuw0d8GmxrnEI5CBRrIStRkEhrC0=; b=
	g4yL/ks5aTkSyXYXYZpFzKCxsIIvMkSuFuuY3iAExKwGZYd4wL/vBi8i7VqtQBie
	MNTR0QrqwF9BG01PDX7YiwIRYzy1hrWMzD3JZ8HzidEVPezLEglNaC0jkMkdUi5b
	n822qEMbNu1i8tw81jwz/njceTnjxMqK3XyU6tdncY/rS3Pvyxdcw9LUf+Z8nNZF
	XG+7Ziw1/VUP4sbGWRAUjbRS7uWXfBZTpNe1alYukeavZg2UmGXp9EtBBM5I2vn6
	egVcYPAJ5B4zeY0XBKNyg14uM9YPrtKDgRj9ezMgYY/Ou++GuWuZYPLPqRXqQQ5R
	fu6Lt/J+jOphyQpIW+jaZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747506256; x=
	1747592656; bh=GAwmrL/ezr6kdH0Iuw0d8GmxrnEI5CBRrIStRkEhrC0=; b=B
	Shpo+xeSdQy87VBoY2XXtncJ7FB87tT/XPn7jecT9X5sGcbfsC0jLsiHCJDmHcOK
	qxgXmyg7yx4sMSxwcwDzNM/Wiolz8IcQNkwnzbJpxNwZoBmmCyBmX6zTRys0l0ap
	EcJ6mgXGZwflmCv0GKqfXhfDSARYxPr4VSbcSHL/vrvWJxjo8DMflg93msRp2iNa
	SFAzS7bgBW3lfDWi+uobbnLcQ+9Nus0Ssa8fBXMnJfrNk8MulELOPkjFecgkg3FY
	QAhHQmLb7rxIWje6tY+aSpkTqt2tNbcVDNd8r3HjtkIhOW+/gttusWYAP6Bmbei4
	PrNiwFf2tpfxYDS2RhXpA==
X-ME-Sender: <xms:T9QoaACaXxGk2Q1Dn9t12du04ub-9riFCJhNANavbw8el383cwUtxQ>
    <xme:T9QoaCiuBorlL5hh1pdqYdpQmGNQZtB09C6vi4t5dNVQKiZ6yJPq7GhyIQUjS9Yr5
    J_yvq05OYTJbkKeCQ>
X-ME-Received: <xmr:T9QoaDlvkPkwz2ov383BMxoSE_Iea2a8E9V-rD1l9_FSYrmGdOKmBMDdBpJ5jcfvA-MuZrJ9bqE-IYHzdwzk73ZTawwmQfQS27Xeo_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlvghvrhgrihhphhhilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:T9QoaGz920EQE6NeBbY8lYwSHU_e6LFbXM2xheQ7dpv3sO-r3ZPy_Q>
    <xmx:T9QoaFSzLTTZ1nqyFF3_7pk-ZSMixQm8DHQPxBxVVsUO1JNBppdGrw>
    <xmx:T9QoaBZv6fC_ChKPoPvXjoLJVX7hUtYuhqy_XmRLI4PkrLn09StRAA>
    <xmx:T9QoaOShFzxA9n8cOjkipK1vnsjTGQ4JPmzfuDAgsSQR7NzfNxB6Iw>
    <xmx:UNQoaOVy7bMr6lFMhDIHlgOCXyFbY42qQ4dAAI1nC43TfLzIGgF79-UF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 14:24:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Emily Shaffer <nasamuffin@google.com>,  git@vger.kernel.org,
  levraiphilippeblain@gmail.com
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
In-Reply-To: <CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Fri, 16 May 2025 13:50:05 +0530")
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqr01si441.fsf@gitster.g>
	<CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
	<xmqqtt5ncq87.fsf@gitster.g>
	<CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
	<CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
	<CA+rGoLf7jf5r3C2mN7X84HNrWqsA9mMueEkCowm7Ftsgcd5EbQ@mail.gmail.com>
Date: Sat, 17 May 2025 11:24:14 -0700
Message-ID: <xmqqplg7qenl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> On Fri, May 16, 2025 at 4:09 AM Emily Shaffer <nasamuffin@google.com> wrote:
>
>> Mostly I lurk these days :) I do still keep an eye on the list. Will
>> happily take a look at your series tomorrow, I'm out of time for
>> today. But per what I mention below, if you don't hear from me, please
>> don't feel blocked by the review, as I think the MyFirstContribution
>> doc is comfortably maintained by the whole project by now.
>>
>
> Understood!! thanks for letting me know
>
>> > So for now I will cc Philippe
>>
>> For what it's worth, I don't think it is harmful to CC people even if
>> they will be inactive. CCing someone is not necessarily the same thing
>> as saying that person needs to approve your code change, right? So I
>> don't see the harm in CCing with low expectations - in fact, in my
>> case it would help make the email stand out, so you'd be more likely
>> to get a review from me (I missed this thread going by initially).
>>
>>
>
> Oh, ok I will keep that in mind next time.
>
>>  - Emily
>
> Thank you,

Thanks, both.  
