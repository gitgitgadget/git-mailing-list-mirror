Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54828134BD
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283506; cv=none; b=J6dnsml08xRbWd1z3shCJQCOey3vZWXTNTIo82VvLVLVW6s+nqpX5HSSlRvdkwWBJAShgjRk2Jb6UHmusklPrsPHeuJq2NRws34Fd05HyW2dd6oWfCmEGz16ZcF5f1N+Q/cGuYyPNHQyHNCuVEjNaNvPRNtNAyQr8N8T8O2i7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283506; c=relaxed/simple;
	bh=Ydb/XuxZuAjPPxcGQQl6YLKYT3RwJdF4cLlVstdqypM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edqI1//qo/ta78A9lFv+i0AlgUnAZERH8ZCD0w1JpphtvP6X8U/j+9DPbp7rUjjqpWBDAvPShZHzOeAdziFd6uSaiKlz2m3EM93mfi3wLKkMxw//pWuySdh8+HwHGnCDGPTRxTZJRDmSaEFRI1ARzcgdWJqGRrwbvcKBE1Ix3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qzjlx1CC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qzjlx1CC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20E8629FCB;
	Wed, 25 Sep 2024 12:58:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ydb/XuxZuAjP
	PxcGQQl6YLKYT3RwJdF4cLlVstdqypM=; b=Qzjlx1CCuueZxL23M4XQxu6LDDhe
	On5w5A238c/1b+bJznoHobzxXULULMUEuACAzLEiJh2CdtFzfOMXglUNbMTY6DPU
	ji0+EAUEWelkGVKyf3rzt4gATU7agDmVdH6iZLBPGFuALKdt3DvHbl284udsRVh6
	3DBvB7k+RkuaZn4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1879D29FCA;
	Wed, 25 Sep 2024 12:58:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4856629FC9;
	Wed, 25 Sep 2024 12:58:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jan Wendland <jwend1703@gmail.com>,  git@vger.kernel.org
Subject: Re: git diff --exit-code misbehaving in 2.46.x
In-Reply-To: <e3da5c9b-c208-4937-a2b4-e1028f3e6841@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 25 Sep 2024 17:26:59 +0200")
References: <CAB0mhhz9LHZ1AWSu_0oM=c89+z0w=XemnQwFAm45wp8zSmQ1Sw@mail.gmail.com>
	<e3da5c9b-c208-4937-a2b4-e1028f3e6841@web.de>
Date: Wed, 25 Sep 2024 09:58:21 -0700
Message-ID: <xmqqbk0bpt5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5FEB2244-7B5F-11EF-BD1A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 25.09.24 um 16:27 schrieb Jan Wendland:
>>
>> git diff --exit-code in 2.46.x is unexpectedly returning a zero exit
>> code for files marked as binary in .gitattributes where 2.45.x would
>> correctly produce a non-zero exit code.
>> ...
> Thanks for the report!  This is a known bug.  The "next" branch contain=
s
> a fix, 9a41735af6 (diff: report modified binary files as changes in
> builtin_diff(), 2024-09-21).

I just noticed something curious.

9a41735a (diff: report modified binary files as changes in
builtin_diff(), 2024-09-21) explains that since 1aaf69e6 (diff:
shortcut for diff'ing two binary SHA-1 objects, 2014-08-16) added
binary comparison, the code path always used a quick hash-only
comparison.  But the above report claims it is a behaviour change
between 2.45 and 2.46.

It does seem to say things are different with 2.45 when binary
changes were checked with --quiet/--exit-code from my manual
testing, though.

Thanks.
