Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF156443
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185010; cv=none; b=knFLePy13Vlr2Gx7sKIteolw30kKeGYTalpHdWIJ9lZQSlERWY4X+ec7W1PAbqJfPWk3NcQ1UECjLUrMoxJwT3kEONT7Eqtm0sEmjlCYkulmC/XPkEpRHGAcbpCSxgwSaTZEV24gpXKK9SqKCfRZs0wcgmPpqEOI8pTtG6I3KrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185010; c=relaxed/simple;
	bh=DFZNV16nbdoSAKvGip8PAY++LsiyI3Hh8pPa9zVuFf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTeGLHC5TwpbS+XM4tKmSphlTLZufcp8q8BO9Vrz6Ym36MeA6UODHnc1aWSmYlveqMWo0qEJSPc+MLaecIMRbHH6x2fJhSt4zqo8Ca8va6OQiovImadPbLSBAxLC581d5wRIhS7ZpIgEjxJ9L4/mpETsh7bnnYeACXsbYqIQCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJCOdhRs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJCOdhRs"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44d084bfe1so415269366b.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710185007; x=1710789807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVuTz4yUX652cJgnJflMuGTjOcfYhApZhRSIzslUc8k=;
        b=iJCOdhRsby+CnCs1Q4TJVxDskDmQ7GJbfr1DRhTIrQyx4/W4E/ol/9MVf+E/DR5Auj
         4s5qYuIxqlYOjpjyTV6rB9ifa6J979IUVGELjRIvQL/BunMM44WHPDBngXnOt+6Nl6iF
         TqTon6RgiU3d7+9NaABUp/oqdlda+c/4COF+psNe7jmfozAlT0jqIGgedekcDzP9mfcI
         CkjeemSS9xzlGuTooU6so06KVpog8i5yoU17VKR7xxt42TAFghEwOb8dlH/Dtxp/3zfb
         92q4YOO2ySXk/KAm3N1nXP2F4AHG7DA7o+zGn7DdvuhVt5dhoOoYizuNAj6z+qreORu0
         8rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710185007; x=1710789807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVuTz4yUX652cJgnJflMuGTjOcfYhApZhRSIzslUc8k=;
        b=cO7LXEowfF4x6OliI2oEQvFyBifLgtdFGjltBNVItrRSPzCMlqbi8PUu61FwFCO/RE
         6ExWuiA8t0OAHRLbkXnVn3+G/Wuj1/4wBz7How2GiXMdAZgF5/wivYjEuqqyeRXBAp/W
         DnT7enHyMhQ9C3QnFMM5zk1E4Nkb5rBuW0OyLbfPGX2TwZFa8NaP7XHOmS1eqqJXm6Ew
         AJ768xGXOJcjxToemryDpRfIJ2ZCPYUBJ7sOt5sVWRN+HMz7QyKBfd4UxHWtUUQ+GviF
         Xl/KzaCc2pb9beyltyQhA5w7MKjCEAmBpCwhymYoaD5panofrWHMojOsEqIfr/IPdOGd
         3YGA==
X-Gm-Message-State: AOJu0YzaB1UW4DE9aoqB1xDnsThJSRWtdCJFuv21VGne+v5SmxKj4aip
	ab1LQqvBMTogaHeiM9AQpqhw2agkHUapUiHTvxTILJzugIMiVNiOszAJfyBu1LFG0Nu2tOdFF1W
	/daUmTA6HL4Ek4KjIJMLA2klmbnVDS9aZevL9PCIaRvyOzpuQYw==
X-Google-Smtp-Source: AGHT+IGMaqC4OuIO7AjBkQ64aHr+bA929otav1COL8egWoCwBANtNzA2gmqYVCjvZX05k2JMrt652Vy5TDb2ukAWkLM=
X-Received: by 2002:a17:907:7714:b0:a45:a98f:2cf7 with SMTP id
 kw20-20020a170907771400b00a45a98f2cf7mr4699983ejc.57.1710185006887; Mon, 11
 Mar 2024 12:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv85zqniu.fsf@gitster.g> <20240308211957.3758770-1-gitster@pobox.com>
 <xmqq5xxv0ywi.fsf_-_@gitster.g>
