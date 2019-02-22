Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655A420248
	for <e@80x24.org>; Fri, 22 Feb 2019 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfBVVqT (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 16:46:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41080 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVVqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 16:46:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so3870492wrw.8
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KR0s17nwbV+xZB8ydJeAQEHLpqlPuX02TqA4BDCotvU=;
        b=raQYmDWYQDWYD/+a50Vl9V1zdY+qUc+y6t/kdv43ZEbPWZ7Gq1hCbBspKns79pzI2x
         KlFnie3GWgpuYyWZ/lOPBeh7i8quA+U+BhAy17UvrbmuV4oLT0yGNc2CeJriR6yDDxSZ
         22bxSryDXOKnYS+4nmHmyb5qMujbgjvq+Yir8r0ZUWNbw79BHjAYH5dIrhoje9H7CEJb
         9eAHFe/1YK49U7Pjf+MuLTRHz2LDTzWl/C2o+bq/AAInK5KkGlW1TNiEbNSIbtAevlkb
         bsXeA+TC1Bvgq6ojFt9TJl7wxBSidfYpknJewfgBvyD1ITodS3Qn+2Jc+xC1MQPu8aKs
         2VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KR0s17nwbV+xZB8ydJeAQEHLpqlPuX02TqA4BDCotvU=;
        b=HZ1XWnPIEPmxSI7u4H8ZJ0bPQF4tL6J30H92Ztoq4e4HIV15E0D/MVmqgkXJ3uZHN2
         ZRvGxjsZGvU/2bW67wP2LVwiI429WJxXTJcWHI68pZuGFp5VdRzueZyRQ46nYQUv7Wdt
         M7AMuTxoc+Es7/fptbqx+fUmN1GIg9qQeLE9tKdtNYzKFN6707KiyjYtCLR6bGcb+5WB
         /Z/lss5G4l+3V3JImTypoGYJVEr9ZaoxoQAMl6XQIupQU08hZNo5+0FBbzTgW6xdR+Yh
         0uGydyWhVCfkFSCaIp2iDSaKlbyThzbv/relJWFhLeE9awW6uMgiBwJb/Yk4E55wIZPE
         AkTg==
X-Gm-Message-State: AHQUAuayx/Qa+erQMaGnqLzLIrg22A065/VPOy1Uq9xbtXPkF/fKmCVI
        iTqr1KNNPNeCcCrv2xold/E=
X-Google-Smtp-Source: AHgI3IZVsZqV/CdMsC5EMXUUacTLmnRhFcUHKw+UahrdNkmpiHEACxS37Ev2r8wuMDbpnN73wgzetA==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr4812440wrw.245.1550871975879;
        Fri, 22 Feb 2019 13:46:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c14sm3596035wrn.12.2019.02.22.13.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:46:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v5 04/10] add-interactive.c: implement list_and_choose
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
        <a97b29d2741e0e5ae8cf45b1c7cafc56afaa66ef.1550662887.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Feb 2019 13:46:14 -0800
