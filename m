Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F43D68
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40AB7
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 23:28:37 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-66d17bdabe1so17455966d6.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 23:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699079316; x=1699684116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1tp5TVOaWsffzOBnNVu6nopH3hwSM8ckYYh9gEPXG8=;
        b=q/6KrrRo95HTo3gRyK9vfoo2pAxmiT4JWp/cogwKfpmXM/xaoJXtA+WHRROfSq54Gr
         VUnu7+KmL+37geb4NGxcjL4xXcez5n9qoU2axDLCmKfYLLyrduCFV944p3wEfhZo/DCC
         lyFAJ8cZ/kyzSI+rNoxOufMp516S/m65pZIngV+ohyZCoJSn7/Qc75YefCWyV43CGqDd
         Utg6A/c1IOJ+MggHQ1GaJqC8mXYUzbAtSv5KUhvEHAGI6AG1GnjEwsP9Y9LuXVOjnRQ/
         wdZJ6t6616VD67Qv5p8eYp0uLenw+h8dus4Zv6pROR2ZeRGhXbWhAjG1dJZfbv+P/hae
         FnUQ==
X-Gm-Message-State: AOJu0YxIJJLfsjVRLyr5HHWJbnUpF0b1CMxQgwvbNWyiwhiyWEQf5dxJ
	/ZD73aFVgX/6SPqCUv5RT21fmGmf+TtUGj1vgKY=
X-Google-Smtp-Source: AGHT+IHY4jzfZo79+t0YNz+mUaZhGGrMAdHUPhjpPSM2dHdvDJz9Zlc8716/k9e+1QYM+8Jfxjh+nL3Y0XMxqpasyPs=
X-Received: by 2002:a05:6214:f61:b0:66d:44c9:ac8 with SMTP id
 iy1-20020a0562140f6100b0066d44c90ac8mr31489722qvb.24.1699079316675; Fri, 03
 Nov 2023 23:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103143508.896745-1-jojwang@google.com> <20231103163449.1578841-1-jojwang@google.com>
 <xmqqsf5mgl0r.fsf@gitster.g>
In-Reply-To: <xmqqsf5mgl0r.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 4 Nov 2023 02:28:25 -0400
Message-ID: <CAPig+cRR0PfWP0_uoevQnctSosb-k9cp3b08-sQNV5OPuQ2tAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and git-stash
To: Junio C Hamano <gitster@pobox.com>
Cc: Joanna Wang <jojwang@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> > +                     if ((magic & pathspec_magic[i].bit) && (pathspec_=
magic[i].mnemonic !=3D '\0')) {
>
> Overly long, with a stylo.
>
> Here is what I ended up queuing.
>
> +               for (int i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +                       if ((magic & pathspec_magic[i].bit) &&
> +                           (pathspec_magic[i].mnemonic)) {

Nit: The no-value-added parentheses around
`pathspec_magic[i].mnemonic` can also be dropped.
