Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F176F20248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfBVWLj (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:11:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVWLj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:11:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so3266304wmh.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pJ2JPvFtCX9QMZ6RgqLQzEsbYISZfOSkWCs6B/4XpXo=;
        b=rGpMCkQ+Jk9Sos/A3iC35ntH0laYK09VwKCt7TGhmQ/ZSDEWCz3jQFUYZfwZUPFxl7
         UEqpC1mIRnJHKA9zRb69Xga6rf9tFw50L6kTO5OXxhNnxfLu+pNVYYoyda1zxmUBWtt6
         hzjS6BD4Bm8hWgNCEM+KixFZj0v0o2wxF1epwa2Ktbe26NrYuE2rtbi8BtRcWx3J32NF
         osAG8neDJOO/hoHeoGMXg+RhlkhO59dJ1RzT4j1We3d+bigluZQkBT0HlMDgiAmXPUhe
         AjPbP6HOh1nH7BPCD+nyPT6NaYC+eJ/MdZkgdlGQAlTMLnDvOuCoUte6BWJRY5uwT2k1
         HMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pJ2JPvFtCX9QMZ6RgqLQzEsbYISZfOSkWCs6B/4XpXo=;
        b=VwELNO5oFCd3+RIf0PJWR7Ccm5+z9g7If4I4YT6dwJZZuWWYSo0GpcYCa/4qstDpCI
         2YdnCHnb6dbXptoKeTJOr7OcHqqg3ino8koqa0IHkRdAshlebPUJOTWWBQxC824Wk3Bd
         zEYpzqE7ClaVExlwHsComJGV5nFAf2tb5ypQkB9Tfr429DppDC1Cgdd/3eqWJNUCJwfj
         vFPi07XIMdXSI47EBSDJUNzkTxnquJw35mLXExfBwC7Bkj55sJVh3z83Tl1NNhYsDkIg
         v6iTxq8KFoVHJ1EDf1+jEvPlA0fkpu/mDFduNXfilDKkXhLHUMfaLYB6IcOkfFsIiRJs
         qZew==
X-Gm-Message-State: AHQUAuayDV56FCa00B3inFIv2FZHexLF59QFPMIsvoyES8Q3pzs1eOQh
        9hakeTJuMSVTmVTa9VzPQZ0=
X-Google-Smtp-Source: AHgI3IbG530xvR+jORzaXvIWz70o73LYq4oKupa67swLkPwh22/WehvVUTXxjGiCbN2nSkTK7dpSxg==
X-Received: by 2002:a1c:63d4:: with SMTP id x203mr3874539wmb.128.1550873496087;
        Fri, 22 Feb 2019 14:11:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z1sm1757455wrw.28.2019.02.22.14.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 14:11:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v5 05/10] add-interactive.c: implement status command
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
        <9a72aabe6cf1001d373c933086a79ace29b98806.1550662887.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Feb 2019 14:11:34 -0800
