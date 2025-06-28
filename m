Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966145C14
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751116486; cv=none; b=tjtIbIQQirp//1ePT6cw4M9gvot5poOGOoIJlrgrnQGwmMPTqpSH8VM/P7tD5XVMV2SU3L7nMZwiKhubf20lCqonC7cwg1JmX+8JJM9Y1l6hqBoUZRPYsyzdtitbxwBTioRBzQI5kpRQuHdUCbnBZWgZ6ejVfOtrYQbpMwDP8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751116486; c=relaxed/simple;
	bh=HFeb7gypbGvzwpwi1Lm587KkzUCDx1tlt13pWC5WfbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw42BJfKr1MMP++q/tSz1H+N86gqBHVFz3X5X4A1EVyTcyUVk6nb9jQItqhKO6MOLNaX/lXubNGz1kYFVjOXWseVOFNaA0xTw49PMR0Snj3bTN3sE+vKwQJektkmwChjeIAFLIuYYxLJsf07MS0wUTbI4L3+b02OkdCLNPCMbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPbCVjy6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPbCVjy6"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31c978688dso2142329a12.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751116484; x=1751721284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuusXatSxuVqrIfUsgAs+WPE1okYcbyJyWqIsjsT03o=;
        b=DPbCVjy6EqrYfTvakUWvZSkZmQYhyizpGjGW+FEqH72GA35c9lgeeLbF2PcKPAn6Bw
         OKZei5+7n5V/ysR13qi+WpZ3D1v6/lv44x5IuvQsHR3cywe6yNpGeynX6EvXtsn32K43
         Ct4lfClv1Ee3u9i/KfWd/aQpiN9Ne1odJ8kX3sSjadJt9gGrdVm/iuBTi+Mmbm1hfPEZ
         H5oD3TL1V4OTLO2QZdbuyAUe2M8LxoiwkSjbX6mc3dFkf4NB59+3UFO9tJZnSCK84mPl
         DgPXjLDeDUcmLbZ3/g2rMdsjHQQZO87SFMwbHc9HtbVaUIlQoAjO254qk1y0HEwAq9uA
         T3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751116484; x=1751721284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuusXatSxuVqrIfUsgAs+WPE1okYcbyJyWqIsjsT03o=;
        b=P4AmqoW4LXfxIUADUt8hKW1sGrlFcphylw68S5A6ieAGtOO/eQqvULKgGuDP/+YHKt
         vNyrFYXJuHJTHJPDJC7vxTa01qQnHaOQcr3/nftz1nhNy6lt7SbFbm95DgtXZZxka9r7
         KnVEiOROHZgYesL8wCp3zgAZK5tBGfeu1pKzsNXwTqdXR1UOUjKV0/ZbQ6izRLubnyWy
         jZTQCsL/m9vRb0YZNzVd8FUrobWZXT4T5jHSla6P4Vle2wfMv6oFeGqNrDV6PbzFfx5F
         PpBT0hnRX5KAvpwEnBgmdmESj9jQUAp0Dd2BBMZql+Ykx81ZPBHHJdV/Qw39oSD3Anbr
         jnOw==
X-Gm-Message-State: AOJu0YylpBZTdzMAshVe5dX8uIN7zwKbJ0iXD/jTAIqUWUTsRdM+JfHj
	BUw5dV851rXMJvj2TgOxqVrF0RCfBH7QGw4qZbKF/gDGf8L7gHjJLz3dAeaLrCYbY6AaMvFDRKm
	dxaT0larPg7JCMLDTicrCIUcsrmT3zI0=
X-Gm-Gg: ASbGncsZcs8bM6aeWynLUMfvuK645ucaC1fvFGtDO4pyNxzpcURC+NB0e3NhYKdtn3F
	DCI+eX/RW9/O/UyDvVznsmXOyUEBUYKpEZwze1uJBS4HMMU8q3huZVGktfsddLz059EVn5cGJm6
	Ff34a1MsqFRWJYijPznflLICepd0GkPuEj/kYxJoaFdURRymBkIGySGTfRWh0JpLQum25il79X/
	PqLRA==
X-Google-Smtp-Source: AGHT+IFwcSljKoAMtWNMNhsyQ5BS0vUomzmk3nA9eJRhmaoz3FgiGPBmEd3drvZQ4pVKCSSa3vBdap+1nnc/gbyoW5M=
X-Received: by 2002:a17:90b:35ce:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-318c8eb9c6amr9182542a91.3.1751116484141; Sat, 28 Jun 2025
 06:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749343601.git.ayu.chandekar@gmail.com> <6ffb071295272a1d5311f52d8d2015d0aec7e71f.1749343601.git.ayu.chandekar@gmail.com>
 <aF-ZLbf8rBHrHOXb@ArchLinux>
In-Reply-To: <aF-ZLbf8rBHrHOXb@ArchLinux>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 28 Jun 2025 18:44:32 +0530
X-Gm-Features: Ac12FXxZ7uLzct2ETaM4DrG5KAxrsZw76doYk5OJSyhYoRigeWdzaQRUHbt7UO0
Message-ID: <CAE7as+ZF3o=vbS3o4RXfRiQJNXEb+0UHQ1tt7v13NX2rDcO0ow@mail.gmail.com>
Subject: Re: [GSOC PATCH 1/2] repository: move 'repository_format_precious_objects'
 to repo scope
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 12:56=E2=80=AFPM shejialuo <shejialuo@gmail.com> wr=
ote:
>
> On Sun, Jun 08, 2025 at 06:36:34AM +0530, Ayush Chandekar wrote:
> > The 'extensions.preciousObjects' settings when set true, prevents
>
> Should "settings" be "setting"?
>

Yeah, thanks for correcting!

> > operations that might drop objects from the object storage.
> > This setting is populated in the global variable
> > 'repository_format_precious_objects'.
> > Move this global variable to repo scope by adding it to 'struct
> > repository' and also refactor all the occurences accordingly.
> >
> > This change is part of an ongoing effort to eliminate global variables,
> > improve modularity and help libify the codebase.
> >
> > Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>
> Maybe you should add the following things before "Signed-off-by":
>
>     Mentored-by: ...
>     Mentored-by: ...
>

Oh, I missed it on this patch series, apologies, I'll update it.

> Thanks,
> Jialuo

Thanks:)
