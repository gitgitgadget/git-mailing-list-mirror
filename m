Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F11BE226
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935507; cv=none; b=c7FxUfTKwwmmlLahMoquP+6lKa1Ue/pZepuh2sgqqQopbj4LYaIAYJsgZmokwLjin5VH2FQ2dBgHCrWqKe1BbEmhKPU1RDD14s/2k2CzEVByjOnpERq3C4gjSc67AhSxDgNqp2SjGJnl1KoGDFAeq1rTb0MkAB5MmHzl7uhGpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935507; c=relaxed/simple;
	bh=daF3a6H1HJat5TzbuSqRjWToIZZxUqnQ7ZjBDv7InfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sE1Lz/FuPyXdomabRKqsMEdTc1g/mRRr8eo446Bl3YLDnX1ANjGTVZMzmqmf1tVRRyxNvbDQX3ln94Z98MORQOKuel5C4qeLFjaQZ73tYfjLUHrFEVofKC5W1N5Zz9QZMjKhF81qnbZgi3x5K/FQSbWCMUy6wARa3g00a4VO6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MajzWKwk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MajzWKwk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D9D5D253DC;
	Tue,  2 Jul 2024 11:51:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=daF3a6H1HJat5TzbuSqRjWToIZZxUqnQ7ZjBDv
	7InfY=; b=MajzWKwkddFVtQOsAw+W3r0/9RPnWk5oXD08JeQqqv78fIRa89a1la
	2K8Io+4Ea9MhaJCHhHSpJ1bPIb2/bYK/JNApvr0gfcltOtFnxYMGPoPFDkTWZi+z
	CsIL7jWxErUZn1Y0By93P5PnzT0oQzwslJE9fq2+cYdKMc2TZ+otE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D1BF9253DB;
	Tue,  2 Jul 2024 11:51:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69B2E253D9;
	Tue,  2 Jul 2024 11:51:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
In-Reply-To: <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com> (phillip's
	message of "Tue, 2 Jul 2024 16:13:58 +0100")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
	<51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
Date: Tue, 02 Jul 2024 08:51:35 -0700
Message-ID: <xmqqle2jssfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F72044A4-388A-11EF-950D-C38742FD603B-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

>> No public method is provided for ending a test explicitly, yet; let's
>> see if we'll ever need one.
>
> This means that we do not error out if there are accidentally nested
> tests. That probably does not matter too much.

Isn't it more like it is impossible to create nested tests, since a
"begin" implicitly ends the current one before starting the new one?

>> @@ -156,6 +163,7 @@ extern union test__tmp test__tmp[2];
>>   int test__run_begin(void);
>>   __attribute__((format (printf, 3, 4)))
>>   int test__run_end(int, const char *, const char *, ...);
>
> We should add
>
>     __attribute__((format (printf, 2, 3), warn_unused_result))
>
> here to catch any errors in the format string / arguments and to warn
> if TEST_RUN() isn't wrapped in an if() statement.

Nice.  Especially the "unused" check is valuable.

Thanks.

