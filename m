Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408577407A
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433211; cv=none; b=GW0bWx/hGb30zs+4bDqspv8SpbqxkYGk735eQLk5LAkVj+8ju+pPY5z1B+0m7YusTxtgzZpAr4z0nu8mgpf+BXr7l7F9xLSLF0qPcf4g12ktTwglSFyp38hBpAPafeqaln298o2nFSldAbOY8wNt2Wmla0yO/UwkHrWjbxlAbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433211; c=relaxed/simple;
	bh=wvgLTlQh1To59FfAbhBki9YuUeA5MFage27I6kZbBFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk9pTnyhKpwLm2UUlF2w6bP/1gorjqU63Ce4DhL4bMyPWUauwTFVvXRadoz/AEei5AwBgwW2Rv94MwV5z4n1QGFTKeSaGNCWRm/LAdw7OlzE09yL+Vi43ZuRN6z5IyC0i5a2unrTQw76xm9FK5we70nroJBQeukNHKH3ihqpXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fujg1/q7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fujg1/q7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a75131ce948so449793966b.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720433208; x=1721038008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Y0wxuLXVYYBhfPsj0Rm4/sVw57FNZDNII3OcHUc/o=;
        b=Fujg1/q7DyK6+D3m4O4zEG/WIYvYfmKQZJc4uCBTnbggeDk5NAkUQVm/vJkaWAnlbB
         G/El65yePQvu2kNgdSM3G5vdxYPnMrlQ201dIJjPPsDlJYKdqNJQ3TzcO3dqwnfo6ovf
         ljnmNIM6HSyeF/hvaLlhSJSXAAXhRNA36i8rl9+QUK5qygzHQWeycQUA2pWlV3tBdcCr
         bICRYwcVxMP3xP5rnGFDy3fbsRfdyGCJGOD1Tw6PH7BG9sRWGFre88/5SfEQlL4pEk47
         qm4RgPKjdUb44lsUDI8tpoaRBK1i9yy0Yj7sUklmC/ScvxpXgX2a34CPpdyuNMorVCm4
         md/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433208; x=1721038008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+Y0wxuLXVYYBhfPsj0Rm4/sVw57FNZDNII3OcHUc/o=;
        b=wydI151Mlsjuw6ajkD3jYMO5hyxP4YW9oNfHceLUMt+jCkPjpuEe7QWiNO9hn9o9jO
         GvYzBsEqpRnYYJzGRk525WIOrDJvQWZQQN6x4yEWobb68TVL+37LUBRJVM/1fJgDvroe
         1Lt6IQdWH0jFqtdnNe5+i7YnLiphFKb2u+dvSTm/mhSMBHuLnVS+aqqF0WcZF0Wvlpea
         OY+VIpZIbJB1Bj36M7kJQg5HYaBRat9sEFi4QSGNGjBNSJzDHOMdnGC8owZBzBceb344
         ucv30iovWtkJHHfOJ2PpkINJpmM1mbayaqpyZK7mrHXCMdbyZGXboLgOCfHRnjRcjH9i
         SgLA==
X-Gm-Message-State: AOJu0Yw8DUbBE51KhUGQS9PLZAa5mMlhEloi3XNNIMLHTCtI7gwndXnC
	Xm0lucbwGhd8+Vek+BSaFMlGxzBb7hw7BUFsxzaraAkQbxE/rmG1vqYzNEehPJ6d3+t09yVWmu1
	2d0yincb2MwqdgHRbZRdzc7upn7Y=
X-Google-Smtp-Source: AGHT+IHzfFUfiDN+ISxuKqf1K5NMGBAzwQygf0TgkofrAwJYfjhwu6IAOXjXkUWt1FGCdXoButX+dY2GXDjw/nj0Z3I=
X-Received: by 2002:a17:907:980c:b0:a77:cf09:9c4c with SMTP id
 a640c23a62f3a-a77cf099e47mr686922866b.67.1720433208277; Mon, 08 Jul 2024
 03:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708092317.267915-1-karthik.188@gmail.com>
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 8 Jul 2024 03:06:36 -0700
Message-ID: <CAPx1GveNmpM=v2Kymi7euuerciZKHqPmmexqPdMxKUEA7oAEkQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clang-format: add more rules and enable on CI
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:23=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> The series was mostly inspired by a patch sent recently to 'include
> kh_foreach* macros in ForEachMacros' [1]. I was wondering why we don't
> run the formatting on CI and reduce some of the workload of reviewers.

As a big fan of automated formatting, I scanned through all of these.
I did not spot anything problematic and had just a few minor comments.
I'm not an expert on clang-format directives, nor on GitHub/GitLab CI,
though.  Anyway if you want it you can have a reviewed-by from me. :-)

(Comments stuck on individual patches)

Chris
