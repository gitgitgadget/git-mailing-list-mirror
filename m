Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D119329369
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085370; cv=pass; b=ZbFEn4RTkRn0P8iex6IONvkmxcLe5GTZBva1oVmA6EvodxMJU+A1ZxVw7oLmap29RsWTNi5M+7z1NOsX20j5kNnzo1nIR1JyfpxUQO5sovL6ST+UnblqRFBuJZtTjJLa+124kYbZ9Tywxfe2ij/pzYtvIA/lWHh2q821rK2lANM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085370; c=relaxed/simple;
	bh=RuVI1nBC17LDNVfsepYdlAA7OahOjUROPJeYSX/JTQw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJjoudOV6I1ISzEUj7IQ4WRM83Fb0tYzGTcJsIO2bw6dBoUWFs7aw28/LZUkGHHLYtb9onYqaZpY9giOfgeq/kDt5ptnfMj8Kmc3Hol05sxXBBRU9lV+Aat2NiPDTSy17kYayUehdk4T1uri91FU4rjdizuwaoBSPtNNmXf/v7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doGEmKVF; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doGEmKVF"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso528952241.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:36:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769085367; cv=none;
        d=google.com; s=arc-20240605;
        b=OqlsG8urrdwARstjm2huQ+ptOcNjxgte5Xf0xIuGQ9+tSOB/TGsW87Ch3LdVvTFJN5
         9mPsmQRMXRbEMgQmiM3jTOVhinXSTWXNRGbzmvvGEfWvQfMboy9cFRxv+xTK3YXyrrJR
         69LdGUQl6OZSXVQbdvw+EQPvJdrGE7uD7DV27tvVRuPcG5hOCHJcLDheypy371Mer3wm
         KCJPsXpfqspPNoe2/yRuomXplG0j+jV7SGSS9DuPVisydsULZgc+0Iwq5qrzJL/CK6Zu
         3XlQpw0PIRYjvv+k6mOPoN1NH/tLaZpzp0gRiM9nUhPo/Hx+8HZpiMw8iZl42OWO75p/
         WBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+4GhV9aPpSYP1Vu/cta7+UwKEJscG/5UWuHRxGh/yB4=;
        fh=FwPhMWsjBKYcFflPDJTfpCRGIKJtbo9YIOHYSs40Fg0=;
        b=VYIHO9M4f6xda/G5BkBgciGakWNhDXAS/n5xzhYa+s9eSOTFUjfQN1QLj/z4qCwJ2l
         wbLJsuEdfTfqZJkvuKjv59IvMvEmBDFNVG4JGZfP6yl14sb2A+P/ZAC+vOblGjMfk5nR
         0skiZotz4xENfSP3mAaeNTGcfMoXx0XeAznAcQuWyeJDnfjO58XAy7y+Di6beCjr4RE2
         jluyTlCib/ayAufh+cZ++GMWMugQxHSydcgyRcRw1/Tk6H+PHnP8rX/LIJN2xxEChyyK
         n9xVG2at1JXk3fLHpyyktQANhcp2vsQmuUgfGV5xBDHk9R0vWmHcZSffj7kxaPOZ3/6a
         0qWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769085367; x=1769690167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4GhV9aPpSYP1Vu/cta7+UwKEJscG/5UWuHRxGh/yB4=;
        b=doGEmKVFZxuF4VJC7U6SeATb68/EKAOv0LkjQmdlKZR2FyLL3RD76GkuWBQKM/6U2Y
         sCGR0yCnx6ZSppqzGkm3jTNIRLC8KRJrSmK6qWUO/TblJC9SN1X70eUysaPjeqynIXbt
         lTBfLVckZ90PbKb8VQauS5zmTpineNCsuXNjUOgZEuTOYTDbsE+dYmNwyCrzVC8dqAI7
         YoncQHwjGTRoPbIJGPSftQR9+UjTcQ81iKuO3iwRuqjiMlma8AhYmeN3Zq18kHgxnvpp
         G9HqDlF3gSi3B/xNhOAp/IUBVv364zgA2B2kbzzRm5aiFftrmJ1rmGG5NKYAe8yLBBSr
         IJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769085367; x=1769690167;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4GhV9aPpSYP1Vu/cta7+UwKEJscG/5UWuHRxGh/yB4=;
        b=qyFzBEqfh7C72KFWlk4ehly8dKDRDoMiqD8UhSbLLIDLvantqvK0qw/FPToY4BmEWh
         RXv58BHzXApvq/65qbBahC/bikbXeGqS4HhIvezV3xdiQWNgEvKXjSZQL4wRuqA5acN+
         Mhl592KylrIxo1S/bDsO2vC4URckSFh7n3IkMVf/T6dI+lK39+oYR93kbaDPKlI13HvJ
         lI6IIycnrC8P48kg1H/dKGw2IwA+k/nJ/PO5WxJGakOq9RSVK986awvU+URz4G/5cqDp
         nwWNYTM1YJ0ImHCaYrpCCSNFwcuM8XD29Ea68rwl/dHZRkZW0ncQWePx7dZeLVDZ4Q2J
         L2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6GRBXja9db67ziGWNyHsq/9cKTo+3je1AbNFTX74xhHU+fHSqM0Bn7Dpze/rDa9nbKm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUAZW7Piboqy60mSCn+VwhwxfcTdJvLZXVqc3Ow+AY6K2gtIG
	J8iE/7Mms4Vw3sywE4zuU09j+Inx8ibQMo24TBDDxpasN2VqOIYRoJIZC6ujAEu4aqp0iz4Su5j
	pRoA9ygr+ySvG2qHJ9LZopEC+wudxMwU=
