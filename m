Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F82765ED
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135156; cv=none; b=taBAuFYcBa241co4JV1+268b02bo/RfH6vNTf2dOYSG0srK0lCMLRBMMaO58bo45kVGz8q6wv8vBlXgaEwMJWkyhUI56qqzkjhIpcVoCmfNGFJLc2efzDqoa+OX8rTPDF+fSBeEkX8WoUas6e/nSsq11AErRX2NXzMK/CDWHSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135156; c=relaxed/simple;
	bh=xqcdBff1Cl3L4uO/rz0hrYKnig/pAyYwRI6O7W6PxVM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBS/CxXD8txZSJx1fTRWI177ixBpKw4+M7krr+9rVbzCO5erRaHC4ucKdmj116/0q0+z6QsaDrZaIc3o2jBchVpkvnnybfMW2yaxgsZO7eEttdeY36bCuQZGPMJEMYgT5c6vXnBZMxLKV5rsqrnW3BYekyglkFNmFLZZFfu19HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDwBUwbt; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDwBUwbt"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-554e726e5cfso2260013e0c.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761135153; x=1761739953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlmZnb0+z6kc2CZrvy/8fW3oB5UmenIPCmDqRTUtgpg=;
        b=EDwBUwbtMlwIyy3OnWfHDy/mcpm5jshBINqzzZQ+xgThmsMGZIQgDxr9uMzXqt34xB
         6hQZ5rL8gxmr7I0Fn0zyql3DbZKeMh0i8emCNznMbrgZBhQ/B+zkXjGqWYrQ5C/Fa6vK
         uUUTgNHjNZuI9dyvFZAC3EK2pR6spUd0yCCeVxz8c533eb5oSHy7jKo5FLB2N4VVIbWj
         j0IOEPM5F7+4lUGEbTz9Vug5sGciJr2sWLE6sMuueYhPUBb6yzOXt+QSRVzrZFrWxdjC
         aJP4UniACGlEr4wHJUQ+C9xnyF9NN2vt1LehsYpukFNdEH1mYVr/TGZbUlcZ+Vjeg9+v
         Y7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761135153; x=1761739953;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlmZnb0+z6kc2CZrvy/8fW3oB5UmenIPCmDqRTUtgpg=;
        b=oXttK12AvcChKpOPGFBQlVqIGz3ItBxJqhre2Ll70kLMmz6xiMDWGrdgFT7QOCaKRa
         1QEVvx1xqLLxxCK3IVWsqtOV43dReKI8eSkJhTzK/VP+EJsSdyopXNaAjLvL+CLV3wxx
         /oVKdbuubq7tcBpwNiYVv7HTNia4Wt8ad2Urz0os76q5utJkW4yRBd29TAimGri4XY+w
         8tTiFPpM64FhMIrXDj1mSn0Js7dbn66ixR9UecKehWZW26M5dl9+pNVjrqgnBb4U70yT
         ka7rKA/W1TQ9rCih4tLKllYn/MtnPU7d1PbJBwXLUNyDY8uVwQ0Wdv/fbCWi511fWkjI
         SuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhhy6LMv+rnWLXz1JDEXl+sSXghrjSmwvT2JEViRpf01deVkqgKBzNYvoeo2lKTdxpxkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pmfFpx3bK0CT+zdMAJ/UHe7k56aKMyG87iQIuVzmrRzWt4ec
	1O5b8PytKATsGKx+Xw9wszjOnbck+h7e4i22HawTUg9MwaOdfZvIcRkcyU+Tz1jVN5lCBgEY0TR
	9oc8XFGMu/G1lOUf6zyxx+SiWg/0MuAI=
X-Gm-Gg: ASbGncsx8y48oQpYnGyS9uOAckmZH3kGrqzm5ovpI6/g6PWZZHT+sAP3qOSpk7UGtAR
	Iwj7Fo7YtGxNnRYThmXjTXs4qP1nJsYVsxTeStVRJG5vTTavtbflqzMD/jOblhoK6O9NfNtCE1v
	5z2cRe2DijDAsdvAhi1NIUiqjtY6NWNlEcqJ8lSSImbbtji0lZN9Lm7NknCuFObtMJSaIxF7wiR
	dfw3T9tsTUeD1oidjPdIPElB6XfXu2EpxdyqEMcV2drL6QiIJO8ha9+dmPIwQ==
