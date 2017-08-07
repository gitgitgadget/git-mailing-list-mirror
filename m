Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3303A2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbdHGRMS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:12:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64388 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751453AbdHGRMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:12:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A235A06B4;
        Mon,  7 Aug 2017 13:12:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=71PXW8hOhy+pdwBQxQdIrsz6lZM=; b=hA3kAu
        4sgHRcmyya3UTPh2xKHIRIW3kkqi0DSnSDuvvIomVGEo1XRQiOk2+a1YbfGKTKvd
        yAIk9qbUCzm+/m1g333+txSAiOV+7xihOF+GPT/pSSv1nz9q0ma6ppUr3dAa8aYI
        4UlmpoAEfwvJ/MqTfLVzSdN32t1bkIpk7b22M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j6f2bTOXjMSqQ8qnlIvyY8+Hhw9LwRAi
        sJxILQyRu4tAM1S4CuOsiRbWU31HJLQ/FOdrZcBPB/r/5IiYHVqL1Nz1YmkA/STN
        eV7iW5g5Ht6QtVGs+1mrE8TRtUhxTKfQk27JE7oOr7/Dyi5T7KTmUCFU22I6bOtS
        dKbk5O4czHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DF49A06B3;
        Mon,  7 Aug 2017 13:12:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B80C3A06B2;
        Mon,  7 Aug 2017 13:12:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
        <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 07 Aug 2017 10:12:14 -0700
In-Reply-To: <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 07 Aug 2017 09:35:55 -0700")
Message-ID: <xmqqo9rrqp3l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F994C56-7B93-11E7-8396-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Earlier there was a more ambitious proposal to remove all "git-foo"
> even from $GIT_EXEC_PATH for built-in commands, but that plan was
> scuttled [*1*].
>
> The changes in your patch still are good changes to make sure people
> who copy & paste code would see fewer instances of "git-foo", but
> "will still work even if I break my installation of Git by removing
> them from the filesystem" is not the project's goal.  
>
> IIUC, you will need "$GIT_EXEC_PATH/git-checkout" on the filesystem
> if you want your "git co" alias to work, as we spawn built-in as a
> dashed external.

Just to avoid possible confusion, the above is not to say "once it
is decided, you are not allowed to bring fresh arguments to the
discussion".  As Peff said [*2*] in that old discussion thread, the
circumstances may have changed over 9 years, and it may benefit to
revisit some old decisions.

So in that sense, I do not mind somebody makes a fresh proposal,
which would probably be similar to what I did back then in [*3*],
which is at the beginning of that old thread.  But I do not think I
would be doing so myself, and I suspect that I would not be very
supportive for such a proposal, because my gut feeling is that the
upside is not big enough compared to downsides.

The obvious upside is that you do not have to have many built-in
commands on the filesystem, either as a hardlink, a copy, or a
symbolic link.  But we will be breaking people's scripts by breaking
the 11-year old promise that we will keep their "git-foo" working as
long as they prepend $GIT_EXEC_PATH to their $PATH we we did so.
Another downside is that we now will expose which subcommands are
built-in and which are not, which is unnecessarily implementation
detail we'd want end-users to rely on.

The "'git co' may stop working" I mentioned in my previous message
is not counted as a downside---if the upside is large enough, I
think that "we respawn git-foo as dashed built-in when running an
alias that expands to 'foo'" can be fixed to respawn "git foo"
instead of "git-foo".  But there may be other downside that we may
not be able to fix, and I suspect that "we'd be breaking the 11-year
old promise" is something we would not be able to fix.  That is why
I doubt that I would be advocating the removal of "git-foo" from the
filesystem myself.


[References]

*1* https://public-inbox.org/git/alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org/

*2* https://public-inbox.org/git/20080826145719.GB5046@coredump.intra.peff.net/

*3* https://public-inbox.org/git/7vprnzt7d5.fsf@gitster.siamese.dyndns.org/

