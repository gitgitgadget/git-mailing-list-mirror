Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA0C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2E261289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 22:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhEFWE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 18:04:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52914 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhEFWE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 18:04:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B71E12BDE9;
        Thu,  6 May 2021 18:03:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vf+e5/BmrhPMOla2lmlPOSsu/KXKOLQ9/mzkFK
        KSIZY=; b=s7WCX8BN0YZTVFveTEIDaGpovTa44xSx5GDDlzDf3L82srS3O1b83Y
        YKROL4e75hP8L8pURyAMwmCD3eVr5Nk3JC4dMNQx7Y83cnKve98ieKuQ8h5fBp1m
        C3FtPWJ6nsYXW4v6Q0lhEZ19UryNNxdtxESGdbpNuwxVvGD4RkqGE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7714212BDE5;
        Thu,  6 May 2021 18:03:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 70C8E12BD82;
        Thu,  6 May 2021 18:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lars Berntzon via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Lars Berntzon <lars.berntzon@cecilia-data.se>,
        Lars Berntzon <lars.berntzon@external.atlascopco.com>
Subject: Re: [PATCH] doc: attempt to clarify a blurry sentence.
References: <pull.1019.git.git.1620319023972.gitgitgadget@gmail.com>
Date:   Fri, 07 May 2021 07:03:52 +0900
In-Reply-To: <pull.1019.git.git.1620319023972.gitgitgadget@gmail.com> (Lars
        Berntzon via GitGitGadget's message of "Thu, 06 May 2021 16:37:03
        +0000")
Message-ID: <xmqqzgx7wmd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2BE2CC0-AEB6-11EB-AAAA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lars Berntzon via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index a953c7c38790..bbb30c52395e 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -66,10 +66,10 @@ it can be any arbitrary "SHA-1 expression", such as `master~4` or
>  The <dst> tells which ref on the remote side is updated with this
>  push. Arbitrary expressions cannot be used here, an actual ref must
>  be named.
> -If `git push [<repository>]` without any `<refspec>` argument is set to
> -update some ref at the destination with `<src>` with
> -`remote.<repository>.push` configuration variable, `:<dst>` part can
> -be omitted--such a push will update a ref that `<src>` normally updates
> +If `git push [<repository>]` without any `<refspec>` argument then
> +git will update the remote ref as defined by `remote.<repository>.push` configuration
> +and it will be updated from HEAD.
> +`:<dst>` part can be omitted--such a push will update a ref that `<src>` normally updates

Hmph, "If X then Git will do Y" expects X to be a full sentence with
subject and verb, but I do not see any verb in 

    `git push [<repository>]` without any `<refspec>` argument

in the rewritten version.

More importantly, the updated description is wrong.  The original
may be hard to follow, but what it is trying to explain is the
following.

Imagine that you have configured

	[remote "origin"]
		push = refs/heads/*:refs/remotes/satellite/*

Imagine further that you have a local branch 'next' and you want to
push it out to the "origin".  You also have other local branches
like 'master' and 'maint', but you do not wish to push them out
right now.

Under such a scenario, if you were to type

    $ git push origin

(i.e. "`git push [<repository>]` without `<refspec>` argument"),
such a command is set to update `refs/remotes/satellite/next`
(i.e. "some ref") at the "origin" (i.e. "the destination") with
`next` (i.e. "with <src>") via the remote.origin.push configuration
variable.  So this scenario satisfies the precondition of the
description we are discussing.

In such a case, you do not have to fully spell out

    $ git push origin next:refs/remotes/satellite/next

in order to push your 'next' branch (which may not be the current
branch) from the command line to its usual/configured destination.

Instead, you can omit ":<dst>", i.e.

    $ git push origin next

and such a push will update the remote ref that would be normally
updated by the local ref named on the command line, i.e. the remote
'refs/remotes/satellite/next' will be updated with your local
'refs/heads/next'.  But your 'master' and 'maint' will not be pushed
to their usual/configured destinations with such a push.

Again, the original may hard to read and it can use some rewriting
to make it easier to read.  Thanks for trying to help by attempting,
and another try with the above information in mind is greatly
appreciated.

