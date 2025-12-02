Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F72F25F8
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714369; cv=none; b=IpqEnngs01HAliddmLJpwIbk9sidlloJhfCcF+cHHwEh8LrUYQLwKTHzpAqcmO0pupid78tk0MNhunFRiMWOF+/g9G61ePIoaPAFvnl2r40LL/uN9aoUbzcUL9u6LtYXyHidxwasexsN++5b1aTkpjbd4j3iWBjhXs4gHm2peRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714369; c=relaxed/simple;
	bh=NtTX70VPb1korlk9GbRDq5RMl478SMAUlytIi1ExpZI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XefzQVW61pbSFNJyJxHs5Bd152vfkQ4dYi+XXw5hcRCk4ysSaA/3OXk8othPG4PEeX8fYZr/UWZNKgEmq6Wxz2jRcV2c1qeENYjAtX38AQcY86gYEQ6R1VAuSaE8h2eBRUYwAI8kWTMFWzqAfk0/ioiCDgWGMFlrWSqEP3cE1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8fM4zcq; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8fM4zcq"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9351ed45fb8so1489287241.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764714363; x=1765319163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XpAHyXfyz1nlgKHoyekdrDwqTkRFIXTWCFSpOACl/w=;
        b=G8fM4zcqJfwsW3/sLxNox5uCaf0x8QRyI6tHgh5Mi41NpkKQqhWtq3tn77goitYD0v
         VUZoR82uQtP60HexNP3pINljTKNWH08+Jg5flkQkiQDCO86D1QZ1Gxg/HTk41qaT/0am
         4/95us+B1rwTl+D672VzjwSVwHTITj4l36XQRmElzjrnXRG+wQ8ahWBMlmrszHbqEfkR
         qSEhxBTn6vLtiXNAs7l/B2eEplfqDT8WorX5Z8n5T2FjgYoD8mZ31XrYfSRgXPIKvlV6
         WV2PAH3hgttW3EBg+GB5EHuo/Js+OFIzrbFTHCqG/SsystOqTY7RTD/3NgNaKyL+M/pO
         mNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714363; x=1765319163;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XpAHyXfyz1nlgKHoyekdrDwqTkRFIXTWCFSpOACl/w=;
        b=HM0ScAQfbevSpEfTG6f6svvFD5rC3vSF+oe4JeDjFcalFbhy4h9aeb6zXlWDu0e/+Y
         5FIA0V/4xwoUMBw2xVXeYqjxNPiGvyAXmI/+rmyKoUtusSUEQttYpV//PLFsawFSJ4X1
         Zn2x+TvkMkgMdzx9QWRxa0hgdUqcY+t51MLf7eb+epW/bXLEtE3QTF8sy3SMwu34RL+J
         uLldo3/ABMjDNHP3ifTTZ5KZ9tVti5XTgS+U+zLOECTrRa76aJye1MEJT5elMaest9Cl
         gDlYKtapE3AMZWiiYVFkC1MySPWt9nmBEwZJ+q8Tz6+Z4cxIw4wUIum1YWl6EMFydiGN
         5Amg==
X-Gm-Message-State: AOJu0YxXiw/wfAKJAvaP3lNxHMVorCVuGr3n5kEFbtgma0eTmmHpzU1y
	u9Dp4OVAznH86bKoYw3FrN0BJ7+V7+QWvUCXKu9RDtsGJR9mqn+4wuSlKAAxxK573oeURNhlNba
	YPEuEdRSCt7A1meI+2maktti5qviYe0GuZA==
X-Gm-Gg: ASbGncuolwGzQNGrIcRZBcWKUpNVv2wTa5Ll7g9KNGV7GaDYAHSGDaHmVQ1VJWW+SX8
	ofZ15UM6vbL6gEct6lnxhzsyWq04kklbr0IVVA2s5+USGVKTsog50ISU6ehmXFZhSRzYebqyb/X
	aPGVLxRS/z+QFpZ4ku1XiAqc1KOBxzGv6xU9cq7y6F70y4Ti/Rg+CpTP9vc4nazFmS8I1s2a5H5
	ASt4QekuD4bULwoDe4ITlEDzebx/6XoJETTunCwKg1cRXTYAVt7TsZpFRLtxZfwHuFWHwGMuIQZ
	WgGaUB1+GaRJhKwAnKGrTfMN+M6qOC9SsnWXkO3KjBGNeolmWw==
