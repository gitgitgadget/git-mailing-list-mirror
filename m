Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141241A704B
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386670; cv=none; b=dXBPMJKkaYyE+JmAM1zq/KkgFNmTDQDajPfyUc9Zt8a7d+4Z2MHSrl6n2Lqmb3GpzOQhcy1j5EEZs6lZabPbKvs7w2rPPNCt/R4AUJ5ugkqVtHImpgt1fmqxhoGMM7tDT6GTKzQGcdZcx3yG6AoDxoyEDJ0oEb1wGeZXl20bKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386670; c=relaxed/simple;
	bh=KrEH9tRq+i/woCpvTZ5xr1NIcjgKbQ0ClFbK6gX8fSw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhvFrkIpP8fRiL9kll7JZQwxcl8eDshVkakwBYkRSTZuBZAA5ItS6iNDxQg3JYGrEI6KazMT+WrqhSpY4Y+nTJGGWs3x3QhbWL6rXk8kprdzSUw8evSO9dDT7t7hY7k//PH5dw/r0n5zTked+KzjCfxG3sXMp1+zj0Lyx1az/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD853xGY; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD853xGY"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-879c44a1dc4so416279241.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747386668; x=1747991468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+wUeOIhfsV6GTjBo+CdPGaHF47jQWdCNy7VpQ/voRg=;
        b=RD853xGYY30P0Gtcy1krQA0aq1lc9dKKSzD/RHGgXbA7aGqa+Iw+FR9NtZ30i5AHO1
         lpuviTst8cqmfn2kHvuIYGLbzeYt+CZ3d/9Db4ytDg4yQYAsZSp6Xn4Mim8pez8kFIqx
         n+TjEJAwhg2IV9XO8JhgVieIk75NGiOwz8jrvk1/IId3wLCBY8xD9CZlZ58G3SO+Tvnv
         P4mMyZSb7mwx0hoBQp5lbFsNNqPTRpieAN2Gog8pYAVlzTe/kc244CHJX3WL7AzgeO59
         JVIWl3aroyUYuhlHtxqMzpMtbfEqH+YB5OhFA0VN32uPdi2waE2CdthlUvM67JQrL6RY
         UrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747386668; x=1747991468;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+wUeOIhfsV6GTjBo+CdPGaHF47jQWdCNy7VpQ/voRg=;
        b=AlcQtDgalvnAheUKKJmCEEranEho4jefyI26ApDy0a96XP0bABdYjXcJacx+fzHMcZ
         zGuh9zkXGAHkbB1/JK7h4RIqipPtLVfWOzgKyLLvC0zCiuFCUZ+aNkCb3D/bLZqxrLV7
         s+52mO0YmUE3L5o5UmnmkezmLHrbhfMweFkyN2txKFfaORx2l52UFvEP/pb1MjCOoI4j
         HVQoBR6ukzGllzfMntaFVR4Rh1EbfsiekfXQhEtcNPg3hqTjZL2WAlW4ShV9J3PXCnZn
         tj/Ayi8w3a+k/ZYumTeXPObxEpd9X/r+WyybOKJAP/F9Bn596GBGgyQLkVo35is0ZxKO
         Rl0A==
X-Gm-Message-State: AOJu0Yy1Nf71oVKfnEqDDPHVKkb8eruG8wpxPp4RiZ6AR+oB9pZPbtJi
	87O08A3c3v2dIIUhtu0Ftu7QkVg5BjeHJCfPjMb6WgEKcHx/ZRBcRXOKg+4rsgWN5E50rZUOe9o
	zgbjyEyq6zRsfFoWdnkcE4g+fSl2/jEtKThgt
X-Gm-Gg: ASbGncvmisS2gBIrbZflhXKwanilA+VH5AFEFw77CZRnyfVNkIHxZvwRSshEhGOCV0f
	9w22TZTK8OJl8ld4fhg8JacJiFnWxmg85iUw9XG9q/w8IsbXdGt4JFBU/NMociw4r2qIZrKvwkN
	D061ixcYeTVKem3ARdixwq0+gDVlgmJRiuZ6+HQZNbGv0hgGXUcAsguH1J6IS+gtNKmTAsVpFQi
	VMlrg==
