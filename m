Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3620F09C
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274983; cv=none; b=qRkKzXVd8VmVHm8lxRZLvFp3dgAbtROIcgBfXllG7lCdZuSv0R10wOwX85OjJG2gB0xbpjneh3+ArelSUZPTf/h5a/t/HaO2AL0lFvJwhAJPDvKFt5wJn+cPaUGylCyZH3PPTlDqmbTfgZphKoabq+2ifqX4BmRxfzeUcIBeLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274983; c=relaxed/simple;
	bh=gWPgQRJWztrMbk3gsPTo/m9TpIBcjPziJMEtFgkB7V4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quFs8dWJjMWQuHgH8tA1L//OZ6RGV1pkQaHkI3P4+QzsB9S+aA+3+wTcKrWy93dqyJqyQHpdJ7q7seWvDT2Ce4+7UGsz739UP80ZoB2X+YXJdBJCQUrNvjNNM9YWPf87ECwaEye8FtdyB4rrQI7q47t6nT/ZOw3e5eYJjfpVVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJp9chEH; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJp9chEH"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5235db99207so349187e0c.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741274981; x=1741879781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yMXb+Xy8TkXUhlRscab9mZExts3G8WrNLQoeNs9Oj0=;
        b=RJp9chEHYgJAVeRpuGuLtMtWKJzhBw/B1CxFat1iWK6plMlkBG9SssFHIhAazZoBqz
         stOsHhvnnVsPR/LoPybSmMvb4ePCyK44t3g3dutppRNNJ8EQivRmubILw1nV516/NWmM
         IfkhbZUgtiUBjkAG04FHnddYQXIXRtX3c2vqjRfVezDujgl0wRHXwQo8Z4+JtQSp5B8+
         R+Iy0Va3Lk7BTfeoO2AMlkcD/D8mnO7OQiTcXYQbr31vGsp4ur1gVxTzFxPo/0kYLqCa
         B7v2hrGzD7htkBBoBbPG/07yZVuXuGPuhHvi5K+VcbuQD5rSbebu66MUdjn9AfOPlCUd
         whgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741274981; x=1741879781;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yMXb+Xy8TkXUhlRscab9mZExts3G8WrNLQoeNs9Oj0=;
        b=StElu8gSMGyISu1jCLvTop4OOhNrBndWnC+teS0mQ0ExN+cyy+uxUuVWC87GlUDvaq
         5lXfnQNtxkGvZlv2+WtHXiuJxVxO99spHaxY/glgGUDnhWT/2qxQto2ivof5h33Bul0b
         VG2ujZNVSfCVJH+IX+g+YrIoTEuXMxRku95nAmeoPPa3CTvLo9D5QOXD7JrLiHYTV9Rk
         dM+NMR5MKHLzn4gMCC5N4mabqXr2hZ4vRYHgwTm3RKzSCvzzoTP2BDeAUzTIGUvpXGJ1
         Inzv8npoN8yY9DVyuCF2q58HECu8JvBYTuJOsQFHt3fvqSGmguGypwHeTwAwETqzClzP
         Vszg==
X-Forwarded-Encrypted: i=1; AJvYcCVBbCJM/J3iQqXbI4AGCOhfZEwFHPO1kWu1jmE/Oi56XO0mxh6WMSqT8Bzq2CdCmxSRbHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrh3lh9OoUp4K2PIGd5ghZGJHbhbb1RUe63ID1sDReaY4KYwzC
	29HQQeAZGnXmFqPlV6g5M4km0bgnngn7GmFNZh9/AkPzNCERz8IIL4HIucKS5hmPoG/gA6O3aTx
	OmFGCSVaPASBdFPnkCUT546pIY720zJxr
X-Gm-Gg: ASbGncsOVltUkB/xyv3eNL56+UgrkldieK7xRdv2UGTiyXJSYXulCI7Vbtvl9bKoYnY
	NZbeyo931KxgC7TdtsPwXfTzS2C44UEUnAShThW9vqt0uqGbcRRSxzKEmM4BGqsq7gEMJTMTl0C
	anlFbqOf28wALbO4kseE59PoVt
