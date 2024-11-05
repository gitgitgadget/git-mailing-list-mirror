Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D4163
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800208; cv=none; b=Bip3PkUrnW8ucly6oMti9ubrZl73+zXIPKPMSkYRBSp5Zr8g+5+gshhdVHTboWcvBTW8OyjuGZptaoFCQ6F5sbk0CVjBS7v/sWNysyXwoTTOD4NXluWLm9h0t0hsFYeHkIz5vO74Unki+zIseSNSIn28+rPj5b/X7bv8uyrPsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800208; c=relaxed/simple;
	bh=fVWvi+wOzSQoTLWFcpQV3EbcHAGpfkRkiDm215Sn+18=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuS075Xy7Z0KIjIzcaJlUyo2AwLBDY9jpR9qoz7sSExpjIq0YXXtcybJthxuM5q5BU8DNDfAq9f5uhVx3cszw6GcPqnRnUjquDwadYXtykjIApv/EMGPVqlHkD66RU053Y7BkrNMso9jWADiLj6iG53W+8gl6+uctTlfRTCifXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a009d0qK; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a009d0qK"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so1552704241.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730800206; x=1731405006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7f6zNhCH0gdOPy29JdNFHYbIji/O6c4iJW4Ad09rZM=;
        b=a009d0qKiCKK8JqjBidh6cPCSI6AEKm9sLFdazsE++YAzGi6ePnsy3JT7sFmbBIOdg
         gyS9Szf3u5N7SAoYH8BmkcUfZ2loutxkhWNrPZF1EkEz8pvgwRKbOiU7PwMrk7vKp9lF
         gvO6bFrSUo0r/dVVR9AFkmNQ/Mtiv+mcD06alhlSgspKMzeEbBnbltivRj99tgkgLScY
         WxTeoeEHKRlgnDgnTOAFFrRzAqQpAkKL2M9f28n7hBuvPl/Q8q0YoZ5CbyZ/SvQDMloZ
         E/b60dUNzqpxq7A6g9lty2s2t2Gy4A+dKSGnoq4p2QPFE+fWnY/KQoawRyDZ/bDJyHOr
         U3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800206; x=1731405006;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7f6zNhCH0gdOPy29JdNFHYbIji/O6c4iJW4Ad09rZM=;
        b=QK/GRKjkErDfLKKmgdn47Gxfwsr1Kp2NQSeIjEJYG5AylnP77/zDUhVhXg5OdWl210
         boKg94UsCZ/cfJgixefcPa49FV7rCuqBmcEkp2+UIAriZHS1MF5e2kc/3s9U514tMD4P
         TI/kdR/TiynwlYiHtCtBmjCxAw83Uf79uJB8h7E3bywYK9GvwKF1NwQUJmwQd1xNx9h8
         lO9TgrxWavh55X792fFdtERVqqo4+7fWiV81pT0A7/X+Jp+7zFX8MwHf1R3n44JPSi/b
         yrnrd3nJXu5p0tiyOiz2I90hOhF5aEtOJgFgLRU92zv1LzaYAms9RRJyOGw+olHfqxj2
         j1qg==
X-Gm-Message-State: AOJu0YynDccBpIviP2YSRjteiKRPsBkEN3GIBDL+adiKRptW41+q94MF
	Fz/sh3bjnAMoYqELWLDBQYu39/yA2qQESZ+vTR/mJ0IpQvG132NGjlQSRVw+l4mV4UmMlGg3kSa
	ZpwUnK2+WiHKEeg1eVLfQWbZFHgY=
X-Google-Smtp-Source: AGHT+IGlRH/ctHir33MmDeKT+1qzyznW5WJyWkDTnqTaENvxJTeLZmMV+NkTwgHrOmBO06CNDOQEFk5p4srqHqF+a5g=
X-Received: by 2002:a05:6102:3906:b0:4a4:8928:718d with SMTP id
 ada2fe7eead31-4a9542a64c1mr20014688137.8.1730800205766; Tue, 05 Nov 2024
 01:50:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Nov 2024 01:50:05 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241104173828.GC2989472@coredump.intra.peff.net>
References: <cover.1730714298.git.karthik.188@gmail.com> <2730aacd8e5add0918d806131d0f31a0b2474915.1730714298.git.karthik.188@gmail.com>
 <20241104173828.GC2989472@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 Nov 2024 01:50:05 -0800
Message-ID: <CAOLa=ZTFid+j-N8nmBXUid+TWSdzNq7jCfk2RF2eCt-Xzu4kkA@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="0000000000007152330626275335"

