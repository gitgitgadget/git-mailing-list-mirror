Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E2144D29
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017784; cv=none; b=mx+BxptFfynXCiMLf43hu08eIaLXI+Yq66AHeFmKgckNE1vs0johTDa/UrDXuRFZH3f1nNHb5/j7wdc/xsPJwNy977w4f6+FV23wOT5c406bjE1ke5U9gITNoLe211KIkIStmVnSxx5HYs+tVWETlup80YVBkg02nUY8zGAxqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017784; c=relaxed/simple;
	bh=lG99fQnki/WrpSNm/zICk6Gq3D3a6ufih/2IfM1TJ+w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9YjHDWDAHS/LRseyL6KMaV2dclgv+c+DjZD6crpOQl/2+VfQc5GwV829Lg6deedcswSaANKB8WVuf3MD7U0ZxQDUNkkwH/Z54iE+c0DFURE8XdiQKqySAp16LaKwbkMPiz+0BffDEVBSIaBTjGmoEA8Vlen7Ponn8HZrGk/edk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM7MI+1z; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM7MI+1z"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260f033fda3so863779fac.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723017782; x=1723622582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lG99fQnki/WrpSNm/zICk6Gq3D3a6ufih/2IfM1TJ+w=;
        b=kM7MI+1zgpal4adEWdqtvoTHbVSjGvzINyFXP5Ks7XktMts8e3HHt3PLSHOlDfn6O0
         qfzn0f6x2ZSwXM1JqJ0e/NNKBmoyxtthGKCAgbRhbJfnayQBL1QZlORyzs5ium0kcDXw
         A2P5RzN3LaQAuzZEPrNyxFdbeQcvay8zBz3Z425NeRIkBB9mnp+zbeGFF1hzM0SkzH/k
         4QXUKfsHMJ6TNRWxAZUyNE5oumtt5y5IGkGK5/BkSMZ0e5uiXvrNZ4jU93L7lWGgmYd7
         0WXD1OV8DBGhldNRR88/pCr+z3e5Rf75wZ2+tLz0pO0673w6V+f4VzYNsI3Shv6EKiWj
         9Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017782; x=1723622582;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG99fQnki/WrpSNm/zICk6Gq3D3a6ufih/2IfM1TJ+w=;
        b=HOS81sr/uZC1AgQg3K2TfWoXtn16szU+x/8jb6RN+u3iue3LK3WlEtrTQdTUH/FSH8
         sKcch848OVHtK5E4mKs/yI3y2+5fLi/x2DKo/yKdbLqSL4foiQysHeJaBl1IxS5WKJPy
         sVIu/0n9MN4rxXvUPuG1JdPQakBUTnfrVsaSg47P8W5FnfnPvv1NfkN/C2eG+Ogrvu9W
         Op25K3Hx6zRfp6rU6LRfitQOka9fKMhMsIqu6wtWqv49A6WqXCYh2ZKl8ST3TnA7qc3S
         2US3MOlRoIpgNLJwlJM3MM9w+0UPrpJFJWNWA3ETonBeX5pWcPf1d0apeHsK7yKjRswZ
         1hzw==
X-Forwarded-Encrypted: i=1; AJvYcCX/4m7yV9gWAmawD50m3sv7UHSWVqqUWDO/ilvwY36Gpe6IJbclxh+wlN/mgUhGgL9DVxdKkrmEMxfCC7PpkqpVR676
X-Gm-Message-State: AOJu0YwvpU/mBjNIKEMcLyL627ku7Awi/MzPzh6Ia7/SppVCiDWjS3TR
	v8Sf2AJyVGFCg2KvpLPgDpZIFItQ1akPms6mVQ3wTn5KO81twOstgY+9GXOoTvnZ6Z7Rqn0sRFP
	0xwA//hN0mCaC8Ij5IjDkDZc/D0w=
X-Google-Smtp-Source: AGHT+IFt6hFygFijn0PIPM37Ha2AKkHhy5ld6K7nAimWw4kqaqxEDqg3PbmQNoGqZThPljoiDd1XgwFyR4t8Iv7v9go=
X-Received: by 2002:a05:6870:7187:b0:25e:1532:fa93 with SMTP id
 586e51a60fabf-26891afec18mr21927925fac.15.1723017781675; Wed, 07 Aug 2024
 01:03:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Aug 2024 01:03:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZrEBsym854FtguPI@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux> <ZrEBsym854FtguPI@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Aug 2024 01:03:00 -0700
Message-ID: <CAOLa=ZRV4A2CyugxghHEE6qoaZ1b8aubyDOTC9PuDo1DJLa30A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v15 3/9] fsck: make "fsck_error" callback generic
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d1a97f061f135672"

--000000000000d1a97f061f135672
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> The "fsck_error" callback is designed to report the objects-related
> error messages. It accepts two parameter "oid" and "object_type" which
> is not generic. In order to provide a unified callback which can report
> either objects or refs, remove the objects-related parameters and add
> the generic parameter "void *fsck_report".
>
> Create a new "fsck_object_report" structure which incorporates the
> removed parameters "oid" and "object_type". Then change the
> corresponding references to adapt to new "fsck_error" callback.
>

So since my last review, we've now changed the function to accept a
'void *' parameter, this makes sense, this way the refs error function
and the objects error function can now only receive the data they care
about.

[snip]

--000000000000d1a97f061f135672
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b9973683c0246c0f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hektqSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHpoQy85SHM5bEZra3J2dXNSTWQrdWtyYVpFaSs5egpXWXpvNlhjZm9w
Y1cwWnF4M25XcFo5QjR4UEJadXVpbkk4UDlmYktRYldsTldZVGJuK3lQalRFaWV0UW5uaEw3Cmc5
TERPYkJxUTQ1RkszTDRkK0s4QUd0MFR5YjNWSlJsWXVhMm9FeVczV3c5ZHlSSXFpMG9LWnNYM2hj
eVBKZDUKcjlxYWZmUTJiQ0lpMU5OMVNuRUxML1FINS9mUk02OXBYdmM0WFJRRm1rRm9ndWpqUU0y
ZlVzZGUvMXBCb1VlaworQXltN0hSZHNTTXpUTHdPeHA1eXpZOFNKS09qV2ZhVUUvRFFxY0pMN1NS
UDVSMGRZeUMxQWY3eHdxYlZweDhkCjlPTkRWWlBVcitMcTBkNWJNZzJrY1BqZWFnWlN3MlQ0clRi
Zm5Bbm9CWmhaa2hkVW9mWnIvR0N2b3lGQzU1eCsKZVJWR2p1aE82K2RvVllOWUxOSUpLS2ErR25J
Wk9QK3o2VWF2QlJGWS9YWEplM3hVNlNwdjE0REM4WUEwVFVIQgo0U1ZnRldIY0dmdW0wTXAyQ2t5
TmVpZU1ETVcvOUFCM1M4bmN6TzVrMkxETHJaNzFNL3ZUSjMxanUzOE1ta2tuCllCU1dwQkRWU2dm
ZExGWGdjbDhMeExod0V2a0RNRFE2dW41QzdFST0KPXRXWi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d1a97f061f135672--
