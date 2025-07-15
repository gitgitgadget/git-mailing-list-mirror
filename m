Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268F2D63F1
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580341; cv=none; b=i+4C4nbz2th2yyLIY3ahCHYr7B9T205u/AkKFBbS6gErbAWUkJaOPyAPDnnqlPY2ITBZRLzZsNTEZY7HskYN6PYcT2PlZVVgvMR1NzkonR97kiumtIDoA3m6A84HGV/pLiKnFPIk374ZPjwFt14727gqwMNhDd99SlWOuzLRdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580341; c=relaxed/simple;
	bh=UHuRfgOSsOlTh83ygVDdcSQ9d51/TnFUVAdqQhoF+MU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIArh7mHrGa8Yn2kxVHSntdArC2c5dK2UsTEeS4zH2IBPh0lTtzgdL+OQssG6odtCka+FFTyv+3hdYnUVJd0LkxfIwcep6xFy0ca3pRr/aqRxa4iiuR/moOVQXQkoJDS5QElgrc8LEuQIp5M9aLQnBZXxXF4Y4cY559N+tUi4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPQapAPL; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPQapAPL"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87f2aed4092so2364743241.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752580338; x=1753185138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3t9h+szoPvrgP0rjBukziE5opvsMBeJsjCVc6tf3ZQY=;
        b=BPQapAPLJBK65+KBl6oa41t+RoMlPMDoeNlGtBLLo7A/Gh+/I/7SWOFQ7pXbW35+VZ
         eMvZC7jFgQ27ixrNJ+N/QRUhvw4RBbqvAjUvoMEaQxb6KO1ElDRgnz7NEyi9LQN6iJUu
         PyqTpAU4ottxgnLEaGI8tcEUogDWiatpP3QiKh6vhoo+FszudyNhRlTauNxeL0rYrDlA
         tO6omxwW1kYgh0GOg1T70yIJmVlA1ZPU6dEn35JeyRS/QTpEkg0OFo8A09CH4il6M2xD
         QCB0BZ34LVivajH/DpD4PAgQi9doZkMfeszIEEuSKmgIHSvM9f9ato9VYIetr89h+jCf
         C8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580338; x=1753185138;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t9h+szoPvrgP0rjBukziE5opvsMBeJsjCVc6tf3ZQY=;
        b=Labm17L+3RpDD9Idjtf3cxa9oYdrXqyw3aXhe3m2zPEv9uWE0DR9kAVYIdqujdfXlV
         +7W4WG+Oi4gHFkkhJ7kK23z+ka7jN3cGYiiE+VWHtddUR7cdMD3fBh4qMwWj4k/iFpzc
         MqnUwxW7SL5EjWLUecT1iBVeUQcw79QuP8PQ8ojQ8UXCxSxIxIO50ygEWlSrdTNHfwdE
         RuwdsS8lIwUXzy9t4KSdraUJyPONcHwJ08ClS2KNfJLC/sZ4twEhMe1AAEi3PPj5Sn/m
         yeMhNV29NkPZzws72e8YA7CRjPesZfcZSv32h5GHiEZiYc/y/hm6glJEqs00+c9XuuTY
         awQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg/8d7xDPDLJ4tqnTqEVK3VxLPUFVudhgIc5VOdh9emugAnC/j5A1IAttt8Bv3ev+cGgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82joayNAbiQsRerrumGk6vhf36CkXNFj4vvWwwhzKKuOIitMw
	5QKwIsE/v41xlPNQXGvtsaeSMj+hM4PHukC79gmLDwxFiOoCLWyPpqbephNiUMPv80vY4w3gAJz
	3ymCFhOoE7Wsr1ot5n1AiyPRbn7Cwm4c=
X-Gm-Gg: ASbGncsPg4+qDN1LejpL3MGv5utHywA1wqg6q4mguaDVT2VeFaFeSCP/EwMCxg/zq4C
	IBd3IAIINynnFFHzfONOb5RXMP6eazxiXRBWAqwFq4qbd/82iq7OCARKHknrgzBZtdoIBFxKTRZ
	9RQDyrceuf5aZsCFQ4tXB+fRx3gK/X8o6igTGq0Z2jq7kjkpu7SgMR1IUTszCvkplhYnYQR6Vtp
	jnW3PEihAXEnrdhYxMKfLc61UHuBwCsKOpEKbY5
X-Google-Smtp-Source: AGHT+IFMAijp6MbyAzKIM1U5ensAGH3ONgr8BxZsU5cx4UzHS8hSoGGhsX9uwFYKf0w0f7c+c5FSCW+NeH1sMkK4e40=
X-Received: by 2002:a05:6102:2910:b0:4e2:a235:2483 with SMTP id
 ada2fe7eead31-4f6e2e830cbmr8033760137.19.1752580337949; Tue, 15 Jul 2025
 04:52:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 07:52:17 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 07:52:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250714235231.10137-2-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com> <20250714235231.10137-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 07:52:17 -0400
X-Gm-Features: Ac12FXy8r6HywewK4Wu2gRHzUKfd9dLcwHCw0U7vDx8h-7qgtZbWnWwB4RWYI3s
Message-ID: <CAOLa=ZSgmRK_59BBj4UMhKmksP0WARneOzpLxfMytbeXNzoqug@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v4 1/4] repo: declare the repo command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000007bf5760639f66836"

