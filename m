Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB62E573
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767259182; cv=none; b=kpSomOqjfpBcMcvkYy10+bzTZ+k6B630CNILY/U4+ZYeL7uNjvZaEzsBba6fDld34Zl4PCtwLABNjLX/LMrtMeH2v+DW/8dKHKUgCCNqZaB+DjmpSDkuLJqfkDt0tEEUkd5wDHWXq7csVxx6Kex5U/QnrF0f5m8iMChxfGdZnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767259182; c=relaxed/simple;
	bh=vyTP1htLLHJsPDXI+q7s0Jc7vPY3FCZmgpA7LTQq2zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Mu8KVKGGXnkkMnbTsMujATF6223aVz6hJwiEsd0nzuzGRXBdSjuFeI5KXL4ujE58amOhXyUd9v8DRmjFhBzLpizKEogZt1JifU53Gg5bWCGm9q2loOPnbScOOD9p9svTna1+7Pc+hKqkEf67gctpHkBZsDFy7P+qaOScIlqrJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3Is9o/q; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3Is9o/q"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55ad466ad1eso2779993e0c.3
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767259180; x=1767863980; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyTP1htLLHJsPDXI+q7s0Jc7vPY3FCZmgpA7LTQq2zk=;
        b=N3Is9o/qFm3Zjg/Kb4BZP+FNxonKJKatNcTSw3eTkn8sR8sHnKlfY0nvKy6nbPXg2r
         S0QJa8uF8WpyvBpG014DxTBR3uzCL5ZdTB1yA7ynzPgT04xMLHIiFDb+0dYz31xmJVRw
         vQRJQcNBtWw8HIr8zhGEqL0tm2xc841yrfU9vEqBZdZrJX0rxSWiaN2E3LwQlFlhd4pG
         KU3fInX7p/yZFoe/YH0etrsnWd5lQvgZCiuqis+oLCGmzPmkgVKN8n8OuBYHl0+avKNX
         eCz5sirpTSrWV553SgwcOqVqGY/bTHP0KNiW4R0kpge92/eLKrDCx9NM5zLfz2XRe2I8
         Yc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767259180; x=1767863980;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vyTP1htLLHJsPDXI+q7s0Jc7vPY3FCZmgpA7LTQq2zk=;
        b=p0uMlbw1sLVfJkidYTJpPalWij+bdoqvOfbM85MqqJx5qErvzwjgHNO9XL1lQEMCK0
         N6tOHir/OQrlU6nAhp9mhf6VL4n2JPiuJEEeQC+e+5m2YNvAXKF05K2ex7SRML3Mdu6S
         50PbCgfOiWJ8KJQWMumwruwL5UwBbEJVZ2/qsNdc+xtLHlT2GCxZssvPoE5fKL0xhJ5G
         uwfNHRHoF05dctlxP1nCQV2Y1n2YrMvr9Vl7/+PLCzBedpsOZXOx604fCt3zwD4tsfeb
         szf0/7O+1HLRaDNe9pt87qxp76ZZmxn4JllTg968BIp9gsF5CdutWE0Zma8787d3/lG1
         9jSg==
X-Gm-Message-State: AOJu0YxKK6VCinVlghRrn/qaGoWf74KxLmc8jqRPsmlDsXSz3c4vV5/H
	lKw/P9KzxCq8oeCMJmEwJzeW0KzWosICD2IEDOF0LIBWGYJgbs3ReMdeQoF2Y/CTFSE5Zjwfjh7
	nc+Fxt4LxHmi6LsCXesJoThF4DM6ZwGIvc4TBLnk=
X-Gm-Gg: AY/fxX7wv+QNtW52DDGoXptiUk6lSvre4Ow6c4Ws6hqaH70Mp0Q7qnZ2s0gjZpPTGG3
	jsAPYhA0hExGFlfl4XrqHwx2Z9MwpcY06etw3UWTeOEQRxUe/HUFSr2dhQzbVKO3cETkdzsLpr0
	KcdVh6qcTfytq+OrRdhgKbMm4DQikBMURu7gm/Rg40aa+Qv+tIlSQvdQFLEviNIyjeizIdH24fa
	+RlSHEijlUuP1c7UcDZBop/r08qfKvH0gm51e2FJx7rpeNF8ZlxH5193a8egNVChA3qE/JWQ9CA
X-Google-Smtp-Source: AGHT+IH99DDhowKvE2anBKvAOIMbpcMSezs7gcVkRtz4IB+h3S/MJ+WO3O3DDavwEYDgtbfjzTN+YJ43b6v9UNbGLt4=
X-Received: by 2002:a05:6122:7c6:b0:559:5dbe:fe29 with SMTP id
 71dfb90a1353d-5615bcda43emr9643900e0c.2.1767259179913; Thu, 01 Jan 2026
 01:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fa1BB2DzDFj4+GLqtDPg55JCi9VGCv0pgj2C8y_PaM5rA@mail.gmail.com>
In-Reply-To: <CADYq+fa1BB2DzDFj4+GLqtDPg55JCi9VGCv0pgj2C8y_PaM5rA@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Thu, 1 Jan 2026 10:19:42 +0100
X-Gm-Features: AQt7F2rQj0LGelWe3ESABDb2VeuZkbROEKW0QgBmoVQF2qnb0gboVDIiM_YTs9M
Message-ID: <CADYq+fZ2gempytBwUKUMaV29mdHStueuMYMdqwM-7W_eyQ6znQ@mail.gmail.com>
Subject: Re: [Gsoc] Early Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 10:43=E2=80=AFAM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> Hello Git Community,
>
> My name is Abraham Samuel Adekunle and I am excited to introduce myself t=
o you.
> I have a strong interest in low level systems development and I have prev=
iously
> contributed minimally to a couple of open source organizations and I woul=
d
> love to start contributing to Git for the upcoming GSOC 2026 program.
>
> As suggested by Christian and Lucas in previous responses, I have read
> [1] and [2].

I forgot to mention that I had started working on this #leftoverbit
and had sent the initial patch
below.

https://lore.kernel.org/git/aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local/
I will continue working on this after receiving feedback from Junio.

Abraham.
