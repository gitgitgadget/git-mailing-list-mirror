Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF27157A46
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846648; cv=none; b=Yr/DcMRqEDmWc4xZa3oIyczgJPN07rqOiAtonJKuQvjZyLa+FRHuRCBqaOTcnk+lHPBrEFI6j73dF0iJCWQZextroHz4+RWSzZK3ifEqJ9uEgECc5DhZ9qsPcYAFAXZafOFmrJnItcW+9LrpbLYsFsb+cH9ZdzU8K/am7Buw2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846648; c=relaxed/simple;
	bh=g6fOBSnh3P/8kqSBxlmQzastm57ogPmhFEhNUVRqCmA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGKkn5mVMbW0d2kEh4F8lHGIm7kkYBwc7fI7rU/sQzB4imgD7KiEoiWTyHZi8x0ZzaFK0yzzXvXJDxx1e13jUHLC5JTMoIHbsxdPXWA3hYv7vl2MmlLHTMwliA3j1LBX+jBNUxPTa4W13YIWjn1YwVahbliAqIlJTtJvBZcMT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRZ8+4fr; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRZ8+4fr"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523d8c024dfso1951373e0c.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742846645; x=1743451445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6fOBSnh3P/8kqSBxlmQzastm57ogPmhFEhNUVRqCmA=;
        b=GRZ8+4frLiMfjVCfyzR0N++MSmYakteq/bXfkfoza7+08P6RmYTe/dcKxrNnitKt2+
         pUdtWH+SXHMdFIaOBPYY0clVjrKeixsNHYZmeJjaKMhnl4nQ5Zy/OX3ZfNJbm1B53kZN
         /E693MJpZg37Tykt5W9Xi9Jzren2vLDKnJG2HWC5sx6OT3cCxdaVamOdZHmka8DDY8cn
         nPFbpudNtf2sW6RFt20GQ3rBXePtPBSN05mUfHL7u85VZWXyt2wHCYV95Zo3KFDrXvea
         JdZX0Ijecljctr2UEw+iEeufUhFHZZl5UQDV2AQozVJ5N0lpaMbInT4/b367HchqRtvz
         hiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846645; x=1743451445;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6fOBSnh3P/8kqSBxlmQzastm57ogPmhFEhNUVRqCmA=;
        b=OCibkDHgP7WOhxLnWczppEXulW28kZNWGZ3Yp0ZvHMnLiJfh8zkxR7XTlvb6keNvrr
         iuPir4eTFRSBYQUpCIM0XLOdGu6Grfn3gpef5yWDY8hm46eliHzFQ/pyoQUM6odSmRbE
         i0c4bDDkzU+KLlZUSmz4LvXSg9mKgHNR71mNY+Qcjte6ZNU9P0npHwdDn2on4u2umtFf
         iDJ5bvZqA5BxdCTq70hvWm6sttOl8BiNQCiQG/OvK6EJXel6QHc4IbLaVrdbVVzknsZI
         o9LNAFhMAo3nVjWd7dSUmU6Lm700y4j5w6x5hiri1XkEU34QnrVCHLhZ2U7N8tLBmnVl
         iTyg==
X-Gm-Message-State: AOJu0YwsamXCsdIcC4yfWmHU16idD94zqaqF4o3Y+ykMCzwQm5fZZHIi
	XCYBBbOOo3CyGuvnbasYlJcRKbE9Q6rO5AirI/iDdllizZaPlhNPHL3cTIlwyeuJMrTjeE6L4GG
	EClBr8TwimoiZfkMdW9WY79XVOQM=
X-Gm-Gg: ASbGncuqjQaJpx3paOnaxNb+gxQ+MbgSnjmBO2WponNFznrIZne+jZfeeV6gioCqNmC
	Ix5S5iKH1Nk/cYVqxDOjwUGrmjLtzymKoiib6cWIsBE15s4YS7nGmG5fGyM7lndGb5mqBZbdwPF
	nqko/HR22VdumNyycO2B9nE8ickFOlUJPiydqQDLl+/L9wC4ID4EtwKxQzYc0=
