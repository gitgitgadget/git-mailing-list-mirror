Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAE3A0E99
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716311; cv=pass; b=puPMKMCVYcMRJzVZaZ1yStVYwxATpCreMrhjVbVM9VxgLU8gK1CPNpj6WlTIilQoGqfcI/coTRqWkMrLFPw7mNPFWZUNcVLTPWs8JbJ6XkMYD6jHyIYTgoFTbfMLW2mEunjqKG+XK+pBAYyWh4fZQNZqI6p5BiCtblNFUHB+Kog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716311; c=relaxed/simple;
	bh=YhoSHxYldCNQZyDFym9ZcXCl7iK8u1dso+XBNn2nb68=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=kCsMdSlhcDLTapThs8lWPsdSfGUnYM4xyihZFiGkbqCdE43IVBkF4ZoEeGCga1plU49xWDF5eIBJ3GyahEIiPKub04xEoB+NRCd+yVXC5yDGPXmeaJMSkKogSn8krfmJjJINKuTmo6o3jkYY874F91Qn4ggQG4BFwJvJLj/kvQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CESG8a6D; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CESG8a6D"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ff18242343so2149664137.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 05:11:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772716309; cv=none;
        d=google.com; s=arc-20240605;
        b=D3/uxYkWxAQyTE1uj0WVygsbF+ZhCJVN2ZgffsyQThTwDnHqHrzLBHeDs5DL81a2fE
         9oxhsh3/Qxpq5pvsSsbB5haBOlqu72vQZH5r7gbE5wuX8MBKTFZGuvye9Fi/VaUog8DU
         62lehBjT2Z+ygyvluRRnhJAf8RBga1gyD4aUHntnHukBHH37V+VBNdLE5CAnP3Pekf7e
         BIYZzx7fZmmiynFXsJS1nFiCmvuxf3ASaPsDHQBBqSeext6d3ZxLck5alcjRXPSqK37v
         Ds+xA3a5T87XhhBGny70sib0/6I5J71v6giMFloWic6HRjLP1D8q7NNycV29SQ7lfoys
         c1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=tcq84KoG2DHOQvaFzjae5+COKncFgOBfxhwF07ypxdo=;
        fh=vaJ1gscFHHjasSGGcj5qoNKXf2RZ46M0kFi9ywARCqc=;
        b=R7lFChi+aDSqvcSCTngMW9HjjN1K3NgB6el8EdkoFfL0bdGVea8eo7q4x7uV+o7xqM
         O9oYesEi9/tVtgmX9PLZOHvJ4CkMuOr4JlPLobucQVnzDl3LECX8GP/Iy5l9+azIy37o
         9fq16NShIe+uKz0d1v191JBO++CJRREqrIWKZ1hiGdOkQAtNOlvbSPHjHmNCbT6vb9u/
         6o5UAJeSlsChkgeEQr7rCaTPDTq0abPu41W3iFLx/DEouprreF+asZm/VO+hHurTQtfH
         kEY0i1INLjBGQ+zAeFKmUZECMCvyyPoN7/QQHp2KOtNbA4uu0guea6fSdIe9n4krMROv
         F5fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772716309; x=1773321109; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcq84KoG2DHOQvaFzjae5+COKncFgOBfxhwF07ypxdo=;
        b=CESG8a6DH73WmXiWNTU8YA+W/oOOv6fLvz/g3kTrmu2jngVvd2+fHsKwGrHq3eZzlR
         9jVWxiRscTRjqQVfGKrT34c13q0KgQCzD4bGskG14mmq4j9HrQh3AmjoA/bUaSdMCdXY
         GIGq/xOjx0YWuTKjQSu+3v4slghWsf6HtFYBDxnAdiVDN8X0qsOcZ/78KBZXUv9qdooQ
         dXpXS7CVIQ2VaMKJfsPknRFZX3qs6Xd10WQXUCU697l+/fPWKKzH4GfdoHy4QuhUHQzY
         oz7GO500H8HmQwa1DeqjJ0z2sEm+zcSijqzD7ubRDyMQX4KgjG+q5OPK7LGDGqabEi1A
         RkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772716309; x=1773321109;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcq84KoG2DHOQvaFzjae5+COKncFgOBfxhwF07ypxdo=;
        b=fGteg45lf9XP+ucL644vaJL7Dxh4T0QTayBR2eatRE9q39qX4hoAILr7phkahG97NG
         gzSZaUHEAmZbaL7DXoJaiyJgbZZ3AiRjehIQ7PnCJL06zmBSBHfTl3GeqAYeoSqr0XVu
         oXjKfZ+E5tqZkIOdtdeSyBOYUqSt5a0Xs8a3BZADnwoL0RMrj4GNG6myWvZWx+z3Wr36
         j/xktHx8nmI5Nn9UtKd3SDhrPVBJayDg+6Jw7PoVTRWFGFTWAQ7mY6d4w9tnEmkqwyWM
         KZrec+xA+h0obPSTcUwLZv02aCrnvU0hUpm0gQNPvW7rzM9lJJQAxGrDwaGGUxO/9Erb
         snxA==
X-Forwarded-Encrypted: i=1; AJvYcCVHHXeaKxTf0oQynYpZdi0DXlzXZHM0v73ZyInHepOQdy+Xl45zxM1kLMAJdp7ZtpSC+bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37EJq6VuKQ8mxRWGkHErrXfHg19d07muUsQHMiXO2LKmIx88X
	d9IC8RgiHcX6CdZyD7Ul/Iq6/kkwm2URY8NKOlTwJ4Ax28THxWXKphNv8r9NGZeimI2WMDHMyfY
	gTUMze9vgzPBkSLy5H/T976oIkz+9Hj8=
