Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62232246BC5
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414005; cv=none; b=Ggl9NAJu92AtRIif2zrOwdT7AkRVzqucSzeydSpmw9P5nNVwa15FQofQ5VYdR26F6XJOqwD0LhK9ladS7sM1xTVMG+ZOkDd3T1YYwoOz8Ejzpc0r+ZCbZtenFkZ8PIiMvIlQe5YYgBu2qsA1Ftui3EKOCwvAIj+a/YQfzLbuBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414005; c=relaxed/simple;
	bh=DwVotexqLTzT4o9nP47qaNtM7uX0hWNXAoaua+/jO+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjVESKCsR4I38LmY/8XmYNrXtPwzI+AjhBWFp/AS+Qazd/Gicc5UhhBGVUDMewYwZyMcUilxN2HPoiT/JUBdaofAyjc36YZRtNeDosFHYAtjfN/6qEpaaI5uqEQlm5ROAFfhtIrUkNxflsAXkFv4fqdSWuUNQmC9Gg5kp7dAuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ9UKwVj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ9UKwVj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so4833685a12.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 16:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751414004; x=1752018804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4+a+FNe4CkbzRB4XBGtu+qRJGLM1l2uL5Oaz0AeD5o=;
        b=NZ9UKwVj7U7UbMNol4f403+lySoQrOpMl7ZN08ZFidf1ByCO04AM8v0NGWzb3vuKFJ
         Mq6NyUuauXx8iccXIp8IhYLA6LhxXbeY/7n/bUyCTcN7u7jCG28U2fJt7j63DbUjf5Em
         HC2ePCcYdEz7CU7CG6sA2dhg3H/mE/y18fZaHwaPkESwFc9sy4VOYSsaygJW7OQE4JOH
         xaeEIds/I5OvHPi3RUevaCGweH2+4NJXlT3aH/emGy8X7h4q94SzpvHI5OtyZDjLkBqp
         9GvyWaL7y3IY8qcTNXcm0csLKEwhVqgUtBlwaKNZxfz9Ms07ivr7NgXBrTOH3AqrUx+/
         WrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751414004; x=1752018804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4+a+FNe4CkbzRB4XBGtu+qRJGLM1l2uL5Oaz0AeD5o=;
        b=nNCqrgyATYCZLRvw0vRJXR4mVX3t5GY2VFM2Kr+3U835jS7l/zoJPVoZrHe6uQ9fNz
         PyW/fT1dmre+wNOnAGaqTbB9TLQIB/HJfymh8hKspuLPiG/7dlRCPE5oayOVXM4piKP3
         eUvjRo5ZcNigZh9zD4LO6mO6ai0tA2HqjsYFA9Gg1lrLZCmugdNQgZQq4+Gh8Xrh8lqT
         NOS0FI1AOkgOSQBwG2yLuXt/nkjs7UF81e9GjofJhp0IlX04PCF3Rg7iKf26vbMOg165
         uyycQQzEV7vAhUasFdsr+bQRVWnLc5PkFY2XM2WxGOQpFPGLZH+R2JbhNl88gtgMk3hY
         qVzg==
X-Forwarded-Encrypted: i=1; AJvYcCXHztUAXB/DZIvsGcovXaBt9H7JogPz5Admb8ePlwJdmsi9TZweJADAio8Y4JDi352bM9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Y+ZioKLR8FhhWIaQhcOP9nWA7tPsoxj7agpK9J/est9GwXWk
	2+F+jDa+mstwsNacdqaOmKN/ALolJoP3lZznG9hk1QesgbjbL9bW1BRFNvoE7DU877h0Fzz4TJg
	aK3WMepp+rtILGqjPMLUhpxBgkkkUGP975SgZGTA=
X-Gm-Gg: ASbGncsDM5xni0KZItOrgtSW1bRJw/w8Gl9dvsuR3mhh/4+Z7OZM2mKaFUDWt/mAicT
	+TzLanuhbnFiD5Unr8fl1YChq56HWh19DEWnriKcKcKNReWBedbNConJpFjgJ9DU1qi5HXOWekO
	reXvBJP7+ohLgh4Uura5NP/fGhr1tFX6Ki5UXAiB4J1mTLEA==
X-Google-Smtp-Source: AGHT+IHgunwcrc3PRuagNKRVyHrvIsGBmNqbXiuuJrPWbSHGVSCRmwdi3omfxIQmIL3WTkAKapG5Ksz69O3Xt0vk3WE=
X-Received: by 2002:a17:90b:55c8:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-31a90afe5a0mr1371650a91.7.1751414003614; Tue, 01 Jul 2025
 16:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751309770.git.ayu.chandekar@gmail.com> <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
 <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
In-Reply-To: <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 2 Jul 2025 05:23:12 +0530
X-Gm-Features: Ac12FXzMFxOrM3fdkNXSW2MG3z8_9sFJsSKI3N-AmhmmgrDEgYtZ-Su5r2VhMhg
Message-ID: <CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
Subject: Re: [GSOC PATCH v5 3/3] environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	gitster@pobox.com, ps@pks.im, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:48=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ayush

Hi Phillip,

>
> On 30/06/2025 20:27, Ayush Chandekar wrote:
> >
> >   void clear_skip_worktree_from_present_files(struct index_state *istat=
e)
> >   {
> > +     int sparse_expect_files_outside_of_patterns =3D 0;
> > +     repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpa=
tterns",
> > +             &sparse_expect_files_outside_of_patterns);
>
> This changes the user facing behavior if
> sparse.expectfilesoutsideofpatterns is not a valid boolean value.
> Currently git will error out when it first starts because that config
> value is parsed by git_default_config() which is called by almost all
> git commands. This means that if someone sets an invalid value they get
> timely feedback that the value is invalid and git dies before doing
> anything. Now, if the value is invalid, git will only die if this
> function is called and it is likely to die in the middle of a command.
>
> Thanks
>
> Phillip
>

Yes, I get your point. However, if we look at settings which are
shifted to `struct repo_settings`, the behaviour is to set a
fallback/default value in case of an invalid input, instead of
throwing an error. This is done inside the `prepare_repo_settings()`
function, which is often called in the middle of a process.

Thanks

Ayush:)
