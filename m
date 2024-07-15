Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1B15491
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072019; cv=none; b=PCYHD9/9SF9jVHgQwW+yhlz5NyLvvUXYt1iUwAl0VVhRSSG91sDkMkbGdjX/ONwUsF9NqJpVYmAMTAZ+EatJD3vZh4G32+7qaaDXJv+pjQa07sZ9FMM1HZyjEvP6vaqMigMYXomGo/3JedIdE/+xY9gHpNruBRE2tlcyN/ryN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072019; c=relaxed/simple;
	bh=wGBUvGhjC7F76QMiXgox8oHksemwGbnj0RFtkGAVc5w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKfGcIsiFeN/8ZZ/5zhJJguwvAnNhVRKGUEXxWRFjT4LtRiLbOIt6OOfthMQdbjKTAiWNt27zZNGZ3OSphRzi5bOk7neb2ZMbDGC+s2BRETFN+mRixxcvbQwU/DNFYlXQ8B61fu+e85SQH8NwsBdXjWDPezXB87w2p22DRjCQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/LqLW37; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/LqLW37"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c697fc4aa2so3327935eaf.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721072016; x=1721676816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGBUvGhjC7F76QMiXgox8oHksemwGbnj0RFtkGAVc5w=;
        b=X/LqLW37rgfAQzT1pnRuxt7IqpRXHrIti+stUKVCNa7s2yjG6KBdEhTYTUIs5fcaMC
         3TeNAX9P+c9a+gSowumxmHwp0MgJ/Vb4qeliSyqPi3Ld09jSqmuPEAygABXktJBbHZYK
         gmdrNIIryU6gi2OX7E/mat3EzqHA/38k5r156jPnEgIlrrFBr+7byQdwAJSFbacSitVI
         7cIdeTUB81SxYVQrvDFhIxuLDPNLA99a6yAhQA7rHzbgGaTc6iSFZGabcB7AzSyFMRhB
         qEN9pwt1CgyDhMD9PWSsXust8JZXoBg4VK7nv1X+6/AlEFnIcUaqRg+eLCl7LJ9+K8WN
         r3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072016; x=1721676816;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGBUvGhjC7F76QMiXgox8oHksemwGbnj0RFtkGAVc5w=;
        b=FDEXvneK3XHTUitp14zsOb30cwYhrKQNshSS0DrkQt6Z1PpdLUZSlS+BluXCXdF7qW
         GsCxJORTMZ5i/u3HLbIfdZRjYxRQbQKw2X5EGHEitgpH9L9UUld4YfNXH4eaafjEiV+O
         aTRG4nu9Juy7Y6LaxgiwhyOnTk7paij2P0y3zaCPbYDN+qs1GPPmiJBEVUqfvbvJSQnD
         xaOxUVkE+XDpKYeK9TOiTGWV8XOs4mJVl2BorRZfh43yVAV/Z0uwsDWkQ7NYQGAvDG6u
         +1Rs84rHRlevMkIKSwcqq8yoKyB8gS9HOsyxmbjxIH7dvXpyjWQDCk0YEaieL6V5zYFg
         PICQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe4mnx8Ytd0lKG2aWMptijk8TfpMFMzpuWBy6E+Kg51paHsDYccUMTsRcTiohZVCwzZ22l3Jt7R1ebN+u3mhdhm8hM
X-Gm-Message-State: AOJu0YzmicFa+d3yhba28KzLnuluJMDkrTwfGUlyZduhbxExLREGFZpp
	451GZvteJXCyrC/y7mzJboDEXpAk4ePh+KIUi8HxSEd7rrhd3ESjyitSVxqngW1chpER0uO4/PU
	qMHxhUyyYiR3mkbsHf2wGIBeaKA5QEBpQ
X-Google-Smtp-Source: AGHT+IFj9pTfkbNOxyHTvXD/MC+V9iUYcjg5h2HkK5kIytmCPJ6Apv++sZ8q9dOAde5zQrhem7ceZi+gGZ9ZGaqA/uI=
X-Received: by 2002:a05:6871:611:b0:258:5143:a21a with SMTP id
 586e51a60fabf-25eae7c7b1dmr18309800fac.13.1721072016663; Mon, 15 Jul 2024
 12:33:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 15:33:36 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qy24mil.fsf@gitster.g>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com> <20240715093047.49321-9-karthik.188@gmail.com>
 <xmqq8qy24mil.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jul 2024 15:33:36 -0400
Message-ID: <CAOLa=ZToNFn5FvC0DDcx4V0tEgruSt1igDEunqZjkUiJCexQbA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
To: Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002fc94e061d4e4e4e"

--0000000000002fc94e061d4e4e4e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> A more ideal solution would be if 'clang-format' allowed us to append
>> rules to the existing '.clang-format' when invoked. But such an option
>> does not exist. Since modifying the in-tree '.clang-format' is only done
>> on the CI job for style-check and doesn't affect any other jobs and is
>> not persisted in any ways, this hack should be okay.
>
> I think our mails crossed, but I do not know why this hack is OK.
> Are there other CI jobs that muck with tracked files in the working
> tree?
>
> Thanks.

I mean from an operation of a CI job, the repository is discarded after
the job. So there isn't a problem with murking with the working tree.

But I agree to your latest response [1], it would be best to do this
with a temporary file outside the working tree.

Will send a new version soon! Thanks

[1]: https://lore.kernel.org/r/xmqqle224npf.fsf@gitster.g

--0000000000002fc94e061d4e4e4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 244b1115ca19fd3c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hVmVZNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWpCQy85SnlLMjVIMGtEbTdqeEl5VDVqR3FHalppRwpHZG5xWWpTWXdl
RllwamlmSXh3TmRKL1N0ZEgva0VHV1pYZ1NKT3VORUZLam1KRnpVR2FGbW9jZDRjUEYrTm42Cktl
ZGtDWDV6bHpic1NxUUdjbGJUTFNwRkVSakszWFVrSS9ybzZ0S01jc0kyeUo4VWJJUytUL3ZkM0Zm
amdOVFgKRFFDNGJEQmJTaW1XMUlHTFhWMjlWaFJYYm8zaEZFQ3ErNVZzMUZxSWMrTEVqV21udy9W
aStWcEh3cWRldWI3Vgp3cFJrSW8xMXB6MzljREtRQWpDWm9DTkIxV09PeHBZeXpmQVFoR0Y5UDRH
dVl4U3hodzF3SVhqdk9qcXprc25sCitzTFZsdmpyWG5QWnFkODFwSGZ4eEJhV1dYd0lLZ2lVVFhs
K3JCdHVIb0tVUkYvZHF4SkIxdHljN21XNjA5QmwKQUZnRk1zKzBiZlJlTHY1NHJYaHZXdU41RE15
ZG9QZnlPSitNTDJwNThzNWJaMXd0S25tRGJtWk95N24zNVlINwpPMjZIeTFlZ2c3N3hrY2FRa1Y4
WVlZSzNRS0ZYSjAySnNWREFnRjJtcjZadmlrOXBmaVRZTkE0UVoyeDN0blBzCjRCclVaQUxtUXNs
NzBvR01TU2Q0Z0pMTzNsUkN5UklENXBNSXpxTT0KPVhXQ3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002fc94e061d4e4e4e--
