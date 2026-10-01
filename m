Received: from mail-ua2-f41.google.com (mail-ua2-f41.google.com [74.125.226.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59AF3C0A01
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849918; cv=pass; b=VsWhiVO4tZsrhX6+QqpkLJ9HA3YPahmCUiajfIexI0jAqOhIWkAwhqTlGQ0d5oxfx+1YtcDWcEZ0xHYai+w+js0GDP8z4+NNQqHg2iZ08eHEqi2+6Kcyo3eWEoS757ZCEvjE5lmoxvmG56u6n2nVEN1ohvSOVd5ZKPPMRVsvabg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849918; c=relaxed/simple;
	bh=a0DOS0MEmxjqS6ptRj5OFl/VbsgUjq5sild1OkuDFxY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GN4Xbrp4mOeTaXUMsMVhnygRa1e4OEkEmH+o0yd2iLKaTXn0WggPCtzmC5m9M1w6vGcRdUqii+oybgKBBJC0LImdQ+XKpC99MaE3lN8afrXy+yVasVPemRKZQxK9Osu0Lrv/PD9yJ96/zGM0ZCtXqSoI+6/9XYrtc6tdvNZITi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3rAHzwI; arc=pass smtp.client-ip=74.125.226.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3rAHzwI"
Received: by mail-ua2-f41.google.com with SMTP id a1e0cc1a2514c-98a100315c0so363088241.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 03:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790849915; cv=none;
        d=google.com; s=arc-20260327;
        b=Qy1C0OZWCx3ey14QVAV3/voC2Z+CjSeWySDoUDvii2y3IdFNhqjhpaGoLN5v38MCMs
         DzN11LX7+ssWdBi3Ju0wE/jyj/D2oXmymm9jqIQytspVzN3dQdECRgohYNI87+2kph61
         HB/YJtnLFfk0rzuDuMgWB6j0FUOGT/t0opmX3XSLpgObIDdrEl9NjH7y9OKsL1wvmQ33
         g6HditeTir4CWMTBXN5+R5B9iRNPF+vk7oWWeGaZ2HzkZUttGKostTjLKkIm4oyO97dl
         fEaqM/X3/Dja+L3bYwtNLmh6nVnqFltnNh0/lszQ96er072hhmafRcYV9pCnNnliiyLU
         lV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=I/uFg25tgHT09MLxAX75cp2ccSY/Y5vPGXUdcB12NR4=;
        fh=Xh3g7ylgJCY6W3+V2kTEk1LHfbH0JD4WLRBvQVMjTs8=;
        b=D62WpXVJiRSqMSws2ffhhXhH8aVlfbqaILWzibadYuPOkV6xpW0cX5Ns7uJazm9USi
         yt+A5S7JS259P7fKWG9fiAxVXLh4JhxkwkhdG5KSSIgpQVSJMw3LnY/6DtRvxOdMjv5o
         kx85L7fbwSeCGj0IS4AQWXZnuM0KfiLQdb96pakJpFOiCmhbQcLuDs5b+FJOPO9m32vE
         x7IEcMWLxwOMdwQznApLmAEL/yw5E/z/PVs9+OkEdkkEPcvvc8ThQuMmq/oXZBvUYtxo
         8w8jaWAFRoNu0xczLpuDX8vkN4XzrjgcaaOWvNrPhc5I3opJCWtY1TDH96CrmdkKcuf6
         pF4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790849915; x=1791454715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/uFg25tgHT09MLxAX75cp2ccSY/Y5vPGXUdcB12NR4=;
        b=O3rAHzwI95aZJzznh5aRsJVF4TQb6Ss8M5D7SH9ZUCgKasTnP95x279gwM/MtJExsF
         YaJfB3/nzZ9l1G3gotWIB5IxZ+oqJVu2S5/ijDNPvEEWg8I+9kU1IO+r0BnI2HTJvkD6
         HM+FdV5YWGINFco/7W37RxNXra1M+Ozfpw2iadt6pILe0VS1OU8OY9Ht1IMkwTzPqeSu
         /twPH0omqzsL6zk3Uk4BvxnWI+1nSCy6v1L/YO4sD4BcWNKrD+NCgB9IDqCKCIsBDqHn
         48BF2Fa1TuFX8uXJjfuLn7BGomECIt5OUXAihBojGfotNBNoRulKAOu6mg6CvRHSiG48
         KmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849915; x=1791454715;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/uFg25tgHT09MLxAX75cp2ccSY/Y5vPGXUdcB12NR4=;
        b=Kdblwv9n9P6kLTsh6j5y5rLXXckYY4FqoMpwt0y8WZIqybzpR4oaqkfZ/HVwveeBWp
         Nf/kP9/vHGQs92RznFPumBPTRDmOVB8EXkWfiv4R0MpVklssN9K/J1GTz//nJ2AfMFeU
         uyY+woW1kpaTtrE26rY27zZNkgQytt6eMcNMa4UjTV6R8xkhmeb1/upkxCSHcbiGdSOl
         Hs/9TkGHQJBTXGQse5S97oaFSBVFsQNfXqiWhhSk4zHCbmDlvWoHvXiv5QCYZLdRY/zO
         s0dQF+VgGUsRUkDQKoPurkG40QBvVLWI8C1i9cmpcZX/DrcoR0Wlqs9DT1ROTT6z5q2y
         nceA==
X-Gm-Message-State: AFq9FYJiemNvnTsr8jX/4utSQBNgJaGQ7kwIU+QOtm1cr2TexMhUei8n
	SjfnjgZQ4PLxd+e245jcgcVleNT/JlKeIrHU3xGYaXafjaa38Nybo+EsjQPqD5vjdN7fXX5AoBX
	Jbn03obWOUc/UAT5A29Davfb0+QL0ImWjcQ==
X-Gm-Gg: AYBFou0rRb6sqg3mv7mE0o6n7TXWPp/NmTxbL0pHsWB5+GpJi97wuGufGldCIHRnwZy
	pz9hVy7kdUrcTNbN/PcvMTzWrOXIjMEsUwndJglr83TRjYOVWlwUVcKe5ii4NPzMjrKpy/c+iy0
	f1GfMj2rcBkCCqlX61dpUvx0cO9uOYlhJSo+gNdX2dtIi0vXbpGZT9l2drVDH3IbBVp1Qcv3+cg
	35Xor51GpeJGlghRbQrny+/Zjb1DZ8YG90nCuhjbrDEVhmMs+QJLvIcjchXEGKHH9WUlK6/NVUR
	P5dEgiicfmeQhGvs0GEpdqLE+/YrH93xc+oKYLPfYOA+aTuxlRm/nUL4vsLLZKePdZujHdQahkA
	z+5idWKd/n5eGIGZ/XuADM4a3+eklGeMu09JHVrGX1VzF0AiRa4VWXz7Nqw==
X-Received: by 2002:a05:6102:3e92:b0:7a4:c3b9:1e99 with SMTP id
 ada2fe7eead31-7be73599356mr880674137.19.1790849915316; Thu, 01 Oct 2026
 03:18:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 03:18:34 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 03:18:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <arz7CNEhQSoDwJ77@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
 <20260929-pks-reftables-fix-timezone-format-v1-1-3df105a95ed1@pks.im>
 <CAOLa=ZQRDVL2Djh4du1zWGg_ABZTyzaWDYYb0PDg3EXAfpn7bA@mail.gmail.com> <arz7CNEhQSoDwJ77@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 1 Oct 2026 03:18:34 -0700
X-Gm-Features: AclHuK8O_GZOz8nRme_OW-XixZDMie7yPHC2LsK2gFgnl5c9cpj8MDQBIxsiEC0
Message-ID: <CAOLa=ZQHhf2obR2OjvgmE5HqRpkWvn9WjE+-LeTx1WYgbQp0Dw@mail.gmail.com>
Subject: Re: [PATCH 1/3] date: add helpers to convert between "+HHMM"
 timezones and minutes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Josh McKinney <git-bugs@lists.joshka.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000000caef8065cc4bddb"

--0000000000000caef8065cc4bddb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Sep 30, 2026 at 04:47:02AM -0700, Karthik Nayak wrote:
>
> One suggestion: I'd recommend trimming the mails you're responding to a
> bit more aggressively. Otherwise one is hunting for responses in files
> and hunks that are not relevant to your remarks :)
>

Sure, will do that more henceforth.

>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/date.c b/date.c
>> > index 014065b419..63ea9dbc76 100644
>> > --- a/date.c
>> > +++ b/date.c
>> > @@ -103,8 +113,7 @@ static int local_time_tzoffset(time_t t, struct tm *tm)
>> >  		offset = t_local - t;
>> >  	}
>> >  	offset /= 60; /* in minutes */
>> > -	offset = (offset % 60) + ((offset / 60) * 100);
>> > -	return offset * eastwest;
>> > +	return minutes_to_tz(offset * eastwest);
>>
>> While mathematically it's the same, but shouldn't this have been
>> `minutes_to_tz(offset) * eastwest`?
>
> I guess we can. It's probably less confusing if we do it this way
> indeed.
>
> Patrick

