Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE103AA1A0
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866029; cv=none; b=Y5xaR6BXkiuplKjMMSLIe4IentZ2n55BEt14lS2UmlX7c4SGfYsbcrCy8ojl6yQvdyRMaKVcsrhcoiOsxE/vbI9Qdgi4l+VCGYgpPFVmgRPd2+Oxn4UViPbjfB28BTq79ZUWq+AkagNkzeTmDtQarTQGB2WA0q0yJBLdK/9uVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866029; c=relaxed/simple;
	bh=vClAduzX1L4Vv3LR6xcK+uatlaSYLbJaGMGnMGU9ock=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8RXSqJJigxrkSyidXnKVSftFxr5Qu6NOKzwDzxYM0BkTAnZKUhAy+2rgVhl3gOjOGUptQMQR0pgMPrUopYvGS6QNd8L7OOh0DY6umMojgTWv4B8d7yi9wYFrjeM2crPYg4m7qcxlHKnbySWpEcE6yPN07PbK3OVd7jnnd7ODFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6aW1rwe; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6aW1rwe"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9352cbe2e14so1021347241.3
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762866026; x=1763470826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vClAduzX1L4Vv3LR6xcK+uatlaSYLbJaGMGnMGU9ock=;
        b=E6aW1rweTGIOmm9vuOB94XkJxVSmN9CMQkCTJSYtaoXN3GoZRk+236m3Hx3LqCo4w3
         4brpFhdl3jv81LKWO04fA4ScKgoEo3zeRHrwrKDl1qzKM4jTnjqW/lqXVWMx4KPmbg08
         GE5NsziWRyB0YIlrghpzn0zf6SPU1/EdLaA+cQZEzDBY4GTajoZPc4bJlWD+kbLUShZ+
         GWrY3C5GtFRv8wY2tSfb+kPX34XYk3QsGg8WxKzCSgxCIKQJ+dxrf58zP9R6vQVeKud4
         esHR7+rZ9EZ9e47AKZZ20ObmiTzlCECSvOvkQbCrCH1cYovgqyreJO+m5RG3lOqPLgi7
         oa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866026; x=1763470826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vClAduzX1L4Vv3LR6xcK+uatlaSYLbJaGMGnMGU9ock=;
        b=Aa8kh2kKDQ9nzO8aTpCQ1D3X7Pc4n151N6JmnVTsrs3CVYwPshkQNbvT8IBNV0jj05
         +lFix6oDhNb2DT1Y+hN0NC/GGbCQtTAcf5QV+mtj54HwtQ/0RDd8iEzGQa181DUAaPIW
         JBaTJPA8JeNGHIdQ3RJw74TxhbQb6VgEiuHkyjVR1gIbHB+GcsRV/OUCf6FLAhmzmfs2
         6n9H72YQxBbUkw3z3LLM1RpsOxCxjlGzZZXbWDv3B6jUF7I7eVTszT2Rb6l2YI5lmwkm
         5khlX7MwxKnUvkls+KoyjmjGeJHerYJcAZXHZV1uMQmP8rbPEbSZ8CE4RrbyRi76zHDe
         l/zQ==
X-Gm-Message-State: AOJu0Yx4/FKwF1WYoA2gd6e3aV5l0Qsn4xdyAIvFqGDv6GdGlymfOgWS
	7pYxYLuiNR8T6seEt/1x6NeGP5A9TRuBIqXXeh3NR2aQLCD/QHWEKnnApDGF/ZNHYm/myXL6SAn
	yqMv3gKYRsa3ArTfz8TqwmJumLRaAMr0=
X-Gm-Gg: ASbGncupnpWBguW9r0SlxmsmE+Td6I0EnK2XUSMNo04eL7mFnDDdaZ2kwv5NqjMqmUl
	ssBrc7i94evIMQeJEzDojcs19hJkZjLUgeciV+9Vu77C7wcpfhlcLToPT3sKTRVLqdUF+htSi0Q
	TC0vjxdrmyTOY32SzLZgtbyv7xZJCIhWd4qx+Y90UH2YRR+20wsPjZks6lVQvSLY7CIk12r53jD
	ozW38MgXK49yjJ3W/0W3dYFuI3sdE9njSjbO/O9EifdpFPDVI8Iz/V5d8KT+ft1O4qlNOoAtwRE
	eCEILVRGO/B/fBga
X-Google-Smtp-Source: AGHT+IHXZi2Duqz5RsfKv9XoZC3A7NfY5654KNyEij+llLL/K9urRD7+DmSYDE9SYsUHqURSP+0D5E0xXooX9KyHL9o=
X-Received: by 2002:a05:6102:6110:10b0:5dd:f9c2:5505 with SMTP id
 ada2fe7eead31-5ddf9c25924mr420149137.20.1762866026345; Tue, 11 Nov 2025
 05:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L_F-c-xACU8z+2GwgBwzVsZBLcMvtVbuB3phC73_xHBoA@mail.gmail.com>
In-Reply-To: <CAD=f0L_F-c-xACU8z+2GwgBwzVsZBLcMvtVbuB3phC73_xHBoA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 11 Nov 2025 18:30:15 +0530
X-Gm-Features: AWmQ_bkn3JX-Y_GwP6-jFgmeOxnQJx0iibvX3uNyGhP8wLKtgSWmpu6RVksqfjc
Message-ID: <CAPSxiM_8MWdKAQJCA2m8zj_3UC7GaOcYZnKmLt=PXrtbUudZuQ@mail.gmail.com>
Subject: Re: [RFC]: Continue contribution
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Hello,
Hello Bello,
>
> The Outreachy documentation permits continued contributions
> after the close of the contribution phase but I would like to
> know if the community is okay with it and I can proceed.
>
You can keep contributing to the Git community. You do not have to
take permission from anyone to contribute to the Git community. Everyone is
welcome to contribute even if they are not part of programs like Outreachy
or GSoC.

Thank you.
Usman.
