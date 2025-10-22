Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEF33CEBC
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134347; cv=none; b=qPTdfG0cFwD1QO1Kr2CzcCMctBmY3+kWmdb7KiHsW+O/CeySZKITS8eQWVPhLkrigD4JhuRzfBBtOjOP5MAf4G4IQtc5fcDFgtB7NDMPHAisgUVB8xIfsAYEdsBQCLoStvCFJACqVm0w7OIahBJ/kUXaJLwVXflsgdqLvTTKQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134347; c=relaxed/simple;
	bh=DI+2bav8RXabMm8PAQrqqlTwZc18lhhldFFI2mDsdrc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e96Rdw7tvyeYP47ZJAB8vIKlDvYbhgsSQq2Kyi2GJU/sm95Q/iWJO9DkM5X8Mizr5vu6VII+P+kFofETLlmkaB34CX0QIWgAcYZlgC6p3b9AYH8xIOX7yAkGSBEnOZ6Sagt4t2Qq1RaXAUDqGi6pGmSKukW0a5ibd9pwvohx+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqacV6IT; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqacV6IT"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d967b67003so4641856137.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761134343; x=1761739143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DI+2bav8RXabMm8PAQrqqlTwZc18lhhldFFI2mDsdrc=;
        b=JqacV6ITSJMl3VdvRjprDewcyrtfi8SLzFm0I6cygekSL1AK1tmGoAqhUmhX9uJ27i
         k8S0yT0qpMADXBAFqa/AQCHDGeW2DAmUo472UjNOE4tt7usjNj2dusgG4aY0TmUgrnr1
         R3qQ7jPGYb638AaS1NhgAWRCwHhYa6lPN9b9sZLk23r70yAEhqC02c964C57WWT+71Th
         j6n/PdZHNo7Jknp7ZMILGxMiCbp2afce6N5cYDlZOx3PDycGxuJhvDT0MktpGpVsQP0g
         BdiaF7I4Zuv6C/WnL+wf/+tayT2unP6a5fW2gGDNIVXe8Aaf1NSvUeX/GGKc+aOdHLUj
         3+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134343; x=1761739143;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DI+2bav8RXabMm8PAQrqqlTwZc18lhhldFFI2mDsdrc=;
        b=jd+ZUM6UWLEBOmYkAuLEJvrGFgB6wUKK1vb4RNhSVQLXAo6t/taUW79CEHHvYakuID
         F3Im3mRt1kv5tM9gnqJfFfrbLKsQ7aMiIiss+cqFjbsRKq+XGC8YrSDX9zvhHcVDEvwK
         f33OpPocU9jeH5zEyESK7SBadLGdDFIrcIWskzjc88foDMMdU3bYNDdFNhmz42sH0gZd
         ddOeSm2WCjE6MaHv5dUkTR2Vf8+BbcDLgiByMmTvML72aaX0UVyMVaSmZv91HACKLpjW
         i85E+mhiHO1IWyD+UYnr7ILeLmLW3+KHcmLLM3zoD3h1C0H/kCqfx6qU4+ViHhqnQBk3
         O6eA==
X-Gm-Message-State: AOJu0Yw2YdiV7NHAD5oOnYaZYoPmkCL3a0Lf8AGZljNYfCntiC3Uah4g
	/u7ENhBdxR9lwie9J8BWO6bHlnsc59Ze7S2TyounYz1yfWtQuE0YYiEbiL2E0wj64GBRn0Zc6R2
	mgz1SwOUoYLEc2cQa8RS26Mzv4C/4bck=
X-Gm-Gg: ASbGncsTloNwstBNFT4771NiNK5EBHQLySAYgtGqlRNxPbNq08wUfFh/0jJZGv/g7Ez
	bW9UVykb2of4aX2PxB+p+cPWqT7Cf7eq1L+pzxpB3gj+k3MmbZiF2NOO0oYOoGt4O12xvmc9/86
	GOPIa8/yeSZSpud2J/9SL4O04f2sHOLLTy/0eEXsKLmMq4G880nGU2Duvs0qTZTmKw2zAvdbMvv
	c9yaxZOUPbvtJVqkGOj4N7clX9R896S+XjueMNPoOC1drPcskptEXXXH/y92w==
