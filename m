Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14AEAE9
	for <git@vger.kernel.org>; Sat,  4 May 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714815012; cv=none; b=XtLwql0LGdYuV3bfMmdpG3jYePDSeFK8+P0CF3Tz7Zveye/CV9VpXhmKp8xQPCVGLyaXO/DaSeZzmh0tXcjb99yVXXd1UBef4RWq7Bc7doteCg3noWuIOy+7faJO6grTnzYaxQJSFFNfq99n5lb3Lz4M5qAKW1RTWCFa7b8RPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714815012; c=relaxed/simple;
	bh=NjtN9S5fTYn1qec+0fJdM3xmHVTqiqh9tdPK8XGTxgc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8M/9+nuoIvO3LwB3ltezKHVihuwsUBiHvYcQt/A81Ze2tTRJ4LW0iRLziHRUWG8Gxzb1PmBETrhM16K5stbegscg+V0NF1vTbr+5fmDskttcsX7lCY82olk0UOI2MaFTu+MEaUvIte2WRF9qk4e0Ce/bkyJptxlwZZHWLsuoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyrEeGhL; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyrEeGhL"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23cd15209fdso231298fac.3
        for <git@vger.kernel.org>; Sat, 04 May 2024 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714815010; x=1715419810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6brqSrL6d62ENFXB04ohTOTcMxWPNLln0c/Z5MJWvo=;
        b=FyrEeGhL80y4hdKEnu/TKJ3MHxphUZg2gMsKlTJ472AZijcM7wxJw5lnPNanG6D2nZ
         lPmx+CbRY21Bz79bvBKDffzll44BIfgi4LZs9jrmfgOFAWZP6tWC2UoHBDkoOubPRM6B
         i2ur81lfGgv8Q6QU6ini23IVG4TVQqeOUrN15gvLdE9Av9nluMoo1yeIQnYsduuay+Mz
         kXV/NDkud8/ZsdDHgtXEWluXwj4e3q+/Xle0wv1wAUebAhvGAdyr8AHtm7ei8g4eaFVO
         zr7n3IXfgAHjnXPE3A7eeMeHl7C6drP0GNC+Ik2AH32yjW/5zlYMlQcTOgQhRA7CpbCI
         C5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714815010; x=1715419810;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6brqSrL6d62ENFXB04ohTOTcMxWPNLln0c/Z5MJWvo=;
        b=iAQ0yQFMem/AgzyHz7fxmNI42repSjT/HS6Lawaf6ldalFlDSc6Vps2DHVMZZ3wWEM
         9aO5QOUFl0qehlmJovmhr+isDBcN1TZpgwSqiv0VAVT4inQu6lVmwtYwHFo5TjGSPR/q
         x8h+PSKMiQd3/4iQr4z9nYRCswnNtN32FE8yaI+91+bR27Et7J3UdIN6qQk98SAywFGX
         J4HV5Hf1g5R4En6Zt8h5KM+LHtXqLBawqlDquf0XTfpkXeUt3BQibjjIvawFezarZR+1
         +WwcjP2psO8Ss6zapwWHoQ2pExy4TiluhRd/IOxAOy4ll7UbHCxvDMNsvD3bx9cWCghq
         aagA==
X-Forwarded-Encrypted: i=1; AJvYcCU/tgbHeaNdtR+k/q+SU0b8k2UAJvQBoVIc30oWPKhi02vPQZ8DYeVJBDL2h0WPZTklcKaX0IS1um5lgylM4yH2jJvu
X-Gm-Message-State: AOJu0YxV9blfREy8CRQBbKMj5F0g6wm8UTV4fb9sZPwiOjhuVaxysuYQ
	lsGYDXBte1q7WJfScRV/Sy4bAmUz+6LcBPpk/rtuyZVY2LzhmKI0OLdF6H9NCzpwquDane/UpzN
	JdeNgymw9zuI+XotjQcfFrEQOWvU=
