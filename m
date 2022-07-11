Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE80C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 22:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiGKWLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKWLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 18:11:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FE13EA7
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:11:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C319F1364D5;
        Mon, 11 Jul 2022 18:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jboFJPbPFZgskOsaFWdFtMPO+ySRFeLZvleftn
        SF3tY=; b=BdiHtHSWZT2SgKkX9qr7uJhwyFFeynru+DQcHGEnXVIZcAKGIBUBpQ
        LHTkjDZ/K5aw+3ZXPWIU/XxyWXMNVkGcS3fQEMi2LqopGPoWg4/nkNSpgAjp3Xp2
        uAkHzEAi+poO/VI51MrTF57n2XXGD47CHexjuY1L1YGRePhDZ6PPc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B96CB1364D4;
        Mon, 11 Jul 2022 18:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29C0A1364D3;
        Mon, 11 Jul 2022 18:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] ls-files: introduce "--format" option
References: <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
        <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com>
Date:   Mon, 11 Jul 2022 15:11:39 -0700
In-Reply-To: <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Mon, 11 Jul 2022 16:53:55 +0000")
Message-ID: <xmqqleszl2p0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70F6FBB4-0166-11ED-AD66-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Add a new option --format that output index enties ...

Let's quote the options and use the Oxford comma.

    ls-files: introduce "--format" option

    Add a new option "--format" that outputs index entries in a
    custom format, taking inspiration from the option with the same
    name in the `git ls-tree` command.

    "--format" cannot used with "-s", "-o", "-k", "-t", "--resolve-undo",
    "--deduplicate", and "--eol".

> +It is possible to print in a custom format by using the `--format`
> +option, which is able to interpolate different fields using

So we use the term "field" to mean different piece of information we
can present.  The definition of what fields are available come later
and the presentation order is a bit awkward, but hopefully the text
is understandable as-is.

> +a `%(fieldname)` notation. For example, if you only care about the
> +"objectname" and "path" fields, you can execute with a specific
> +"--format" like
> +
> +	git ls-files --format='%(objectname) %(path)'

And the example makes it pretty clear.  OK.

> +FIELD NAMES
> +-----------
> +Various values from structured fields can be used to interpolate

Are we dealing with unstructured fields, too?  If not, let's drop
"structured".

> +into the resulting output. For each outputting line, the following
> +names can be used:

"outputting line" sounds like a non language.


    The way each path is shown can be customized by using the
    `--format=<format>` option, where the %(fieldname) in the
    <format> string for various aspects of the index entry are
    interpolated.  The following "fieldname" are understood:

perhaps?

> +
> +objectmode::
> +	The mode of the file which is recorded in the index.
> +objectname::
> +	The name of the file which is recorded in the index.
> +stage::
> +	The stage of the file which is recorded in the index.
> +eolinfo:index::
> +eolinfo:worktree::
> +	The <eolinfo> (see the description of the `--eol` option) of
> +	the contents in the index or in the worktree for the path.
> +eolattr::
> +	The <eolattr> (see the description of the `--eol` option)
> +	that applies to the path.

> +path::
> +	The pathname of the file which is recorded in the index.

Since we are mutually exclusive with "--other", the output always
comes from the index, so this is OK.

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index e791b65e7e9..6376dbcccc6 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -11,6 +11,7 @@
>  #include "quote.h"
>  #include "dir.h"
>  #include "builtin.h"
> +#include "strbuf.h"

This is not strictly needed (we have users of strbuf in this file
without this patch already), but OK.

> @@ -48,6 +49,7 @@ static char *ps_matched;
>  static const char *with_tree;
>  static int exc_given;
>  static int exclude_args;
> +static const char *format;
>  
>  static const char *tag_cached = "";
>  static const char *tag_unmerged = "";
> @@ -85,6 +87,15 @@ static void write_name(const char *name)
>  				   stdout, line_terminator);
>  }
>  
> +static void write_name_to_buf(struct strbuf *sb, const char *name)
> +{
> +	const char *rel = relative_path(name, prefix_len ? prefix : NULL, sb);

A blank line here between the decl and the first statement.

> +	if (line_terminator)
> +		quote_c_style(rel, sb, NULL, 0);
> +	else
> +		strbuf_add(sb, rel, strlen(rel));

It's the same thing, but strbuf_addstr() is less error prone.

> @@ -222,6 +233,72 @@ static void show_submodule(struct repository *superproject,
>  	repo_clear(&subrepo);
>  }
>  
> +struct show_index_data {
> +	const char *pathname;
> +	struct index_state *istate;
> +	const struct cache_entry *ce;
> +};
> +
> +static size_t expand_show_index(struct strbuf *sb, const char *start,
> +			       void *context)

I think this does not make "struct" and "void" align (one more SP needed).

> +{
> +	struct show_index_data *data = context;
> +	const char *end;
> +	const char *p;
> +	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
> +	struct stat st;
> +
> +	if (len)
> +		return len;
> +	if (*start != '(')
> +		die(_("bad ls-files format: element '%s' "
> +		      "does not start with '('"), start);
> +
> +	end = strchr(start + 1, ')');
> +	if (!end)
> +		die(_("bad ls-files format: element '%s'"
> +		      "does not end in ')'"), start);
> +
> +	len = end - start + 1;
> +	if (skip_prefix(start, "(objectmode)", &p))


Using skip_prefix() not for the purpose of skipping (notice that
nobody uses p at all) is ugly.  We already computed start and end
(hence the length), so we should be able to do much better than
this.

But let's let it pass, as it was copy-pasted from existing code in
ls-tree.c::expand_show_tree().

> +	else if (skip_prefix(start, "(eolinfo:index)", &p) &&
> +		 S_ISREG(data->ce->ce_mode))
> +		strbuf_addstr(sb, get_cached_convert_stats_ascii(data->istate,
> +								 data->ce->name));

This is outright wrong, isn't it?

It is unlikely to see such a trivial error in the 6th round of a
series after other reviewers looked at it many times, so perhaps I
am missing something?  Or perhaps this is a new code added in this
round.

If you ask for %(eolinfo:index) for an index entry that is not a
regular file, this "else if" will not trigger, and the control will
eventually fall through to hit "bad ls-files format" but what you
detected is not a bad format at all.  Once the skip_prefix() hits,
you should be committed to handle that "field" and never let the
other choices in this if/elif/ cascade to see it.

It is OK to interpolate %(eolinfo:index) to an empty string for a
gitlink and a symbolic link, but the right way to do so would
probably be:

	else if (skip_prefix(start, "(eolinfo:index)", &p) {
		if (S_ISREG(data->ce->ce_mode))
			strbuf_addstr(...);
	} else ...

> +	else if (skip_prefix(start, "(eolinfo:worktree)", &p) &&
> +		 !lstat(data->pathname, &st) && S_ISREG(st.st_mode))
> +		strbuf_addstr(sb, get_wt_convert_stats_ascii(data->pathname));

Likewise.

> +test_expect_success 'setup' '
> +	echo o1 >o1 &&
> +	echo o2 >o2 &&
> +	git add o1 o2 &&
> +	git add --chmod +x o1 &&
> +	git commit -m base
> +'

Apparently, this set-up is too trivial to uncover the above bug that
can be spotted in 10 seconds of staring at the code.  Perhaps add a
symbolic link (use "git update-index --cacheinfo" and you do not
have to worry about Windows), a subdirectory and a submodule?

