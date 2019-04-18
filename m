Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AAC420248
	for <e@80x24.org>; Thu, 18 Apr 2019 01:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfDRBfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 21:35:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33364 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRBfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 21:35:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so790895wrp.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xBUvpjjf9wm9SVOSY/obHVP/zvguCDm2BvaBiQUo8Xs=;
        b=HLw+Tm9r3obEarO63o055nuwQnTLrRINyHrHFihDJxWNQlUhS71XgcDUO53EupDwls
         V/PIqQyVQOzDXGVM8EZP2cVSQdrDFutYcP/uUJcGQmRB2HaJih60DGklBRPQJeMAQpdA
         G21sIaHXDEiiN4cLoCnzkw+LdCMAZIuMEYJw+tQELY0lylXE/t8AG2qWBmlsb3aM7lr4
         3bH6aPbi+oZBzwsl0OKgrsVKHOoSZ3h9zXNx7VVyA0LRgNUoEj8CnAt+dGICnxbipE0/
         JANI/1d8bBDktGQVzbL0eHxtK38zKMwGsDknE/PGFTdmIE291YwxVBLMvGDyjS0uh/ur
         d/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xBUvpjjf9wm9SVOSY/obHVP/zvguCDm2BvaBiQUo8Xs=;
        b=F3MApQUYoAeev3lRca+0BikFB+KMuKu4s25QUylENyhtsRO4iF8h3UOODEFXJx6dOi
         SOl8jFelx1NUVnizP3saL1ovn/1feKV/T1TqcgWhFRnCzcdtZPtZNLe2H455aNnE8euJ
         iI10ZPNBZyKz+OcR/YoHEWEizQ3sxmbt4NWvXVfIvqF58qO+cmOYFeD2TtMeO8pBftUH
         A0WyUTNaCNVGTPmzZDNKOe6HlXyStcqlbO6v9Hv0IWViWIidpVZk1oJJ0Qy9hO1khp97
         9nt/DPBxuDqyXOU5tfQYttPUI7EvxJhH3/1fU/TPsZtcel+UtzcIs/FD7zKlH+83D5XU
         ho4w==
X-Gm-Message-State: APjAAAUX8/6VjnNqsDeF63Q4JpQmgyDnEbo0oc/hXUpJ6tFufNPdladF
        FAMVNPvPG8Io57MPhI7gHcE=
X-Google-Smtp-Source: APXvYqwbeUDLhv4h1qpuHpdYcJqEyby+od0BLduhJxE9qCt9o70WDAkfG+cJBFXaCTC52Camlt/47A==
X-Received: by 2002:adf:efcf:: with SMTP id i15mr300046wrp.133.1555551349271;
        Wed, 17 Apr 2019 18:35:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j190sm519234wmb.19.2019.04.17.18.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 18:35:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Cc:     <git@vger.kernel.org>, <matthieu.moy@univ-lyon1.fr>,
        <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>
