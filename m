Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653E2E5B2E
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712018; cv=none; b=hyWgh/LTM927Xu4Wm2ZbIwFFXMIWyzCaW7Yzj5OjTaKpi91YEryMc2NMsF68l6nQG54gsx/tQMLjALLbiFh8c0jupEU33ANFBswm5ZzYUXjOYTAXF5sP1KRu1m5wnA4KGMIZ+5THNbZFhfivuRydbUBDSahuEevaqHLZjgtLeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712018; c=relaxed/simple;
	bh=95o7yJ4Om9hEK4ScQiJHRvUYmaoBkBV3U3rubtrMT/c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RL0ebdYPbsEC2G49B9Xu63FBOwDJjF9oos03fWOZXfhszpmtEj4axRqFRZz026Qdf5meMCnuWzhLaiLdeVxUArottnuOGmMtd5x4OHnk/ZyGCUGICveWG8b+yL/+Q+1sQh02TkGAsSex3YVJUxAzPOH4OgWP30Y45HJrVKOn1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdp6ltHc; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdp6ltHc"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018e9f902so3548516241.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758712011; x=1759316811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Yq0F7/criI+QGPS3yhCPd2vb1VWfYEF/8VzX3IjFo=;
        b=bdp6ltHczrRWCxFb55UL6ffsEbQoqRXO77aaRO+enxWgzb6oyQHLJgqd+KODXzq+qy
         mgrYkmyNkid7Pe0i9LsGIRahNMN5kWq4/08d8KoiIznE0/yjiLRoRlxZZW4W4hBG4QPA
         Mgj9IWZI4V/s8niWSrbyZij8L4ZOtjAhgD5YAsUsPCE7MoxWWzm8ycqj0KmLiGoMe2tR
         fwh2VttE5rDqcfO+GUN/zsHsXp6wSiSWr/nUvUgupyU8m2BenQgxdS9fxCEWgcJh5Dl4
         XjlxfguVZiOpABijnkzGqlQRE29toh7A0NNElqzhz3uZ2E+z/PxdnXQU+h/7Bt+ecKiZ
         CLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712011; x=1759316811;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Yq0F7/criI+QGPS3yhCPd2vb1VWfYEF/8VzX3IjFo=;
        b=XU6dxc9WWwR1YkHVInmLBQGyZofCFua240AArxU2nF/Vngqr5CszsG3oXJGFDtFpky
         IaeTNxp8P3FtE0HNZI+qzJSRIqUI1UGJNOvLAzaLPh00UkE8fs16gEm4h0sZF2FItOkX
         buSUIpuumcEyJiIrfqZM0NfErxRyVEn1TRfvtOpMhXSKDHtD5J749V0WM+MbndSTtf8W
         7nkvqKF7+ZqWPDhDv3CdieP2rEl/UyJ9nsnXHmKR29XXrlCdlSeaiiGsiPE9QqVh1l8f
         NuZfEp1OWzfM/VjeawNkmwD6tmCS5TH6DtGN/LyeFzQBNqNX7WJzPXlwYwYeLB1bBDAP
         7KSg==
X-Forwarded-Encrypted: i=1; AJvYcCXsEIDKOnxMaVRJaUvJj6BsQ3M1juCYuq4DSE/4oxob/joWdcnHKgIswOhqynddxjuRQ9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZpUOPV9ieKp6soZBhYnHvVwrIqzwuX5vko2v26k5h2cezfJs
	pDUBD57neNzIHhKDBSx6M5DpuZGASHKVCqWkH1ZVF2HjBP5lfTbxqibVwBxr+4b06Szzni+Q2s6
	0CVOb4bssLObcDJRYncBObPjEYYkzcnE=
X-Gm-Gg: ASbGncu1hUQG2h6jIkmlPTWXIidtvsp/WWA4Y6A0X1HW6wZ8NE1TQucnOQc9RLFBQsU
	P/3l3CJgoUWDALD+5Sx+bwW/q3B/EZ/HZvjovJgo9WjHBOoc1L7o81d7ZMLd68w131W0ZPTNWw1
	We8v1xpODbhg6E1vIwBDx7Y10VTwSsrx0SQCrn+h6b0j/OC87i2/eEuNdZmg81mPhDYucVWf2Tf
	OBMoMZQ8djGaTzxLoq5Qg466iSE+QX5uKyPN84Tzw==
