Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DD92022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdBWT7M (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:59:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35568 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBWT7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:59:10 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so154379pgz.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yjjPPgCnO52ffq0omhB+4fd7dwBO6UZh6lsAVeDu+RA=;
        b=M7wj3iAJsRBzS7kbeTZKMXz9XFhe+21opgRvD8nr34TYEmb3XVNODfk4OMrv4oInxh
         XGVcZa3TZyKIcwDNq47TSelqw1RdK4eBTlCMZ4lTn+Y6u0T8LAMvtIjvfbRO5ZmFGLtO
         npG2XkjjE+eRSk0qR7/fbg2Df5nYMsTowBBqdmrPQ8Qald9vMmKrPXVU2BjpAjPJhjHv
         1gV/0ZNcAmlPu0MLymW9WO6Z69HnLmZ1WNkz/UM2LTA8k8IA4Eb/I08U/U/IUFR44nsk
         mOhqca7bGG12TSuGaxcnOAL159jlKovg+dFCGxXsrtjb0TKfZ3PnA2RhxOzp96iM3OKe
         Hv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yjjPPgCnO52ffq0omhB+4fd7dwBO6UZh6lsAVeDu+RA=;
        b=FdDsksu+deKjB2dmYF0KUN8pWiZrU875dnQdXiYHEENOZmfc7KADepKDTWj/whhWms
         oWaVTVrarmtPc0Dp4x3W2bLQWJGHJ0PhVc0T98ZBIoFUEAHSO7tNSdlFWLp4To7j5P31
         rwRffm1Sx1xc9BTaSdoyLKP1tPjlgFqdBHjP643rhoSWI8K41l/njmIZ79rTN4Ryxanj
         JTucKYEut6xjNuld1k/tAqRRCe1T30e79shiYCN/9ES5AcvO6pZNZofyM3FcYDc/iDD5
         br/ePlnF07d5w2bPgHOjG/K0h+WNW+Ba2R+PmdRIfLw5pkAEOrWpmqf6LXR3Jo4QnqL5
         eeDQ==
X-Gm-Message-State: AMke39kGod7tR8M/Z4WC/UmgxYJHi4ktSd41DXUcBsqPs+A6pMJ8iBm+Wjmu9ryuAPmmBg==
X-Received: by 10.99.94.198 with SMTP id s189mr50710030pgb.211.1487879949458;
        Thu, 23 Feb 2017 11:59:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id z27sm11306628pfg.38.2017.02.23.11.59.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 11:59:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 1/1] config: add conditional include
References: <20170223122346.12222-1-pclouds@gmail.com>
        <20170223122346.12222-2-pclouds@gmail.com>
Date:   Thu, 23 Feb 2017 11:59:08 -0800
In-Reply-To: <20170223122346.12222-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 23 Feb 2017 19:23:46 +0700")
Message-ID: <xmqqwpcg7k6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>> There was some discussion after v4. I think the open issues are:
>>
>>   - the commit message is rather terse (it should describe motivation,
>>     and can refer to the docs for the "how")

> This allows some more flexibility in managing configuration across
> repositories. 

That is not an ideal opening to describe motivation without people
knowing what "this" is ;-) Of course, the person who wrote the
sentence know it already after writing the patch and the subject,
but others don't.

	Sometimes a set of repositories want to share configuration
	settings among themselves that are distinct from other such
	sets of repositories.  A user may work on two projects, each
	of which have multiple repositories, and use one user.email
	for one project while using another for the other.  Having
	the settings in ~/.gitconfig, which would work for just one
	set of repositories, would not well in such a situation.

	Extend the include.path mechanism that lets a config file
	include another config file, so that the inclusion can be
	done only when some conditions hold.  Then ~/.gitconfig can
	say "include config-project-A only when working on project-A"
        for each project A the user works on.

        In this patch, the only supported grouping is based on
        $GIT_DIR (in absolute path), so you would need to group
        repositories by directory, or something like that to take
        advantage of it.

        We already have include.path for unconditional
        includes. This patch goes with include-if.xxx.path to make
        it clearer that a condition is required.

        Similar to include.path, older git versions that don't
        understand include-if will simply ignore them.

or something along that line?

> +Conditional includes
> +~~~~~~~~~~~~~~~~~~~~
> +
> +You can include one config file from another conditionally by setting
> +a special `include-if.<condition>.path` variable to the name of the
> +file to be included. The variable is treated the same way as
> +`include.path`.

Drop "special", as all configuration variables are "special" in their
own sense, it does not add any useful information.

I think we avoid '-' in Git-native variable and section names, so
"include-if" would become an odd-man-out.

The variable is obviously not treated the same way as include.path ;-)

    When includeIf.<condition>.path variable is set in a
    configuration file, the configuration file named by that
    variable is included (in a way similar to how include.path
    works) only if the <condition> holds true.

> +The condition starts with a keyword, followed by a colon and a
> +pattern. The interpretation of the pattern depends on the keyword.

"a pattern"?  I think it is "some data whose format and meaning
depends on the keyword".

Hence...

> +Supported keywords are:
> +
> +`gitdir`::
> +	The environment variable `GIT_DIR` must match the following
> +	pattern for files to be included. The pattern can contain

	The data that follows the keyword `gitdir:` is used as a
	glob pattern.  If the location of the .git directory (which
	may be auto-discovered, or come from `GIT_DIR` environment
	variable) match the pattern, the `<condition>` becomes true.

> + ...
> + * If the pattern ends with `/`, `**` will be automatically added. For
> +   example, the pattern `foo/` becomes `foo/**`. In other words, it
> +   matches "foo" and everything inside, recursively.
> +
> +`gitdir/i`::
> +	This is the same as `gitdir` except that matching is done
> +	case-insensitively (e.g. on case-insensitive file sytems)
> +
> +A few more notes on matching:

As future <keywords> may not be about path or matching at all, this
belongs to `gitdir`:: section (and it would be obvious that that
applies to `gitdir/i`:: because we say "this is the same as...").

> + * Symlinks in `$GIT_DIR` are not resolved before matching.
> +
> + * Note that "../" is not special and will match literally, which is
> +   unlikely what you want.

> +static int prepare_include_condition_pattern(struct strbuf *pat)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	int prefix = 0;
> +
> +	/* TODO: maybe support ~user/ too */
> +	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
> +		const char *home = getenv("HOME");
> +
> +		if (!home)
> +			return error(_("$HOME is not defined"));

Instead of half-duplicating it here yourself, can't we let
expand_user_path() do its thing?

> +static int include_condition_is_true(const char *cond, size_t cond_len)
> +{
> +	/* no condition (i.e., "include.path") is always true */
> +	if (!cond)
> +		return 1;
> +
> +	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> +		return include_by_gitdir(cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> +		return include_by_gitdir(cond, cond_len, 1);

This may be OK for now, but it should be trivial to start from a
table with two entries, i.e.

	struct include_cond {
		const char *keyword;
		int (*fn)(const char *, size_t);
	};

and will show a better way to do things to those who follow your
footsteps.

