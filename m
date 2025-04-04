Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088D1DF98F
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775255; cv=none; b=A6rDrEemXkHxN445zX/KmqrBoOmAQ+fA9QctDRd7GpT0d9o+eMle1mJVA5Hf8oQDBAGoZiSrOt8Oq5Oe4N/GEEU/dzLl2vi0UDRk4YvYsgr1Ms80sToQ3B85iSqT3QYXFvQrYFLZ3CdMZrPDtY98JcFmoV1dUR30IiLRb/Chczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775255; c=relaxed/simple;
	bh=abZteG/XkxlWEwosK0fdIF1rfdRKJ0yI4WfgxIWEGbE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX7p5oyrq+iO+mrg2CgQXsnj3a+ufORYvsXVVUEgmV5qeGJzAM0hjjxNoNrc3IMJ91s3qYOtYP0jslRPxEIXvgI7ghIFvtoiIVrsHcbAdqUqcCj1jyk2/fnMwHHQq3+4DAOSNSA3RkKYFKzfxqBhoH2quhZClhrBSKlZj2bi/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOlQcIdI; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOlQcIdI"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86feb848764so946211241.0
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743775252; x=1744380052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=abZteG/XkxlWEwosK0fdIF1rfdRKJ0yI4WfgxIWEGbE=;
        b=IOlQcIdIf/OJ/Th94rMAo2tCH87iKfsNJIR8CzCAkK9VMUu237YnKhsFKuxxSsdpKW
         vMQzz25MBTewlhU7WhDGHQHkzlJRw3eK5RG2ow6Wsqum46UiIowxcVB09Qnz2JRlpIMy
         /fHniaaXbSqzDxijjWsmhzHybg6OOzrCdIXhu5zqJYZGuSrT08EEFpgVvWQdkvWpzLTq
         FSe/7dnd1Q9ZiONm2EUPBf+omtfEeTftWfb6Yxnqztx4rtpl65udOwv4/wbYIK/NOrMI
         Zcz6G3CEvgyrql6TZzncPWVIUvhkBurbq6qvV5USLaL+pRMTRSSKC3Vv/btIzp+w5NAW
         NmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775252; x=1744380052;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abZteG/XkxlWEwosK0fdIF1rfdRKJ0yI4WfgxIWEGbE=;
        b=sQcjFjZTpWNhPtHsr125oOQ+8rpB1TRbtGD8UvOVFWFIAfe2qqqdWgZ53Eh4lK/tzT
         ZmiG/jf6fH1EtcrsFmjxk24BGvicdDXi7JURPNz3M5PHFz0/xM2npZMPAmrhspaqw6XA
         /2gB8eARqjps6so1sScckRRFru/ko8LWlANiEWf2j/6illrAeJ8ZoWlHogd1H2pjts1x
         E0Sq/yXS6gc0YwFtQ5HgNzUu+sgx99MD1e6IQEWjo07i8ogmvMo+s3xEofqeNXug6mFe
         I0JbDBQwTxKTY8NvU0uhWTGlw/Iz/oPt8XwEbSZ9lgaZadsehdO0GeXuJg/G3nwtOcPp
         dNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbMOqjBEyVJ5tJuuJvaYb1A6lAjux1k1uJR2WuGeWoakMtMoqrUwaFdRqKjPM4vQP4gJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNoBT2YbJjTlDYo5QAhZ8GSrt/9xpqhgbf2YPhWonPZoxv4lf
	6+4aLnuJomb4yplSjtwcAu89yYfes/DXCXhE9BiMm0O2Bs/+n52SotgUCTvJTEHMmW8Xyea/nhX
	Jxu+MyFeStnk3rgPbL+C+BkTelhQ=
X-Gm-Gg: ASbGncuol+t+MpcxhyfzsPAksJ0IQBO10FBcWcRDsQszB5pNX8OlY+6iQw58vGgO/Og
	6kMTStwnrq3D3O2Uzoqjw0XodropyIT1CqNy0pKBgzcuwLlFVbMIegtc7SyU+1OLO5aw1h1YwFB
	JqlwefUoylfA9l7eHyUTzpvlqDDTNSHx2MBiCi0a8s+a/V/P+9yAOoFzYrplBnOI9SaHF/iA4=
