Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DEDC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD2E206FA
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i71E5Dhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbgFXPiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:38:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57737 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404190AbgFXPiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:38:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B82AC8AFD;
        Wed, 24 Jun 2020 11:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zutgqS3liobPdi/GDNOQhsnFeOQ=; b=i71E5D
        hhJDIfWap1SjpGQilZSp7mu2gq/yHssUDbDFJ7PeCenjTllk23myKHN6VKN4AySb
        sMhUM/mo1rbImWB7cOr7rsA6bWFBoiBbK0g56tVR8cRKgyhxsgntU9RqI9hLjJUG
        gb5UkNwWlNbkblYpOUSaYEY9c5xuhbG8UKIm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gZ61kvAyo/m1/uAS+9fawOvjh/85HYi2
        NqD6lRBgGghDCTu80fMaMIMH6aHgBfHNariLTfxAmrjf9DCcVU4R5ypHFwFz/gX1
        nrzSUj7A9dNDYH8WxOUE/RvP+ZrHVhBqPlANxM05k81qXPO4VqvLXW0SYDtzOpef
        goph+oVG6+0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53F06C8AFC;
        Wed, 24 Jun 2020 11:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 924A4C8AFB;
        Wed, 24 Jun 2020 11:38:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 08:38:01 -0700
In-Reply-To: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 24 Jun 2020 14:48:37
        +0000")
Message-ID: <xmqqtuz08ofa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B137CE3E-B630-11EA-9866-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v1:
>
>  * Rebased onto master (no conflicts, so it is safe, and it is more robust
>    than basing the patches on seen which already contains v1 of these
>    patches).

Thanks, I actually wanted to include it in 'maint', so I'll queue on
the same base (no conflicts, so it is safe, and it will be in a
maintenance release if we are going to issue one).

>  * Adjusted the quoting to match 
>    https://lore.kernel.org/git/e250f1bb100aca94c914f1b2d38a3849c2566aea.1592909867.git.liu.denton@gmail.com/

I know I mentioned it and I think the patch to SubmittingPatches
does improve by doing `seen` because it matches the way how the
nearby `git pull --rebase` is quoted.

But I am not sure about the patch to gitworkflows.txt, where the
text around the new `seen` mention 'master' and 'next'.  I think
your v1 was more (locally) consistent.

I am on the fence to the change to giteveryday.txt, where `pu` got
changed to `seen`; your v1 had "(patches seen by the maintainer)" as
an explanation after the `seen`.  I guess it is inconsistent to
explain only why `seen` is `seen` without doing the same for `next`,
so I would say v2 is an improvement over v1.

In short,

>  1:  dc6f971290 ! 1:  35e3dafd6a docs: adjust for the recent rename of `pu` to `seen`
>      @@ Documentation/SubmittingPatches: their trees themselves.
>          patches, and will let you know. This works only if you rebase on top
>          of the branch in which your patch has been merged (i.e. it will not
>       -  tell you if your patch is merged in pu if you rebase on top of
>      -+  tell you if your patch is merged in 'seen' if you rebase on top of
>      ++  tell you if your patch is merged in `seen` if you rebase on top of
>          master).

Good.

>        * Read the Git mailing list, the maintainer regularly posts messages
>      @@ Documentation/giteveryday.txt: $ git push --follow-tags ko <13>
>        <2> see which branches haven't been merged into `master` yet.
>        Likewise for any other integration branches e.g. `maint`, `next`
>       -and `pu` (potential updates).
>      -+and `seen` (patches seen by the maintainer).
>      ++and `seen`.

Probably good.

>        <3> read mails, save ones that are applicable, and save others
>        that are not quite ready (other mail readers are available).
>        <4> apply them, interactively, with your sign-offs.
>      @@ Documentation/gitworkflows.txt: As a given feature goes from experimental to sta
>       -* 'pu' (proposed updates) is an integration branch for things that are
>       -  not quite ready for inclusion yet (see "Integration Branches"
>       -  below).
>      -+* 'seen' (patches seen by the maintainer) is an integration branch for
>      ++* `seen` (patches seen by the maintainer) is an integration branch for

Not---'seen' was more consistent relative to the surrounding text.

Thanks.
