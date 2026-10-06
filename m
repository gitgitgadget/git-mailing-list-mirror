Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BDF2E737E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279397; cv=pass; b=OBKsovgN8iObQS244tH9RZdvhm8lnXMIQ91lBw2TllSFWGWkeFO++KHjb0LiQBKyow/J3M6xRpiG0S+6iM9Kq0AZqwDdWoU3IaRItaNyDnC8sT54G/G2RcFl/kB894xvLQ/JnDlgBHUyQCdgqRlu5zEhwHsyomchXJVUKN8ZseE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279397; c=relaxed/simple;
	bh=KMY07J7WCz1mHzNrayc7ywgBJQOilsznSXH1rb3FYKg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=MzxvpP7OA7+tQUbcnzOOvtx5lpEpZcP1+FYcDQzOtVKSenLisKkwQXXDmlEHDrCZKFfjrt9Mfftkbm7aMIj8+ImP74kNCyEohSkbpNVIrGOfaFjfiWGD8Hp0vb8P/wZzopLGfZwOrW8WgvjznLLreVgGg5FTnbtjo/DVfyH28H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tkg5FJFz; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkg5FJFz"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7907f01e487so32423137.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791279395; cv=none;
        d=google.com; s=arc-20260327;
        b=GbTezdqzJWVGTpBh5nem+PqMFsjmXLBJP0jkv8ffqOwoPpyX08ftwEyThG3NAyPQXQ
         QO48U2F+TcevDR+hbMJVkpbQ7bIO5NsHY4unbmMAgFGQZf6/pc2eLKkM8rDR7wpJBV/v
         hrCOQja38H6l5NtiPZI17ZMWVSXQTVvj8q1egHmaoiuuuEnuDY7BEvEQeGt/JLBk6EFD
         adKnN6bKeV3HItlsNVPsakRPQJHAxHIhKKjzNqdXS1zWWi9IbWDjoAhwuKGQzTXnPpNW
         bY3SuEXknzHp0ElDcri2yBbKN6VzNXqy03oF875737JrfcWuiV25b7WyMpjxKLV8piId
         m1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=5q1O+twpRNyOiSucfN+PrGc8kyYqsOiTZc6WoX3za7Y=;
        fh=kUx5K81dbg55raALldwO+oHkpX0qA1HPUFi3f9TgUwk=;
        b=qSsaWdzN4jcmWL6c7pHVn1ysXSjP3tlncm3/u0koFyH2Aul248CmdZjsQOlN8lr8HK
         zVgsp6k0B/dLRcN8Hxw12RVL1XH99OfbJcQQ8H3bC5hXr1rPtW89NYquOaKj4D/xM/Qi
         r9aAs3yPQS72QGo5vMFaABNVh/uUVAKrdQizvY7jxBtf3xFCtz1L9X1IyaDXSrZbhipR
         nOEDDMjBesdXydGGSA/IRaDHbWD+2quYe4+wqQdB5iow2novivevMyg/c6ObULvdmC2b
         en2ImgMhjSEfjpLxrElFUz4LtZyvjxnBBUmQSZeGjCMBJx7ejjR2J/27QnrFJGzrmWns
         gX0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791279395; x=1791884195; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5q1O+twpRNyOiSucfN+PrGc8kyYqsOiTZc6WoX3za7Y=;
        b=Tkg5FJFzjaXylOCbBzC221YD6UlZCYuRdlS6OUhk4S6gXssSk4iEcnqcLcIqgLnpP2
         zYQIwOYln56ZJHZCy/sGR9z92Amz7vugX9K9N81bzDeCBIR3vOQZMIm/hgl9J7iClIKK
         jnOlDOvqalGvT3Rjiewa4qYYDe+FtdY2QHWIObNyccGCDsC8/oJCKDMjahAgWsSJIXpC
         10b+66+8B6wL94Fdu6i5k25BT19q7Yq9xoI/ggUmDqkBzYKB/oPakRV35+o8n06lFtNv
         7NhlRA2vPbpIM3RrqW0lfXf11ezXaCU+14AOLXEr1iUxjiEirL4SQ/EXDkgPBD3XchjW
         klSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279395; x=1791884195;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5q1O+twpRNyOiSucfN+PrGc8kyYqsOiTZc6WoX3za7Y=;
        b=IzC634sPwLYAHAUTIXJ6341IHzQEgLWsfwQCvBsmLKuJ+Fiw/EWV/Bbm4SiohV3KXv
         i8ribztg9gOuOusnnNS8/l5uIc+KI4cA1OdlvadtwbpbbSbwI8PD2wpePVLNkBmzs8d+
         Lcn3xSGkNbik4TP4ZWC6gAD8D4eX4mPFKsepm+MNUXXsimHAc981x7VbPOldFZb1/7pe
         JYtMDSs1x55UkumWROeW8Z/guPR4V6xC/GWZqKVuOM+pBXymOmAidZEiP2NzJZ0+hLOp
         VmFmQ6uqQ/ZP1zPziYepHKq0V15KI3hUnXsZJqBrJzVlKF2yn8XIH00/A6yJ3CDHvZ1i
         QdUA==
