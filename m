Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E8DC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 18:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D59A22BF3
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 18:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a9bPA38n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZSrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:47:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58392 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgHZSrE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 14:47:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B89CAED11F;
        Wed, 26 Aug 2020 14:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0vCuQRySdxfigRJcZTtYZvVhBzI=; b=a9bPA3
        8nla5vrljVegHP8o2huN9exH1eZVqhsj0nW1+fdkozUM72F8A5XO7/4H2a7Gqat8
        JCtXTGb5bMR+hUgsExuvOwWvo/ZSIBW2AK9r3c/ai77w0PKI2VYSECvn5PA7GD4i
        LAlyKqO4rRaTHOcy5n0uOm3siOn5ilnb8UHFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uke9v9YIkTbGlimMLp3RQlLUvvkTxg6a
        LmZcZ012FAidhpJKsYVrmReLWGZB/BgmUEI1AvNxy8Wf1CsA16x6heAMzia4Jcky
        s6OG1ssi26kd31TB+B09mdK+Go8Q+RhbHHJxD3erTtOeiUTZkReJErtkyjbeENFt
        wvwsYz7VYzM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4B8BED11E;
        Wed, 26 Aug 2020 14:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB455ED11D;
        Wed, 26 Aug 2020 14:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Barag <sean@barag.org>
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
References: <pull.710.git.1598456751674.gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 11:46:53 -0700
In-Reply-To: <pull.710.git.1598456751674.gitgitgadget@gmail.com> (Sean Barag
        via GitGitGadget's message of "Wed, 26 Aug 2020 15:45:51 +0000")
Message-ID: <xmqqlfi1utwi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83392974-E7CC-11EA-A301-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Barag <sean@barag.org>
>
> While the default remote name of `origin` can be overridden both
> pre-clone (with `git clone --origin foo`) and post-clone (with `git
> remote rename origin foo`), it'd be handy to have a configurable
> system-wide default for clones!  

I doubt it is handy enough to deserve an explamation point.  Replace
it with a plain-vanilla full-stop instead.

I however tend to agree that, even evidenced by the manual page
description of "git clone", i.e.

    -o <name>::
    --origin <name>::
            Instead of using the remote name `origin` to keep track
            of the upstream repository, use `<name>`.

that it is understandable if many users and projects wish to call it
"upstream".

> This commit implements
> `remote.cloneDefault` as a parallel to `remote.pushDefault`,
> with prioritized name resolution:

I highly doubt that .cloneDefault is a good name.  After reading
only the title of the patch e-mail, i.e. when the only available
information on the change available to me was the name of the
configuration variable and the fact that it pertains to the command
"git clone", I thought it is to specify a URL, from which "git
clone" without the URL would clone from that single repository.

And the name will cause the same misunderstanding to normal users,
not just to reviewers of your patch, after this change hits a future
Git release.

Taking a parallel from init.defaultBranchName, I would probably call
it clone.defaultUpstreamName if I were writing this feature.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index b087ee40c2..b0dbb848c6 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -941,6 +941,29 @@ static int path_exists(const char *path)
>  	return !stat(path, &sb);
>  }
>  
> +struct clone_default_info
> +{
> +	enum config_scope scope;
> +	struct strbuf remote_name;
> +	int linenr;
> +};
> +
> +static int config_read_clone_default(const char *key, const char *value,
> +	void *cb)
> +{
> +	struct clone_default_info* info = cb;
> +	if (strcmp(key, "remote.clonedefault") || !value) {
> +		return 0;
> +	}
> +
> +	info->scope = current_config_scope();
> +	strbuf_reset(&info->remote_name);
> +	strbuf_addstr(&info->remote_name, value);
> +	info->linenr = current_config_line();
> +
> +	return 0;
> +}

This feels way overkill and insufficient at the same time.  It does
not need scope, it does not need linenr, and we already have a place
to store end-user specified name for the upstream in the form of the
variable option_origin.  And the code is not diagnosing any error.

static int git_clone_config(const char *k, const char *v, void *cb)
{
	if (option_origin)
		return 0; /* ignore -- the user gave us an option */

	if (!strcmp(k, "clone.defaultupstreamname")) {
		if (!v)
			return config_error_nonbool(k);
		if (strchr(v, '/') || check_refname_format(v, REFNAME_ALLOW_ONELEVEL))
                	return error(_("invalid upstream name '%s'"), v);
		option_origin = xstrdup(v);
		return 0;
	}
	return 0;
}

would be sufficient, and at the same time makes sure it rejects
names like 'o..ri..gin', 'o/ri/gin', etc.

> @@ -992,8 +1015,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		option_no_checkout = 1;
>  	}
>  
> -	if (!option_origin)
> -		option_origin = "origin";
> +	if (!option_origin) {
> +		struct clone_default_info clone_default = { CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
> +		git_config(config_read_clone_default, &clone_default);
> +		if (strcmp("", (const char*) clone_default.remote_name.buf))
> +			option_origin = clone_default.remote_name.buf;
> +		else
> +			option_origin = "origin";
> +	}
> +

It is somewhat sad that we have the git_config(git_default_config)
call so late in the control flow.  I wonder if we can update the
start-up sequence to match the usual flow, e.g. these things happen
in the following order in a normal program.

    - variables are given their default value.

    - call git_config(git_commandspecific_config, ...) early in the
      program.

      - git_commandspecific_config() interprets the command specific
        variables and passes everything else to git_default_config()

      variables like option_origin are given values of configuration
      variable at this point.

    - call parse_options() next, which may override the variables
      from the value on the command line.

    - main control flow uses the variable.  "Command-line wins over
      configuration which wins over the default" falls out naturally.

One oddity "git clone" has is that it wants to delay the reading of
configuration files (they are read only once, and second and
subsequent git_config() calls will reuse what was read before [*])
so that it can read what clone.c::write_config() wrote, so if we were
to "fix" the start-up sequence to match the usual flow, we need to
satisfy what that odd arrangement wanted to achieve in some other
way (e.g. feed what is in option_config to git_default_config
ourselves, without using git_config(), as part of the "main control
flow uses the variable" part), but it should be doable.

	[*Side note*].  The above means that this patch, even when
	the configuration variable does not give upstream name, may
	break the option_config feature by breaking the second call
	to git_config().  We need to have a test for that.

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index e69427f881..8aac67b385 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -19,6 +19,20 @@ test_expect_success 'clone -o' '
>  
>  '
>  
> +test_expect_success 'clone respects remote.cloneDefault' '
> +
> +	git -c remote.cloneDefault=bar clone parent clone-config &&
> +	(cd clone-config && git rev-parse --verify refs/remotes/bar/master)
> +
> +'
> +
> +test_expect_success 'clone chooses correct remote name' '
> +
> +	git -c remote.cloneDefault=bar clone -o foo parent clone-o-and-config &&
> +	(cd clone-o-and-config && git rev-parse --verify refs/remotes/foo/master)
> +
> +'

These two are "showing off my shiny new toy" tests, which are
needed, but we also need negative tests where the shiny new toy does
not kick in when it should not.  For example

	git -c remote.cloneDefault="bad.../...name" clone parent

should fail, no?

Thanks.
