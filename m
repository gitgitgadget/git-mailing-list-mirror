Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE8189BB2
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991072; cv=none; b=HQhjEJGu/xg7uCaAxKMHVxdDNc6uN9qP+KuAirEiaE8ZCRbYbF/avHaqfw752Z2zo8yu6iXLJUMCmh4tik/GYouI6xUNM2ogQh3kGThOx5TbS/8/PNp5jaXf1cWBbLpZT2zOfz5vACYYEmL46DPnUoVfficOhTxGj3yhYw8hHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991072; c=relaxed/simple;
	bh=41dAnFZtrcAw79faDljlrJqjOHirKFJqoNxiLEJMnU4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNv64obVKGYbdcxBQNUdeJFdWx1HwpCgrnMJyv1R/MWCfJBGZaiYdGGZTls5qr+fx49CoisL7Be5Ii6GCM7kU+3ZnkNMkZapckg1ero7SRUwykW6+nJ59hyrF6Q+A9stCq09XQM80IR9s9+OPhK5KB1EsepW6TJ3zi6og1edeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Bl3Mah; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Bl3Mah"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so495355e0c.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728991070; x=1729595870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CleT4WFyq5e+SJAww5NNZ0L5yNjKcVSBf9qlvPpetM=;
        b=U1Bl3Mah5ZI37bAdQFqnaNr3vW3uAjTWj5i6bKKUcGW4PPk9m+luPIB//PT7u3OKu+
         +fmNVNbr9tqq7LTfzfS5dcK5JjFLtjDZWHMShR8sm07A+5UpOyLWgFqbOPg2LPSp+F4s
         JpQ5bnbJm5sqGkIqzpQfTMmuIMzPrCwNfeTpLXVK6GfDPH3faeAxdBaumbL5hddjeyli
         kykDuKuh019inINcLWLjOMqCnO3fg+9KhNqfqJWcpZl9K7MrIsAwP5GjJuaVSuYVvo6n
         gME1RKCi/q/d+yLv55lt/ZPmDc1MXb4I51SPZg1/E2fZuMrtFlT0A1e/8B3VNikhLGBD
         9Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991070; x=1729595870;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CleT4WFyq5e+SJAww5NNZ0L5yNjKcVSBf9qlvPpetM=;
        b=c7hG2McFSJVjF8Wsf43mC6up7rQY15mfAUOLbEfSQ9pxscYW4iivQjZ5lw5fXegDrq
         5R/wwQPuJ4NeeQAIRCiKJN8aleM/bTJkNC8gVzbFQm2NLyQRz0OzhPljFJiQRztRcbk8
         MIRpuhK9SWUYA38B8qBRuUE6wZd6AL9N3F1cVEDn+Pjdg7KfGoDJTVjGp2pTUrr5KTtM
         rdBgYqoKmUVtUJSzB5bN0togBJaaqY8+TS4IYV3udEi6u0r6YhNywMvIxb5SAIWvoYey
         eUMxJrmvDHWqaj7CGVKbXY49Mb//asCK3YsbYkHJnUlx5Z7SNAJ8OD/I4/eC/3oxf6LS
         D9EA==
X-Gm-Message-State: AOJu0Yw3fWekMMf3AdB3dQcTcMaaHNjx8+I1gnHhapd4Uds/kQccFTTI
	o7iWtWoPE5ay9qauOG6g/O5YrqTfGB5YkOs+mORcVfXj/M5iH/bKvrsWIORI3rExrFvpuJ9+oAw
	Ue1ow2xaoYbjGeRkFi6Lnp8BmtGfqRbGH
X-Google-Smtp-Source: AGHT+IHrzXY7EVPD32dRKLXa2mQGWZa/4DvqdXK3ikX5UlI1kunLW/0A7w20c/LaGubu3LptJJQ0fHLIvXcoo/9Y44k=
X-Received: by 2002:a05:6122:2003:b0:507:90d1:e91e with SMTP id
 71dfb90a1353d-50d8d648bb0mr71989e0c.10.1728991069946; Tue, 15 Oct 2024
 04:17:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 04:17:48 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_smVg8aVjUFixKOicCJqQgAGhrbVPa9Q9Z8+OKKM+Thsx2oQ@mail.gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com> <36a53299c1ab1b55a09b7e1d499832e6715ebaba.1728697428.git.karthik.188@gmail.com>
 <CAO_smVg8aVjUFixKOicCJqQgAGhrbVPa9Q9Z8+OKKM+Thsx2oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 04:17:48 -0700
Message-ID: <CAOLa=ZRZGhcKTWMApyuAi1Ec2_4F+QEDzX_MEG6PT1NEbRVbdQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clang-format: don't align expressions after linebreaks
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: multipart/mixed; boundary="0000000000008b9aaa0624821ac9"

--0000000000008b9aaa0624821ac9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> We enforce alignment of expressions after linebreaks. Which means for
>> code such as
>>
>>     return a || b;
>>
>> it will expect:
>>
>>    return a ||
>>           b;
>>
>> we instead want 'b' to be indent with tabs, which is already done by the
>> 'ContinuationIndentWidth' variable.
>
> Why do we want `b` to be indented by 8 columns instead of aligned? I
> think this is harder to read:
>
> int some_int_variable =3D aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa +
>         bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb;
>

The reason I added this is because by default editors will follow the
'.editorconfig' and follow the 'tab_width =3D 8' rule when there is a line
break.

This means more often than not, most patches don't follow this rule. We
don't enforce clang-format at this point so it makes more sense to align
the rule to what everyone is doing. The goal being that once we have a
good set of base rules with less false positives, we can start
enforcing.

> Of course, this is even better, if it fits in 80 cols:
>
> int some_int_variable =3D
>         aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa + bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb;
>

I'm sure we can tweak this with penalties ;) But I'd say this is
something we can tune later.

--0000000000008b9aaa0624821ac9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c27b2fc49b383728_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT1QxY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2gyQy85MWFpM21FdVJwTkxnY1NPZHNCZkJSUENIZwprTHlDbjVjd0dZ
Y0gwcEcrOGMwV3dWOFRjUS9qU093MW82VnVXSkNEYW1nc0hJcEJpTFV3ZEgreGU0YkVqb2syCktr
SjRST2IzSmtQRHBDL0E4L28zcjEvQTcvczBLRXhEcndCeG5aZ3ZCdmx0SkxiV1J0M0hNOHU2dDBa
K294anoKVEZGdVR5S0tNT1luTSs5Z0pMN2RLcW5aSjA2RXFOMnYrQk1lZmZqSnp4ZnhlUmlQUmFM
YjREMkU4U0xCNkt3SwpndWc4U1dydTlscjVpQzJ1TWptNXgyMWpUd1hzb1FZYjlVWUxOMkI0K2s5
MW93NzBJakl6bWZITTBnTkZYdXVFCk1BcWlib1B3Q1MrckU5Q1N4ZXVLUW9NVVp1d1lzRVZhOHcv
VG4xdjNPcEZBUGFRY1JyT3cwWkxTVC93SHdWci8KV3IvbW0wRkhnWFRmMzFPU0EzWE5mQmI4cWRE
a1JpNnovanNzeDFET00wRXRnOGZ3RkREcnZlV05SUmJTdWkwRApraTA4N3kvMjlQWXk2bVVLY2RN
YzhxOHNtNjRtRzFUY01DUmErcU1SQW5kR0E0NXNiWDZOWGw1dlV2UkpDVm92CkdQNmdsY1dJSkgx
ZmFvWmlYT2ZsdmJ2WmdMTEM2SG5NT2pFOEtYRT0KPStjWmYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008b9aaa0624821ac9--
