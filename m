Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DF305948
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336455; cv=none; b=m8/7Vt/4D7cWQRoTqwH41un+IZYy9QEECnEa686iEJHtP5GuTuYB/xeOtcPvPpdtE+rt7m376LPf+9is1aenrygzCYSfbr5FkCDJTEUUvxrshegpj3hGZCr3UgnykVAbCkc1RflukLw0mcIDqIP6yiGO1YHegwSRkqXLsfaX4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336455; c=relaxed/simple;
	bh=vudYJ6QixXeMxn8EHOxnGshpBTAwmaM1itobSNLleFk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7RJtiWuokWAACaPkD8H3Jmadk++ukeDcz7dxEDttRjnupUyDwePOmy7JXAGQTMp8LelUKztnrHz16R6sURj4voDOD79AX13RWV2G7YfwxKN2OsIAsLE6QuUsAWVr0rJvQgZSjxAMjwbKUsFeM4/jregzYQ0XezqZ7S9Rt7P1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAqtTWKL; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAqtTWKL"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52a8b815a8aso2303931137.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757336453; x=1757941253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xmTX6denuMO6xjpSkSYelEXsfdzVJWjMqJlSqFSxVIA=;
        b=aAqtTWKLm4ms7JXfr0bBKnBsadSoXpoZOREmy/CPiAloNtBY3soC/iDek7ijqdqMDf
         kOTUB5t0gTYyztPCiqUt5nsXXznmManfcaMIzcstFWFqpFZpEkRft2WRRE776j3OyAMp
         Swd98KOxEz9SWvqTn9gfMlzOjZNpX5b72t1jxSiOQT4uw79ixE7P6WF4TP05wDKKPnJv
         VmbJQ4p9ittfst5bw20IqhL6Q+EyoGm+wUIOdA6god7RGXFs22FTAfr9Dm+64bxIlKRb
         GiCsjiINfzkb1pfnTJe+65vqZTaq6ckapFZFUJAieChWUpvPFGAuj7yuWfLSJfRuY1ZF
         w64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336453; x=1757941253;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmTX6denuMO6xjpSkSYelEXsfdzVJWjMqJlSqFSxVIA=;
        b=v4l1axDLAXCUMQHznAfqcdmULTb/EtREl7lg9Uo6kX0HAN10KkjR4reEvHs42B/wxs
         SoLPVK+33EKW9MkR/NBtT/kciRjOFenoIKaUMqg2d6wGuxCNga1wZtcWqUwj9EbENCXD
         cfSX9nu6edvAzW3ldbOdxV8jj8eG9N+4Fm0DZHClUU2GFhVSfn6vWfzdez2841wjOJUa
         LCibUpXCIkentznnldn/vzgMuGrLQeoURKbyjr3wOtg0OTv7xPYPvYp0G2dmF+TqDmPl
         xvodskAe2ZE1ED1LOPROpSrHof2Ez243JwAtTOhRVl/yLG3LZGjrjLV9DSpORWj47jko
         fBRw==
X-Gm-Message-State: AOJu0YyG/cRBJfuefQXv2UESNsgpf4mlEdnuPvZXlV5sG+OkLn2f4Png
	MCafdbIH7fv3GiJLlQGuoOG/Wc41eFJOyYZnvbnT65VmXRm4GD7DxGMeLGM8mcTPQClZ2e/AITO
	hxq5HB5XWUGap3uZinFRKTATpZA5wfIU=
X-Gm-Gg: ASbGncsRLGZUy+Fp/efn3H5K8Yve+oJQYikLIPRCuIOv/vgoWOPfuIzrlHIPMqgxCVg
	a3WvtezVlgu/E7sgeZIuxU4teXXbWWELVFbILbNtyY+hcZARtX3XzlSs7DQoQpkvONtZLIqvsJu
	wLV0Rbmh6wbMtM+U4FW6iePvvYdfRXHxcy270Sv1lJow8qB7/rUOygK+OnzC38iu828Y41QSgBM
	vQbqDLpVN1E9wcWLDfE2KQQLv5HzRgEqvamNq+RGA==