X-Google-Smtp-Source: AGHT+IEpNvt9fWNJBNqrSeaaRMCzBbSEinhF4S6MZ0M5O5C7BWejVMRqWscw1odYBe6BI33YBpjoQPazat332P9zKJ0=
X-Received: by 2002:a05:6102:418d:b0:5ca:a978:8a with SMTP id
 ada2fe7eead31-5d7dd6d63dcmr7030848137.33.1761134343526; Wed, 22 Oct 2025
 04:59:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Oct 2025 04:59:02 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Oct 2025 04:59:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aPcXNOz7HdxfUzcC@pks.im>
References: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com> <aPcXNOz7HdxfUzcC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Oct 2025 04:59:02 -0700
X-Gm-Features: AS18NWA2wPtNcr3Z_COmerIL9RkUY7ETHCDGAfOfmSEsXyZaSbgnbrF4VnzT_JE
Message-ID: <CAOLa=ZRmp3PDg7q+SEirO-UXZdvE_nRvSYCMYRdqa72OcTaauA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] refs: cleanup code around optimizations
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000f2ac6b0641be0a41"

--000000000000f2ac6b0641be0a41
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 20, 2025 at 10:18:28AM +0200, Karthik Nayak wrote:
>> This is extracted from a recent series I sent [1], which I've since
>> dropped to follow up with a different approach. I think these patches
>> hold value individually.
>>
>> They mostly cleanup code around 'git refs optimize' which was added
>> recently in db0babf9b2 (Merge branch 'ms/refs-optimize', 2025-10-02).
>> The code in the refs subsystem contains both 'pack-refs' and 'optimize'
>> functions, which are one and the same.
>>
>> This series unifies this to only retain the 'optimize' functions and
>> naming, since it backend generic.
>>
>> This is based on top of master 143f58ef75 (Sync with Git 2.51.1,
>> 2025-10-15) with 'ps/ref-peeled-tags' merged in.
>>
>> [1]: 20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> Changes in v2:
>> - Squash the second commit into the first.
>> - Change some variable names to also no longer refer to pack_refs.
>> - Fix commit messages.
>> - Link to v1: https://lore.kernel.org/r/20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com
>
> This version looks good to me. Thanks for all these cleanups!
>
> Patrick

Thanks for the review!

--000000000000f2ac6b0641be0a41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aadccc0438075b37_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qNHh3UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjhDREFDUEJzaTM5V2ZoSW1oUFF5dldNbEk3aFZ2SwpabnFlNU0rOE5U
eE04QVltQmNObnlNNk00bDZNTXUwS3JSWXhFdUtQR3lXc2pxMGNBdDQ1emUrQzF6OVVMYURwCkEr
L1VOblA4REdHdE5aNHYvRDV4Y1dyR3ZSK0N2S3g0c3cxYW43M3oxYXRQUWpDblIyT3hKT2ZhUmhN
SW8yMFkKMzZoQ3ZNL3ZVMlY0ekZ6UnQyOTJ5MEU4NklaYUhsbmcwbTcwZFMwakwyaUFlLzBVREVQ
WTZDR29vQkNnMUZEZgpKcS9OUnhlT1VYczhVUmZmRWJJdEdUZ1NvOUF3ZHhKSVdNY3VKRlpqS0Iy
STloUTY3QjFUUkJDSkk5Z0tBbXpMCmlGTE9tRThhd2ltZktrMms3MkFlWEJOSFNTYzB0WGhGQVJE
VGR5S0xOemwvWnR1YTZaUnM4cGtSQXlmUzVPUjgKYnNxQ1piUFhKbVNTemdsODNLSzZQaVBOTXhQ
ek5XdjFlQTA1ZlJqaWY4OElNcFRhWG02aUdEZW5aM2VqeUJuRAoyeWkvUFRuNlhMdE0vd1dPY2li
WlAxQWNQeTFRYWNMcitsQU9qTGcrUVVMYnpCZVg0UGpjVER1ZWdtTUFUY1hJClpqNCs4bHZlOHI3
eUdtRmlUbnk2YmxoTGY5cTlRelNBYkk1RjlqRT0KPTBNYUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f2ac6b0641be0a41--
