Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014F79CD
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347744; cv=none; b=jNotBkqoGQ0AHXYgRHlLUns6/7+ZQWnyKbJA7lHdQPBve8hw+AbEDHtzcqiBDxkslmeyZncev8yXz9fzXJ0rkK1YuI2Kpu40bxEWUdcBxQqjIjBjrLU1VqXwr/CCmxkFiO3oMUfJSVMSSDFTkxDl9ttMScv+SPnzHtcWn7kKI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347744; c=relaxed/simple;
	bh=Karta7yc1HdAVU01tyMfZunfDvycIVGIcssW4StkykI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ar4Z1alr6PCIXr1+MW+tc/zHdnWotgQrTCXMT7S66mZ6fJBL9eoBTlZyfC7VA1p5aHC/lDVJucQVddqTzq19zgvivQ2rZRdn1oWUI5OmptXDhtpG/ZKk/0ilUYF+WGeTfS+aXh+OqjY+zWSm5BycMFs/uM/5V6H5cStD3up5WBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HADN4mxk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWGdJLil; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HADN4mxk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWGdJLil"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 039F9EC057A;
	Fri, 28 Nov 2025 11:35:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Nov 2025 11:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764347741; x=1764434141; bh=JV1B/alz2v
	mJRHXBe30SYW+ahwkpqIJpvkYQlUtWgB8=; b=HADN4mxkbLSmcWKcNTHi7kKKSk
	tsf2lxuxAQ+ipUq9MJpNRnQlltcJN3XwDcX74CR1eC9TGo0AfpC2KaGiL+Ar4oGT
	Bkw94vNkVdYiy0ehMO/+Sik/2LtCerGWzIlCKLxpnvSbhNrNcpmUBQNdBRjoTfKE
	Z2Ylcv1UJOpauY9PvPSn/tv9e7YBQfUpRyfyRzqqhWDJmoA8Pat6mmQJ39j2iZO8
	IQ1FmfPXNLHd3F/grjPDbdDJX908dVzqwK43KZrJeTlZxrcAvLky+T0RCatldhLq
	BUfJnMkDr8SO+5VfWxvPgI6K0P2vLC4Og+BTprA5X0NnY2dES8B/5JCaAPmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764347741; x=1764434141; bh=JV1B/alz2vmJRHXBe30SYW+ahwkpqIJpvkY
	QlUtWgB8=; b=aWGdJLillogA0jlLwMqn/2T8T9ostRdvdN6a8Bq/Sn5hYfFImj6
	7cQHnq9dnZqNNALm/EYcE/W9ifV+vpokReu+6+DUmzXbVQx4Rc3RnwaKYfxBe6ga
	+3kqnCKdCGeqLR8xqrmp/OS1l9HLhd9DQ/8yElmeGi6azr0GXLPbdISItq+Styab
	EEreAisniansmkUFLMYKErG2Lc924RPrH2v8pouturgtLLf1Qzh8cW+X1+JjTyxW
	+129xK5p1C10RJZ27RhTA81GCBFLVtlJZ/WOPNjFfe3ylkk6PqKiSdHL9M2SNeHp
	5V3/4lpxoQtTNYFN9AtT/Avg4efvkO40VFQ==
X-ME-Sender: <xms:W88paa-g0Albmz1Hb434oOto2pWlnge9HnZ3kmKT0k9Tad1WeE7xnA>
    <xme:W88paVG5uggcT9UWdo1FIt4gc3wNE7zXBmBG_O0DQCX5vjojd178QsIzukKm8dIS0
    qs5dyxaODCkOiFhM_A19ayTFu8l8MgDoDuJKP7QKdEttFTWGMhHQA>
X-ME-Received: <xmr:W88paWJNcjtJ_NERJ7wB6qrvV04xIXkeIMd4Q8tW-YTxKJD_NNBdU7rYUh7aULruGsfT9YUY7bUqdQyIH--eUy3gxdnQQJ9po1ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XM8padki8G57CK39s_CwB05a3JS_MKDHkAcNhCFFlsjqg-oBIr5ntg>
    <xmx:XM8paXzRxN0rR_juxhNTeTXfquJFugQEw0P8RY8UydkvV5nReTCaiA>
    <xmx:XM8pafsM_RrxVxsJvhQ6NyEgEvFWQE1WPVWO1u4ciB9RBQ7Zy34fyA>
    <xmx:XM8paRF5r9myjt8Ij8p2N5tF6i-S56RZzfO8VMcEG4z33uxB2VJ1IQ>
    <xmx:XM8paZarbM1OiLjq9nSy6M-7VMkh7tCP428w1h3JzDt0NKOZ-yUPQ44h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 11:35:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
In-Reply-To: <c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com> (Siddharth
	Asthana's message of "Fri, 28 Nov 2025 13:54:07 +0530")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
	<27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
	<xmqqcy54mro6.fsf@gitster.g>
	<fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
	<CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
	<c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com>
Date: Fri, 28 Nov 2025 08:35:38 -0800
Message-ID: <xmqq7bvajesl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Agreed. I will keep the current submission focused on basic --revert 
> functionality. Supporting --no-walk for disconnected commits (benefiting 
> both --advance and --revert) would make a nice follow-up series.

If we want to have a useful support for disconnected set of commits,
"--no-walk" is not the way to go, I would say.

Imagine "among the 7-patch topic merged, the second commit (i.e.,
topic~5) and the final 3 (i.e., topic~3..topic) need to go".  You'd
want to be able to say (without going into details of the syntax)

    revert topic~5 topic~3..topic

The setup_revisions() parser is still the right thing to use to
parse the command line arguments and pick out "topic~5" and
"topic~3..topic", but instead of letting prepare_revision_walk()
turn them into a single contiguous set of revisions, you'd need to
check revs->cmdline->rev[] and

 (1) treat singleton as its own disconnected island that require no
     walking,

 (2) treat A..B as a range and independently walk them, and

 (3) dedup the result from cmdline->rev[] elements into a set of
     commits that are potentially disconnected.

I agree 100% that this topic should not attempt to deal with a
disconnected set of commits.  That can and should be done as a
separate series.
