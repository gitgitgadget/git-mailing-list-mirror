Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D51B1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 10:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfKGKZP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 05:25:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55584 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGKZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 05:25:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABA0531CCE;
        Thu,  7 Nov 2019 05:25:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ek88+V6NWyXJqehVPaL2PsxlFo0=; b=R5dZPD
        vM18qR9hzK81Sk+iAT4DPii2VIjNp4NNzOHAh4sDMTnk6RNZEmYhvCFwtJwnhG1P
        nOgGVArNexeL1pHTM4s9KEUgoe/r0ftWuvxudR73JFp0r1ElZ4skVk6a4onGMH0h
        xqAKsVW2Lv8eF99GxKFMK+YIad0jfG4Do4w9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rf7vjVXSTkbBw7ctM9bv9tQLgcbyzNPH
        9F0QbR1ooEFeNZ7vO4SkQ7quBX8OihtVUaIyPB1foTVsR3Kprk2p/DJpqVwT0hxX
        i7WO447O3Dg1vtVGbdqS2MAR8TqH/oiWjIeL0sYFKckPSAxzqXTQR7zAX7+szKEu
        XwjVkgVurkw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6993931CCC;
        Thu,  7 Nov 2019 05:25:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B009731CCB;
        Thu,  7 Nov 2019 05:25:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 2/6] [Outreachy] check-ref-format: parse-options
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
        <e8bca0910e7ba7582a50115eeeb66406d965a52a.1573114201.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 19:25:05 +0900
In-Reply-To: <e8bca0910e7ba7582a50115eeeb66406d965a52a.1573114201.git.gitgitgadget@gmail.com>
        (george espinoza via GitGitGadget's message of "Thu, 07 Nov 2019
        08:09:56 +0000")
Message-ID: <xmqqmud8ouf2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE55017C-0148-11EA-BB5D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: george espinoza <gespinoz2019@gmail.com>
>
> This command currently handles its own argv so by teaching it to
> use parse-options instead we can standardize the way commands
> handle user input across the project.
>
> As a consequence of using OPT_BOOL data structure on --normalize &
> --refspec-pattern, --no-normalize & --no-refspec-pattern has been
> can now be used.
>
> NO_PARSEOPT flag was also removed to update git.c with the
> conversion of the structure in this command.
>
> This is a rough draft and I need some advice if I'm doing this
> correctly since its being built but it is failing tests.
>
> Helped by: emily shaffer <emilyshaffer@google.com>
> Helped by: johannes schindelin <johannes.schindelin@gmx.de>

I do not think they spell their name like the above.  In general,
most of us do not spell our names in all lowercase around here. I
appreciate people with originality, but I'd rather see them to be
original not in how they spell their names but in more productive
ways ;-)

> Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> ---
>  builtin/check-ref-format.c | 49 +++++++++++++++++++-------------------
>  git.c                      |  2 +-
>  2 files changed, 26 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index bc67d3f0a8..3fe0b5410a 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -6,10 +6,13 @@
>  #include "refs.h"
>  #include "builtin.h"
>  #include "strbuf.h"
> +#include "parse-options.h"
>  
> -static const char builtin_check_ref_format_usage[] =
> -"git check-ref-format [--normalize] [<options>] <refname>\n"
> -"   or: git check-ref-format --branch <branchname-shorthand>";
> +static const char * const builtin_check_ref_format_usage[] = {
> +	N_("git check-ref-format [--normalize] [<options>] <refname>\n"),
> +	N_("   or: git check-ref-format --branch <branchname-shorthand>"),
> +	NULL,
> +};

OK.  This is the bog-standard prep for calling usage_with_options().

> @@ -53,31 +56,29 @@ static int check_ref_format_branch(const char *arg)
>  
>  int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
>  {
> -	int i;
> -	int normalize = 0;
> +	enum {
> +		CHECK_REF_FORMAT_BRANCH,
> +	};
> +
> +	int i = 0;
> +	int verbose;
> +	int normalize;
> +	int allow_onelevel;
> +	int refspec_pattern;
>  	int flags = 0;
>  	const char *refname;

Discard the blank line before "int i = 0" line, and keep the blank
line you have here between the last declaration and the first
statement.

> -	if (argc == 2 && !strcmp(argv[1], "-h"))
> -		usage(builtin_check_ref_format_usage);
> -
> -	if (argc == 3 && !strcmp(argv[1], "--branch"))
> -		return check_ref_format_branch(argv[2]);
> +	struct option options[] = {
> +		OPT__VERBOSE(&verbose, N_("be verbose")),
> +		OPT_GROUP(""),
> +		OPT_CMDMODE( 0 , "branch", &check_ref_format_branch, N_("branch"), CHECK_REF_FORMAT_BRANCH),

This is an iffy/tricky way to use CMDMODE.  The way CMDMODE is
designed to be used is to have multiple ones that sets the same
target variable so that parse_options() can notice conflicting
command line request that gives more than one from the same set.

The command has two modes (i.e. the "--branch" mode and the unnamed
mode), so it is understandable that there is only one CMDMODE in the
options[] array, but I am not sure how well it would work for a
command like this.  For example, "check-ref-format --branch
--normalize --allow-onelevel $v" should error out because --branch
is not compatible with any other options.  I do not think a single
parse_options() call with a single options[] array can express that
kind of constraints.

Besides, shouldn't the third parameter of OPT_CMDMODE supposed to be
the address of the variable that would receive the value in its fifth
parameter?  I do not see a decl for check_ref_format_branch variable
(isn't that the name of the function???).

Ahh, you said it builds but does not pass test.  Of course, that is
because this part is completely bogus.

It appears that to your series the only thing that matters is the
shape of the tree after applying all of the patches, and individual
steps are not ready to be reviewd, so I'd stop here.

