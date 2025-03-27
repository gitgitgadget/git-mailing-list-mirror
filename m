Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0E210F6A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073625; cv=none; b=Pm4pwi/dfnSs4Iq3pzbGYpkr7bNF4djpatp4nNAT2y1BfpUW67WWzxD5wUkv+fGaEnOymV730yaHevQPF0vsOPn977lACJtlPQjKuvKIa8xrow6HghkEPgrCaV72WKDOIHOsPXzFcd/EWI5/QPHsRwP5CHsJOyHFbTn0OWpNqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073625; c=relaxed/simple;
	bh=ojSNkMwjMt9aD5vAU7CBDF69uILjVXmVLG2YcpgBSMA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFu1Y3+dNEi+4Zhz7TCO2qx19XTcWdJ2/nRVGSQONPjt/Wz1YUJqcdXT4C2aPRfDrT1zoxuYU7gYO9NWndiK6es1YQ0lyrpoOl/X9vSvfVLL/DGphJIxvOLJ51Prq9Jzs8T83Dw/GUE02BkazlPy54PlCpPWe9n3rTcbu1pO424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6Mwo7R4; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Mwo7R4"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so391601e0c.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743073623; x=1743678423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZJzyWcHjGiMgj33JeAuTS8IGLS8Z13wkq5DCIulMKQ=;
        b=l6Mwo7R4nZ7AZVRKDAgtg+IFUd2PRKmROjlwrGyl5lQhjm5TFLu96U+aA/gl1mZK4A
         VX/QE60d4kwIA/of886O46ZjSd5jps+pXrbNpMJH7k3NsExhqBTujNpRegcZgwh7BWhf
         GjMu3U2hU7jzmfSwVjZOYt0ND1wuptRbruI59+iAiEejlq52hI92+TXF6do5I+qpeYJJ
         1oChaZ70BxSXhNuS+fKyWYJvsv6kKDyQsjvH0isGaufPrGsdReFO3UpogmQLLfRBO/Tb
         AExPS1T95WiTx0NDQQ8IPH963Y7skimMoTDmKv4qHfMdcgFw1EJhuNcV3pBvqWOTBrGY
         yDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743073623; x=1743678423;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZJzyWcHjGiMgj33JeAuTS8IGLS8Z13wkq5DCIulMKQ=;
        b=Q0hqn99EZcqfRmqAWnOtogCKcYEECF8PDXdxe64LKChMbPNl0Nkg6/R66rf+A7OoUh
         Ok3KyRbcbit/0nfnPP9OtujjCJjefByPK3jB5o0smuPoGzPj+8kupwTrZWnlJAk+P5Rm
         vSSnlEccDUbc3agPGC5QC5vtIinJY6/xyM8M3w1va+CdKKQHocnxT/1jWz8pu9SEk/34
         dmmmVMqabLenRJ8u3J9xEMDTgXJpRFzS2vEfpNn32lum0ZkG/QHDFMGFgLvIWbKFzQgb
         KeHNxTeTdpaZo7MPOgJh09k2suaIc6g6irDZz0HwTYL28hLjJ6/kP652dGRRpqHpMbvM
         2LcA==
X-Gm-Message-State: AOJu0Yy94yRbERvzYq6OMS+DPKrGbZYHSRZkNLDbk9RGVlUmtBMNWOhZ
	WkUFkbigoGw2yxUW62WbXpCc0raaQ/HBuHOGhiNE8RqyMtHcrQkWbxDMzh5/sxb+sIPD0lfeVoh
	n+M1YjANlz01Pxf8ro6L10CWGR/8=
X-Gm-Gg: ASbGncuPmmkz6HssUr0crSDBzYCQESUkoqCMddknejUd9WauK5Q5y0JrmroLh2z2sGj
	8SLcWIKSoBs2D9veUd22aBjvQeDdxkKy65bdLOnQS5utN0mwuETIKf7+zwGgHwaa/WImgWu7TX1
	VOAQwgCDIv6CXWbK8pGeZ6BB2O
X-Google-Smtp-Source: AGHT+IG13KhfvK2OEYOFmNk0aviu9tCmzDE9gW130defWlViJsaZMkhj3MyyEVp3Csl5vTbmbAXBT9GgtGWCkpttZEo=
X-Received: by 2002:a05:6122:308e:b0:520:43e0:8ea0 with SMTP id
 71dfb90a1353d-52600ae326bmr2146410e0c.11.1743073622611; Thu, 27 Mar 2025
 04:07:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Mar 2025 04:07:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cRLXDohGG0RLpC41hy=rTmbmNQ_qScFWMv2LP8pdM8_hg@mail.gmail.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
 <CAPig+cRLXDohGG0RLpC41hy=rTmbmNQ_qScFWMv2LP8pdM8_hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Mar 2025 04:07:01 -0700
