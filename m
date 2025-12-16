Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E93347C6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871527; cv=none; b=VusdYY6uoUVD948eRo0eeddm/oCKeRjS/vu6vex6lSc56kXHn49e73yOpADD05stEUc7CUbnpwSxwBJzz/s+Hixbewls+aanSQTBn7d7J+vZfmiR4VAbyw2f1iX1/Bi6NB5ns1c8fzGYaVnXmOL6021Z4LqP/nAWTRa0Pwrw5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871527; c=relaxed/simple;
	bh=jjTMJLZ1cPpm06ilo/HqjiZ2Z7yKfnihsU7E9sPKnYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq1vKhzw6LSUNcKKwh4KrONcIweIb6U3Aka/iPh9Xy9VMKlO613EFTXpDHz7Lj06gZsrXHwgdvPGT4u9jPyIv6L+qFqBO2k5nxiPPs4hLizZ4i/uo38dtrMy5JW50mws50qMSUmh3y62mxpPGBvxBOa+/Q9wKqmfNpJcqCyjCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dVp405nnSz7TLs9
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:10:40 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dVp3p6QqkzRpKY;
	Tue, 16 Dec 2025 08:10:30 +0100 (CET)
Message-ID: <be069975-8b0f-4915-8c50-0dcbf6efb142@kdbg.org>
Date: Tue, 16 Dec 2025 08:10:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Would it make sense to add a commit.signOff config?
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
 Elijah Newren <newren@gmail.com>
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
 <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local> <xmqqsedc8w7k.fsf@gitster.g>
 <aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net> <xmqqldj48pyl.fsf@gitster.g>
 <CABPp-BGCwjTBEi4wkg=065QofiO9ZL+9XVCCcTiHriXqgH1Szw@mail.gmail.com>
 <xmqqwm2n40sf.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqwm2n40sf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.12.25 um 03:29 schrieb Junio C Hamano:
> Elijah Newren <newren@gmail.com> writes:
> 
>>> diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-option.adoc
>>> index cddfb225d1..0b869dfbe4 100644
>>> --- c/Documentation/signoff-option.adoc
>>> +++ w/Documentation/signoff-option.adoc
>>> @@ -16,3 +16,15 @@ endif::git-commit[]
>>>  +
>>>  The `--no-signoff` option can be used to countermand an earlier `--signoff`
>>>  option on the command line.
>>> ++
>>> +As it makes it harder to argue against one who tells the court "the
>>> +log message of the commit ends with a Signed-off-by trailer by person
>>> +X, but it is very plausible that it was done by inertia without person
>>> +X really intending to certify what DCO says, hence the Signed-off-by
>>> +trailer is meaningless", if we add more publicized ways to add
>>> +sign-off automatically, Git does not (and will not) have a
>>> +configuration variable to enable the `--signoff` command line option
>>> +it by default.
>>> ++
>>> +There exists `format.signoff`, but that is a historical mistake, and
>>> +it is not an excuse to pile on more mistakes of the same kind on top.
>>
>> This feels like it's missing context (it'll take the reader a while to
>> figure out why the paragraphs are there and that the two are related),
> 
> Very true.  It may be sufficient to leave this part unmodified,
> keep the updates to gitfaq document, and do nothing else.
Please do leave a pointer here. People who want to automate --signoff do
not visit gitfaq, but will search in the command's manual page.

-- Hannes