X-Forwarded-Encrypted: i=1; AKwUvBx0jSipwu1tS5odzRAWJxE7l61UuL/h+/kzDk95buu76omZbf+bQSXAafZLEzf1Ws1D0QI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5qvysR4Oy9jC+pDvOsgg0WybtxhW6avBaJHmwboH0o/ykiQW+
	Qa808XF6rZkmQIKx+6p6xPiI6uHYziCgWWbXW/Dq/2vO6m4T8d739wHKdleHQDNogCIZ+VtvTAD
	Q9hNLApoTo+LJzuaa17efqEPORr+gTWQF/A==
X-Gm-Gg: AYBFou2k6dCEkYUp3dN8U+7WaXOmdjX0kVK4PABTyP9TN1dtQS8GtG+Hd0WMkPhZT9W
	AI/r2s0SsmmTgqzazcKBPa1kddJ0aMuLAkw1QUdvoQ7r55/CzjKf6E8zs5mDBZ1+U4sfPmibMt/
	O23PxM/SYUMBekXEoKi72ZAp+QUTEPNmgbzpb/nr4HYdGKBIfw+OpTn76yGVW5ufRF+ok30W8Sf
	LzS4YjKi8FWfec+tEuoDpHQnAjC1chCnyPxNlkoc4XWdrsOIWaxX5B30YE7S8vsMVDafAXyUy9b
	kImCOWaQVZL71oFL6p1HC88WHDH3ZVaiiqKoX6ANPMVC3IKQE+bswb2dHq5ktqUQ5vpCvrOq8fA
	Xt0DdS425qFmJ/7xNB7l0/OSZX9B4o9ou30zegNjBzTiMwQ==
X-Received: by 2002:a05:6102:2921:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7c87a3180damr117458137.10.1791279394637; Tue, 06 Oct 2026
 02:36:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 09:36:33 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 09:36:33 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87zewsf13b.fsf@dev.null.iotcl.com.invalid>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261002-kn-speedup-packed-refs-v2-1-2ae75772ebc1@gmail.com> <87zewsf13b.fsf@dev.null.iotcl.com.invalid>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 09:36:33 +0000
X-Gm-Features: AclHuK9ulZGNK9Kz_sGahtIdUoG5NwikxMSio3X9BvqCvjCyEHR3quB35oF97eI
Message-ID: <CAOLa=ZR12Xc2ZV2T4q+HZTa4TfeO8G7GiabZr3EYdrG-n6YA8A@mail.gmail.com>
Subject: Re: [PATCH v2] packed-refs: use `fwrite()` when passing refs verbatim
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000002f10b065d28bc86"

--00000000000002f10b065d28bc86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `write_with_updates()` function uses a `struct ref_iterator` to
>> iterate over all refs to write to the temporary packed-refs file. It
>> receives the iterator from `packed_ref_iterator_begin()` which takes a
>> snapshot of the 'packed-refs' file.
>>
>> While writing to the new packed-refs file, writes are routed via
>> `write_packed_entry()` which uses `fprintf()`. Even for references which
>> haven't changed, we use the same mechanism. Instead, let's track the
>> position of unchanged references in the snapshot iterator and directly
>> use `fwrite()`.
>>
>> With this, any sanitation which was happening as a side of reformatting
>
> s/side/side effect/ ?
>

