Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED055886
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290690; cv=none; b=hjiHSf0x7W15As8QOHLfoShoAhWzvOlnFvSOMHRMIydap9vusP+miSc5nWcvn9JuJ0NLXBfRM/nlirSSjWadbYjDAhcZnfjIami69vANlPOOkFe+V6N0T5OdxzBoEXSf81bn+QMusudtz/MF8OnyQ6NQ1z133nutcirsV8yqIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290690; c=relaxed/simple;
	bh=XPgBk3KwT7xxdN2iTokvLm2zpzWvibrihiKP+RSmdQ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZIhnC/I9Vs+kaUc4+Jpz8aGCzQV80xUPWt8E3QunHICy/k1dN69JhCVBLysOMRG00R+iwWf9c8esQWXvrJZKNDt0UPW8RPFo/Lzs9gj1PqyLIDuNZ4e9WmGatuWk1zC2JEgCNVRujKWcCgA9fdSww9LjOX5NMkgkT+Uf4l5E14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVjW4tPy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVjW4tPy"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso6918281fa.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290687; x=1721895487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK4K7bNo5slBYkw3zT4q9QNmd+j09UVcC5Icran7Ess=;
        b=aVjW4tPyFJYh/JnV2vrdKQeTErYqzk0MTuyyQXMwjTcIl3HAhAkgQnKIVs/Z3vxJxw
         GcwLr8o4UcnXvZzjIAFlmmOMuHiym7ZjmdICu776gaUCgsgCZHKDMVLby+g020LJA9an
         Tezy46Zjz1yKrL31Dp4766rbg3LmTzafq74WamRxf6E74jjz5jDyjVHVoowQ2mHwv3MU
         JTJ0iDx0b4GivFxC4djHSm2zyldIc6mm1UfCnL2vYd/4EQeF/jX4oTjDUR4mqRqoWKRu
         PFMIigv1+don5+Jpu0tYG1k25czJWsxBfVI7PjHoCoVqXeHsIr0ukmd7r5b5v5duc7I0
         54SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290687; x=1721895487;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK4K7bNo5slBYkw3zT4q9QNmd+j09UVcC5Icran7Ess=;
        b=MVy9Q/1gWAUiE3Jc5hXRa8NS3LPNQ5OlsGBSonbEnXnzWsmy3yDOzqCJaU3Sq0TpcU
         Qad7fbp2tSAIfx5UQBtc5ucb4/mUdjSl7Ba2T2F2/vh0w2vxdYRMFkuiMVjh90GloW/D
         oDjHRMJmmiTiMqc2V0t6j/h3DBbUEdXJAJPSnpS8yr6hl6b2B/gETa9f1WS7lQN4qtkg
         qCfaUMCdePrbzDPjdD4eBE2A/U+ibdThA+pxflVt/ZLDprh6VtcbvL1STR6TyO6xEb7F
         Ta0xfeTUy89qYQBwFwt489GRgoHXeluySuPrtGD/53bRBiCNCQz53NQb8o5BtbGvckqM
         +Vig==
X-Forwarded-Encrypted: i=1; AJvYcCUnyIeYqrpmLQqZMj/VmGNqJjyS22Psbxn9wkdxd++HhrJAcQUjl9q/Qw0l+X2ueFoMyde7143a/1AiYzi4sCHUKuZJ
X-Gm-Message-State: AOJu0Yw9PlxP1l+cWHyp3izoB47weJ5gdSz01RTrZIPtTI2DTAqYflTL
	FGJoM2zwfo5NkdkBj2uYdjxTXaC1UZshoCHpfywqpE2nquv1pmW6dyCqCTVFm2HHi5B9MZ1WQlL
	OM543LxbaDeltDEJaWxHkkp6T9dI=
