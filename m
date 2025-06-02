Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA4223DD1
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884393; cv=none; b=nGw72HOf659s3ZMNhMr/72FRJO87bdKQBHOu7PTTysr9rJyUuttow5Glj/nNc45/uXqRIAxm8v9ELhS03lQTekNtftdSyF3cf1VpW5wOHDPq11t5C13Q8eN5amyLPBfCp+M/89vYJ2bysfu7nOdDrSs/BwMgSdH+3fPzaTahRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884393; c=relaxed/simple;
	bh=a7MQRJDR7Q17S9BUiI7sFuMWKK04RYOL/zDzdGeoZKY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXU/OTHM0F6I0/MKIQYSRHJkGjUjG0GcVVGbsVnoJRTWAVivtbKg6IxUdzvj3jMYXLCbaXZQcGQNzi6V1c6apBkK1yZsfTX5+N6MJmTM+QGUBc1oyDrFDjfOx6sJWDpKFR8s+xf2FeYuFGno2cR5DvCMNU48mBvrtulugxfTUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk5djndb; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk5djndb"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-525b44ec88aso1486108e0c.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748884391; x=1749489191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7MQRJDR7Q17S9BUiI7sFuMWKK04RYOL/zDzdGeoZKY=;
        b=Vk5djndbN5HsDPYpzymXBvshhQfqZAF3dArlOq3noh4uSJanm16Ip4+LdKoejNeY1H
         sOCDHkKRBsK5+ovkYBFGc+0qf9BKU+xsgLv1O5dkBe95CbL+8mzcZfkCizqVOrf9pnLP
         t+BfFlTkRAR1gOYTt8GU0f6r/wz7H8zrPRsK1c8Bgvn9iFLn3XH0P2wfpSJIo9RfgHvG
         2drWBUQF9pmO+yqc4+zgxvTE5Zqyfb6K7IJezCWQpixju+aC4mm4iYlgNn10PQfRyjZZ
         4jMBKtzWDwlmWg0qzypKdk/6NvyD3cgBQMMIsL4SOgyFk1OQgwef4s9C0y86T+3L8rkY
         dEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748884391; x=1749489191;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7MQRJDR7Q17S9BUiI7sFuMWKK04RYOL/zDzdGeoZKY=;
        b=dlQiJK6szZf0mQd7UBJGoAD7Xvi/r8AAUJJsnmS5vHw9wj4S7NpUvcFw9iHdLDONC3
         uqJ1TwOPsC4q2vcvXtEDBWs1FzhPPQLLLpWS4lM3Wqvi//T255w7UbRoujLdeWL58jjE
         tzLRx3ZjQdJ3TH4vWLWIXFpk+LhUGJHva5NHuq2aaG1ChoPz7ll+ipNB5JxJcLNP3Zxj
         9MkXuLO3Ci/prHtUmC8H22onWH25zmVA/Ar3XVIZXNVIo80GXOOrdW2s8CP+xVsGHKfa
         Eh2PGHzJgmU0HtLKsI3P3Ib1SyB1za+zOsNGYvAmyWcYQTt+rU84r86YisisQJVzhetn
         plgA==
X-Gm-Message-State: AOJu0YySf5UQqi1B5OQtsRG4Hkj8KHbZVbxoOa5kfFKF1T6pJSCzo+kC
	Nm50JOBXfjLj5I5P+LDzl7lUq/nxsiE7bMl3KE529reLmTr0iM9B9HyQknOEVdrkiaDcrHLiu1M
	ImHOwNhkzn3NnarESpP9FY9eL1Bi9Up8=
X-Gm-Gg: ASbGncvY7bLLvToDCmhXCPK+VxRBgjg0+CGWiQjyUWQSS42qhKQLwK9arrLLv5lfBy2
	zgD4KXdhKvxaaV0J/ZbeyQpNBDgfjWZvFkjCvEU69V0L1Aj0ayatT3XYGi2BS/2bKyLO1i60XGs
	NhkTwOW2hokRtQFy4XMGpoEfc9smfqmr7s2bfSzabcOmizKIcxGps/1kwuftT3P7UbSBT1DvACO
	aNz1w==
