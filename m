Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B01CD1F
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743847295; cv=none; b=KP48+ehaelrOQPq1TgCqlktTMC4WWgw6FCUzhT3gYbdkr5gEqxBr6YhUdXmGsOAg4i4a7XluzmsbpKgWUo5ixAGVNCFdW3yKAPp3xqEqqFSMzUJrn2z1oR2MK9/K+bMUr0ougelq6O29lEtLpT5Fx0v72h2qnvnYF4ZgJ2d7p50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743847295; c=relaxed/simple;
	bh=YBOeWeAByGQqUIc3xLEX30fls1A2ARnpJGoO4RJJ8tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYWdzi1/NPne+LPCHqpzUb5PTWcAc5sY45bnUxoBZbc3x1xsv+pwnE4M8ujsk5ozXOOqz8FvZiq+PktVMt99cg13z089gKRqBbaUFxudwjaDr1tGbxtDgXh8MNIdtUS6EG9B1Ei5cDXUScbZ+l6LvMmxugoKvmP8L3NUraEl15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh/wnBDQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh/wnBDQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c266c1389so1988101f8f.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743847291; x=1744452091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BfUpTtbdLVCZND93nKgz6z8AC/4g3nRw9gREj8o9tY=;
        b=Hh/wnBDQ0IcLsWVRoZ1aQXjk16pp+vD07581kN+6BAtFMS4fHcod9q7NBLBbiOTcMi
         9H+J1oFSJYDUbWuADQ7jhdggrDix+JJx0l+eYzpSWK+hL8I/omf8Fxn39eV51lL20Lsp
         q1GkuAQg5UasUjwlUazgRpXHzEV0LZZIftYm7v4tkDJh6uSOc0Y4holi0q4P9D3Uj8BF
         l+SRii5DBvFZj6qxjaxiFeiTDGpEIu7xUooeNItAsakXV48pqm41TvFhfm0M6OnDmFDi
         mbINuXW+VTsH88jseNjfHkfwsyZIwKsvf0GzIEDyVpwdqoj8JYQgKAsVlD9TsauLnsgW
         aUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743847291; x=1744452091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BfUpTtbdLVCZND93nKgz6z8AC/4g3nRw9gREj8o9tY=;
        b=Ym2enT9+Jfr5vBlX8/UeGy45WMzSOWYQJahH5cTBYjctw6u9bSf7cWsvw9xftxX5ar
         R2WkfeUw7v6txBKRRjuA2C3P4pFYm3ukB1SyHLRWmMbkGorzDafimEuFSxbUqUHqHZYU
         +iUpwBY/mPi/saiiX5iqN8p1xzZl/2IScur0pPqgdiLQinPuF1p40s4tLAQqz/si6d+P
         pnC2heystUYX6ODzI0meC2Z2UGxaXNbqhpwK/Or7iOE7qgOjO9YnwvyWFqouLgAp+4/+
         HSBAqSmrutwV96bgXefAL/FLW4bPYnZew7hEiBum65/HxOXokl/l59eUoMWprqunMnqj
         DtMw==
X-Gm-Message-State: AOJu0YwwXjQ3tk/g+TVMo17kMBxJ5aI92XRFhC5M0NXDQLy8oh6NNU/l
	GnCYP+X/smY6Wpfg0wczekFU8pRaJwBdOuBvRsRlsTroSbcXSslmkp0q7cCj5Wj7ALNgQoZSZZG
	jOOGq1evHt4QfC1l5rVfsk9fo/iqfK255
X-Gm-Gg: ASbGnctNsw2Rruy/XoiSAIdt+Y9ydcBbb7xb3KCSySGFqDJGsnJ6Ed8kWvjOCsEwhRY
	YUZVWx2Q/LS8VO/+RzI+PC5uV95k4Hu6HKP1vIEPeaYlBxRPHdahhbwd4MS4F2UFzHi0InOwGsX
	No5nuWFf0uCO4rmtQJRybk+ohKRcY=
X-Google-Smtp-Source: AGHT+IEc9JAp5gSetZUf/qPNJy5qQUIVYayWC/L9WaypXo7nSOpY4G3GvcaNyqoSPkw2Ps1m4WrjBqF7T/s3KfkItiw=
X-Received: by 2002:a05:6000:1849:b0:391:ba6:c066 with SMTP id
 ffacd0b85a97d-39d0de3e88dmr5174883f8f.35.1743847291412; Sat, 05 Apr 2025
 03:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com>
In-Reply-To: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Sat, 5 Apr 2025 12:01:19 +0200
X-Gm-Features: ATxdqUFHr89Rn6nW2-8beyeN3HcGdOcaYOXJVTJ1KDcQauYTRu3NZU1Lu_J5nI8
Message-ID: <CAN0heSp9RhH=UMDqLs=Kd57RoseySrFT4sFeXrVV3h7f=daSaw@mail.gmail.com>
Subject: Re: [PATCH] refs: fix duplicated word in comment
To: Christian Fredrik Johnsen via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Fredrik Johnsen <christian@johnsen.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian Fredrik,

Thanks for posting a patch.

On Fri, 4 Apr 2025 at 20:39, Christian Fredrik Johnsen via
GitGitGadget <gitgitgadget@gmail.com> wrote:
>
> From: Christian Fredrik Johnsen <christian@johnsen.no>
>
> Fix a typo in a comment in refs.c: "checking checking" =E2=86=92 "checkin=
g".
> Signed-off-by: Christian Fredrik Johnsen <christian@johnsen.no>

There should be an empty line between the main part of the commit
message and the Signed-off-by trailer.

>                         /*
>                          * If we've already seen the directory we don't n=
eed to
> -                        * process it again. Skip it to avoid checking ch=
ecking
> +                        * process it again. Skip it to avoid checking
>                          * common prefixes like "refs/heads/" repeatedly.
>                          */

Well-spotted. No doubt that this is the correct fix.

Martin
