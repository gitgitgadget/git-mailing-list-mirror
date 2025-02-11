Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B1253B61
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299636; cv=none; b=mo6BV+SrtkEFqtidSog0DyEJhVjKBxMX5E8Mwa9U36MuvqY8prNA1HiWUMX76TjkYw5DfuRRJnaF0yxuZwoDDaAxbEqY3KzS5CU6jKbK2wAvgluiLdFL5a9itiErKTZqAbcCXH6xAK2VYz1V3EbO4iQPW0H3nKUWgThIQ1aWHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299636; c=relaxed/simple;
	bh=Ax9A4gc4SQKcySNz63/sTeIx7DHbmquEFqpSXBlSHtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIk4abh1NpJoBVLh7xrcwurNKOD2r4DMhnGGGjz2KcMldrr8NXcfB7LYL61HclZ0QVdUIpom1KZVtZd/8X44wjDX+xzJgvFvmCAmYSFci/SKXbAEKuX+qj4ID5cBb5duO85BW40oUE0JNbWIHTT/QlGFbSKkSEerFiO4op08whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=hWgT6Itl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="hWgT6Itl"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so7712328a12.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739299632; x=1739904432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RwzP1TVfUFZMyLje7tgyFiaEQyV6oKYE/XorwV9PQ2M=;
        b=hWgT6ItlDaFtk3I5jBjRjPcnImh8YC7HPxuu/LZXczDnHJZ72kFEIzZgYXc8OJHn7o
         eQX/z7Kn1RaLo46N5tUIJqs2LOhXDNGEazxflOyRlHyoIc9hDITD6Ijn4HMg0jEvrfKr
         Cw1+qwltEmpoaSjptSWtNZDxQhR23X6d6DAKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739299632; x=1739904432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwzP1TVfUFZMyLje7tgyFiaEQyV6oKYE/XorwV9PQ2M=;
        b=rqVGomW1gE4AM88edEhFKM+QypoSYOPcj8GWOxAky+ghls9+0/37uAOdIuTeY+ISPI
         00udQb/ZNjbMvibgkECnIwNHHtF0dLaQUCJQHqvexYY7AKp+sxA160E3eU86VEkY7tj7
         QqOja/F6PQhvPdL7nClmmjo45rcCzGjNTvAq0zxaGteKgoz2rM9F1vuge4lJucBYJMuz
         mSYIN9KGP9N6AHqwyJpBnTsK7YwjSfik++mNK26wC13t/8y2hWDEINptsHZKDr977WFi
         kBemWepkXMYPqn+QX99vK07YSNAQxEjmx3yofIToQtvYFU+EZwaIGtWp3vPp5Q2+oqDy
         s8ZA==
X-Gm-Message-State: AOJu0Yx5qVwC2PmPZ9JLK/XC1emCsTb6ufPkuxhhKkA437MtNUjVfGTB
	6MU/UXwUBEHqTPZRHGPBx2/GHEPqkEgUdUOWd7GnnHAPlKicdvIMer9RA/KqHnACv3Prnrq1xGA
	Z43s=
X-Gm-Gg: ASbGncviDA2yYJZPV0vvRNM7nDryBUhhP3AUZIxbql638GT4tl9+1rephEhc841JMEc
	iaOXzWBve8anBKMPwlYim6baUhHZnrVi5amqhzKVMMDghEv2Hq3hEcBMpjTX6eNDRQQmwlr+auG
	Fz3ZrGN3eEG6t2OcQTURxwFV8kgTzaSYCgXcX2GYa7KRDRi7Yp1E0i4rIH3U3Ffw6gQ/7K5/xBu
	GRuliccktAHyt0h3zSQCbuTb4hCPJX+0KcdKpas6sgLl4d6VR835NBf1ggMCcOpAwxmuC0uWg/m
	/PiTP4zm4SEF2GTSUVooOMauCEhrvmIqYYAYgX6uLOmftvIf8g==
X-Google-Smtp-Source: AGHT+IEQ43KzoWOykkCU5Kygy3HP7gFnv9LyY4DatUfwK94cGXx8MISRf/alxSCjBzYqxSs/EtFAIg==
X-Received: by 2002:a05:6402:2106:b0:5d9:a85:1a59 with SMTP id 4fb4d7f45d1cf-5deade09ecemr254929a12.27.1739299631606;
        Tue, 11 Feb 2025 10:47:11 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5fb0d738sm6876671a12.59.2025.02.11.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 10:47:10 -0800 (PST)
Message-ID: <e7e0c581b4caab142989df174ee51e454e97dee1.camel@intelfx.name>
Subject: Re: [PATCH 0/3] clean: add `config.exclude` and `--remove-excluded`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason
	 <avarab@gmail.com>
