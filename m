Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2522E093F
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432353; cv=none; b=cAsjmeEFhdiTw3yR3RstcfdOP1a+3Yep3Mou9rb9YTSQvFcX1PkRO+HksTHnqZaDW4S9nAPjiulDWrgwUTdjKX7EFnNvyCwZiIABI+fh0/7ZsVbz+NFfBofMs1i6P1RufN4wcJNAqYEa3i+CwFi50aINj1i7LSaHMlWkZCKgvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432353; c=relaxed/simple;
	bh=95x8YZNn9nNpO0YgYsYKUOCOcwBuDzEgq3BwhFbHlJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMJs5SCkt6c/LqFEyhJ5mhfTYt/zLA41tRRq7urlAT3nBq0LuPEM4ZUKUEEOZGMc7OfFWa3rODHtsnFU64ERNG/XGxj8gGy7XEDucm7wygT6GBKVDgCR2nUf10Izx8vbDeQ0Yqi3sbNIU01pAkOLfksybTjI7XIkp5bjUaTdlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loiFpfPn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loiFpfPn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63bdc7d939fso293976a12.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432350; x=1761037150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95x8YZNn9nNpO0YgYsYKUOCOcwBuDzEgq3BwhFbHlJI=;
        b=loiFpfPnR+suKFAsmi4IFe46e1049ZAXPSs8oFPw5BGM5Wo43p7HlRei4NpK7Ya1aK
         daL7EVpYX09kbeNtm1lRzXoQmTfo8HFGwiA7hzeZLyY26O87nsu2pUMC3HBSe5zwZWpN
         eZUvY7h/AqPrNtxc87OuEDaTiyRQyXmB++xcsNh14nRB6Ghm+1OKMRf85GkaBMIqYW81
         vlWdkQxXnc0SJe0jB6bpkQOyZIV5vcQG4Fq2MFiyBwtgUGB2MHmp5IH98jqiEFNGKQCk
         fC4mGEDchp14/zVWuDksGv0F2BfMK6o3GuJrd5iyqDYllXcjhJuqaOotJ+vWwZgxzJtW
         3N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432350; x=1761037150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95x8YZNn9nNpO0YgYsYKUOCOcwBuDzEgq3BwhFbHlJI=;
        b=wizIg+Q5TSZPUiYukWoCNE0UGqhe+yU5iI1i+nfVTvxeGH451QDI6D8G4AGGELgk07
         3j4eE4INyDF/MYes6gj7amdQUmkSCLxD3H/2afefQCBuU4t/JREEPu7Ak76LcHgXvFIZ
         Lfa+YCkTPYQAf/8w7+88+bcLGcwvF3h8bsupTgt6x1Lq402Ez7TY/ENem+uJWZ4QkrTK
         O8GTgHr+Vhg3HN0zv7fiLsXGcfhE0uC/+3Da10zmphfxeQUSSJPgGrwzOT7GxPwxUSkm
         rtOafEixPG/BUsxJ/dM8+ea10qihySQbv9cSUVpdHZg4gagNmcdDcAWiwODRS/Njfjvs
         yCQQ==
X-Gm-Message-State: AOJu0YwqmJSV/xz8ma3od+ufelfswYBvey4i6/ylD0F7i8W/5g9D+8j/
	QcVejhvK/yZjh+7tVBtDgG9TLXeRnC/nn64zgyq/R736x0B9Ywm3PzNQ3GkwEOqwqbG43YBrC4D
	LMzRs/OYVprFmrmWN1X/QxrvLCwLBzw4ZJy6K
X-Gm-Gg: ASbGnctFq0Z1TYRj4TcVaCpZMggRFYIOD4C3AJQdflOEfFL+5ooyWHlzPxXdbfSIURg
	GqlDkIDarnYEX8bUqFYrRXmKhi+WgKUN89L3MD5yZPXfBqEmIf6borQH5BMJIqiiu+gcDGvotZh
	o4138qPGYTgvxqR5HjbIfABnbKAWVQZsGImVIX4ueP/A8JvZeqTJpsFy7o5oPuYRrgBi03QMugs
	OhN7uWBZ7ziTZvcu+5BXF0GAQ==
X-Google-Smtp-Source: AGHT+IH3pV293e52AtDNkQxqCpp3jUUPcldo01zVR7KsMlVzh6n9bjLC8ntklpDEh0AhoK4LiIMkJXyNQMneQA7Xcy0=
X-Received: by 2002:a17:906:c102:b0:b4f:ee15:8af4 with SMTP id
 a640c23a62f3a-b50abfd5ea6mr2429554166b.34.1760432350076; Tue, 14 Oct 2025
 01:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+tvzBWXYaYXBXgCpcCv59nJdhw+hqQBfHgcC9hRoQ5pe0UX-g@mail.gmail.com>
In-Reply-To: <CA+tvzBWXYaYXBXgCpcCv59nJdhw+hqQBfHgcC9hRoQ5pe0UX-g@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 14 Oct 2025 10:58:57 +0200
X-Gm-Features: AS18NWDf4jWTGqAX4cb-PV5CyF7L1Xt0F2iyA3_8EqrRmKuI6By339mvBEeDW28
Message-ID: <CAP8UFD3=k_pNurhwrAH+Q4T5Hb=OiP=2+GufqM33Sb6-aWK4AA@mail.gmail.com>
Subject: Re: [Outreachy] - Introduction from Solomon (Solly) Akpuru
To: Solomon Akpuru <solobarine@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Solomon,

On Mon, Oct 13, 2025 at 1:04=E2=80=AFPM Solomon Akpuru <solobarine@gmail.co=
m> wrote:
>
> Hi Christian,
>
> My name is Solomon Akpuru, and I=E2=80=99m excited to start contributing =
to Git.
> I=E2=80=99ve been getting familiar with the codebase and recently found t=
he =E2=80=9CModernize Test Path Checking in Git=E2=80=99s Test Suite=E2=80=
=9D microproject.
> I=E2=80=99m currently preparing a small patch for it and wanted to introd=
uce myself before sending it in.
> I am looking forward to contributing positively to Git and the community.

Thanks for your interest in contributing to Git!
