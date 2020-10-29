Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC285C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814EF206CB
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uodVoWpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgJ2R1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:27:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63213 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJ2R1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 13:27:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68520101BAB;
        Thu, 29 Oct 2020 13:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Hv2WVPKTbiE64pV2sUH5mdDKA8=; b=uodVoW
        pVv9bSrT153+WOTi92zYOsQK8ZWeyFMmr2tDAI3BCmWs63cIKPuBNx89W9EuMPUN
        cOJLDdN15b8DcM47RUdQKF/nCv5U352kSR1K6oEAfiFHU5RwvzpCGo4tFeV5W7cx
        Q3oaqETnAuh1UNdTRMgsKfe923NydwwMxtCB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JOu6wy/TAfRXjTGDp3314bbEYJKwWopC
        1xzsojCNOksdwou0mEgn41DPqcIZO6rQNhBHjUmlOsPk4IyM33JJ2yaOnAFu/SZv
        9XHK2jnUFh4kKYjvKCqdK8Rt0RRV/kdFCJJDKImq0Zh7+j/sQ0BACYAIvJPye+X9
        oQ43Q/UkpLM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 613ED101BAA;
        Thu, 29 Oct 2020 13:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA017101BA9;
        Thu, 29 Oct 2020 13:27:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
        <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
        <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
        <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
        <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
        <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
        <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
        <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
        <xmqqeelh7y23.fsf@gitster.c.googlers.com>
Date:   Thu, 29 Oct 2020 10:27:26 -0700
In-Reply-To: <xmqqeelh7y23.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 29 Oct 2020 10:16:04 -0700")
Message-ID: <xmqq361x7xj5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04C876EA-1A0C-11EB-A020-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On zsh the situation is different; zsh by default has a git completion
>> (/usr/share/zsh/functions/Completion/Unix/_git), and some might argue
>> it's more complete than git's zsh completion,
>
> How is that completion script developed, maintained and distributed?
>
> By "by default" I believe you mean that it gets installed when you
> install zsh automatically.  Is the situation different on macOS land
> (which I can believe, unfortunately)?
> ...

Web searching for "zsh git autocompletion" gave a few interesting insights.

 - https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
   was the first hit, which is about how to use what we ship in contrib/

 - https://stackoverflow.com/questions/24513873/ which was near the top
   had these gems.

      https://stackoverflow.com/a/58517668
      Actually, ZSH does know how to do git completion out of the box, but
      you need to turn on the completion feature itself (which from the
      steps you described I guess you haven't done)

   and

      https://stackoverflow.com/a/63894520
      Turns out the problem for me wass that when installing git via
      homebrew, git installs its own zsh shell extension which is
      considerably less complete/capable than the default that
      oh-my-szh installs. Find out what versions your git install is
      and then remove the zsh autocompletions. Mine were here and
      deleted thusly:

	rm -rf /usr/local/Cellar/git/2.28.0/share/zsh/

The "knows out of the box" in https://stackoverflow.com/a/58517668
is matches your "zsh by default has".

> so why would
> distribution maintainers chose the one in 'contrib' (an unofficial
> contributed script) over the official one? Indeed they don't, at least
> on Arch Linux.

You're right.  They would certainly not, and the situation is quite
different from bash completion where we seem to be the authoritative
implementation.

This leads me in a totally different direction.

We are making life worse for the zsh users by shipping our own
version, aren't we?  If we didn't ship our own completion script for
them, the user did not have to remove the one "which is considerably
less complete/capable".  Perhaps we are misleading users with our
version that has an implicit "came from those who know Git the best
in the world" label that gives it more authenticity than it
deserves.  A good zsh autocompletion would need to be written and
reviewed by those who know zsh completion well.  They also need to
know Git somewhat, but the expertise on the former would be a lot
more important, I would think.

But as you said in
<CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>

    The answer is obvious: the set of zsh users and the set of git
    developers don't overlap.

this community is not equipped to give good reviews and improvement
suggestions on zsh matters to your patches.  And I do not have a
feeling that the situation would change soon.

Do your recent 29-patch improvements not just fill the "gap" but
surpass the one that comes by default with zsh?  I have this nagging
feeling that the effort to make the autocompletion better for Git
users who use zsh may be better made by you ("git blame" tells me that
you seem to be the only one who's invested heavily in the script,
unfortunately) joining forces with those who develop and maintain the
autocompletion that comes by default with zsh.  We may also want to
have a tombstone in contrib/completion/ to redirect the users to the
default version and away from our "less complete/capable" one.

Thanks.