Date: Tue, 11 Feb 2025 22:47:09 +0400
In-Reply-To: <xmqqcyfoxr7o.fsf@gitster.g>
References: <20250210191504.309661-1-intelfx@intelfx.name>
	 <xmqqcyfoxr7o.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2025-02-11 at 10:37 -0800, Junio C Hamano wrote:
> Ivan Shapovalov <intelfx@intelfx.name> writes:
>=20
> > This series extends the concept of "excluded files" in `git clean` to
> > make it useful to protect "precious files" that might be present in a
> > specific developer's working tree (see below).
>=20
> How does it interact with "git status"?

In the same way as `git clean -e`, i.e., there is no interaction.

>=20
> > Specifically, this series adds a `config.exclude` knob to configure
> > "always excluded" files (same as `-e` on the command line), and a
> > `--remove-excluded` flag (intentionally without a short form) to
> > "REALLY remove everything, dammit!"
>=20
> I am not sure if this uses the adjective `precious` to mean the same
> thing as we historically talked about `precious`, in the context of
> "Git does not have `precious files`.  What we call `ignored` are
> synoymous to `expendables`, and we'd eventually want to add the
> `precious` class of files that are separate from `ignored` files".

There were no implications behind my usage of the word "precious".

>=20
> If the feature is about _turning_ the existing `ignored/excluded`
> into precious and require a new option to clean those files that
> have always been treated as expendables, then that is a grave
> usability regression.  I am hoping that it is not the case.
>=20
> Let's read on.
>=20
> > This might seem like euphemism treadmill, but there is a specific
> > use-case for all of the exclusion methods and options:
> >=20
> > .gitignore:     files that _the project_ does not want to track or touc=
h
> >                 (build artifacts)
> > clean.exclude:  files that _the user_ does not want to track or touch
> >                 (IDE configuration)
>=20
> The above two share the same "does not want to track or touch"
> explanation and readers do not know if you want them to have
> distinct meaning, or just two different places the user has to store
> the same information, one project-wide, given by and shared with
> others, the other personal.
>=20
> You need to say something like "`clean.exclude` introduces a new
> `precious` class, the user does nto want to track or touch but
> unlike those that match the patterns in .gitignore, they are not
> expendables" here, if that is what you are trying to say (I am just
> guessing).

I don't think I'm trying to introduce any new fundamental concepts to
Git. This patch is merely extending an existing command line option
into a configuration knob, because I noticed myself passing the same
arguments over and over and eventually creating an alias that does
nothing but `git clean -e ...`, with the `-e` flag repeated a good 20
or so times.

>=20
> Without that ...
>=20
> > git clean -x:   remove build artifacts, but keep precious files
> >                 (when a pristine build is desired)
>=20
> ... this would merely be a wishful thinking, but once the reader
> understands that you are introducing a new class, yes, it does make
> sense.  And it is backward compatible enhancement, which is very
> good.
>=20
> > git clean -x --remove-excluded:
> >                 remove everything, including precious files
> >                 (e.g. for redistribution)
>=20
> Ditto.

The above descriptions are just that, free-form descriptions to help
understand the intended use-case. I'm not sure I understand the reasons
behind the "wishful thinking" label applied here.

>=20
> Another common theme around `precious` is not IDE configuration but
> things like config.mak file we have.  Or perhaps deploy key files?

config.mak is precisely one of such files that I now have in my own
`clean.exclude`.

>=20
> It is a clever UI hack to notice that the `precious` things are not
> something you'd share with the project, and to take advantage of the
> distinction between the project-wide vs personal preference in the
> configuration system to introduce the `precious` class.  For that,
> it might even make sense to call the variable "clean.precious", as
> its semantics is VASTLY different from what we called `exclude` or
> `ignore` (they are synonyms---and they mean expendable files that
> are not to be tracked).
>=20
> And when people want non-project-wide but personal paths that are
> excluded and expendable, they can use $GIT_DIR/info/exclude file.
> So a possible alternative is to have the dir.[ch] infrastructure to
> start paying attention to a new file $GIT_DIR/info/precious instead
> of the configuration variables.  I am not making an assessment on
> the relative merit between clean.precious vs $GIT_DIR/info/precious
> yet---just throwing an alternative for others to discuss.
>=20
> By the way, I notice =C3=86var is CC'ed, but I haven't seen him for quite
> a while around here, and am wondering how you decided to do so.  Did
> you have private conversations with and got suggestions from him or
> something?  Just being curious, but at the same time, if somebody's
> influence in the resulting design is big enough, crediting them with
> "Helped-by:" or some other trailer might be worth considering.

This email was part of the `perl contrib/contacts/git-contacts` output
for this patchset, as documented in Documentation/SubmittingPatches
and Documentation/MyFirstContribution.txt. Should I have not done that?


--=20
Ivan Shapovalov / intelfx /
