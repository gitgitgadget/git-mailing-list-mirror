Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43E150992
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686465; cv=none; b=Q4be6mu1BTj+gE9t2XrY8cRFXrWqDSlWItbvzdNucCZ/QTbBjoBHCHSmSHvPe/nYgbz/xLeaGOP1BICLxhpGJxtNTg358Keq3lHkPksIF98DgYVQykCd+EZNZ0/bT/gK+tkuUijPn1b3tdZOFF9jFsjMPTq3gIDqWRYdAAfAqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686465; c=relaxed/simple;
	bh=JqF2jGlN/XNLaD3sH56cxrTiPDb9p406BCxNGxzNO2k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOfnIJjXD/Q+oqO9H1Ck0KbI9JCtnCdulnEi0MDKjj97J1tRke6sA/1YJpLlJuRDSAlzhl7oh8h2RFy2HIv4R2b/hCEiQGmwjp6jb4t/IXnnf+k+TNKzO00hj0tDvZkWy6nZCKMWG98LNYOSWycv6EqEoC+qMUKlXiRpco+reBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noMOZFDj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noMOZFDj"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25d6dd59170so324985fac.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686463; x=1721291263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvp9c6qHjArmuVg4mxdmTzJ+GndaFkFKtvjk08v/Rl4=;
        b=noMOZFDjqyUB9g9DHBCYPBxxnhC8famXJe4VUOBMpehntZrZRv3FjJkBrJFCPKrNi9
         8IaMbiErbFzZIU9IrwIrdy0h06fhJsAFTVPXANhqeJM43luS3uvL2p5qbZBBl+amL1jg
         JOxVia33PeDfFFaIvMZfd8t2bkW+9cNCdY3QszTwKHy959IpaFheSIk1QeMfGl1cJJm6
         aVBBV3S6txjyLYUzXyTLGFxBvfyEmxYmbqZiyszcE+7RApHIwOzpkp73O45TXfPoYkFx
         HXBE0YbrC7eUuL8XS/PEpHX6EGbrhB2rPWX9iUMf/kqywTRiNdZ0x5xTpakUacrh6RwT
         6t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686463; x=1721291263;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvp9c6qHjArmuVg4mxdmTzJ+GndaFkFKtvjk08v/Rl4=;
        b=mfdrD9hM1SSBFFVk08yV4yJd8SYo1JU2Gkz5GezQQsoQjS6vnTre0tWPhpD2u1itYK
         UdQVoxsh9b/tM/4q1QpqlKvCl2GPYe4rjStcRcV28RHADllY+oTPHbV0mHVqAj+2IykK
         GdgHLFPr/U4qVBbSJ3/s1yftJVEwjJpHTJQ1KuRfG1sjIY9gw/Fbk2OH7Va/+/NS6duj
         7K9tvl1zU9tORhFiV38A7+cGnXCclJe/seXv76t6wM9cbrJI9CKg/DYVut/5Xc6wIq9O
         CLkJTWElohcdp7ZlbJY6Rsf18PvrmUP/p5/hpniOR4g5C62pE9u7e/CXP2676OvwyTnb
         cDXg==
X-Gm-Message-State: AOJu0YypCY+F2ye2nG8RU1m0SIIc/dqWLKH+8xBVEsOhc7OpwQDb3Oo4
	3f0vM05Hb8nACznpY5l0ek2tTsdmxVKrcZ8P2UKBJ/2RPeyMjQGOi3SCwS11jpGUvfpbiwb8jZT
	j7o3udSlO9PaPntFYDWcInGJUVAU=
X-Google-Smtp-Source: AGHT+IGLWDV8Mc4AWc1B0QdNWfkn2KG8E9pGqdA1GZd6NMJ67mvhP0Pqls4PERVu2JpjKn+E7vC/zS38E/NQP2EVbfA=
X-Received: by 2002:a05:6870:7009:b0:25e:1cde:f5c6 with SMTP id
 586e51a60fabf-25eaec6dc95mr6187236fac.53.1720686462361; Thu, 11 Jul 2024
 01:27:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jul 2024 01:27:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qy9z14t.fsf@gitster.g>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com> <xmqqbk37hjma.fsf@gitster.g>
 <CAOLa=ZQdPTnLp63eFiq1oOkgukBGsug==Cam0hGW_9koCefhGA@mail.gmail.com> <xmqq8qy9z14t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jul 2024 01:27:41 -0700