X-Gm-Gg: AZuq6aIXuFMuOZRJkA9FIVT298AfEKv1Bmvqw3v3Pmx1z/mMUXrCxPUwPAy+FLouPA/
	Q0qzGa0hu4QloResRFiJO8p4+wZF1OD9V3tPcZdHAyURdG+aWshF8Jpy084/P5K2TxqGx6PpZ5t
	BKt4YRRLf/kJ4cp0yI242dj10V8XiQmLxesY8VorlJHe/IOEchTE0fLMIvLPEAQo4nCa2oZ9TcU
	g8UgTjHq9PocnBnye9isUj8K8MzBEdduYw43CMMlHnNdiB5JcbeC32VQ9bplf0YxBxXUh/7U6ji
	eNoBeyBLXpf4pjZBBMKVGTBPngRZ
X-Received: by 2002:a05:6102:3582:b0:5ef:a164:ebed with SMTP id
 ada2fe7eead31-5f1a7210563mr6715796137.43.1769085366863; Thu, 22 Jan 2026
 04:36:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 07:36:05 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 07:36:05 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjioxahm.fsf@gitster.g>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
 <aVvVAH1eRxGa60Fp@pks.im> <CAOLa=ZT5YwDXEs=wHqVcHqLNxen51-hucaPXOWQEMug3oWfxOA@mail.gmail.com>
 <xmqqbjioxahm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Jan 2026 07:36:05 -0500
X-Gm-Features: AZwV_QhPuF687YAzcYlBsbvq6CVWmGYFb7hePX2T6pc0Awvhbbe8u1AJ9fyOkAU
Message-ID: <CAOLa=ZQBvrf_T5BHdam74JBgNZ=WPVAznT3q+f9SvN3Gr9KxAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] refs: allow setting the reference directory
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	sunshine@sunshineco.com, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000dea1740648f94818"

--000000000000dea1740648f94818
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> FYI: I did an internal review of this at [1] and mentioned a couple of
>>> things that I think still need to be iterated on. Most importantly, I
>>> think that we also need to handle worktrees:
>>> ...
>>> So you can expect another iteration of this patch series once folks
>>> settle into their usual post-holiday rhythms again :)
>>>
>>> Patrick
>>>
>>> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/451
>>
>> Thanks for putting that here. I did reply to one of Junio's what's
>> cooking emails [1] stating the same (mostly that I'm on vacation) and that
>> the topic isn't abandoned but would be delayed.
>
> OK.  The topic has been marked as [Stalled] and I'll probably eject
> it from 'seen' soonish to declutter my tree, but it does not mean a
> renewed effort on the same topic is unwelcome.  "Dismissed without
> prejudice" so to speak.
>
> Thanks.

Yeah I understand, I'm still working on it, but it has been a while.

Thanks

--000000000000dea1740648f94818
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c7e632c441455a90_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1seUdiUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXFqREFDYkd5M21vZFNLYXRHaXlpTUtGdURLeTRCYwpsSkRCVmRnUnB3
VjFieUsvclAyRE1sMWVTZDlVZ3ZrbThqdHY4OVdYYzA2dFBHNHVkVWNJVEN6S0ZYMDYyOGVNCjha
eThoZER0LzV0dHBqS3pHQnNUODlvYU11dUxzWS9ubkE5Zk9oQldSSGwxWk12MnZoc3YzektUZnVE
TlBlaHcKd3REWkRSOEVReitrY1hqb2VMNDRoM1daQkFuSHFVL1pqQ3BCbEsvTHVQUmRFcGRrNUZ3
RXcwaWEza29UWHJ6TgpTdmR6eVJRZUVvU0RjaXlicEdIY2lmSGtKN3d6TUIwN3hLUnNMWmgyVEpE
WTR0clQzenJsNkhnQ1UxS1hXSzJtCi9lTFJZWE5qR3NrWU52bUVoR1QxcHJtZmZHK1lOejJsdzU0
dUd3NnI3dHhUalVRUUpZNjhZRnRDcFU2LzJPVlIKYWdGMTQxYVQzd0FNd0tLdjRCWUplMWZ0ZEl5
TUJ1NTZjdExpS3lzampLdk9NNXdVRllBb1NBU0FWWGJHblMyVgpYbk1nMHZOWDk1elJyUnBTK2tn
SEwwdXUyN2laRkpuVS9yOVFDWElWUUg5dzMwTFJxNXUwcmtsZ0YzWTM4NXg4Cm1Xem5iR28wb3dR
TmtnUFV4b0hrMXhpY1BwMmNpYU9NTnAxdGNaST0KPXlBWWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dea1740648f94818--
