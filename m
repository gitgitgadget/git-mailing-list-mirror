Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AB21ABDD
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639451; cv=none; b=ldYt45obnZClEWJdvzPX1VPwHSvL2LQuIDJ1pZe/mCqq/7NIfW+f7KEQWN4KvblK8TNlLqQY7n8hcuX2wQaVscGWWKdggq4VnbxpP4KgDjAuTSbLlwlIvATXkGb3DuNiR7fxXXOfCKkuIzZ/KkXG0YZ8SsAoe6MdmyfiJHeIPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639451; c=relaxed/simple;
	bh=FuE1mNxeAjGJ6I4AD/OWLmjGm0XQg5ohC6fYosHRNFA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dyo+QEJ8GpRCmmEEZzjGGU3dcH19FzDkUWHJAMDLoN0qzCFc8ABwFCfwvSZ5hDgvBmhqPCaEp8BYVzW+nlNfRAcu/HFQB3uCQUGVY8vzLtj4OMpb0BdVqVcWcffbIPzG7HaNY3vZM9n5vGytRq1ZgQj/wQk6wZESD/ozwnQRbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=jFX8noEp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jFX8noEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758639440; x=1759244240;
	i=johannes.schindelin@gmx.de;
	bh=jlhJD3g4spLA4gmR909tme8xnp0wkA9pLmAkKr2NVVw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jFX8noEpCsRxl+Sa1Q9+WlqbBR0vXS/n6jbi6cJ5ECBuWvaUD4/gHpJITvqc7e8E
	 ptpC7k5bv8dZDD3q8Nlr4vU8qCPil/IUyzqvh3WFvmoRFEFRlZoUxsa8Mrbn9totY
	 sVz1FqruHeHtVrjZ10b040dFy8khO/kDqvsT63zkjFE+4y+ajdncIXO6cyCNt2i1O
	 NWLwKphHqj6ERbIYxTUmmSLT62uyQO3mB6nosk8ckF56k+/JpGhWqU/v5geBjtJEo
	 4IaEKHx4kMt95KoEaruing+2NGEuA08nZQQ1YUir2vNgDALpUxXnc/xrA22jeftxu
	 q1uqtYUYWIfdBg68tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([78.35.138.48]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1uk5XK2Lzy-00O6z6; Tue, 23
 Sep 2025 16:57:20 +0200
Date: Tue, 23 Sep 2025 16:57:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jacob Keller <jacob.e.keller@intel.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
In-Reply-To: <20250521232917.2333291-4-jacob.e.keller@intel.com>
Message-ID: <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com> <20250521232917.2333291-4-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NVGsvdDUnyEYG49oyMys1fja4noid0NzJXg1Tv4PoaMTkDOOmrd
 Ky5wHzYR7Jm6tqro1h7NsrBAwAGuvIbGvT7TmeAeM891aXMQShqt+ZZ2VKs8bVPjmx552dC
 IFQZUV+WefCNdsmd05qXO12fqpX6cP3HUre2x4TTxvRwoj7NX1zb0ZayJsRIu0hw2IycFka
 /nLsuhkov+hVkvfp1btCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NQ+TKxHWBf0=;Y3yMf2YCvjT/oKgjN38JlONSlCf
 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
 JhE2vqNVRVOpW9KXuVJSbi9RXtQG
Content-Transfer-Encoding: quoted-printable

Hi Jacob,

I know this is about a patch that you contributed four months ago, and
the usual feedback required sweeping changes, including this one that was
introduced in v4:

On Wed, 21 May 2025, Jacob Keller wrote:

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9739b2b268b9..4aeeb98cfa8f 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -15,20 +15,45 @@
>  #include "gettext.h"
>  #include "revision.h"
>  #include "parse-options.h"
> +#include "pathspec.h"
>  #include "string-list.h"
>  #include "dir.h"
> =20
> -static int read_directory_contents(const char *path, struct string_list=
 *list)
> +static int read_directory_contents(const char *path, struct string_list=
 *list,
> +				   const struct pathspec *pathspec,
> +				   int skip)
>  {
> +	struct strbuf match =3D STRBUF_INIT;
> +	int len;
>  	DIR *dir;
>  	struct dirent *e;
> =20
>  	if (!(dir =3D opendir(path)))
>  		return error("Could not open directory %s", path);
> =20
> -	while ((e =3D readdir_skip_dot_and_dotdot(dir)))
> -		string_list_insert(list, e->d_name);
> +	if (pathspec) {
> +		strbuf_addstr(&match, path);
> +		strbuf_complete(&match, '/');
> +		strbuf_remove(&match, 0, skip);

Okay, so here the `read_directory_contents()` function learns to
optionally skip `skip` bytes from the `path` variable, after potentially
appending a `/`.

>  [...]
> @@ -337,7 +369,23 @@ int diff_no_index(struct rev_info *revs, const stru=
ct git_hash_algo *algop,
>  		paths[i] =3D p;
>  	}
> =20
> -	fixup_paths(paths, &replacement);
> +	if (fixup_paths(paths, &replacement)) {
> +		parse_pathspec(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
> +			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
> +			       NULL, &argv[2]);
> +		if (pathspec.nr)
> +			ps =3D &pathspec;
> +
> +		skip1 =3D strlen(paths[0]);
> +		skip1 +=3D paths[0][skip1] =3D=3D '/' ? 0 : 1;

Since `skip1` is defined as the length of `path[0]`, I would expect
`paths[0][skip1]` to always evaluate to NUL, and therefore the `=3D=3D '/'=
`
condition to always evaluate to `false`. Did I miss anything?

> +		skip2 =3D strlen(paths[1]);
> +		skip2 +=3D paths[1][skip2] =3D=3D '/' ? 0 : 1;

Same here, `paths[1][skip2]` should always return `NUL`.

This has ramifications where `skip1` and `skip2` are each one larger than
the length of `paths[0]` and `paths[1]`, respectively, and hence the code
in `read_directory_contents()` will now try to remove one more than the
length of the path, after potentially appending a slash.

But what if there is already a slash? The answer is:

  $ git diff --no-index -- /tmp/ /tmp/ ':!'
  fatal: `pos + len' is too far after the end of the buffer

This has been reported (with Windows paths, don't let that distract) in
https://github.com/git-for-windows/git/issues/5836.

I _think_ that what the patch should have done instead was:

	if (skip1 > 0 && paths[0][skip1 - 1] =3D=3D '/')
		skip1--;

and likewise

	if (skip2 > 0 && paths[1][skip2 - 1] =3D=3D '/')
		skip2--;

Focusing on the lines' correctness (which I don't think was the primary
concern in the review of your patch), that would be what I would suggest.

However, this makes me wonder whether the logic itself is sound? It is not
immediately obvious to me why the `paths[0]` and `paths[1]` values aren't
matched against the pathspec yet their entirety is seemingly skipped in
`read_directory_contents()`?

Ciao,
Johannes
