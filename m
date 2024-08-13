Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3717C228
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544257; cv=none; b=nwPcjYRgHeHK2mP4Uji3Zvk0NuFpi8QCG+Pb1nO/yE1AWAu6ftZvFnQpGw7yIrekGnGsYvLLNNAeM9uMzV7fcYki/v1WaqgzmScp9erFDYQ1FrXb7+1zjsFxnmwLOeKR4I7ynFYPF2xbXHYwqe+6Pk47RZ/ddyqkzLtU9zT/mso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544257; c=relaxed/simple;
	bh=z4wghsuN72IRpWKOdS/6wQOtORUTHSPbQNxho3Zs25o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=aC1bj/Udj93abfuL5ek1nD5rIrYKnhyUIqJONRGLT4bphQBImtyY7dKRVFy2ItIm9RooHQXLNB7VaDR+CK2l6IAsyuj2XskXpSxaediSY3HOPmEbO/FWE+m9qvUXUqTERX2TrloNXJRp1ohT8wCkq9vS6FtoUHS8nhlp8rS6nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYwjGLcX; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYwjGLcX"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1270da60so4099914b6e.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723544254; x=1724149054; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4wghsuN72IRpWKOdS/6wQOtORUTHSPbQNxho3Zs25o=;
        b=KYwjGLcXwC9ct801slKy96+RfkvE7QdifX9XoXqsFmqxIvlp1D+QQV3kMkCi323R5s
         SeymtCIEXcV/I4+f7rG3QmCIE8cZIkDUVEAmTWNYI2FfV/1blPyVCkNn9WgE9fttW+by
         PTDNbXFqu2t6TIlFV/JFAB9hp/mplsL2u12SrRnXPOhBFqyagxJYNuTBLMS6OYZNlzD2
         XoVMRTFrfxe1nPREZQoH56U5ALGGvudL8sLmITsZcQVcNR+jjTmY5eHiWiWH0RUYXP5C
         PXLBS3xbKtVykghSHQeE0G1ymS32JH1wQdbLecdq68NzK3Zp9AkP77SyZcME94ROzeD6
         RM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544254; x=1724149054;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4wghsuN72IRpWKOdS/6wQOtORUTHSPbQNxho3Zs25o=;
        b=krdavyB6hqTYFtmrMSyD+BzpmL7tHJd70vZW7RR5m3deFnA3ULb9Z69VyoUDYOQBb7
         e46sQjbCkjuTOcJv2rDFZTQVbiwQ7zEK9zSwkcCAgIYSfyFC0+r/jXPSikzXAUbuvXBO
         OnIdQdUAU8gYo/G8MKGzQGEFTdIa/uiThKMhAxuq0ArEaf6/PgjeRoCf+WLNK5IrRdHD
         ZozQkebLwLblsfSvCPKCl2fbYQoFDjuEtcRFeNliUyMGykZ9l3UX+AKA4vKyq+T6P9xG
         XcyXycN9vyPZSZDNQpGF+IDtev64FLBgvYDONz5QVx2qWKc+GzrJyLtbg+ma3+JMrJ2v
         dDlA==
X-Forwarded-Encrypted: i=1; AJvYcCUNohRfEOlCqVAMNKRwjpdQ+KQxyxrMSbfC4dnh96xkj0jAWocYmg+VebrTtGv5RGJIqcgSvFICYEwEtoZ0ul0ztaOc
X-Gm-Message-State: AOJu0YxujxFUZmsoCUmJm8NGQE+wL+pWtOnHagtl9Fh44XLu5b89BUHk
	vJ93oPo5tcgykrvKD1OTc0dvtP9qDbw6Szw6YYVLavFLg/c7pFjDdZaDsXhC6ns0cbbZ0X64NYC
	SZAIUd1x5DAiVL7gf0287xBhEFRXYBQ==
X-Google-Smtp-Source: AGHT+IH+JDHvEShS7oRQ9wlivMwAwUW4wP2fjQ+pnoda5qw0qIiZoujJLISoVuydTwP1W/dYT/MY/3BkwjomhbxbbF8=
X-Received: by 2002:a05:6808:2192:b0:3d6:71d4:e90d with SMTP id
 5614622812f47-3dd1f0fed4dmr3426939b6e.50.1723544253843; Tue, 13 Aug 2024
 03:17:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Aug 2024 05:17:32 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 05:17:32 -0500
Message-ID: <CAOLa=ZREWViEAxBbVTGfTtb3ZwxO8NiVc6GkQEbgyKBEheFH6g@mail.gmail.com>
Subject: Re: [PATCH 00/10] reftable: drop generic `reftable_table` interface
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000016b8c061f8deb35"

--000000000000016b8c061f8deb35
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series performs some simplification of the reftable library
> by dropping the generic `reftable_table` interface. The intent of this
> interface is to abstract away whether the underlying table is either a
> single reftable, or a merged reftable. Arguably though, it is not needed
> anymore starting with my recent refactorings [1] that made the reftable
> iterator itself seekable, as that now provides such a generic interface
> already.
>
> So this patch series rips out the `reftable_table` interface, both to
> remove unused clutter, but more importantly to make the reftable library
> easier to understand overall. There is also a tiny performance gain of
> 1-3% by requiring one less vtable function call. But while that speedup
> is consistent, I didn't include any benchmarks as it is rather close to
> noise and not the primary motivation of this patch series.
>
> Patrick
>

This is a very welcome change, the indirection was a cause for confusion
before and this clears it up.

My only concern is the loss of dumping reftables for debug purposes in
patch 8, I suggest we keep them until we have alternatives. Apart from
that everything looks great.

Thanks!

--000000000000016b8c061f8deb35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2094051391d53bd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hN01yc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlBEQy9vQ3NXcnlhZFY2TDV6aWZoM1FEaHBnRGI0OApLVUpKbmZ3TkFN
UXA1UG9VcFpJSjB2UGV5Uy9uYStOOXBKMXhYRkFwcGhGSG56WlF5REJFd05sOWJZcEJTT21BClF4
a0daQ3FFOW9EQklzT043SXFobnRGYjRPUXd2VDM1bGNRWEhuN1Y2SnpRZWdUUmlHTGZCUitNWDVS
cDZaRUIKSnlITlFCTHd2U09wR2tSdEZYL3pEVVcra2JYQVNXcVo2NUY4d1J3d0UzazJkcTlsSzl6
cnp4dzF1amMzWUN1NgpoY2VjM21QWUlSNnBXcDNZM1pHNVp6Zm9MRDU3RUUrdU1OZ0V6WDZ6N1Rn
ZWxXNEdWOEVRMy9VZGVvcHNkcDFjCkExSTFaRTh6YjY5NlQ4SVZYbjZ6MEVDQnluSGMvTm85ejRs
ZlpGcUVkZWl5NU9sU0VSVllmOWJhUzM5ZE42RmkKc3NNcWFvaHVTc0RmUXlObDdicm96M2czMmpp
dFVIMk45d3JZRVhsOEJsSHorMkV3ekdqY3Q5S0REQjd6SG5sRwpRcFgybXdZdzhlbk9aN0sxVTBK
cUVFa2pPZExyNmVWWHhjdHg2RnNFOUpWT3BheUR6QmJUL1JETHhNbXZNSjlCCkFWanZSVVlCclZp
T21Fc2FGZzhLT3JQSlNUR1hnK3RUSFpaeDdzaz0KPTVjUEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000016b8c061f8deb35--
