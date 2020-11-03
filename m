Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81612C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFED21D91
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W9q9ulAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCRzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:55:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59409 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCRzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:55:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13FA399E50;
        Tue,  3 Nov 2020 12:55:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O30ziVxO1wVUnuanRrGkLMC9+lE=; b=W9q9ul
        AuzOSss3stQuZ0rK6JUJH6yYVIYF0A7VMymXPSK7rQJE9+oS3W+zwfqPc2T/ZNW5
        vQ77oaHOp0YWca+vLrRD6G/DjNkFMTYOezBIgoxnTJgogYRbXitPiwoQZ0XWC+uK
        TeM+6fhsw5yqMhEcV+lYFB9OU36F8yCEqj0IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HvAMUGHZZODvUJUcWY48HruAieEhW2sP
        nHfhc18QFG2fWZNGjpMwHx4Db4SpKGm/P3slk2U7QQbtPDd4tdlDJzsm0JCTv8Kx
        zUf2cYmB79vHVHUUS2wq5QeH1VAM0t11KGI66iZmWeci4cDYqGNvPPp8Z7SUuni/
        9hhzxwrr+Js=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C447999E4E;
        Tue,  3 Nov 2020 12:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BE6A99E4D;
        Tue,  3 Nov 2020 12:55:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201026175742.33356-1-sangunb09@gmail.com>
        <CAHjREB7W2P9_P4LoMHVVzV_YR5-_51zdbRZ0fpEDVkgkd7sh8w@mail.gmail.com>
Date:   Tue, 03 Nov 2020 09:55:05 -0800
In-Reply-To: <CAHjREB7W2P9_P4LoMHVVzV_YR5-_51zdbRZ0fpEDVkgkd7sh8w@mail.gmail.com>
        (Sangeeta's message of "Tue, 3 Nov 2020 16:16:49 +0530")
Message-ID: <xmqqblges4ue.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B558A88C-1DFD-11EB-B17A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta <sangunb09@gmail.com> writes:

> Hey Johannes and Junio,
>
> In continuation of the discussion from here[1]
>
> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011020251520.18437@tvgsbejvaqbjf.bet/
>
>> >> * sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
>> >>  - diff: do not show submodule with untracked files as "-dirty"
>> >>
>> >>  "git diff" showed a submodule working tree with untracked cruft as
>> >>  "Submodule commit <objectname>-dirty", but a natural expectation is
>> >>  that the "-dirty" indicator would align with "git describe --dirty",
>> >>  which does not consider having untracked files in the working tree
>> >>  as source of dirtiness.  The inconsistency has been fixed.
>> >>
>> >>  Needs doc update.
>
> Do I need to add the doc update in the same patch?

It is ideal if code change, tests and documentation are done
atomically.  For a large series the story may be different, but I
thought a single commit would be sufficient for this topic?

>> > I *think* the original rationale for marking submodules with untracked
>> > (_un-ignored_) files was to avoid deleting a submodule that has
>> > uncommitted (because untracked) files.
>>
>> I agree with you that that the motivation was exactly that, but I
>> have a suspicion that its execution was misguided.
>
> I am really very sorry if I ended up adding some unwanted code.

But you did not.  The "motivation" and "execution" are both from
long time ago, back when submodule support was invented and "git
diff" in the superproject was taught to pay attention to submodules.

Dscho suspects that "git diff" were taught to add "-dirty" to
submodules with untracked files in their working tree in order to
protect them from those who are about to delete them as a way to
check if it is safe.  I agreed that the motivation may have been so,
i.e. they wanted to protect users from losing untracked files that
they forgot to add and commit in the submodule, but the execution
was wrong, i.e. "git diff" is not the right tool to achieve that
protection.

See that you didn't add any unwanted code---it all happened long
time ago ;-)

> So we want that `git status` should behave in the same way as it was
> behaving before? Can we do this by passing --ignore-submodules=none as
> the default args for status?

Yes, I do not recall offhand where in wt-status.c "git status" does so,
but there should be an internal invocation of diff-files somewhere, and
I suspect it is not passing any --ignore-submodules bit.  Just like
wt_status_collect_changes_index() calls handle_ignore_submodules_arg()
with hardcoded "dirty", we may have to unignore untracked files in
submodule working trees when checking the working tree changes.

> Another approach might be to figure out
> how the diff is being called(like is this being called from git status
> or git diff) and then add the --ignore-submodules=untracked behavior
> to it accordingly. Though I have no idea how to do that now.

No, callee shouldn't have knowledge of its caller to perform a
special case action.  The caller should say how it wants its callees
to behave.

Thanks.
