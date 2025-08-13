Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C751F3B9E
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118079; cv=none; b=U74cQOXUF4gXOfesReu0IpuIySZiRkp7fM+V9u0IWw0ndh+5af9dA4MZE3HTtUtTDcIpXmTF8LhYMiErniYlX2mZ6x3QrogGwKg4hLqmHa6tj+z2dLdkclhEEaKu3KA0cuTMhVhodU1AK5CEMxiEIDFbPRMCp27ynN91LbaKf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118079; c=relaxed/simple;
	bh=uMUnpp0ovMMP/RyuxjMKZWvANsoRCsJu2ZyPYWH+y9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjY+KSnmM9edTwplJZMik8IcjJnY8ZNwJH+wf9k1Q3rzkzCP3k4yGz6LvtXF5KyZbByLHxpNO4gAvwFXiIomp2AbeSiHBCeBD5mpWEpLRef/DR1UmWgb61Fz0900PKTVkIF4vrjGQ6N1msISVp4GvR/pqyOeO4nJlksj0y3psKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=PTdVH129; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="PTdVH129"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7E750DF830F
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 22:47:46 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:8ab3:7400:5489:5bd6])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id B7646B0055E;
	Wed, 13 Aug 2025 22:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755118058;
	bh=uMUnpp0ovMMP/RyuxjMKZWvANsoRCsJu2ZyPYWH+y9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTdVH12987TVmJkdl6zMy5XpubqP1U2TooF71VuJ3CjhLsefFUrkjvwFErCpohVZq
	 mS5F+0nSNhk4ESQ+nTDLrvyXPhjt+pU9hGKZn2NLf2cyCGCzs9yEL0NHialP1sv/EU
	 diCdnNiGytWw/WZ5kbk4DKECzE4+NEU5Z8PA7suL+l1/c3Gi92jFRAVzQS08fk03jh
	 zX8x4Hmoj5c1PBn3AZyy9G1cNiOmtxO2w03zfjUkr6cDwiUzhxCAB3iQRxSAi3fbsB
	 T4nik1WTJgjM//SAOzNkdf1cj6QWxOctlA/nWMPT6gtzqVKv0omOGPxXc+kw2iItJu
	 EfEqB21qF12ug==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/5] doc: git-add: remove options from SYNOPSIS
Date: Wed, 13 Aug 2025 22:47:36 +0200
Message-ID: <2319022.iZASKD2KPV@cayenne>
In-Reply-To:
 <3a2cc38b72fb0f6ccc0ec9cbefadb7576cd8b934.1755029249.git.gitgitgadget@gmail.com>
References:
 <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <3a2cc38b72fb0f6ccc0ec9cbefadb7576cd8b934.1755029249.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 12 August 2025 22:07:25 CEST Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>=20
> Motivations for this change:
>=20
> 1. Listing a huge number of options is visually overwhelming when
>    opening a man page for an unfamiliar command. It makes it harder
>    to understand the command's core syntax, like `git add <filename>`
> 2. For options which can be passed independently of any other options,
>    including them in the SYNOPSIS does not add any information which you
>    can't already get from reading the OPTIONS section. `git add` has
>    some mutually exclusive options, namely:
>    [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]]
>    but personally I already find that line so hard to parse that
>    removing it doesn't remove a lot of information
> 3. Some man pages already take this approach, like `git rebase` and
>    `git status`
>=20
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-add.adoc | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index b7a735824d6c..12afeead6637 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -8,11 +8,7 @@ git-add - Add file contents to the index
>  SYNOPSIS
>  --------
>  [synopsis]
> -git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive =
| -
i]
> [--patch | -p] -	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal |
> [--update | -u]] [--sparse] -	[--intent-to-add | -N] [--refresh] [--
ignore-errors]
> [--ignore-missing] [--renormalize] -	[--chmod=3D(+|-)x] [--pathspec-from-
file=3D<file>
> [--pathspec-file-nul]]
> -	[--] [<pathspec>...]
> +git add [<options>] [--] [<pathspec>...]
>=20
>  DESCRIPTION
>  -----------


Hello,

I'm not crazy about this change. In its new form, it is almost useless and=
=20
formally wrong: according to it, `git add` is a valid invocation. The quest=
ion=20
is about how this synopsis section is supposed to be used. For me, this is =
a=20
quick refresher of the available options, their exact name and how they can=
 be=20
combined, a kind of compact overview.

I'm not saying that the current form is good. For instance, I would expect =
to=20
see alternative forms such as `git add -u` appear on their own line whereas=
=20
other forms require <pathspec>. There are common options that could be hidd=
en=20
into the [<options>] stuff, even if it kills a bit the "compact summary"=20
feature of the synopsis, but as you said, these are independent and can be=
=20
found under the 'OPTIONS' section.

The design of the man pages predates some more modern approaches to organiz=
ing=20
technical documentation e.g. https://diataxis.fr/ and https://help.adobe.co=
m/
en_US/framemaker/2019/using/using-framemaker-2019/user-guide/
frm_structauthdita_sd_dita-topics.html. Thus they are mixing different aims/
approaches in a single document. Anyway, we can agree to classify some of t=
he=20
manual page sections into the more modern typing. For instance, I think=20
SYNOPSIS falls under the "reference" type, and as such should be as=20
comprehensive as possible.

Jean-No=C3=ABl