X-Google-Smtp-Source: AGHT+IGQAFMxGdP8KY3sFLB2TI0K0iFovknxBfu+kneCefAUm89gcyxLvZrmVWFcB2iB6lmb+ve6ihQEiR6cuGfz5M0=
X-Received: by 2002:a05:6102:15a5:b0:4c2:ffc8:93d9 with SMTP id
 ada2fe7eead31-4c8568c12bdmr1989278137.9.1743775252429; Fri, 04 Apr 2025
 07:00:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 07:00:51 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 07:00:51 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <PH0PR07MB91768A0AE333B30ADB1D39E087A72@PH0PR07MB9176.namprd07.prod.outlook.com>
References: <PH0PR07MB91768A0AE333B30ADB1D39E087A72@PH0PR07MB9176.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2025 07:00:51 -0700
X-Gm-Features: ATxdqUEvU7p6p2Z9nJhSMSTsoLfxOVYolbFb-PGIkUuisgYNJV_Ke98St2h27_o
Message-ID: <CAOLa=ZRmwSmFB1vTQ1+usMqbF0RHGF_QtboaLas6h-ZzKh34mA@mail.gmail.com>
Subject: Re: GSoC 2025 Proposal
To: "Tatarinov, Daniil" <dtatarinov3@gatech.edu>, "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "ps@pks.im" <ps@pks.im>, "shejialuo@gmail.com" <shejialuo@gmail.com>, 
	"christian.couder@gmail.com" <christian.couder@gmail.com>, 
	"shyamthakkar001@gmail.com" <shyamthakkar001@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007d67990631f45021"

--0000000000007d67990631f45021
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Tatarinov, Daniil" <dtatarinov3@gatech.edu> writes:

> Hello!
>
> My name is Daniil and I am a CS freshman at Georgia Tech. I prepared the =
following proposal for the following project "Refactoring in order to reduc=
e Git=E2=80=99s global state" that I'll attach to this email. I would like =
you to give me a feedback and critique on my proposal and just express your=
 opinion if I'll be able to complete it.
>

Hello Daniil,

One of the expectations for prospective applications for the GSoC is
that they take up one of the microprojects [1] listed.

I couldn't find attached to your email, and since you've already sent in
a proposal on the list, I would also recommend that you do complete a
microproject.

Thanks,
Karthik

[1]: https://git.github.io/General-Application-Information/

> Best,
> Daniil

--0000000000007d67990631f45021
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2d9a9d5789f3134_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdjVoRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODliQy85T3dkc3Y0UnBBdm1uOG5KNmRJaXJwYkZiSQpqOWpnZW5MUXpy
cmdQUk9kSkFWTWQ0M3RpQmxGZEx4NTZNYUZOa0pPTStGQk1lNkJCTmNxREFnTTJkZFVGY3dWClFz
ZWJoRnpLdHpZQ3JMM2wxQ1F0SjZBQ1F3ek54MVJzaGQxbi9vTjVLVXFPTE4xQjdqYVd6eGpuSExw
Tm54ZlQKNTUxc0NzNjcxVEh3cExXbGw2VUZRdkdtQ0dPajNYUzhKNS9xM3YzdUFkNDJjT3JyVXdt
VmpZT3lPcEY2eklHTApBWXEvaVBTNWZ0c1FsaFFzcmI2di80TDI3ZnBRRUtPRmZ4dXQxenE2NWRB
bU1JOGtGV2ppMmI3dlgwLzNzejYrClcwZFd0dndGZk1oVWJKMGl0alljZ1BnenpQdC95WDI2eDBH
YmRLK0NiMUFXL1dRRmhEVEJlVE1tZ3Y2RXJDdFUKWVFzVkloMHo5YzJaV2tqM2ZPdU52UzYrRDQ0
b1hrUzVQcE1KbEF4UVhDenhhdEhCQVc5UnYyazQ1c1U4Z0s4NwpWVWo4c2JjWUcrVXdZWFYwUGZu
UEZ5Y0R3V3RxLzFRZjVuTjlBVEgvQnlsRTE0SnlPTXVuOCticjNXcFl1Z0hkCmN5YW83b1QwUVBK
aGVpWVNqSHpEUkptM2gzV2tZUU0wbWlFK1ZnUT0KPTFjcTkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007d67990631f45021--
