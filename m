Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF531FA25F
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710191; cv=none; b=bfGMCqt9JURUgQPjezPwFJzibE4RHhT64CIP7KrjiJlG7wdVfQqMFLKNEIPQZ2KAEroxTlel8iFna4DQZFcCikmhrJqQaqtyipsh0zUgzu+jAmlfdJDXzEf16gqtIbBPr7idkrdTTmYfEsdDqDmu1MmFoRsswantljfkB52re38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710191; c=relaxed/simple;
	bh=IkHjK97vw5AR7QNv+bmqeE+JJ+rvI4BkoWTBxkwkrDs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpEkhnAjW+9iM9HS5aT9rhk8A8XY5Rq33Eb0fZclpcH/5HUDBRMRly+p70BUxtFC+b2ffDtz6XIrZPp9uC1jMDNHoqaAyB5GrAJDEp+7erzzedAHXQ8y/OyEN4li8RTA0Cdw6ooHn3o8OnYqquxd+KCNMD+EYFIWUOX+VP/Z2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQpFNB/W; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQpFNB/W"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f1e7639391so1462406eaf.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 04:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732710189; x=1733314989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkHjK97vw5AR7QNv+bmqeE+JJ+rvI4BkoWTBxkwkrDs=;
        b=NQpFNB/WlGa7SjTfczAgfzDwXIyIHHtnV7oHJVvMvgujc6NFPmd6DoVZF1501/GcRq
         6S4qvlL9brGPo/OWIshJxR2s//WyWZw16Kxm3hVdcyLI8DQVWNlBFsZWFnPkW0aeOP5C
         8Clrn21P/Hgq/OLvzpEhsGrMpec8dy4nwD8SZBU58VDKUsxPaOjgC/SBbk4lEhqk8TEN
         otLXI2vPOC8DhDZRNvQE7FFiVlb26iJE0zQlr6NmaD0vj0UBwzjqeK/sDDxQtc4bmq7y
         vl4vS0Y6m/oUOUe1tx2HBMxLsnxSQ+92UznUwhkxijeJnB1BzXltaH98+RlUJWwDaxS/
         qb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710189; x=1733314989;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkHjK97vw5AR7QNv+bmqeE+JJ+rvI4BkoWTBxkwkrDs=;
        b=vQhf+uldrdmlINvNt2A4tsGUiBsJfA6T9KciS9qdOoxlOfdq5S9bbzKLw1lwakFcJC
         IEreMitPRSMbwTaOP/zmsJF5cWhiez27+njmsURozzTYSw/3xJB6dE/0dI39M70Vbj42
         UyyHHz3pkivcJ4TnJE6nWorLpxgvIS0EL+dyBRp4la5IV642IL513f72NepZXZsu8DHn
         FXEOT0QRFggXd/EwTSZtxYJjFnFLgzq2sZuD6eBu9E3jv3scfCgKjDAT6A1GY9FhdU73
         6t3gEMQIK5MH9HM3TWlE6EOZCKPR1csyEOP6e2c4Sl35aRSuL0bkQmEi6WJSN6rLJMhI
         nfZg==
X-Forwarded-Encrypted: i=1; AJvYcCVqcyz1B/6GAvA1iIWBNbXOomcVPVS/iBlUfEbSDgFRzIMOlwZQiFAsby/WwCPZiA7X2TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzegrftcn/mt7cKia1HWOI0jj7cj4nZ+c7ugvHZLbzT+nQ0Jvza
	2zKYRFy4vDwaFtZyrKvGoppvgSBJtYzk6r8XKCSRMIZMxXcGBZ4V3+G15qZbdAaM2XyBh62thiw
	xJUDQtFQiRivpyeCUMn4LsOyXxuc=
X-Gm-Gg: ASbGnctuq1IKWPIwJIso/vt2nkNXa9AmAeyp7Mtyu+ZiOWXz2edhAcvvj32pQF587IV
	SFzyumtrUn2+uUJBYOkdMeN6hugplfQNHf+NYKmzKM7WDdtz/VeUFU9jypiggzIDZxw==
