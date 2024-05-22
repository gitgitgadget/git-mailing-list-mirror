Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5698146A8F
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413279; cv=none; b=MFZFjB4V0oY0EcDQgCANCG6Arv44huMiVUN8vv2O4+9aZlUwKTLjW469kPh41JqN3JWfCXPhtV1jpMEuRCo7qsopWLBrGyQuliPgIyYiUyfrSe5jCJSXZ3eWDinFnC9WXTlcekQ63pmIKyRQ3fWdzIyugxjpd9yv+yy/+Kgb/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413279; c=relaxed/simple;
	bh=zLSzqB7VJ9wLjIy1xlIHkr4ahXelgcrBv3zsACTigYY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IjleD65cc2Fi7/x6Qt1cRCRYGeOrIUkErEUw4O1dNDDD4ExswLq8/jafEhvNVljUelQROmuKko+PWOWLxQSZvQ9BW3hsxcM/EAyZVt86Bcv6iI7+e/eU6DnwhWB9LaDoEdDZ9FJn1Joiq29N9WukTZC/nwIW3A6HqVmbKZFM2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fkPPV4ui; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fkPPV4ui"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716413276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6TZ2+JZBpllfrwE8o4JXeNUducB+sdobygGCE+m5Vs=;
	b=fkPPV4uiqhb+6GM0w/C7LHi50j4JHuPxZe7ROBlBOSDtDsGANtEcQob3e6gAHOa3ZMkaeq
	L/ufjyjlBClnXKnahUspEdDmilyLzh1LO0RZFL9AA7eYdcnmxdwHez7IzoAJonZCkOQRXC
	IZGih73jn/QsglFtjsA6vBY7lWiJ1R0j7H98SE+LmN8mr6vrr2ogwNsQNTox5+lD5UCPC7
	sUD4sxtbdakni+o6FARu4V4xExg8uoRjwNP5IeW6703doc03ITdRpBxHJuI7K/tdG3OAtT
	PVSwPD3cojaV8Zz1ZPdcQSK1NQFYN1vFY076H1ulBW/K7jqikMjryk39Y4tgsg==
Date: Wed, 22 May 2024 23:27:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] add-patch: render hunks through the pager
In-Reply-To: <ff8efadb-4c1a-43ce-9b12-7688d6062c18@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <310a2904-681a-4bee-96b9-90a2dc107975@gmail.com>
 <1accd0163c96811b7b7f146e477acf89@manjaro.org>
 <ff8efadb-4c1a-43ce-9b12-7688d6062c18@gmail.com>
Message-ID: <424c7de34b5a42680a07e7f362a47f89@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 23:23, Rubén Justo wrote:
> On Wed, May 22, 2024 at 10:09:25AM +0200, Dragan Simic wrote:
> 
>> > @@ -1387,7 +1388,7 @@ N_("j - leave this hunk undecided, see next
>> > undecided hunk\n"
>> >     "/ - search for a hunk matching the given regex\n"
>> >     "s - split the current hunk into smaller hunks\n"
>> >     "e - manually edit the current hunk\n"
>> > -   "p - print the current hunk\n"
>> > +   "p - print the current hunk, 'P' to use the pager\n"
>> 
>> I think it would be better to move the description of "P" into
>> a separate line after the "p" line, perhaps like this:
>> 
>>   "P - use the pager to print the current hunk\n"
>> 
>> I know, we'd sacrifice one line of the valuable vertical space
>> this way, but I find it more consistent and much harder to miss
>> the new "P" option.
> 
> Making 'P' a /version/ of 'p' allows us to skip adding 'P' to the list
> of available options:
> 
>     (1/1) Stage this hunk [y,n,q,a,d,j,J,k,K,g,/,s,e,p,P,?]
> 
> This is what I though and this long list is what worries me.

Oh, I wouldn't be worried too much about the length of the list of
the options.  It's feature-rich, so the list has to be a bit long. :)

> But I see your point.  I am not opposed to adding a new line.

Thanks.
