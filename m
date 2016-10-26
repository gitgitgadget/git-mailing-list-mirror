Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7812022A
	for <e@80x24.org>; Wed, 26 Oct 2016 18:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbcJZSME (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 14:12:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54087 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934520AbcJZSMD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 14:12:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7C1470E7;
        Wed, 26 Oct 2016 14:12:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H164PRFTezimGjFIRQ6cS5dDag8=; b=XH3bvS
        9a9KThFWD8ng/RlTXmtZ2sU9SrdNjxJ67tHtFJCyouNsmxOai8q9SJCaNBi9coqZ
        dTgh/BLJp79hQ/ZniO0kOo6WqOy1/5QIfEoBnM3Nel/IR1yjtpGGfuwCE/GsDTZ8
        v8WxKU9JNa+pTnGrd1BwZ8jpMgpsidME0wqso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QmkSJelDrRpjeqw33hYvIv89X/X4kNYM
        n+z+dN9y9tc+CG5EQ5Q1XaVYmd6iapJfkNvkzOxUyCwpaEJoGx0UePAURKN/Fwms
        kqjNlXjjZIe2IPxxUFduv7LI37jyguflvtPgD4HmmdNscCfiFCLDfPyocQELgtmb
        YPdCJu7YvJU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50B15470E5;
        Wed, 26 Oct 2016 14:12:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A459470DA;
        Wed, 26 Oct 2016 14:11:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] Documentation/git-diff: document git diff with 3+ commits
References: <CA+P7+xq1i8AtQ7i=1m_n9HTSL10kFUFBn8jvNcB_t_6Rh29u4w@mail.gmail.com>
        <07712c2c94670ca4d91ef78cd7d3602a8d36b0c1.1477472970.git.git@drmicha.warpmail.net>
Date:   Wed, 26 Oct 2016 11:11:52 -0700
In-Reply-To: <07712c2c94670ca4d91ef78cd7d3602a8d36b0c1.1477472970.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 26 Oct 2016 11:11:14 +0200")
Message-ID: <xmqqh97zask7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADA4C3D2-9BA7-11E6-A3EE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> That one is difficult to discover but super useful, so document it:
> Specifying 3 or more commits makes git diff switch to combined diff.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     Note that we have the following now:
> ...
>     'git diff A..B' equivalent to 'git diff A B'
>     in contrast to 'git log A..B' listing commits between M and B only
>     (without the commits between M and A unless they are "in" B).

The standard answer is: 

    Do not use two-dot form with 'git diff', if you find it
    confusing.  Diff is about two endpoints, not about a range
    between two.

The reason why we do not reject can be easily guessed by any
intelligent person when some historical background is given, I
think.

 - In the beginning A...B did not exist.  A..B was the only "range"
   notation.

 - "git log A..B" was in wide use.  Remember, "git log A...B" did
   not exist.

 - People started mistyping "git diff A..B", which looked as if the
   user typed "git diff ^A B" to the internal.

 - Git _could_ have rejected that as a bogus request to diff two
   points, ^A (what is that???) and B, but "What else could the user
   have meant with 'git diff A..B' other than 'git diff A B'?" was
   an argument to favor doing _something_ useful rather than
   erroring out.  Remember, "A...B" did not exist when this
   happened.

So there.  We may want to deprecate "diff A..B" but I personally do
not think it is worth the effort.  There is no substitute for the
current "diff A...B" to allow us to deprecate both at the same time,
which is the required first step if we want to eventually swap their
meaning in a far future version of Git which would have been better
if we had hindsight.  But remember, "A...B" did not exist back then. 

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index bbab35fcaf..2047318a27 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git diff' [options] [<commit>] [--] [<path>...]
>  'git diff' [options] --cached [<commit>] [--] [<path>...]
>  'git diff' [options] <commit> <commit> [--] [<path>...]
> +'git diff' [options] <commit> <commit> <commit> [<commit>...]

Made me wonder "is [<A>...] 0-or-more As or 1-or-more As?".
Don't we allow pathspecs in this case?

>  'git diff' [options] <blob> <blob>
>  'git diff' [options] [--no-index] [--] <path> <path>
>  
> @@ -75,9 +76,16 @@ two blob objects, or changes between two files on disk.
>  	"git diff $(git-merge-base A B) B".  You can omit any one
>  	of <commit>, which has the same effect as using HEAD instead.
>  
> +'git diff' [options] <commit> <commit> <commit> [<commit>...]::
> +
> +	This is to view a combined diff between the first <commit>
> +	and the remaining ones, just like viewing a combined diff
> +	for a merge commit (see below) where the first <commit>
> +	is the merge commit and the remaining ones are the parents.
> +
>  Just in case if you are doing something exotic, it should be
>  noted that all of the <commit> in the above description, except
> -in the last two forms that use ".." notations, can be any
> +in the two forms that use ".." notations, can be any
>  <tree>.
>  
>  For a more complete list of ways to spell <commit>, see
