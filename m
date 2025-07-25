Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABD2E5B3E
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441832; cv=none; b=HQooY0HpwAgKBC5C2zRnPU8KUjuKhhTnVJ2A6JoQ1kssP3y57p6LlMuCv6AbNTHi28QYLRVDxnP2R0JCOsSUf7HtVzVX3e+UxGgik5qLhfRVbie/IxuJ3K2DKZcnNEL6teg6FI3oQFUYvfLa0oi5IHlZ9vj3t23328+taOstCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441832; c=relaxed/simple;
	bh=fLBpX3AvI4h3rn/voyULnnJcP76Qj518HDjbX4oldic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzAdMyI0pqkt3XwQ2uDepKc13kTfox7J9asHDPLmn1LSl2Qo3vq9HIwl68UGLz93ERncGByBap0bTNPYV81ZykVyJtDXS53n+0IOIN0QHg7xv/X1/SNnP1W/TEcOEUV4VRgHSYIJoRcZWeiSyRZHFB0mYB05hz7f5ig3xA2KwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc2MclFs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc2MclFs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313a188174fso2439989a91.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753441830; x=1754046630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi4NiQ+y9AS9SyHnKDYSKUe/m6DaVdG+ibEjKCtgiSo=;
        b=bc2MclFszg1B0qAj+Bd3c/ydc65QNUNc2eUt1wH5Wo3Xh3FgAmNv6zhG17jK2BLNjR
         Vhv9E9xFeh9rkpIrIPNnT8VmQv/43NqifQJ3W3aHf1iRrzvTCJ7kHWCiOFSdpZTYMd1j
         zvOvE7+LJZw+4G+LkE18B6rfKhkXUyHsQeljIIUICGma3IRsXnr+HfGvF42s39Dv4zzC
         /CEwIM+CnTG21+TgbA4wOiDF7yYbLdnxtIPsUYKAnGNbDvoebDej703e1xr7n0NYsQw3
         TddnCEMrAoxweQUg6X9lRPDbtq2lXCU9WN2ALYkw2jWPYM4FcCUtdb0RV7yR3lR/WRWm
         oLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441830; x=1754046630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oi4NiQ+y9AS9SyHnKDYSKUe/m6DaVdG+ibEjKCtgiSo=;
        b=Gbp7hwc+pHg/MmzjkNQiNTxOCLdIDlKuQoecTFVyDGDcM+csUC1dgw1F0Bh9JDS/0M
         XjibpQ/jFUv9vaU4c8GXyOi2ZKePy6OS1CP6P+hVSdO6oGChpB0nEvB1fboUXpnvg2LC
         C7PXWbYVZe8Dea936kPN96gCeFYxIHuR76kxiquIWVNu97oDomMBIZBwMJXoVw30s6Ai
         KYhy3OiREtftQSS4M8UrOnOVEhnCB79lWNMcT7mC0rRuXyAnRxdq1QjV1c3fDwynjG/t
         zXcGAKO4rA4zj7DdJ1FrdMZFlXBFMrduptMOK3Fu2TIgqoxqorfK5ZjnVqEmkq2ArqNQ
         9cYw==
X-Gm-Message-State: AOJu0YxBVDpj1bv2j05NiSR9XwDahoLQ/vZCdgUYq68SMPo+61J6wRN0
	L5s6q8jfdMO7H4giUa62nExMr93WBmxt+xfQMks2+iSfV9pI65xDlKo+AlWVY25zknwzVCSc9Sw
	if+o1FhRbp5F7q34hDJ72CjkUpSwVy6T5ENGf
X-Gm-Gg: ASbGncuUv0nYVYfk5dfA2I4cvMhu06utBuCpZpYMBKgEIAfEwssIVfcCt7DaHw76M4o
	qUsYG1DztqyJRmzS4gR5lBguY3uKF5i5iZEMjF2NGOtOBuoxKmqBFGOL3gyIG7kG/i4k/S5z7I/
	8bYjRjTVfTiz+k6nDscp0Et7NcYf+LkbC07JFspiPP5hGBDALcVJLcxWy+M7t4vPIhoQvKJE04T
	qAM9haY
X-Google-Smtp-Source: AGHT+IG/iZpWslK7VCDbMlf4mHOr8JdZ+vdnwUrPNg2MWB8h6ez7XywD5BhYCXsPx7bbG0C//bOyISgnwlcbLNKFp1M=
X-Received: by 2002:a17:90b:68e:b0:313:17d0:b066 with SMTP id
 98e67ed59e1d1-31e66240ea6mr6702161a91.7.1753441830406; Fri, 25 Jul 2025
 04:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717075009.26262-1-meetsoni3017@gmail.com>
 <20250723064313.29866-1-meetsoni3017@gmail.com> <20250723064313.29866-2-meetsoni3017@gmail.com>
 <aIHLdkhdVNy72Yf-@pks.im>
