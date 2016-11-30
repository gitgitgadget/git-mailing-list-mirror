Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6014F1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932579AbcK3WkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:40:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64725 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753043AbcK3WkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:40:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6275A52D40;
        Wed, 30 Nov 2016 17:40:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZcqpJ2vLxNWJbMnJKdeGA6jqJfY=; b=sSlh0N
        gRVCbBkqGclIiozbA8E9BJwki3wzGYugF5huRHeWTDxbf3QyZgDHMJAv452kDfnf
        SNvVNon7hNzUPD3EsYUjJyJFJaV8De4eKQkN14oXjzIPG5YHVUaaEu01OXUTXa4a
        1/yY0xVZQ0PmVR/oOBO4hEJscQ4I67krdhIC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EPR4ADvsdovj7RA6kVwTJGz9UWcv7GOK
        lGIrT7C3e9rggLGrXOk4aRIHLfaYFgUXFMhWkcDMJ89t909eJLYMcVFLVN/IDipi
        /RIo1ReiLQA/QD1/MsjhMlnPTsst/H/P2RA+/MKeilJd9fBvSO5GyccmsO+xvGrK
        /SU/Zt0awLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F7F252D3E;
        Wed, 30 Nov 2016 17:40:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 480F252D3C;
        Wed, 30 Nov 2016 17:40:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Emily Xie <emilyxxie@gmail.com>
Subject: Re: "git add -p ." raises an unexpected "warning: empty strings as pathspecs will be made invalid in upcoming releases. please use . instead if you meant to match all paths"
References: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
        <20161130211100.GA18680@ikke.info>
        <xmqq7f7kd3pj.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 30 Nov 2016 14:40:02 -0800
In-Reply-To: <xmqq7f7kd3pj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 30 Nov 2016 14:04:40 -0800")
Message-ID: <xmqqtwaobni5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F04A2670-B74D-11E6-B676-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> forgot to Cc: the author of the
most relevant change to the issue, d426430e6e ("pathspec: warn on
empty strings as pathspec", 2016-06-22).

> Kevin Daudt <me@ikke.info> writes:
>
>> On Wed, Nov 30, 2016 at 12:31:49PM -0800, Peter Urda wrote:
>>> After upgrading to version 2.11.0 I am getting a warning about empty
>>> strings as pathspecs while using 'patch'
>>> 
>>> - Ran 'git add -p .' from the root of my git repository.
>>> 
>>> - I was able to normally stage my changes, but was presented with a
>>> "warning: empty strings as pathspecs will be made invalid in upcoming
>>> releases. please use . instead if you meant to match all paths"
>>> message.
>>> 
>>> - I expected no warning message since I included a "." with my original command.
>>> 
>>> I believe that I should not be seeing this warning message as I
>>> included the requested "." pathspec.
>
> Yes, this seems to be caused by pathspec.c::prefix_pathspec()
> overwriting the original pathspec "." into "".  The callchain
> looks like this:
>
>     builtin/add.c::interactive_add()
>      -> parse_pathspec()
>         passes argv[] that has "." to the caller,
>         receives pathspec whose pathspec->items[].original
> 	is supposed to point at the unmolested original,
>         but prefix_pathspec() munges "." into ""
>      -> run_add_interactive()
>         which runs "git add--interactive" with
> 	pathspec->items[].original as pathspecs
>
>
> Perhaps this would work it around, but there should be a better way
> to fix it (like, making sure that what we call "original" indeed
> stays "original").
>
>  builtin/add.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index e8fb80b36e..137097192d 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -167,9 +167,18 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  	if (revision)
>  		argv_array_push(&argv, revision);
>  	argv_array_push(&argv, "--");
> -	for (i = 0; i < pathspec->nr; i++)
> +	for (i = 0; i < pathspec->nr; i++) {
>  		/* pass original pathspec, to be re-parsed */
> +		if (!*pathspec->items[i].original) {
> +			/*
> +			 * work around a misfeature in parse_pathspecs()
> +			 * that munges "." into "".
> +			 */
> +			argv_array_push(&argv, ".");
> +			continue;
> +		}
>  		argv_array_push(&argv, pathspec->items[i].original);
> +	}
>  
>  	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
>  	argv_array_clear(&argv);
> @@ -180,7 +189,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
>  {
>  	struct pathspec pathspec;
>  
> -	parse_pathspec(&pathspec, 0,
> +	parse_pathspec(&pathspec, 0,
>  		       PATHSPEC_PREFER_FULL |
>  		       PATHSPEC_SYMLINK_LEADING_PATH |
>  		       PATHSPEC_PREFIX_ORIGIN,
