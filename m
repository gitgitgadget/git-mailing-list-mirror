Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9961A01B9
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799882; cv=none; b=msmXF7dUykPW4cgQYptPZ61GPRcjUlK++bjikn5frATuHSXMCJbyh87S7VbLnmMOf1YS2LSFviZIJBT/WC+Kgl0V3BXRgxVab7dR17Eg1D0KPfnqgEGea17ovtc8LKYDROJzO0p85x/UwVsoQa4qcbCI58NR/Np3ky4TUiD06+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799882; c=relaxed/simple;
	bh=SKjcbbbius52oVBGKp+07MP9Rq/53svJnMT6ilBRR3Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTLm4ReNp0GpXRrYt2kCNCFT1HZyVewAy0rDWqQSWAjUjmxTOfyCWaOyO27BFt2PzmfLUbEPptwt4XHNbd4AHxS7evw0G80xU/GN374gJ9kmA2j+8/tfajGyILNrHSvHKf9KK97zyr+SU7U95ezytkoC8MlgxqJO6ikNkOkMul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqrwIAjs; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqrwIAjs"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87ec9a4c86cso538595241.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749799879; x=1750404679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0H2N2mFF6ExGoq2btwkFkJqqM3wleoL8K2XVbC9JY0Y=;
        b=nqrwIAjsMU/pCj4f6ki0jUVoLUKtYItWWYcoTGY25Jf9tnKBArBuxjs3poD/94fRLi
         Tpusw9LlLrBAMgb/JImyOFRiTc7c1tI2MY8oXnH/uzYNeJt9euynPt7uCYLzWiuFegLz
         azD6KOyiMZMY2m/BXMho4Ra8UjQZ1H763kW1eDJxIEegRncNhAjM42LtFXVHlGsv3gxX
         PEk2uzyYx5fuRsNMq9es+yb6sLigbJ0UyCKXqEnuVyUPOCVGUKdKPm+wnipEM+4tmoV0
         k1W3mA6AiUWvqTZNZOVIpVGvI5CnnlcBoD+quiiyjqb4NxYqQMHbFMXLmi9isZgDZ7da
         AvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799879; x=1750404679;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0H2N2mFF6ExGoq2btwkFkJqqM3wleoL8K2XVbC9JY0Y=;
        b=t9f38b4+7Vx3xyTBrz05mBAkeYLQHeFTqKeJKdT9y6zD6EEn+8xx9iSzv0Y1uYLy53
         sriqSauCga5MW4SkrH5zqTxYaUGI9nhkfknzGWkw5s3xqbv973hIFWHVzKsQYwblhSlr
         DeXTv4eLn1Le2U2W/eFHvmEt6i+0sne31x8KoAL/ddIT1ncijEv/JPoo0/HIf5EWb9G7
         ceJtMS+uoiL8k7oW/+eRc2PJcfqo77kzW/FD4WXS7ioo6npcKm8itomEmIm45gkl8rSm
         G4qCe6A84Hdj8b8+kwFtwGzWAyml+H61x/3gYDZYp7Cx98xDH7lnn0ppA1ZMLrKjZiBe
         p5Bw==
X-Gm-Message-State: AOJu0YzDZZLmkHIh0DHjeUDqQ+frMvAxTGWVoSbmNLZSMmykhg5I//pT
	nr7C2yTvgwtR9Z4ygpR2941IE2ZETMMP3eoi7awenHg1EbEQ6+ZaFsGl1w4Li3OhICTBwzAausI
	Z5hEAEaaELM1mX9t/xxmu4kvaLuwfnfOc+NRk
X-Gm-Gg: ASbGncsY5yuCCZAB+WIzV+ACJmWeZoNGzIDyryHIwTPt5HkORJPJf1LD2j2XiWynZqM
	+e0ZdUKyZeGlyXRA7I1P0P7i8BJ6/hsLnZ9owT9UOhFjgtXxcslCnBHaESvJe3nyfVQpZXwr7Kj
	1LaDsq0AGqAOOfPX+yFPGKx9G5xgGtYomM8yIRF/qO6hqQFzXicNYxSdMWwAKy4SCN05Hk6MvtR
	zfUVg==