X-Google-Smtp-Source: AGHT+IFFjjlW8LbPfgsXM1AUHX47sjEnHpOxJwf417bhbij0U3aKnMifPdCgMhPiP9neGbgyFGXolrvVDMdy4PC8BD8=
X-Received: by 2002:a05:6102:4a95:b0:5a4:60ff:80c2 with SMTP id
 ada2fe7eead31-5a5829169a4mr2415174137.30.1758712010930; Wed, 24 Sep 2025
 04:06:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 04:06:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 04:06:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b6d03748-8171-4df3-83fd-7f4025d9eb6c@app.fastmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
 <b6d03748-8171-4df3-83fd-7f4025d9eb6c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 04:06:49 -0700
X-Gm-Features: AS18NWDFGHSIXO-6Va4eJiuBh6MFzVMjKrKkHX0RlbDpNyvrAgnvv_IXx75DgcI
Message-ID: <CAOLa=ZSkx--7A6zs3RK3Noa=bBZ8mSLMVWBYr7tUFXQkrstgMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] reftable: check for trailing newline in 'tables.list'
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ac9c1d063f8a0cd4"

--000000000000ac9c1d063f8a0cd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, Sep 18, 2025, at 10:11, Karthik Nayak wrote:
>> In the reftable format, the 'tables.list' file contains a newline
>> separated list of tables. While we parse this file, we do not check or
>> care about trailing newlines. Tighten the parser in `parse_names()` to
>> return an appropriate error if there is no trailing newline.
>
> Nit:[1] newline-separated + requiring a trailing newline sounds like it
> really equals: newline-terminated list.  Is this moving from
> effectively using newline-separated to a newline-terminated format?
>
> =E2=80=A0 1: Since others have commented anyway
>

I see the confusion, it is a newline-separated list, but we don't
check/care for the last newline. We don't require a separate terminating
newline. Let me amend the commit message to make this clearer.

>>
>> This requires modification to `parse_names()` to accept a third argument
>> which will hold the error value.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---

--000000000000ac9c1d063f8a0cd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e7dcdfab6573ac3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVDBNZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0tsQy80MXpXNkhaRlFGSm1vK2hneFdIbEQwdGVsQQpCVW9JWmx3SEhK
M3o1YUVPZmNFc0M1TWFGUFdvS0tnRlpCVHQ5S1IvQTBlQzd1bVJpaHo2eVVxMFFVMFlJWVlrCkkw
b2RaamhXN3orSzJoNnM5bGhjTkVNdWxCNG1ERy96MDcxVDN6S00xdmVKbG1oYXBqY3YyRzRvczh4
a3RrazIKTCtxUVBac25qZXhrTmgreEVsNDZEVEZjRE1GL2pQZzZCaWZ5N1FMZEF1SmxVR2w5YlNF
Zk5JbzlleFBJalIzZwpTYVQ4Vi9HOHQ0VEMxaXRQYWhvWEZBTzREMm1LRXl1bDhSMHR6OC9EenBL
U21FMXIvaGVOamZmcy9HckdUV05yCkE4d1JnNUEyNFlBYXdDaC84ZHFSdUlIZVAwRTF1MVQ4MWt3
TWI4TDkvdXFISXIyalVBYW4xNjltbXdham1VaFYKNjFzWWMzM0krL2FVUTF4UUJXcWoxRVhjTGVS
WnBOMGs5aTM3RzFHelcyOEdlK0lONVU3akl2cGIxeFRpK1VvcwpMUC9nR0JaRDZtRUlHYmhIdzZl
Zk1wdU9GMEs1d1d1dnVDZkp2QldYTTUyQWhCSFc2MTRON2l0TjVzblI3ZE5XCjd0cGg5Y3pOMW1o
Y2ZhRDdDY0lsVzBjVVNCRTFLSHl4K1B3bUVIRT0KPU12V08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ac9c1d063f8a0cd4--
