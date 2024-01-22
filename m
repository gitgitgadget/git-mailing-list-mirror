Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37E4C3CC
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965490; cv=none; b=rcCjHZFieB1D1+44qVTKhH7hPjJ172AJ3ZtFNoqCbYtNQ912OTKIJlVAScrU/NGYaqOQ4nSIz41O1XZaZRgRI/qQ0U5yTHtK/ofQ7NbmZ4jwtsWZkjbOtIfYB4ofjhFXVWefEOsxcQwEJ44ErjnocGqbTioyWjqeqqoflZKu0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965490; c=relaxed/simple;
	bh=JVSfBcSechvALXZjJb+rFQD/nzaaKQost3Lcpx/eB4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCkab4bv5VcWxJugQPEuEH7t2pc9MmdUpNz4mc2e9Erf8qcQF7bjmZQ696cmC/UztpTmn9SmG9XqmDU74fcw+YOF89ZaogIjx2mG7MlrnpzZRFWJt3fYEAsVh1DKREJ6/5YAhbBbBLQeYKM+xvb/spBkMnZXtNDh1PvWme6D/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uc3eh0ZW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uc3eh0ZW"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso3610a12.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 15:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705965486; x=1706570286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVSfBcSechvALXZjJb+rFQD/nzaaKQost3Lcpx/eB4E=;
        b=Uc3eh0ZWzEA8DGZbg1/3C/iFjERgkF7KqwdUsiP7EyoF+qHRhXThde5iaaj9Tpkz82
         L+MIMcvnoOcza4W92jkYg6phc5g6h+ii2w2PcJegkwaffbl2Dw+zQfSM5z7lFD3fqQ8k
         cJgq/KuNZ9giBoxWRqcyCvwdHuuN8HkUl1yHN33Sb5HmFWcT3lH3ZwXnTY+8SqXi/tiD
         ZigWoNvT69MwHcCVsEfysISwKhod1BY6PTl9ukqeBa4QDNLAMt3qJS5QDghcb1BDYiiH
         C2rXDNA+BF+mptqYUiZFSkZUrpakQt0eKSqTRagvbpe6cXhfCRfQwvrPO7MmIeJdGOz2
         T6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705965486; x=1706570286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVSfBcSechvALXZjJb+rFQD/nzaaKQost3Lcpx/eB4E=;
        b=dt5YDFQcI5UBQ5lkYBLP+OUJ3O7SDjZtAleSGXTEFjYZ/qZqxZv/lY2ievH/yJRIMU
         FUqFyZqVxmGdlhATXZs0wUS5K8/jbtR2qqK93M9MUg1JCIv/QU2wLqWNnuxn8T4ZbIxY
         WIuKZINK/98E8nRlwcClqdURhSvvB515XgrrIcLGV+0LY/BZP1tey8tju5lZnFxfRXnH
         QK1KWzpyd8NB3sU6XgOTqEtrJgPBGo/foKq5UIcTZNB9jwIbAxd2wALHrha+qcb2Wu6F
         sCTkCX0oYb0ZEAxBXZWHs9RN7niBVIm0Pwdq+iH6PZ2CvThrTd78BbP+g63pEZqYAq8Y
         VE0Q==
X-Gm-Message-State: AOJu0Yx3nDGMPl4Gl85HFAkrk7DuBYy3ee0K/LOe19+085Tt1B+lYtEm
	krFXaKUgUhwb+KYMJ0sZRTAXdMBC+DrWRbFPT1ZMaWT2vXfGzzJIE5n1aVhUoDqA3sWE/c2NWGN
	P5ewn9gfYhI/2sGXdK/BX23LEB3JnZ66qTcoYxrBZVEX2akK3GQ==
X-Google-Smtp-Source: AGHT+IHbHbQ028ZWBVfQLDSxkiXmqGYt1SjehbLg3jz+jTW6GzzWs++hIG3EK8a5JFZ8Fz+Z3KPf7ydyHainZE5J6Y0=
X-Received: by 2002:a05:6402:2285:b0:55a:58b6:4175 with SMTP id
 cw5-20020a056402228500b0055a58b64175mr59434edb.2.1705965485423; Mon, 22 Jan
 2024 15:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com>
In-Reply-To: <007c01da4420$10a7b700$31f72500$@nexbridge.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 22 Jan 2024 15:17:50 -0800
Message-ID: <CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
Subject: Defining a platform support policy (Was: [DISCUSS] Introducing Rust
 into the Git project)