Message-ID: <CAOLa=ZSUZGqxHbEtpR3fadOFf=YPVxbo8W7SwyB9j5am14EB7A@mail.gmail.com>
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000005c021e061cf489d1"

--0000000000005c021e061cf489d1
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Yeah, makes sense. I think I'll simply add in
>>
>>     if ! git rev-parse --quiet --verify "${baseCommit}"
>>     then
>>         echo "Invalid <BASE_COMMIT> '${baseCommit}'"
>>         exit 1
>>     fi
>
> It would make the intent a lot clearer.  Good.
>
>>>> +if test $? -ne 0
>>>> +then
>>>> +	echo -n $gitLogOutput
>>>
>>> What is "-n" doing here?  Why are you squashing run of spaces in the
>>> $gitLogOutput variable into a space by not "quoting" inside a dq-pair?
>>>
>>
>> I actually didn't know about this. Thanks for informing.
>>
>>>> +	exit 1
>>>> +fi
>>>
>>> Looking for "--check" in
>>>
>>> 	$ git log --help
>>>
>>> tells me that the command exits with non-zero status if problems are
>>> found, so wouldn't that mean the cases with problems always exit
>>> early, bypassing the while loop with full of bash-ism that comes
>>> after this block?
>>>
>>
>> It should exist with a non-zero code, but since we're capturing it in
>> the while loop, it doesn't stop the slow.
>
> Sorry, but I am confused.  The control would not even reach a "while
> loop", I am afraid.
>
> I was commenting on the exit status check done here:
>
>     +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
>     +if test $? -ne 0
>     +then
>     +	echo -n $gitLogOutput
>     +	exit 1
>     +fi
>
> Even though the output is captured in a variable, the exit status of
> "git log --check" is still seen by the shell and "if test $? = 0"
> next line say "ah, the thing exited with non-zero status so lets
> echo the whole thing and exit with 1", before it gets to the while
> loop we have below the above piece of code, no?

My bad, I thought you were referring to the code before my changes. Yes,
here you're right, we don't need the check since the shell would capture
the non-zero status.

--0000000000005c021e061cf489d1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3a6f359bf2ac28e4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hUGwzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnNyQy80aEp4azVjdzJ0RUJXTTNEY1lTR2hqdTdhawpwaEprb0Y4T3Av
RWJjVHE3aVU5NytmVVg0TC9YSmNub1BZelFoMFp4UTNDcEwyZGlxTUlzeldtZ3ZyWG9KQXZFClY4
SVFSTzNPUmtna1JDNmp0TDVwcys2RCtYZXg1VUhrenMzYVc4L2F4bW4xN0NsYUdRS1FRbFNNa0Z4
ZGJ4NmMKV2tHNytjUDlROFlvK243dXhNenIremo5Q3JPNzNUOHdUTCtmZXFPWTJRenlRVVBwNDJm
SDZRcndleE5JMVdyUwpSb3JUdS9La2djRzhTcUplVFowc0dmRXZjejREWlVlcUl2MmhZUXJPQ1VI
RjlvY2xxVlowQXlkYklYSzRLRXJlCnlta0ZqM1ltMFQwY3BEK2VoODg3NFZ6ZnhRVWRBam5wQm9C
elNHN2lsY0RPZ3ZYRkNjc3lPcFRJUG4vSVhqM0sKb21SdnR5UWorUldleVJIVndtQkc4ZzVnTkZM
UGUyMUNyZHB5TDhnSVZTL3owdUM4aWhkb25NR2RmQ1dWVC9KWgpaRTlQVmdtc1V1bE9mZVRBeXRv
KytPNGorZTFZTlExaE53UW5lZDlrTFNINkszTlB2VHlnVjY4eGYvc3gzU0psCmZsNGJwcEY0RW5O
MzlaWm9QMTNZNThuM1QzZVpTRE5KdkpyV09Xdz0KPXFMRlUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005c021e061cf489d1--