In-Reply-To: <9a72aabe6cf1001d373c933086a79ace29b98806.1550662887.git.gitgitgadget@gmail.com>
        (Slavica Djukic via GitGitGadget's message of "Wed, 20 Feb 2019
        03:41:32 -0800 (PST)")
Message-ID: <xmqq4l8vpj6x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int parse_color_slot(const char *slot)
> +{
> +	if (!strcasecmp(slot, "prompt"))
> +		return COLOR_PROMPT;
> +	if (!strcasecmp(slot, "header"))
> +		return COLOR_HEADER;
> +	if (!strcasecmp(slot, "help"))
> +		return COLOR_HELP;
> +	if (!strcasecmp(slot, "error"))
> +		return COLOR_ERROR;

As these are "color.interactive.<name>", matching case-insensitively
is the right thing to do.  Good.

If we would end up increasing the number of slots, we may need to
switch to LOOKUP_CONFIG(), but for just four of them, this will do.

> @@ -313,3 +357,78 @@ static struct choices *list_and_choose(struct choices *data,
>  		return NULL;
>  	}
>  }
> +
> +static struct choice *make_choice(const char *name )

Excess SP before ')'?

> +{
> +	struct choice *choice;

Style: have a blank line here to delineate decls (at the beginning
of a function) and stmts (at all the decls).

> +	FLEXPTR_ALLOC_STR(choice, name, name);
> +	return choice;
> +}
> +
> +static struct choice *add_choice(struct choices *choices, const char type,
> +				 struct file_stat *file, struct command *command)
> +{
> +	struct choice *choice;

Ditto here.

> +	switch (type) {
> +		case 'f':

Style: in our codebase, switch and case are indented to the same
level, with the body of each case arm indented one more level.

> +			choice = make_choice(file->name);
> +			choice->u.file.index.added = file->index.added;
> +			choice->u.file.index.deleted = file->index.deleted;
> +			choice->u.file.worktree.added = file->worktree.added;
> +			choice->u.file.worktree.deleted = file->worktree.deleted;

Would it make sense to make sure that all of file->index,
u.file.index, file->wt, u.file.wt are exactly the same type of
struct by introducing

	struct adddel { uintmax_t add, del; };

in a very early part of the series, and embed that structure as a
member in "struct choice" and "struct file_stat"?  That way, these
assignments would become two structure assignments, that would be
much easier to read.

> +void add_i_status(void)
> +{
> +	struct collection_status *s;
> +	struct list_and_choose_options opts = { 0 };
> +	struct hashmap *map;
> +	struct hashmap_iter iter;
> +	struct choices choices = CHOICES_INIT;
> +	struct file_stat *entry;
> +	const char *modified_fmt = _("%12s %12s %s");
> +	const char type = 'f';
> +
> +	opts.header = xmalloc(sizeof(char) * (HEADER_MAXLEN + 1));
> +	snprintf(opts.header, HEADER_MAXLEN + 1, modified_fmt,
> +		 _("staged"), _("unstaged"), _("path"));

Is there aversion to use of strbuf among your mentors?


> +	s = list_modified(the_repository, NULL);
> +	if (s == NULL)
> +		return;
> +
> +	map = &s->file_map;
> +	hashmap_iter_init(map, &iter);
> +	while ((entry = hashmap_iter_next(&iter))) {
> +		add_choice(&choices, type, entry, NULL);
> +	}
> +
> +	list_and_choose(&choices, &opts);

In what order are these filenames given?  Whatever random order the
hashmap happens to store them in?

I vaguely recall in an earlier step the code used hashmap to collect
but at the end produced a sorted list out of the final result.
Shouldn't we be iterating over that sorted list instead?  Do we even
need the hashmap at this point?

> +	hashmap_free(&s->file_map, 1);
> +	free(s);
> +	free_choices(&choices);

Did we just leak opt.header?

> +}
> diff --git a/add-interactive.h b/add-interactive.h
> new file mode 100644
> index 0000000000..8ef3d2e82b
> --- /dev/null
> +++ b/add-interactive.h
> @@ -0,0 +1,8 @@
> +#ifndef ADD_INTERACTIVE_H
> +#define ADD_INTERACTIVE_H
> +
> +int add_i_config(const char *var, const char *value, void *cbdata);
> +
> +void add_i_status(void);
> +
> +#endif
> diff --git a/builtin/add--helper.c b/builtin/add--helper.c
> index 6a97f0e191..464d2245f3 100644
> --- a/builtin/add--helper.c
> +++ b/builtin/add--helper.c
> @@ -1,6 +1,38 @@
> +#include "add-interactive.h"
>  #include "builtin.h"
> +#include "config.h"
> +#include "revision.h"
> +
> +static const char * const builtin_add_helper_usage[] = {
> +	N_("git add-interactive--helper <command>"),
> +	NULL
> +};
> +
> +enum cmd_mode {
> +	DEFAULT = 0,
> +	STATUS
> +};
>  
>  int cmd_add__helper(int argc, const char **argv, const char *prefix)
>  {
> +	enum cmd_mode mode = DEFAULT;
> +
> +	struct option options[] = {
> +		OPT_CMDMODE(0, "status", &mode,
> +			    N_("print status information with diffstat"), STATUS),
> +		OPT_END()
> +	};
> +
> +	git_config(add_i_config, NULL);
> +	argc = parse_options(argc, argv, NULL, options,
> +			     builtin_add_helper_usage,
> +			     PARSE_OPT_KEEP_ARGV0);
> +
> +	if (mode == STATUS)
> +		add_i_status();
> +	else
> +		usage_with_options(builtin_add_helper_usage,
> +				   options);
> +
>  	return 0;
>  }
