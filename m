Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A6C2BB40
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4C123E1D
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393012AbgLJS3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 13:29:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58813 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390832AbgLJS3L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 13:29:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C11E91029;
        Thu, 10 Dec 2020 13:28:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Gi3y6aPsG6c5nJdf3VG1nam0II=; b=M9nlm6
        N29CE0qG+dgOGWrSP2rJ0I9F4RhM0TjkfxQUGH7lANPQBeKJF0ztrGPDq50TreJ+
        NJ/QsVFle5Bnf2nAk9TgPe9ZhpxbzkPSDLDuK5rz+s2gMze6wwFbB/AAEO4oEJE+
        P1rfsuJvZaFnjt8V5JSCjpcDXha5PQ7+voQMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gTps7hd4BixcrWDxYmIWuMhZc35dtQhT
        j+GOvIb5XB+bBS0XemX1TeAGSCEbFRu45WHqGlWSuPxKmCY/7R2wFdK4cT3SytTm
        +5T/40BxFMTWUBES9bAL2dds0TLyacvN3jzKisUthGPKcWXwa3Lj/1UQrj6i9Ev+
        22YwRwDnkAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53A0091028;
        Thu, 10 Dec 2020 13:28:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3D5191026;
        Thu, 10 Dec 2020 13:28:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
        <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
        <20201210152715.GQ52960@mit.edu>
Date:   Thu, 10 Dec 2020 10:28:22 -0800
In-Reply-To: <20201210152715.GQ52960@mit.edu> (Theodore Y. Ts'o's message of
        "Thu, 10 Dec 2020 10:27:15 -0500")
Message-ID: <xmqqim99wm61.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CB663EA-3B15-11EB-BA7E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Wed, Dec 09, 2020 at 01:28:48PM -0800, Junio C Hamano wrote:
>> 
>> A spot check: do you have pull.rebase set to anything in your
>> config?
>
> FWIW, I haven't set pull.rebase to anything, but what I have done is
> to simply added --ff-only or --rebase to my "git pull" commands.  I
> type fast, though, so it's not that a big deal, and I like the fact
> that the warning is making me explicitly express what it is that I
> want to have happen.

OK, so I would tone down my optimism that the loud warning we have
been issuing for a long time would be sufficient---the switching of
the default would break people like you.

> It's also true that very often, I end up running "git fetch", then
> look at what I got pulled down, and only then run either "git merge"
> or "git merge --ff-only" or "git rebase" explicitly.

That is very understandable.

"git pull", which is "git fetch" followed by some way to reconcile
two histories, does not have to be the only way to interact with
histories from other people.

It however doesn't give useful input to help us answer the questions
Johannes raised: is it sensible to force users to tell "git pull" if
they want to merge or to rebase explicitly, instead of defaulting to
merge like we currently do?  how much damage are we causing to
existing users who expect the command to work the way it currently
does?

Thanks.
