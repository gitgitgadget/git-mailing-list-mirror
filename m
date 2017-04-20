Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E95C1FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 03:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934384AbdDTDX2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 23:23:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54842 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934301AbdDTDX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 23:23:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAE72710BF;
        Wed, 19 Apr 2017 23:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d9KxYMLhUBhBMW3IY8u2gfUzgNk=; b=FpOW6E
        sh7OjZT8PfC69hKG0ArGOxg84wJZrJ278X2yvoiTcULHmYIaOgBcFKDlyI65mX50
        QyF1aZPbTGDFTgiRmBFVWiMgyetHatIu5feKWTYUy8DWUR+yy1AoCEEQeY4ZMQ/6
        tSj62UX6kN1Rh1dhtkS7AZ+fXG5oFxeFtTw6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BxFyT/V82Zk72DPoS+WjjXa705nzTUeY
        PJD4/DY9aVVMq5rxV2tJJAgdE8ygvGUm2OneHK4e+N9I7nztamWwpAnzYU/Y80C6
        zWevU8hYmR2CO0IX2k4YVVIXLu5l0apTYMrQ/LOrBlV+7f/ZySaYnS7Q/IHd+9jz
        wkT/ocb1EWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2CB1710BE;
        Wed, 19 Apr 2017 23:23:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BEA2710BD;
        Wed, 19 Apr 2017 23:23:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v10 0/5] [GSoC] remove_subtree(): reimplement using iterators
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
Date:   Wed, 19 Apr 2017 20:23:24 -0700
In-Reply-To: <1492607652-36341-1-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Wed, 19 Apr 2017 10:14:07 -0300")
Message-ID: <xmqqk26fahjn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6E15B6C-2578-11E7-AA74-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> I do not know if "queuing" meant I did not have to change this series
> any further (specially after Stefan's "ok"), but anyway, this series
> applies Junio's corrections back from v9, that were mostly regarding
> commit messages or style. I hope I got them right.

Queuing merely means that I queued the series on its own topic
branch and merged it to 'pu', which is a bit more (but not much
more) permanent place than the list archive.  It does not mean
anything more---specifically, it does not mean that it is now cast
in stone.  It does not mean it will appear in the next release,
either.

If you and others are happy with the state of the commits recorded,
we may then merge the topic to 'next' and then to 'master'.  But in
the meantime, if there are things that you are not exactly happy in
the series (e.g. you found a better way to approach the issue you
tackled, you noticed that you didn't fully address the review
comments, etc.)  you are welcome to further polish your topic by
sending out replacements.

> The only point I was in doubt was about Michael's signoff. Actually, he
> gave it not regarding the snippet for the new dir_iterator_advance()
> logic, but to a small piece of actual code he wrote on the new dir
> iterator test helper[1].

If part of your patch contains his code more or less verbatim, then
it is the right thing to do to have his sign-off.  For that part you
are relaying his patch, so he signs it off first, signaling that he
wrote it and he has the authority to release it to the project, and
then you sign it off, signaling that you have the authority to relay
it to the project (see DCO in Documentation/SubmittingPatches).

> I also didn't get whether I myself should have renamed t0065 to t0066
> given the other queued patch.

I would have expected you to move it over to t0066, as I'd have to
rename it myself otherwise.  There is no "skipping" of a number in
the result, as this series comes later than the one that adds t0065.

Having said that, there is no need to resend the series if the only
change necessary on top of v10 were renaming t0065 to t0066.

Thanks.
