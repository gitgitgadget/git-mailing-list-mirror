Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B41AA7BA
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606138; cv=none; b=ifvvjTWkRegtlq+3FzcG0gHGsALnEVAMlaHJMQzEe9DHjW9hYxKH5qeaHq9l6AteTmKXXpbXsHnnMDh+qBpcAlDTha5Sp2iCat45CVVi8UUmwrcSDXkGfyw9KF8UPAbZXtp2Wda0dB6nanvJqdRuxK/gr4ipZ0rNF4bbwpzfDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606138; c=relaxed/simple;
	bh=eQFHLOhOgZiGj/9RAnGE13agLO1FqVaVrSbzoNsjLHo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyIo0NCK7wDikW0vqOLQaEJn2ACQDzzqN+OWTl+BytDaVz7y7oLZ0OWCwzNTcajU57qYU9MMRb6pb+yoGT7KNjpqYy6NzPN7XERys9q/W3YKSVeUqe7hirRgBD+NrO1T5PgXpYCfIV9AGGH0pZJ8N2k4cUG6JyfuTx8NmyVAmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca089z9V; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca089z9V"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so3244191241.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741606136; x=1742210936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5tDkrwEYq7nyoSujGCVJLJSYjBSuFLOTmeaY4+MrLc=;
        b=Ca089z9VYi84QWfXpDUzvyVtTCWV1Hw8PaVfcUMF5EePOu7LoC6MrZFxICELpa4ysD
         rKJER/fCgUltOb4lUvZ50LLVRj6EXhWhHNpFFzNn7dJhU4xX61XMenKKNr5eKbfJJ3l4
         DGuGRAktJ2gepcDvov9gYppFU6svNSqdqfrowvoGkDflshPs+aoLpDtIZEKPNNJ7bz5f
         2g+dgbFUocVAA4d9ABgcnJ/XOUHgLp21FNuCnCeymi1Gh7Kypo0KTjukAKBd52T8rLwK
         i1NRiAm2n2vUehvUBcg0Jqg4JdauBMSVVKOLORgXB0fEUK2Oh9Zgk9iE4wed+GPkAMLg
         tVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741606136; x=1742210936;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5tDkrwEYq7nyoSujGCVJLJSYjBSuFLOTmeaY4+MrLc=;
        b=grsluZOdq79wPQtdbgBhKFDcetRyyBO44LqDqVwjylgriBcyhThXvldq+rk3OfmlaL
         zRrikYufiR4z6SIaXymAzQTBvyoblA7nR9+MahkNcqcVU9ZbcUJSJ30bwep1ldCcnOxB
         HEnSqWcwGOZ3rkKugTSkCMbEZc46XQzpX8e6tz1R6YJUGDCOnLimnBf1OPcnRwyiOSSi
         UVWaQKE6dnDCsLa9i7fFQgEnS+61/rTMBjbmSOu7IiTmrkvZUHXoMtDdpAeGEjKX6PJY
         3dKy1wpqDypDa9/GdMXx+CrY6tZ8nGD8T1MuBl1XWhZQhfS3facV465w+PlVaMA7VK7D
         e5hg==
X-Gm-Message-State: AOJu0Yxv2i3dK+v15j/RDBF0jS4BjEl3/qLuEO3Q4Jj2iv7L/Ffomnz4
	EIbI/V1owJxYC74vD7pVjB8Ux026pDUykUT+BMvEI3+k1v7wb2ipJF0U0chN2i6c/G0lwxX15fO
	NqRQ7Ko3jGBf7KuHiCFZ1XHLBENG7Ceda
X-Gm-Gg: ASbGnctn8yXmcTvt2FnDU7Mae3D4RxxgVig3HyLQFlt/8ZCXFTs5pWU18Umhb0wubmM
	MD3SDA2KYJMlIy/ogkcKNvPlRG8yKREmgaNhH+QZxA2Ars41TpDglR8BpjoHEwloeKkcVLSUhzE
	IO3v59J1CbI8CgOvgIMNhXtGYCaZU=
