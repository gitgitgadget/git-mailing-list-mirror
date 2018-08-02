Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70FB51F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeHBTTN (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:19:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50354 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbeHBTTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:19:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so3431464wmc.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/A+FgiSLjLekWAwpKI6AxLqVBnM+vdZm/Zd1ApmvqNA=;
        b=s31HkDi2K5rev9s8t3HvM/Jjo8hs2ALpkjGIn+xJ3D58hsG31W5rQNgozjRlX1eeST
         6eiVh/O5pblSz0LLV8i8HTybqJu03k6SePtNGNBVqFk7xKVhUwUENBRnzqwmQJ7GbQ+7
         my6ODo5Cw2kxz2aieGyzSwRjAMpyLcHSeJHfYT5Ee4OEu9mD9YjbMkkc7dSl/6Urltjz
         /NvBwehjkpDEtckTogAvcqJzwqImF1nMtQQbk1q3aocMEAG/SYycEtqb0tbfa/MI7uqk
         LqRaYedbnOCw4ixa+cIK2OoUyLzzXWkdOeg4u0ySYbPrZvsVmnnzqpK5FSte1p8UhGgF
         XjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/A+FgiSLjLekWAwpKI6AxLqVBnM+vdZm/Zd1ApmvqNA=;
        b=GYdgVHmrbX4LaAjsJRGTCJrrKmrF4XUGBgSONPnGueXcCbCsQSV0uOaVLaZuOraw3n
         T7LfCVG3sIWYLU9L5UwQtHOwUfZC7fK5gWulY88c/TW5vtEr7AdiEbgJifGeri34BWYk
         FKir7FiBAPesYSxAJ+44LHlTe9L6HM961NqazZH9tIyMXGlWLOmkP2WnpmD7JlHtsys1
         MwfbQILwgZvpoVtnZWcW6wcjZu5OQf1lYFzdYJqkArmV2cGPS1beGd3JrutxsFMGC0cZ
         tJZUwurEEXGlhU5M5CAYMRyPYNBtXqViGwMSK3A6TtTuVM+PYf+Q100sr/1NtT23O531
         S44Q==
X-Gm-Message-State: AOUpUlE7cxGz90amJxTeAYFqMb7Wbq7uY4QyouXkD1AC0UF75Nm640o9
        q5wapJfnjwPjyycVhlJJ11Q=
X-Google-Smtp-Source: AAOMgpduKkofSbd+fSJKLfjddsLqeJ+QVxjn463OFizBkSrTSnLJKUPjESNwr4OFBsTyhiBwmYQZMw==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr2492370wmd.18.1533230825221;
        Thu, 02 Aug 2018 10:27:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a6-v6sm3310244wmf.22.2018.08.02.10.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 10:27:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
References: <20180731073331.40007-1-sunshine@sunshineco.com>
        <20180802112002.720-1-phillip.wood@talktalk.net>
        <20180802112002.720-3-phillip.wood@talktalk.net>
Date:   Thu, 02 Aug 2018 10:27:03 -0700
In-Reply-To: <20180802112002.720-3-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Thu, 2 Aug 2018 12:20:02 +0100")
Message-ID: <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Single quotes should be escaped as \' not \\'. The bad quoting breaks
> the interactive version of 'rebase --root' (which is used when there is
> no '--onto' even if the user does not specify --interactive) for authors
> that contain "'" as sq_dequote() called read_author_ident() errors out
> on the bad quoting.
>
> For other interactive rebases this only affects external scripts that
> read the author script and users whose git is upgraded from the shell
> version of rebase -i while rebase was stopped when the author contains
> "'". This is because the parsing in read_env_script() expected the
> broken quoting.

I wasn't following the discussion, but is it the general consensus
that reading the broken a-i file is a requirement for the new code?
Not an objection phrased as a question.

I do not think it is worth worrying about the "upgrade while rebase
was in progress" case, if it involves much more code than necessary
without its support, especially if the only thing the user needs to
do recover from such a situation is to say "rebase --abort" and then
to retry the same rebase with the fixed version that was installed
in the meantime.  Let's see how much we need to bend over backwards
to do this "transition" thing.

> Ideally rebase and am would share the same code for reading and
> writing the author script, but this commit just fixes the immediate
> bug.

OK.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 06a7b79307..c1e3f947a5 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -880,7 +880,7 @@ init_basic_state () {
>  	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
>  	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
>  
> -	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
> +	echo 1 > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"

This impacts the work Alban is doing, which at the end removes this
script altogether.

> +/*
> + * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE line with
> + * a "'" and also escaped "'" incorrectly as "'\\\\''" rather than "'\\''". Fix

I think the comment here (for both the wrong and the right versions)
is easier to read if you wrote the string as literal without C, i.e.
The string is "'\\''" but as a string literal in C it is expressed
as "'\\\\''".

> +static int fix_bad_author_script(struct strbuf *script)
> +{
> +	const char *next;
> +	size_t off = 0;
> +
> +	while ((next = strstr(script->buf + off, "'\\\\''"))) {

This looks brittle.

We need assurance that the first "'\\''" we see on the line came
from the attempt by the broken writer to write out a single "'", and
not from anything else.  The broken writer places its own "'"
immediately after GIT_AUTHOR_NAME= (just like the corrected one
does) before moving on to the end-user payload.  Can the single
quote at the beginning of the substring you are looking for be that
one?  If the end user's payload began with two backslashes, that
would have produced a result that matches the first three bytes of
the substring you are looking for.  But there is no way for the
end-user payload to make the next two bytes "''"---any byte other
than a sq would result in a sq added to the result, and a byte that
is a sq would give one sq followed by a bs.

OK, so this is probably doing the right thing, as long as we know we
are reading from the old and broken writer.  It still does look
unnecessarily ugly and over-engineered to have this (and the
"version" reading code), though, at least to me, but perhaps it is
just me.

Thanks.


