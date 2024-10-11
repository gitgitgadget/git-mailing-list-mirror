Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C531991DB
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679409; cv=none; b=H/44FbnVDvFjKbAODtpUFHc1Kiart+pjP/y1zVW+vnUmvhS5mnzL87ZVCFoG3AmCiSwshZr79ivCTSHDwBDlRruwEl4K9RIL/apC4wjFtph1OWDdrIDxf6u77N3pUiiJ7Zg2L8+yGN5mf39snvEVGERmsWYDc0A8C+YMeIb/NBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679409; c=relaxed/simple;
	bh=XTejNXLGtxLPQaodYV8h84wtDRlsqWcO/KRnIA329ec=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXI6Bv8hChr+CQ9iYhd6SSh7U7b5BE5EXRYDp0b+T1ikJKLDKSriQjwztQr3M8gQEYY97KwBj+0vYiCNUODMRq/uY1YlWyck+31hwNfiaY6lI8CDRxcbxjop3oGAhXTpJfmpUZUdveIErTL1gAgxecOvEhptJNZGMe0aYlCvsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNPLJ689; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNPLJ689"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a47177cf6bso214748137.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679405; x=1729284205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6oUCNL6f+NGqS/fXSgDIIz5HKUxtKqUT+n0LXkP9cw=;
        b=DNPLJ689z+6kgV22dpG5+UgpMhvnl+IY2gc7aOMRCOB3TT73XzPM7wP34be64LyRKR
         vS63kMYzZNGrpDgDSjLSRjCkGePXu3iHsFmoZ91tfRCD66/z3nc+XXtcGqkD149hs5/a
         9lcXUnLDb17HIaLYHrm/dzX3lLtMCkEnRxhxY9A3jWjaERhgLOLrwfaQh/XfpyVYXLAn
         rTZsJ17u/Yt4vrwXwzLQQLEyXeuE/Bv+J3YHejDXC9AnzNCn+quTK1fe1eEldnESCNMt
         ydtwTJVszP5j3YaakX5lgAm/m7Ah/LjFVoJ+yZWs4z+RomUtrQ6sFLJNW1OEnsmQpjEp
         EKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679405; x=1729284205;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6oUCNL6f+NGqS/fXSgDIIz5HKUxtKqUT+n0LXkP9cw=;
        b=HsxeitXEZ1DdwWn8JLCr6LaQ2rddr6Hu0Yiq3r8HIfGNfIL+16ETCSKQOIiRE6EXMl
         bdVzR3G2SwRHt1X44cSRFhy13KoE8rnoPd0M9KdpQgi6/7w7JJeJc1NMpjQ63SczhwP8
         Lh2jrGIZb7qUBuOEHMJuavfRbzabfZD39i9xyampPApYxfRZ1VdW2lvgYMWxU2ccpZZ2
         3WWTsGFIrjojMBDL3JpiCGo7hndjdxPaf/HsHdvsq3iMZE0mBvtLQ1y02EV04Hr3TjTb
         9UvDZrlEeVnqL29f6u3RBxDq1oWLonOtVyQbWk0+IueysSVBcCSrXUXLTXL6ReYurUhC
         9uAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOY5ErHrYg8Jh8kS6QAjtxc3eMxi3iBKYI6AzOAQimU5hREsd53dSpfygwT+F6GM8Cr18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrS7NXXFlVQzMSK51ad92h7kgCozTXvKzNTB5Y016BnAKYohd
	zFJc/FKJxC/4EX0wXrZ9Xcw6VRlhmIsoIyssohn3bfy+L8xEmL2e6xpDsesDhhxl/iU1Bt9Cwur
	tHS16rh2WiAb3isYS3oORfu+MxXs=
X-Google-Smtp-Source: AGHT+IGpuXfKghPW0h/FKcMjQnhEBa+bReUy51zBexnm+lmZ06SIXlt8ilECYN6EOK4DK+rvjDX2gkUAPpXk604tN6I=
X-Received: by 2002:a05:6102:4188:b0:4a3:f9e8:2fb9 with SMTP id
 ada2fe7eead31-4a47600a7f5mr1215685137.24.1728679404735; Fri, 11 Oct 2024
 13:43:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Oct 2024 15:43:23 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g> <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com> <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
 <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 15:43:23 -0500
Message-ID: <CAOLa=ZQY_a_dEZQ2EcLVfE_5Kjy7b2R3OFbQHQbkzH0o9-q1JA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000d9ac910624398949"

--000000000000d9ac910624398949
Content-Type: text/plain; charset="UTF-8"

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

[snip]

>>
>> > +		git remote set-head --auto origin >output &&
>> > +		echo "'\''origin/HEAD'\'' is now created and points to '\''main'\''" >expect &&
>>
>> Nit: might be cleaner to use `${SQ}` here and below
> You mean something like this?
>
> 	git remote set-head --auto origin >output &&
> 	HEAD="'\''origin/HEAD'\''" &&
> 	echo "${HEAD} is now created and points to '\''main'\''" >expect &&
>
> I tried a few variations and this is what I could get working, but I may be
> simply missing something with the backtick.

I mean simply this

    git remote set-head --auto origin >output &&
    echo "${SQ}origin/HEAD${SQ} is now created and points to
${SQ}main${SQ}" >expect &&

- Karthik

--000000000000d9ac910624398949
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c8af0b574f95bf4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSmplZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjg2Qy80NHFabklrN0FDOUFoa21kd3BOQUFEdll2NQo3aGJwQUpTNXli
NDAvRE5uUjBBSjlPYzl4NElCRFB1OFpodUt3Qm5JUEVlaitOaDl5ZWNqYmFxOVRyU1BWTVdzCmNM
NVpDZ2FBT0hxMS8yeWlscUxWSUFmaTQ1Y082N0c3S0dlZ1lyVmh3ME5JVDB4eFZvYWUvQndKUmw1
ZWV0c1EKN0N0WWc4UlF2N1Bua3c1bkVXV0dsUy9CQjdwTDZGU20zUjBNWk05MkFZbjI5dDdseHF6
NUJNTm9hd0VTMExsZwpNMUtTVjFsdEpXOGd6OXl3Y1FRNjdpSUJMYnY5TWNZWlJrK25XTExzTUZK
clRGUndCc3pFZXgwRjd5WWNQblhCCjcrZ2dpVXNJZTQvVDZ3UUs3SUFXdk9tRzRSTXA5bS9abS9x
OXZMSjhRTWczenhMK0ZJU0RkZHJkS2UwTUZBQU0KcjMvVFBDWmI2NDIvTUVpUlZxWTU1SDR0aGhS
YmpRWDZTNkd5a2VUK0g3b3RkZjJpeGNnRXY5TTBCV21XNCtPRAo1TkpYTEZjb2xJd2RQL2IzaUNC
RzFLbDY0RmNqSkFOeHp3eXFKRDhWK2d1WHdDUXJSaHNqUFljSExDN2YzbFNiCnJ3M0g0OXVnald4
Ty9NVSsvOGIvdGFCNjlnSlNFeDRMZkJZc0pOMD0KPU15eFYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d9ac910624398949--
