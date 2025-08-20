Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233626CE12
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677102; cv=none; b=Y1Ov0bLdIf9uVovQTNmZc1Ll+P9hoB+Vx9vg+j1nig/H/18EVxiIhH6/mDE0AszZ1mL+jEy8w34QVTY0hDU+TXyyZ2WMGrS/hkZSGxjD8fIBDrUIrKEc3bfH+JMcKnRQ+1l20UZbyItzHxAl7uMh+cxLps+XdiD5pQrrovvfw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677102; c=relaxed/simple;
	bh=1qgLjlU6KVG1FYaHvnqycO5DjUJfJ27qWdbCrn5JcQc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAvJLxWZKSSKIGOBIejI6xK8LGM7vaT7o91zVm0cNgtxohk76/Ac83ZvWf88TOG/WSxdwv044/U/jB3sAA4RDDUW3TwWC0STU61cgAqTwbaHOwYvP4RODQnxCdmah0DNSuAZPo3jlz3+kUs3KPZ5XXkl1eF4XKXNF/76cHni8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDqz0KIH; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDqz0KIH"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-50f85dab6e7so2666479137.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677100; x=1756281900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vU2vhMaXW/FaTPnRzrQxpPhXbJ7EYQRpbYR7ThdeLZY=;
        b=iDqz0KIHqHw1Lr1mvwNYS5azyqVEH4VZIQk5KE9AfZQbldsu5WQQRlThWwwe8N3o6J
         MEg3+Eb+SgfgGXeIOR3ewCG1MHO/bO7r/hahiUPb52yq85hSC2i8QreRjdRePSumy80/
         guNCsQiKo/XC7OIcB7QP9bnm336bbJEajGEhB5/mVlu1AQI0NBbrOCsnExkaRpxEq+gh
         w2y0bVQ5jlgnDMCzXPUvaXbR0PHh3GCEvnHIzQ6oFbnIak4/LUsvnPi1eFjN/7ixw/UA
         GieOsjTP4APfSPYITuh3q86GVsbG5/oOR7q+02O8A2nla/GBGsnWBJkEOFFD4eAFrP5E
         qjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677100; x=1756281900;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vU2vhMaXW/FaTPnRzrQxpPhXbJ7EYQRpbYR7ThdeLZY=;
        b=CyBchNiMua033LFhZbQrITkns24yUE3E6HzrIyI9Tebs07t+ImbOlErWt/5AYgcudS
         kS/DdpN4mBS8M2SRqyNd/S2g4Lf7pyBFrgv023zxhVkLMS+6LiR56nJqRg5LXypzlnQG
         jG+Ce49v4Jr0/ZNCdsNA7WglVtpQfeBach+9CLSKhvsCP9jSsN2VELLzKM3WC4ep8X+y
         h5uX8/9uz8MpDoWEfJva8g3HSDnkvkeQE+6VyR/kKR+OLcxmbiiqPSzmi5CqRFKmtj0t
         N+YXZh5taMKd+Q4E/7Qmpqmo+qiSNhSTOcXahrLx7Yeczi0bSihC8asddfLRpZHLWGO2
         8PkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeDLBvf/Hcc9/L6rgtyB2hWZaKDpoWTAH40hNGcFcfxLAqGrnoWwpGET0DsE2+/6AOLtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxM1WyBhkya8yrC6297FODx1khlr7hNXeKGNrvLjk9SO3cju+q
	SnhTfQIRFoGpW/q+b73lMeynmr3Wp37Ik0c+v6urfZr50TdzCCNmN7v4Gdtw+ic5n03apyf1XGy
	Psao0aOjF7BuLZuhHnO5OV3PdNrzyLuIAew==
X-Gm-Gg: ASbGncuhyWRYWwvIL/HBBLr1e0w7qmPMniLbcuWv7ppo8el7PMYOx2wYj3Md/v9gikx
	Npqa0WnyG/vjCBfoHaz7x6RMrOnGRftxyP6NT40UwN89m9iZ5nXwKcf9yWya37FLcS7alt0nCnH
	Qj7LUaoTTFFt7ifOnLYmzQAPt3K4Lb/wOUYb5zJSOV1I7Ns6mfTutLGV7ocVg27jFwDLdpgx6+4
	F5IDUFs3j7HrznBTTtCc1FGZ+XEYB7A4yKmhCghXJQJK1Rr8mA8
