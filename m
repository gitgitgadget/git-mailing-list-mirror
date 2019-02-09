Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09C1211B5
	for <e@80x24.org>; Sat,  9 Feb 2019 06:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBIG1O (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 01:27:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfBIG1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 01:27:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11B841377E0;
        Sat,  9 Feb 2019 01:27:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=/ujQAbpRdjZ+/1A/fXtKw79CtcI=; b=uW8vvde
        ZqNCdOjRN/T57d7cA9EYRdPOjg/N+Nuom0Cnjef91B9MUcYwuRoWf62p6aujybsp
        x+RjTDpGze3NRRr0tbEX4K5jfZ5vCkoKb4XdqSLucG58x0LQyeovaAPNEoSCrOE1
        Ncrpx7I09/768OkP81nY/YaiviHS2W5dmtJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=owPHvQYcEdP9S8JneCFhT77fr7bPD3AHP
        QqXWD67cJ1RUZqRhcS2gd8YW4n71wwdXkLj1nNmoC+QMTnA9sOLc8qwnfp7SRkEt
        K4XO6JPPSUFwLRfRVLv3cxGe6IJEDdJYCXVecDHeOt2Kf0iwNfB39LhLHr2VyBgZ
        J5v/yEZWK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09BA71377DF;
        Sat,  9 Feb 2019 01:27:09 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83BE51377DE;
        Sat,  9 Feb 2019 01:27:08 -0500 (EST)
Date:   Sat, 9 Feb 2019 01:27:06 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Sergey Zolotarev <szolot4rev@gmail.com>
Cc:     git@vger.kernel.org, Keith Smiley <k@keith.so>
Subject: Re: [PATCH] Add support for 'git remote rm' in Bash completion script
Message-ID: <20190209062706.GF30548@zaya.teonanacatl.net>
References: <20190209052434.20616-1-szolot4rev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209052434.20616-1-szolot4rev@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B9EF7672-2C33-11E9-95D6-F733E42159A7-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

There was a previous discussion of this in December 2017,
which might be useful:

https://public-inbox.org/git/01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com/

It didn't end with a patch applied, but it's likely worth
reading to help you make a case for a similar patch.

One of the points in that thread is that the rm subcommand
is not shown in completion intentionally, as the preferred
subcommand is remove.  But it should be possible to offer
completion of the remotes after a user types rm, which I
imagine is the more helpful part of the completion.

Also, you'll want to add a signoff to the patch if/when you
resend it (refer to Documentation/SubmittingPatches, if you
haven't already).

Sergey Zolotarev wrote:
> ---
>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 499e56f83d..fa25d689e2 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2334,7 +2334,7 @@ _git_remote ()
>  {
>  	local subcommands="
>  		add rename remove set-head set-branches
> -		get-url set-url show prune update
> +		get-url set-url show prune rm update
>  		"
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"

So instead of this change you could adjust the subcommand
line, something like:

-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	# Don't advertise rm by including it in subcommands, but complete
+	# remotes if it is used.
+	local subcommand="$(__git_find_on_cmdline "$subcommands rm")"

I haven't test that, but the code looks like it hasn't
changed since the last time we talked about this -- when I
did test the suggestion :).

>  	if [ -z "$subcommand" ]; then
> @@ -2379,6 +2379,9 @@ _git_remote ()
>  	prune,--*)
>  		__gitcomp_builtin remote_prune
>  		;;
> +	rm,--*)
> +		__gitcomp_builtin remote_rm
> +		;;
>  	*)
>  		__gitcomp_nl "$(__git_remotes)"
>  		;;

I don't think you need this chunk, do you?  I think that's
only useful for completing options to the subcommand, which
'git remote rm' lacks.

I believe you can simply skip it and let the case fall
through to the last item which simply completes the
available remotes, just as 'git remote remove' does.

Hope that helps,

-- 
Todd
