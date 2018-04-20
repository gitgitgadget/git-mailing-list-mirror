Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 464F41F404
	for <e@80x24.org>; Fri, 20 Apr 2018 01:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeDTBFs (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 21:05:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45296 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 21:05:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id u11-v6so18535947wri.12
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 18:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J5MR7iydpzMtnxwvhLhFHFRrUWrD+ykHCx/TjdBwJ48=;
        b=NwFYgaw/8Gb0fcDtc0Aje8UuPhLbeo7+D8s0H4EMtmHzxHJLcu1FEFMzLcuRhzz3Wn
         TMaHbpYgPfkJklpO2xtGotb4dwBxl/hqWrYJu+YXlSEJgVQP/cm5xzso9hactsfJLF8H
         VHjdWkOP5sU04jdTm9RguszGhB/VZ3m9cRnD9bundHUhRgkOAyAu7eMwkoB3E+upsPdM
         XUBuMWMIkvEeIydX8bjvfITs+P7UN4WiCxkwxBnd2GTwK7/IZkSuAjLT9Yb6JFs9OmoY
         C1OwUPZfFk/2IcSdCWstzhveADaBYyoSC1z3u+wEcSXWik3levLUlYhuOPzjxH+zxSar
         k8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J5MR7iydpzMtnxwvhLhFHFRrUWrD+ykHCx/TjdBwJ48=;
        b=SGKwqny7nyAyMGG7vXRhPU2erTU4EtAkumMe1twJc8+0paAiyi8Ybjcj4Qm+c6pbDN
         AoJAvcP8U8k2OEGvKVDZxuN99mVZSfHhNPngAcHrImpfb/FTt6EYedOJV63nzjV1zPb/
         qoyRMh3VW5UZXahjECpyIM81HccqcoXEWOcqehMVWO5Hdo4mm9mPmFm+c2ItAeSY7Mzo
         hiqps1ub0yUKsXuxiYUbgf7B6BwB4G0Aa2THgQQo75ADJEiXh/pUfICZMH+caDlI7oZt
         bycQLsgtlIJIeoj4N68a9zx6Y+YEFsrc/v95c5LTKtnT2Ut/EQuNzL/2E+XKl9Li/4xQ
         tGkA==
X-Gm-Message-State: ALQs6tA9O1Uaba95vp4lnBuIzK0Y21+AniIstVHtkjdmmKsrIwxMhpB3
        trV6DAGr9c9uCQzWbIr8rMQ=
X-Google-Smtp-Source: AIpwx49qQQiqp5e/LQUSYSEYr1WpgJa4l3UTDE47gn67CcXF/272abyYjGT/qvs/+gZ8SVyXGaCduA==
X-Received: by 2002:adf:c50f:: with SMTP id q15-v6mr5914265wrf.208.1524186345633;
        Thu, 19 Apr 2018 18:05:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a10-v6sm7390303wri.10.2018.04.19.18.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 18:05:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/7] replace: introduce --convert-graft-file
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
        <cover.1524125760.git.johannes.schindelin@gmx.de>
        <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
Date:   Fri, 20 Apr 2018 10:05:44 +0900
In-Reply-To: <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 19 Apr 2018 10:17:50 +0200
        (DST)")
Message-ID: <xmqqd0yud6vr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This option is intended to help with the transition away from the
> now-deprecated graft file.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-replace.txt | 11 +++++--
>  builtin/replace.c             | 59 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 66 insertions(+), 4 deletions(-)

I expected you to remove convert-grafts-to-replace-refs.sh from the
contrib/ section in the same patch, actually.  FWIW, I think it is a
much better approach to give the first-class UI for transition like
this patch does than "go fish for a good way to transition yourself,
we may have something useful in contrib/", which is what we had so
far.

> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> ...
> @@ -87,9 +88,13 @@ OPTIONS
>  	content as <commit> except that its parents will be
>  	[<parent>...] instead of <commit>'s parents. A replacement ref
>  	is then created to replace <commit> with the newly created
> -	commit. See contrib/convert-grafts-to-replace-refs.sh for an
> -	example script based on this option that can convert grafts to
> -	replace refs.
> +	commit. Use `--convert-graft-file` to convert a
> +	`$GIT_DIR/info/grafts` file use replace refs instead.
> +

Nice.

> diff --git a/builtin/replace.c b/builtin/replace.c
> index 43264f0998e..4cdc00a96df 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -20,6 +20,7 @@ static const char * const git_replace_usage[] = {
>  	N_("git replace [-f] <object> <replacement>"),
>  	N_("git replace [-f] --edit <object>"),
>  	N_("git replace [-f] --graft <commit> [<parent>...]"),
> +	N_("git replace [-f] --convert-graft-file"),
>  	N_("git replace -d <object>..."),
>  	N_("git replace [--format=<format>] [-l [<pattern>]]"),
>  	NULL
> @@ -423,6 +424,53 @@ static int create_graft(int argc, const char **argv, int force)
>  	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
>  }
>  
> +static int convert_graft_file(int force)
> +{
> +	const char *graft_file = get_graft_file();
> +	FILE *fp = fopen_or_warn(graft_file, "r");
> +	struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +
> +	if (!fp)
> +		return -1;

Returning silently is fine as fopen_or_warn() would have said
something already.  Good.

> +	while (strbuf_getline(&buf, fp) != EOF) {
> +		int i = 0, j;
> +
> +		while (i != buf.len) {
> +			char save;
> +
> +			for (j = i; j < buf.len && !isspace(buf.buf[j]); j++)
> +				; /* look further */
> +			save = buf.buf[j];
> +			buf.buf[j] = '\0';
> +			argv_array_push(&args, buf.buf + i);
> +			buf.buf[j] = save;

It's a shame that we do not have a helper that splits the contents
of a strbuf at SP and shove the result into an argv_array(). [*1*]

*1* There is one that splits into an array of strbuf but the point
of splitting is often that these split pieces are the final thing we
want, and placing them in separate strbuf (whose strength is that
contents are easily manipulatable) is pointless.

> +
> +			while (j < buf.len && isspace(buf.buf[j]))
> +				j++;
> +			i = j;

One difference I notice while comparing this with what is done by
contrib/convert-grafts-to-replace-refs.sh is that this does not
skip a line that begins with # or SP.  I offhand do not know what
the point of skipping a line that begins with a SP, but I suspect
that skipping a line that begins with "#" is a desirable thing to
do, because commit.c::read_graft_line() does know that such a line
is a valid comment.

> +		}
> +
> +		if (create_graft(args.argc, args.argv, force))
> +			strbuf_addf(&err, "\n\t%s", buf.buf);
> +
> +		argv_array_clear(&args);
> +		strbuf_reset(&buf);

Strictly speaking, this reset is redundant, as getline() will always
stuff the line into a fresh buffer (and after the loop there
correctly is a release).

> +	}
> +
> +	strbuf_release(&buf);
> +	argv_array_clear(&args);
> +
> +	if (!err.len)
> +		return unlink_or_warn(graft_file);
> +	warning(_("could not convert the following graft(s):\n%s"), err.buf);
> +	strbuf_release(&err);

commit.c::read_graft_file() seems to ignore a broken graft line and
salvages other lines, and this one follows suit, which is good.

The remaining die() I pointed out in 1/2 can safely be turned into
return error() for this caller (I didn't check for existing callers,
though) and would automatically do the right thing.  The real
consumer of the graft file, commit.c::read_graft_line(), shows an
error when oid cannot be parsed, and the above code, when
create_graft() is updated to return an error instead of dying, would
append the problematic record to buf.buf in the code above.

Looking basically-good modulo minor nits.
