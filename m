Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3B1A704B
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386761; cv=none; b=oCBp2CGplaRwN4fNIYQ5Tl1K1Bb/z1IcERDJc6uASp0aAxrrvaqP7g52GWVS2vcg5J/S2N4I1H7lNcjZ5l0c2tU61Z8zYRVSTemo3aoTfSU5GXDBOsWTLm1OLYP2vrXwoexP6d8aYKcTGZUzt6gNXNGF8nCcXZTYK9K69qhRsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386761; c=relaxed/simple;
	bh=t4GVvwRaQcClmkrl+j/zxUbGhHYLUkxpvyq+wr8K9E4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlXUe2JJhA1fdnhZHcFoaQh5OPditXBkSyMOUEvV/K6LV1IrLvNUD8vmttILpKgdnVYRCRiVWvVRO8CANJdouyWcMcEsDz4yjygLSlHF/C+/6q7R9j0OrBpeVRb9uMBTMMr/T35tEL0ZwS24KsUExVuoWw+k9Bw1zbOfPUxyrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9BJrpNl; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9BJrpNl"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-52446b21cfdso605125e0c.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747386759; x=1747991559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AjnLmLDTgoP1dVnvkdkAvgmNRJ0DXKFYLR1OmAiLLQc=;
        b=W9BJrpNl6/8wd9W/DypgzwkQACH91dW0JPqqbKXl418fkggwXi88tzdmRWAb2ajxHy
         /dyEBjQm8AZgJ/JEAtLHGmPHeXxb8xtBEwSAgCEKiqgHEZH+zYCfEPO+mi8BEd3eXPMh
         u40J0SlHf7VkqrSP8CuwLye6nKLxAU48Q8Vyoz14bSksw6fBtjpo4mRtEg6juJC84HyQ
         rVQQ30xx56IhAhLfnT1x4mQWGhCxaiVz2LAw8DSGLZC2soQpbfM86tVJWU1zqZdpD1gC
         MMGJQR9Uko1/Cbb7jcBr2nqH0dV0FJXvGlyTN7A4BU2Y35Kiz6JEhHkJgYbBafdSzT1h
         B4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747386759; x=1747991559;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjnLmLDTgoP1dVnvkdkAvgmNRJ0DXKFYLR1OmAiLLQc=;
        b=FcipvjaKHvD8Z+w+ZVpHIpgL6v+pgfOansdr60t+5HPr5fQ1id7oN+4kngiLHG4ZKT
         TrG7x5Cg8duySv7/qJzQsQSIsgl2t8zQFvrYHWJ7WzyZyC47GcpwC9sqmcLWFz+sdLcz
         wUmCvq6TtTdcDuOvcr3znR2WQnYh0rzHXRoHISTGZwbORueFwQuGBlfGridi+Z1134hS
         rqyQoxflbElfjvoDl9iKQ0cWvL7qUm2zPhK9fjputd5wnTZFhEyB7KI6sEOaAfVAGkRR
         0dm9Sb+HxXX1yo4DieyyydhHrjXln6GLB83E6StefJLvieaLRRseZBdFEkqkjsbz96fc
         sClg==
X-Gm-Message-State: AOJu0YzJfwuFbiuJE7qwoyhtCHfahmszqPzHN+kjke+5DQuGPVfWPFoy
	wIgwig+MnG++b+DaLZGI4rOj7CyHKH7D+jWDYfrrCJ7o0nNlTx0yOBPS3VoMjNRiYxjlem8NZlp
	gtOs9nL5tPVUwkSeodiNZTI38ClyDUaZy2oDW
X-Gm-Gg: ASbGncsv3eLo/g7kYW3gXigfyj7fftB9aWdTbFm+9o5TJY5Zy+azxIWsGltBm1VeJcw
	rufYTRr93is664sRRcsFjKWcw9A5CgVv6DrhAVDtuTPJJnwVbAuYI4olIDvJ6m7HbRDHX44aMiW
	kUDh6y2nVfVvdIhoszUFfG2WMLkuRqNtKXoutQAwMhwTB72Z7diyH8uJIb4vR7anyQ+No=
X-Google-Smtp-Source: AGHT+IFQQwNIb48oG++VMYitrDykWgp8W0ZQqTKiKiTNmARqMhBxd+sdnI156DrXVkwUcGNLmYsknsV/W/KUxXA8oQo=
X-Received: by 2002:a05:6122:da8:b0:52d:b855:e0b5 with SMTP id
 71dfb90a1353d-52dba83a776mr3456000e0c.3.1747386758639; Fri, 16 May 2025
 02:12:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 02:12:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 02:12:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjrtzkm1.fsf@gitster.g>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>
 <xmqqbjrtzkm1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 May 2025 02:12:36 -0700
X-Gm-Features: AX0GCFvjvymrF7a0UZ3smFKM4mOzH3r14aAE58e3m6UX3biS1xDDKvtUxSLzhYo
Message-ID: <CAOLa=ZTwchMMg81JnHagQ10rpRw6pR5+JQUWLUcaxusGFBL8PA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] refs: add function to translate errors to strings
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000008daa806353d2f51"

--00000000000008daa806353d2f51
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

[snip]

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
> Why can't this return "const char *", without xstrdup()?

Yeah I think that is much better, string literals are anyways not on the
stack and can be passed around. Will change, this would make it much
simpler.

--00000000000008daa806353d2f51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be8a31fba054f773_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbkFZSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnR4REFDRFI2cEZjNlhpZjhvR3FNRDZ1aTAxdExpWgowZ3hFY1Z2KzVM
cnhYWVMxS0hOY2U5SGZnYmhRRG5pVHlYeXdqZnRac3VUM0ZKVHlnaXJrY3RFMUV5UWFkdk1VClZ3
SWpVNm9zblAxdU9taUNjUlFuSm5PeTJLK01FOGI4L0dRSzNYNVJrNHFqUWRuVUZDVklFRHNBT3J1
TU5UNGsKVnh0K01tSU9NU29CcXRzYWtBVWhXaThTUTdoMDNoQ3VVSnpBR0x4WktjWFhRYzhWejFY
SW1BYVRMQXF1ZzV3UQp5aGZUZzRDcHRlK0ljMGh3TS9kQktBZTRLNms3Ly9SKzRoaHY4dDNkMnM1
eEkxOWozY2UvNGtGS0J6MW1sZWtOCllpNVRuVm1WMTgvMTIyNCthMnRTTXUxbHFtcW5YQzVBOFFp
TGF2YzRaMkxzdTdtdmdyaEN4a0k4ZnpoY255UWoKN3F3Rk9CTE1HQWVibzlsMUk5ajNBMWdHQTI2
YmRxWkxVMWpjRHFUcDhTT0pZdmZ5OGV6Mi9BcUlWbmQySUdqUQpvNDBrY2hwcmZzajcyaTVCa3Q4
RXByaVJhME5WYWRmYXZPNjd4ZTR6eS9hZ3FwRW5ZVXp3M1RUUUlrWVFWR0RtCmZmTkw3RERYTDdq
M0hTV2pJaDBlQU5uMFZ3aWhRNmQ3aDUyUmVNQT0KPWhIbmYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000008daa806353d2f51--