X-Google-Smtp-Source: AGHT+IGjs98aERCaeA7yf07YDEefjtt6t1p/DDhzsGryAGCderxRPCg12PPPJpdb9KkDHC4tlv+t4KFEu6ypnCYzhM0=
X-Received: by 2002:a05:6359:4c99:b0:1ca:97a8:1663 with SMTP id
 e5c5f4694b2df-1cab169294cmr191179155d.24.1732710188928; Wed, 27 Nov 2024
 04:23:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 04:23:07 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQgKv4SEPRqQix8pJo1nr30Fpg2oF-LdDX1ynHeSjDcGw@mail.gmail.com>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
 <20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com>
 <Z0W3rgHQhmUxjgfp@ArchLinux> <CAOLa=ZTeRUT6Ex5Pa-fM1i-QbTfnmDN=o=MU_N2VFeLQwbscgg@mail.gmail.com>
 <xmqqy115x0be.fsf@gitster.g> <CAOLa=ZQgKv4SEPRqQix8pJo1nr30Fpg2oF-LdDX1ynHeSjDcGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 04:23:07 -0800
Message-ID: <CAOLa=ZRj8SiZu3AiBTGHwp+SiuBNBj3VAsVG9PppTjyKuz9oyA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin: allow passing custom data to sub-commands
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005047c10627e407c7"

--0000000000005047c10627e407c7
Content-Type: text/plain; charset="UTF-8"

karthik nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> karthik nayak <karthik.188@gmail.com> writes:
>>
>>> Could you elaborate on why you think this is an over-optimization? We
>>> don't loose functionality with this, nor do we have to have add
>>> additional code to handle the typecasting to `struct repository *` if
>>> needed. But would definitely like to resolve anything I missed.
>>
>> I do not know if it is an optimization, but if you know it is of a
>> specific type, casting back and force with "void *" loses type
>> safety, no?
>
> That is true of course, I just thought that is the price to pay in C for
> having to deal with generic data propagation. In the end I'm okay with
> both scenarios, I see merits both ways. I do tend to incline on the
> generic version in v2, since it is a lot more expandable.

That said, I see v1 is merged into `next` [1]. I think we should keep it
that way and like you said modify it in the future if needed to add
varargs or another `void *` argument.

Thanks

[1]: https://github.com/gitster/git/commit/668c0913f5803ebcc3b0b1f13e6cd49503194869

--0000000000005047c10627e407c7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f13e4c8322e7fcfa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kSER5b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0JWQy85NFZWSEwyRk5xM1VXSkRoNUVFTkdPYW1TVApub21hNk9iUkZY
NkJKU25Bd2gyU0w2dmZrUFJ6c2QzZzlmRE1XOGd4OXdxM0dUSllORFZGS1l1RGpSRTREN0F2Ckda
NjlScUdpcG9aR3YwNGIreGNUaXROc3g2cUdka3NyZVdyWUhJL3ZSQWd5T1F5eDNBaEYvRVhrcEk1
WEVSalcKVGlhVDdPWHY5UnY2ZFJWUktHUGp5QkZKaW5WNW4xcVArNElsdUNtSzVqcEJEUVNmM25M
c2d5Z04wUm91eklISQpzTERTRExxTUdWcWV2QzhPZEZ5YlAzSW8xeXlvZXRXcDRwUTRvcWZlZWlt
TjJLQ3F6SjlCRS8yelRtcUxhRGZjCitlRGR0MUl5aWxoZW9kQld0alh3aU53bWhSWXA2aERxUVM1
SnIzVU84NW9PUkh4bWtOZkhyL1NVZU0vaThCemEKSzFEdExMditReUVHd3ZDRnk0aGlhVTdCTXJ4
aWQ4Tm93TnRmU1g0eFdLcStWbFRoSEl0N3hzV1g0Wk9Qb0tFMAovc3pucUo3MThXekNZOUxaYkNq
d1ppNlYvVmNrL1NCL0FjVURtMzRnZ29qaTYzS05zbVBoQVBrV0dHaTc4dlZ4CmV4M0xkeDVyeEhx
cmpFdExXM3E4OXBNNzFVV1kxZWdFdk9ONUxLND0KPTRmVEcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005047c10627e407c7--