Yup. Thanks

--0000000000000caef8065cc4bddb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e51839c504bfb386_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xK00zZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1lNREFDbEFmQ3RkSHQra08xQmp0dHgxVTVUelZIeApIQjVLd2lPZWVV
RnFOaXI0eEwyUHEra3cwWjR4cE9SQ2pXTHNQWHVObnZCb0Yzam0zdHAzaDB5MC9qZWdQVDJTCkRV
QmMxYmN3OGR5M01hTFFIWVF5RlhxLzZoMTIzSmJ6Q2gyL1JNcmVEUWNQY1FjTFpnVnlmVjVnOUJi
cHhwZzEKZUJDdDBLNWNxay9YV0FiOXBRK0I1U0F2dXVWQVVqWU44bFRIQW1za1NCZEFOejRPT0tS
eEZkR2pyaGgycmJIMgo2RTBlYk9BQlRVZmxKVDR6dzVKMWdPaWhjaTVGV2dPc2RYbWhKV1hLbjA5
eTBlVjFleCtMaWJVNUZxcm1LYVJnCmpVeG5pZkdTNldZcEl3WVRrV3RzNW1vY3AyKytUMnpEMGFI
K0pkUENyamF0WWY1cUMvMmVqUHNJQ0srRzlDNTgKeVRLbGZlbVJKMlg2blpwMUJBN01lb2RPeGlI
dnhBRjVDSG53VC9ONDgxTUYvSTU2aDhZdVc5R29pRFNwc212KwpNNDVlSGVOTFdlamw4UXNRZGh0
aGFsNzBzeGFoeGhtWG5wRFpsL2ZzdVNnT2FQYUk1V1F2UVc1QUtXaGcrWlN5Cm1CODhOUnorMElo
eFNqNEdVTnZMUkZMekY5bTdzb0dsOTJLa3p3UT0KPWZMSGgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000caef8065cc4bddb--