X-Gm-Gg: ATEYQzz7KLTLozCDxuT26psMl+KOLWPEBmXESN6biRCdeTmmH9JYIdbsuPgi4b77t4A
	ApKF1nClsYr81XLvLlJGrEIAQ/mVd/iWv/YYid+B8zoxuZbnIVTVLVar2qHRDP7awczjNTT9DrE
	L4mneTbuotnzfl2Pusb4U7aBlvsX6Qr6pQesoQLkipIysLf8vrowtccLNQQmjGazi7BwhmWQ8Wl
	MDySx0yQXibH6WqOwFEL3BP/dk0y+FnFnYU3XjuMi81rWTjHXpxca80MrycZIiTrxMAjYtNMimi
	F1WojCF0e8xAX7Os2w5cz6a6Rr/Gst5iXSIUfBnePA==
X-Received: by 2002:a05:6102:c8d:b0:5ff:9e4f:6946 with SMTP id
 ada2fe7eead31-5ffaa6c35f4mr2292834137.0.1772716308730; Thu, 05 Mar 2026
 05:11:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 08:11:47 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 08:11:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZx-mrdbZp-7VZfi@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <aZx-mrdbZp-7VZfi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 08:11:47 -0500
X-Gm-Features: AaiRm512_5IRb67gdW4fBurgKzKSiyVNMFw2nwb3HVXzz1X8Ml0x83qi4FcxuEE
Message-ID: <CAOLa=ZQcibb-CHXchv_pG4Uv4wNzkFta84tm-OtL92WPaZdehQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] odb: make object database sources pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000debdd3064c46ad6f"

--000000000000debdd3064c46ad6f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 23, 2026 at 05:17:51PM +0100, Patrick Steinhardt wrote:
>> Hi,
>>
>> this patch series finally makes the object database source pluggable.
>> This is done by moving backend-specific logics into callback functions
>> that are part of `struct odb_source` and providing thin wrappers that
>> call those functions.
>>
>> To set expectations: this is only a start, there is still functionality
>> missing that needs to be made pluggable. Most importantly:
>>
>>   - Counting of objects.
>>
>>   - Abbreviating object IDs and finding ambiguous objects.
>>
>>   - Consistency checks.
>>
>>   - Optimizing the object database.
>>
>>   - Generating packfiles.
>>
>> These will all happen in later patch series. That being said, with this
>> patch series one already gets a lot of the basic functionality, and it's
>> almost possible to do local workflows. Only "almost" though because we
>> rely on abbreviating object IDs in a lot of places, but once that part
>> is implemented in a subsequent patch series you can indeed work locally
>> with an alternate backend.
>>
>> Furthermore, what I didn't include as part of this patch series just yet
>> is the introduction of the "objectStorage" extension. I mostly wanted to
>> focus on the mostly-trivial parts without introducing any change in
>> behaviour.
>
> I forgot to note that this series is based on top of 7c02d39fc2 (The 6th
> batch, 2026-02-20) with the following two series merged into it:
>
>   - ps/odb-for-each-object at 3565faf28c (odb: drop unused
>     `for_each_{loose,packed}_object()` functions, 2026-01-26)
>
>   - ps/object-info-bits-cleanup at 732ec9b17b (odb: convert
>     `odb_has_object()` flags into an enum, 2026-02-12)
>
> Thanks!
>
> Patrick

Apart from some comments/nits, I think the series already looks great.

Karthik

--000000000000debdd3064c46ad6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 65268f0a69942dc3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcGdSSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1FUQy85YTdXN0VmUVFWcC9xTXdKbkRaK1l5bDkxQgprWnBKRW00cG4z
MzAycWsvWCsrVFpISkRwQVhveUttUm1OcER4N1RMTkRtdHg1RExXTzNUc0R5YlQ2cm5wdXczCjhm
czJXNlpxSG05akIrZmVmZHNjOEFwNlpYWnQ5alp4cUMyb2Nwdk93NkxNbUJ3enlGWXYxTWE3ODF6
Ym9iZWgKdjNNcnRpMEl4cW13V1NWWVJyZG5mSDFKQ0FkdGIzOUJPMDhDUkpRbEhMeEdOS2RoZzVw
dHkxUkRtUytpNGdjYQp2ZGViZU5xSml4eEliM3ZEUzBIRDRjMnliaEg1eVNvYUkwa0draTcvOXJv
MW9JM2dvZGEwSmx3R25IMU1yUjE1CitBWXRBcktZRSs2cW51Z2VFMTg1SnAyanU5TXNObU9pV2Zw
VVJybTZTUkYvSEFzSzA0TUZtbnMzeHdIWHFYNFMKYld4bEF2YTVOSTFrV3psUjVtcElHUWxpS3I2
TStRRjdMV2M3VWZQRlhWMFlNanMwcVRjZlFIb3dIZEduM1c1YwpnN09OQzdDM3FyMGVzeTAydXdC
UDBIMndaQVhRWkFiaThQWVoxTEQ5WXVqejFTR3ZwU0xqY0V2RUFFK1RUMkRLCm5CaHNGZjh4VGdz
TS9iRXlQY1I1ZGtrYWw5dGR3VXU4dlpuc2Q5bz0KPTNQeEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000debdd3064c46ad6f--
