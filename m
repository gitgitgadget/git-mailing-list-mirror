Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94F325700
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869322; cv=none; b=UV2fz3yaE8DUuDY8upCvcpU28dm4gh+bq3Ixet0T220vnHoPOfrbjDnFX2BGHonTIdmqcx0YZ/MB5UW6WUMwRUCXqvCz6lojuVmx5W6pfmhDp97vZOZY0oQezMcabnWF6FTlHBz+AzKAwJukE2Su99hgZDnooW1TccFDTxIeo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869322; c=relaxed/simple;
	bh=Qmv6OYHtHkac271dXXYj/7aRzlGS2LF3pDtjOqpxpuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS1/TiRg13fbrzIRUVhsRE0XLLUCFbEFJg+YyoJPBGhta751hU3dttF2Y5pY7ihvIu+E7Ym3zeKO4gFXOqXVhdnjcYLybK5stznpaLJbOU3E4OECDWiCJf+9tQ+4Yk4xwVTWg/ZuXG2KI1xwm0DlL2c2muqh4AAICYUWUVeZzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dVp995thJzRpKg;
	Tue, 16 Dec 2025 08:15:09 +0100 (CET)
Message-ID: <706588fa-97f7-40b1-86c9-8e5c944c173a@kdbg.org>
Date: Tue, 16 Dec 2025 08:15:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Would it make sense to add a commit.signOff config?
Content-Language: en-US
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
 <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local> <xmqqsedc8w7k.fsf@gitster.g>
 <aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net> <xmqqldj48pyl.fsf@gitster.g>
 <CABPp-BGCwjTBEi4wkg=065QofiO9ZL+9XVCCcTiHriXqgH1Szw@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CABPp-BGCwjTBEi4wkg=065QofiO9ZL+9XVCCcTiHriXqgH1Szw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.12.25 um 01:17 schrieb Elijah Newren:
> On Sun, Dec 14, 2025 at 6:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> --- c/Documentation/gitfaq.adoc
>> +++ w/Documentation/gitfaq.adoc
>> @@ -83,6 +83,21 @@ Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
>>  which quotes the filename with spaces and specifies the `--nofork` option to
>>  avoid backgrounding the process.
>>
>> +[[sign-off]]
>> +Why not have `commit.signoff` and other configuration variables?::
>> +       As it makes it harder to argue against one who tells the court
>> +       "the log message of the commit ends with a Signed-off-by
>> +       trailer by person X, but it is very plausible that it was done
>> +       by inertia without person X really intending to certify what
>> +       DCO says, hence the Signed-off-by trailer is meaningless", if
>> +       we add more publicized ways to add sign-off automatically, Git
>> +       does not (and will not) have a configuration variable to
>> +       enable the `--signoff` command line option it by default.
> 
> This feels kind of hard to parse for me.  Maybe it's just the lack of
> sentence breaks, particularly near the end.  Let me take a stab at an
> alternative:
> 
> Git intentionally does not (and will not) provide a configuration variable,
> such as `commit.signoff`, to automatically add `--signoff` by default.
> The reason is to protect the legal and intentional significance of a sign-off.
> If there were more automated and widely publicized ways for sign-offs to be
> appended, it would become easier for someone to argue later that a
> "Signed-off-by" trailer was just added out of habit or by automation,
> without the committer's full awareness or intent to certify their agreement
> with the Developer Certificate of Origin (DCO) or a similar statement.
> This would weaken the sign-off’s value and could undermine its credibility
> in legal or contractual situations. To uphold the integrity of a sign-off,
> Git only adds it when explicitly requested, rather than through automatic
> configuration settings.
> 
> Maybe the last sentence or two are a bit redundant and could be
> stricken.  Anyway, thoughts?

This is much easier to read. I'd shorten the last two sentences to

This could undermine the sign-off’s credibility in legal or contractual
situations.

-- Hannes