X-Google-Smtp-Source: AGHT+IFOO2xwQsc36pVuuIa6uj0AOt9UiWI74xKRILagniT6XPllpv8gMinNvGvhbK+BlAISPGAi2FGYFfKk3h/WSkc=
X-Received: by 2002:a05:6122:3543:b0:523:a88b:a100 with SMTP id
 71dfb90a1353d-523c625956dmr5082909e0c.6.1741274980732; Thu, 06 Mar 2025
 07:29:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 07:29:38 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 07:29:38 -0800
X-Gm-Features: AQ5f1Jpb22rhYeu8X5KItODw9fSkPdfjurv6kSJRUuuQS_vRvSGQKVIMuZBM07E
Message-ID: <CAOLa=ZTcn5ibmejf3AcEsvQV3YjY4ZaY07jqX_YATxUvSWLp-w@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Stop depending on `the_repository` in
 object-related subsystems
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000af0656062fae2cd5"

--000000000000af0656062fae2cd5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series is another step to remove our dependency on the global
> `the_repository` variable. The series focusses on subsystems related to
> objects.
>
> The intent here is to work towards libification of the whole subsystem
> so that we can start splitting out something like an object "backend".
> It is thus part of a set of refactorings aimed at allowing pluggable
> object databases eventually. I'm not discussing that bigger effort yet,
> mostly because it's still taking shape. So these patch series contains
> things that make sense standalone, even if pluggable ODBs never get to
> be a thing.
>
> Note that this patch series stop short of dropping `the_repository` in
> "object-file.c". This is a bigger undertaking, so I'm pushing that into
> the next patch series.
>
> The series is built on top of cb0ae672aea (A bit more post -rc0,
> 2025-02-27) with ps/path-sans-the-repository at 028f618658e (path:
> adjust last remaining users of `the_repository`, 2025-02-07) merged into
> it.
>
> Changes in v2:
>   - Point out why t1050 had to be adapted.
>   - Drop the rename of `get_max_object_index()` and
>     `get_indexed_object()`.
>   - Fix a couple of commit message typos.
>   - Link to v1: https://lore.kernel.org/r/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im
>

No further comments from my side, the changelog and range-diff looks
good. Thanks!

[snip]

--000000000000af0656062fae2cd5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d898a560e05add6c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnYxNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFM4Qy85cGt6amQyaDFnZnIrWW9pVVVHM1RrekhEdApqRmZySVBmOXNq
MVppZXRodjgvb0ZEeTF2UDhSWFA3MFVEQzRncDRHRUIrdkUxbk1BdFBPbHF6WENCb3BJWnJVCkJZ
RFVkWnBleWFkaXc5SStHbW5QR0VFdjN5bzdjQzlUSWJGREtlV083dU5LS3B6TGZtZFh6cElDTXBo
Q0VwaVUKUzI2aDJHaElYa2dxWkpvQTE0WG1OYlhXbFIwdjVkY0k1VHZNNEdZMTl6VmxyM2Vnc3Z1
K2x1RlRKV3hIazJEegorMXJqUGtleC9ndWgwTkpyc1ZZb2E5cndQUlBOTjRFbTZBNmVic3FzWWFQ
QjZCT3lvY3g5NUZrTjd0QkRnVE9SCnhRN2tBZDVKbkZJOHV3c0Zzcjd2ZWxnQ1BYV3VRVnZxUC8z
TCtPbWlNdFRpRmIySy9Db0owZnNGb09KcFhtOVMKSjVmWFZPbVc1LzIrdkpEWWJ4R1pQaGVrd3FZ
Q21HRFpLRmkwajk3bkdUTzV2VDA4UHFOaytTYTFxVEErbndSRgpvVnNDQ0IrZXhBZkd0c2Q4WG5t
Q1I2QVkzSnNTRnRZVGRRc1Fhc2ZYaFZxenVkMW45ZEo5SFkxbk4xSUJlMElXCi9ZdUNLSVVtYTJj
RHBUUVJ4MkM3ZDRjM3RzUFJDRmxRcmVlc0orWT0KPVBUSmEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000af0656062fae2cd5--
