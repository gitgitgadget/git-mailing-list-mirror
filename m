Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAB270569
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764363046; cv=none; b=HHwwiz2NqNpBnYUxgY5G2FUZ485hjCl/R9nNKWq1V1CB4wImqM7LW9L8J27x9lUD4QgJlc9cqC5mBVDMm1Y4/CWYIx3vNcHpR7vgeQEF9t2Sb6p5SoKdqJEEa8Q1Bv94i2HEdzkzGBearj08bg0dDBUu+eikIVV8yKiIxr/8cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764363046; c=relaxed/simple;
	bh=BEA5y2wjAJcCMcrS8I90AdtYC1vQVJmanKprrw+jgZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SxvhzO+1GMGyGscUnQ/uEaQ+lnnX2Y0Xyi/EGrO6hbyKxb9ECqo6W/R/wb+cXSFi4cEj+S1wOAP/TmedN5ZwI1ApbvpUCYUVri/uw8SZSczx8zx8vme+VUQQY/v+ebKO7kR9gOXUQ7jufUBeZsGxrbVX40hwa4ZBdBjGAAghnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cJkEAHdB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M0NsKin6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJkEAHdB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0NsKin6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9282C1D00618;
	Fri, 28 Nov 2025 15:50:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 28 Nov 2025 15:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764363042; x=1764449442; bh=TZke7yLPQm
	Qucid122Jl09pDeHP7ywKH9cNIo1ElQjY=; b=cJkEAHdBlxkhH3++oX/YzkReVf
	mMxqq8dJUpQKKJSdHJJjc05avBNf1V9Ple1MX6wjX50njo2UEVHMsBb4XaSGWcMb
	0SVPopTvv/bm+zob2eFCe0Ua0FOOHTne69h2FDkLfHUVgwiPVI3jMqoFFPtIlLrx
	Sf0M2hecM3rmFF8y6B39E/OF7zNX6xxTChLnnahqCNBZUe3JYVUUH0vtafJHvDs+
	WZJG312aaztU4kOIXBbDQ3rvPr19N/AaICpD+6tk1ovOdDA54MHsscy5Qil+HFv5
	XisoYdgktXtkXZeIxMx/VaRBRNxOBrxwAFkeDMWrbWUjcd5Y8Z0Yhz8DYS/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764363042; x=1764449442; bh=TZke7yLPQmQucid122Jl09pDeHP7ywKH9cN
	Io1ElQjY=; b=M0NsKin6CWSw6jZCd4eSmlKSoYgXEONI2mX5XkPv2+S0vzXhbK5
	bunBDBASis4xV60wnYXfMrW8L7dE3KbKLqyPW25MsD7PQXf70k9+fK9bSxlqaiE0
	UkIK0xo1y6o2L4z3qLER7Ojhe5kgGpILYIx9ZSaZ6mkDvg/+oTr13L2x1d5XSAyl
	A2TpkZh/L8m/tDtZ4TLppVHM/h/gFG8JIqyCK4OSonGnLwcbOQgNRnnqFfcnUS44
	nT2h4TT2PpidBqc1xKSxMhy/KOvmfKbhcqrNFsrMhQFE6dpJ8/cd1RKsOjDKwo5n
	p/+980hMGk9RW69cKd12kIxAyLYehXZNvZQ==
X-ME-Sender: <xms:IQsqaXuzF_C8DrO0VxRS_Y2MBJMUeekAow2pjPgd_xcNwPwE0l6p-Q>
    <xme:IQsqaS0C8Su1xumRpkomYWIAwV9kqiyAO12yzOh4R5I7NhDXjFXScdUiWDhBazChX
    hkTRnah3pksdluxZUCzSCTc1Sd4RPwEqICxXR13c3nJ_Qcs7WukLw>
X-ME-Received: <xmr:IQsqaQ771PGvReKVNWYnZ2d8Mu5xUQZD6ZBrFK7UjonL_j3CpVtXbgTtEDvF_SSifxYYRWwwcWav0SRw1XYTLQh7X1_cye6rDJEH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IQsqaRWdjAHrYRH-Mtpx4D-8DvbQaxKUBU1YWRodJ5BF7yc5EyGVMw>
    <xmx:IQsqaQjFhpfLoX0ougWNvzdY0R7vvYXUs6_rjZ-9phq3d3ccARoouA>
    <xmx:IQsqaZeHcWBqcAxiDLmNE-aQq8LHL_026Y1QCt-GNCtXIfcm12p8Kg>
    <xmx:IQsqaX3VP2JYWQDTROERtCMiIx9HzRCdUPrNWW54CDi_qMliYk3sOg>
    <xmx:IgsqaU7gpSc2W6V69lpNhpi2RyfuS29_GMzvTxeGp6nsaNH7-YoKz0wX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 15:50:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
In-Reply-To: <CABPp-BF48AF9qoP_pUs1X=sUV-_G5BpsxnG6AEhQYkJkE_TBjA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 28 Nov 2025 09:07:04 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
	<27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
	<xmqqcy54mro6.fsf@gitster.g>
	<fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
	<CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
	<c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com>
	<xmqq7bvajesl.fsf@gitster.g>
	<CABPp-BF48AF9qoP_pUs1X=sUV-_G5BpsxnG6AEhQYkJkE_TBjA@mail.gmail.com>
Date: Fri, 28 Nov 2025 12:50:39 -0800
Message-ID: <xmqqtsydj2zk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> How does one distinguish the "topic~5" in the range "topic~5
> topic~3..topic" from
>   * the topic~5 in "^topic~7 topic~5"

Two answers.

(1) You don't have to.  When you scan cmdline->rev[], you can notice
    the ^topic-7 form and reject, saying "we accept A..B but not ^A B."

(2) Or you design and document the interpretation you implement when
    you see a negative commit while you scan over cmdline->rev[].
    Perhaps you may make "^topic-7" to require a positive commit
    after it and convert "^topic-7 topic5" as if the user gave you a
    single "topic~7..topic~5".  Or you may do something else.

My assumption has been (1).


>   * the "topic1" and "topic2" in "^$OLD_COMMIT --ancestry-path topic1 topic2"

I haven't thought it through, but doesn't ancetry-path imply you are
really interested in the traditional connected set of commits?  The
path is a connected subset inside those commits after all, no?
