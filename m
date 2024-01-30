Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0860376EA
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603944; cv=none; b=afS4Ln4XioM0kp6cR5vR3SumMXabsKu/ofCpGLW0QdxrPZUriSejUt+BRSGKMUuDIRi2NHM6MaeSYQhK4W//+5PaWDPOpV/WF+pz1xIbhPdv5j8J0/DG0844BcO25e1Jgb6KFSuySRcUiwta7N1/mD0p2t7BVUFsZdp6Wzilcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603944; c=relaxed/simple;
	bh=SFSufA2KIgZD+EvKh3i1IcIshkaQHNUz0FiSM4+Iric=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i97JBswOCdSONwV74KFjZMsIZEA4HqcT0RqF2N/BNc8fXw5GaFs+XcCr4zjSlWresBLKgRdxQQtDt3uErS8EgTTO+qsA0Df7WcWe2RARqGQlt+ji3SmsZ81I7Pv/zV1q+YJbmT47zyX3pexi2L1LQNfWBcVLkRz6TG3ua/VomyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAUQHQI2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAUQHQI2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-510322d5363so3899419e87.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 00:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706603940; x=1707208740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAvEOc0aDDQORLZE9rt84ox9l7Xw5n/CzFW1gLHiSqQ=;
        b=BAUQHQI2C8TWRxtDmo25SghqX8i/GWAQDYRAtmBRHq0NP8c4wpMFX290UwyiX1MzWr
         RGqyZWCLHx4QecjPEBngOUpVbxcRCLKpCSwrYmI/CA1rcLhh6vD6yAYn0lp3v3ww0QWF
         IYJ6XJIyDNDPHhTfrttBBc5/u3Iedkz8rHhUX2oWYjDEsngzGohzQwnWshy1P/AHzVmo
         wI868V5gJcPmCXrl+yeWZAqMNdN5xWuCtQXAyG9n8nbOCom1x2PLb6rnjFw956GL6AWs
         +mzfMNHU+f9q8cUhrNc6vtDeVufjJoau7VfgFkB5jPzpTsqDLbW8wrlRik3Mf4u6dkPE
         Fz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603940; x=1707208740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAvEOc0aDDQORLZE9rt84ox9l7Xw5n/CzFW1gLHiSqQ=;
        b=QxFBaf7WtP06rdG66kD+dQeKh075pa1Kt9NHuQUf0R2wQwfteOzrjgklNIWHAVV5BP
         FokkS+IESB/t7cViEDOw7uV/W04zR6q7TALHU/zc4BozlTs42YHHsxLsj91kH6484rhZ
         biMjQbFropSM6s0AXh/aWpxS4JSJslZ7qMEUMS9KJQ6Hqnbbm7WtkFfW/ZcOG+o1llzA
         IbXm1cQvRTYf88QS6nO/k+9g2cHzL+QMAdGlF53vnsuF4Ro2vCRv5ijLET8nBQAYCje3
         7fZR8oR9Esz91K+yo+dwtpughXMiuFpBbY5luKSGcwr7NUkrmu0N4xlEie1z5qcpFfMW
         +viw==
X-Gm-Message-State: AOJu0YyGUM3zEwiIPJsHx9pRD/6uqrLhiFkLyvOhz0EiSKGEZ0ZG6X68
	8y5s5bJzfhWFyK5SBP5AoqzCh86ktAXGFQlMcZIZwWofwNYcw0jaZG/rXauaJVXLrgdFY45ud+M
	Tdxmttt6V5p9JyNVHmC8Ls1zFcEA=
X-Google-Smtp-Source: AGHT+IHAPxWhYtYO0VlVzViVEEpXcMJdvHsYhttpjz5ifT/HpqwcatmfYfCLnH3o7LlJP/tAeQ9n1W1dov6ci6eXn0I=
X-Received: by 2002:a05:6512:3d8e:b0:50e:aa1f:4427 with SMTP id
 k14-20020a0565123d8e00b0050eaa1f4427mr6158256lfv.51.1706603940266; Tue, 30
 Jan 2024 00:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
In-Reply-To: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Jan 2024 09:38:48 +0100
Message-ID: <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic and all,

On Mon, Jan 29, 2024 at 7:16=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi everyone,
>
> GSoC Org Applications for 2024 are open now [1] and are due before
> Tuesday, February 6 at 1800 UTC. It's good to see that contributors have
> already started working on microprojects this year :-)
>
> I could help as an Org Admin like previous years. I could volunteer as a
> mentor depending on the set of available projects that we're able to
> gather for this year.

Thanks a lot for sending this and for volunteering as an Org Admin and
possibly as a mentor too!

> There are one noticeable change to the program that should be highlighted=
:
>
> "For 2024 we have the concept of Small ~90 hour projects that are a
>   standard 8 weeks long (they can extended but it is suggest not
>   extending beyond 12 weeks for the small projects). We aren't
>   required to have small projects available but might be worth
>   considering if we have any small projects that contributors could
>   work on."

Unless some mentors are only willing to mentor Small projects, I don't
think it's a good idea to propose such projects. Except for some very
good contributors, I think it usually takes a long time for the
contributors we mentor to become efficient and autonomous enough by
themselves. So I think a Small project would likely leave the
contributor halfway there, and they would then have trouble continuing
to work on their project if it's not finished or contributing
significantly in some way afterwards.

> The GSoC contributor application deadline is April 2 - 18:00 UTC, so
> (co-)mentors and org admins are already welcome to volunteer. As usual,
> we also need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2023-Ideas/). Feel free to share your
> thoughts and discuss.

I am volunteering as both an Org Admin and a mentor too.

I am not sure how many tests there are left to be ported to the new
unit test framework. Patrick told me about porting some reftable unit
tests to the new unit test framework though. So it might still work as
a GSoC project.

> Do feel free to ask if there's anything that needs to be clarified.
>
> Just like previous year, there will be a GSoC Meetup in Brussels during
> FOSDEM weekend on Saturday, February 3rd in the evening. If you are
> around, interested and haven't received the link to register directly
> from Google, let me know so I can send it to you.
>
> There's also seems to be a GSoC stand at FOSDEM on Saturday or Sunday.
> It's said to be located in building H, level 1.

Unfortunately I cannot attend the FOSDEM this year. Thanks for
mentioning this though! It's a great opportunity to meet GSoC people
and open source people in general.
