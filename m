Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF124B249
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736593643; cv=none; b=GpeHn/sTS64dr6THHBWnnfNJIzUSqX7nzvfQOPg8DfAiY/9Omk0TLNavpRmAW8GlucKUOl8LoBeTRzKDHGBJQYu8zCBdrIu2GvH9p0icSixF7Cn1U1bDBJOgHUUmC8mQmYIEBJVUJae0S79znoDAxeSGl0srYPHQbIhISycL2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736593643; c=relaxed/simple;
	bh=br25puV9ZDKBzjLlTC3+wB8EKzl9RSHB5BIet/uAvnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXAg0jmZG7Djk/JfLr043mgUdICfP5vhHcU4xXee977EIloKk0LEhbcYpO7DegaIOt9rlks1D7txevLXmsoUemA9bj7psY4F+nO91tJEemRUp7Rwg2ddsLHjM2uD57+Tuukb8P4SxL0TZLuq0F+7TxK39BXyGFI41N+gajJ/m0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmRRJNCq; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmRRJNCq"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso798506241.0
        for <git@vger.kernel.org>; Sat, 11 Jan 2025 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736593641; x=1737198441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Aj++sT16q/rWkBx++gaFY6mAVbZhd2TtIg1T469MTI=;
        b=KmRRJNCqJVheWKHMLNkzhb8EFM1ubNZhRRjihoIwhX/JQEqDYKKlKkd8fanBdfICuZ
         gD4DvV5fSf4wRsXDYD3TeE7/JCRwMEeUEO4f5wF8Y+Y9+8CjO7Z++YoJliaKGIUE3Eio
         dAElqxMVj5oOS95wAywkES9wgHz/DcnCQPA9qx5ystwrDYTzGAQ2s7/OufSRvJycTgPi
         6a0B93pSUfsPFfGYP/+Ubmu80v1o8i52ngTXNKO3knJPO8k30lKvr5xvHh+N1ZKwEWrD
         FdcHnV4u9KvtR4Keq4JTB4iXy6rnprOeKybdvQjuDWjhUt0DGmbIeo/gArLgZipzAhDQ
         gmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736593641; x=1737198441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Aj++sT16q/rWkBx++gaFY6mAVbZhd2TtIg1T469MTI=;
        b=DzzM2PcqKNoFy1O++QU6VlL/TKPklJsoie+XY+ezqHB520Nb/uuKqWcqaRt9uFUJ/Y
         L/xDno/tGRN3BjacYzgKsrl7LndfGwAHzVA65p7iOBWpGJ+7y7Xa4yV8gWfOY23g0vl7
         DKj3mHN0cW36VU7PNTX9mOz3woH2iVL/uzbOc53dsCL7hPkobrVOJfMbnFTzym2O2bw6
         zBiyvqURyxgvshFMfJQN+DwsiZhKJ9jL4og54MFK2uysCpE82X7DYe1K5RUIq+VDZcKY
         6lEtgk43LgdMSOVRdwObvgJrfrsavnx5+FZeI/F3ZZ7z83efRtffcN9DBSv/g6ny5nya
         rhAg==
X-Gm-Message-State: AOJu0Yy5OBpfcVKoSiZbgpKIiE8guLnSVA5dODCIgYPKOC44sHdQjkS1
	VdGVo+/1syehfhHV6EQ7mvGSuR7AKLw+4LrFZJxlTHFV5JqBbYJ2U9gjkTJ6lGiXQtLbgw9LA8V
	Uidyt9Pbq33tWV3WHn7t8gMcNymo=
X-Gm-Gg: ASbGncs+cEgL9GtjFa5YCoQNygS98krUyEZeG3xa40/2JS3vuzPGzjd2GoOX0/QQSc9
	Q/drbxJJWqKkkW0s97z3Fbi0ZPAvUkJfpSQamGQ==
X-Google-Smtp-Source: AGHT+IG3Lon+t2z59paCjLE98b5Uy78z+NueByqkBDnSiPsEcaSRW/I++K13sehl0Mrjwjb0IsbTuyYfCxHBQdOmki8=
X-Received: by 2002:a05:6102:3596:b0:4b2:48af:bc84 with SMTP id
 ada2fe7eead31-4b3d0f1613emr13561875137.7.1736593641124; Sat, 11 Jan 2025
 03:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-4-usmanakinyemi202@gmail.com> <xmqqfrlvzzcd.fsf@gitster.g>
 <CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
 <xmqq1pxdnuxo.fsf@gitster.g> <CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
 <xmqq5xmokn0z.fsf@gitster.g> <CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
 <xmqqldvi5v5v.fsf@gitster.g>
In-Reply-To: <xmqqldvi5v5v.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 11 Jan 2025 16:37:09 +0530
X-Gm-Features: AbW1kvZjlC24Ru8t8_MzY1COkaetSpYbYVsZMtKyAdv3i9Dsaa3e6hS4jc88J-E
Message-ID: <CAPSxiM8kWoAXEvAVtp0C9NUQaas3KN=TMBA-p9o6+8KDQbmBUA@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 12:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> >> First of all, I mentioned "registry of canonical os-version strings"
> >> to help the users of the "Please use this string" so their server do
> >> not have to suffer from different names and spellings to identify
> >> the same class of clients.
> >>
> >> But the server operators that *want* such tighter control *and* are
> >> capable of enforcing their choice to their users are probably $CORP
> >> in-house operators.  They can tell their employees what string to
> >> use, or they may even do that in /etc/gitconfig on the machines they
> >> give to their users.  In other words, they do not need our help at
> >> all.
> >>
> >> At least that is my thought.  Others may have different opinions.
> > Hi Junio,
> >
> > Thanks for this.
> >
> > So instead of having a .format config, we should have a .string config
> > which just
> > takes a string and uses it as the value for the `os-version` capability=
 ?
>
> Ah, sorry, I totally misread your patch.  I somehow thought you _already_
> have the "any string goes" variant implemented in the patch being reviewe=
d.
>
> If there isn't any such thing, then my preference is add neither of
> the configuration knobs and let the system provided function give a
> not-too-specific os-version string (like "Linux").  Once people gain
> experiences with that feature, then we will learn more about what
> degree of customizability is required.
>
> Sorry for the confusion.
Hi Junio,

Thanks for this.

Actually, in this patch series, there is a config option called
`osVersion.command`
The specified command will be run and the output will be used as the
value for `os-version`
capability. This option was particularly asked by Randall S. Becker in
a previous
conversation https://lore.kernel.org/git/000a01dac25c$df7b23e0$9e716ba0$@ne=
xbridge.com/

Thank you.
Usman