X-Google-Smtp-Source: AGHT+IHfxS/MH039+U9KuX5c3AgKjmBzCT1yDD3M3GVgO/N4+3m6FxICkSBa6T2EXiMmP9h53liXs+g2Wc9r6LLi7GU=
X-Received: by 2002:a2e:9f4c:0:b0:2ee:5969:e454 with SMTP id
 38308e7fff4ca-2ef05c52b96mr11148831fa.1.1721290686475; Thu, 18 Jul 2024
 01:18:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jul 2024 04:18:02 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyne30eb.fsf@gitster.g>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com> <20240713134518.773053-9-karthik.188@gmail.com>
 <xmqqa5ilcngi.fsf@gitster.g> <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
 <cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
 <CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com>
 <xmqq7cdm90h7.fsf@gitster.g> <CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
 <xmqqle224npf.fsf@gitster.g> <CAOLa=ZQx4UKMfq7q2GMV6nYQGKeCj0dW_P4kG7yDTcdo--1HHQ@mail.gmail.com>
 <xmqqcyne30eb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jul 2024 04:18:02 -0400
Message-ID: <CAOLa=ZQkxOTSMih+-sKuHRdRFdrzxgiJdzXdyesM3523t65RJA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ec4a90061d813732"

--000000000000ec4a90061d813732
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> If we know we can write into /tmp/clang-format-rules file, then the
>>> CI script can do something like
>>>
>>> 	{
>>> 		cat .clang-format
>>> 		echo echo "RemoveBracesLLVM: true"
>>> 	} >/tmp/clang-format-rules
>>> 	git clang-format --style=file:/tmp/clang-format-rules \
>>> 		 --diff --extensions c,h "$baseCommit"
>>>
>>> right?  Then "git status" would even say "there is no untracked
>>> cruft" (although I do not know we *need* to keep the working tree
>>> that clean, without untracked cruft).
>>
>> Yes this is the best solution.
>
> FWIW, I think an in-tree throw-away file is a better option, simply
> because we _know_ that the working tree can be written (by the fact
> that we can do "make" and have compilers write *.o and other cruft),
> but we do not know if the CI environment allows us to write to /tmp
> or /var/tmp or /usr/local/tmp and you do not want to run around and
> see if there is a suitable temporary directory you can use.

Sorry I got a bit busy with work. But I did end up testing out writing
to a temp file and it works on both GitHub and GitLab CIs. Also I found
some of the rules are too new for the clang-format in GitHub, so I
removed some of them.

Overall, I've sent a new version with these changes.

--000000000000ec4a90061d813732
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a6af52b52c850d63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWXo3Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0F1Qy85aU5BRUxvRnNoZGpxNncrTUJVWjBsMSt4OQpETU1MNHZwNmEy
aTVQdGl1N0g4VHFnWTAyYzFTSWp2OGg4Nzc3c1NqVWxVV25HWlZNcGxFd2V2bzJ5QjU1by9kCnk1
MGpLdGJ0K1EwSFdrYXpmTDJPUHBiVC9LbE5VL0Jyc3EyS3k1ZEVBc0pIWG1nNGlTclFEUFJITG9u
SE1QVnEKbDRSRnJuS1lZM2lKVTFPc080S0JyVExtQ3kvRjREcDlHVDBUdXRnZVBzV28zSlU3NHhy
clovVktiNitmaTFuRwo4WmZlaUZUbTdNZU1SdnVwS05OdlFvbEZBRnh1MEZDdWhFb1F0eUw1c0FJ
NCtaL3lucURjejdFY29jZElNR2lsCmRoaTh2OTJSSGl5NCtqQjJIa2NBbndZSkhGTzA4bVJUUHRk
MmVXVWNpR05RN2pmdS9ld3QzQ1lXZWhGYm10OVgKRlRpNEdNWGxabnB0alkwZ2E4LzczeTdUU1Nj
VmVXZEJQZXlOMWVDaU0rVTVnOHN6SkprQy9yTHQxU2pmWm9JSAoydEpXNHpiSHRKWVZZTzNmZkpx
UzhBeW5OMEpUb0xabEs4SzNWcWg0Y294ci9CdzhQc1hnblh6bUN5L1AzU01lCmNUOEh5Rll0Q1hD
WGNBWTlwK3RFWmc4ZTlRWllnb2tDZVZzbThFUT0KPUFxR1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec4a90061d813732--
