Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFFF1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 20:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeHHWjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:39:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54662 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeHHWjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:39:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so4013558wmb.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0MeWjcJGgeQYuW+9hxhfPPbVG7X0V89QGg34LOZu3ZM=;
        b=vTja4LjpSfJfjusmDKY6B1QiktKUWLdeZUI9UOipE3aaLIgmoIvsbPfX2/NquznNZk
         Wrajy9hhsSMhz9TTghgDB3/RfXJW9/gtbmiBhiL6P6PIj10uhrQkkFCpjUWjpoNvGAAZ
         wuf6VBzf3D1ELIQC6Dd5ULm5IHxUasnXzQUyct3s2MIKETzHdM4H66wUckAorE7/aF5A
         VdW5YWtPDkLCm8OEG5FXtCjMgyCPyB8E5vzsOWbQsRP3E5wF0WqCoQFGw5TsRP804XUp
         CW39WV8T3U7ZuzPYpLz+bH9rZ6iyK+69hkVd4pLJUd4h+tGoFqw55Wk0g2o5gAq8rmQc
         wUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0MeWjcJGgeQYuW+9hxhfPPbVG7X0V89QGg34LOZu3ZM=;
        b=U2uqUAXFadNrufMo1j3e5ujUR7eQdIh0wPr3BCI9buvMglMN6l/ZWPFh+Pxav+rcu4
         SL0EA3n4TByifwWSmCCqjy5YZxrzg/+clIcbxnd1jGCAfc1PjsAOYja63K5zXBIi2Pp3
         lmBxL+HDvt9e99pkSZ6MfOQ4Y6drbUvCV818j7NhiaYYcmmIIXBMTsJ5ydhQTMVhbL92
         LMoyEoFzPW+/NS+6EtmAiQJu2DH4M1VcEcZZmDSqYIxBhMKpuIALQmlcKyNjqiwlFmMC
         aLX30ZKlmhZ5FOdSie9cfNoYOMO21K+7yuOcuI9FvSkr5ak6pSWVS/43lOoZEydSTdgF
         6rsg==
X-Gm-Message-State: AOUpUlFCa6fDCHUS94e3XVdb1fD3nbNUgiUsUV1w6UH16V5g5F44YnGd
        aF7vtJk7HYgT/29+OjZO5qo=
X-Google-Smtp-Source: AA+uWPxR/6FF2oekK+YoQqQZQtaNnZlJP1kUU11sItdwpMU95CsrFkVZp3bS9oCr8JpZoazbHBqJWw==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr2826510wmy.11.1533759516722;
        Wed, 08 Aug 2018 13:18:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u4-v6sm177312wro.47.2018.08.08.13.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 13:18:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 05/26] stash: convert apply to builtin
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
        <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
Date:   Wed, 08 Aug 2018 13:18:35 -0700
In-Reply-To: <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Wed, 8 Aug 2018 21:58:44
        +0300")
Message-ID: <xmqqa7pwfw84.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> From: Joel Teichroeb <joel@teichroeb.net>
>
> Add a builtin helper for performing stash commands. Converting
> all at once proved hard to review, so starting with just apply
> lets conversion get started without the other commands being
> finished.
>
> The helper is being implemented as a drop in replacement for
> stash so that when it is complete it can simply be renamed and
> the shell script deleted.
>
> Delete the contents of the apply_stash shell function and replace
> it with a call to stash--helper apply until pop is also
> converted.
>
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Good to see that the right way to forward a patch from another
person is used, but is this a GSoC project?

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> new file mode 100644
> index 000000000..ef6a9d30d
> --- /dev/null
> +++ b/builtin/stash--helper.c
> @@ -0,0 +1,452 @@
> +#include "builtin.h"
> +#include "config.h"
> +#include "parse-options.h"
> +#include "refs.h"
> +#include "lockfile.h"
> +#include "cache-tree.h"
> +#include "unpack-trees.h"
> +#include "merge-recursive.h"
> +#include "argv-array.h"
> +#include "run-command.h"
> +#include "dir.h"
> +#include "rerere.h"

Wow, "apply" is a biggie, as you'd pretty much have to do
everything, like merging and updating the index and asking rerere to
auto-resolve.  Quite a many include files.

> +static const char * const git_stash_helper_usage[] = {
> +	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
> +static const char * const git_stash_helper_apply_usage[] = {
> +	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> + ...
> +static void assert_stash_like(struct stash_info *info, const char * revision)

This inherits an unfortunate name from the scripted version (it does
more than asserting), but it is OK to keep the original name,
especially in this early step in the series.

Lose the SP in "* revision"; the asterisk sticks to the variable/parameter name.

> +{
> +	if (get_oidf(&info->b_commit, "%s^1", revision) ||
> +	    get_oidf(&info->w_tree, "%s:", revision) ||
> +	    get_oidf(&info->b_tree, "%s^1:", revision) ||
> +	    get_oidf(&info->i_tree, "%s^2:", revision)) {
> +		free_stash_info(info);
> +		error(_("'%s' is not a stash-like commit"), revision);
> +		exit(128);
> +	}
> +}

> +static int reset_tree(struct object_id *i_tree, int update, int reset)
> +{
> ...
> +}

Kind-a surprising that there is no helper function to do this
already.  The implementation looked OK, though.

> +static int apply_cached(struct strbuf *out)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/*
> +	 * Apply currently only reads either from stdin or a file, thus
> +	 * apply_all_patches would have to be updated to optionally take a
> +	 * buffer.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
> +	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +}

Applying and updating the index is more resource intensive than
spawning a process, and not having to worry about the process dying
is a benefit, so overall, making this into an internal call would be
a lot lower priority, I would guess.

> +static int reset_head(const char *prefix)
> +{

This is resetting the index to the HEAD, right?  reset_head sounds
as if it takes a commit-ish and moves HEAD there.

