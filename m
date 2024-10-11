Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A338DF9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671003; cv=none; b=jACzuIxagZ2BbXVuQE5nNcSjxpurDtoYD8Up1vGGwjFBZVpz3IbR0NfH154CiuhKBgbn1WVC9g8R89WXlSyAgdfN5OBfAAvLtgRgAs6uInKjpdh/NCtwkugUYj7NGV/vGBkPwcESEVsTTvZwP1s2bqHGv1hEcOLuqN2gyZ+/cIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671003; c=relaxed/simple;
	bh=8+Tq8sOvDYTkFa672xbMQal1f6qQk9k1H5nDH4QAs0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BdPg36tXBYp6zj5C/DZ6ln0nbU/kCo8lTeNyIKh0fYu78QLCkFUWOUUR/6V4hsHW/vZIuUff9rpJincVETlgoiVn9CQHYye/hz8BN1VMNCgk7ckp1K8ZUMxuyKfQ3Jvqi6c4V7SQy/E4M0kXtIvDUwLQ1LZHFaLdwiVivdqr6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eskLUOlu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TCRQK7BH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eskLUOlu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCRQK7BH"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81C47114014E;
	Fri, 11 Oct 2024 14:23:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 11 Oct 2024 14:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728671000; x=1728757400; bh=hpBRM/wwwF
	k40dnNUnc+26PExkJ5lJFTrWQ5MNuxUVw=; b=eskLUOluvAJxLt+eBvECegqrY+
	oNstwdo0Rmd0VkOySE07Pw6ov8WpzOM/QD6A8r7MwluSGBQtH4+BdvLrDttURnq2
	wm75c4a8GjZvT8dSRgrHMLUdka1gymoY/pDKIjX8TER9i8zcRRtiFGFM92znADpB
	5x1Iaeum2HVuuL5KPmXBFAbhRX0sZuyU85z/bu4f//6B8u/BNT5f6W+NaHa4XiOl
	DaX7nVqThGKXa/DHMFF5DMJC9jaX4U8QESAImknlnCsSg4v+Ia4/wGW1F6EuioA4
	kL+KzhXm/zVpkYSBfVQWLmJrDb0giMq18QfEs43nM2jpejPW/i3UT3/d+m7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728671000; x=1728757400; bh=hpBRM/wwwFk40dnNUnc+26PExkJ5
	lJFTrWQ5MNuxUVw=; b=TCRQK7BHzFBR52zC4SrmDxOrWaY+VzM8+z3eb+zo+X3L
	XOf+iyoOZMgqs8sJHVCsxvWiK6pr8c6uKsCzbRrekOGFo93OaMnB/q9NoB09qSUm
	Md5d2bpA9kV/Al6XjTH389ruzIbtvYMLGxLTII6bW7GIb8C3TszxnqWDuWN5Ij5F
	uJsNu8hcH1vh4Ze7DvvLN+QlsU7CuZM7ru5JU5OvtMbZxLjaLaz5FuEeOmsdX+uU
	29Bv7NYGXfpUvc5zlOnVq6TIVes4lXU65TEiCBHgIlW6VqAlON1HET+wuMne38gu
	aSxa/p5YfT0UtgurtRg6FPY/s33Tbbb4CKd+d3c1vg==
X-ME-Sender: <xms:GG0JZ-BgLW2y8WK2NM6z4Dwx_Vb6xGXrpf9k1Y8KQNEDzLIkoKTsbg>
    <xme:GG0JZ4ib0RfCMaueiFXtjRQBSzWqlNG-HiSqFsZ3knemjqt9dE7kNDLQEj7CxHKRs
    qrfreNFHb2b9_W84Q>
X-ME-Received: <xmr:GG0JZxnBu74I3_IllMUm9_74j-DYL2h8gBOJ848dEuXUhZQmLxn-6IM9UNPDEnnpSmaVYtYLozSA1UULrc3quCwt2iyG4ekXfoEkLtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    rghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnh
    htrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsohhktggvvhhitgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GG0JZ8wZXdtMJOUCNznJRzRv-4N-ztE6tZstqgIFI5o_DvBy4KCPlA>
    <xmx:GG0JZzQIJfhExoNExc4mGdFjIAQ3FYH11RM-kNcEasLVRRtkasxXBw>
    <xmx:GG0JZ3bS-RX2nVFzS-DIWGudpoJEu9UshiYGPqMutVWMfdwW_PoG0g>
    <xmx:GG0JZ8Qx2pnzmbs3_jQtHqsWSbN-H7hl-CoA3-Y7Njc2JQHSf0TL4Q>
    <xmx:GG0JZ8QXeRvwcjRLXw8ROE5BJ_8seOyDw-vFcqmlH-PyRR3Z8KC8wlbU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 14:23:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  sokcevic@google.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/3] repack: pack everything into promisor packfile
 in partial repos
In-Reply-To: <xmqqa5faec4x.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	11 Oct 2024 11:18:54 -0700")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20241011082404.88939-1-hanyang.tony@bytedance.com>
	<xmqqa5faec4x.fsf@gitster.g>
Date: Fri, 11 Oct 2024 11:23:18 -0700
Message-ID: <xmqq5xpyebxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Han Young <hanyang.tony@bytedance.com> writes:
>
>> Changes since v2:
>> - rebased to seen: 89afaf27d3 (Merge branch 'ak/typofixes' into seen, 2024-10-10)
>
> Please NEVER do this.  'seen' is as unstable and fluid as you can get.
>
> Instead, base it on something that is well known and (supposedly)
> stable, like v2.47.0 (or an updated tip of 'master'), and then
> test (1) the topic by itself, (2) the result of trial merge of the
> topic into 'next', and optionally (3) the same for 'seen'.

If your topic really depends on what is done by other topics
in-flight, either in 'next' or 'seen', then prepare the base
by

 - picking a well known and stable base, e.g. v2.47.0

 - merge these ohter topics in-flight you depend on into the base
   you chose above

and then build your series on top.  Remember to describe what you
did to prepare the base in your cover letter.

Don't directly base your changes to 'next', which would mean your
topic will never graduate to 'master', as it is taken hostage by all
the topics in 'next' (and the merge commits that merge these topics
into 'next', which will never be merged to 'master').

Thanks.
