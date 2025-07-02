Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48E2DCF48
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474756; cv=none; b=n8fRwADur9wsz7ELug6/UAs39GTtHGqlpu54XpEYxWKDe9x5qxa80Rhzm34eR/wZgNS0VABNBgcn/WJEuyL+n5F+FL6JtLVgMCJlCUUROVELqikwE+tbHqULTiCcLkMvYvaKihfbl3wyySqguOkWncURHnhX0kVweVRUHOVVsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474756; c=relaxed/simple;
	bh=n2NP4DotvoG5mX3b0ebaPz1j4MQvHy1tdz2KGcIFYoY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSuk3qxtRNZ4KABksyuyHrFb4G9tERU+iKau5T/U+zeNu8JeiOgN5zBGbpMDKJIVTWzKeW2yl/0iYEN+RhcOkJ5zlqoGRskWO2vaE0ZG7bieF2SGZNXki3sazvdxjRrpkG2KKUctbX7ouUYG08R52kdkzAZLe/e4YbL586WsMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUmm1Ipp; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUmm1Ipp"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-531426c7143so1392407e0c.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751474754; x=1752079554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yg+RQr2kHCA0xY9YA+7v5fa29HJGXjoH2tyUx44WArk=;
        b=WUmm1IppMsIpkRbJPMbWXvS4/l5mUaoz0X8z2JG7c9aOniU9a7+LguuTn5U3/dkRHP
         7cS/DYdIKFQceulx+viK1rxU6BMWltqMpBSZJjhZA/eY63oPHfV83IlpVtmHCu6wMo2B
         qzv8hybjlemQ+J5ezyfvFwi6S5hz/4vs/JxNF8v34xBehF5V1tgbrei/Ixbf/jm4xpW0
         pxsRylsafMVckw3EQNUbXJGrvDQDHbwP+8VBtv6cxlec8l/GkS16LcfR3pi4h/H4bhoM
         asQU9QIsFrJUFb3ztB0MIFh+qYYUf5fzDeAFGWgm8qaXFW8Hc1VkYZSDSHaS6iW2KAji
         jG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474754; x=1752079554;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg+RQr2kHCA0xY9YA+7v5fa29HJGXjoH2tyUx44WArk=;
        b=JyPnvtpJB2dJymFCFTzakyYCLy9MLte+ciV7YiAA1X+UwnRxYRRPuRA60BivYMGA6r
         Ov4rN1p8w1nBHkhDBYjzsJCTOsYx3fM+4rNV2NyjNFXTv8W/yw9ucJdCjS/vZVQ/RNI5
         8od2ndcXgekYqeJFaQBjQbcpVmLpDhIQBqU0T89pAZYOG6xgx0Aj9NOca+etKVSDHhp/
         wC7kEsTGMGNA3seRDwz7+IDdP+BBkuwaqpDAHc6lqkQAXQCib7Qjb0OvawaPxbbvkTfE
         Zxz9PjXUHA5kO7amO0nOUsDqs7a1i/c5oB6b51lPx4JPs9PPxIfifoVkco80JACxXvqY
         jPzw==
X-Gm-Message-State: AOJu0YxXdn+475M3mD8n+Irtw6+E61zKILZ9+H5Fmuke1tshBmsS5UdO
	wK3sxCTBwQxnLCg+y7DeYmMj1lHRtKy146L2nck2Vgd/k7R2XlcPoC6SsZ9sut59HFdnZL5jOwG
	c8Zy20o7nNN170uWpKn/HyT4hYnt3pDc=
X-Gm-Gg: ASbGncvf9H/ywf8RGh5ZhXT8JTW3fyyJvOsLAVSK4GORIPUMLOteYCM5uxvByVUCo9G
	rr+Si0G+d7Tgat50bpSddwtVr6qGP9/Fv+XbGzKLlHK5VWMA+sCLW2AvYpbHPE8Mx7gRiVbpImn
	vwhmlxccSCZr+5w9SnGOlWSp7npWhof6MR1+d1XOaMF55+mzAz3H88a93P/iQZ3UuwU/NGIqpXb
	prtAnTxRXNTada6
