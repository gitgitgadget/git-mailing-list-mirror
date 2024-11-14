Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C31DB95F
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578670; cv=none; b=SxhMk1D546z55GpY626Gb3QPBZ0qsiUAegg5qbrC655unX621QrtX/dLm4nGKeIjUsOEpsQ/xQUCNPQwhjHLWbFHzZg6bDh6MjtmF7822SCm98OK5UXgbPOvf1clc8SyEi0xSbgYrkT6r1oKHQOwBBUahZVZkii6/W2RN6ToclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578670; c=relaxed/simple;
	bh=jNm4yrJt9yHpXQdlv8TF415RB/rDWE1vZ3u09eiQAbA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJhHGNxfZ5KMluBxcQJ+90v9RtI+i9fIlHm6OM+O5ls1ndg+P9CDqpLMEQFAiqcqlmT52Auvor6nvyC3OUqEdajmod/63jqjyy1AAoNSl+WI6mGHZJyQGhBK5AVIxO9cLAHbtXLBuGKhmas9NAgW0UnlJ+qOaLG7d/XTFAKGSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9CT3yEx; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9CT3yEx"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d525be53eso222806e0c.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 02:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731578667; x=1732183467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vD4byS3HXnNPuaaRbRyERckm8ctkv/h4pUf4Is3/yDE=;
        b=T9CT3yExS4AoAjB2G+XvHgNvxpwuQXDjognTSpsoBZUqSKGY9ctvXisuJMzecCcSby
         zTWWGPNJT/+7DarLa7aLoEZ7XjFLzqSsNNfhrYnWhFOLFeL/QUPPzSqmQXGJb6CO1Ngz
         XdtCViO/QBpQeO2qaEMP7cmzhiJTOYyMM3mDnUfNDGS6WgfK04KLX2rWkkSg8Re3WGWr
         prMB4oQDI1yi3/hCqCg1cF332AdJVCUATHOrAondyIVw5DI0kgTidhgMUZZEb3+Uzm+z
         sRzWZHUC46zcHmvDTkjHMBxNF5IOGl4zIJv6MiroELtImqiCL65Cive7CyuwYdrvMpfF
         BLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578667; x=1732183467;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD4byS3HXnNPuaaRbRyERckm8ctkv/h4pUf4Is3/yDE=;
        b=Vl4s1EOk5UVmhq4Ukty2U4STBsNWb5cm9iNFSXYVcntkX8fjq+X0ijCMtlTWfxoo5+
         iFKJvyxomhvRLRB27wfQepTBdesTQ6JC/QAUOlu8FE0KynAX1WzFdvN5vumIYL3kwkoq
         4fITB057mC5XUBFRq8id1rl7AWIr1RLkLEP4ouVcyV3lYZRCMA9tFksOstFaX2cjcL5R
         vYwHgp0DCFag67rGu/UK1A8Hq9RlQQgJEWJbGXAcRgeIG97Dga24He0thsxPeSEc4d9i
         esEjTQH/MzZOEz5YyGRoqSTucTTS/LGP40zcduFNuQ2rRYR8CzBJooMwB9mX4qCzUVRl
         r+dw==
X-Forwarded-Encrypted: i=1; AJvYcCXzSU6MNohELoU1So9aN9q9778ZvLk8kWvRX/3lZuk/tm54wE1zi2UAi/luzQn7ZVicndM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuIMgfs2nvo5y8JNWqwViJVa90Jvl0yftT8OaZPtBFOf+gkUqa
	N5PsBdm9L2SnrDub0rICUQDC3qVA/p+++JumR7sX5PI66Gq310fQbqFHLwaem73U4BoY98OYwf6
	SvnUsOLbX12k8LEn4Xegf81AJ54o=
X-Google-Smtp-Source: AGHT+IFB9DhbVe32rl3z7pUHR+T38c4MaQMnIcTDlaRwTUyjV5RF7PQ28NYkyAY+MidX30d49VzZc87kO/v3meQxKis=
X-Received: by 2002:a05:6122:1d4a:b0:50d:b561:33bd with SMTP id
 71dfb90a1353d-5145432d866mr6524555e0c.12.1731578667192; Thu, 14 Nov 2024
 02:04:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Nov 2024 05:04:26 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh68a8z83.fsf@gitster.g>
References: <cover.1731323350.git.karthik.188@gmail.com> <6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
 <87ttcbi9w1.fsf@iotcl.com> <CAOLa=ZTmmpqC7xDLMop=O1_gV+wj9P+dGqT18W7doo09XW3hwA@mail.gmail.com>
 <xmqqh68a8z83.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 05:04:26 -0500
Message-ID: <CAOLa=ZQu3_r=F2XCaoEiB66=JmTYiYTTSswXS6SWtbnA2EEOjw@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] packfile: add repository to struct `packed_git`
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000005c34760626dc9355"

--0000000000005c34760626dc9355
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> Indeed. I'll add it in locally but will avoid a re-roll just for the
>> typo.
>
> FWIW, I'd _strongly_ prefer people *not* phrase it that way.
>
> It is very much sensible to refrain sending an another reroll
> immediately only to correct a small typo.  IOW, "avoid a" -> "avoid
> an immediate" would be very much appreciated.
>
> But in the end, the final version should not waste all the work that
> went into reviewing the series.
>

Thanks for pointing it out, I agree and didn't really consider how that
seems. I will be more mindful!

> Thanks.

--0000000000005c34760626dc9355
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9789970cfd92600e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jMXl5WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHFtQy80a1JjWVpjMWk0ak13dko5ZTdnVGNwdDdmagpVdmlKdFFuVldr
b3p2RUt4M1VrUnBMRitiMHZVdk9qdlF0citUeGJ2ckVLclQ3L0tyMWFpOWJ3RUF0M1lmMkVBCmFL
YVA3RkFweXpWQmdlSmhvckdONjEvVjZuMXJIRzZpRGR5RkY2T0NJVnRSWjJ1WUxCc3JHWUM5Nnd3
SjFRMU0KMzFSTUJ1RVg3Myt2OGQvMWJxVDd5V1lPcmd2Qy9nNUtRMG54Y1cwTGZGZGpqQ2NDa1p2
bjd3czlaWk10aHJtQgplQU5PTitLem5DUDVndWRmdDEvMmo5QU5VczVlRndrVVM5dXpoRWpPYU5o
ZWU4RVQrNUVnenhLblQ1QmMvWStkCjNxSDUrMTcxekFkMWNPb05LaXhWc1pXdjJiclFHM09wU3JF
NjlaMXpVdXZmNXZPN2JTYUJITlZhbm51Wml2NEwKSFBhTk1TNGQvcXFXbTRhTnJES3NRNEdDblVP
a3o5WjBQa1lvSzN1Q0NIMTltSGRqZkxrdFRhbHVsL1M3RzFFagpqUC9pM2QxL2syOVc5MXdNUTBC
ZG5aTHpwMHJKY1V6dkEyV0ovMkFBTGxrSUJLdXBFNENqTGpNUFNzWm96ZEwrCnFmSmViR0w2MHBZ
Ny9zMDlRVnVSdHRkNGE5Vjl4a1A0MWRuY1hCbz0KPURLdVUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005c34760626dc9355--