X-Google-Smtp-Source: AGHT+IHYHT2UaguEW/c5Rd36PpdTOTFNPbVLx9V0r24Ys+GpJ9DW8n0SxSjOj1f0DBHpcjFZA1sMS1+UtN/9mL3ufj8=
X-Received: by 2002:a05:6102:3e28:b0:4e2:942c:7862 with SMTP id
 ada2fe7eead31-4e7e38d813dmr1395956137.8.1749799879310; Fri, 13 Jun 2025
 00:31:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Jun 2025 00:31:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <5115663C-0F90-49A2-9925-389715618580@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250610152117.14826-3-lucasseikioshiro@gmail.com> <CAOLa=ZRFM5ZVyBfbpYjePN1c+cVBTfU-nk+hsQOGt5e1CJ3EXA@mail.gmail.com>
 <5115663C-0F90-49A2-9925-389715618580@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Jun 2025 00:31:18 -0700
X-Gm-Features: AX0GCFtvuyMAj7-F3X-55ektYqJvmuhU9pXIWpMTVmNUAMawh7h_7EtCekvx2fk
Message-ID: <CAOLa=ZQtZy_xwn5JWKB39maXJ7zSaO_SJQx6UCaomW+X+s_dPA@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 2/5] repo-info: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000003c518a06376f082f"

--0000000000003c518a06376f082f
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>>> Also add a flag --allow-empty, which will force the output data to be
>>> empty when no field is requested.
>>>
>> Why do you suppose we need this, I'm not against it, but it would be
>> nice to state why this is necessary. The idea is to have a default
>> output when a user runs `git repo-info`, so I'm missing why this would
>> be useful.
>
> I was thinking about use cases where repo-info is used inside scripts.
> A simple (but kinda useless...) example: an application that is a GUI
> for this command, where the fields are selected in a checkbox, calling
> repo-info with them and then displaying their contents in a dialog.
>
> In this example, if no field is selected and there's no validation in
> the GUI side, the default set of data will be retrieved. With
> git repo-info --allow-empty, we don't need to care about it.
>
> But, yeah, I agree that we don't need to think about it by now...
>
>> If I recall correctly, in our previous internal review, it was mentioned
>> that since we use perl here, we should add a PERL pre-requisite. Similar
>> to the one in 't/t0019-json-writer.sh'.
>
> Do you mean to use a `test_lazy_prereq`? I'll take a look on that.
>

Yes, that's the one.

>> As of this patch,
>>
>>  $ ~/code/git/build/bin-wrappers/git repo-info
>>  {
>>  }
>>
>>  $ ~/code/git/build/bin-wrappers/git repo-info --allow-empty
>>  {
>>  }
>>
>> So what differentiates the former from the latter?
>
> In this patch, nothing. I was only trying to keep the consistency
> of each patch from 3 to 5 implementing only the code related to the
> field, but it seems ok to me to squash this patch and the next one.
>
>> This is because we didn't implement plainttext no?
>
> Yes!

--0000000000003c518a06376f082f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f9ab7520c9cfacd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oTDA4UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meE95Qy8wV0FPSzB1aDJiS1pKWlFHQWM1ODZvOW9RcwpDWURVL1VvQlFs
SnJtUGNrUFQ3NjNSMDJDdlkraWM1QzF5c3pra3ozUDhtVC9GY1JzR0gwRnljOGlTSXpwMGw3Ckx6
NlplRDR6SGtPS1Q5VStjWjZMWmlkdE0vY1BRL2lUNTk3eFpDOGp5VS9POEhBRDBvNVJYeTl6d1Az
WWFjV3QKWmdHTHVRQXBEdXdMWG5ucnZOR0UxZ2hqdnZLckljVHk4eGRBMjBjMTBEdlZOS2E4NGh5
VmRSTkhuNWdvZHVuVgovcnpNSXJaaWE2WGxucWpFbWl1K0owL1YxeE9jQWEzL2FYT3Z4UVcxeVZ0
SXFmMXhGWmhTT3hXOFZ2Y0Q5SEplCk5maFlFOVp6SGVnbkh2bVkvVVRPL0pVM3RGeHhXNk4vcE93
VUtQNjhNd2swWnJ6UEhXZUtUcFF0VkgvbjRhaWoKNlUvYU9jYUJDZEQ4NExIamt0dEdqVndDeHRB
ZkJUSXZxUnR1Sk9FODVHSmxpVDZqcjdweWhoWmIyME15UXB1agpIRGZDRnBRSnJiV21GbnlpUmlm
blQ2eGwxaXVXbGpOM0p2dXFpVmc2NnBkYjNKSXp3Rjl5ci9GNmZEVVd3clR5CmxhcitvbisyK3dT
T1d6K3NwVW9wc242Y1VXS3hDR09PczR3ZkhaUT0KPVE5V3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003c518a06376f082f--
