Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC025A626
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399235; cv=none; b=VchQyzFxOrG819TYcF4dJda2N1BaOfyOIii/fzE739tVlIIwJ7+4eUm5FuoNeZO7RTpibmO8+V70p1LEVy/EXba5vEPtJUH/r13rXuXiYUMY9Qb9jPIRLuoCbfs0xz95Kh4N+Rj+NATfC3ZveQd6usMCmC9JCi/3+26GuimI3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399235; c=relaxed/simple;
	bh=zTmt2Qo2nC7YZUWoXXkGv88tiomfIb4dpGa+pUK0OTc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8WILtqv46ExMsIU3aeiBBnPIQrwb3wZyBPH4m4FpRlhQbJgCq8HvkXixQMLz2ofot7guRWxYy8LPg50xvHy/cDH2mwFw39ACgUdtsc8bUagVq2TjQ7lVDDp2pTIbnVHlIECW0D0ljLN2BZ1NlqLO9qshDlK/YPeU4E40Mz4nHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDtsNkWt; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDtsNkWt"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso1050883137.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399233; x=1760004033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNPQwRQzcbeApNlq+wDPV2LLIOx+5pCKIChsO9YKt5U=;
        b=kDtsNkWte+XNRF8K+u2hu3MKQUpuZFnc56w6wBhY4ejaHOIFgmUeyyX1X4vBbcoGNa
         DfCJnnRgzYEkTlliGkjpoEGzO7Km9C0kVI24ADCkJxALBw7SKooMpS7B8XOwz661z8cI
         6T9bYE1FAGv+DLwCxGOJ70Ip+bkOzqs+sSx6b4cBOcDzUxWPaUyT6SPNy/Rj4AZFzJcz
         oBcuHSrus1FXydRQUaQn46gsLBikZp/mVRCbGOOIw3QKkKhlTKMIMrxtTpgYrA4xYh2b
         OfWs2adI+09zUFrAVlkTnjrmqYs9bp7W2HIOIg0AKNoKNl7TVS77S5TuRJky9uBRUkvl
         el9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399233; x=1760004033;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNPQwRQzcbeApNlq+wDPV2LLIOx+5pCKIChsO9YKt5U=;
        b=CysyVQX1kvRYTM5Z8gFeabPIX8uBMNVJc8tGgqB8537Xk7bXF038kbNiWZjezN3ZkI
         6he3eQX5qyG+y+eVSuV2G/jzX7cLsflBXaWmfuFA1h5zMv+6on+D6fTwcGN1jL8Cq2Kj
         HZEImna6sToUliGZQdNYaffmWGwuoSTkvxJ/YQcGT8cQmKHDk9SPqldBLRHLImgoyj2r
         x8M0JHtl6iwCWhEZ0Z92H8XtMwq95TL4kxjBIFk7Zt/ipcqv3fIpQ8yRu3qvGwmvUu7A
         h2wO0hKfwTip9IAhKrbYo72pg6mXauHrwPXI/8fQhLmZjmNexFRVGo2uUFAhnYgX+l0L
         gzNw==
X-Forwarded-Encrypted: i=1; AJvYcCXMJzW6B6aGpehKbztlGrE5GW4rj5LKlQiSncETrG241G82JWyCOUYWNnvevGw129OHslE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRzaNYfDKJ4lYQxjkmJDRZ8Wd1NgrvdowZH4+xvcoRRda3D3X
	Sc1/Ohx2GjG3NCBxJ2GFUpRpIJ8NMeNz4H3KnDC67l6Fj0nvS+blVjjmAABQpt0XhFCJRVpxRn0
	24DUnNqw5F2Haf+1nuxV6Be87hHBeGCI=
X-Gm-Gg: ASbGnctvP5mjeC5mgsh3mt+Hvyx6lkxqE5v3BjWD0xT0RjhDN4mImA7UFwxP5SOYjGk
	WTaGAhp4f/6NeeAgDktzE0EZAFJ+D6NnOJgCRiwnWJ+9/ENujDhmNdjDoZjsZuIhoFjJtRvJ2ev
	ftNEiE3jJS65fPBbU/kNMVkHk85CHEXxO6gJ2kItXu4f8tOZDvntBPwqCr9lhcyYj4aWqAoXk9Y
	Fli6BZsE6mep50Kk5pjfqhmzKo0Bc08lr6mkzj/EL2b0Myd/fET98n67N1NAMl67Q==
