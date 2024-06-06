Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2C188CD1
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668468; cv=none; b=ciL9XKf3CTRwCrl68qrJJCNjlexKccB8Hz8BwqILc+nZwLLKFCrt3/G/LiF8T0t28agAcxfPbLO7W24oZ6HnduePEeZDH512dd+A9l5l20w8lDa9QBVUPnaq13tnw6G17pGVwr+pXT0XPVRFBqaBJDTp17k1EOtILn5AqvyzYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668468; c=relaxed/simple;
	bh=PdwaQ92+jUMPW0sPle1DOl+BcgC3HmJpCEqXWgGzJn4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Id8blgf0zWpzH3nCd7niEvAyaVy7v/tbNlFFqLe3EX12mcMcK1y30y3rYMASqJZ+tQG1A2cihcJylCXDFBdVWm9sefLOeqz0tEh87wLaF147mww9X+VvfiDbY5eOL+bXH8TOAZrsUzx+ifeyuovIjqqVkifrJLljcluK6cuqRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8kKAMNW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8kKAMNW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d200fd77a4so838630b6e.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668466; x=1718273266; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdwaQ92+jUMPW0sPle1DOl+BcgC3HmJpCEqXWgGzJn4=;
        b=I8kKAMNWeNwWeDgWdcpU8D9WKtHaZnWsg1Y056iKykh8949fDgtp343m1Y3P5fr91z
         R+Ic6F5RVclz6cobq8x8/hbw85IF+9gdzK8ky9SNcDLAZjA7/38GW+H2Sy4SxFPSfYPA
         2X1jq1/bu3KTTwmK8ti4RwlJrmObySs5cqim10KXs3GPWDIWA749SkuX4GQDWRutiy5L
         krQQ3YMoaljh1HUs36fRk7qkhqs2xR2zZwmWr5qdj2DbGQ/GoKoVwGZAaQDgJtobyJ5b
         WEiNPBmVCbD22J+i90f29XsKmid4Woo18gYZhJFo+0CcFqVPwrUu8PYsS5IJGlnkfWFm
         nZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668466; x=1718273266;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdwaQ92+jUMPW0sPle1DOl+BcgC3HmJpCEqXWgGzJn4=;
        b=ZEb6xtfmm6U4jHhc1Zttc2geqr5mxYnEiBzD+xukNQFvdERYgBt4khUhp92Kf+44ev
         KSvDAhDHuzxA0aWY8V+L0K6yuC6s1UFp4ZG4/hRH8BhjEuDuCFrCKU2U3TwooPZGqKea
         YAjOdLcjsYsh5IjW+vpHUm6krszLQpKbGh3cPSNoRNKYLJ0ud1+ANwDrftcVbC+Cdlto
         jRf6/Pr/sgHxgb+agLs18SodqoRvcSXEUCkEHYWX75ft3tanmWnG1xq2YvnBDjgo/VLY
         CGit9i9oXzCJK/UJyr//o1qBhoD4z//7LmWvrINa6etV3Djo3SqZjgPy1tssavmrqtX+
         m44Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5V4QeC03FwEH7YVxQ1UxPJmncm4q+h+nfd7ck/lDqXQLFDVObkHrw84s/PVzIOsz3qHDHvbzOZWR2Wd1gieejdrVP
X-Gm-Message-State: AOJu0YzyVSYjzzs97dy/BIvLzOrqfZKqwlwxHcZcpx+muJgxme+xp46N
	bLEuQVJiCtFsAIK8M2N4is0tob+29KDWR3VHIG5mCcuQOjbPyRdfS4/pFUzsAAW92Z3L34Niip/
	9CUVp/26AfDVbTHGt41a9v1bgCGY=
X-Google-Smtp-Source: AGHT+IEBGYeFxK5NZuKr6RWdIGNHx/QI7hkOFF6gOOCcM9ezI0VV5PhkVPNrLPFgtl6qOApaLuZz8HcSfbLUBNqy5Fw=
X-Received: by 2002:a05:6808:19a2:b0:3d1:fdf0:aba3 with SMTP id
 5614622812f47-3d209b7a690mr1005272b6e.6.1717668466444; Thu, 06 Jun 2024
 03:07:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 10:07:45 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <0052d60ee889981f2ba92c9781e1659e961eace4.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im> <0052d60ee889981f2ba92c9781e1659e961eace4.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 10:07:45 +0000
Message-ID: <CAOLa=ZT3XvdpheQCV9VQinnppitU3ghqvB_Qs-+zm0OyrAOrSQ@mail.gmail.com>
Subject: Re: [PATCH 06/29] merge-recursive: fix leaging rename conflict info
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c8e4b7061a35da60"

--000000000000c8e4b7061a35da60
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

In the subject:

s/leaging/leaking

> When computing rename conflicts in our recursive merge algorithm we set
> up `struct rename_conflict_info`s to track that information. We never
> free those data structures though and thus leak memory.
>
> We need to be a bit more careful here though because the same rename
> conflict info can be assigned to multiple structures. Accomodate for

Nit: s/Accomodate/Accommodate

[snip]

--000000000000c8e4b7061a35da60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 92748c2cfdbd705d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaGltOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDZ0Qy85NExhSC9lWm9xTWZnNklIQnBXbzRYRlViWQp6bGRVU2dOdHo3
QkREYjVGdDQ1ZHh5M1RDQkk5YityVFRiQ0lxNnJHNTd0Z2RGYXJoaWFObjJkbHNaME5LUkYvCldw
RmVhVXdVdW41OGlUTHNZcHVqYXhmVE9oZXFPMnBxampiSVB4bEFUTUJqREJzZ0NzeUFIaCtDMGVD
VHIwL3UKaTNtMlpEa0J3MnduTWtaZnMxY3R3YmJTMEVUK3hORFR4RkJobnpPcGZZbFpNMCs1d0tB
Z2ZQWjV2U1l5WVJKbwo3dnUzTGtjQjRWSjlRRWoySWJBellpRTEzOCtLUkhjU3ZWK0tFbTlLWmht
cU1Salo0SFNvWVpGbm1tNnQ4NDJhCjRtcUVNSnVYdm4xTHRGcGNNRDdmOXVzRW1Ldy9BTnZMN1pW
cFhqWEt1ei9HVGJLYnRaUjRZaXI3dUNja0xNR1MKTXFoNmQ1emVBN0ZuK2tPUjh2b2dRd1RnSEZG
ejVaMkRIbHQzS3l2QnlGVVkxSWczdVVFYTQ2RkFuY0dERno2YQo1TVdudk5pSWFyd3J3Uy9yMzM2
NTRLYTJEcGZ3azhHdlExbEtmRlFjaTZaeHhQVzFpcGp1TEVJY2xYWXVDT3pkCjVZTnp0VHc0cmdR
dXBxbGVzSEpHWDhabkY4MDA3ejhveDZ0Zkxjbz0KPWp5aVEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c8e4b7061a35da60--
