Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD162D5C74
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724355; cv=none; b=BIpI3gkP/tnb1RXYmmCTZOnE2FQ6vEIUU8h/tSunW0Mm4CZr/t+ZGP/dYcnVgpqyU6INeQYXHIeug9m630V39xUjokVEVBqKDXykUuLNggL9DXe6cJgsrDDBU3z+AKOJQ96i8F5ggov7Wb/fPMb+JIKkV9eILWetGWeoy1d/M7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724355; c=relaxed/simple;
	bh=Lx/Fy8UMysvK/+YfnjsHVn7j/GWW71gFCDurHL+G5V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhXaQYjM6pR6OVKzJHTRFdlBRgMsnQBk1ZdCE2SF+QdkFpvhijPrM40P69ndFOyTDQDhXHB6B7/EwuVR6tZHUC0bkYUH86TvySEbaQnhX7mUFnYFMcrBbtdiiV+nIq0zZv32PdsG6VYjviZfnkHJBN0v27oG9y/JqcbjQA1Ge2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E4JBT4qH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2dzwfJq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E4JBT4qH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2dzwfJq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 264D11D0011E;
	Wed, 20 Aug 2025 17:12:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 20 Aug 2025 17:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755724353;
	 x=1755810753; bh=NyC8gLkJmvgO9E0mQsax+v8TvkDT9X6p0NGWb32Dj58=; b=
	E4JBT4qH5NIhJv8nGLOr67qMDJtPvDHhYpObazPHxhFI2YdQi6Xtoq95DIvsK3bL
	ld6/aijuG2qD9BgaMU4jaghqlLZAIe4tXJJSdXELA4sCdTosoG5ScjXiTCyLsd/S
	0KIdEliOpiySWOqJUN3qXzSwBX5vkj6v/RYn7KnINDHFgW8leT2AbW/pMyNfj9q+
	IIVv0mgIkUOKznhGTfwIXtKPRWF8M3wnN8G6znHy8NzK3u8ohsAkephZs2jtWuI+
	zgWQecB0qS9PzPVFVnhuuuOsZk67EXoSJQCeDtShdJpM6HmgLM+IgTDFGLuAvkbf
	mnyCCKX+cdBN27h+Xxs57g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755724353; x=
	1755810753; bh=NyC8gLkJmvgO9E0mQsax+v8TvkDT9X6p0NGWb32Dj58=; b=K
	2dzwfJqoSDiiK71pFLqDDt9Axd2oCEUl+a9sTahVf9HBQ3YKqB1CX5/W/XINVgFT
	qfnpIy9+AI2I51340k6J/1+tHDAkheqPH4nH1XfAtD/Z/GbjNK7r19Ho1ZvXV6DL
	F+AF/v1luHCmIgN0mNnzq2IuocCRm8cvC27GV797QLD2WWjK57eYTGZ5WulE5xAe
	5T6z8IAn7lgljeLvlx7/gDZVb+9bExmSSCojGxEosrBooILNCFkWkizG3hcrxEL8
	wrovXOtPscCfb7Hqlfa2EWxmb06z1UbLyDuJwborX6NJAfYOKAjL5Oxdyr9uNmdF
	NaFZ34tfot7tfo9ktGxvA==
X-ME-Sender: <xms:QDqmaMlEz1qn9W5KBO-zVsJ3PWqSBhUy4ucICzIfm7DkppcYxceuNg>
    <xme:QDqmaGbtQgdGh5Uz1joCWrN8wfPFu2MGs5s8BbegKTPWeCv8SH8j-7mCQah4LO6UD
    GjQiZCuF61QlCYAUA>
X-ME-Received: <xmr:QDqmaHPG8F_jfaPf8fAI3aQcVrV0vUHZr1iIdxfUrcCoViDvlKiGx0CU_fCLMcdE3OSPwjoWvijSARQgLgfSXydyRmsCUa2UoRUhQ28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghpphgriiiiohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhei
    theskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QDqmaLYGFYU4BXXTkjmoDPoMTpy4eh3miRkfxRpWxiCyheQ4zAAsZw>
    <xmx:QDqmaF2tWeBQGzauC-h_AVbMeEtiF4kj27mMQhwbEUCkxkD6Yfl_8Q>
    <xmx:QDqmaBdylxfpWEb2WfAOtV-dN5PquEsiT6ONTwp9WLmYed2qTpkTtg>
    <xmx:QDqmaGEkXVaZg4AJ2tsd14PnTxlQl9DjF4MfhDCmlCzfvePLJsewIg>
    <xmx:QDqmaN2IfmKtZsTAu9GRbd0eXCeFNFOj9-5USjEEhbeefhSe5T1jflqb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 17:12:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
In-Reply-To: <CANoM8SVTROfaQpRNBfwxU9opjXFPLzxN1W-xXTrA2bhx9KJ0LQ@mail.gmail.com>
	(Mike Rappazzo's message of "Wed, 20 Aug 2025 17:02:47 -0400")
References: <20250820195229.45943-1-rappazzo@gmail.com>
	<xmqq349laeyb.fsf@gitster.g>
	<CANoM8SVTROfaQpRNBfwxU9opjXFPLzxN1W-xXTrA2bhx9KJ0LQ@mail.gmail.com>
Date: Wed, 20 Aug 2025 14:12:31 -0700
Message-ID: <xmqqldnd8zpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mike Rappazzo <rappazzo@gmail.com> writes:

> On Wed, Aug 20, 2025 at 4:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Michael Rappazzo <rappazzo@gmail.com> writes:
>>
>> > +#### Creating and Sending Patches
>> > +After committing your changes:
>> > +```bash
>> > +git format-patch -1 --subject-prefix="PATCH gitk"
>> > +git send-email --to=git@vger.kernel.org --cc=j6t@kdbg.org *.patch
>> > +```
>>
>> Just being curious, but does the project strongly discourage a
>> multi-patch topic?
>
> I don't believe so.  I think most people know how to submit a github
> PR, but J6t has mentioned that he prefers the mailing list (as noted
> in the readme).  So I wrote a simple example to show that patching by
> email doesn't have to be scary.

As the original assumes that you are on the branch where you are
taking the patch(es) from, perhaps

    $ git format-patch --subject-prefix='PATCH gitk' @{u}..

would work?  I was mostly reacting to the "-1" on the command line.

>> It would be really nice if you add "review them here before you run
>> send-email" step between these two commands ;-).
>
> I can revise.  I will wait for more comments before sending a v2.

Thanks.