That's probably better.

>> is now lost. But that was never the job of this section of the code,
>> since the main intention is to simply rewrite the remaining refs post
>> deletion of the selective few.
>
> Agreed.
>
>>
>> This removes the unnecessary formatting operation involved. We can see a
>> consistent ~20% performance improvement when deleting from packed
>> references.
>>
>> Benchmark 1: update-ref: delete ref (refcount =3D 100000, revision =3D m=
aster)
>>   Time (mean =C2=B1 =CF=83):      28.7 ms =C2=B1   1.7 ms    [User: 22.5=
 ms, System: 5.9 ms]
>>   Range (min =E2=80=A6 max):    26.7 ms =E2=80=A6  33.3 ms    46 runs
>>
>> Benchmark 2: update-ref: delete ref (refcount =3D 100000, revision =3D b=
4/kn-speedup-packed-refs)
>>   Time (mean =C2=B1 =CF=83):      23.8 ms =C2=B1   1.2 ms    [User: 17.5=
 ms, System: 6.0 ms]
>>   Range (min =E2=80=A6 max):    22.1 ms =E2=80=A6  27.7 ms    56 runs
>>
>> Summary
>>   update-ref: delete ref (refcount =3D 100000, revision =3D b4/kn-speedu=
p-packed-refs) ran
>>     1.21 =C2=B1 0.09 times faster than update-ref: delete ref (refformat=
 =3D files, refcount =3D 100000, revision =3D master)
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> Changes in v2:
>> - Instead of using the existing function, introduce a new
>>   `write_packed_entry_raw()`.
>> - Modify the commit to also note that we lose sanitization.
>
> s/commit/commit message/
>

This doesn't go into the commit itself, so I'll leave it as is.

>> - Link to v1: https://patch.msgid.link/20260930-kn-speedup-packed-refs-v=
1-1-111cd03d9b0e@gmail.com
>
> Okay, I'm okay with this version.
>
> --
> Laters,
> Toon

Thanks for the review.

--00000000000002f10b065d28bc86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 43112822376435ab_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRXdSOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1VGQy93TTFka3d4bndYcjdXeWxPY2ExN2VqUk8zWApWQXI5OE43ZUky
d0VXZUc5T3pVcjlTUEF3d094RDUwelM3WEtSVWRLK2lkZ21zTkhlajVrNnNuNC9JSnhDZU1tClRL
NzIrZlNiQkxnUFFEY3hhS0N2T2hOZGZlQW9Rb3g5TWZBakswQ0swazR0OEpSci9HRG9RT1JqUVM3
ZDJvaksKR3VEZ21XVGpOdTd1aUlyWjJiSThOOUs4TXBNVnlYRTk5VFJWYkNHUFVQRFZTdWFhcXcx
aGpTWlBPSVorMFMwWgpGYVdRQkhET0xDaTByUHRrbERNdE1Oa3ZxcVVWbGFicTlFRzlsamova0lH
RFIvODBMSnJCS0Jma0xjc2hWZXlECi9MY3dpdXRIS3lpSitWWm9yUTk2MGtLTDhvRzNuNytYc004
SFpoT1ZOK1VXYjh4Wmh3elNadnJzZFA2OHowOUQKMnpaT01xck9IUFJYdGdpbXV1aG13cFczc0hL
M2hwbWRTQlplaUNUd0JMWmp5S25DR0dEUXIvcTBUL1RKYkhkdgp6R2xqa0NJZUpFTWNqblVQVHI2
YVpCalgrWjQra2xHZjhKcjRtNFplYW4va2lIMXY4cFdldktRM2FvYWV1UlZSCmVGVmNwQUxWS2dS
SGVoNzlsdC9TQzJ6eFN1bElyVkF3RmZpelZjQT0KPVdtT1MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000002f10b065d28bc86--
