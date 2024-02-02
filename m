Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47342146902
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888922; cv=none; b=UHQGcW7NOm90B+RYCzx3Sz8CvkCPo6NBwLW26t1v1bLs6TSc17gZleBVIi4AH/R5yNXO/DpVoyLKHQBY22VaStV+FXhjDyXp+SyLRyreid69rGDnRaKXJ6qs4vKwaigjp+eN2SQmAa+3iF/cvItsLpwG8f7YAqnypp1JC0jlYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888922; c=relaxed/simple;
	bh=avmG70tMjvTxZyP3pGoWIT7SyyS0aW764mqOanmnvdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEy+W8ZIn+pc5VjOZw2dBVttT6l72+CFGwHUUnODL9FNFNaDoz8HI0yiTLNB5EavI2Uu540W65+fQWEeVStOOou69vHoio+9zhfe0OAuiAwcr/HHHflbtmmTlYpgJSJM5o1llYPj5nLE4nrmHum11xM1u0n7hYym8zttvG/hWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRsvG7FJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRsvG7FJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3566c0309fso301281166b.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706888915; x=1707493715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf17c89spsg2T1JUzLjK5F1wDXgzdhZwUkaZUZhQafs=;
        b=hRsvG7FJ6SaddX7XtuAhUSV5sCwufJvhqa7oJipNcLoIMFPlUmzIr0SydU1+dSD92+
         KauGC9YA+2T8kE6RErjOVLdBmNPpspPmmj/ylKd2Zrok8PwAUt1xYvHq9H3rPRXjtYOj
         EzzkzV6vydLJ8Fdu01EAtQH1kbllaE325YIlMC/jWkjszxutaG40BrR23gnMGzEZlwgh
         vtvJwDqSfWnvkxlkQgzIQO+gcl/Ve3fh976lvB8vTjjaNjyY7JirLLc/hprnhT7Rz24R
         2shBTQuHIjMdEV9PVIcp7LcMjHK3dz2tV53Tb1DC9SdTfcVY9UpA7pQBQL3E2cuZcgdh
         AzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888915; x=1707493715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf17c89spsg2T1JUzLjK5F1wDXgzdhZwUkaZUZhQafs=;
        b=Vpf6vCO6EWEEiErmgdJYOCyb+iQdzXx/ir/Nad1rHZ64VRz/ovq6b+wOKh+pZPticF
         YUPnEHqwj4kI6xDjDuDk2WjH2hczV1fZ6/FtkRtrsMK92WrS3R8qTvSPKaST2DCQ5ClU
         vvbu1FwcrkMvrcLDZ78rlnf/vpSqgtPrqmh6T5nEEF0yZ1n6HzXRJ7ZFkxPI0h4IYs9U
         hrVqf3DHmeyogOxKfubm4WfIDNaI288t+5Cs7OisF4/DU73jIi/x2fbBaED20FhHBaK5
         L1CsQw1xGnyNC7Cn97LyyHpAu+DdT1zMECjV/dw+cQV9NHOye3GwIZhg7aQSKWgr8V3i
         nMug==
X-Gm-Message-State: AOJu0YywIfmvZKuM247ZLUjPZAgRjlU/fDMsvcZpk42LdTZKXPhuKukB
	0mCc5v6jAbgCQ8rFGlCK1ADZr8UhLuC3EVlvekvNaW6fXZB6DRYG2Mw5BF1ulFHCk0uGNQtJTvT
	ArAKWZt3sxZR+fUaD0HIZrM02DNTq33LL53M=
X-Google-Smtp-Source: AGHT+IEzsOOwmyd+1jB4Bkk+W9QqlX9REWObR7eCfysdmeHiBDY4EuXG1IRFOLZ5z7Ea/dJUzA5UQSdIcbbUyWo2FfA=
X-Received: by 2002:a17:906:e0d7:b0:a36:1240:71d with SMTP id
 gl23-20020a170906e0d700b00a361240071dmr5788259ejb.53.1706888914421; Fri, 02
 Feb 2024 07:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com> <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Feb 2024 16:48:22 +0100
Message-ID: <CAP8UFD3zNgY2qXQo3eU5fAMU6T-uWPMcTR473rgyrtF3pK_1-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] index-pack: fsck honor checks
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, 
	Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(John, sorry for having already sent this only to you.)

On Thu, Feb 1, 2024 at 2:47=E2=80=AFAM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> git-index-pack has a --strict mode that can take an optional argument to
> provide a list of fsck issues to change their severity. --fsck-objects do=
es
> not have such a utility, which would be useful if one would like to be mo=
re
> lenient or strict on data integrity in a repository.
>
> Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
> change the severity.
>
> Changes since V3:
>
>  * clarification of --fsck-objects documentation wording
>
> Changes since V2:
>
>  * fixed some typos in the documentation
>  * added commit trailers
>
> Change since V1:
>
>  * edited commit messages
>  * clarified formatting in documentation for --strict=3D and --fsck-objec=
ts=3D
>
> John Cai (2):
>   index-pack: test and document --strict=3D<msg-id>=3D<severity>...
>   index-pack: --fsck-objects to take an optional argument for fsck msgs

I reviewed internally on GitLab the initial versions of this series
and I reviewed this version 4. It looks great to me, so I am happy to
give my "Reviewed-by:".

Thanks!
