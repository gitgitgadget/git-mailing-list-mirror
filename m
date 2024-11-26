Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26B1D8E1E
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639269; cv=none; b=S9THrjAJ2zjXZ0s5MLrq6yo3iMEjFDBo5O8lx3c2L+2PTovl5aDfw3kLMrw9O/Wx71uGS6YqDumqr98Ky98FjhALv8+9/kWXUtiGLtXIDnGdn2N4+TD5I1tmntMErQkj0dv3HcwQd8Tn5mxTaouHwJigDNaVh9+qM1JzNC5gIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639269; c=relaxed/simple;
	bh=MpNM4WZxzRzK0geY14BvnEeWdLEwU+jSIowo62gHR/E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZ5gaKlR1nmYrfpYjxt0ADcW+K4TL4utobeNAtSuNWoKBELOju7jEDWNMc6ec/atHBGlMBBVmh+BK8drOpx2bHaV3k6WOx7WWy4k+vZDIfYWijCGQwqYg3qGLUEoOtYFLIxC3yL8MR5KDcea5LJNcJpngvJbg4lnsO1iuHm3ZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC3MdnJ3; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC3MdnJ3"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5152e0a0ff5so763882e0c.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732639267; x=1733244067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpNM4WZxzRzK0geY14BvnEeWdLEwU+jSIowo62gHR/E=;
        b=ZC3MdnJ3dy4VEiZwUdNUURU7m8TEFCL1r+0A8BHaakYM1uYvupJHaRjh9f+51g87T6
         +fJYHqsP25rjCGlcWJdkNfJ/3pVMiIgA+OpIymGLizP39qHuTSMf92pqAvZL2JeeaprZ
         XmoiR/66inPk3MCAi2F2WibrbDM4C3sx8KwcbrTcg/f8bEi62PFYW1q33zwwlHbc9TCf
         hwsGtfieMRgjx7s15/vuCS8kCzmhoCEvbVA9f6KJBqX6p+kmgKIri3PkjjsYWE9i39yo
         StWOi/EOzPAdJTCsP08EZFWHvOgEli2apCgKgI072/SIcyE8dryfR0maIYSXW5urK0AU
         qMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732639267; x=1733244067;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpNM4WZxzRzK0geY14BvnEeWdLEwU+jSIowo62gHR/E=;
        b=oz4YJc7xIpkBahQw99gN4nxnbwW4uS+7J77JmM/YUCKa8djqMN8GBywtP16mfqRfBA
         d1YANiKE/u14UQNohrQwzEcBERWEW+nek/mvg/t8LaG7DU1KfojEux2AHxE+xx7FTNVG
         svnBq9qSMpP4AEoVkPjLU1zmRRcVw2cjQIhI2Key7fv8q1Vb9Pxixcs3124Iffgxpleu
         8TMGjf9spoh0D3PL2sSS/GTJNiOfR6Z3Ib3NB3+WDAkyPGOes5yYWF2CE4LklSSqvTTe
         AdganJvY2K8zC46LMhTZc6dFGpSczaF8FWsV5xhhcZcVmaDDA7CXPNV2TeRdbv0alAgW
         g+PQ==
X-Gm-Message-State: AOJu0YwvpVfttXISOaICnEgbjpGJu0jFTFYv5A8OqFGM7Pd2H3oMU9iv
	M3KWMIzJE5dj5MmGoJSESwxuGLxkubDEzx4ubmbHXBwCF/6TYniOOnumgy3+vyXg6QsyhhSWDsw
	6GQ3rdJsBp/lT61296ZegAoKUnPA=
X-Gm-Gg: ASbGncvgxzt65mt9oHrP18T9C13d+FMIbC3zsOvGkaUkYnLzGMabO/GrTG4YaNUKq82
	mXrQJE3LcDA9bW6vHmXEZunRU/O79iQ==