X-Google-Smtp-Source: AGHT+IGyO+HIHtsGDVKfTKhFOzayXpDNCH320rLDW2XBlqNyJ6spsU/HRbM6u5mTOliEsu1R36rc2mK3htFOGETkzw4=
X-Received: by 2002:a05:6122:8cd:b0:520:64ea:c479 with SMTP id
 71dfb90a1353d-534584a84d1mr2710538e0c.10.1751474754166; Wed, 02 Jul 2025
 09:45:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jul 2025 11:45:51 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrffltym.fsf@gitster.g>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <xmqqfrffltym.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Jul 2025 11:45:51 -0500
X-Gm-Features: Ac12FXwzALyHjJXL--F8EIIA5_Jsxjp0FUcab-QOE2kIAb07PdPWPTnfw-phk5M
Message-ID: <CAOLa=ZRs44wc7gtyKqn+nkOtm306FNCGFWsm5=sgDBSFoB52LA@mail.gmail.com>
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008e407b0638f4fe14"

--0000000000008e407b0638f4fe14
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `git-for-each-ref(1)` command is used to iterate over references
>> present in a repository. In large repositories with millions of
>> references, it would be optimal to paginate this output such that we
>> can start iteration from a given reference.
>
> I haven't looked at the patches, but should the end-user's mental
> model of the process be like this?
>
>  - We have a native order in which references are sorted and that is
>    what "git for-each-ref" without "--sort" option gives them.
>
>  - They can use the "--skip-until" option to seek in the above order
>    and start iterating in the middle.
>
>  - If they give "--sort", the set of refs to be shown would not
>    change; skipping is done in the native order and then the
>    remainder is given sorted.
>
> Please make sure that the documentation is clear enough to avoid a
> misunderstanding that this feature would kick in after we grab all
> refs and sort them.  If it worked that way, it would allow us to say
> "going from newer to older, but skipping the most recent ones that
> were touched within a week", which would have been nice, but that is
> not what we are doing with this feature---I think it is OK but we
> need to be clear about it in the documentation.
>

I totally didn't consider '--sort'. I do agree that we should document
that behavior if we tend to keep it as is. I wonder if it is worthwhile
to even prevent the two from being used together. I find the whole "we
skip before sorting" to be very confusing.

>> This series adds a '--skip-until' option in 'git-for-each-ref(1)'. When
>> used, the reference iteration seeks to the first matching reference and
>> iterates from there onward.
>
> OK.  Even the filesystem backed ones we internall sort after doing
> readdir() loop, so this is feasible.  Nice.
>

Yup. We have 'sort_ref_dir()' to sort each directory parsed.

>> Initally I was also planning to cleanup all the `refs_for_each...()`
>> functions in 'refs.h' by simply using the iterator, but this bloated the
>> series. So I've left that for another day.
>
> OK.

--0000000000008e407b0638f4fe14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b797ad9a4af79d18_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obFlqMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXdoQy85bVJ1NlMyYzNrQWNQVlhyTlpvd3pvYmNuOApnZGN6WkdaZ2M0
YUJ0TEZvbGc3L0pPalRydFpiUjUvQ0NsK2NaYUZ6WEkwYVh1akhtNEpvbGNOemNzYndHM0RsCnhE
NVJoRnlKU3NUR3g4QUdaRzlQa2tmSkVibms5RDdLcDlnUGVNTGdIWWpuRXA3SFppcmFNOWVDQm5m
NHp4RHAKSHhXVkhtOFAramtaaG9JazNLUndOcDMxc3lvQ1RRbldjSUtTVmxmZnlSQkUvZjdYYXp5
NzdrZGtrMXRocWJHbApRSVBvUytNRWtmTkRrVGZ5cE5FMkJXM0tTQU11N3hjQkFYbFdkMVd3cEhx
c1YraHpYTEo3MW1SYlJGR2xXbUttCjVlcFJqZjRXK3ozQXk5UzBVSnJqbTRwcWE3ZEhkZ1RYQ0tM
M05pYUpZSmJ2eE51WmZsMzV0WUNFS21HNVFGSEcKWUpZbWFUVThWMm9pemlVOWNra0dTTldPY2Zp
WFhod2hUR1pQZHdSaVk1NVZZc1FybGo4NitRQXBhazcwTlpWcQpYYVBmVzIwRE9GaVFkVHJBNUlM
MEZPVnpCbzhiWFIyMmdiN3hIY0FQcEJtVmplaFBQZkhqdjVtOUVCeVpkNWtNCjQwdjh1VTNFZXQv
VzZLWS9UTlpMZjEyZkdRVzBuLzMyancxMjVUaz0KPVZQK0gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e407b0638f4fe14--
