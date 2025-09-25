Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA2A944
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825832; cv=none; b=Sj54r2k+YXpB/14B0uqNpu5skSx30oqehdFapmC+C4QAH+XfJNtxxxDHku+UIZk6BjbniTeb4NoCOLVA/H+odvWsDfAznuMeI1Kt3Llza1aBULQAaQgo8wbmoD5rOUJVVMtqfvgZuhQ+YVmNuzUOKY1/4F4EsZDFgPqLeASXn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825832; c=relaxed/simple;
	bh=fWZst0Xepwn7io8gMOIUwnLoC6Pk62tcKPG25JiwrQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojQGjWaLT7UKy4Osnq3I/Jvzwtm7VsnmjWfLW6HMv2RHDBOMv8As95C//+PQH9UnPGFWPQO5fRX5cZqBHm2JkRCY7sxPLIAoadL/hRI7PaKHLyjUjx+ZJDNfhHNAkLLFRF9n7HgAJbJJsxOI4mjRZ92EluO6wt7yyrcSFLUpkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ykH6teVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hn0VzXOI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ykH6teVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hn0VzXOI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 700D4EC01CE;
	Thu, 25 Sep 2025 14:43:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 14:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758825829; x=1758912229; bh=e5b+R4OrOL
	uTzm8gSZb71Re4Tk4nDVAZSJfpbIQxTrM=; b=ykH6teVROnBgMmV75mg7pBNVQq
	JQYXZ7zf9v6Ki/+aHPufa8jM+biVlo6Lt/D4gQhAOYQFIa650yfeQxqbMcuKzxtO
	pEhrJ56jYXPMDnUaAgCEM9IA/DauCqsIT71EPDXS0Vv+TeBpm2bnY2xAzrKLKliZ
	3/zbeJUc7T/nB8QZRgdtIVdZKL/xtZEOAirOS2WyMDfS3Z9lxTXbit+ES/5nnGtO
	B4lqdGlmL2KpN93cl+f3w717ve4G7e7Wwrc87ruhN/euKzCJEJqwwmvQC+Rtmr7G
	WuYSHqettJN7jQwDMlXK6o3xToxrMvsgU9LJmyhObiTYDihtNOzWzRS1rPhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758825829; x=1758912229; bh=e5b+R4OrOLuTzm8gSZb71Re4Tk4nDVAZSJf
	pbIQxTrM=; b=Hn0VzXOIsXUpACwHKSXY4Y1MIRZlVHYhVju2EUGQ1DI/BAQpMPM
	8jInx2vDdEeNzPiiNtbbAlwue5DeF7yRPoqCE4EjqUcEMNTf73NvarPkK5oneKC7
	EZZo8D15ubgRu5Nye5LhI3KoXLzhlNs4Mat+kdf9JdTymibu47eIxykEH2k/SFEa
	2y8rG3eJANZOW8bqZWepYksRofz9jrZ2LCPgUSvU8FGEdo+u0A9x7F3rFfdJKOJf
	CSzg6UJo4x2GVOZVsRpSBuPiU5QsG50iDtFK0xyh51e6xiCnsc5Rmvt5Q4C+u9KH
	vqNBzLfDDW9eXM/E2ZorNqOf0ayO05dgzzg==
X-ME-Sender: <xms:ZY3VaCUjOC7En4UebEoHJcNRsTHw_NsQROaPPkifewuX8L64BQUTtQ>
    <xme:ZY3VaHCPWeIAjx6i4bLemfmkGx9QHGdBktvA6aA4r8zJmA20S95YF1oJKifAj5BkX
    kiiwTy8mFJzinTY8MRz4RY24v5Q2Vj96ZQKV9RoAygTPNprnXNkuA>
X-ME-Received: <xmr:ZY3VaG0iLhb5nvdKIiTOrasxV0IZGXp5RXRRn1-e01RhE5TaA9Qe6Eipc6GvS8-Ukv8-LnE6DO2XOVgz71u5U5x4PkE8tiMv-Qs3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudej
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZY3VaJ1lhI1IOY_nJ_9KTCWYuocuuDQpCHugMs43-DfADrc-6XC3sA>
    <xmx:ZY3VaLBwlpavIKByGgvxCzS5UbciitCSbIAr4zrSFqIVSC0RGh7AGw>
    <xmx:ZY3VaI6RlNdPwDsGgU80pWyvx9S2uU8VbPl8sGxj70Deqi3DsrEe0A>
    <xmx:ZY3VaMKRvZba37_Igtge6iMVBVFic-Jq8w46w_pEDNPoqvfZnHjhzA>
    <xmx:ZY3VaN4gldsUwa-iI-eZoxHGYJW8K0lTqWy28wtt41_XPNkJN-TMcn8p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 14:43:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Meet Soni <meetsoni3017@gmail.com>,
  git@vger.kernel.org,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
In-Reply-To: <CALnO6CD0fCF15Vdh7_AtuWiKeXUFbU_kqV=+wAMkmABzchV=Tw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 25 Sep 2025 14:08:11 -0400")
References: <aNOQhncjwYCwCaZ3@pks.im>
	<4FEB2B85-FC32-4076-9DA6-F47AAB096CB0@gmail.com>
	<xmqq7bxnn5cj.fsf@gitster.g> <aNTgRGeaPajVz1dv@pks.im>
	<CALnO6CD0fCF15Vdh7_AtuWiKeXUFbU_kqV=+wAMkmABzchV=Tw@mail.gmail.com>
Date: Thu, 25 Sep 2025 11:43:47 -0700
Message-ID: <xmqqtt0qfk4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> I don't quite think so. The problem is that we have so many different
>> tools that relate to refs, and you have to remember all of them:

Yup, but ...

>>   - `git show-refs --verify` to read a single reference, unless it's a
>>     symbolic reference.
>>
>>   - `git symbolic-ref` to read symbolic refs.
>>
>>   - `git show-refs --exists` to check a reference for existence.
>>
>>   - `git show-ref` and `git for-each-ref` to list references.
>>
>>   - `git pack-refs` to optimize references.
>>
>>   - `git update-refs` to update references`
>>
>> I'd claim that this is quite hard to remember. So...
>
> Agreed! To be clear: me asking questions should be taken as support
> for this exercise :)

... the same thing can be said about subcommands of "git refs", all
of which you have to remember.  I am not sure if this "everything
under "git refs" really makes much difference.

>> That's also where the "git refs get" proposal comes from. Sure, you can
>> use `git show-refs --verify`, potentially with a `--no-dereference` flag
>> if you want to read normal refs. But I would claim that this is almost
>> impossible to discover without searching through our manpages.

So?  That still does not indicate adding yet another command to do
it is the right solution to the discover-ability problem.  Instead
of shifting and moving things around, reimplementing things to risk
introducing new bugs, wouldn't it be more productive to spend effort
on improving the documentation and possibly filling the gaps of
features?

Thanks.
