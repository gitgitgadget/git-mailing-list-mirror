Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21902D73BC
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222572; cv=none; b=R0YAdgL3n6Li1GHnQiRt5mUAx6M6lOislnCnDREk4wT+AzoWFcCPLvubSYI3vZOXsn8JvNRGA0rMu7rGdLuvjFztHAm3K/rSHVtCxwtTgD8q7l8kWXNCS2/Y0RYRy/FGzzumjauH//ZM+nbgLER45q9AsNVZClsujYRH+N0BeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222572; c=relaxed/simple;
	bh=Pm7ZPiDpU6w6OsifB5/qxECPB7ZOdSisFRV/VY/W4YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORYbF1jh7R9pGdFIYZ7LHfUVus4X1BiKWmq/AvCr2+OBVNRzSQIHsnEug4+R+7YU58vgSPwZrqrIJ4bUm0n8BZJE0NwChKNH86nVTjD9oTOVcQbeFQLj0AelPYnZQ2dJai6mDwc4z66BXK2g+OOEMOgsgZgwBMqL+Ji40YVzpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu0AjrQA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu0AjrQA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7904a401d5cso66694117b3.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 04:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222569; x=1768827369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM1l9NLVg950SGygAZZyyOAYu+RnDqzgs7uLlyQJ4KA=;
        b=Tu0AjrQAOi9koDCTBfyH0eZAmNnUUbBvvexsmoh9UMGgmD57AN4hAsCioeDdgpT+aR
         aNcKil6v3SOfUCLNAXZAkehpeIWCnsA/Np4eqWHAJp91jFcuyNRFHLy6dQbZ8ZzXHYC1
         eUC2wN9tyKTxg5OvjC0TR8n0fpjo0IZ1PnX4Mq13iBhZKzQb0B+UxjT0xRytcU4UkPlI
         MIV71S7jiRaX7Bme3mK5e1jWO2JDyYhYhU7A3Af/C7CYS2iRKFEXFgtLCedOCqcofiTZ
         WZ8tanIpdflLtfpB8OPNM4xzO8FGU7RwxTrj4EVIeDAy4X7WwsdpjFrVs3aH3JySKrpg
         N3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222569; x=1768827369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iM1l9NLVg950SGygAZZyyOAYu+RnDqzgs7uLlyQJ4KA=;
        b=qjepAXRql7+3WAmx2BnKVnk+B+UYtcBTIfKt6HmvhVDV4nle/dSpvfCqpEbaTJ5THC
         MYMcJZUOhO0BHR1b3Q76ledoDUIDiD+7/u/fzN1GwolkUG9R1zAdbfxU1EW5iZn+jZTx
         7cE8QUi880kwLF2GVuzBUkgnYwrc5LIjUrmaeuBuNd90Gl+qnnI7/VTqcvqMM7iUQGIk
         Gu/xs2jDgVJaWYCe+u+sEkIIcuRiYORx2DmRUjAMLl9CgIHt/9hsWY2yBAnO91/99mqx
         bmdMJHbDg/Rq0kvBdSTEN9VoQZbfRRxQBLrMo3GqeWt5429hzXi8J8s69UbLwNuGkp5U
         2lnQ==
X-Gm-Message-State: AOJu0YzYnCYs28Ja2oxIDh3Gmk48RAfmcQq47J3jEi5ZD2IuAuI7g9Yn
	QjyfMf29CMG4E4j3FQJNZa/UAUwWKaEp/I/KK+zkUIDQqszdVVX4k529jpcNb8nY/0yO51rW1yN
	N/gdNUmjDM4whw79c3iciLm6tQ8opze6R2UCVTCWQZw==
X-Gm-Gg: AY/fxX62GJomdVprO1Mov6wWkTKy6hs1Qenu1OGwNfVRNJxrktz+y0cH7wr3f/URqau
	+k+yYiOfvLFqEklBYg/pTGWgUyIwb7LDvPaCSNpMvwPPVQncKn8KRZM4iZ36uua7LVt7G4Ux9HH
	BLK9pbvEopxf0//M0+CbXK9qKRdFeQ5mwfmhY69gv9gbF61ul2h8HnIIiIsA6+eRpV98BEMgMdm
	7L/R6AMB78bt1XNSKiLPFpshMs9gKlYbXk6cFBfaoDdyqIeIKZzt/dSlnIMPdb207XyTiU=
X-Google-Smtp-Source: AGHT+IEkIhy+/+6ozWhkJIgUb07TXqwulKFO+G+3L2UloC4Qy7iaKB6VHHWYPqGEVtOolBvJpoQlb33pjRcM6Vl6iNw=
X-Received: by 2002:a05:690e:1c1d:b0:646:bb17:1515 with SMTP id
 956f58d0204a3-64716abe6afmr14950464d50.19.1768222569531; Mon, 12 Jan 2026
 04:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108174651.1618874-1-shreyanshpaliwalcmsmn@gmail.com> <20260112094030.314203-1-shreyanshpaliwalcmsmn@gmail.com>
