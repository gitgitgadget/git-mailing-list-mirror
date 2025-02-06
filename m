Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D731DC9B4
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738875591; cv=none; b=uFysLez8cxiliZDf3j7ZdMWmKySGoXEFU9knWc7vXymmbRBFW7fci1xQwA4630p5ZggfK/bEvoACc7Ojxry8Tj7s9MQxbwTIp5LEFQW2Ll6iuj2x3yo5BclLD7dJloiOEVGzgC4ksgQ9KGpS9UXSulFixhcDW2YXHHLBV4kTejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738875591; c=relaxed/simple;
	bh=fnYBf20DY3GhpoGl1qwEmGJi4sibT0IV2DaUBpOY+eQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eg0kkH06B3MSJkeGQj3kumzJ3HPcBJEwYQY309hm5zXp5b4Unv9lN2Th+geeFbkWOpbLDg5QHQ2XOLRPhlfEzdwFLlhNq2YC/T72jT9uQ+pmxOMs8KUR4ekemyEe5YbRuGZmGJWSw4UR9BRuLrJIbFdGZZTkV5nIacmtGOJoC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eN2OESx0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ynxnRGCl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eN2OESx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ynxnRGCl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 235DB2540194;
	Thu,  6 Feb 2025 15:59:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 15:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738875587; x=1738961987; bh=Ue3x6FywIT
	Bdj/cBv+KuuUiF0J5Gx3iiV2ILbL/gAzg=; b=eN2OESx0S8dHLG/nisulPKfYwP
	hK/jHy5SWno0Vm1xHzXN3wQ2pFYP3IIQ0p4AuB0hEE0FddGa/OlpGbaAharWoNRf
	vv6uqNAVbxHmrRY+Ho54V/6yN+UbX3gvRfaS8hifpwDSmJt89dXJ/RT9xuNuyABW
	xcKmp2nWNP240DAzcxejVqqkHuWHmMJqbNzJDotEF5K11K49cUWEorPNgx22wswn
	6BMpNZdLSDpI9uS9Brx0361y1cWugVytwgvR2lkGQmXYFYrO/ZOj40guONn11nDt
	Ge5qUCWYeftOgJpyrATUi6yMiKk7bHSC5BgTXw2qXQXVF2BfzPRLngyyEwgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738875587; x=1738961987; bh=Ue3x6FywITBdj/cBv+KuuUiF0J5Gx3iiV2I
	LbL/gAzg=; b=ynxnRGCl16Uou/39O+vFk8YrW56tKlU3SG1tB0us/yqETXv5C7e
	nkUAN4pWE0bzEzLe1VisEWC7kIMJqEcFNclQRhHOEC/Q0ITUGmdJqptp5QItcPjI
	QeLE1/AP/xTTbJToLT9j5X9YWYCSfm1WzsdTKsjR67FGlP7IUOidMMVFgXkcsE9G
	4DsXKfJVKg4pw0mM/NJ6yUWbVzE1YmmZUwuVa47Zxl2nhvseDsRiwolpZLFXaa34
	dxiqqth/LqErSrie1ClWfatNxGM2WTDvHQgSLsibBo2hxNWL7P8Z63G2w+VuCnJL
	EYF9E7baaeH96KT4yPSVN46bl3+3SzAvn5A==
X-ME-Sender: <xms:wyKlZ3Yh4mOLQE9pxba5Iux-4215UsqjoQbmF0aV8WwA8u5TDMfTPA>
    <xme:wyKlZ2ZfFiYJnimf-zOLbjddT_6t9X99xijbl0i_xFGCyI_Tc2U82NJ4NdmEVdknv
    jJ7vU1x6JveZYMuRQ>
X-ME-Received: <xmr:wyKlZ5-apK5Ptn6JUwWGQeXlzC4PEhR-BZmcd52tyqwFGT51QKORWqpNJlAiJDjGvbXC-0fBVJDDJQLUgwi3WkwvyAxLFyLp8axi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehilhhlihgrrdgsoh
    gshihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:wyKlZ9obePC4FYvgo6be-G4X_zn2lTwkMAMhvRJSM9iCpdLOBBZUnA>
    <xmx:wyKlZyp8ZUH3gvJqhrj_fMVhk0elO7WSmVlyGjs7gtBTEpOOKdNGDQ>
    <xmx:wyKlZzQ2Ymk1coudWf15B7qL-4ADpIt3_Ym6ahcLh4Ro29sXTbWcyA>
    <xmx:wyKlZ6pdEZ4BlhDs7kSFz7LrMn1DZwdYlyONfycHqi-WNuVlvd3Hlg>
    <xmx:wyKlZ_Dl5V7QXpGmSR8xZCEAbqdVeDRUwLBtssKHJRw1B7szWWRt-wIT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 15:59:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: Jeff King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] diff: --patch-{modifies,grep} arg names for -S
 and -G
