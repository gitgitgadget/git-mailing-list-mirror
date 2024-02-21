Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197B3C47E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506250; cv=none; b=u1qBVuD85e8FN4dYIXlWYfqcTQENlIw4cDmdH8aUawrtR5VeEvARw+ZUkXUtmoawRL8rKupAzTJyt6d47nbWNW4FWK73tmF4lOeZ2OSZllYb6SyKIYq+6ly5OUYL+E+Fe0EoHEetq9wCP+CDs93LaeF/7oD2OxtJxp9M6TRn+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506250; c=relaxed/simple;
	bh=MQrM8HWj+yEYbENsUTgDvN+Tx118SRrTLQ/zj+x9Lfo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=QZyPBSbZiL09YPBdRp3Awg4hEzDQqf5KBruk4TtzELNXzqKbz7vTdmOehH9ElHKLrVPJAE32k0axq0Ig1+HVIavhoTmkAaCKzm/iz93dS/tryWJc7OfKl2lHL9TTho3a+tFX97VGBt1so97cHc0GQ+X4sHIAAiDwwKHBE1zpvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tty6ApVt; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tty6ApVt"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c17098ee8eso132742b6e.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708506247; x=1709111047; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUYT/vvTUN4pyuUg91vEogR1hSvOAchNU026auDtI7o=;
        b=Tty6ApVt3TIOsrXtOf8zfZnJNGTql+MClStMW/c72/D+3io7uyUSnCCLnHjzIm3QVt
         tH3XycoI1gtLJ0MlT4k642W2UOPiQyhk6Qyu3n7dYVJ3flLV7CYZgJS5V0koZqELmdbx
         UdCspzdkb8tdjpPT2hKjTtaDchnv5G86dpUAt3FYW74exhuuv09XxpC9Zrkhw4m4n/sS
         89qaqo3G5m/FsMwCVm55V3zRQrSRMbebf3eYJLDV/8kno+4gfLXKEGvItOOWeiatCnPs
         y2f7AIWB2NryFaj3zeVLgIj5yOCSZkqo6Xrtz1Lm5yFOdf4mWlWMjntJjsqiLuK3X0nu
         DWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708506247; x=1709111047;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUYT/vvTUN4pyuUg91vEogR1hSvOAchNU026auDtI7o=;
        b=RbakEmrNquumyIl7W5HBsz7aGXnLzhyHin9ZD0Itnr5EnB/2JhgDzsDYPEEhYA3B+q
         fiFkdg54WhF7lxQgjIxHYIpyrgBUeM6HW9CfZer4umDcY74B+IucdNGwjNeEWgT6HkRv
         uMpbvBIgfzJhnxddnrHnJQ3vR1wqzxv5EAldDDCtZi8+jYMfoZuWME4rFs8UISRHSdZv
         axQ+KwK+TPtH9S8/Icg/8pPSPdLi9LMR+3hYEZn2bKkRl9MLc7rA3qk9El1pgK51CByO
         oEUKHQR3WTgVl5E7eIDySVMYIryCrO9TmQfURcqZG4NQzZpzxJv9U2l04FGzBB37zjZ6
         r1fw==
X-Forwarded-Encrypted: i=1; AJvYcCXaqn27Qwfo9yG8Uo/jh8eJaXhmjWcYNuNRZiFLYgAxw2djZ/wuMGKPRLCYVHi6aVrHEhNbb8Fi2ulKAkX3WzncEWor
X-Gm-Message-State: AOJu0YwoI+IhA2oXIUmoj9zO+uZ3Tl86olow4iTrlGWkT/hAdkcYcOA5
	QhepFLSbK0bmK4ACdGk2tL0Pi2EzMc1PpJCYdHJ5GFlF3ZHSeFnYc9/g3SzOAK63tTCfT1Np8tk
	EvwHxUF6b22U4e+dLIfySjwSYPclHL1/Ekm8=
X-Google-Smtp-Source: AGHT+IHAXxmpW7p62X4jX/3YekegCPvWb2MSQ1kkhHN6qlhYQuyqtG/+SYX1hUznQT+bSYq6kGcRC+8MmUUdRPE4uAk=
X-Received: by 2002:a05:6871:58d:b0:21e:ac8c:d39e with SMTP id
 u13-20020a056871058d00b0021eac8cd39emr10432273oan.13.1708506247705; Wed, 21
 Feb 2024 01:04:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Feb 2024 10:04:06 +0100
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqplwrqbd2.fsf@gitster.g>
References: <xmqqplwrqbd2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Feb 2024 10:04:06 +0100
Message-ID: <CAOLa=ZQOtDgyWxmV+C9r_wfqo-KdJ5uqW4KwJKD8WdT9qM0t2Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2024, #07; Tue, 20)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fdcd1b0611e09bf4"

--000000000000fdcd1b0611e09bf4
Content-Type: text/plain; charset="UTF-8"

Hello,

Junio C Hamano <gitster@pobox.com> writes:
> * kn/for-all-refs (2024-02-12) 6 commits
>  - for-each-ref: add new option to include root refs
>  - ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
>  - refs: introduce `refs_for_each_include_root_refs()`
>  - refs: extract out `loose_fill_ref_dir_regular_file()`
>  - refs: introduce `is_pseudoref()` and `is_headref()`
>  - Merge branch 'ps/reftable-backend' into kn/for-all-refs
>  (this branch uses ps/reftable-backend.)
>
>  "git for-each-ref" filters its output with prefixes given from the
>  command line, but it did not honor an empty string to mean "pass
>  everything", which has been corrected.
>
>  Will merge to 'next'?
>  source: <20240211183923.131278-1-karthik.188@gmail.com>

Let me know if there's something more I could do here.
Thanks!

- Karthik

--000000000000fdcd1b0611e09bf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfcb53edbae86dc5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YVnZJVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODZxREFDVXZBUVFJbTJuWm1MVWwvR05TSzU3clUvOQpzWEVaUTI0Uk1M
SW9yWDlRQXFTZXl2SGI5T2dia0U3QnpTUHJPQWIxS3lvNlE4bThCOEcvN2RqQUlhNGhZSis5CnU2
SVVsdDhEQ3FUbm9XTS9ybHJIUXMrNmNsbkMzQmJmZ0NET0hBQ0doa2FzZ3c0Qys2OEZvK2RXWjJV
Q0ZxZmwKR1NNMnlMS3RWRzhQWWZ0TUV6UDdPTUtpVkRITnpZT3RNcjhaUk1XUE9QUlRSZXhZWEx6
eVdkb0RIOFdrNW03Vgp5NTZ4RlVmSERHWUlMNDdlQ2VUZ2FsWk1tOTRHVUNmMDNXdGdmbkZmbm9m
dnY0RGRKcGpJTlM0TFJROXl4dXlVClBFajliMmFUQ2pudkQ5bVRDUnJHOFFZT2IxakdVM3VOUFVv
Qm1OeW9zU3ZXYnRUYzAyUG9nQnpKdjlmbDM3a3EKdVE3bnQ1L0QvT3hhREFBWm9DWHk2L09sNDVs
M0NQRVdEbnhtUEZPWHZMV1F4RTM2dnViZ0ZhRjBpOUc2VHJxcwpyR3pDK3JPMW1aVkZnM1RhS3Yr
M3YzWlpsb2RYTTZVWEl2dy9LcUEzUW5oRXZJYlBhRnY3VmFGcVI5ZXQzZnBYCkNCTFlUSFZraWR0
WWY1WXV0cEpVMUltWFVTMlV2T2FRK2c1TTdTZz0KPWlDek0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fdcd1b0611e09bf4--
