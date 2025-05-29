Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F511DA5F
	for <git@vger.kernel.org>; Thu, 29 May 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548650; cv=none; b=SAL/5hY122DylFv4/dhlW8tAZeKAhi4gev2murT4hscXWQ/0bLXjMMm24vu6hsE79LlEVnD6aN8HHW+Ucg/0XdfCJXReZDVlrTxG1yVm3guM+Mc+PLYFCaptLqtNOsKMFYuxNDc7JAco5Q69X6BLpzJBSAvxRi99TcYhCO5q2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548650; c=relaxed/simple;
	bh=2Wen2YP6ZFfHY9U3aoU7jtm1V4Itm4eEpNKmIll5we4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gR3gTAHJa24WkWsxY1E+8qF99JiitmPsb0gl+CEFhsO29RehvMSBNXRjKk2EX/+hfgHv60NAlFAU1Z2TEjS0Ke4wZXZoyp535r51hK7QZ2W9wwSxi5InNLw9NmlwGUFweYvTkXMqZK7kATO0CEaJyOwSZHpKeg1t39ViDeT7MSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQZzr5h2; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQZzr5h2"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e591544d42so426008137.3
        for <git@vger.kernel.org>; Thu, 29 May 2025 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748548647; x=1749153447; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyUyAfqiZV69z9J9w7UhVvig0uXK/VB4Eya/OPkN4es=;
        b=lQZzr5h2AEY/B4eYP3M28EirZfuN6yXlhYx/wMDjSj1AwaJz3Ylp9tsnXwa3etqNNW
         1uEZ/Tpkk79T9l9d5MJJepemh7H1lqCC77suDizhBVWr9a8m1/ku3yykt2hmUPvsKELC
         Xl63Qy5QZ2tpR7fuWGE1lo04wDVcodE4XXdkHc4W36sUb2EFd+PGSgSgRnaoz74SfWIU
         NfjXLiy7zLKqG8x0oREWoN50zZiirHGtxY7mXvGhAFk5T2ysu9KWI9/VENfKfvXZTdNQ
         H2eIXUukLviQhdraZO4N1x0WuN2nkxX4KRCKpvTgs8oaBBWjxaSdhz3TuzonNClJdNUB
         PbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748548647; x=1749153447;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyUyAfqiZV69z9J9w7UhVvig0uXK/VB4Eya/OPkN4es=;
        b=oHu/9DgonBZZVou4sYOiqlG8HB9+PCFczfp6+MdReYTaTkpgeOSdIoqZLkrx43vTc4
         VS8Lhrs7gXDeYY+y8VJYCTkplU4eSlg6objz3JFD3WcvEIUtd4W8BDAcOjgk7xc04BQQ
         8vzefNgdf5QpvDt7a6ciPHzE+987W2a6EB3oFhg1iHfz/R1UO9tUTOuHT0D+4f06XYqm
         S5i8BctsuGIMEcmfto50PzZ8st+jI/mRRARZidyVXS0zOrk7DHWzMSwBxqehKI2IPZCe
         zwsWJUTeq/O/7KyQNwnxf33MPRR62pCjNRnGGhiGDnEcAX6ZJMMblVdAhnw2YHB3tHea
         emsw==
X-Forwarded-Encrypted: i=1; AJvYcCUwfFyk0Iii4LF8CEyxBPuG1++LD+uGPcyhn4MTEz433GE++XWdXpPwICQGYiHha2FBnKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCznsw8/8avsXYPmRbNCSCuVOzqdwnbYM7SunIgbi+JPSLKBVw
	wWzrTznAUTbldlqhaTEKkEV2qmOZB95LS1sMyZFspEMgP7aO68xa3HEHCFtp+8L+tPvrpTE7Poa
	buHhcHeC+VaZnrzQ8/xRLxoEejoDCUVU=
X-Gm-Gg: ASbGncv216plbw4zJrUL75z7gFbOP8EVIENc5C+uxtaivR71yIhCKfZVw2VlVh8nM12
	PxPGxWK1y0mixfv3am+5hlUZyLsg0PAmBjuGsUDO/4uW3iZKeFRXCpzWODwu98N0ZdELIQZE2vh
	IecVEqg2MrW2pu/hRKZP9UNRpP2gX88opHcUIkXvuqtPufP6qWlWC6QujMvf4eNd9Lp60=
X-Google-Smtp-Source: AGHT+IEzGodsEzwNPzvhrNXhEZQdbKYIdjgeM0EMxVmYoxrzXj0OjL2ix0FCtmSoov+8RfJPbAL2gQoqtEa4vagDMMY=
X-Received: by 2002:a05:6102:2913:b0:4bb:d45c:7f4b with SMTP id
 ada2fe7eead31-4e6e410d419mr1287867137.11.1748548647191; Thu, 29 May 2025
 12:57:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 May 2025 12:57:26 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 May 2025 12:57:26 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250529192036.75408-2-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com> <20250529192036.75408-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 29 May 2025 12:57:26 -0700
X-Gm-Features: AX0GCFsIomwtxZ9k9z6HTwCX4Qx__yGOzhesZVB-AyG_SZ2yAcq5eY3kRV6u06k
Message-ID: <CAOLa=ZThmqVf5u4QOZuQa-cFVtke6H01iw8bbPx_0eTxVdFZRA@mail.gmail.com>
Subject: Re: [GSoC PATCH 1/2] MyFirstContribution: use struct repository in examples
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fd232f06364bb473"