X-Google-Smtp-Source: AGHT+IErGruy3pqvA/ZvUfZagOKl80uJTxm017ojIOXeCZkttojg1WMzqs1BhOx5nSjeZu/hJz6vXTULtLPCoPG0nN0=
X-Received: by 2002:a05:6871:64c7:b0:23f:309:3676 with SMTP id
 rk7-20020a05687164c700b0023f03093676mr323321oab.5.1714815010082; Sat, 04 May
 2024 02:30:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 May 2024 02:30:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqplu24hne.fsf@gitster.g>
References: <20240501202229.2695774-1-knayak@gitlab.com> <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-8-knayak@gitlab.com> <xmqqplu24hne.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 May 2024 02:30:09 -0700
Message-ID: <CAOLa=ZRUe23MnkBYergXr0YTSwV43f1nJj53diGF6wYHFkJy6w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] refs: remove `create_symref` and associated dead code
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000882e0c06179d7b6b"

--000000000000882e0c06179d7b6b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> In the previous commits, we converted `refs_create_symref()` to utilize
>> transactions to perform symref updates. Earlier `refs_create_symref()`
>> used `create_symref()` to do the same.
>>
>> We can now remove `create_symref()` and any code associated with it
>> which is no longer used. We remove `create_symref()` code from all the
>> reference backends and also remove it entirely from the `ref_storage_be`
>> struct.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>
> This has serious semantic conflicts with in-flight topics.  I think
> I resolved them all correctly while merging it in 'seen', but please
> double check the result after I push it out.
>

I had a look at the commit pushed to 'seen', looked good to me. Thanks.

> This comment equally applies to the "force all callers to use
> get_main_ref_store() on the_repository and remove functions that
> implicitly used the main ref store of the_repository" topic by
> Patrick, but we really should devise a bit more smoother way to cope
> with out of tree and in-flight topics.  For example, as the new
> refs_update_symref() function works exactly like the existing
> refs_create_symref() function, after renaming all the in-base (i.e.,
> in-tree at the point this topic forks from) users to call the new
> function, instead of just removing the original one, it would have
> been nice to guide authors of other in-flight topics by (1) causing
> build failure and at the same time (2) telling them what they need
> to do to adjust to the new world order.  This patch does only (1)
> but does a poor job for (2).  We may want to establish a better
> convention than just outright removing and breaking others' topics.
>
> Thanks.

Just so I can do better next time, what is your suggestion for doing (2)
better?

--000000000000882e0c06179d7b6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c33d2bcbd2955f68_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZMkFCNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNi93Qy85elpseHNIajhmQVJSRTNxNHZEMHB4NExtMgo2TEZ5dnQrK0Rt
OU1kN3pJVk9TZi9OdGVCbzRpcDh3MHpZcFhXaUQyREJndFh4NEtzd3F3MWw4V3pxRFVzTlpzCk03
bjl6c3BXcmhPbnlGbWE1Mi91aHZzRWtGZzhnSXZ6aldVYktlR0ZMa1ExMGhCTklHUjllOGNPblMy
VTlPK1EKS2x0djM2Y3FUV2E0alcxN0xLY1ZCb0pvT0hianFJamlkSUFaZElmZjVMZjVxUC8rV1Vx
RGo4VFhxUjBxb1d6TwpNbVZxZUhRMEpBLzc5WVkxTFRzYzlMQlJJWTh5M3hDQUIwWVJjTVYxc1FY
RXhHSFBxYUlvN1JkcEtYVVBVT0J6CkprWHRXUUIyOGxoanlPTmNPVkY0UXFhWmpZYkdDdnQrY1B4
TWI0WmZJQmdMMmQ1NUN5YUM3LytHVEhyK3BlQTUKdURyTE5xVzUrTnpicSt5aHUzSTdVTGE3QmlJ
Z3UreVdCRkZJMXU2WmFoT25mdDdSeTVXbS85ZXEzSTRnb2cxTgpIWGZvb01OM1NYMmtpeWpNdmxH
NVgvMjFCbExhMFBKZWJJcDJCeWdFcVpDVk1SRzVseFZIdUlNMnNHRHVzbUFiCjQxRXdjcXg1MXJI
SVhhS1pYMWJWekJnd3RFZjVkMmRuV1ByUkRqVT0KPTZnVU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000882e0c06179d7b6b--