X-Google-Smtp-Source: AGHT+IF5YyJQMRhCteHALApgRzj2Jhi9KpCw5zPoOIq2mpnecnPfixJKFr3JQMmKMTDxvaKwo3mIxVQFsiDYrwFk1NE=
X-Received: by 2002:a05:6102:952:b0:526:db01:5fb2 with SMTP id
 ada2fe7eead31-5d3fe6eff53mr2984240137.30.1759399232850; Thu, 02 Oct 2025
 03:00:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 03:00:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 03:00:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Oct 2025 03:00:30 -0700
X-Gm-Features: AS18NWDzT9mLBOPFmu_iv7b2XWfn3HJFEICCXboN7LtEH-akqz7YfrAQjNhozoo
Message-ID: <CAOLa=ZQjMzCiVd8tRXtJJ8yXxLgwGQDgOZW3F86h9jC71NJm5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Phillip Wood <phillip.wood123@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ps@pks.im, newren@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: multipart/mixed; boundary="0000000000004af94606402a0ef8"

--0000000000004af94606402a0ef8
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Siddharth
>
> On 27/09/2025 00:08, Siddharth Asthana wrote:
>> The git replay command currently outputs update commands that must be
>> piped to git update-ref --stdin to actually update references:
>>
>>      git replay --onto main topic1..topic2 | git update-ref --stdin
>>
>> This design has significant limitations for server-side operations. The
>> two-command pipeline creates coordination complexity, provides no atomic
>> transaction guarantees by default
>
> Are you sure that's true? Maybe I'm missing something but my reading of
> builtin/update-ref.c is that it when "--stdin" is given it starts a ref
> transaction, reads the commands from stdin and applies them to that
> transaction and then commits the transaction which will make the updates
> atomic.
>

You're right. Using '--stdin' is atomic by default. You can manually
handle the transaction's by passing in the 'start', 'prepare', 'commit',
'abort' sub-commands in the '--stdin' mode.

[snip]

--0000000000004af94606402a0ef8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4cb793933eedf0bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qZVRUMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1pXREFDRllpamc5NWd2UHBXNDhuUkFvR2x0UTMzSwpqOW1VNkpDOHNE
NnZmRWZqQmNEaTBQZzdrTTRGbE1XZlo0d00zVHRFbVJOWjE2Q25mMTczVnJmZkpVOVBhaHAzCmYw
Mkh3dmhndDhoNTNoOTUyeXNJRkxPMUgrZWd4K2tWZXRHVDFZb0laNkV1N1hUTWEweEZSa042dzdS
QmpoMlkKbllwUU1tT2lSSkcxQkp6UFBtSzV3TkVNOEM3S0hBM2dsMm02MS9KTkNyUGZkK2wyenZz
V0pvSG84eVhNTGF2TAp1Ty9DaWIvMWthTzJ6czR6ODRyMmU0Y3Nac3RFYW12SFFaa1o3bndzRm9J
aitpT1NEMEpVMFhTTU5NcFI2ODBTCkpNRDRLd0tIOWNNQ1pjVHUwZXZWUVY4RjBWODBnZkJOMUJS
QkJORldKRDVRMWRaZ1pUU1FtempBRENRTHlBTXkKdmRBUG9sSDFXT1R2NlQyb2lPbXZQS1JjTlEw
ZjhGd09ZZ2Fod0NxWkVrcy9tQy9LWTFFQ0NGME5LQXI5QXBoMQpWdlZidmdFUzdrbVQ5RVVac0F0
ZHUybmxqYWgwRXlOVlI3bGxJcGMwTFA0VTdyQ1dEM21HSmxONDVjVmJGTjM1CnJ5bDRBcWQ2cm5V
YkxkNVJWeGh3VTl4anREa2lZVFVKZXJVRFp3WT0KPUZnZEgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004af94606402a0ef8--