X-Google-Smtp-Source: AGHT+IFvwAEvTx7hGPkeJ77LYgZHn54gnnR8j+WvA6rJ0sas641yVw/L252pX56TmQaP9NZdsL6eQ8JO7jcc0wLJdss=
X-Received: by 2002:a05:6102:41a8:b0:4bb:623:e1f7 with SMTP id
 ada2fe7eead31-4c30a67e6demr7101881137.16.1741606135759; Mon, 10 Mar 2025
 04:28:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 04:28:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjuccyz0.fsf@gitster.g>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
 <Z8rdg90kxmKHHbyh@pks.im> <xmqqbjuccyz0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 04:28:55 -0700
X-Gm-Features: AQ5f1JrhCG8FF4rL-gC1tqA0oxM_LyhlhnMNbY2_4DE6F6mzutqUXm80uEwprNE
Message-ID: <CAOLa=ZS=1mJFJrL=0wLYJ6exhHPyU4n_HxnV1PARfWT+WxcQSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000fac34062ffb4793"

--0000000000000fac34062ffb4793
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +The "drop" subcommand removes the reflog for the specified references.
>>> +In contrast, "expire" can be used to prune all entries from a reflog,
>>> +but the reflog itself will still exist for that reference. To fully
>>> +remove the reflog for specific references, use the "drop" subcommand.
>>
>> The last sentence feels like pointless duplication to me. We should
>> likely also point out how it is different from "delete". How about:
>>
>>     The "drop" subcommand completely removes the reflog for the
>>     specified references. This is in contrast to "expire" and "delete",
>>     both of which can be used to delete reflog entries, but not the
>>     reflog itself.
>>
>> It might also be useful to add a comment to "delete" to say that it
>> deletes entries, but not the reflog.
>
> Good.
>
>
>>> +#define BUILTIN_REFLOG_DROP_USAGE \
>>> +	N_("git reflog drop [--all | <refs>...]")
>>> +
>
> We need a matching change to Documentation/git-reflog.adoc file,
> too, right?

I'm assuming you mean documentation specifically for the '--all' option,
I will include that in the next version.

--0000000000000fac34062ffb4793
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e54c232ef07833cc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mT3pQVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXYxQy85Y1hHRm9SNVF0eDZLcVJvWkYzUmZXVU1uVApvS1Z1b29FL21l
NlFHaWtoTnEwT1hSMEswb3E0OGNBcXlUQmxiaWdoZ0YrZFpsUXZuZUR5RjE2cDBtS09TMXJOCmU2
cm9IdlltdTNPd0I4T1hrT2UxbUhEYlVQM2tOWU9BYkFyMzhVMTVHTFYvWWxMYUZDeWZMRWZNZW9F
d2ZzSjUKeWNQR2pyUGJnNWFpVnQ2bjRub0h0di9oRWJsYXFackZSZ2tqN0dRYW5CNHNxQzlXcXdM
bUxpV1lrN0hXbWVpOAprcVpSSmlVY3pMeXZLM0gxZnhSUVk1aUlEbytqT2tGWUFOeFo1UTRPTDNC
emZpS0Q2K25oTTdJYVBlWXhhMU5aCmx5RmtjbEcwK1NFUkoxZUZBc2NzRzlzSUwzTjF6S2hHamV5
Tk96VnVHUitDTkdyOG1LUzdzMkF2WkJTc2VveGgKUEU2QjJIcnNDc0NUMjlsMHBXaUZyNlNUQ1Q2
dGw5WmFGbjAvdzhCbnlTd3lma3BDNVZzUzNrcHJYQlRTMzZ1KwpmSGY5Zm9ldXdmZ2ZRelEzY05Y
akxnZjN1clE5Qk9LMDZIdForbWZSbXdjeGx4ekxRV1VHNFlMTTBkbEptQk0xClphdVBjK3greG96
OHBYSGUrdGd2OXlXR2k1bzlZUmo0Q2w5UHp5ST0KPTU5aWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000fac34062ffb4793--
