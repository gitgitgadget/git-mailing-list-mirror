Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14C20124E
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488354; cv=none; b=ZuepfDWQL6RFDvd1Zs+vVeyEc/HAbxKH+xo1uZo0DnrcwHxv5MIlwYbqQG8Wz0iVR/aaqLdSBX4cM/xkdWGMXIfeO1DjTPHS3YiKYtm/4IL2Laf1aBod7HbfPy1b6Vs9khfWG7n/49rzsNEC4T1LRFZUPBiGm27+FniYsaCd6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488354; c=relaxed/simple;
	bh=LzhCpQ+6W7wvNWhSKesjM2BUf2NuIsViBhAo2gPV2eQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ5qtLwLN2oI2Pq+mvTkx0SRoSBAz+dWzI3QfgJwI6iA0lMoEFrlwSi6TnqtMPc2+i/EyGp2fsIk/q1vP6pd478MzPa8q2t1crfrR7wL3QJ39QeRgMwQ6PWUuGLiIom3UK1uZE7hn+0+U37w7gpr2Fo0GpI1nwqVcqjOoPrbf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMAJA1/R; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMAJA1/R"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29737adb604so1157151fac.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488350; x=1734093150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJnYhecshx+cozcLkFTMiV2NLTQMyr8hu0kcxAMBMzM=;
        b=cMAJA1/R5mlc2vw0lXsnIuvWVchNSttQWaL1S90BV2MOAu4PqVoZOi0sImJJg7Y45w
         rgGTv15DOhT6277/A0vDjV5zgq0oO+YNo5QOV66LZPQyvMCd8E79UhE9aWvOmEwWBumT
         3AYi2PMj9gAHxqI7Jpc/wpWb6+osBcBf5045MWv1impJVlnN45Wi7rVhikzrc5dliR6r
         Abq57Q6gg13wl7FHsXSR7tNZI+YOpvN+asXfMCOo91Qjm1pwQvHiGRmW407eCj5RClAI
         jcjt5Rhe4PCPHz/6PtoQEnQg2Nzw2o04hi20aUlcrYRePeBUSA3I4KrvB4hhTc1g0znH
         6+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488350; x=1734093150;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJnYhecshx+cozcLkFTMiV2NLTQMyr8hu0kcxAMBMzM=;
        b=ZlAoSHeeFnfPSZBnenDCYE7RA02BKhFoMqgtbJuIlq6CBae8yAUIVObdSZ2r13THSq
         Bciz+loac5h9KBqOabCrwRsuhYBYYOIfMLYaWW4iWfrHkG6Sj/Voj11uy6DAoGvXVuqc
         at8iTloDD1yVjkB6M922KjufxK/QXpY9RGCMzhvj1UH+LZSr3keWYHvrMRRSN/+nUF67
         Or76BYNouI6XhWMS7o0ksstLWYKgY/baeN32WFY3nqZGLjKAKNuVPgJbyQQKp9l5V/bR
         oPkOEFAhXcNcetzrcMwG6Nz2Y7q0M+A+52TAIMNWLWy4Xq0k12kJEUEia6m8aUZj+DdD
         CYUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3W4VLtPwQFcVUYQeA/rh/RERBlmGacnAo1VSmdfnREB1CYqKBx47QMHlmFI7/IHsSd7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLjCkyY3qQyEgCmuCo0nDHBFUFwfL/POjLoeM1nT6ZVGw5NQm
	q3nghA/C3eTHi0klnbd36Zmsip01aw1S+ouH9ARU3ha9sYU1ofX0XaWvOE/C285qhCjfJn+gI52
	GfP9nD7NQJ83NuDq17waq/FmcNxw=
X-Gm-Gg: ASbGncvNdwo04nqhHLv3FoaXc3MC3CJ2FugBEPSTluiwDPdyyPZZcufl5oCb8iVbgTE
	mW8aVU/oR7ofls5rmDLXXfzDHjAYdHw==
