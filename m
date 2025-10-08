Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CA34BA3C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911070; cv=none; b=jXoxaJcnEV3L9FbM0/RGk/FzAyRgg2NdP5KtHLk5Ls974Ke8DoG6ASZmpVgXAOHFXhy7s+lCjrHrQXREwn1TX9t2tiGaZkLOFLKCpEN+MzdtlPuoNT4UraPUh0WBSAX9RYm5m5OFoJChTJ/R3gAYKS1c2OdhHGPRdev1I4piX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911070; c=relaxed/simple;
	bh=j57CvxgoWIcUiLPr5+Hd8y34pSSH8rHiU7jFrISHF9w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXNjWzvP++jwpcQi792yhHGWx9kVXlyi3bX2qvj81znFFhcnY3HH5HTVrLt6drajx1E1HI8OPRBfP90vI9OS++SSAuHaWtv5vKlpFhupQBbUc/n9FRJoTUG6hgBZIO6XdwtpElOeO2iaQ/8bTbpaZC6zRQXa3yw1odcfo58O7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdINAysW; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdINAysW"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9000129f2bcso5190235241.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759911067; x=1760515867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVrBlU98D4FjQ7n8j3821tOf9wq8RLrK5k2HT40uXPI=;
        b=LdINAysW+odkbkRUkAxCJt/kECXOHWogKKAO+oGFImj/kxu0TLlRTL5X1j2i861+eq
         QiyuryCNYsoR/HH/enUwTJkETMHNQFEuOTqNFCeB/6FWfXyjBcETEIL9+q1gtXpMFhtX
         n97Jxrja6hYZ/J7cHkmBrRHnieIksJ0jv/vJXBRyctaPVY6BpfG4cpA4I1c2MUpl6hde
         UOJ5O9ofdy8hBwn4mdyPCz3NqKP8BHRkxX7Drj3NBnt5fgkYtyMB3p9qG5RzCe5kRMvj
         0J/HtqtOtpCeFAsrOwpJXV6P4Dutralepch4t2qFU8bLbwwJOJYXaZNK9NaR2bNuoLGR
         FL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911067; x=1760515867;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVrBlU98D4FjQ7n8j3821tOf9wq8RLrK5k2HT40uXPI=;
        b=q1IA1DYUBMPCx2zY1zNkZhVXMhoUluz6facO146eSMsf29uH+mNmM+BBb8w5r64B9q
         vGq9BPQPPFLAvU1xEVM5rmCrKKch1/2h84/Y9vWioRhIovD09rel6QCyuVOmrHwkmYbq
         DwluqBQzC+BJGIOf2Blwr7v2salkZVTIgkBBahOrYq98C6G4H058sowBepzBkPzNB/Cv
         zCOOceThgsU9xS0xUMAXvsIS/NWSHFYPUWdEK8o+EYrJoWfTgMZypjfj+3M6fzYkf7xp
         SX+ZMSiq5FY7E8lIyhBA3ufk/sGYxpY8Ht/TNdpyKqfTcPgRqIP/gSvcLzK0mvkb4lTD
         WTLA==
X-Gm-Message-State: AOJu0Ywha+0rBvpQ4SR6mwIxveAryD4dl/91zzHzYYNIH9ZHXEz50hpk
	PfOuzvwk+6eQNEkGEh6kqbeANTBWsckyDd5Y8x+VAMnjohZnq/9UkXSzX9QpNXUpA5/MVDGwjG4
	rm1QGbZimSeGPXg+ewlL1C7gmiwVRvgM=
X-Gm-Gg: ASbGncvMWPA8A+gZ4zAU0KbZvyVD0w9Wkw/9rH8uz4yMH4SJY3auiRBmgcECnowqji/
	rFfSdgDVmvI2sU7dK/w31qOwcfPtzrafo3dszH/PRO5/2JSUb1R+aXpFm68FVlLyOso5zR9Ee6o
	uQ1iBWL+rCPTDhP8TN3anK3Nl+RxeWxd5PKKfuBH1ULwPJAw0yiXVJ4k6bSmZO1QqSus1tcj9lp
	eG6ISb9yrNiNDZK81VYdasqv4SGnqBCxiZS5PcVciABGLg9zgDv6GdkmfPy8eS7/GmgrM5S5WtE