X-Google-Smtp-Source: AGHT+IEA4MS/HIFrmUyJyrIYYqyWupHbAtf+lMKDoakiGSSFD+kOoz5RRlAMV/3G97KhI9hXQxaKpUdTnl9LkyadTyM=
X-Received: by 2002:a05:6102:3e95:b0:4df:4c9e:7bf9 with SMTP id
 ada2fe7eead31-4dfa6ad38c8mr3193409137.5.1747386667813; Fri, 16 May 2025
 02:11:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 02:11:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 02:11:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250515191153.GB3309052@coredump.intra.peff.net>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>
 <20250515191153.GB3309052@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 May 2025 02:11:05 -0700
X-Gm-Features: AX0GCFuoedAiMuyiLReRsSi9P4bt-NASCWOzY3ELpIXNffP5qhZZG6sMjVzieEQ
Message-ID: <CAOLa=ZQHR5Xt3yP4FM4gAbFVRM-dXVPpQHS0tObeoz45T89X7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] refs: add function to translate errors to strings
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000009ee67b06353d29fa"

--0000000000009ee67b06353d29fa
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, May 15, 2025 at 04:07:25PM +0200, Karthik Nayak wrote:
>
>> +char *ref_transaction_error_msg(enum ref_transaction_error err)
>> +{
>> +	const char *reason = "";
>> +
>> +	switch (err) {
>> +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
>> +		reason = "refname conflict";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
>> +		reason = "reference already exists";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
>> +		reason = "reference does not exist";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
>> +		reason = "incorrect old value provided";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
>> +		reason = "invalid new value provided";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
>> +		reason = "expected symref but found regular ref";
>> +		break;
>> +	default:
>> +		reason = "unkown failure";
>> +	}
>> +
>> +	return xstrdup(reason);
>> +}
>
> The assignment of "" is dead code, I think? We will always assign
> "unknown failure" as a last resort. Not a big deal, but just something I
> noticed while reading this related to what's going on in patch 4.
>

Yeah, I mostly moved the code without much thought into it. This can be
cleaned up. Specifically because we can avoid all the memory allocation
and directly return the string as a 'const char *' as Junio mentioned.

> Also, s/unkown/unknown/, but that is present in the pre-image. I hope we
> don't need to retain it for bug-for-bug plumbing compatibility. :)
>

Thanks, will change.

> (I guess the dead store of "" was present in the original, too, for that
> matter).
>
> -Peff
>
> PS Sorry for all the nit-picky comments. I was just going down the
>    Coverity rabbit hole and didn't really review the rest of the series.
>    But I wanted to say that the numbers you are seeing are very cool!

I think all these points have good value. I'm happy to address them :)

--0000000000009ee67b06353d29fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ddceac1e98ddc232_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbkFTY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODVIQy8wUVFvY1Fpa1dtbEMvdkFnU2M5cHhXQ0dkNwpDZ3h2VnBaWDZ0
S3ZGUVVBS1hEYjlsV0ppVmNiUWRFc1ZXVVZrMUdNK0JGZHpOa1hOeUZQcGRTM3c5RHBtVGM1Cis3
Tjcyb052OExob1pSbjREeWZKSS9WaGRBVTYyMG5DOVNCcWZNV3RVQ1BzblIvU0tSeXBVcUpkbkNU
VkdmdnMKSis3S2RLRzFhcHNXNWlsam1jLzJ4WmdabXFlR1g4Z0pzYUl0OEhiYVkxTXE4UFU0NW53
WjB6eFZtbUp6Q3h0VAowR2l6V2g5eWhHd0NESVdFWmFPT1Z4OS9GZ2F6V3krYlNEcytwYVZudUI3
VUZlMkRtK0VnTk5CWGdpSDA1T0o0CjVpTHBsMVZkTWlPREVidTVhTW01cmRzUmNvd3NPOG9GTHB1
Q3hEdHdtSUFRV1BUYWdnbHdXa3cwakg5VjdNQ3QKQm1MYW52RXhJTzVoWWVUMlpyS0xaTDhybytI
dk5CNm45MHJKWGhkS2JSandrYVB2MHBIWWhndjJodnNIU2hTQQpCN3U4NVZLc2t1a0EwbGdhU1pZ
T1JDMlA0bXhPUCtvN2M2cG5Mb3llQ1A5WlZOL3pCd0FZc1Q5dW9zalpqZFVwClAvc292Q2VNVzBu
WU4wWkJYR2FJYXY3WTErNDdOdUoxaEdUaXFSMD0KPWFDMUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009ee67b06353d29fa--
