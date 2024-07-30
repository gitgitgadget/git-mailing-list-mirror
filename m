Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19013DDAE
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337250; cv=none; b=cQ/6kO05f2C33Vbu5FFLtPuSSacF7bLw2B+Cghd2/qs3EddSIAaI6qsnJG8AYnBcWylgUriNq/WoKbnOry9WVkxqKOAvrBzubD5Mwud9JMMRbP4ZuMTNooaOeQySgPW/C7c0Of9zNMIr84S4VAHE1mI2FkT4aC728xUYzdQe3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337250; c=relaxed/simple;
	bh=r9moL2/ZIs67JXSQ78XyyPJ5uqSxp+aGjC8OvBtJ7qA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=rEos0LhnBURsd1MNAMl5MF6UBHtbQokUkvy+okJ/PKm++4pmf/4XwxhZc6x5Ho7G0x1dLkC/9oBtWeAuv+zcSrQYN9dp2II/Z1abgi78ukk/3/fNYVZXvnqag5xveDwaDWKGQ3E9gtrxPvttRY83NCrDu14U9/jgIteCNn0jpak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c25s3UTM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c25s3UTM"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25dfb580d1fso1945054fac.2
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722337248; x=1722942048; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9moL2/ZIs67JXSQ78XyyPJ5uqSxp+aGjC8OvBtJ7qA=;
        b=c25s3UTMUq0QAk996E8kvD6BZFZg5vG0LQhDLG8XIz9dTn6bx+zuthWq6+RBrqApp/
         ECTyObhFoIXLHbJUv1i5wUcxYo5JKeHarg77gUfWvnChvDghbA0ShU0KEn5FOdHqTKbw
         eqP/H5x/f9bd6Az7xtXZH/EvjbmxGmskMrufs29Zd+91QQQrbQmHUnHI+CYCfFvfOcft
         dXvWwY+cDbSWbsda8YFWA273/jIw77ZPLV+Ds7o7Ueanu27Um6szAOFy7h1OE0Gj1Zvc
         WjCLBCtyP4jd4DbKPeRfFA24c4rsGUnv4QzdNjZr0c3yLCB7/i7nd2bIug5PxdoIC3aO
         Ckuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337248; x=1722942048;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9moL2/ZIs67JXSQ78XyyPJ5uqSxp+aGjC8OvBtJ7qA=;
        b=xKpvoerCfENI4y4Qguur8ZxIgxNKBZXgYWnA1d9kJ1k/NiydE7a+pk/UOxR7pKaLri
         8LBO4A3+JXt8mrP6Mk9Ed6WCh3P9V/6ga3xE072LyAZUfYBpGYPk1qDjcczUl+8oxmD3
         wdYVZSzbMyeQzEVf3ywy1KaueFhqX9F9eczuS4LPLNUvsp5UuqRF/MBDMNsIJGZv30ss
         9y355dmXZjjg47494/xR63qedvO6rHsbxXWqGlkP7qpTL9fm0vAIpbrE2tYaEvu2xhJE
         Bo6zEf1BRzdxHyXDPvRJEFhkEqWXVwrAy1tKftShr1ReQNxc3L4fHOB36equ8kOM2BfR
         wDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoQTjKqyzzmwNgzllklmJvUD4p2n3lECK4meDQvQkW35UK9n62ilHgs785XbHsT5ZaH1/vWMkT93mgNrwtXYUB5UVa
X-Gm-Message-State: AOJu0YwnOQW9gXcO5FvVm8gRg+i9UxAjkntoc4pmj4jDQs9VR5PzfiL4
	euv3Gw7jKYT6WjOibAP7XMI1jjspBxQdrBJPvMaTCLrA1EbdPQgodBZ7jWVp4EDrCB87iXnO+Ob
	n5Y2yrOewS/2fRpLdVSTRSAsejyw=
X-Google-Smtp-Source: AGHT+IHup6dRxHQG4PwGSMukkTzwH8s6tTyiZcrHb+Ef+8/Y4Muj/8xzlzRVPs13hk1V+bLxouyTVFxjuisT7VSD5Zo=
X-Received: by 2002:a05:6871:aa06:b0:267:e2b2:ec52 with SMTP id
 586e51a60fabf-267e2b304ffmr10183564fac.49.1722337248282; Tue, 30 Jul 2024
 04:00:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 07:00:46 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <e277222bd298560b0d7f10cb9b5d0eee5967ba87.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im> <e277222bd298560b0d7f10cb9b5d0eee5967ba87.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 07:00:46 -0400
Message-ID: <CAOLa=ZQ7t4eo34eQNtLzd_tjknsxkaSVGy6Z11hPUQdkGYBfow@mail.gmail.com>
Subject: Re: [PATCH 12/23] builtin/rev-parse: fix memory leak with `--parseopt`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000de2b05061e74e340"

--000000000000de2b05061e74e340
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `--parseopt` mode allows shell scripts to have the same option
> parsing mode as we have in C builtins. It soaks up a set of option
> descriptions via stdin and massages them into proper `struct option`s
> that we can then use to parse a set of arguments.
>
> We only partially free those options when done though, creating a memory
> leak. Interestingly, we only end up free'ing the first option's help,
> which is of course wrong.
>
> Fix this by freeing all option's help fields as well as their `argh`
> fielids to plug this memory leak.
>

s/fielids/fields

[snip]

--000000000000de2b05061e74e340
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 764f809733b16cef_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3g5MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlk2Qy85TWdMOFVQK2ZPY3l4SkdLUHBnQ3JPNDArWApnRmFSL2UvTmhX
VlhqMnNrQ3R5TldJZnRERk9Lb0I2QXIrR09kOFlINnFjcDA2dlJSU1NnV1oyR0NLZFZVN01HClRy
ZHNsY1laZ0k1dHlabVdPTEFNSTc0RzRHZ3cwSmJTbXMxaXluamNzdnd0aEhBQ1pJUWU3WGhKcVpD
S0pDOWsKNE9MVFkyZzk2Vjl1RnU1NlhxK09KcmthRGlpTGpwbDYvemdZUWxqaEo2ZGhNVzZRZklq
eE1RYXo3YnZXT3VOMwpUaDRaRDVmd0J2ODZROVg2d1pKSElTOG5OSllUT2oyYTRTdkFpNDAxWk52
ZHZoeThBYWhmSnNUU3dnanpwZFBOCjEwZkpBTmdwMUJLUDNaQXpuaVhrWlM0QWEzajBUck5uOFhp
L2NSeGF4Vi9xZHFPNENncnhwSmVCaTlQNElwZ2IKTmxuZ1M3dFhaOElNaWVodUdLa0xzTW1hSEcw
R2s1L3JxSnE3K2VZWVdKSEtUQUUvekVrK3JEWWNyZUxCdlQ1YQo0ZnJHK1Q4cEYyS3Uyd0thUE1j
cDdiRUNzcnpsUmRIRnpmN1pnZDZ6OHJtK0tVTnNtZXRYNDloOXBiemlFVEQ4ClVHTTcvSW04YUVl
cS9uQnZqdXNvTmJ2cm5WWm9mTE9WQUVSbllwWT0KPWxYaVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000de2b05061e74e340--