X-Google-Smtp-Source: AGHT+IHdaocoAKu/wmzsMMLDpAO6628085uY5mCfSZSY1xcBTwZfvJP8jy1kAYnwYZ6k4gpKFCA973ff6+BxqS87VSA=
X-Received: by 2002:a05:6122:4897:b0:515:3c2f:3525 with SMTP id
 71dfb90a1353d-515569cba13mr56738e0c.6.1732639265956; Tue, 26 Nov 2024
 08:41:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Nov 2024 10:41:04 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z0W3rgHQhmUxjgfp@ArchLinux>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
 <20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com> <Z0W3rgHQhmUxjgfp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 10:41:04 -0600
Message-ID: <CAOLa=ZTeRUT6Ex5Pa-fM1i-QbTfnmDN=o=MU_N2VFeLQwbscgg@mail.gmail.com>
Subject: Re: [PATCH v2] builtin: allow passing custom data to sub-commands
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000f8c8530627d383ea"

--000000000000f8c8530627d383ea
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Nov 26, 2024 at 12:19:22PM +0100, Karthik Nayak wrote:
>> In 9b1cb5070f (builtin: add a repository parameter for builtin
>> functions, 2024-09-13) the repository was passed down to all builtin
>> commands. This allowed the repository to be passed down to lower layers
>> without depending on the global `the_repository` variable.
>>
>> To remove usage of global variables like `the_repository` in
>> sub-commands, it makes sense to pass down the repository value from the
>> commands to the sub-commands. But let's make it more generic and modify
>> `parse_opt_subcommand_fn` to instead take a `void *` value. This way we
>> can provide custom structures to each sub-command.
>>
>
> From my perspective, I think using either "struct repository *" or "void
> *" is OK. However, I am a little concerned about using "void *" at
> current. It gives me a feeling that we over-optimize here.
>

Could you elaborate on why you think this is an over-optimization? We
don't loose functionality with this, nor do we have to have add
additional code to handle the typecasting to `struct repository *` if
needed. But would definitely like to resolve anything I missed.

--000000000000f8c8530627d383ea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e02b5b842ac39f2d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRitod1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meExjQy93TWY3T2ErZ2lnOUhOaGZRZllRTWhUbmVBeQpYNGlTQWRiQ1pL
QU12cktyNG9uNmtta1I2MGQzeUdyTGZqcVgycXc5TlB3bUxMdGZldGRUQkEwQXoyQ2Z6RGZDCnFr
VlBqdG5nbTlMYm0zODlOMnJiY3FYc3I2Kzh5cDlnaGVDWlUxUk1BTFVsdXhQSFJOeEszMGZpV0g2
WUlnLzgKSW1jWi93cG1iYnhmaUtzei9VUjhWZUxhNCtRdDI0dCtNZjFQcTlZU0JPM2dxbW5IQ3kx
Y1VuTHM2alFVaUpBQQpZVUx0alpDMDR1QkZ0Uzd4VlVOTE1jS2RqVlN3U01YN0Z3QUQzSElPQVY3
eWU2Y0tnNUVlVWVGSDZsK1h6Z3pwClMwdERkc0NEV0NvNGNidERjVVg4c20vNGl4WkY5aFZ0L2M0
YXBGUmdlQXBRRU5yN01UZjNObFMwSldyQnV2bC8KV3U2b2JrWHNleGRVYlVxSEhpMEhWRkR0WTEr
V21qRmN3TityakhNZU1jaU1wb0c3bWFoTnFWYi9TOHNaUktmZQo2M2hMRm1tV3F6ekJhUHJFcll4
VWZPbTNvMTFEYnkyUGxqVklnSmtqbmp3WUp2TWlpbk9ZTmJ0SXIyRkpERmtkClB2K255a01UQzNo
eEtvU01IdGZ0UnRhWEsveWp2QUUzR2tsVDRRdz0KPVYzSm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f8c8530627d383ea--
