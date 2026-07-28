Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFE3191D3
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281366; cv=none; b=a97PAJXBwPb0YbiWwy4Qx5FmjGXX8ImDJoldfhwXnDJXncUWDKVdhSt7i42LbDtdQwvNyqVmp/dNxLAKGKxLQ061e8iDZw14QPiajr+TUQUcOmmSLITNaoSg5fwlEWJFMnEtiYpj/d18xhPenSwp8MHy0qfRPuaTVmVwwm95qvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281366; c=relaxed/simple;
	bh=2mi+Opj9w9FvFj3SinNt/f1zhoXj4XlRy2qnf+9eTtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEnIvhTBbfye+JG3A9/IRiuZKJ2sP16Syi35khoezXGAw6F/QFXRMprUWTEKPH0pfMeM4yqtDOqOaKxyXrZqo3/rGE1o1GQqYPJUg2/a1kP6HZXlRH9E8vFUlwAtyrEOaxoKP1pzK7O9ZIQaau5YJIn9E76wH1Bcly39aKY4jL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SKrI97zO; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SKrI97zO"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6682259cb3dso711303d50.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785281363; x=1785886163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SCMiJaXvOIS3+01VguKIVvGmMeFcX4LsjM64wZqgLa0=;
        b=SKrI97zO7Q13sR6NlxsT+1SmN6S3MJw/cAHyEtOrGaz5Zkw/mElapoEMlo8nFtM0ga
         Pzs2c1uZGseCIlhSgm0B7j8UxBrk9Fh8xqcviimKYnw1aNwNiJfRKJh/41W7xdTGmJbD
         XK7jb3mbhcxyCO1wXRyNeY+JoqXF6mLC4cqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281363; x=1785886163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCMiJaXvOIS3+01VguKIVvGmMeFcX4LsjM64wZqgLa0=;
        b=ib7dLAEbv+cKMsLHhIC61ZsUhKm946J5HhbL0UJCkJqJPy/IdrikKf3jgCXQPWto7b
         FvEOhvQyeRogZj7jJly8fef6zMSyFnpMoXzdHhWAenDYxpuElWAU/va4fOXQomH7Yzj/
         N4zwr5CqqYlGOmsGmMVhtujm+mUHsqs55HMgAbpM98Euw59hUGPL37nrhcDq41GBzjzA
         tW1CaRNeiI8/8rGtnKXvwOdqKG4BQDRGz4+g2R8RosdN4TcYt6tpVqthmK8oUyZTnkZd
         Zv6WKhiN505vHRETlwOUUAPE1vsapvlsLIObkm3JeIGtzae/T7Botz5crdYRfgH6n6Rv
         iPbw==
X-Gm-Message-State: AOJu0YwfWuIb+E2Mjx0VDUFdbKxvOQJ+G9WQr2anBH7+leRJELAO6Op7
	WpVX3sbnQCP0atwxUMIBobpPL3CoAmNgnX0GOdNlI2e8fz8/gimwB/EO6zhNf5qnhzA=
X-Gm-Gg: AR+sD12PpvOSyrzyWPgkJsxSvK1UMfqVm92MHeE0Uq96egUOT66g2xx6q6cF3nldS/F
	8GHNRtpx1p6NBFpmD0pVAvgGfJTWNS9KNwAe/RsHzpZmLhbgmYT8JAbt9S65QAIP3mO8vJ3dSnQ
	+D/sU5NhGYodMOz/M1J3q08gkFxPAFoWk6FpXZv5SZVjx+XF2JRAf0A9tyqOsZytlMt4mV60meh
	SRlKPUPN/RShDzi7mHq0J96Djyj/yX/1HVPfKXZjwZ10aYlolQyUprggPJEaCYTyDUEsmdk7vLi
	/+klVuo0URhEdtL7AnR52EJCNhpyS3d65sqpq0Y+6njH5MDr1bO1PLuHUrqKE6w/8/02UEq0gDZ
	XAuTkaLHzxQ9g68fbI4kVzXvr2akK7VFtuu2lgDD9v3JfdmBXKb0ore7mq6gFH6D1t2zUi/wMaO
	Kyd1nJpYZIncZn+Xdq+KFZrW2GbBxfYP+Xdlg5sIobi6YuWS6s4NxwUWebjrC2tI7QxNzchgL7d
	CzHX5MbJ2ZXv0yIAFvwHovQv32EzQcMUGwFA7+07H8Xlo53bwmB1aWVf+s=
X-Received: by 2002:a53:c056:0:10b0:667:8b93:4fdf with SMTP id 956f58d0204a3-66905860663mr1630700d50.49.1785281363465;
        Tue, 28 Jul 2026 16:29:23 -0700 (PDT)