X-Google-Smtp-Source: AGHT+IGHMFFxSH0morw3ABu4kNOKT+/zkMt6gUtd4X0iVzdfzauBAW++xsdMcXxLqBHOXpPlZ5gLQz1RahtnGtZXf68=
X-Received: by 2002:a05:6102:3ca0:b0:5db:23ed:3840 with SMTP id
 ada2fe7eead31-5e48e40eaf6mr10723137.37.1764714362975; Tue, 02 Dec 2025
 14:26:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 14:26:01 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 14:26:01 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aS2Q4-U5kgJ2nNVv@pks.im>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
 <20251121-fix-tags-not-fetching-v8-2-23b53a8a8334@gmail.com> <aS2Q4-U5kgJ2nNVv@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Dec 2025 14:26:01 -0800
X-Gm-Features: AWmQ_bnj12N_4ukIS8z1aSKxykNMQQRDSZKKe8tNcJJ-O8pNgD9VTxYTD5wWEd8
Message-ID: <CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] fetch: fix non-conflicting tags not being committed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com, 
	sunshine@sunshineco.com, David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000bc54890644ff94e1"

--000000000000bc54890644ff94e1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Nov 21, 2025 at 12:13:46PM +0100, Karthik Nayak wrote:
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index b7059cccaa..4b113d7c27 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
> [snip]
>> +test_expect_success "backfill tags when providing a refspec" '
>> +	test_when_finished rm -rf source target &&
>> +
>> +	git init source &&
>> +	git -C source commit --allow-empty --message common &&
>> +	git clone file://"$(pwd)"/source target &&
>> +	(
>> +	    cd source &&
>> +	    test_commit history &&
>> +	    test_commit fetch-me
>> +	) &&
>> +
>> +	# The "history" tag is backfilled eventhough we requested
>
> Tiny nit, not worth a reroll: s/eventhough/even though/. Other than that
> this patch looks good to me.
>
> Patrick

Will add it in. Thanks!

--000000000000bc54890644ff94e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6135a7dbcae62085_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rdlozZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDBiQy80ME1LTGd2YzJTY0poR3EySExsbXNqd09mMApYeUFtQ2Y4aWJq
WFdRQ2E5Q0dtWFhwa3ZhQWUvVHdJalArZ0VxYko1eTZ2UktPVzNCcmVHaVJHTXpNdlZ1N2drCm1R
WlZqRUhscnRTVVVBcDhIMlcxdEhkUDZMQlgvcmdGMm44bFpyOXp2M0xNeEJxTU5WR0FIV1VBQzNa
WjVjYkkKMXBhN3pCQUpyNk1GRmpyTXNrZEZ2Uk5qejVkSkJEei9Hc3k1R3hQZUt1aTVFaGZBR25T
S1p4czgwcGovMUd5VgpJYXNmdXhzV1hLb3dpZU0yRDIyZm5ISFA0ZkdPeTgwS2ZsbDBSVExONHBr
WVVTVlZCTElISEFwZGMwRERMTVlsCjMxaHFuNXNiT3ZjYVJsVkZPZlk1V2xwQ04wQzEydXpLVmk5
NmVPSU53V3VzOU1EQVhDeHpXRHlIWW1rbk1oTisKMmlNMk81eWhyci9VNWJ5a3NFUURMRTRaNTlD
ZGJOeUlxMk1MMnBGZHlDTW5XU3Y2bStoMzBwSnFoK0dhbW1lcgpYanc2R254THZ1K2RJN1pNSDNN
dXpqVEh1SEM2bWJEWExLVmlJZGxXSDRGWG15MUJhWDA3LzVxY0xLZFJuYlhlCjJhb2lsWHd4K1N2
djFWWnEvWUM1cjNEdGRxb2UxVmovOTBEQlMwWT0KPXJYTTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bc54890644ff94e1--
