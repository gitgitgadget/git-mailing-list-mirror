Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF219F12D
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894519; cv=none; b=TlA1SI/CyVvkqfCY9tNledn4TV+l7PrRLvliaeJFbqaLpxFzMUb+JeZGD5neYgJB4XhwpMoHg6kZ/TgDdp5+nIOyLdTFbLcSBPI192UaO4o7zb8fhAxQv2a45KVN+jskCUaJhvx03Fbhfogm5hH8xXRd/sizsCF4uLBdWXNHXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894519; c=relaxed/simple;
	bh=Es7OjVViBgsX61VxzJFD1R6a8+T6Q6f3sLGQ2FBTVQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR8ciuBLzM1AWKmDO8AARRpOGpW90q2/OOVhq7lb2+b3WEe8/H79wXHSi4FH/+6GysisCI1lLK0tc56al53Vt1cs8myOL1kXJoF9MUepZabUDdlgWh/JjTLrEQuaE2kBSDmjQ4NZzrXie6B9doC+xpqqkViqeFFgSdjN+XzkV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh2wR5uL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh2wR5uL"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3391618a12.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 00:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761894516; x=1762499316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOdpcAhN7l5T09U+7qP5LdTmragi+sn4Bc63FSiEDDA=;
        b=Zh2wR5uLuRXNJh9jxZZqD4gDf+syrgMnW2Eo+THhfnL2ldrFy4kl/sGoTSScA/sYct
         BdSm9VZptN8oN3tnaA5GNa3N+NzJMw/hLkQGrP+wIHZOOLssMdNw9fzdnywZBZ7QbBfc
         +LdVKBfkQRxAX7RObnIZ9p/jLIwdWdh25JFNTAWpdVENE8n+L0xh5v7rLP6Auj1OYUaE
         zM1xKowZutG0G82NhSpGiG0vDZSSQLtURzxLkNaKhMzmBi+z/1B/2UnJaQqR9yQR1oGA
         Jsxb6jDne9vrhseLa+lj8+BFPwenkDU3UykRW97eWntweqnnwE/Fa3kfJZPIXel3tBoh
         PYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894516; x=1762499316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOdpcAhN7l5T09U+7qP5LdTmragi+sn4Bc63FSiEDDA=;
        b=YIIGoEAlEXkslc17WUVCBJlTScfDhYvSFkO4M8m9/zq/hKpcg2AqsyYopRRCApBkAo
         cE17AAEl4C9l1VxWHeackeaBjaKsoAEIb2v3eoaXOPdW322M0CXUI7Ka+hpx9JjuIQ6E
         UQPc+nqa4ukHa5nPsP2UoMkB9/U1d0bYpQte0J/xs55e6hfYG9E0287iov7ySu8EnVQw
         gUQ9EDMALzx1UsDiVASb4Ob+3xcf7+0de4UIAdSm7vYgkIF8cLuZFKMrM58njIordliI
         eh+C88CxO4MJrANDEe6x6pD4Hzu6McnH6LNCA8E2dIqh6jhm4lkg4/GvK78txrTbhkJg
         9lTQ==
X-Gm-Message-State: AOJu0Yx06YhQOPXAYDOBeUZrABl1688GRCAYJgZeP93pdyyaIENs2b/j
	faG0xUfyxzgk98YUtjLEOgsCJkg9inHRsoqwnlbuQ6vmY+ehM8H+o4Dh3OcHuD0Ud2lBE5UiW2i
	SoWDJJUkbkML0AD2V62YJL4LHTCrf5zM=
X-Gm-Gg: ASbGncv35m3lZoMS/DqAtFXPXpYBtjpYDcEzojYG9FxKr2t6gHEodu9nYwyopyU6eWF
	nLaUD4A/YiC8l9vtbAsekdZ32vBbk/LgSQB5J2vA2YjIQHxk1GR48Zfj4TU4QjCr/kJ4xm0QbYw
	YODM8yAHisieYypR/9agAjA+9e4PHEJvxc4Eo9/FQhph1AlCQI8CqM4OFgTZdFYHiAWKpFvJN7W
	JbqK8UstBUPRqZX+5wkWaVmsmCeJ2Ax+gDoE+pKyig0ksUPEAJKIwZCHEjqAKAECb6s76pPYb7q
	cXeXDVs3acgOcYPcqT27q1yrTXk=
X-Google-Smtp-Source: AGHT+IEVBxSuAiScC6ELFa/GIFX3SFjhGy+huZBX67N/T15JAg4TsKaxBPjCXZaivtdFPTOLoVZix0/s/+MrjXdztCk=
X-Received: by 2002:a05:6402:3047:20b0:63c:1514:67cd with SMTP id
 4fb4d7f45d1cf-64077012ef9mr1579609a12.17.1761894515878; Fri, 31 Oct 2025
 00:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com> <20251030191931.30837-4-siddharthasthana31@gmail.com>
In-Reply-To: <20251030191931.30837-4-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 31 Oct 2025 08:08:23 +0100
X-Gm-Features: AWmQ_bnrKLvbCj9iJ5ohDpfG4Wd2UTwMNIgK_ItUg1vG9fQsH5wvaj7xvvHcdls
Message-ID: <CAP8UFD2xJVtQMEFBQAZJP+kYq5iYCcQYn9WD_x+SO8grauPrZg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] replay: add replay.refAction config option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	newren@gmail.com, gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:20=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> +static enum ref_action_mode parse_ref_action_mode(const char *ref_action=
, const char *source)
> +{
> +       if (!ref_action || !strcmp(ref_action, "update"))
> +               return REF_ACTION_UPDATE;
> +       if (!strcmp(ref_action, "print"))
> +               return REF_ACTION_PRINT;
> +       die(_("invalid %s value: '%s'"), source, ref_action);
> +}
> +
> +static enum ref_action_mode get_ref_action_mode(struct repository *repo,=
 const char *ref_action_str)

I think it could be "ref_action" (instead of "ref_action_str" ) in
this function too.

> +{
> +       const char *config_value =3D NULL;
> +
> +       /* Command line option takes precedence */
> +       if (ref_action_str)
> +               return parse_ref_action_mode(ref_action_str, "--ref-actio=
n");
> +
> +       /* Check config value */
> +       if (!repo_config_get_string_tmp(repo, "replay.refAction", &config=
_value))
> +               return parse_ref_action_mode(config_value, "replay.refAct=
ion");
> +
> +       /* Default to update mode */
> +       return REF_ACTION_UPDATE;
> +}
> +
>  static int handle_ref_update(enum ref_action_mode mode,
>                              struct ref_transaction *transaction,
>                              const char *refname,
> @@ -367,17 +393,8 @@ int cmd_replay(int argc,
>         die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>                                   contained, "--contained");
>
> -       /* Default to update mode if not specified */
> -       if (!ref_action_str)
> -               ref_action_str =3D "update";
> -
> -       /* Parse ref action mode */
> -       if (!strcmp(ref_action_str, "update"))
> -               ref_action =3D REF_ACTION_UPDATE;
> -       else if (!strcmp(ref_action_str, "print"))
> -               ref_action =3D REF_ACTION_PRINT;
> -       else
> -               die(_("unknown --ref-action mode '%s'"), ref_action_str);

Maybe parse_ref_action_mode() could have been introduced in the
previous commit already?

> +       /* Parse ref action mode from command line or config */
> +       ref_action =3D get_ref_action_mode(repo, ref_action_str);

Here it could be:

      ref_mode =3D get_ref_action_mode(repo, ref_action);

Thanks!
