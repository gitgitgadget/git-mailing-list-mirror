Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27096C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E188822449
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TY2k6g/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKTDD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:03:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57659 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfKTDD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:03:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9F9B96EBB;
        Tue, 19 Nov 2019 22:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7b7yP3hnaLYG1ibpp2Twtp9mXKs=; b=TY2k6g
        /ZVybD+EI8P2rmfvOxEGtY2UZrfMzYsboZNrLZR4vIuKqBhgqJwod/5RXRH14BcC
        RMhZK6zXOWwVi99Z8sodKwgMjnL5jh0URTsmCr37Qkk3XReeBzseJ9MVbV/jdSj6
        GfV+zngVGLrOjAbgcMMQ7JqErwH/FRueE6sto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jC+wwT0D+Lb2s+t58SLI0Nn0oeo/dKjC
        YBCt7bYW8OMCabDa3pgdXv8IIJaezmRriczyBE+RuKxnEz4VESsmAkiammYk//Wa
        uyH4qLzFRA1QuoS1X/7DiM609OD8tyZBP+gEzBZ4E7onCM45rYd7mtf+CnrVuppN
        0Q+5HsOLrOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E21E096EBA;
        Tue, 19 Nov 2019 22:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06C8996EB9;
        Tue, 19 Nov 2019 22:03:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     alban.gruin@gmail.com, git@vger.kernel.org,
        phillip.wood123@gmail.com
Subject: Re: ag/sequencer-todo-updates , was Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
References: <3e616116-2f6f-acff-91b3-4aefc7e62653@gmail.com>
        <20191119204146.168001-1-jonathantanmy@google.com>
Date:   Wed, 20 Nov 2019 12:03:51 +0900
In-Reply-To: <20191119204146.168001-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 19 Nov 2019 12:41:46 -0800")
Message-ID: <xmqqv9rfckq0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62BC3D7E-0B42-11EA-9A32-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > * ag/sequencer-todo-updates (2019-10-28) 6 commits
>> >  - SQUASH??? tentative leakfix
>> >  - sequencer: directly call pick_commits() from complete_action()
>> >  - rebase: fill `squash_onto' in get_replay_opts()
>> >  - sequencer: move the code writing total_nr on the disk to a new function
>> >  - sequencer: update `done_nr' when skipping commands in a todo list
>> >  - sequencer: update `total_nr' when adding an item to a todo list
>> > 
>> >  Reduce unnecessary reading of state variables back from the disk
>> >  during sequener operation.
>> > 
>> >  Is the leakfix patch at the tip the only thing that needs to
>> >  prepare the topic ready for 'next'?
>> > 
>> 
>> Yes, it is.
>
> I took a look at this. Some comments:

I took a look at your comments and re-read the patches and I do
agree with many of your points.

Let me not merge this round to 'next' and wait for a reroll.

Thanks for stopping me.