X-Google-Smtp-Source: AGHT+IEWD+3+dAlMCDMvXVtqw8I1HD7EfXtI/UETQN0qK7fzTltlbMkcb0aD3vFn6uDaG/3MpcTQeXva2/IwqX+cRTk=
X-Received: by 2002:a05:6122:209e:b0:54a:a048:45ae with SMTP id
 71dfb90a1353d-554b8a82a73mr995025e0c.1.1759911067122; Wed, 08 Oct 2025
 01:11:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Oct 2025 01:11:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Oct 2025 01:11:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq1pnfof71.fsf@gitster.g>
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aONhmrE0otiyZ16f@ArchLinux> <xmqq1pnfof71.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Oct 2025 01:11:05 -0700
X-Gm-Features: AS18NWB3h0F8rDOmOSx_YKyzNY25smMAC0Rph8FN_YdGiqAFG4P6JYUizzkcgsc
Message-ID: <CAOLa=ZQzfzRkzK5qkg+rJWqZ4mE9fn06tx9njGzGt4YNi3kDwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] enhance string-list API to fix sign compare warnings
To: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000fe284e0640a1393d"

--000000000000fe284e0640a1393d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> shejialuo <shejialuo@gmail.com> writes:
>
>> Hi All:
>>
>> This is a small PATCH to enhance string-list API
>> "string_list_find_insert_index" which has introduced sign compare
>> warnings.
>>
>> ---
>>
>> Changes since v2:
>>
>> 1. Enhance [PATCH v2 2/4] commit message to express the motivation is
>>    avoid overflow.
>> 2. Add comments for `string_list_find_insert_index` function.
>
> Thanks.  I didn't see anything glaringly wrong in this round.
>

Same, the range-diff looks good to me!

Thanks

> Shall we mark the topic for 'next' now?

--000000000000fe284e0640a1393d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48f146ced9ab4060_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbUhKY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEpRQy80OUs1SlRHQyt3N25aaUp4MC9HSGZTbExzOApsT3VmaGFkOGph
WEVHUHBQUzRmUWdpcmFoSjAzUWJhWkpYU2drTGZCZGxST3dTRjlQd1JZTjRiaStlNVBIUGNlCmtQ
MHZVOHpIbmJKYWgwTTVQdm1YK2ptS09USXhMZXZFWG9DaDhQOU1MOUF0a3F3TVkrbzE5Zi9DTlI4
eGQ0YXIKbnhmOU9TbnJtakxTU0RMUVhScVRBVVhtWjJnRTNDU05KUzNhMndpa2VVYnBzUml6c1k3
aWZyOThvNXFTVCtyRApxSTd2cHJKTWloZmtaS2dLQXFyeGgwVklVc0tyMzFZQmxhUzZxN1l0ZlI2
MXRrUnJSOHk4eFNEQjh6Tm5Ea0pwCmsva0xNNENhcGl4Q3JKUVMyVzVHbWY1NXZRMHZYRUhUZTh1
WFhGVmZZclJ5UmtzMkxLSUxBYXlmT1pYTUdnaU0KZDhINkhtYU96V2lRTGNZWmtsZzE1ck5LZjRw
ajR3OE42bUZZMkh0MGU4SVdQVzVwVWZBRE8zdXhnYkFTZ3lxegpUUHpxNktuY016RGZHUDkzWEZQ
Z0VMVG45Q3d3UTBjU3dsUThzeUZ4OC8vVUxCRWZyemJ0T1NmZVhtOS94NjVkCnlwdnh5ek5GZlFQ
NDhVcWIzMTFFVlgyM2VBV2JaQ2VuQmtGT05Pbz0KPVRlR08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fe284e0640a1393d--