In-Reply-To: <xmqq5xxv0ywi.fsf_-_@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 11 Mar 2024 12:23:08 -0700
Message-ID: <CAO_smVhAp4V1pb7LQV7yvhs98JVrtDgW5LzjzyJHupGuGSA+sg@mail.gmail.com>
Subject: Re: [PATCH v2] setup: notice more types of implicit bare repositories
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 3:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Builds directly on top of 45bb9162 (setup: allow cwd=3D.git w/
> bareRepository=3Dexplicit, 2024-01-20).
>
> Instead of saying "primary worktree's $GIT_DIR is OK", "secondary
> worktree's $GIT_DIR is OK", and "submodule's $GIT_DIR is OK"
> separately, let's give them a name to call them collectively,
> "implicit bare repository" (for now, to reuse what an earlier commit
> used, which may not be an optimum name), as these share the same
> security guarantee and convenience benefit.
>
> The code got significantly simpler, and test moderately more
> complex, having to set up submodule tests.
>
> ------- >8 ------------- >8 ------------- >8 -------
> Setting the safe.bareRepository configuration variable to explicit
> stops git from using a bare repository, unless the repository is
> explicitly specified, either by the "--git-dir=3D<path>" command line
> option, or by exporting $GIT_DIR environment variable.  This may be
> a reasonable measure to safeguard users from accidentally straying
> into a bare repository in unexpected places, but often gets in the
> way of users who need valid accesses too the repository.

nit: 'to', not 'too'

>
> Earlier, 45bb9162 (setup: allow cwd=3D.git w/ bareRepository=3Dexplicit,
> 2024-01-20) loosened the rule such that being inside the ".git"
> directory of a non-bare repository does not really count as
> accessing a "bare" repository.  The reason why such a loosening is
> needed is because often hooks and third-party tools run from within
> $GIT_DIR while working with a non-bare repository.
>
> More importantly, the reason why this is safe is because a directory
> whose contents look like that of a "bare" repository cannot be a
> bare repository that came embedded within a checkout of a malicious
> project, as long as its directory name is ".git", because ".git" is
> not a name allowed for a directory in payload.
>
> There are at least two other cases where tools have to work in a
> bare-repository looking directory that is not an embedded bare
> repository, and accesses to them are still not allowed by the recent
> change.
>
>  - A secondary worktree (whose name is $name) has its $GIT_DIR
>    inside "worktrees/$name/" subdirectory of the $GIT_DIR of the
>    primary worktree of the same repository.
>
>  - A submodule worktree (whose name is $hame) has its $GIT_DIR

nit: '$name', not '$hame'


>    inside "modules/$name/" subdirectory of the $GIT_DIR of its
>    superproject.
>
> As long as the primary worktree or the superproject in these cases
> are not bare, the pathname of these "looks like bare but not really"
> directories will have "/.git/worktrees/" and "/.git/modules/" as a
> substring in its leading part, and we can take advantage of the same
> security guarantee allow git to work from these places.
>
> Extend the earlier "in a directory called '.git' we are OK" logic
> used for the primary worktree to also cover the secondary worktree's
> and non-embedded submodule's $GIT_DIR, by moving the logic to a
> helper function "is_implicit_bare_repo()".  We deliberately exclude
> secondary worktrees and submodules of a bare repository, as these
> are exactly what safe.bareRepository=3Dexplicit setting is designed to
> forbid accesses to without an explicit GIT_DIR/--git-dir=3D<path>
>
> Helped-by: Kyle Lippincott <spectral@google.com>
> Helped-by: Kyle Meyer <kyle@kyleam.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  setup.c                         | 28 +++++++++++++++++++++++++++-
>  t/t0035-safe-bare-repository.sh | 26 ++++++++++++++++++++++----
>  2 files changed, 49 insertions(+), 5 deletions(-)

Looks good, thanks!
