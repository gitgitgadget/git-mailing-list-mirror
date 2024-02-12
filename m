Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A01EEFD
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781107; cv=none; b=kY/Y0PhN2EW7xMEYjOWps3UG6w4tC2Kfjvh2RnDhhtgZLbN6l1AvCGhjCTngqPZD+qjYxJNM00yFNvJVqHWLjwWdOMN5BKW0Zhq/3C5ZgLt2a+aEZA7biqqESs+OJMwS/zl4Fk6ABtsa2aMRPxpw/ayjQIziYZm+dfVinG+4cgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781107; c=relaxed/simple;
	bh=DlbZWfzEI2JN+hjYb4aqat/HfNmfmUmSWSLuEACUZMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wq1/DztJSwV4DnggKdyh7I+6PbShmJ56XKcEGGzWBSMScNJisENt6E/572TA9UFu9YLhGBuYnH83xXx2VStWmuumpG44+1C3/6A3bu+EyzlN9wrmmu4jAywJjAlA7MBOc/NGgmp/KeTcPd/IDGVpxiWxbEAzqw/qOHbpk372JoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka6qNgeX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka6qNgeX"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so506563966b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781104; x=1708385904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlbZWfzEI2JN+hjYb4aqat/HfNmfmUmSWSLuEACUZMo=;
        b=Ka6qNgeXswmms2t6AsVsZA2axOjfQTh8ZBR8io3ay/wBxbSJTDo3WG5xhMDsD2FJ/K
         4roQJXMMW89S/NigGDkSgJ05xShaSbUIZs/nxrvHCSI5CcE1Ncs6bHim1n6UxVig2WmY
         L02zZUeSx6wGaKYad9LowscqZEwTMIhQWRl7aXGg+ArovutYLs3ZenUYfMtlNA4l5Iho
         IQUglNwsHxe6KfVTLsEfFGr/CC/LCOwlv7yR+t3sRNs9buN/w79TyfKzt5mcD39cdmmf
         Ov6oGPHhu0YI/jUB9p/oZLYi+OMrMBsEikKY3ua7aGqPDHSk9t4SEfGgoH6v4WRJNcFK
         O8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781104; x=1708385904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlbZWfzEI2JN+hjYb4aqat/HfNmfmUmSWSLuEACUZMo=;
        b=LZ9g2R1rmKif3rwFiQNFPlFnmGkN9TcWzrizZtqAkRPrIVityT+hRpFiADTeQje1mT
         AanslR7P8MilpYrPjByjBqxMGH/WnFhnoaw4Z7c4Fnd076p222/MOusKjh+Ewn6WgVnK
         TSUnA5DV8K4WRnSmXYE7b8grqoH8roqInWz+Am4EVhV7x+InpB3TX9RIcpXIR4K45f/m
         hHBKkaVONSQZqDYPT105Q5bewAnsg3zOK/YMMPmBbFz51l1rx4xtDLxvDWVMrkmFGHFL
         nmbN0MsRrsyc882JVFpz83jZQmbUMD0yE4yuc0q2UstTnQyd87bOz3Z+E5peAgYzIXbI
         mH2A==
X-Gm-Message-State: AOJu0YwdcKRFPNjTT1D7rXuXuocgtOao6WGR+WSjjctIB3I72+FV+01i
	SV1AaisCkG83svB+TOLTK3x9CgcMokdMm4UlmL2qXDT7gn/XZmw//63UyZmS/yK/8h48E08GsIb
	KLOQn2f5p7aWwYrROMqwGM3YPomQ=
X-Google-Smtp-Source: AGHT+IF+tS2Pa+ohYUB8n8MfoJhPlKYruzXzOeZwB7PC78K+HR6RxGHT6LQxtX+ZiVbGTQe31mW188HUoyoJXQNZZ34=
X-Received: by 2002:a17:906:395:b0:a3b:b334:2f26 with SMTP id
 b21-20020a170906039500b00a3bb3342f26mr5645524eja.61.1707781104100; Mon, 12
 Feb 2024 15:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:38:12 +0100
Message-ID: <CAP8UFD3u+QDx2LqpO2ZpeHQszwjMAsQ90qqbE7Om=t1vPRQ==w@mail.gmail.com>
Subject: Re: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the separator
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Do not hardcode the printing of ": " as the separator and space (which
> can result in double-printing these characters); instead only
> print the separator and space if we cannot find any recognized separator
> somewhere in the key (yes, keys may have a trailing separator in it ---
> we will eventually fix this design but not now). Do so by copying the
> code out of print_tok_val(), and deleting the same function.
>
> The test suite passes again with this change.

I think it should be clearer above that this fixes a bug that was
introduced earlier in the series.

Also I wonder why it was not possible to modify format_trailer_info()
like it is done in this patch before using it to replace
format_trailers().
