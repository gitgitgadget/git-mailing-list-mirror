Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5374C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbiGNTqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGNTp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:45:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478856BC33
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:45:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79E3B196409;
        Thu, 14 Jul 2022 15:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3exvSjzAr/YmKLhTsfwdJG6pI/2OUE65TScnnQ
        NcilE=; b=ox2qcIFqYfwEB9yaIon8f2Qc2sWkt/UfIG0Qy8mXDEvd+r2PjmPK7U
        L59OgrSt3RkCyYJyN976yw3Uvl/xGVNhjGqW7WJPHGT0krw4wmzg+Pv3DgvsOY9J
        mfO0VIBKIjdAjZ+8mTte/II876j33Xk6jlhBU8kpXbhCMU4YKlu7A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66273196408;
        Thu, 14 Jul 2022 15:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02D55196407;
        Thu, 14 Jul 2022 15:45:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] doc: notes: unify configuration variables definitions
References: <cover.1657819649.git.matheus.bernardino@usp.br>
        <d39e826756e79ce7fe270175ad0d5ae523528af9.1657819649.git.matheus.bernardino@usp.br>
Date:   Thu, 14 Jul 2022 12:45:51 -0700
In-Reply-To: <d39e826756e79ce7fe270175ad0d5ae523528af9.1657819649.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 14 Jul 2022 14:44:04 -0300")
Message-ID: <xmqqzghb4gwg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91E50BCE-03AD-11ED-8383-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

>  	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
> -	section of linkgit:git-notes[1] for more information on each strategy.
> +	section
> +ifdef::git-notes[above]
> +ifndef::git-notes[of linkgit:git-notes[1]]
> +	for more information on each strategy.

This is the first use of the single line ifdef/ifndef in our
Documentation.  I assume you have verified the rendered output on
both AsciiDoc and AsciiDoctor?

> -	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
> -	linkgit:git-notes[1] for more information on the available strategies.
> +	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section
> +ifdef::git-notes[above]
> +ifndef::git-notes[in linkgit:git-notes[1]]
> +	for more information on the available strategies.

Ditto.

>  notes.displayRef::
> -	The (fully qualified) refname from which to show notes when
> -	showing commit messages.  The value of this variable can be set
> -	to a glob, in which case notes from all matching refs will be
> -	shown.  You may also specify this configuration variable
> -	several times.  A warning will be issued for refs that do not
> -	exist, but a glob that does not match any refs is silently
> -	ignored.
> -+
> -This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
> -environment variable, which must be a colon separated list of refs or
> -globs.
> -+
> -The effective value of "core.notesRef" (possibly overridden by
> -GIT_NOTES_REF) is also implicitly added to the list of refs to be
> -displayed.
> +	Which ref (or refs, if a glob or specified more than once), in
> +	addition to the default set by `core.notesRef` or
> +	`GIT_NOTES_REF`, to read notes from when showing commit
> +	messages with the 'git log' family of commands.
> +	This setting can be overridden on the command line or by the
> +	`GIT_NOTES_DISPLAY_REF` environment variable.
> +	See linkgit:git-log[1].

This is unrelated to the "unify description in git-foo.txt and
config/foo.txt in the documentation" topic, isn't it?

I haven't formed an opinion on the updated text, and it makes it
harder to review when the content change is mixed in the "unify
description in two places" topic, so I won't comment on the change
of the contents.  Please split them into two steps (a step with only
content change, and then another step to remove the duplicated one
by making one include the other).  Same comment applies to [2/3].

>  notes.rewrite.<command>::
>  	When rewriting commits with <command> (currently `amend` or
> -	`rebase`) and this variable is set to `true`, Git
> -	automatically copies your notes from the original to the
> -	rewritten commit.  Defaults to `true`, but see
> -	"notes.rewriteRef" below.
> +	`rebase`), if this variable is `false`, git will not copy
> +	notes from the original to the rewritten commit.  Defaults to
> +	`true`.  See also "`notes.rewriteRef`" below.
> ++
> +This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
> +environment variable.

Ditto.

>  notes.rewriteMode::
> -	When copying notes during a rewrite (see the
> -	"notes.rewrite.<command>" option), determines what to do if
> -	the target commit already has a note.  Must be one of
> -	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
> -	Defaults to `concatenate`.
> +	When copying notes during a rewrite, what to do if the target
> +	commit already has a note.  Must be one of `overwrite`,
> +	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
> +	`concatenate`.
>  +
>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>  environment variable.

We are losing the mention of "notes.rewrite.<command>", which is
outside the "unify" topic, isn't it?

>  notes.rewriteRef::
>  	When copying notes during a rewrite, specifies the (fully
> -	qualified) ref whose notes should be copied.  The ref may be a
> -	glob, in which case notes in all matching refs will be copied.
> -	You may also specify this configuration several times.
> +	qualified) ref whose notes should be copied.  May be a glob,
> +	in which case notes in all matching refs will be copied.  You
> +	may also specify this configuration several times.
>  +
>  Does not have a default value; you must configure this variable to
>  enable note rewriting.  Set it to `refs/notes/commits` to enable
>  rewriting for the default commit notes.
>  +
> -This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
> -environment variable, which must be a colon separated list of refs or
> -globs.
> +Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.

Ditto.

Thanks.
