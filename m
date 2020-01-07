Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C0C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976D42081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OLKMY1k7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgAGQeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:34:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59552 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgAGQeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:34:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35232964C5;
        Tue,  7 Jan 2020 11:34:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tUoW6XAAuQ7nUrogyDCPez2sBPw=; b=OLKMY1
        k7h+PP8K6pAkpypepQG2twhZ4xc0+GpUcHl/nIvAWvG/EWKykcG7jXDfRDs+f0DQ
        Ssw+znV4jid/JcotKheVmnDqJ2iEdONvoN9AOy7ikMHG9Fx/YgVdvgDI04tsZqn7
        1taGhcZKc6JOEYOrsIm5OqIDwpNIBG/LGFuBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kMp8mkr+uwoeLkDp4RLzDMyodpCysXv6
        vPdv3LQ9unkrv71NGEfjMWIRu87qkJtWOOBRvrn128/reWgLRWHaeY8rygXOg6GA
        4AVKtwhvcf3WANYNJ+lWkwc5C3ScLB6YcV6Bj06LkjeYpbWFIbL2jwzDHc5wJQv/
        EL2gBnsKLnA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D290964C4;
        Tue,  7 Jan 2020 11:34:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52674964C2;
        Tue,  7 Jan 2020 11:34:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different branch before deleting
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
        <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
        <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
        <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
Date:   Tue, 07 Jan 2020 08:34:04 -0800
In-Reply-To: <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 7 Jan 2020 06:16:17 -0500")
Message-ID: <xmqqh8176xab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85C162F0-316B-11EA-B716-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

[jc: skipped all the good suggestions I agree with]

>> +                                       }
>> +                                       else {
>> +                                               advise(_("The branch you are trying to delete is checked "
>> +                                                       "out on another worktree, run the following command "
>> +                                                       "to checkout a different branch then try again:\n"
>> +                                                       "git -C %s switch <branch>"), wt->path);
>
> I like the use of -C here because it makes the command self-contained,
> however, I also worry because wt->path is an absolute path, thus
> likely to be quite lengthy, which means that the important part of the
> example command (the "switch <branch>") can get pushed quite far away,
> thus is more easily overlooked by the reader. I wonder if it would
> make more sense to show the 'cd' command explicitly, although doing so
> ties the example to a particular shell, which may be a downside.
>
>     cd %s
>     git switch <different-branch>
>     cd -
>     git branch -%c <this-branch>

Note that wt->path may have special characters that would need to be
protected from the user's shell (worse, the quoting convention may
be different depending on which shell is in use).  That is one of
the reasons why I would suggest to stay away from giving an advice
that pretends to be cut-and-paste-able without being so.  In this
case, <different-branch> and <this-branch> must be filled by the
user anyway, and the only thing worth cutting-and-pasting is the
path to the other worktree, not the "git -C" or "cd" that users
should be able to come up with.

	"The branch is checked out on another worktree at\n"
	"path '%s'\n"
	"and cannot be deleted.  Go there, check out some other\n"
	"branch and try again."

or something like that, perhaps?  

> (It is rather verbose and ugly, though.)

I tend to agree.  It also feels to me that it is giving too much
hand-holding, but after all advise() may turning out to be about
giving that.