Received: from com-79390 ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669125fbd76sm711511d50.11.2026.07.28.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:29:23 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:29:19 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: friel@openai.com
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, stolee@gmail.com,
	me@ttaylorr.com, ps@pks.im, jonathantanmy@fastmail.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
Message-ID: <amk7T6N5XhArUQwo@com-79390>
References: <20260728042550.91133-2-friel@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728042550.91133-2-friel@openai.com>

On Mon, Jul 27, 2026 at 09:25:32PM -0700, friel@openai.com wrote:
> Git's upload-pack normally uses pack-objects to select each reachable
> object once before writing a response. A server can instead construct
> that response by streaming entries from existing packs. When those
> packs overlap, the same object can appear more than once.
>
> Avoiding duplicates requires the producers to coordinate their object
> selection or track object IDs across all input packs. A duplicate can
> also be used as a delta base, so removing it can require buffering and
> rewriting the response. Doing that work at request time gives up the
> memory and latency benefits of streaming existing packs.

Right. An out-of-tree implementation of upload-pack may choose to stitch
multiple individual packs together by concatenating them, trading some
pack generation time for a pack which may contain duplicate objects.

While this series is primarily motivated by that use-case, I suspect
that there are optimizations we could make within Git's implementation
of upload-pack that would take advantage of environments where clients
are prepared to accept packs that contain duplicate objects.

That's not a goal of this patch, of course, but something to keep in
mind as others review this.

> Applies on top of tb/pack-with-duplicates.
>
>  Documentation/config/pack.adoc    |  11 ++
>  Documentation/git-index-pack.adoc |  12 ++-
>  builtin/index-pack.c              |  41 ++++++-
>  t/t5308-pack-detect-duplicates.sh | 171 ++++++++++++++++++++++++++++++
>  t/t5309-pack-delta-cycles.sh      |  10 ++
>  5 files changed, 241 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
> index 22384c2d2f..2229878abe 100644
> --- a/Documentation/config/pack.adoc
> +++ b/Documentation/config/pack.adoc
> @@ -39,6 +39,17 @@ is set to "multi", reuse parts of just the bitmapped packfile. This
>  can reduce memory and CPU usage to serve fetches, but might result in
>  sending a slightly larger pack. Defaults to true.
>
> +pack.allowDuplicateObjects::
> +	Allow linkgit:git-index-pack[1] to accept a pack containing
> +	multiple copies of the same object while checking that the pack
> +	is self-contained and connected. For example,
> +	`git clone -c pack.allowDuplicateObjects <repository>` can accept
> +	a pack generated from overlapping existing packs. Object and
> +	connectivity checks are preserved. Explicit `--strict` and
> +	`--verify` continue to reject duplicate objects.
> +	`--no-allow-duplicate-objects` overrides this setting.
> +	Defaults to `false`.
> +

A couple of brief thoughts here:

 - Is "while checking that the pack is self-contained and connected"
   true in all cases? Certainly if we give the option
   '--check-self-contained-any-connected' to 'index-pack'. But if
   a user invokes "git -c pack.allowDuplicateObjects index-pack ...",
   we will not bother to perform the same checks.

 - The "For example [...]" may be unnecessary here. I don't have a
   strong feeling here either way, but it feels somewhat specific to
   'git-clone(1)' so perhaps belongs there instead?

 - "Explicit `--strict` and `--verify` [...]" and the following
   sentence. I think that this means to suggest that `--strict` and
   `--verify` both continue to behave as-is, but setting this
   configuration option allows them to conditionally accept
   otherwise-good packs that happen to contain duplicate objects.

   I wonder if these couple of sentences may be combined like: "When
   `true`, linkgit:git-index-pack[1] will accept otherwise-valid packs
   containing duplicate objects under `--strict` or `--verify`." But
   reading further, I don't think that that's actually what this option
   does. More below.

>  pack.island::
>  	An extended regular expression configuring a set of delta
>  	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
> diff --git a/Documentation/git-index-pack.adoc b/Documentation/git-index-pack.adoc
> index 18036953c0..1cb11ff898 100644
> --- a/Documentation/git-index-pack.adoc
> +++ b/Documentation/git-index-pack.adoc
> @@ -11,7 +11,9 @@ SYNOPSIS
>  [verse]
>  'git index-pack' [-v] [-o <index-file>] [--[no-]rev-index] <pack-file>
>  'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
> -		  [--[no-]rev-index] [<pack-file>]
> +		  [--[no-]rev-index]
> +		  [--[no-]allow-duplicate-objects]
> +		  [<pack-file>]