In-Reply-To: <20260112094030.314203-1-shreyanshpaliwalcmsmn@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Mon, 12 Jan 2026 18:25:58 +0530
X-Gm-Features: AZwV_Qh7jh4P5hZvcjncFWl6ZpNcs5Dz3hPEWa8SzAq9rGXdJuXaJKZTQI3P-lk
Message-ID: <CALE2CrTuZkFm1R3Bb6gFmrN1trr88vdO_7Aw6ycBYvFpWMEEtA@mail.gmail.com>
Subject: Re: [PATCH] doc: MyFirstContribution: fix missing dependencies and
 clarify build steps
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shreyansh,

Thanks for working on this. I have been going through
MyFirstContribution myself and a lot of these changes match issues I
actually hit while setting things up.

The extra includes like environment.h and strbuf.h make sense. I also
ran into build problems when those were missing in the examples.
Fixing the git psuh synopsis is a good catch too since it breaks the
manpage tests otherwise.

The note about needing docbook-xsl along with asciidoc is especially
helpful. That is something I had to figure out the hard way when
trying to build the docs.

One small thing I wondered about is the prove -j$(nproc) note. It
might be worth mentioning that using all CPUs can make failures harder
to read for beginners, so starting without it could be easier. Not a
big deal, just a thought.

Overall this looks like a nice improvement for new contributors.

Best,
Pushkar

On Mon, Jan 12, 2026 at 3:10=E2=80=AFPM Shreyansh Paliwal
<shreyanshpaliwalcmsmn@gmail.com> wrote:
>
> Fix several issues in the MyFirstContribution guide that can lead to
> confusion or test failures when following the documented steps.
>
> * Add missing header includes in code examples (environment.h and
> strbuf.h).
>
> *  correct manpage synopsis formatting to prevent failing documentation t=
ests.
>
> * clarify documentation build prerequisites, particularly specifying for =
DocBook-XSL.
>
> * specify the use of parallel test execution with -j$(nproc), noting that
> it runs tests using all available CPUs and may be adjusted.
>
> These updates improve accuracy and make the first-time contributor
> journey smoother.
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFir=
stContribution.adoc
> index f186dfbc89..38f2a23e77 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -331,7 +331,8 @@ on the command line, including the name of our comman=
d. (If `prefix` is empty
>  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's no=
t so
>  helpful. So what other context can we get?
>
> -Add a line to `#include "config.h"` and `#include "repository.h"`.
> +Add a line to `#include "config.h"`, `#include "repository.h"` and
> +`#include "environment.h"`.
>  Then, add the following bits to the function body:
>  function body:
>
> @@ -429,6 +430,7 @@ Add the following includes:
>  ----
>  #include "commit.h"
>  #include "pretty.h"
> +#include "strbuf.h"
>  ----
>
>  Then, add the following lines within your implementation of `cmd_psuh()`=
 near
> @@ -504,7 +506,7 @@ git-psuh - Delight users' typo with a shy horse
>  SYNOPSIS
>  --------
>  [verse]
> -'git-psuh [<arg>...]'
> +git psuh [<arg>...]
>
>  DESCRIPTION
>  -----------
> @@ -531,7 +533,7 @@ easier for your user, who can skip to the section the=
y know contains the
>  information they need.
>
>  NOTE: Before trying to build the docs, make sure you have the package `a=
sciidoc`
> -installed.
> +and `docbook-xsl` installed. See `INSTALL` for details.
>
>  Now that you've written your manpage, you'll need to build it explicitly=
. We
>  convert your AsciiDoc to troff which is man-readable like so:
> @@ -726,9 +728,10 @@ $ prove -j$(nproc) --shuffle t[0-9]*.sh
>  ----
>
>  NOTE: You can also do this with `make test` or use any testing harness w=
hich can
> -speak TAP. `prove` can run concurrently. `shuffle` randomizes the order =
the
> -tests are run in, which makes them resilient against unwanted inter-test
> -dependencies. `prove` also makes the output nicer.
> +speak TAP. `prove` can run concurrently. `-j$(nproc)` runs tests using a=
ll
> +available CPUs in parallel, but the job count can be adjusted as needed.
> +`shuffle` randomizes the order the tests are run in, which makes them re=
silient
> +against unwanted inter-test dependencies. `prove` also makes the output =
nicer.
>
>  Go ahead and commit this change, as well.
>
> --
> 2.43.0
>
>