To: "Randall S. Becker" <rsbecker@nexbridge.com>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>, Git List <git@vger.kernel.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Wednesday, January 10, 2024 5:26 PM, Taylor Blau wrote:
> >On Wed, Jan 10, 2024 at 05:15:53PM -0500, rsbecker@nexbridge.com wrote:
> >> Just a brief concern: Rust is not broadly portable. Adding another
> >> dependency to git will remove many existing platforms from future rele=
ases.
> >> Please consider this carefully before going down this path.
> >
> >I was hoping to hear from you as one of the few (only?) folks who partic=
ipate on
> >the list and represent HPE NonStop users.
> >
> >I'm curious which if any of the compiler frontends that I listed in my e=
arlier email
> >would work for you.
>
> Unfortunately, none of the compiler frontends listed previously can be bu=
ilt for NonStop. These appear to all require gcc either directly or transit=
ively, which cannot be ported to NonStop. I do not expect this to change an=
y time soon - and is outside of my control anyway. An attempt was made to p=
ort Rust but it did not succeed primarily because of that dependency. Simil=
arly, Golang is also not portable to NonStop because of architecture assump=
tions made by the Go team that cannot be satisfied on NonStop at this time.=
 If some of the memory/pointer issues are the primary concern, c11 might be=
 something acceptable with smart pointers. C17 will eventually be deployabl=
e, but is not available on most currently supported OS versions on the plat=
form.

I hope y'all don't mind me hijacking this part of the thread ;)

But, Randall's remarks bring up something pretty compelling: I don't
think Git has a clearly defined platform support policy. As far as I
can tell, the support policy now is "if you run `make test` on it and
breaks, and you let us know, we'll try to fix it" - without much in
the way of additional caveats. If I look in CodingGuidelines I see a
few "this doesn't work on platform X so don't do it" (like around %z
in printf), but nowhere do I see "how to know if your platform is
supported" or even "here are platforms we have heard Git works OK on".

That causes a lot of confusion for the project - threads like this one
(and presumably a similar one about C99 adoption) become a blend of
"is this change good for the project or not?" and "will this change
leave behind platform X?" that is difficult to pick apart.

Does it make sense for us to formalize a support policy? For example,
if we wanted to formalize the status quo, I could envision:

"""
Platform support: We make a best-effort attempt to solve any bugs
reported to the list, regardless of platform. To prevent breakages in
the first place, consider running Git's `make test` regularly on your
platform and reporting the results to git@vger.kernel.org; or, better
yet, consider adding your platform to the GitHub Actions CI
(configured in `.github/`).
"""

Or, if we wanted to be able to move very nimbly, we could imagine
something much more restrictive (note that I'm not endorsing it, just
illustrating):

"""
Platform support: Git is guaranteed to work well on Linux platforms
using a kernel version that is less than 1 year old. Support for all
other platforms is best-effort; when reporting a bug on another
platform, you may need to patch the issue and verify your fix
yourself.
"""

I suspect there's a happy medium in here somewhere - trying to fix (or
avoid) an issue on a platform which the average developer cannot run
tests on is not a recipe for a happy developer, and a general policy
of "patches welcome" for anything but latest Linux is not a recipe for
happy users.

I see a few axes we can play with:
 * which architectures/kernels/OS (do we care about more than the
usual suspects of Linux/Mac/Windows // x86/amd/arm //
POSIX-compliant?)
 * age of architectures/kernels (do we care to offer full support for
a 10 or 15 year old OS?)
 * new feature compatibility guarantees vs. core
functionality/security fix guarantees (which do we really define
"support" as?)
 * test provisioning (do we require a VM we can run CI on, or is a
report generated from a nightly build and mailed to the list OK?)
 * test/breakage timing (should the above tests run on every commit to
'next'? every merge to 'master'? every RC?)
 * who provides the support (is it the patch author's responsibility
to fix late-breaking platform support bugs? is it the reporter's
responsibility? and especially, how does this interplay with test
provisioning and frequency above?)

If we had clearer answers to these questions, it'd be much simpler to
determine whether experimentation with Rust is possible or useful.
Plus it would make developer lives easier, in general, to understand
how much compatibility support work they're potentially signing up for
when sending a change of any size.

 - Emily
