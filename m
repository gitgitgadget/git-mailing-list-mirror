Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875631B805
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303709; cv=none; b=PKRUSZBYKfDgIohsoml71yn23+e7/uTejBvaI5HaKzqmlYhK/ewpWEzmEJ4oIMYwBawHIOi4YbaX4YkeUJeAUbCpjgtUrI5LUaZsLhtliSa7kH/ldv7BQCIuWR85KN66S6mIgT2tdl5BlX0bEsLSctHNUcJvYwKIzenuhfbrwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303709; c=relaxed/simple;
	bh=UctFbPpiBIvaU0VKjeFkT2VavyjXazNpWbLyoqIt9Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwtZ73M2ygXRYciVdVL3DTTikDpglS/YnduQJNM6hDAF533LHXHd1kjIrzGeYavFuEgevx5ATt91kNyqn9y2IvJPGdT3DBl5xORh8fXtqUu1cceZB/yqYhBO6MEewKF+mh8CeuZkstk1P/hVQdvgyLh+tT2c863L0gnu/Ehh340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoUIQDGW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoUIQDGW"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so73360666b.0
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303705; x=1761908505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx9O+7i3RWjLJj6ZSLo3hLlQMeSnvcZbd+dluCrZ6Tg=;
        b=OoUIQDGWV5ZA1U1mQOwsJ/VCRWEm7etLSCWQsmR6z1MayJlFACAvamBVX4Hc+lWpPq
         GJ2BOowrrazyDeUsF1yHaBE5OrYd823BY1g9bYISfl+kYtQON2HZwLMVI3FBrhn4s++v
         aZTyvMXhMOXEKpl4/SedaU6V0rFA6xnRG4qrpFAmRHOSIp9i0APlMc8cAuoH6QRaEmCa
         EZ5owdXXskzc3HQYGv/kqHkpH5V0EwV7r/Qw3RmjyL0wL0ClwXV2Qe8SI7SFEKPhVgpK
         T1PYTqjVwVx56f7fmoU5dYuQdwhAwVk6a4UPLR5wGld78FS1cjufEWf/y0gmqesahNdv
         RqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303705; x=1761908505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx9O+7i3RWjLJj6ZSLo3hLlQMeSnvcZbd+dluCrZ6Tg=;
        b=kuSYCEat8jCOPv6UVwtB8Ggm4IlAqaU3q7tn+Exk+VZGj5yq53iBA5zXBNJ9O0zXZS
         fVX9fN/lqwBL0Naf6/L68sHlyJFofSnDjtTWbl0miJs5TLEfJ/XTB4zH0ZOpads+vVxh
         prRtYZmSUAineL980QVvOHXAbYX+AxuSxOHD47A+ZcbUe9OTyfpQLnYG0v2l9TJojw73
         zB8IjNQJY9XlBd2PkF2HikcZO6pvNwOFV8o17apBIPQN8hEMoQI5Fi0veH7vKhE8NLvg
         qUm9u6lFWh0XFaz13jTFbQE7J9KQ19uQsi0XP4+N1CedIgG3Pm9iixWDTnCaPj9Ym3AP
         sC6A==
X-Gm-Message-State: AOJu0YxgfkX8pso4iPj5/396nFfhrc/TR9EW5KsucwMBbeu8/dFeLg5e
	hNNEUiww6JpMqKFNSh8VxKZKGev488DIjtWsyR2W2gsaouSpwBCMzXZNSMIuyZujB0eGn1XFSRo
	awxes6AiOGZ0XbAmwYc2uaLjpDpTb1uU=
X-Gm-Gg: ASbGnctR2fTDcA47rMFx17DBWLpUQrDFW+uOaVo7Ce9Oxy39xKtKE7U/vbdyQBQZQjl
	Buze8FaRoB5/tUiflb3luvSFWUDZHPhOdzcOIOeMCvuHX4Os6gVXJbItcQSCX02vsV0Ntip8ymr
	uqupQZacRVapmJGLBQc7x+AlEGMcIRgroNbr0YDb2XQFVrFAX6g8DEREzaGGZ6jvj3uxTp9vj1A
	M43KGUCR8diO7kX037dIQJRjhn4ejCCLux5vmeqVebrlIXAgiSOB/eUZKyt
X-Google-Smtp-Source: AGHT+IHyDRL5C2hTDUT12fdhs9K/EL70AiViUtWIUyPwTQDQUdpL3uXZYXkgCYctQabYttrCe1nMoDiqyj9XSES/w20=
X-Received: by 2002:a17:906:7312:b0:b42:f7df:a2ec with SMTP id
 a640c23a62f3a-b6472d5bc00mr3242081966b.9.1761303705379; Fri, 24 Oct 2025
 04:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com> <20251022185045.29256-4-siddharthasthana31@gmail.com>
In-Reply-To: <20251022185045.29256-4-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Oct 2025 13:01:32 +0200
X-Gm-Features: AWmQ_bnexkfK4SUNkwtcp991RhdI_irxZ6a1pxLsVk8PhwWGBrsFKy1DqkY3lgM
Message-ID: <CAP8UFD3Bz+Yn4qtCrFoKcE=u-dAtK0cXON1nFMRL8n9wBSS8pg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	newren@gmail.com, gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:51=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> @@ -367,7 +368,20 @@ int cmd_replay(int argc,
>         die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>                                   contained, "--contained");
>
> -       /* Default to update mode if not specified */
> +       /* Set default mode from config if not specified on command line =
*/
> +       if (!ref_action_str) {
> +               const char *config_value =3D NULL;
> +               if (!repo_config_get_string_tmp(repo, "replay.refAction",=
 &config_value)) {
> +                       if (!strcmp(config_value, "update"))
> +                               ref_action_str =3D "update";
> +                       else if (!strcmp(config_value, "print"))
> +                               ref_action_str =3D "print";
> +                       else
> +                               die(_("invalid value for replay.refAction=
: '%s'"), config_value);
> +               }
> +       }
> +
> +       /* Default to update mode if still not set */
>         if (!ref_action_str)
>                 ref_action_str =3D "update";

It seems to me that a dedicated function could handle this a bit
better. Maybe something like:

static enum ref_action_mode get_ref_action_mode(const char *ref_action_str)
{
     const char *config_value =3D NULL;

     if (!strcmp(ref_action_str, "update"))
             return REF_ACTION_UPDATE;
      if (!strcmp(ref_action_str, "print"))
            return REF_ACTION_PRINT;
      if (ref_action_str)
            die(_("unknown --ref-action mode '%s'"), ref_action_str);

      if (repo_config_get_string_tmp(repo, "replay.refAction", &config_valu=
e))
             return REF_ACTION_UPDATE; /* default */

      if (!strcmp(config_value, "update"))
             return REF_ACTION_UPDATE;
      if (!strcmp(config_value, "print"))
            return REF_ACTION_PRINT;
      die(_("invalid value for replay.refAction: '%s'"), config_value);
}

[...]

> +test_expect_success 'replay.refAction config option' '
> +       # Store original state
> +       START=3D$(git rev-parse topic2) &&
> +       test_when_finished "git branch -f topic2 $START && git config --u=
nset replay.refAction" &&
> +
> +       # Set config to print
> +       git config replay.refAction print &&
> +       git replay --onto main topic1..topic2 >output &&
> +       test_line_count =3D 1 output &&
> +       grep "^update refs/heads/topic2 " output &&

Nit: here and below, it's a bit better to use test_grep instead of
grep for better error reporting.

Thanks.
