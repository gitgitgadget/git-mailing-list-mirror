Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76B36654E
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773162; cv=none; b=kceKPdfxwRo4iDK99Pg9i1sxY0wC8WFy6BfXzYLONdPqVJ4nMhFD/SZwFvbb26NFwVfz9U1ytrhIJ+xCLWnCW/muhQB/V11RAocvLa1GSKyhysVWaFwM6KIGL7gEfyG/3VbS2l189ra51s9wlzVkMzN73dNS4V4LrHY3AFuxlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773162; c=relaxed/simple;
	bh=oMEgEmCOyKHiMKNuAfYMJo7ciW0tKgnYTwsOHS3BgC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=th2yfNgJsDrsA9tzr/QrE6feA+6TssGhnLETvOjjD095wGHTP6ogu9RvGRvwdz+jZgxTKjomrTQssoJEnq+xfwgC9WonwTdTwR8v2sHr59kAynNbkY57uxstcX1hJ7EJzq0IyJm1cRdem20qYnoAcvNR60Q3wYpHTaem6vDdQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eA8dzkwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wcRYCLVG; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eA8dzkwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wcRYCLVG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 846BD1D00111;
	Tue, 17 Mar 2026 14:46:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Mar 2026 14:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773773160; x=1773859560; bh=aA3+kN5Yrz
	M3wnAfMI9rHPm3zkb3LTQEx8FJbH11nHg=; b=eA8dzkwelDLGSBb3cFLlx5G+/z
	vpeH3EfBkyVQv1LC6k5OPi20HS4NRxL67o9jO/zzD0FJs6wBj/LqbqznRR/Wc/aU
	/rUkI+diZw/kAeXAnne5fS1ZVKQGhUW3Z+e679QcdGLHUr44D14cKAil/iQki2IK
	svf16k+zCH+ywvANurbJ/dUJPOYIWFkkfNg6cf4SAVw28egz98++N13q1huvPEtk
	gHzuzcUkD8nSUKzyDLmux+XaCbRZgBanscCu9NDW8YHFM0G7jlriWN3oWqtSUakh
	tfHu0FiehWjF/HSIo25OjJ6kNS2bXS9PQ47snPa9VgAI4l9x6vPyhErwKgKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773773160; x=1773859560; bh=aA3+kN5YrzM3wnAfMI9rHPm3zkb3LTQEx8F
	JbH11nHg=; b=wcRYCLVGqBVZ1M4HX0rYYY5GmgeL42q0h+LxjI8vOxAlDoUamdE
	5aAgaD6cSR/Dx+puTMHk6Beki7Xunw27kzjo3W4DOEl/WkWzTXxn5f1Mt57RWeRM
	Y991b85+HwJC22cL0K+RnbhGp1m3JAzvXl/Ci+ZuMqAOj/Bv2cFAZd6h1ruX9Yxe
	sI/8ik0V4n5dYB1V2XIYVs7zLD5v7uLhKw9AWJY2re8W6lOwEXvalANIGaUaPX4e
	wqn9jkRFnhM2f8H4j3X3rIm0nwsd8Z17uapp3JNQQFt+zEwIwTQ694r+D5F2WVJB
	+0AEB5GRq2OKBepdgmnwt1BJq50TbjMGnZg==
X-ME-Sender: <xms:aKG5ab6aSKtclB3U_fHG2jl6QzvAKL_CDAbG6WW25IHDMdxFDk6rhA>
    <xme:aKG5aYWO6kVUVd5nW4ycr6pNc28_AFQQtUT0tbWVXkrChTmyxgGYt_Z2XOWVxkVx6
    JdSRJ5giV2CqUJUPnRKJA_8CmVFzcMM3dZoxw-qK6Ou7XHFmxAqnw>
X-ME-Received: <xmr:aKG5af00BG4jthh0v6TRSHYNUo-RBMKttBDUDbQiY5hDZYVBqhGn5DemE05buo-q0kDlJI33b12af4UKq539J2C9rgoyXX4Ixg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aKG5aV1hbMeQRnf17acnlX5QlsFnus7pS3Kv1QhZFcDWFDwmY_rI4A>
    <xmx:aKG5aS9-vBoq_Jc4SDENL1FQxZEMkq-c8XlpmtHq7mHLGYr971e3DA>
    <xmx:aKG5aS11hduTJs4dytFV6wlqPN7BgTOUAmuzFo6lPMXrsrK7v3ff8g>
    <xmx:aKG5af9baNhEVyeOJgvT-d5kbjlz5v46ZGuuJfMbMHvLrKhKG-n1QQ>
    <xmx:aKG5aZgkuIHngw1ilXVbcHJYF_nOhDRqpgUZxh8zP_jDrGScw22M6FLf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 14:45:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
In-Reply-To: <CAPig+cTTgLVGPG99gsb19BeJVWS=VZCU4F-rjb25yHTAORWwzg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 17 Mar 2026 14:12:12 -0400")
References: <xmqqldfql4hp.fsf@gitster.g>
	<CAPig+cTTgLVGPG99gsb19BeJVWS=VZCU4F-rjb25yHTAORWwzg@mail.gmail.com>
Date: Tue, 17 Mar 2026 11:45:58 -0700
Message-ID: <xmqqcy12l2ft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       test_when_finished "rm -f sample*-i patch patch-new target" &&
>> +       (test_write_lines 1 2 3 "" 4 5 ) >sample-i &&
>> +       (test_write_lines 1 2 3 "" 0 5 ) >sample2-i &&
>
> Curious. Why are the `test_write_line` invocations wrapped in parentheses?
>
> Also, is the whitespace before the closing parenthesis intentional?
>
>>  test_expect_success 'incomplete context line (not an error)' '
>>         (test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
>>         (test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
>
> Perhaps the parentheses in the new test were copied from some existing
> test, such as this, which already used them for a legitimate reason?

Yes, the existing one was concatenating output from two commands run
in a row into a single redirection, so (grouping of the commands) in
parentheses were justifiable.

The new one does not have such a justification.  Thanks for
noticing.