X-Google-Smtp-Source: AGHT+IGAPRPfMovmbc79YuHVkpzXyYMVy1ME75vwmMLie1aLGMQpaMoUA2V91H2rkor6u2zh7DLk5jlAQFCaZap8XJU=
X-Received: by 2002:a05:6358:79b:b0:1c5:fde0:ff97 with SMTP id
 e5c5f4694b2df-1cb170fc811mr173287655d.1.1733488350368; Fri, 06 Dec 2024
 04:32:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 07:32:29 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241206-pks-sign-compare-v4-1-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im> <20241206-pks-sign-compare-v4-1-0344c6dfb219@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 07:32:29 -0500
Message-ID: <CAOLa=ZRjo27U5fWkqV8GOOO6HUF_=dgDD1Dhm=5Tb5JLT0fOCQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] git-compat-util: introduce macros to disable
 "-Wsign-compare" warnings
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000593f56062899358b"

--000000000000593f56062899358b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
[snip]

> diff --git a/git-compat-util.h b/git-compat-util.h
> index a06d4f3809e5664863d4d0f312c88b3e1364ee74..e283c46c6fa06e4079851296a55c9bd5472a65b4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -44,6 +44,16 @@ struct strbuf;
>   #define GIT_GNUC_PREREQ(maj, min) 0
>  #endif
>
> +#if defined(__GNUC__) || defined(__clang__)
> +#  define PRAGMA(pragma)           _Pragma(#pragma)
> +#  define DISABLE_WARNING(warning) PRAGMA(GCC diagnostic ignored #warning)

Seems like clang [1] also support `#pragma GCC diagnostic`, so this
works with both.

> +#else
> +#  define DISABLE_WARNING(warning)
> +#endif
> +
> +#ifdef DISABLE_SIGN_COMPARE_WARNINGS
> +DISABLE_WARNING(-Wsign-compare)
> +#endif

Looks good.

Thanks

[1]: https://clang.llvm.org/docs/UsersManual.html#controlling-diagnostics-via-pragmas

--000000000000593f56062899358b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 88419e4d61fe4124_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUzd0d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODdYREFDT09zNk1Tc05GNmExTDRiRVhXdjRDaXpZWQp1U1ZETmFnUytq
ZkVGUHl2Ym1HTWVIQnJsS0JJS3pjQ2JkbFhjSm1URktZRW5jUENMTHdBejlkTFlZVzFpNHJ6CnFl
bEtsSnBLa1ovUmZBRjAySDdyT1MrK2Ywc2k0Z1MvK3J4M2RUVk13VFpucXNJVDBIWkc5SndUcXpN
RU1SS1MKeHdrMmpOSU1JaEI4cGZCVnVDRVJQUlRTU2h5eFdLK2svZlVkSjZCbGFYN3ZHNWc2MTNQ
WXZ0UEhqcUtZNy9KTApIRitFai9vTHZzWHo5S0tVYW51Y3U0WWdkU0lBRk9LTmtyTjBCTzJEY0o2
MWtHUlB4ZkRhMk90cHVmT0lXZGZxCm04M0REMHcvdjBFVWhxcFJaUjV2QjR2emVlOHJ2RndUK09L
YWtPcUtvZnZPQ0FKUno3cVB4eksyWlY0d1Eram8KSkwvL2FQVTlqMHdZSytlY1hnNUFNMW9tcVV5
eFZHeXU3c3ZrNzJzT2J4UkcvTFpLRVRBUFMzR0dVb0haVHphUApWUUk3UERQRnJEUXkzeGZpVG5z
dHpDU1NUTUM4OW4rSkl5cENON2J2Mm9yT283UXRqM0gwaEc4UkNiRjllQkk3Ckk0NTFGQ3piZXVh
ZmVPcTdpS3Z3WmJpUUhIZXBDd0VDZlNFbVdWYz0KPVpXYWoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000593f56062899358b--
