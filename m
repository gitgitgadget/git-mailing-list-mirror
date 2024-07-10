Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA63194A68
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627336; cv=none; b=GldXWfuxEFc3xUHAyTT3UCJO6QnEL1E+SLMa1SCHhyDfld2IK3iCnC0ZGY6ld3SW57DXkTZ3NHpCUa87MtfSON1+mAYbdtRTS7YAVvwohwAb7CMhGn7NznhswjD8ZPpxpLTxuvXjRrxbzfzO7ti9ML4I9NE4mCOk9z2d1UuLnjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627336; c=relaxed/simple;
	bh=a6wmlTCQHmCKcn8V9K4wFo+tYOJY85wkTd52Nd0VmXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fts83CMoz5l2u39OAhxBkG2bej5H0Rs69aXdMJNVGHrZm9gLs53U9QO6K8rVj3RXrt8pSiGYVK/wgqtiYRTz8K5cfDCGBUj9q4R+6FZj790FaXMudzyXVUZAfqMu1YYEfsiTtXivsLUilJ+iZUjSj9WK4DkSAveOXKipRJNd0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vu7R/4yC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vu7R/4yC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB26C1DD9B;
	Wed, 10 Jul 2024 12:02:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a6wmlTCQHmCKcn8V9K4wFo+tYOJY85wkTd52Nd
	0VmXE=; b=Vu7R/4yCOkuHhsUVja+KDTJ6+lhBp9mxqQ4MNoh5GJPvLKzqah8dkg
	z6pGl5tW5WDzmaYN5U2hU9i1obwR/sn0fUeOvQESHnaO8owTlw4jIhSrwEwIASR8
	5U2/FdLsp9r8279i6h63VHFoVAWNUE43yX5WprTCGeFxOs+/ZPyxA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B36D71DD9A;
	Wed, 10 Jul 2024 12:02:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DEC51DD99;
	Wed, 10 Jul 2024 12:02:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
In-Reply-To: <CAOLa=ZQdPTnLp63eFiq1oOkgukBGsug==Cam0hGW_9koCefhGA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 10 Jul 2024 07:06:25 -0700")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-9-karthik.188@gmail.com>
	<xmqqbk37hjma.fsf@gitster.g>
	<CAOLa=ZQdPTnLp63eFiq1oOkgukBGsug==Cam0hGW_9koCefhGA@mail.gmail.com>
Date: Wed, 10 Jul 2024 09:02:10 -0700
Message-ID: <xmqq8qy9z14t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C55E672E-3ED5-11EF-9D36-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Yeah, makes sense. I think I'll simply add in
>
>     if ! git rev-parse --quiet --verify "${baseCommit}"
>     then
>         echo "Invalid <BASE_COMMIT> '${baseCommit}'"
>         exit 1
>     fi

It would make the intent a lot clearer.  Good.

>>> +if test $? -ne 0
>>> +then
>>> +	echo -n $gitLogOutput
>>
>> What is "-n" doing here?  Why are you squashing run of spaces in the
>> $gitLogOutput variable into a space by not "quoting" inside a dq-pair?
>>
>
> I actually didn't know about this. Thanks for informing.
>
>>> +	exit 1
>>> +fi
>>
>> Looking for "--check" in
>>
>> 	$ git log --help
>>
>> tells me that the command exits with non-zero status if problems are
>> found, so wouldn't that mean the cases with problems always exit
>> early, bypassing the while loop with full of bash-ism that comes
>> after this block?
>>
>
> It should exist with a non-zero code, but since we're capturing it in
> the while loop, it doesn't stop the slow.

Sorry, but I am confused.  The control would not even reach a "while
loop", I am afraid.

I was commenting on the exit status check done here:

    +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
    +if test $? -ne 0
    +then
    +	echo -n $gitLogOutput
    +	exit 1
    +fi

Even though the output is captured in a variable, the exit status of
"git log --check" is still seen by the shell and "if test $? = 0"
next line say "ah, the thing exited with non-zero status so lets
echo the whole thing and exit with 1", before it gets to the while
loop we have below the above piece of code, no?


