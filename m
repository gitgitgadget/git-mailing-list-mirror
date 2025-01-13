Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB3240242
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781334; cv=none; b=FmBkG5BRz0X9dk27K5QmHFDMf5uEkBNpmTVS1RR2sV599b/VmMh6rNmsef50AXHI3PoOPbRP8v934MA6kM9q5g13bP9ixRNb6ummlKzv4F7fPN8z9xCOeadM49gZB25sz+aDAd3otR/oRgBNdUJqYfpsvNUdPCUGSaBxhsQXNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781334; c=relaxed/simple;
	bh=Sc9FfYXk1IR1GM/uKsbPAiaCWVcnZCibnZLxoy70dtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9JLb8vYIT2mF6z32dym/9xHgSTvt4dOdgo6kx3dD1GtqZkAt2J9tVV4iGEw2jYWofm9oLsuUGFrGLTgbgjTTgitDJqo4LuGz1NUNE8VCzVYKvrzqR8RXGCSCF5f9p+WEhod945WffLqHGMDgozw3/OR87YUECjVvqDaDgP9uQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EKIlRJGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaDScQIZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKIlRJGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaDScQIZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D6E541140101;
	Mon, 13 Jan 2025 10:15:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jan 2025 10:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736781330; x=1736867730; bh=kkM+edTegk
	U0rgbdrtWqZ5DxdjyQVKsx8J5SfOcINWc=; b=EKIlRJGYS/ViCQk4qh9/VvB/aw
	znQoi6guCEMhVQGCJRaZYbKg7KfrPuQDAEQf1EHUvVPwuGV1v71SPvNO17n7q+Q8
	o6uia0Zq5tiKznZ5NBZBuPO3VdY3Bk4SVVHjV5nqTxNfLqdM0c4SfZHjBPsIPcXP
	TI04+NqwXg0EtXKRnbBcYz+uQLIFpzWGmUinZx+ahONtRKrbvooJnG55CAD2XCZ7
	tiYk/it8Ax7ZnEeXkziPpipXl9L0QKt3o0JwNWYI3edb/6JLl1iqmtGsqSNd5n9Q
	yhOIyQ1GQFe37LGY4rLhCCjsuxG0zeMyHOH8GXiGlakBvMzxvXHZtf/o+QZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736781330; x=1736867730; bh=kkM+edTegkU0rgbdrtWqZ5DxdjyQVKsx8J5
	SfOcINWc=; b=PaDScQIZc6IjurOQt1cAEae0H5YTb1KCQL2S3dIq/yhZCXND/qS
	J9s6jLd324sMW4iAgPeEyBEmpVCoj1BMceFJjImMWnWa7D6wG4WXw2vurPDi9PJi
	QCfBJQC93VglP57Vpj37QZLnMlhVWNcglKaztp+apPg3LOl8ZGsTw//FXMOwN3RU
	ld/gY+q+vToJ6++CA3Xsc+ODl1rVKPuEvsx6fnv2tYp1B+SjSwr2222VaFqq0C9D
	dSF2AMrZvlvPpp/HE+V0Jz70K7OEJehlr1fsdyLWfA4+JvfEq4k/G6l6Ya2pQxB0
	olc3TDgPBUmYXzctpbGTq216kq5CKcuET7Q==
X-ME-Sender: <xms:Ei6FZxfjsvFVdD7NWIh5amzBbUg7X-iOWrfLR45jTNtx1upB7WS8Lg>
    <xme:Ei6FZ_N2WzRqG4D1sCAEAQSzLPYs8r7RLPdiOBvLiRw1uBaG5yaYqjj3RXSU99Fn7
    64TBKMGFkU0uV5Grw>
X-ME-Received: <xmr:Ei6FZ6hPNNEvfceBVmRAOY6y-XwQQ3dPqsdojpMIZe6Uhj6UMrtj00S5bVc-rJ4L0Z4yBEwbGwxSwDba6kug75CI3uP7H5GBiJL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ei6FZ69Gmnb2BkPwECe79NEkPyK12kR5JLA9zegcMJRKk7Spj6mmCw>
    <xmx:Ei6FZ9sWyULgooRfgFfRC0I3HiD7UcEuYqlQzxYNB2BVqeyxij6ZFw>
    <xmx:Ei6FZ5EZ8pa2tBcLJikRdOhscarN_GorIc4ykf4CXvBR7MhonOUrpA>
    <xmx:Ei6FZ0O6VoozOJkTe3FUwqylAP4Af2fKhujlotYXsfLWVMPujKOTdg>
    <xmx:Ei6FZ3IufpDpfdO6MQ4GFl6AORATSJa3FB4OA7E_P011yBknLBHyNgUM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:15:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jan Palus <jpalus@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t8002-blame: simplify padding generation in blank
 boundary tests
In-Reply-To: <Z4UIWId7ExLB2gWJ@pks.im> (Patrick Steinhardt's message of "Mon,
	13 Jan 2025 13:36:34 +0100")
References: <20250111231107.2190448-1-jpalus@fastmail.com>
	<Z4UIWId7ExLB2gWJ@pks.im>
Date: Mon, 13 Jan 2025 07:15:28 -0800
Message-ID: <xmqqr056bv8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Jan 12, 2025 at 12:11:07AM +0100, Jan Palus wrote:
>> Fixes compatibility with mksh as well:
>> $ mksh -c 'printf "%0.s" ""'
>> printf: %0.s: invalid conversion specification
>> 
>> Fixes: e7fb2ca945 ("builtin/blame: fix out-of-bounds write with blank boundary commits")
>
> We don't typically use Fixes tags in our project, but instead embed the
> commit into the commit message with `git log --format=reference -1`
> together with a description.
>
> The subject can also be adjusted a bit: we use to just write the test
> number, and the important aspect is not that we simplify the padding
> generation, but that we make it more portable.
>
> So, my suggestion would be:
>
>     t8002: fix unportable printf formatting directives
>
>     In e7fb2ca945 (builtin/blame: fix out-of-bounds write with blank
>     boundary commits, 2025-01-10), we have introduced two new tests that
>     expect a certain amount of padding. This padding is generated via
>     printf using the "%0.s" formatting directive. That directive is
>     non-portable and not understood by for example mksh, breaking these
>     tests on platforms using that shell.
>
>     Fix this issue by using "%${N}s" instead, which is already being
>     used in t5300 and thus portable enough for us.

Is "%.0s" really not portable, or is it just mksh
being a bit lacking?

"That directive non-portable ..." -> "Some implementations (e.g.
one that is built into mksh) does not support the precision to be 0
(i.e. "%.0" before the "s" conversion)"

Other than that, your version is easy to read and understand.

>> -	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
>> +	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
>>  	EOF
>>  	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
>>  	test_cmp expect actual
>
> Okay, makes sense. And as mentioned, we already have such a use of
> printf in t5300, so it should be portable enough for our use case.

Thanks for reviewing, and thanks, Jan, for noticing and fixing.