X-Google-Smtp-Source: AGHT+IGa5eg+WYKNm+DswS3hyAGscLxRryAHslH/ZAUdEonDEMQh3EvhWv1kaILEf35kLsm9eAZX+faQn9LrWwpgVeU=
X-Received: by 2002:a05:6122:3c8d:b0:52f:4680:1c89 with SMTP id
 71dfb90a1353d-5309377b27bmr6380948e0c.7.1748884390869; Mon, 02 Jun 2025
 10:13:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 10:13:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 10:13:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cTMDcvwfzq7Pqn+MF7r1x7qZq2k=8pAV3bio0pcnuh4eA@mail.gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-2-903d1db3f10e@gmail.com>
 <CAPig+cTMDcvwfzq7Pqn+MF7r1x7qZq2k=8pAV3bio0pcnuh4eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 10:13:10 -0700
X-Gm-Features: AX0GCFtXYYbNBVirXrf-UVzFFb8XVf-iG4bIhs9RMG7bMduUZI4I8U2TPICRBkg
Message-ID: <CAOLa=ZTp2F8QNg10O3SvGuje9MTZ5=RChcJ0t91MSNjLJF+m+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] t5516: use double quotes for tests with variables
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000df3ef6063699e0ea"

--000000000000df3ef6063699e0ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jun 2, 2025 at 5:58=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>> Since expressions don't expand within single quotes, change test
>> descriptions containing variables to use double quotes.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> @@ -1421,7 +1421,7 @@ test_expect_success 'peeled advertisements are not=
 considered ref tips' '
>> -test_expect_success 'pushing a specific ref applies remote.$name.push a=
s refmap' '
>> +test_expect_success "pushing a specific ref applies remote.$name.push a=
s refmap" '
>
> If I'm understanding correctly, I think this and the other changes in
> this patch are incorrect. There is no `name` variable in this script.
> Rather, these "$name" instances are merely illustrative, acting as
> placeholders for the person reading the test title.

Huh, you're absolutely right. I think I did a 'grep -v' to ensure it
worked and failed to realize that my shell was replacing $name. Will
skip this patch in the follow up.

Thanks!

--000000000000df3ef6063699e0ea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 381296e8d79bc18b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nOTI2UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEFpREFDSmI2Rkk1S3kySTRLejY0N3Y2RENEVjIzVgpPNFN1NFJkTEN0
VHl5eWQzeTRPbHQzajJlTU05WHA5aVVmL1JJTWF5M2svTFU2MUpTNjVqQTZhYWpKWWRySHVPCmo3
cXJtVFlaMHkvUkI0TE1Ja3pNVXZIL0J1ZktKMzZUaFQwbTRPME1yaTE0ZURrRGs5bG1QellLK1Fp
MWFlc1kKMHlaZTg2dGRtZytOYUhQOXNRazg5NGI1Z2N2ck5WMHVvSHd3bDBDZ0JoTTNKZXlXa2sz
VkF2NWhSYXpJSitDNgpPdjBvS3pMR01kUkM0RlBybTJYc1FUOElVaVduOTAxNEpZUmI1eEd6bk5B
T3VFbFBHRGJSWTNVMmFxTjVGc3dZCjRJSWxYU0pDUFBpWm5jZG9uL2JFVE9meVBFTytHelM0VzVR
UjBJN2NRYW1oeVJma1BBRzhNc3ZsaTFZQXgwSXAKNW5vTEtLYjhZK0lIdzY5U0JZcHVnc3RhdEhz
d0sxcUFEQU0ycVFCRXBYS1ZLMFV5RkZocmFGLytOVHVkMWhiUApIR1B0T0JwT3lVejM0Q242akk4
eTFSenZwc1NEd2ZVS3ordnZJbWFyRVc4ZXJTNXZxb3o4TytUdUZPTUF1MjE5CnJGZ2RZU2JVN3FQ
SzhqMG0yYXJIY3RpeUtDNmZ6WE5CaXJQL3I0VT0KPVlMZFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df3ef6063699e0ea--