X-Google-Smtp-Source: AGHT+IHeJgWbNjAEz77zk0AVWBpUb29Qxx/2Absdq6FSt2AbKRKhnKLl0ScNiTyef/iXjScwrasNg92ZJspM/xndbUQ=
X-Received: by 2002:a05:6122:8c14:b0:54a:2600:bf86 with SMTP id
 71dfb90a1353d-5564ede13bfmr5213325e0c.7.1761135153460; Wed, 22 Oct 2025
 05:12:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Oct 2025 05:12:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Oct 2025 05:12:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldl31uhq.fsf@gitster.g>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
 <CAOLa=ZQSc0jHv9gK5T06GA_mprknucwCj5H_M2djZ-UWfRMbJQ@mail.gmail.com> <xmqqldl31uhq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Oct 2025 05:12:32 -0700
X-Gm-Features: AS18NWD_MoO1vfGk-uXbRxWb0kfe-A8h_XgD-_TfvXGIP_8eulcqo7EpXisqEg4
Message-ID: <CAOLa=ZTHxw8uCbo=oHq=LF=qX=sufnWKJTC6F2YLsrZ8EyxsYw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] builtin: add new "history" command
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000395f3e0641be3be2"

--000000000000395f3e0641be3be2
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> +	const char * const usage[] = {
>>> +		N_("git history [<options>]"),
>>> +		NULL,
>>> +	};
>>
>> Nit: We have pointer alignment set to 'Right' in our styling guide and
>> also mentioned in our 'Documentation/CodingGuidelines'
>>
>>    When declaring pointers, the star sides with the variable
>>    name, i.e. "char *string", not "char* string" or
>>    "char * string".  This makes it easier to understand code
>>    like "char *string, c;".
>
> But there is nothing specified for an asterisk that cannot side with
> variable name, like the one we see above.  I _think_ the "space on
> both sides" is the prevalent style, but I do not know (although I
> suspect you do---as the person with most changes in it) what (y)our
> clang format configuration wants to do.  Can you make sure the tool
> suggests the style that matches the prevailing style?
>
> Thanks.

I looked into this, and unfortunately it [1] doesn't support such
granularity.

So for something like `const char * const usage`, it only cares about
the alignment of the pointer with respect to the tokens surrounding it.

With our current setting of `PointerAlignment: Right`, this means it
would expect to have `const char *const usage` which is not the
prevalent style.

[1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#pointeralignment

--000000000000395f3e0641be3be2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 89b4ce9163705f1d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qNHlpNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL21sQy8wVDdBeXYyb0tpamh1RkkwMDRPRytEekduTApwWXhWd2hWckQ5
enlZdy8xaktMZHVrUW1Panllc2JTdWFrQlFiQTVBZ2dZRlZCcmN0QjlmV3BVdFJxMkpOYWk0Clh5
UC9sQ2FtNHc2N1lYZS9ZaVJoMjF4Wk55QlpvTEhDYzVSbktZSEZBQWVuZitONlphNVhQU3pDQ09O
SjgyTGsKbGZBdFdSUjZjdVBSYzNOUXRsaUxVdzdwVVQvYngvMk84Y2RSTStnS3U5eUJkejlyZUh5
UFlRZ0dMWWdqVVVIRQpnbXR4L0t3czNTU25LaFFtNUN1TU1zSDdsSXY5NXZocjJkVWtoWURzb3NY
aGY4NmRibUtqTVpWa0JZN1RaQmtTCjdHbFM3bTUrV1JVek0xZXVOYzE0eUxUcXJxeVhVVDV4TkEx
Rm1Tc0lrZTl1WHN6bWtMZFdHL1M3a0R4RjR0a2sKZjQrWGlQZkQ0YkloRHZseFQwa0tabnB5TnpX
NFg4YU1uUDZPNEFUc3BOd21rTGdPWU1SUUdUa3ROeUFteUdOSApyangrSXc3TkVzQzdnbmVaaHhv
SWdvVjJQbmtIbUE2UXJuWGxGQXY1TEV5U25uTlJxMG9LaHhCeXgwOC9mZlIwCm8rSGxSbnI5NVBK
NkxsTEtVbElyMDVHRUZucEpmUEpmbXRQd0NpMD0KPUhVUVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000395f3e0641be3be2--