X-Google-Smtp-Source: AGHT+IGaVuXOsydaS2MaxApTSqEUL1qH5VzXMw6VDPqMaoVyZKTIufTfcHGg+EFuoBx4DAWUQqVFunAFTR5bLyGiXHo=
X-Received: by 2002:a05:6102:5807:b0:4fa:85f:31c0 with SMTP id
 ada2fe7eead31-51a50c9044emr455162137.19.1755677100182; Wed, 20 Aug 2025
 01:05:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 01:04:59 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 01:04:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt23e0uo.fsf@gitster.g>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
 <CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com> <xmqqtt23e0uo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 01:04:59 -0700
X-Gm-Features: Ac12FXzR9n8GPkFBnFjKFWKd2K2Nz7PQ3oBatrWEs-ajgSzgRU7gBZ9egOzjWtU
Message-ID: <CAOLa=ZRazqga7DCePqif_Hx+z9_OtMrJ_ka+gFmzVvMz-frzYQ@mail.gmail.com>
Subject: Re: [PATCH 03/16] odb: move initialization bit into `struct packfile_store`
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e5b3d1063cc76d91"

--000000000000e5b3d1063cc76d91
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Tangent: Also this is something that is only mentioned in the
>> '.clang-format' but not in any of our documentation, should we add it to
>> the documentation? Usage seems to be around the same for both types.
>
> It merely means that whatever .clang-format does is forcing changes
> to half of existing code base without any developer input, let alone
> conseusus, doesn't it?
>

Yup indeed.

> A quick look around does indicate that with spaces around both sides
> were dominant in the code base early days (like 1.0.0), but that
> dominance eroded fairly quickly and by the time 1.6.0 was released
> it was already half-half (24 among 43 are with spaces).  As you
> reported, among 216 hits for "^[ ]*unsigned .*:.*;" in header files
> (in 2.50.0), 105 of them are with a space after that colon, and the
> rest without, so it is really about the same, indeed.
>
> I think it is a good idea to just pick one for new code and stick to
> it, and if we can do without churning existing code, that would be
> great.
>

My thoughts here too. I do like the spaced version since it reads better
for me, but in the end, I care more for consistency.

> I have personal preferences, and usually I'd like to hear from
> others first before mentioning my preference, but for something this
> small and does not affect readability very much, perhaps I can just
> pick and dictate?  I dunno ;-).

I wouldn't mind if you picked one over the other, like I mentioned, I
care more that we make it consistent and that the formatter can notify
or fix it for us.

--000000000000e5b3d1063cc76d91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 82b89978432136be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbGdha1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzdKQy85SnExV3h6blVDTmM1QXYrMFN5SVdJYm9LNgprZEVwdm5vQkV1
R0gvTGlCRUxrU0dXZmNTVFVFRVZxRFJvbjlLNmxYUS94MGd4dWVrTG53MGttUHJmNkJNcnN1Ckdn
WmcwdnVKYmdZaXdEMzhtcWdJSEhKaTFoTlhyUU1yQmFSZ2pKNGVnVEVvUXR2aFZ0ekVFb21PbUN5
QmI4Y2YKVTcxdWg3ak12Q3V6Z0xyQytkTFdrblcvM1d6T25qSzBVV3FEY3J0U2tid01vTjVITjFj
UXdLNXgxV2o0K3hQVwpVOXFKN2VFQzFQZko1ei9jU1VrR3ZjOERCeStVK1FvaEM2MjNTalhRREd5
MEtsU0ZxM0V5ZVNTSUxFK2p2THBpCkVjcHZTajB0K2FvWUpuNWlMRS9CMnQ5eFY3bFhnQVJ6SjBG
WS9pOXl5VG13emxhakhDMCt0SmZDeHFpay9yYk8KRUREaTlreUFYRTFmc09vclFDV1ZEdE1aNHZC
aXlsZkpCc2RKMDZHTldnWnI0NnQyTUo5YUJLMy9UbW5LY0lqQwpyU3hjNHVPTmZzbTd3eWhRMlIr
U0lSYnBHNGxCRTRldk9leW1JZ2cvTW9Ca05VZWFFdllwNjdhS2RlNHdQSStvCmdmaHpoUDY3Q3dC
SlBmeVhtOFBHVytkWFJiYzNMVWQ4STg3eksvcz0KPVZ0azMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e5b3d1063cc76d91--
