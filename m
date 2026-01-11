Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59D30CD81
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768129312; cv=none; b=AvYzUfdxXalA0daL+Wk4m3NMVvpfCfUZTQo5d6XgN5JnD7Yxs2qk2UTx6d3byW+WfejhnicTAdc9kWwPvC4qPcvSSB9PMYcB8qYjfwk6LtAEKtQw7E5eEnu2Wmhcrm5wn8mYonKYSWG4QV92mFYP4CzGnJlKklyQ+H63xnXJY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768129312; c=relaxed/simple;
	bh=rrH6SjFumweMpBA5faX7tNo50XFtotfeLH9Z6ml20nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCnW47rG4viQK22oXqQMcDGlMIYSg9vp4yO0SmhUY5ywJcf6yJ4XfD3NxectNRbzMkKdDG2hMzALbyJDhcxIojdnmQMNjdYS94RPMsrpgScjdS7DB1Q5pzcWYgpHScsxoftcGDdeag7FCTIvuxXKJErX6JUKpYyopaKTmHT60Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmJrWfuo; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmJrWfuo"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6446c924f9eso5103684d50.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 03:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768129310; x=1768734110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H92OEAteLWkiGm1CfbWgkNddrxDvIl5oZydBGESrf4w=;
        b=JmJrWfuo+/ktCtrp1B3uGr/Ft//0BOHkuiFHTCN7LHtQl2j6/cCFZZCvq6BqHHgVGu
         jn5YY/UXFaNnpUtMrzPKo7Z7ge81RNcf0elSGPBH25JX75IVPW7gsAbOpDs6oSx1LlJl
         xGoeiqY8l809Uw7frZGX/6VZCv0BbPdIimJHfwPu3HzBAR0CuX+ahZoWN1xiLPlfnMyq
         iLHIAvktUNxc3IGjQw2N0YHg1Vnks7PPxAY50RTbok2mPIINZHEBYmnLF6r01puu6Pdd
         cPHoUEUFoAtdYOGXErBGQqgE5a4B8kNd0jDhIwNCXy7IwL5Mq0aRIoLe5X6nKOrjWMsU
         szPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768129310; x=1768734110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H92OEAteLWkiGm1CfbWgkNddrxDvIl5oZydBGESrf4w=;
        b=PXmmc+iJGRpslBYhfyGtcW/EsW+dZOhXGHqQ4M+/S7dHFxqjDMjF6NvL5btLe/wHCn
         hlCT4AbPFpIxwAjSHDds1AqImrvRL6ipQD6EgM3KVioLJ2wSWsfkBKQKxeYA9JAdFjgh
         lWF+zgThAdSST+6vgUXIdRAVm+cqEvqZt+EHd65n8XtmN/5n3TPaFHJTUJyf7e0zUQ+f
         /hAkQnPBjtL9WqqmKeEWegJ3NGeYK9Yy/tLRM1f9kY2VAhQ+e49a8HVyfByc3AvrpmH6
         U2i0dp9oeOHUODB0az5EZaXrvtmJa51myStnoK8PmmgdzlPBIfVSHbL/YSxNMwO/F1jB
         trMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAqvBC/dKjFy7/B3uDl4RXOP8Psq0Z79Iz48MXetjG7CCXNrhSQNpuztznsHrdothnZt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbVav73UipVjsAEX3m8r1SWMcScQgNuUVBSw9ZG/PCW3dV44o
	98UzcLA3vD89bSYhoxhb6q4RlgsEe/CO8zdNnSWhfxqc21g00mnCCR672SU5QIyg87ano3LBwYm
	IP06fkBCyMZk92a/TWF5WU5Ux0d7Mhxg=
X-Gm-Gg: AY/fxX7aPrAg0L9GDfpOFYRiQ3hf+OVZijNCnVu9qdb/XmWcwnF1M2EruSODEoSBI3R
	RlBzAcXUmVjoNVBEyodqSSVhGGka+dlMKVv21S+tJ5ls12bQKVAI8d4YxLpVExEzGZZhcMc1Go7
	Knx4rvU4aw5lKhwquAdz2vo7GYpO2ZCwnkU+Et7y+SXsz2sUiAQfvNVf4kAlArinarsksFGeOHx
	gGpyCPR6G5UQs/f2VWdbSr3OY1CZgJUT7GCMvSCvVApmS2YuekRXSzmR5mwFb09Mf5EJ8U=
X-Google-Smtp-Source: AGHT+IGEbp3hq94rHTRJaobUzcw3lA1Ss2z2w4jSUNNUneUKKvZldTtbsmA2sbc15iuYG3gqT1/Yu2LTpG3ML/koTDM=
X-Received: by 2002:a05:690e:13cc:b0:645:51f9:b4c0 with SMTP id
 956f58d0204a3-64716c390b5mr11156651d50.55.1768129310086; Sun, 11 Jan 2026
 03:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
 <20260111072950.9463-2-deveshigurgaon@gmail.com> <CAPig+cQgF2yHL40OnOB=SWMHCv+z0hLTAwTD8q18-DGPHO48cg@mail.gmail.com>
In-Reply-To: <CAPig+cQgF2yHL40OnOB=SWMHCv+z0hLTAwTD8q18-DGPHO48cg@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sun, 11 Jan 2026 16:31:39 +0530
X-Gm-Features: AZwV_QjHF__pCuqM_1Q_Y8jJnvA-w1RwIp01S9gMO673_LjH9PGerjQPaVkgxyw
Message-ID: <CALE2CrSHocR-p_zVS8CihtJRpR6Fd72JTy1-KJ7L9iMMubp0sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5403:introduce check_post_checkout helper function
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree with Eric=E2=80=99s point about documenting the helper=E2=80=99s ar=
guments.

Since patch 2 also changes the hook output format to a structured
"old=3D=E2=80=A6 new=3D=E2=80=A6 flag=3D=E2=80=A6" layout that "check_post_=
checkout()" depends on,
it would be especially helpful if the function comment spelled out both
the meaning of the four parameters and the expected on-disk format of
the args file.

That would make the helper=E2=80=99s contract much clearer to future reader=
s
and reduce the risk of accidental breakage if the hook output changes.

On Sun, Jan 11, 2026 at 1:23=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Sun, Jan 11, 2026 at 2:30=E2=80=AFAM Deveshi Dwivedi
> <deveshigurgaon@gmail.com> wrote:
> > The test file repeatedly uses the same four-line pattern to validate
> > post-checkout hook arguments: read the args file, then test each of
> > the three values individually.
> >
> > Introduce a check_post_checkout helper function that encapsulates this
> > pattern. This patch does not change test behavior; it prepares the
> > code for improvement in the next step.
> >
> > Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> > ---
> > diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook=
.sh
> > @@ -9,6 +9,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +# Helper function to check post-checkout hook arguments
> > +check_post_checkout () {
> > +       test "$#" =3D 4 || BUG "check_post_checkout takes 4 args"
> > +       read old new flag <"$1" &&
> > +       test "$old" =3D "$2" && test "$new" =3D "$3" && test "$flag" =
=3D "$4"
> > +}
>
> Rather than forcing people to read the function body to divine the
> purpose of the four arguments, the function comment should spell out
> their meaning. See the many "Usage:" comments in
> t/test-lib-functions.sh for examples of how to write more useful
> function documentation.
>
