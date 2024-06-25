Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55CD143721
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307923; cv=none; b=guSMONPJEu7nF5dYUPVlI3sRJmgBDVBIk4zmNTATkK2EDn6LO9hYTnfBHUZPl9zRpztQelgCQnXf+06o8WSl9cwzVpRdqehFU0ORkciSiNICNSt0k7+AgTLL9xocQdlzxn3gWRl9Ba74vwOuoE8FYjCa9jQWSXhLFD8UNfRIVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307923; c=relaxed/simple;
	bh=YuiAm19w6ExWYsGeVKQOBG8fimkR8gxhORafv4DlY8E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFSwgp9Y/9C+iPO/FCGmAqUkSTXajy3hANBGiO8ctjOnm7SdcTt+Zi2mYjeQqqVx2LYScxujxvM6wNk3i1pOibqZNIsT29Cnc9kV1Jd+I6fsSyomfEEqgsL+NPAidVR3XU987A7i0w1Fi8KEFMYlGfZHsJvEMEc68BPuGh0kXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLPmY0/P; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLPmY0/P"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d541d93127so1239149b6e.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307921; x=1719912721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuiAm19w6ExWYsGeVKQOBG8fimkR8gxhORafv4DlY8E=;
        b=SLPmY0/PVs8TCnE8H7Er3VCRiNA3KoCQlosbfkbZwH8pfkNCrlwkQMOiCu8a7TXFGw
         ndu4do5KvRhbbFNwStrdD0pMc4CXACS2qsjpYmweI3hJarj9n6hFCnVRM1+IrHL23G2F
         CAZ5H5u0XZHnJb2pnh5IAIzmlTgSDk9lEiZEVt8sE1DVEl/vAA+2+uFqVwUMv1mie+ZB
         X0uafkhIuMvb72avf485JYfMryCYeEug38JpBSBPbXBXEfMgsuhlSq4oGCAqcSwUC1Ea
         ZNgdA99Mvxm5OJyz6mYl+5x/qn1YEQ4qtEiGnhsHIvU2hLxYYDxI0S/QMcL37VuXZuVX
         SELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307921; x=1719912721;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuiAm19w6ExWYsGeVKQOBG8fimkR8gxhORafv4DlY8E=;
        b=Yu3/cTGrVLikPGUiCzwnLue698lQPvFRd6bjGFUI8bv4GTegTqIuUj48wQPqQhg5Ny
         T2aWzUwBykvElnduwjclsesPIQdlDCYFbjoDgFGELItIp5aQaRNJD5d5pCotON4+UVL1
         66Gw/GjKIT4vTe4OTk0MK9+Ud7OcvWqk6SeLtpp70kzs2GvMiadsTvoqGWSWFvADaJOc
         LYykcMi+qgVIBiLV6mXV/qkmaIKnkvO/ZYXII2X+zy8oPsunou1FnTqYYnngwgrodlhL
         sZUYFsXL80gC+oTpqDR8H5mInqALOrnNe1kNo9bXJ5jzegyhp+E1niTkMVp8RikzULh5
         4TQw==
X-Forwarded-Encrypted: i=1; AJvYcCV3HWG5wOtMpcqpZimd9nImRg1zi6TbntY+GCRdObo+povVuXv7o70TBlnwASuU70UKW+MhJWqzjDN1xnSMTGtBPxjs
X-Gm-Message-State: AOJu0YzDqdjL8e2wnwRRPzxhUQkIzoHT/79i7nYAad8NHMnhFrd7RT1v
	vHCads4fxnD497l25hLj8YxkcOM2pkTtEOSwxx4rKMUyq4J1Eg+ZCS6a4cK9g27Z5arN/tZdyTY
	KfjbZq6GSFs4t9e6lXdVUpfcCiKw=
X-Google-Smtp-Source: AGHT+IEedx8ixAia7jws1ecDjVK0HP86nb2fsCL4LGOya4+PtdBup+H48l8dZZ5yMuWKLfbjMVV/BGqSqKEenoZIBfY=
X-Received: by 2002:a05:6870:89aa:b0:24f:dad3:97c with SMTP id
 586e51a60fabf-25d06e57b0bmr7661051fac.46.1719307920915; Tue, 25 Jun 2024
 02:32:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 04:32:00 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com> <20240621115708.3626-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 04:32:00 -0500
Message-ID: <CAOLa=ZR=jProEJYnTj0w0=gNyvz8PceVhjXKc+6sQFfUcW=v-Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/11] t: port reftable/record_test.c to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000e2dbe6061bb391a4"

--000000000000e2dbe6061bb391a4
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

Hello Chandra,

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/record_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first patch in the series moves the test to the unit testing framework,
> and the rest of the patches improve upon the ported test.

I did review the series, I must say I'm not too familiar with the
'unit-tests' framework, so most of this code was new for me.

Tangential to this GSoC project, I was hoping for some documentation
regarding writing/running 'unit-tests', something similar to how we have
't/README'. This would help formalize expected styling and tips around
writing tests, and also how to run individual tests. I was mostly able
to figure it out from the makefiles, but it would be easier if there was
documentation too. (We did discuss this internally, but I think it's
worthwhile stating on the list).

--000000000000e2dbe6061bb391a4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 80837203ce7ea78e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmpvMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0Y1Qy85eWNucFV0S3p3MmRMWk45TW5kNjkwelhtUQpIdlMrUld0WmF4
eUNMejdCalZCNk4xcDYwS0FxbitObE1ZSVFlejBlMXA5cVFNazNwWFdneXM3eGNEWUcrODZOCkRD
NThjUGdiV0REZ052LzNkT2s1YlVIb2xpbUVoeWFwNkl2QjlBditKYmZNK2gvSE9pSHZWdDh2QnZj
TlliWlUKd0V3YzJqMVhOR1N0YU1qWDliK1RhaEdVQmFnZzN3d2VvYW0zbUFxVEozN3NQaFpKaHFS
YU8rd0M4ZXhqOElSYgp5STl5MThpWEh1VEtaRS9naXhNNHZrVHJrSVQrV3lIejJycGp5S2c2V2Fx
bVVpb3F0Z0dlL043YjFpR0RYR3poCnhQY01zYWJxVndCY1UrTS9qUlhpTUlaY3liWmpuSi9ab2tT
eXRYYWZwSmhkekNBeGZ2VE5zelB1cGxNNDJjaDEKODNpKytKS0h5WTNiYVFXVU9kR0hEamgramlz
WWtmS0JKRE5VQXNlL3Rycm5NMzA2S1NKWEJpQkxhcGtXLzlwSwpMblJvRHRYVHF4c1ZSa1liM3Vr
Z2hQSWxPMktrQTNkSGdTc1J4c0xKbWZaVldHZ0kxV29Gc1lyNkJPV1Z3Z1FVCmRrQllYdnNVWE5W
aStkWW5JVk4rUVROQmxGcXg3Z0U5di9lREJFdz0KPUxFblQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e2dbe6061bb391a4--