--0000000000007bf5760639f66836
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Currently, `git rev-parse` covers a wide range of functionality not
> directly related to parsing revisions, as its name says. Over time,
> many features like parsing datestrings, options, paths, and others
> were added to it because there wasn't a more appropriated command
> to place them.
>
> Create a new Git command called `repo`. `git repo` will be the main
> command for obtaining the information about a repository (such as
> metadata and metrics), returning them in a machine readable format
> following the syntax "field<LF>value<NUL>".

I don't think we should enforce a syntax on the command level, but
rather we should enforce it on the sub-command level. This way any new
command, let's say `git repo stats` can provide a more suitable output.
Which could be a more human readable format mimicking 'git-sizer'.

By not enforcing on a command level, we leave it extendable.

>
> Also declare a subcommand for `repo` called `info`. `git repo info`
> will bring the functionality of retrieving repository-related
> information currently returned by `rev-parse`.
>
> Also add entries for this new command in:
>
> - the build files (Makefile, meson.build, Documentation/meson.build)
> - builtin.h
> - git.c
> - .gitignore
> - command-list.txt
> - Documentation
>

Nit: While it is good to state what this patch does, this list is
similar to the diffstat below. Is there additional information it is
providing?

Perhaps:

  We add the required tests, documentation and build changes to enable
  usage of this subcommand.

would suffice?

> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  .gitignore                  |  1 +
>  Documentation/git-repo.adoc | 54 +++++++++++++++++++++++++++++++++++++
>  Documentation/meson.build   |  1 +
>  Makefile                    |  1 +
>  builtin.h                   |  1 +
>  builtin/repo.c              | 38 ++++++++++++++++++++++++++
>  command-list.txt            |  1 +
>  git.c                       |  1 +
>  meson.build                 |  1 +
>  9 files changed, 99 insertions(+)
>  create mode 100644 Documentation/git-repo.adoc
>  create mode 100644 builtin/repo.c
>
> diff --git a/.gitignore b/.gitignore
> index 04c444404e..1803023427 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -139,6 +139,7 @@
>  /git-repack
>  /git-replace
>  /git-replay
> +/git-repo
>  /git-request-pull
>  /git-rerere
>  /git-reset
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> new file mode 100644
> index 0000000000..6f8fe3f6ea
> --- /dev/null
> +++ b/Documentation/git-repo.adoc
> @@ -0,0 +1,54 @@
> +git-repo(1)
> +===========
> +
> +NAME
> +----
> +git-repo - Retrieve information about a repository
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git repo info [<key>...]
> +
> +DESCRIPTION
> +-----------
> +Retrieve information about the current repository in a machine-readable format.
> +

I would keep the description of the command short, to:

  This command retrieve repository level information.

The `machine-readable` format is a implementation detail of the
'git-repo info' subcommand.

> +`git repo` will be the primary tool to query repository-specific information,
> +such as metadata that currently can also be done by calling `git rev-parse` (see
> +linkgit:git-rev-parse[1]). `git repo` doesn't query information unrelated to the
> +current repository or that is already retrieved by a specialized command, for
> +example, `git config` (see linkgit:git-config[1]) or `git var` (see
> +linkgit:git-var[1]).
> +
> +This command returns the retrieved data following a null-terminated format with
> +this syntax:
> ++
> +----------------
> +key1<LF>value1<NUL>
> +key2<LF>value2<NUL>
> +...
> +----------------
>

Shouldn't this whole section be below the 'info' subcommand?

> ++
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +COMMANDS
> +--------
> +info [<key>...]::
> +	Retrieve metadata-related information about the current repository. Only
> +	the requested data will be returned based on their keys (see "INFO KEYS"
> +	section below).
> +
> +INFO KEYS
> +---------
> +
> +The set of data that `git repo` can return is grouped into the following
> +categories:
> +
> +SEE ALSO
> +--------
> +linkgit:git-rev-parse[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
[snip]

--0000000000007bf5760639f66836
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: afb2a88177842d88_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMlFPOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMW9CQy85cmViZG5Bb0pNWTNnVHlOTUNCTFpXY1Vnagp6YTE3dEtRTm1K
MWZvR1plYnZ5U2VPRXdrd0haNlBLcFRMak82MFN3Ynl4ajlXWFZwZFRzYktEQ21VNHRpK1NMCkM4
OWNaN09sc3k3Ukt0T3lKWFZWZ1I3RTIrcGk0dFY0THc2VHdIc1F3VEZvSVhaQm5Za2NxRzBRUm5Z
NFFQR3IKbHNwN29XWWRsZmZWOUFqb2JHQzhWZ1E0RzRMVUpON3FBN3JULzN2ZzQxcjEwZXhXcUJl
bmVkeCs1QzA1VzVqRgpHZTBWS0RvUjZFdDA1Mkx0T0U2SnQ2UnRRN3BYOFFHem1YekZrU2c5VkdZ
OU94ZXNScjNlZHBxekZqaG53RmdTCnhWZXVDb0IzV0lxUVRBWExCVk50YU9OZkdFYWFKa2o3TzZK
YTA3Qko2dDVURnlPWXJsUkV3YWlHRUlnWktOZTIKdGw5TEJFbEk1WmJoQWdtK1RGUVpNQ0tCeWFI
Rzd2NTRMSjhDTTlyUW5lUlAxbXBUNllvRDV2NWlFY2pHN1BZTQpYRkdLbHdpK08vR3ZEWGFBeTQx
UjRFV2NUS1Y2WE43YnJtZ2V3YTNVeWdnc1hIZExWU3VmSXRzcnRFRkhVTnlzCndEVGZ6eVRFWVR2
dExoeWhCV3BOQnBsNmhhWXA1eXVnTjliWmdNQT0KPVJlcEEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007bf5760639f66836--
