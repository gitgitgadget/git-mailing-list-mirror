Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2887B2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbdGZV4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 17:56:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52584 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdGZV4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 17:56:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 775FF962B3;
        Wed, 26 Jul 2017 17:56:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YvUOEjdwBGFrvX4u++bWNCytXA8=; b=SKuG4r
        J02OURSzK9SLOzCTYA1G2ttChN+K0RVh32sQD9x/F6HajgLiUGay91OLM5C+2Wi0
        Y/12OiPj9yV9v7VvmfV9m/w1FIFyKmUxoOEjr0oeJoDkYEmYf6Gja7DHSReaIsCF
        YPwmXwa7Nb5CkMONEToocIaPO+/XIotlTSOCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dth0Wnlo653UDhjjxdwCJ3g5RcuyhBB6
        INJl53fDBVjw2INqX77c9gAiuFJQVFGnitdKvD9+T6kTBV3r982Y/l0TIq72v4QQ
        SHL4nwi93bRmLOo+kPpUzYVTkR++rMqIK6xpCNweJ0YTzMA9enWO6ut3z1sg+cQ6
        Tn2jOPu3kPU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DC30962B2;
        Wed, 26 Jul 2017 17:56:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCBA7962B1;
        Wed, 26 Jul 2017 17:56:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
        <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 26 Jul 2017 14:56:40 -0700
In-Reply-To: <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Jul 2017 11:21:17 -0700")
Message-ID: <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ED2348E-724D-11E7-A0E3-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood@talktalk.net> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> These patches add an '--autostage' option (and corresponding config
>> variable) to 'rebase --continue' that will stage any unstaged changes
>> before continuing. This saves the user having to type 'git add' before
>> running 'git rebase --continue'.
>
> I wonder if this interacts with existing rerere.autoupdate
> configuration variable and if so how (i.e. would they conflict and
> fight with each other?  would they work well together?  would one of
> them make the other unnecessary?).  In any case, they look closely
> related and perhaps should be named similarly.
>
> I even have a suspicion that they may be essentially doing the same
> thing.
>
> For a previous discussion, you start from here:
>
>   https://public-inbox.org/git/7vej6xb4lr.fsf@gitster.siamese.dyndns.org/#t
>
> and for the context, look at the original post by Ingo, to which the
> above message is a response to.
>
> Thanks.

Hmph, this is interesting.

"git rebase" does take "--rerere-autoupdate" option from the command
line, and propagates it to a later invocation of "rebase --continue"
by storing the value to $state_dir/allow_rerere_autoupdate file and
reading the value from it.  $allow_rerere_autoupdate shell variable
is used to hold the setting.  

I'd expect that this variable to be used in invocations of "git am"
in git-rebase--am.sh; but that does not seem to be the case.  I
wonder if this was once working but over time we broke the feature
without anybody noticing it, or if the support was added but not
completed and the feature was a no-op from the beginning?