In-Reply-To: <a97b29d2741e0e5ae8cf45b1c7cafc56afaa66ef.1550662887.git.gitgitgadget@gmail.com>
        (Slavica Djukic via GitGitGadget's message of "Wed, 20 Feb 2019
        03:41:31 -0800 (PST)")
Message-ID: <xmqqd0njpkd5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#define HEADER_INDENT "      "
> +
>  enum collection_phase {
>  	WORKTREE,
>  	INDEX
> @@ -27,6 +29,61 @@ struct collection_status {
>  	struct hashmap file_map;
>  };
>  
> +struct list_and_choose_options {
> +	int column_n;
> +	unsigned singleton:1;
> +	unsigned list_flat:1;
> +	unsigned list_only:1;
> +	unsigned list_only_file_names:1;
> +	unsigned immediate:1;
> +	char *header;
> +	const char *prompt;

Makes a reader wonder if "header" can also be const (not to be taken
as a suggestion to bend backwards to make it so).

> +	void (*on_eof_fn)(void);
> +};
> +
> +struct choice {
> +	struct hashmap_entry e;
> +	char type;

If this is for choosing among the member of union, possible value(s)
for the type member and which value corresponds to which union
member must be documented somewhere, perhaps as a comment around
here.

> +	union {
> +		void (*command_fn)(void);
> +		struct {
> +			struct {
> +				uintmax_t added, deleted;
> +			} index, worktree;
> +		} file;
> +	} u;
> +	size_t prefix_length;
> +	const char *name;
> +};
> +
> +struct choices {
> +	struct choice **choices;

In general, do not name an array in plural.  An exception is when
the code mostly refers to the array as a whole.

When most accesses are to individual elements, then it would be a
big win to be able to see choice[2] and pronounce it "the second
choice" (you do not say "the second choices").

> +	size_t alloc, nr;
> +};
> +#define CHOICES_INIT { NULL, 0, 0 }
> +
> +static int use_color = -1;
> +enum color_add_i {
> +	COLOR_PROMPT,
> +	COLOR_HEADER,
> +	COLOR_HELP,
> +	COLOR_ERROR
> +};
> +
> +static char colors[][COLOR_MAXLEN] = {

Do not be overly selfish to assume that this will stay to be the
only color pallette in this file.  If this is the color palette for
list_and_choose, then have it in its name, e.g. list_and_choose_color[]
or something like that.

> +	GIT_COLOR_BOLD_BLUE, /* Prompt */
> +	GIT_COLOR_BOLD,      /* Header */
> +	GIT_COLOR_BOLD_RED,  /* Help */
> +	GIT_COLOR_RESET      /* Reset */
> +};

Is the above list of values and comments correct?  

Doesn't each member of enum correspond to each element in
list_and_choose_color[][COLOR_MAXLEN] array?  It does not exactly
match my intuition to have help text in red and error messages in
plain color.

> @@ -186,3 +243,73 @@ static struct collection_status *list_modified(struct repository *r, const char
>  	free(files);
>  	return s;
>  }
> +
> +static struct choices *list_and_choose(struct choices *data,
> +				       struct list_and_choose_options *opts)
> +{
> +	if (!data)
> +		return NULL;
> +
> +	while (1) {
> +		int last_lf = 0;
> +
> +		if (opts->header) {
> +			const char *header_color = get_color(COLOR_HEADER);
> +			if (!opts->list_flat)
> +				printf(HEADER_INDENT);

I won't complain if this is sufficient for the application, but the
above would not allow different level of indentation depending on
what header is being shown.  It may make sense to get rid of list_flat
boolean and instead allow a new "const char *header_indent" member
in the opts structure supplied by the caller.

Don't use printf() when you _know_ you want to show a simple string
without any % interpolation.  fputs(HEADER_INDENT, stdout) would suffice.

> +			color_fprintf_ln(stdout, header_color, "%s", opts->header);
> +		}
> +
> +		for (int i = 0; i < data->nr; i++) {

We do not say "for (int i" (see a previous review).

> +			struct choice *c = data->choices[i];
> +			char *print;
> +			const char *modified_fmt = _("%12s %12s %s");
> +			char worktree_changes[50];
> +			char index_changes[50];
> +			char print_buf[100];

It appears that many of these variables are only needed inside "we
are showing 'f' and not just names" block.  Can their scope be
narrowed?

> +			print = (char *)c->name;

Yuck.  Stuff c->name into print_buf[] instead and get rid of "print"
pointer.

> +			if ((data->choices[i]->type == 'f') && (!opts->list_only_file_names)) {
> +				uintmax_t worktree_added = c->u.file.worktree.added;
> +				uintmax_t worktree_deleted = c->u.file.worktree.deleted;
> +				uintmax_t index_added = c->u.file.index.added;
> +				uintmax_t index_deleted = c->u.file.index.deleted;
> +
> +				if (worktree_added || worktree_deleted)
> +					snprintf(worktree_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX,
> +						 worktree_added, worktree_deleted);
> +				else
> +					snprintf(worktree_changes, 50, "%s", _("nothing"));
> +				if (index_added || index_deleted)
> +					snprintf(index_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX,
> +						 index_added, index_deleted);
> +				else
> +					snprintf(index_changes, 50, "%s", _("unchanged"));
> +
> +				snprintf(print_buf, 100, modified_fmt, index_changes,
> +					 worktree_changes, print);

All of the above look overly repetitious; a helper function that
takes a pointer to "struct { uintmax_t a, d; }" and populates
changes[] buffer would cut them down by half, but other than that
I do not see a room for drastic improvement here X-<.

Oh, it would greatly help to use two strbuf for wt/ix_changes that
are defined outside the loop that is strbuf_reset() after each
iteration and use things like strbuf_addf().

> +				print = xmalloc(strlen(print_buf) + 1);
> +				snprintf(print, 100, "%s", print_buf);

Likewise.

> +			}
> +
> +			printf(" %2d: %s", i + 1, print);
> +			if ((opts->list_flat) && ((i + 1) % (opts->column_n))) {
> +				printf("\t");
> +				last_lf = 0;
> +			}
> +			else {
> +				printf("\n");
> +				last_lf = 1;
> +			}
> +
> +		}
> +
> +		if (!last_lf)
> +			printf("\n");
> +
> +		return NULL;
> +	}
> +}

This obviously only lists but does not let you choose at this step
in the series, but that is OK.

But I see a deeper problem with the design of this helper.  The
things this helper can list is quite limited.

The original was designed so that the shown strings are prepared by
the caller and this helper is solely responsible for showing the
choices, giving prompt, and accepting choice (in various abbreviated
forms), all _WITHOUT_ having to know the meaning of what is in the
list.  It gave us a much better separation of labor and
responsibility between the caller and the callee, I would think.