In-Reply-To: <aIHLdkhdVNy72Yf-@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Fri, 25 Jul 2025 16:40:18 +0530
X-Gm-Features: Ac12FXwykmDPgxZv6eHExIfrbhAoMOK0I07gEQYH_tzM1zb6qOdEgdgZRuzE0zM
Message-ID: <CAPhwyn1XK8SoW_EM+EnaaxWsQ8QTYVkMxBZqCQa0-YutvNVJZA@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH v3 1/3] builtin/refs: add list subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com, karthik.188@gmail.com, 
	gitster@pobox.com, sunshine@sunshineco.com, Taylor Blau <me@ttaylorr.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 11:28, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Jul 23, 2025 at 12:13:11PM +0530, Meet Soni wrote:
> > diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> > index 5ef89fc0fe..f7bbc1902a 100644
> > --- a/Documentation/git-for-each-ref.adoc
> > +++ b/Documentation/git-for-each-ref.adoc
>
> Tiny nit, not worth a reroll by itself: it would have been nice to move
> the extraction of the common options from our docs into a separate,
> preparatory commit.
>
I'll do it in the next version.

> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index 3d2207ec77..d7d8279049 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -16,11 +16,27 @@ static char const * const for_each_ref_usage[] = {
> >       NULL
> >  };
> >
> > +#define REFS_LIST_USAGE \
> > +     N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
> > +        "              [(--sort=<key>)...] [--format=<format>]\n" \
> > +        "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
> > +        "              [--points-at=<object>]\n" \
> > +        "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
> > +        "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
> > +        "              [--exclude=<pattern> ...]")
> > +
> > +static char const * const refs_list_usage[] = {
> > +     REFS_LIST_USAGE,
> > +     NULL
> > +};
>
> Shouldn't the usage strings for git-for-each-ref(1) and git-refs-list(1)
> be the same, except for the command name?
>
I thought so too, but the man page of git-for-each-ref(1) and the code
implementation
differ. And the test didn't capture it as it's marked as a "known breakage",
will update this in the next version.

> >  int cmd_for_each_ref(int argc,
> >                    const char **argv,
> >                    const char *prefix,
> >                    struct repository *repo)
> >  {
> > +     int cmd_is_refs_list = !strcmp(argv[0], "refs list");
> > +     const char *const *opt_usage = cmd_is_refs_list ? refs_list_usage : for_each_ref_usage;
> >       struct ref_sorting *sorting;
> >       struct string_list sorting_options = STRING_LIST_INIT_DUP;
> >       int icase = 0, include_root_refs = 0, from_stdin = 0;
>
> This follows the same pattern we have in "builtin/blame.c". It's not
> exactly pretty that git-for-each-ref(1) is aware of git-refs(1) now, but
> I think it's the pragmatic thing to do.
>
> > diff --git a/builtin/refs.c b/builtin/refs.c
> > index 998d2a2c1c..41e29d1b5f 100644
> > --- a/builtin/refs.c
> > +++ b/builtin/refs.c
> > @@ -13,6 +14,15 @@
> >  #define REFS_VERIFY_USAGE \
> >       N_("git refs verify [--strict] [--verbose]")
> >
> > +#define REFS_LIST_USAGE \
> > +     N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
> > +        "              [(--sort=<key>)...] [--format=<format>]\n" \
> > +        "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
> > +        "              [--points-at=<object>]\n" \
> > +        "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
> > +        "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
> > +        "              [--exclude=<pattern> ...]")
> > +
> >  static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
> >                           struct repository *repo UNUSED)
> >  {
>
> Hm, this one is a bit unfortunate though, as it feels like it's just a
> matter of time before the two `REFS_LIST_USAGE` defines drift apart.
> Might be worth it to move them to a shared place.
>
> Alternatively, we could pull out the logic of `cmd_for_each_ref()` into
> a separate function that also receives the usage array. Not sure whether
> that is worth the hassle though.
>
> Another alternative would be to just say `git refs list [<options>]`.
> This here

True.
The first two suggestions seem the right way forward. The third one,
just using a generic
git refs list [<options>] seems counter-productive, as a key goal here
is to improve
discoverability, and hiding the full list of options would work against that.

The solution of pulling the core logic into a helper function seems
like the most robust
approach, and since Junio's feedback also points in that direction,
I'll proceed with that
refactoring.

Thanks.