In-Reply-To: <20250206014324.1839232-2-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Wed, 5 Feb 2025 17:43:16 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250206014324.1839232-2-illia.bobyr@gmail.com>
Date: Thu, 06 Feb 2025 12:59:45 -0800
Message-ID: <xmqqseoqiybi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Most arguments have both short and long versions.  Long versions are
> easier to read, especially in scripts and command history.
>
> Tests that check just the option parsing are duplicated to check both
> short and long argument options.  But more complex tests are updated to
> use the long argument in order to improve the test readability.

While checking both may be a prudent thing to do, because the "-S"
option and the "-G" option have been there with us almost since the
beginning of time, the swapping all existing use of them with the
longhand is rather unwelcome and needless churn, I would have to
say.

>  `-S<string>`::
> +`--patch-modifies=<string>`::

Good.  I am looking at 'git-commit.txt' as an example, and we seem
to give shorthand first and then longhand, which matches what we see
here.

> @@ -657,18 +658,19 @@ renamed entries cannot appear if detection for those types is disabled.
>  It is useful when you're looking for an exact block of code (like a
>  struct), and want to know the history of that block since it first
>  came into being: use the feature iteratively to feed the interesting
> -block in the preimage back into `-S`, and keep going until you get the
> -very first version of the block.
> +block in the preimage back into `--patch-modifies`, and keep going until
> +you get the very first version of the block.

If this paragraph _were_ written with the longhand from the
beginning, I would not have minded too much, but I personally find
it unnecessary to churn the existing document like this.

>  `-G<regex>`::
> +`--patch-grep=<regex>`::

Same two paragraphs from the above apply here, and ...

>  `--find-object=<object-id>`::
>  `--pickaxe-all`::
>  `--pickaxe-regex`::

... all of the above.

> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt

Ditto.

> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index 642c5..e4b18 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -245,33 +245,35 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
>  
>  This transformation limits the set of filepairs to those that change
>  specified strings between the preimage and the postimage in a certain
> -way.  -S<block-of-text> and -G<regular-expression> options are used to
> +way.  --patch-modifies=<block-of-text> and
> +--patch-grep=<regular-expression> options are used to specify
> +different ways these strings are sought.

This is worse.  Here is the first part that describes the pickaxe,
so mentioning both may be more appropriate; showing only the
longhand nobody is familiar with (yet) does not make any sense.

    ... certain way.  `--patch-modifies=<block-of-text>`
    (`-S<block-of-text>` for short) and `--patch-grep=<regular-expression>`
    (`-G<regular-expression>` for short) are used to ...

Once establishing the equivalence between the longhand and the
shorthand for these two options, we do not have to churn the
existing text at all.

> diff --git a/diff.c b/diff.c
> index d28b41..09beb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4877,15 +4877,17 @@ void diff_setup_done(struct diff_options *options)
>  
>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
>  		die(_("options '%s', '%s', and '%s' cannot be used together"),
> -			"-G", "-S", "--find-object");
> +			"-G/--patch-grep", "-S/--patch-modifies", "--find-object");
>  
>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
>  		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s'"),
> -			"-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
> +			"-G/--patch-grep", "--pickaxe-regex",
> +                        "--pickaxe-regex", "-S/--patch-modifies");
>  
>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
>  		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
> -			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
> +			"--pickaxe-all", "--find-object",
> +                        "--pickaxe-all", "-G/--patch-grep", "-S/--patch-modifies");

The message change looks fine; the indentation is broken.

.git/rebase-apply/patch:184: indent with spaces.
                        "--pickaxe-regex", "-S/--patch-modifies");
.git/rebase-apply/patch:190: indent with spaces.
                        "--pickaxe-all", "-G/--patch-grep", "-S/--patch-modifies");
warning: 2 lines applied after fixing whitespace errors.
Applying: diff: --patch-{modifies,grep} arg names for -S and -G

These alone do not require a new iteration, as "git am --whitespace=fix"
already corrected them.

> -		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
> +		OPT_CALLBACK_F('S', "patch-modifies", options, N_("<string>"),
> -		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
> +		OPT_CALLBACK_F('G', "patch-grep", options, N_("<regex>"),

OK.  NOte that this says <regex>.  We may want to have a separate clean-up
patch so that Documentation/gitdifcore.txt that used <regular-expression>
and the placeholder used here match.

> -			       N_("look for differences that change the number of occurrences of the specified regex"),
> +			       N_("look for differences where a patch contains the specified regex"),

This is an unrelated change that should not be in this patch.  If
you want to modify it, please do it in a separate clean-up patch,
just like the above <regex> vs <regular-expression> change.

> -			  N_("show all changes in the changeset with -S or -G"),
> +			  N_("show all changes in the changeset with -S/--patch-modifies or -G/--patch-grep"),

This line is meant to be shown when the user requests list of
options and their meanings.  Growing the message from 47 columns or
so to 78 columns would make it wider than terminals when these
messages are indented.  Because earlier entries in this array have
already established the equivalence between the shorthand and the
longhand, I do not think the output is understandable without this
change.

>  		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
> -			  N_("treat <string> in -S as extended POSIX regular expression"),
> +			  N_("treat <string> in -S/--patch-modifies as extended POSIX regular expression"),

Ditto.

Thanks.