X-Google-Smtp-Source: AGHT+IEiTZz1tzee+Zt5mQtA+E2Bk3Tb2Ikacn3MlYUQvasF2KzUAoE3X4pADi/0aMPIwhzS5P7ErHwIZs3ho29L01g=
X-Received: by 2002:a05:6102:3709:b0:524:51e6:4bf2 with SMTP id
 ada2fe7eead31-53d0e48f315mr1937918137.15.1757336452451; Mon, 08 Sep 2025
 06:00:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 09:00:51 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 09:00:51 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwm6gh4q3.fsf@gitster.g>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-1-4f96b3834779@gmail.com>
 <xmqqwm6gh4q3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Sep 2025 09:00:51 -0400
X-Gm-Features: AS18NWAPukCMUuwXVPVf42rE4t41HpuP0KTAys1sZsZC8gGAUOAHakpneB0Cl2c
Message-ID: <CAOLa=ZTuZ3fOr_wkQ7TsEVRKjKynei4uF18YHygpcafXT9Qjmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fsck: order 'fsck_msg_type' alphabetically
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ffef7a063e49c689"

--000000000000ffef7a063e49c689
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The list of 'fsck_msg_type' seem to be alphabetically ordered, but there
>> are a few small misses. Fix this by sorting the sub-sections of the
>> list to maintain alphabetical ordering. Also fix a clang-format issue
>> where the escaped newlines are not aligned.
>>
>> While here, remove a duplicate instance of 'gitmodulesLarge' in the
>> 'fsck-msgids' documentation.
>
> "A few small misses".
>
>> diff --git a/fsck.h b/fsck.h
>> index dd7df3d5b3..559ad57807 100644
>> --- a/fsck.h
>> +++ b/fsck.h
>> @@ -20,82 +20,82 @@ enum fsck_msg_type {
>> ...
>> -#define FOREACH_FSCK_MSG_ID(FUNC) \
>> -	/* fatal errors */ \
>> -	FUNC(NUL_IN_HEADER, FATAL) \
>> -	FUNC(UNTERMINATED_HEADER, FATAL) \
>> ...
>> +#define FOREACH_FSCK_MSG_ID(FUNC)                                  \
>> +	/* fatal errors */                                         \
>> +	FUNC(NUL_IN_HEADER, FATAL)                                 \
>> +	FUNC(UNTERMINATED_HEADER, FATAL)                           \
>> ...
>
> Please undo these "pad by spaces before backslash"; otherwise we
> cannot tell which ones are "a few small misses".
>
> Thanks.

Yeah, you're right, its much harder to review this way. Let me add in a
commit at the end to do the clang-formatting for this section, that way
we can drop it if it is too much noise.

- Karthik

--000000000000ffef7a063e49c689
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1a9253dfb415e6d2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pKzA0SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWxQQy85dXJ1TDhmSSt0THdtaWpPMkRJTUhiaVQwQgo1aFZqa2pKZ0hj
c2xzeHczRGNFMkhjSDI0VkxXQUkyQ3pkWDg4VHJFQUFybXJHaDZES0lnNmFacWR3OFY2VGJ3CmtS
UHVISFYwckZWSXpYdUNJNFdkNWRFSlYyN2R4Zk0rQW8wVllENUp3aG9kRHNSdmdVa3VMakFnSVpJ
UWdSTWsKVldoZUtxZWZRUXlsMmJCTWZNZ0tRbVM5Z1RZQ3o1OWRGMUdJcGNERVc0L0pXZ0I4enhJ
TkhaK3p4WXVJeDY4OAozb3hzRE02WVdmR20vd2Y5NXZ3ODQwSDhuL1QzdVI4L0NkZFIzVHlWR2N5
R1FaYWhvRjMzaytFOHlXcWt3cGZSCmRGakN0ZDhPZjZZTWVINlc4OHJvV3FITnlMQjI0N3I3RHUy
Ty9sTGxSZi9NZEpoK1Q0bnlJb09WamNhNktydWMKMGd5MGxqMlRIQy9pUzZYV1llc0ZKaFVkRFpU
NXpvb2lVMDNHOWttNW9nckR2ekkvYXlyVmJyZWphNEhGK25HTApqSk1QdzZ1K2V4dDhWYnV1Snly
bWorMWk4RS8vMXdTZTNuaTJSUGg3TmFWTTB5MGpJaEZNV09Edm9ZWWdyT1dCClROV0xLdkVzQ0RE
VXRQaUdYM3JoTlVvTUs2NDFlcnF1ckRjcndaZz0KPWY5K3cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ffef7a063e49c689--