--000000000000fd232f06364bb473
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the parameter `struct repository *repo` to the cmd_walken function.
>
> Since commit 9b1cb50, all the cmd_* have the `repo` parameter and new

When referencing commits, we stick to a particular format. From
'Documentation/SubmittingPatches', we have:

  When you reference a commit on a more stable branch (like `master`,
  `maint` and `next`), use the format "abbreviated hash (subject,
  date)", like this:

  ....
  	Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
  	noticed that ...
  ....

The document also states that `git show -s --pretty=reference <commit>`
can be used to obtain this format.

> commands must follow this convention, so the documentation should also
> be changed.
>
> Also change the `git_config` calls to `repo_config`, also passing the
> `repo` parameter.

Nit: Okay this makes sense, but It would be nice, if you also elaborate
a bit here, about why you want to make that change. The context being
that since 036876a106 (config: hide functions using `the_repository` by
default, 2024-08-13) the non-repo config functions are no longer
recommended as they use the global 'repository' variable.

>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/MyFirstObjectWalk.adoc | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
> index f03753dfc0..29d26abb47 100644
> --- a/Documentation/MyFirstObjectWalk.adoc
> +++ b/Documentation/MyFirstObjectWalk.adoc
> @@ -43,7 +43,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
>  #include "builtin.h"
>  #include "trace.h"
>
> -int cmd_walken(int argc, const char **argv, const char *prefix)
> +int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
>  {
>  	trace_printf(_("cmd_walken incoming...\n"));
>  	return 0;
> @@ -86,7 +86,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
>  Also add the relevant line in `builtin.h` near `cmd_version()`:
>
>  ----
> -int cmd_walken(int argc, const char **argv, const char *prefix);
> +int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo);
>  ----
>
>  Include the command in `git.c` in `commands[]` near the entry for `version`,
> @@ -193,7 +193,7 @@ initialization functions.
>
>  Next, we should have a look at any relevant configuration settings (i.e.,
>  settings readable and settable from `git config`). This is done by providing a
> -callback to `git_config()`; within that callback, you can also invoke methods
> +callback to `repo_config()`; within that callback, you can also invoke methods
>  from other components you may need that need to intercept these options. Your
>  callback will be invoked once per each configuration value which Git knows about
>  (global, local, worktree, etc.).
> @@ -221,14 +221,14 @@ static int git_walken_config(const char *var, const char *value,
>  }
>  ----
>
> -Make sure to invoke `git_config()` with it in your `cmd_walken()`:
> +Make sure to invoke `repo_config()` with it in your `cmd_walken()`:
>
>  ----
> -int cmd_walken(int argc, const char **argv, const char *prefix)
> +int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
>  {
>  	...
>
> -	git_config(git_walken_config, NULL);
> +	repo_config(repo, git_walken_config, NULL);
>
>  	...
>  }
> @@ -250,14 +250,14 @@ We'll also need to include the `revision.h` header:
>
>  ...
>
> -int cmd_walken(int argc, const char **argv, const char *prefix)
> +int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
>  {
>  	/* This can go wherever you like in your declarations.*/
>  	struct rev_info rev;
>  	...
>
>  	/* This should go after the git_config() call. */

Shouldn't this be s/git_config/repo_config ?

> -	repo_init_revisions(the_repository, &rev, prefix);
> +	repo_init_revisions(repo, the_repository, &rev, prefix);
>
>  	...
>  }
> @@ -305,7 +305,7 @@ Then let's invoke `final_rev_info_setup()` after the call to
>  `repo_init_revisions()`:
>
>  ----
> -int cmd_walken(int argc, const char **argv, const char *prefix)
> +int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
>  {
>  	...
>
> --
> 2.39.5 (Apple Git-154)

--000000000000fd232f06364bb473
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6ce29a44b1705c9b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nNHZDUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzRSQy80MVB3VUY5VmRoQTZFYy9iUUpqenFWN0UxQQptRVZzd0cxdUdl
SnhiMUQ3VjIvQ1NwM1p4OWhRY2k3bkRmcWVMNHFGTjEzYkJpUVFtbTFlTTA2WlVVQXViZW1FCnpL
S0Z6R25tRFljWlZDa0cxbjJsTi91NVFNSWZqYmxTNGN6UWZqaFFMNGlUV1ZHVnlPQmxDenBRbWVp
bFJwcmwKaktDM2FXWFBnaG1mMFRBQnBkRDRaWGZpMlNEZy9JMVRVNDVGQTJLN0Jua0VFdDBwU2ZG
WjBoai9qR3ZXejRlQgppWjNyeDJ3a0NqOWlkZWFOUkV2cklMa1NvK0hRd0xKeS9tZldlWkRMZ004
RlBXT1d2Y3N2R1grYklBTE4yN25OCnRxOEpBM2wyMnpZNlAwU3dmNU5BTVl3ZDRLYjRMbGZDeG8x
RkhFZ29GNGNsN1BVd0QzTSs3Ykp4UnZ6Y2FodW4KRStvdkQ0QmlTbi9VY24ydFZVdUdQaTlSd2JD
UUhmcWIyYm5MZzdEeFhwOHR2ZjFKbWp6Z1ZlWGVkZEtLby9LdQp5dW44MG5Mc1lxZUdnL0x6cVc4
Z01wbERVQmY2WWlidjZKR1lhejU5bkZtbFVyNllmSU9JK1I4SHZiUGQzTk5kCmZIckJaUGp1ZzE1
ZlIwZjJJbGZWMG9vd1cybzRnZ3VNTjQwQi9FWT0KPVBVb3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fd232f06364bb473--