--0000000000007152330626275335
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Nov 04, 2024 at 12:41:46PM +0100, Karthik Nayak wrote:
>
>> @@ -652,8 +651,11 @@ unsigned char *use_pack(struct packed_git *p,
>>  				break;
>>  		}
>>  		if (!win) {
>> -			size_t window_align = packed_git_window_size / 2;
>> +			size_t window_align;
>>  			off_t len;
>> +			struct repo_settings *settings = &p->repo->settings;
>> +
>> +			window_align = settings->packed_git_window_size / 2;
>>
>>  			if (p->pack_fd == -1 && open_packed_git(p))
>>  				die("packfile %s cannot be accessed", p->pack_name);
>> @@ -661,11 +663,12 @@ unsigned char *use_pack(struct packed_git *p,
>>  			CALLOC_ARRAY(win, 1);
>>  			win->offset = (offset / window_align) * window_align;
>>  			len = p->pack_size - win->offset;
>> -			if (len > packed_git_window_size)
>> -				len = packed_git_window_size;
>> +			if (len > settings->packed_git_window_size)
>> +				len = settings->packed_git_window_size;
>>  			win->len = (size_t)len;
>>  			pack_mapped += win->len;
>> -			while (packed_git_limit < pack_mapped
>> +
>> +			while (settings->packed_git_limit < pack_mapped
>>  				&& unuse_one_window(p))
>>  				; /* nothing */
>
> Much nicer than the earlier version of the patch.
>
> Do we need to call prepare_repo_settings() here? It looks like the
> intent is that it would be lazy-loaded, and I don't think there's any
> guarantee that somebody else would have done so.
>

I think it would be safer to do that, than to rely on the tests like I
did. I'll change that.

>> @@ -123,6 +124,19 @@ void prepare_repo_settings(struct repository *r)
>>  	 * removed.
>>  	 */
>>  	r->settings.command_requires_full_index = 1;
>> +
>> +	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &longval)) {
>> +		int pgsz_x2 = getpagesize() * 2;
>> +
>> +		/* This value must be multiple of (pagesize * 2) */
>> +		longval /= pgsz_x2;
>> +		if (longval < 1)
>> +			longval = 1;
>> +		r->settings.packed_git_window_size = longval * pgsz_x2;
>> +	}
>> +
>> +	if (!repo_config_get_ulong(r, "core.packedgitlimit", &longval))
>> +		r->settings.packed_git_limit = longval;
>
> And this looks like a faithful conversion of the existing parsing. Since
> we're switching from git_config_ulong() to repo_config_get_ulong(), we
> could take the opportunity to swap out for the size_t parser, but:
>
>   1. I'm just as happy for that to happen separately, and leave this as
>      a patch which should not have any behavior change.
>
>   2. It looks like we do not yet have a size_t variant for the configset
>      accessors. :)
>
> -Peff

Yes, indeed. I'll leave it out of this. I'll follow up if I can! Thanks

Karthik

--0000000000007152330626275335
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 59630c558405a9dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jcDZrc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0NlQy8wYUNQL0Q0U05ta2h5elNnRDdGNVVDUjhkcgpHTE1ZdStadk93
bTBHTjVBQjY4UkhidUF5ekgxUE93OVRyY0k1c2hQTExKZnd4V0s3RzJNOEF1N0s3YW93QVhaClBD
blFFTWw4UTNxY3NFYUdodVFkMWxvdGRuSFZrZit3SXA3Y0FQbW1zbTE0bURoV1VRUHJnZTd6VkRw
dmFGK0EKQ1dDNjRTWnRrNUJnQlJWSEhPZFRKYmVOTmlqZ2hmR256UVAxNGRLU3VEWFc5aFFpRHJO
SFgwZTQrS1Q1YkxwNgovaEl2UVl5Z1d6VGtVN1FXTzVZUWtwZ1drRnZWSlNuUzhoWmFuQzVuRHJS
SDhQaDEyNUo1RmtVWmJBWVBYM3BNCmdoMTRVakFYenR3Q3c1WXR2NDBqaWkzN1lLR3haKzZma0ZF
S21vYXFQc2V3cHhMSjhYalFBVGlUMFNSZ0owSlMKakU4dS9YOC94b3BtT0xPQU84UlBYWUtpcnpS
YzdKU2RiRW9ZdXRoTlI2OGJRaGt6QmluMnhJU0Q2RUhWemNtQgpZMEFBZEJNY0VIOGhyakFQbVJI
V2lIT1l3bFI5TU80QUpYTzZTRWNGeVdCbkViRWhQTWljMy9YcTgxd1hxMURvCks0a1ZjekhJOC9L
dHFtUzFxeWd4UFB1a1JCckIyeEd0a2NjcCthMD0KPUNKbWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007152330626275335--