Subject: Re: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
References: <20190409125205.13754-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190417160138.6114-1-corentin.bompard@etu.univ-lyon1.fr>
Date:   Thu, 18 Apr 2019 10:35:48 +0900
In-Reply-To: <20190417160138.6114-1-corentin.bompard@etu.univ-lyon1.fr>
        (Corentin BOMPARD's message of "Wed, 17 Apr 2019 18:01:38 +0200")
Message-ID: <xmqq7ebshz7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr> writes:

> Add the --set-upstream option to git pull/fetch
> which lets the user set the upstream configuration
> for the current branch.

I think it is a good idea to mention what you exactly mean by "the
upstream configuration" here.  

Do you mean the "branch.<current-branch-name>.merge" configuration
variable?

> For example a typical use-case like
>     git clone http://example.com/my-public-fork
>     git remote add main http://example.com/project-main-repo
>     git pull main master --set-upstream
> or, instead of the last line
>     git fetch main master --set-upstream
>     git merge # or git rebase

A bit more blank lines around the block of sample commands would
make the result easier to read.

> This foncionality works like git push --set-upstream.

functionality?

>
> Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
> Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
> Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
> Signed-off-by: Matthieu MOY <matthieu.moy@univ-lyon1.fr>
> ---
>  Sorry for being so long.
>
>  Documentation/fetch-options.txt |   5 ++
>  builtin/fetch.c                 |  55 ++++++++++++-
>  builtin/pull.c                  |   6 ++
>  t/t5553-set-upstream.sh         | 142 ++++++++++++++++++++++++++++++++
>  4 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 t/t5553-set-upstream.sh
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index fa0a3151b..4d2d55643 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -165,6 +165,11 @@ ifndef::git-pull[]
>  	Disable recursive fetching of submodules (this has the same effect as
>  	using the `--recurse-submodules=no` option).
>  
> +--set-upstream::
> +	If the new URL remote is correct, pull and add upstream (tracking) 
> +	reference, used by argument-less linkgit:git-push[1] and other commands.

git-push and other commands?  The way I read the motivating use case
example we saw in the proposed commit log message, i.e.

     git clone http://example.com/my-public-fork
     git remote add main http://example.com/project-main-repo
     git pull --set-upstream main master [*1*]

was that your initial cloning made "fetch/pull" by default interact
with your public fork by mistake, and you are correcting it with the
new "--set-upstream" option so that future "fetch/pull" will instead
go to the true upstream, while directing your "push" traffic to still
go to your public fork.  If that is the case, then shouldn't this
paragraph in the doc talking about affecting future "git-fetch and
other commands", or "git fetch and pull" (which may be better)?

	Side note *1*: by the way, don't write --dashed-options
	after positional arguments; the parse-options parser may
	allow such a sloppy command line but it makes the examples
	inconsistent when done in the documentation and log
	messages.

> @@ -1317,6 +1320,56 @@ static int do_fetch(struct transport *transport,
>  		retcode = 1;
>  		goto cleanup;
>  	}
> +
> +	/* TODO: remove debug trace */

Perhaps do so before sending it out for the review?

> +	if (set_upstream) {
> +		struct branch *branch = branch_get("HEAD");
> +		struct ref *rm;
> +		struct ref *source_ref = NULL;

Have a blank line here, after the decls that appear before the first
statement in a block.

> +		/*
> +		 * We're setting the upstream configuration for the current branch. The
> +		 * relevent upstream is the fetched branch that is meant to be merged with
> +		 * the current one, i.e. the one fetched to FETCH_HEAD.
> +		 *
> +		 * When there are several such branches, consider the request ambiguous and
> +		 * err on the safe side by doing nothing and just emit a waring.
> +		 */
> +		for (rm = ref_map; rm; rm = rm->next) {
> +			fprintf(stderr, "\n -%s", rm->name);
> +			if (rm->peer_ref) {
> +				fprintf(stderr, " -> %s", rm->peer_ref->name);
> +			} else {
> +				if (source_ref) {
> +					fprintf(stderr, " -> FETCH_HEAD\n");
> +					warning(_("Multiple branch detected, incompatible with set-upstream"));

downcase "M" for consistency.  I won't repeat for other new messages
in the patch.

Shouldn't this be diagnosed as an error and stop the "fetch" or
"pull", though?

> diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
> new file mode 100644

Make your test scripts executable.

> index 000000000..6126bb188
> --- /dev/null
> +++ b/t/t5553-set-upstream.sh
> @@ -0,0 +1,142 @@
> +#!/bin/sh
> +
> +test_description='"git fetch/pull --set-upstream" basic tests.
> +
> +'
> +. ./test-lib.sh
> +
> +check_config() {

SP before () is missing here (I won't repeat).

> +	(echo $2; echo $3) >expect.$1 &&

Make sure to dq quote $variable_references UNLESS you mean you
intend to pass a string with $IFS in it and want the shell to split
the interpolation into individual tokens (I won't repeat).

Especially, quote the filename that is a target for redirection to
work-around a (mis)feature in bash (I won't repeat).

You do not need subshell for the above.  Perhaps

	printf "%s\n" "$2" "$3" >"expect.$1" &&

> +	(git config branch.$1.remote
> +	 git config branch.$1.merge) >actual.$1 &&

You do not need a subshell for this, either

	{
		git config "branch.$1.remote" && git config "branch.$1.merge"
	} >"actual.$1"

> +	test_cmp expect.$1 actual.$1

> +check_config_empty() {

s/empty/missing/ would make the distinction even clear.

> +	test_must_fail git config branch.$1.remote &&
> +	test_must_fail git config branch.$1.merge

Do we document that "git config" errors out with a more specific
signal to say "the reason why the command has failed is because the
key was not found", by the way?  I think we do, and in that case the
test should expect that specific exit code.

> +}
> +check_config_empty1() {

A blank line before a new shell function.

This one is about an empty string, so it can be named check_config_empty
once the misnamed one above that checked for a missing definition gets
renamed away.

> +	git config branch.$1.remote >remote.$1

Here is a break &&-chain; intended?

> +	test_must_be_empty remote.$1 &&
> +	git config branch.$1.merge >merge.$1

Likewise.

> +	test_must_be_empty merge.$1
> +}

If this wanted to say "It is OK for the variable to be missing, and
it also is OK for the variable to have an empty string as its value;
all other cases are unacceptable", then have another layer of helper
perhaps like

        variable_missing_or_empty () (
                value=$(git config "$1")
                case $? in
                0)	# exists
                        test -z "$value" ;;
                1)	# missing
                        true ;;
                *)	false ;;
                esac
        )

and then you can say

	check_config_missing_or_empty () {
		variable_missing_or_empty "remote.$1" &&
		variable_missing_or_empty "merge.$1"
	}

In any case, you do not seem to use empty1 variant in the rest of
the patch.  Has this been proofread before getting sent?

	... Ahh, this is WIP/RFC.  So a later iteration may start
	using it.  OK then.

