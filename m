Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957F1CA9C
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152098; cv=none; b=RKejJHPGdbVpjC5PLYFr583Jx6uZlErAG1uei9M+WYVgxmCjLieBI16y9aPCqU9VB0uBootnPRkmgUN1SFihajJOhqZUSOTYnVyO255dpznfg1WxWX5X5wFt52Z/3XICCM2xQlOi1IBA/sIILWF+Y3lSZ+LTdjo29X0xj86tr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152098; c=relaxed/simple;
	bh=EBbZmugs48wJSYVsGhPapdZii4gw43RqF9qkp2+WDBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiZzbYa2C0fKyIm9gX1XqACKS5fQx2OrT0XQS653r+tIdMZS+ebuoJWIfJsTiJAZkZgrCfRvmutRdXaoOptLCy1My8lv6m/C9PoRB9LAZA71EsVuBYkerGmDP9fHv43/ofVWKh/Iwp29GcH4vtAnelf1IJ6iTy6/reZWgc+Bwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMJ11TQ9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMJ11TQ9"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fb7c373416so18314837b3.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740152096; x=1740756896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dN4PRFaC0L+RXUf+7MRpsDmXaLfQmbWjwuZWhIXWCM=;
        b=NMJ11TQ968nataaVyvX8KWdX+aqs79xnPuHiepbm+67zjsjLaTNItRv74ebh43XaN1
         PXSQSoq5s9pxU6WuNR0CfmmkjnDptUfyGfzSU7YFyPnPeG++Nr220olxrUpUGRfcU9Bi
         aLgRFYkD9X8KfGIOQ5MVOqkMcZWt56n8V2/9uV9KJY0VTmpHjG7TZPbS6regADlREKTW
         wG21/WsqNm4LhYdKklxkmGLu4ROQOmtk8o7jU7ml0kPIQIDqOPV4lKhFkowSatnQezrb
         0pY809DI3tc654Wn+SFv7gXpmyfMpbrvTx23JwkVTmFyYUoW3rXn6yRj5reD7eK8RGF1
         holg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152096; x=1740756896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dN4PRFaC0L+RXUf+7MRpsDmXaLfQmbWjwuZWhIXWCM=;
        b=t41Sqk43vXq4TVkfUdhZ4M701U1jVuUqViNAAc9ObbEVEaqd6ZevAl8cG/g3TBCB25
         B3TunfzOqlnF5djC720finDBbdRgemVDnF3G2hq7otlr8QlkAOaik3WJxZavqfmKHUDs
         Zn1aFV6Uw61Playt6ZNqZZB/RuJE9tM3By3SMD2nuSgA6vU3nzCjejL/EpileyKqEID8
         4hfHJuBRH83iDaELWexqMCDQmQzEzR03I9+gxBRQ9zA6p4yIXTGJa0tr6CFnr9CEBk4Y
         o6AH0bKveFg/91EdKlba4TPWKtSuVA7rtZDWHSu7n3SRB1t7gESo4UjEtfwuIoRvIzo+
         X/kQ==
X-Gm-Message-State: AOJu0YxL4v2DpNo+yOT+rDipkZLOs86dtqD6jzX6TRB1dysnPvL2ispq
	1mMVLQXepiKFjQQCY9WaAzzyAOLG8GORW1Wp6aLvf5qZ/lOlDyVszST1PtK866Yk2NGwg4KFXLk
	FmtAbUvwb5g1YQj2S5veNokU6HNw=
X-Gm-Gg: ASbGncvMCcoeS3XsbbndSPBEpMpSTY8aEnAXrKhC8KHMZARqRvZTrVH/Tll7RvwyfST
	Ci6/4nSvSsLjfLceFIHYsi0kOE2YvQq4/uQIVV0NHg8dbPRC4yGtAw6HIuFY9h4Vm31aTZpdUme
	DNKD0qMRg=
X-Google-Smtp-Source: AGHT+IGT9IoLDXXt5sezJ01MCzwZvsJaGjbKadsYlM12p3U+Kev6XDXdk+BkNLzxzsuSfVgELMOQbcHao6GgyTBJmkw=
X-Received: by 2002:a05:690c:498b:b0:6f9:753a:519a with SMTP id
 00721157ae682-6fbcc25e721mr31709767b3.17.1740152095663; Fri, 21 Feb 2025
 07:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com> <20250114021502.41499-9-eric.peijian@gmail.com>
 <20250201020321.GA4081169@coredump.intra.peff.net>
In-Reply-To: <20250201020321.GA4081169@coredump.intra.peff.net>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 21 Feb 2025 10:34:44 -0500
X-Gm-Features: AWEUYZl8gXiU8l_Ol2Slrj9S_wI2i6z_kNME2sIrWI7L-btO5mn0Yt6qXHVoU10
Message-ID: <CAN2LT1AFA8AG58NNVvW2nvWR27qisPXDzSTR-tUycWGi96kcaw@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] cat-file: add remote-object-info to batch-command
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 9:03=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 13, 2025 at 09:15:00PM -0500, Eric Ju wrote:
>
> > +static void parse_cmd_remote_object_info(struct batch_options *opt,
> > +                                      const char *line, struct strbuf =
*output,
> > +                                      struct expand_data *data)
> > +{
> > +     int count;
> > +     const char **argv;
> > +
> > +     char *line_to_split =3D xstrdup_or_null(line);
> > +     count =3D split_cmdline(line_to_split, &argv);
> > +     if (get_remote_info(opt, count, argv))
> > +             goto cleanup;
>
> Coverity complains that split_cmdline() can return a negative value when
> the input is malformed, which we then feed to get_remote_info(). If I
> understand correctly (from my very brief glance at the series), that
> string would be under the control of the untrusted client?
>
> I _think_ an attacker can't do anything too bad here, since
> get_remote_info() also takes a signed int, and so iterating from 0 will
> just find no entries. But probably we should explicitly check for error
> and bail.
>

An explicit check is added to make sure if a negative value is returned, we
will error and bail.

> While just looking at this code from a security perspective, two other
> things occur to me:
>
>   1. Calling xstrdup_or_null() implies that "line" may be NULL, which
>      would make "line_to_split" also NULL. But I think split_cmdline()
>      would segfault in that case. Should it just be xstrdup()?
>

Thank you. Revised to use xstrdup() in v11.

>   2. Are there any bounds on the size of "line"? E.g., is it coming in
>      as a single pkt, or can it be arbitrarily large if an attacker
>      wants (it looks like maybe the latter, since it comes from a strbuf
>      in batch_objects_command(), but I didn't look at how network data
>      gets passed in to that). At any rate, I think we ran into problems
>      before with split_cmdline() and integer overflow, since it returns
>      an int (CVE-2022-39260). I thought we fixed it by rejecting long
>      lines in git-shell, but it looks like we also hardened
>      split_cmdline() in 0ca6ead81e (alias.c: reject too-long cmdline
>      strings in split_cmdline(), 2022-09-28).
>
>      So we are maybe OK, but I wonder if we should punt on absurd lines.
>      Related, can an attacker just flood input into that strbuf, making
>      it grow forever and waste memory? That's just a simple resource
>      attack, but we have tried to avoid those elsewhere in upload-pack,
>      etc.
>

Thank you. Adding a check in v11 for the length of `lines`. Please let
me know if something like this makes sense:

if (strlen(line) >=3D INT_MAX) {
        die(_("remote-object-info command input overflow"));
}


> -Peff