X-Gm-Features: AQ5f1JpkwYn7UoHwoz9F8NrRB173SdGKM2ijhD3HRizgbvGWN9Ij0qnWPgu7S-U
Message-ID: <CAOLa=ZT8VjTrJcVMYtCK3+8Rt1h79GPKdNr4OyKAJ+57a=EHDw@mail.gmail.com>
Subject: Re: [PATCH v2] blame: print unblamable and ignored commits in
 porcelain mode
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, toon@iotcl.com, 
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000017f764063150f4ae"

--00000000000017f764063150f4ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Mar 26, 2025 at 5:07=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>> The 'git-blame(1)' command allows users to ignore specific revisions via
>> the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
>> flags are often combined with the 'blame.markIgnoredLines' and
>> 'blame.markUnblamableLines' config options. These config options prefix
>> ignored and unblamable lines with a '?' and '*', respectively.
>>
>> However, this option was never extended to the porcelain mode of
>> 'git-blame(1)'. Since the documentation does not indicate this
>> exclusion, it is a bug.
>>
>> Fix this by printing 'ignored' and 'unblamable' respectively for the
>> options when using the porcelain modes.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
>> @@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
>> +for opt in --porcelain --line-porcelain
>> +do
>> +       test_expect_success 'mark_unblamable_lines with $opt' '
>
> This test title is going to display literal "$opt" rather than the
> intended option. Fix this by replacing the single quotes with double
> quotes:
>
>     test_expect_success "mark_unblamable_lines with $opt" '
>

What a silly miss. Thanks for pointing out.

>> +               sha=3D$(git rev-parse Y) &&
>> +
>> +               git -c blame.markUnblamableLines=3Dtrue blame $opt --ign=
ore-rev Y file >actual &&
>> +               test $(grep ^unblamable actual | wc -l) -eq 2
>> +       '
>> +done
>> @@ -191,6 +201,16 @@ test_expect_success mark_ignored_lines '
>> +for opt in --porcelain --line-porcelain
>> +do
>> +       test_expect_success 'mark_ignored_lines line_porcelain' '
>
> Similarly, this is going to display the same title for both cases,
> which isn't as helpful as it could be. Presumably, you instead wanted
> this (using double quotes):
>
>      test_expect_success "mark_ignored_lines with $opt" '
>

Yup, this needs to be fixed too. Thanks again.

>> +               sha=3D$(git rev-parse Y) &&
>> +
>> +               git -c blame.markIgnoredLines=3Dtrue blame $opt --ignore=
-rev Z file >actual &&
>> +               test $(grep ^ignored actual | wc -l) -eq 2
>> +       '

--00000000000017f764063150f4ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2fbe8517e9af8c2f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mbE1WTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTUwQy8wVVQ1K2txTXZXYzhlNlJxcVpIaU43b3dNVgo0N0hyS0RlanVy
WVpIYld3bTZobWZ4c2UrTG5LOE03d3p0b1ZIZ2NqRUZTNDdabld5T3RUWkE4ZndFUENKVTVrCkdq
US9yLzRvZ253RXYxUmJtQklCRyt2bGd0bnhnZVNpZVhJRXdyMjhiRFpwbUQ2aHRMcTlqbUh4WEZZ
YWJNZ1QKdEtxbkZXSG0vSWdBRDZIdUxJY0h3NlFwUWU2NWNRN2RWM2ZWVVNWaW9rR0dRS3lVcC9p
UUhNNW9naENaY3JQUgp1dk1xVzZWVitCOUVDZUZYM3Q2RzZJdE1iK1BNSDA2MWFkOWc3MjRibUkv
My9rLzI5aHZnaGliS2FaaTF5V3c2ClZUOFRLUmtuL2gvUjJZUStzazBRa2IwWTRSanZCb0JYdHFu
Rmg0UTR3eDEyTGZKRWxqVnFVVXI4NDJDR2VFVEUKQmZOdXI5MzdqMDhNTkx2akRMTVZxSDFzWDNZ
azhkYllLLzkyd0dCZjRiTzFxTUhXSGxaYXRnbXRJWlNnZHFlTQpmam81S1R6c0wycjhmUFN2Q1M4
SFNlRWF1RjZ6ajlSalQ5SUZqSzU2alcwWVluSXJaOSt5THFMU2hoRmNleFA1Cm8yVDBLN3dqSWdh
OTJPaFdyUm5LcVZRWmQ2OFQ2Y3E4MHVDVXFldz0KPXFXRjMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000017f764063150f4ae--
