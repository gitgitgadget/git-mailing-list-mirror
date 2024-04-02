Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD122BD1C
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040614; cv=none; b=R7TTFBq3A3P/1H+ISncfDah/IbkkIfORzwcJkyCimQdRZGW2Yp1OkLzhM0YNZRmPQ6yKqF2bziSQyYaKNKiZrnIndw4km91zPD8VZtMl19CkV37jQ+bpZZTYXJRnM+Y26JAereSKTgxDxNfPIfeJvvDxreUXp7YWgUlmSoj7iDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040614; c=relaxed/simple;
	bh=PK+jJ17+qX7USMG3YxwcqgOySysw9n8c6VY1OzfbGOY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCjYU3dF9p1NOTyNIyvqUZtWhSsmHh0/Yk+mTWV6lDrt4+vUharlH55re17JkpTaAlw5ZkEwrVl02Ap+XFChUQC6VCjcY/DD2bfxjLaA7tjZY98CeOusKDciq3EooNegKeUgEEXQkDNXULfpa5+8FMkNyOsOo72zA4qSEjGU9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOSMzgvi; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOSMzgvi"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22988692021so2043925fac.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040612; x=1712645412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8Y3nPlKUjZejoYSypG3yn7gEopSOUljzUuRn5dOD1Q=;
        b=UOSMzgviIrNlPsGthskm4UavmPZA2iP17o/urI+Z6PbzC0RFAZZ16UGN3XSeuhro2p
         ldJaJB8mN4EHdMytxrnQldq9eLlf1SP9w7/IdgBOLH7Qea+sQ4+E+6CWLDLZJyaEDvpE
         Xk+sqd6wgNWpf6/HxrPUf24iMsjRiryGmF/RDQyAZmVTnUj5tOgy2WMtpTTzLU4fcBAx
         JRKSh0B7BLh1NcYV58NblaSm9nNd5r8W3agDNF56utUVGCnzrxashOSp14ojsUDTnW82
         SAFBLy7kxqlFbB2c7ugbWeQm6J2JDvt/Ivs7RQNgwNe2AkQicLwaqhfBTj7mXWY2lEpY
         w5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040612; x=1712645412;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8Y3nPlKUjZejoYSypG3yn7gEopSOUljzUuRn5dOD1Q=;
        b=VI0anqNth+lUmgpFhUeVBVHYO4vcrjgZcRf68At1MwnvQKwKekMJAzuXXK6fehjgMu
         Adcr2sdtpsnIh63p5xqQ8ClNdldcmpr5OdVMotpSzEwOo22zAW4P5lAYH/P1KIfNVmcj
         iTMh9V181v1ijP0gtz/P0Groc8wKmFJKhwv84XHBOBy1EoqzdqtNoU4jvxcV1UKgOVtF
         axvFGEu/MxffYgYSQlKn8HytUHt3+knBYjthE6rM9qn51tzDMJipQVZzKKVeD6k11JU/
         DfOINiTFUeYqDdX3UdEkf//57WBntSkWXbALOwv824s+o3NiliYFfXnv7cZl5exiCcQZ
         nZ4w==
X-Gm-Message-State: AOJu0YxDLWTbL2e+9aQVopFnV5m8ath/ThT6kc4cLZ3Xnz2VvKutEfIL
	RpkpILnHMg5y2ylYXXqfr81dQ7gSN2fTPOaQBP7TUylVbpTbDfHuEOBg62x+2rAt9zdR20aGvD5
	RanR+ylwBB0u3lzLyfardqSHdTSI=
X-Google-Smtp-Source: AGHT+IHO4tmpQ5tjrM1NnUM09JmofSq4+DzXhXgmYyiJ41EzR3ibuFFK3rXBU+g465k/vbkQReYqQJyD7z4xciq9whE=
X-Received: by 2002:a05:6870:c155:b0:222:8961:43fa with SMTP id
 g21-20020a056870c15500b00222896143famr3895214oad.15.1712040612390; Mon, 01
 Apr 2024 23:50:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 23:50:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqr0fo7kop.fsf@gitster.g>
References: <20240401144542.88027-1-knayak@gitlab.com> <20240401144542.88027-2-knayak@gitlab.com>
 <xmqqo7as957h.fsf@gitster.g> <CAOLa=ZQRw1Cu9rcKYoxzsL8V3LWjyMKuOkcutzqRJb+cpyBNTA@mail.gmail.com>
 <xmqqr0fo7kop.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Apr 2024 23:50:11 -0700
Message-ID: <CAOLa=ZS1OUCtPTC2LGpgU0K7U-ryNkkKFLrUqnuz=tcpU0NE-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] update-ref: use {old,new}-oid instead of {old,new}value
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chris.torek@gmail.com
Content-Type: multipart/mixed; boundary="0000000000008b031b0615178435"

--0000000000008b031b0615178435
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> Did you run t1400 after this update?  There may be other tests that
>>> the message update is breaking but that was the first one I noticed.
>>
>> I definitely didn't. It totally slipped my mind, I was thinking that I
>> only modified the *.txt files. I will send in a new version after
>> ensuring all tests are fixed.
>
> Here is what I have.
>

Yup, this should fix it. I've sent in v2 with the same fix.

--0000000000008b031b0615178435
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c0cb5552545d20bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTHFxQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL29iQy85Z0x6TUs0QWZ1Q2ZkK2M2S1lMOFlUMzRZWApXS2NvQmpTd3Ji
aFJDMUdtSnRNaUpDRUpnejQ0MW9EbFRvSGtzQ3UyTUhFOUhLTjQycjJjVTZEUWMycUV6NFZyCkhQ
S2VrWnZEb3QrVzQvNUpjOUJ5c3BjdTRVWFJoS3JCZXFKM011eS84R08wVlRxR0pWaEplQkE4SFhJ
a29xWEYKWEdMSHEwanJnQlpLaFQ0YmtMYWhQYkl0N2lrNnJJeDh2MzZkSXhqYk5TZm5ON0dRbEJm
ZGU3dlN1R25NVm1ubgpJVWY3ZUsyQWMwMW1TNUVqbE95UGlVVFRVaS82VUw1SmVGWmZRZDVTN3ov
K3RaTSswTWdkWkcvSWFHR2c1U2VrCjBWc2VIN2RnNDhSUDZrWFBLWTlOcjdBbVg3M2RIaXRVT1Bk
YUJSaGFXSlJReXpBbmZwVFpUaDJ1UWxicldOcUsKMXcwdkF3UDk3VWRaMWZhb2owQ29vcXJWN3pT
Z0tpeXB1STR0MUJianlKQ21BTUlxS2tHanZyQXBLbVEzQkg3TwpkYjc2TTNNZGZVRkFRWFp4aUlv
S0NoQTRjMWFHRWRTczN0azlGUWJtYTAyMVdCQWVGVVN1ZCtzSWorU2pIdldYCmE0dDhBQ1dCL1R2
MS9jdE5yZkJLcGxNejB5QktsZVdLd01KWUV4TT0KPS84eFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008b031b0615178435--
