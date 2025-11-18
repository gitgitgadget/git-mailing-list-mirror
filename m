Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAC30DD28
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501304; cv=none; b=NIFtFakESwAHOKUUCbNpmpcRd48npRfP9xPLFPJzEzeafZvNvFpBAcWxciDU7pLl9nPjGRyv4uKw3Dsu5VgSSf7k81aUAVNKjkF0mZRCyueqEQ+hmNorHMaNsshSC4T6SWXJpj2gUBYTbRmh65WadBmGNmd2d3oo2SMEoo1OsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501304; c=relaxed/simple;
	bh=4mahHAcxgKJUwuCcniUFBowITi5Gu3C7BwMoPxRyNw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CeNtBcTsN2EH9opvYZe8Al6L3zfBr4VqqwdAHpu9prLMzXmewf0tlpsjAs488Vxy+M5KMKrKxzSOF1zACe2hSBzKRdU5Mf2vKMnM+YUg//6/piCb4PYN5KsZBye145JmDgpjlY8nX7fYgk3tlbuLaQmS+KgARV/kPA29P1gXmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jjWe1od0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCok+5mX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jjWe1od0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCok+5mX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82DB8140009C;
	Tue, 18 Nov 2025 16:28:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 16:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763501300; x=1763587700; bh=os20kN6IBq
	UgT4x9oFYaKbECzU2IdYwM/Zl0V68DJ+o=; b=jjWe1od0PzQt8ihCTwlfrhuvaf
	6I0c/HIB2Ib/6TMZYbaInhkiMvt+0auLt4R/fnnlZCZ126a77Kc8ksNMnLC1nRGS
	wTu9Z+uCapYhFHsqGluXynphjDkunUw2B9cHwIfUBuSLCVlyBUCSInsa3FLnge2i
	zN31jvUYYJtIL+/+8zYGBniVmkCXSkg2DQdx+fAk0CWmiNVtZzu5kFcIkUsd9TXl
	wJPF7kXg0U3D+BIrfJ0EBUdgXIr+PY49oa662RGcLQkLegcEK+N3v+G6EUUG9QKW
	vvPIkFac5z4oSWYQ6fmBq1pKVetI7Y8Q7utp8/dYea1D9EdfZBvWxaf18D8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763501300; x=1763587700; bh=os20kN6IBqUgT4x9oFYaKbECzU2IdYwM/Zl
	0V68DJ+o=; b=nCok+5mX5ii1ZzRDtLhpaPAtFj0/rZ5WyNN/ilOOpRTW3OFbPb2
	Bx6BbXjVybf5HG81Hx+CIx+MpDoUaRNYNJ6gOE4ghWx4LW9kwjztGbJyupaeRsz+
	v2GUIYrCou27jIxQnATmi8KG1s8SAR8QxFuZlKDP4Ec3RS4zMFL5jVo/gO1VuMQh
	wfz49D356LkdVuYrNWSSSfgjbMn1aV3ddJyHtXmJu+91txOmmIJKz7YANFluhvNm
	6z1NpM+n/M8nyCN6z+pXllsDLKe7EOa8j3AerxolMxpKGddeTcKw7BmrrQMfHqPf
	OQorWmzkuswgpaXm+NbdH5ADU7Xolt0roFg==
X-ME-Sender: <xms:9OQcaQVvCDj92o35b_O9MWLM4Q-gjABb0friBPFTwt2TL-1a_wdqeA>
    <xme:9OQcaYQEYxXVb3XxnVFeO_gRxhew6D_0nZMbp01F63DVcW1xMw-z5PsmbObGF0qRe
    318NyrP1EC1fXVgs5n-ztdB5cZr9GmpSvoV2KjiFfSGZavN-fDKKw>
X-ME-Received: <xmr:9OQcaePeqvuOiHjd6NFOw5l5lc8DmMQGztXumuvyG6EgOj56gC0tWl3vKkXIZrbZk8yCjF9-lZdekXJ808wTwqib8mtHCpxnMw2z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9OQcaWRIMuOE3FDJ_ufOv5rzNGUhDu1_NEPQe6MP8m5BqtmMYPL_Tw>
    <xmx:9OQcach5GMRRx_HJu6SOESY9RcIdLHF-XbhKCu2kXNlDm3xtAySR9g>
    <xmx:9OQcaf-oZb9CJEwpeUVgC2UzEiEVa46AtGNmpVNbwcxjxLPAPhL2iA>
    <xmx:9OQcaTGFOs_yW2wtZgMdg1yH8PmAaPNgW4bd6gRwjs-QNcmKdLanXA>
    <xmx:9OQcaRb2293_BAylsgyCeKPl9DHCsDOd89Z52-VGg4N6pHXBmjvmVQOU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 16:28:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [PATCH v4 2/2] repo: add --all to git-repo-info
In-Reply-To: <DA3814BC-D6A5-4EF1-9A2B-9687D1B6C26A@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 18 Nov 2025 17:16:09 -0300")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-3-lucasseikioshiro@gmail.com>
	<xmqqh5usiizp.fsf@gitster.g>
	<DA3814BC-D6A5-4EF1-9A2B-9687D1B6C26A@gmail.com>
Date: Tue, 18 Nov 2025 13:28:18 -0800
Message-ID: <xmqq8qg3do99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>>> + for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
>>> 
>> I am not sure if "unsigned long i" is the type you want here.  I do
>> not mind, and actually I prefer, a simple platform natural "int i"
>> for something simple like this [*], but I know other people prefer to
>> use "size_t" to work with ARRAY_SIZE() these days.
>
> Yeah, I also thought it an unsigned long feels out of place, but I
> was only following ARRAY_SIZE. Actually, I was trying to avoid a
> warning. In this case we have very few `repo_info_field`s and any
> int type would work here...
>
> I'll replace it by size_t, then.
>
>>    Side note: The reason they insist using size_t here is that
>>        "-Wsign-compare" makes the compiler complain.  But I would
>>        say that it only shows what a misguided feature
>>        -Wsign-compare warning is, especially given that the
>>        compiler perfectly well knows how big repo_info_fields[]
>>        array is and the iteration cannot do any harm if done with a
>>        signed integer smaller than size_t
>
> Perhaps if ARRAY_SIZE(repo_info_fields) is bigger than the maximum
> limit of the integer type, which would overflow and this for would
> loop forever. But, obviously this wouldn't happen here.

Yes.  We can tell, and a compiler should be able to figure out, that
inside the loop nothing other than increment by one per iteration is
done to "i", and the ARRAY_SIZE(repo_info_fields) is a compile-time
constant that comfortably fits in platform natural "int", so we
know, and a compiler should know, that there is nothing to complain
about if "int i" is used there.

But the quality of implementation of -Wsign-compare may not be good
enough to figure it out.

As ARRAY_SIZE() essentially is a size_t divided by another size_t,
use of size_t is the safest solution that does not require any
braincycle to pick.

>> Again, this would work for now, but maybe "git repo info --keys"
>> that emits these would be easier to manage.  This can be left to
>> #leftoverbits of course.
>
> I can't see a use for it other than these tests. What about writing
> a helper inside t/helpers for that?

If you use "git repo info" only occasionally, wouldn't "git repo
info --keys", if supported, be a useful way to get a more focused
help than "git repo --help" where you have to scan the entire
document and try to find the list of keys that are supported from
there?
