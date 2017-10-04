Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C552036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdJDEkU (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:40:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64841 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750909AbdJDEkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:40:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D956595782;
        Wed,  4 Oct 2017 00:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8OFAavuOF7Od+3k0vdR/29yPmVY=; b=GucB2f
        HntN2ky9KkbPKxgk2UmTYaqTyEIXLpWt9wcnKpbFyGPnNHEzIDQ6vZgAEdQkIpbt
        YdV7odVS/UQYXUaoqp0j8nadvrZqX9W34M/+r8FvCmN9YjKBa+Fb/heibABGiHZ6
        b5k2JqKrT4NtWTDNr0pbVGXQn80QaJ8Cq/XQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wMSATJx4IFhiTDoVxvIJUyEmm8TV14pZ
        +FznEpelwU04aB2fjw34lOIl4+6HjE58GnT8T4uFzkadMBXZkz8yeDdnfevxJ9gh
        55KPSU96EURDZ4bxTuif/dMwf328Eal7qbFuybMnfmcu2A3l5vF1ng0vTnUymn7y
        quMIHgOtoxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D202595780;
        Wed,  4 Oct 2017 00:40:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 556999577F;
        Wed,  4 Oct 2017 00:40:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien <damien@dam.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run-command.c: add hint when hook is not executable
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
Date:   Wed, 04 Oct 2017 13:40:12 +0900
In-Reply-To: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
        (damien@dam.io's message of "Tue, 3 Oct 2017 10:59:37 +0000")
Message-ID: <xmqqo9pnedar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C81E540-A8BE-11E7-949E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien <damien@dam.io> writes:

> ---

Please explain why this change makes sense to those who find this
commit in "git log" output six months down the line, without having
read the original thread that motivated you to add this feature
above this line with three dashes.  Use your full name on the From:
header of your mail (or alternatively, you can use an in-body "From:"
to override what your MUA places there) and add sign-off with the
same name (cf. Documentation/SubmittingPatches).

>  Documentation/config.txt               | 2 ++
>  advice.c                               | 2 ++
>  advice.h                               | 1 +
>  contrib/completion/git-completion.bash | 1 +
>  run-command.c                          | 4 ++++
>  5 files changed, 10 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1ac0ae6adb046..83b1884cf22fc 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -351,6 +351,8 @@ advice.*::
>  	addEmbeddedRepo::
>  		Advice on what to do when you've accidentally added one
>  		git repo inside of another.
> +	hookNotExecutable::
> +		Shown when an hook is there but not executable.
>  --

"Shown when" does not tell readers what is shown; many of the other
entries in this list does so, and it is helpful to choose from the
list when a user encounters one of these advice messages and wants
to squelch it.

> diff --git a/advice.c b/advice.c
> diff --git a/advice.h b/advice.h
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash

The changes to these files looked good.

> diff --git a/run-command.c b/run-command.c
> index b5e6eb37c0eb3..95d93a23bf87e 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1174,6 +1174,10 @@ const char *find_hook(const char *name)
>  		if (access(path.buf, X_OK) >= 0)
>  			return path.buf;
>  #endif
> +		if (advice_hook_not_executable) {
> +			advise(_("The '%s' hook was ignored because it's not set as executable."
> +				"\nYou can disable this warning with `git config advice.hookNotExecutable false`"), name);
> +		}
>  		return NULL;

As to the string constant, it is somewhat strange to see it is
chomped into two and the LF in the middle is given to the latter
half.  If you are going to chomp anyway, perhaps you'd want to chomp
it further to avoid making the source line too long.

But more importantly, is this checking the right thing?  Before the
pre-context of this hunk is:

	if (access(path.buf, X_OK) < 0) {

so we know access(X_OK) failed.  And we didn't have to care how/why
it failed because the only thing we did was to return NULL when we
decide there is no executable hook.

But for the purpose of your patch, you now do care.  access(X_OK)
may have failed with EACCESS (i.e. you have no permission to run the
script), in which case your new advise() call may make sense.  But
it may have failed with ENOENT or ENOTDIR.  And your new advise()
call is a disaster, if the user didn't even have such a hook.

Writing a test would have helped notice this, I would think.  You'd
need at least the following variations to cover possibilities:

 - Without the advise.* configuration, install an executable hook
   for a command and try to run the command.  Make sure you do not
   see any advise message shown.

 - Drop the executable bit from the hook from the above and run the
   same command.  Make sure you do see the advise message.  You'd
   probably need to protect this test piece with POSIXPERM
   prerequisite.

 - Set advise.* configuration to squelch and run the same command.
   Make sure you do not see the advise message.

 - Remove advise.* configuration and the hook, and run the same
   command.  Make sure you do not see the advise message.