Not the fault of this patch, but the synopsis and usage string
(`index_pack_usage`) do not agree, hence the 'index-pack' entry in
t/t0450/adoc-help-mismatches. So putting this on a new line is OK, but I
think it's fine to keep this and "[<pack-file>]" on the same line as
"[--[no-]rev-index]" in the pre-image of this patch.

>  DESCRIPTION
> @@ -97,6 +99,14 @@ default and "Indexing objects" when `--stdin` is specified.
>  --check-self-contained-and-connected::
>  	Die if the pack contains broken links. For internal use only.
>
> +--allow-duplicate-objects::
> +--no-allow-duplicate-objects::
> +	Allow or reject multiple copies of the same object while checking
> +	that the pack is self-contained and connected. The default is
> +	controlled by `pack.allowDuplicateObjects`. The command-line
> +	option overrides the configuration. `--allow-duplicate-objects`
> +	cannot be combined with `--strict` or `--verify`.

Hmm. This suggests something other than what I gathered when reading the
corresponding git-config(1) entry.

Are there cases where we would want want to allow duplicate object,s but
retain the other "--strict" behavior of dying when the pack contains
broken objects, or links off to objects that we don't have? I would
imagine that 'git clone' would want to do just this. I imagine that such
a use-case would expect that even if we are cloning from a source that
is known to produce packs with duplicate objects we would still want to
verify that none of the objects it references are missing, etc.

I think that suggests something more along the lines of having this
option opt you out of this specific portion of "--strict"'s behavior, as
in "git index-pack --strict --allow-duplicate-objects". I may be missing
something here.

> @@ -135,6 +135,11 @@ static int nr_threads;
>
>  static int from_stdin;
>  static int strict;
> +static enum {
> +	DUPLICATE_OBJECTS_REJECT = 0,
> +	DUPLICATE_OBJECTS_ALLOW_CONFIG,
> +	DUPLICATE_OBJECTS_ALLOW_OPTION,
> +} allow_duplicate_objects;

I was initially a little surprised to see a new enum value here for what
I imagined would be a true/false value. But looking at the diff below, I
think that this is to silently ignore a "true" value for the config
option 'pack.allowDuplicateObjects' in the presence of "--strict".

So I think that this tri-state is fine in that sense. But I imagine that
much of this goes away if we take this option to instead carve out one
specific behavior of --strict instead of being incompatible with it
entirely.

> +	if (write_idx_strict &&
> +	    allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION)
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--allow-duplicate-objects", "--strict");
> +	if (verify &&
> +	    allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION)
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--allow-duplicate-objects", "--verify");

If you end up keeping the existing meaning and need to declare this
incompatible with write_idx_strict and verify, there is a helper for
this case:

    die_for_incompatible_opt2(allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION,
                              "--allow-duplicate-objects",
                              write_idx_strict, "--strict");

    die_for_incompatible_opt2(allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION,
                              "--allow-duplicate-objects",
                              verify, "--verify");

Alternatively, since writing "allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION"
is kind of a mouthful, you could instead write this abomination:

    if (allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION) {
        die_for_incompatible_opt2(1, "--allow-duplicate-objects",
                                  write_idx_strict, "--strict");
        die_for_incompatible_opt2(1, "--allow-duplicate-objects",
                                  verify, "--verify");
    }

;-)

> @@ -2055,7 +2090,7 @@ int cmd_index_pack(int argc,
>  		read_idx_option(&opts, index_name);
>  		opts.flags |= WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
>  	}
> -	if (strict)
> +	if (write_idx_strict)
>  		opts.flags |= WRITE_IDX_STRICT;
>
>  	if (HAVE_THREADS && !nr_threads) {

OK. Since we aren't treating this as a carve-out, we don't have any
further changes in pack-write.c. Makes sense, though I am curious about
your thoughts on whether the alternate interface makes more or less
sense.

> diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
> index c6273a1aeb..95c81fa7b4 100755
> --- a/t/t5308-pack-detect-duplicates.sh
> +++ b/t/t5308-pack-detect-duplicates.sh

I haven't read the tests carefully (under the assumption that they may
change substantively if the meaning of "--allow-duplicate-objects" is
altered). But from skimming, I wonder if there is some room to shrink
the number of tests.

When working with an agent, I typically ask it to implement the minimal
number of tests, along with a prompt that it must demonstrate that those
tests still exercise all interesting behavior. Often I will repeat this
a number of times until I am similarly convinced.

Thanks,
Taylor