X-Google-Smtp-Source: AGHT+IEz+olkvnho7sxVcuYx3BfBHM99sO3HjFbnhp3NEcJMWzR0LKrYyt+gzXgdalKR76QdSkzRZTwrS8ci0cfnrew=
X-Received: by 2002:a05:6122:322a:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-525a854e2b7mr9731706e0c.9.1742846645166; Mon, 24 Mar 2025
 13:04:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 16:04:03 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87a59aww8j.fsf@iotcl.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g> <Z-Ew_12NWX_5qATN@pks.im> <87a59aww8j.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 16:04:03 -0400
X-Gm-Features: AQ5f1JqBMU9JoVpP1UDyHOf4DAD037tn2zswZn2ZBk4FHMlLqmI6efFHB5uXudY
Message-ID: <CAOLa=ZTHb6ZFmpDpSwzUTiDs44gY-W3aqBooAMyORK8Xs3YQxQ@mail.gmail.com>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
To: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000002efdac06311c1b4f"

--0000000000002efdac06311c1b4f
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I think the porcelain mode is already built so that it can be extended
>> with arbitrary new information, no? In `emit_one_suspect_detail()` we
>> end up printing one line per info we want to display. I would have
>> expected that we can extend that function to also print information
>> around unblamable or ignored commits, like we already do for boundary
>> commits. E.g. something like the patch further down.
>
> Yeah, I think the porcelain format exists to be easy to machine-parse.
> Having an optional prefix symbol on the commit OID would complicate
> process that.
>
> And I've been thinking about a similar solution as you've been
> suggesting below. I was only wondering whether we only do this when
> using `--line-porcelain`. When using `--porcelain` the function
> `emit_one_suspect_detail()` doesn't print most of the commit info when
> it was already printed. But the "unblamable" and "ignored" info might be
> different for each line, even if they blame down to the same commit.
>

I'm curious, how would it be different, if they blame down to the same
commit? My understanding was "unblamable" and "ignored" are tied to
commits.

> --
> Toon

--0000000000002efdac06311c1b4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d16b26149f103c46_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maHVySVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0lzQy85Zmh6RVRMNnptb2pRRmFTRlRlZVlvbUJUeApvSWVpWENPNm40
L1ozQThHaXcrbmhQL1llaVZ6bnNRMStwUUVvVTRVOHNKeGh6YzR4cDB1aWhab3BMU25TMlM0Cmhs
MkIrRHFvb3BzS2lEWjl3R0wzMVowcGtXdG52TGtaRDdrTkFnNk1BZjhWejFwcDZNa2xOTW9DNFhL
Tk40S3IKUDIzbHJvRVZXQkUzMTFQdUxuQnZ1dlVMR0YyTXlJL1Q4YWJZemJxNDlmTkNDR1V6Q0Z2
N3hzSHBJRXQ4UWg5SwpyRkkzVGFlRHBxZ1M5MzZZMzRuTDZIZ0RaV3Q4bjdoYXNJUHppQnFyQmpK
ZUxObGVaUVNHS1hWVi9raE9LejVNCkpkakJyMWc3R28xOTBzajVvUkNnQ0tvNDB2Z2J1WmU3WE1Y
R3hNcFZXTm0wNFF2aDE3emtSNlhVZzJST2dFajcKam8vTnNkL01vclRvRkkvS0ljMFY4Snlka0Qz
MDBRV2d2bHNFNVM4UW9jeFVERUdqOGpHYXFhdUhjcldYZ2xmZApvSU1EWFZSNkJiY3Zzbi9oQ1oy
a0VCQnN4VG1NSVA5dEtKUWFrZlJlODhZa2I5RUhTM1BDRzFnRlBHQUlMdm1CCkRuVTQrNUVpMmdt
VElhU2VBWm5hRE1LeHAzZ2k3TmhCSnR0dDlsOD0KPWVRaXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002efdac06311c1b4f--
