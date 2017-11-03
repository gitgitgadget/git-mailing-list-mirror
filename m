Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED3A20281
	for <e@80x24.org>; Fri,  3 Nov 2017 01:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934687AbdKCBql (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 21:46:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932285AbdKCBqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 21:46:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5653CBF50F;
        Thu,  2 Nov 2017 21:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7dZXId7bl+5HH+D0daOg+jCEKoY=; b=DDNV4S
        MNPL7z921V1K4/2wdyM/4PrK41MD80voSWqUyRK7Knfd+Kz9QG9YurFnktTSG4a5
        dWhWw3kpVytQt75hu9WSyJERsMf6gRCr/GnVXpmeRAHfqi8giP1xTI/AFuH+GuOj
        BBMB6EGP2m8QcjFQjLtQkXC00fF7NAe94bXqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XAR9oZD6gIb6oruaYcRWidg+KPO9YOax
        xgMbRJfHclwNMKTpjNa+b/mkkquXS8Cm0AJj487QjIxZVyQuZZ98q+suN8jzMzLl
        1tHhZwPJRwgpgTMtA0tk4ML+ZxSxVVwJCa8CQ2nZy2K1O5+sv9GKmskkDdVi+1bk
        KtgZaXGI6FQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EC5FBF50E;
        Thu,  2 Nov 2017 21:46:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1EB7BF50D;
        Thu,  2 Nov 2017 21:46:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCHv3 0/7] git describe blob
References: <20171031211852.13001-1-sbeller@google.com>
        <20171102194148.2124-1-sbeller@google.com>
        <CA+P7+xr0owJt4qvWeNkWhEionJ4468h0pTdB+h-FrEaBqi375w@mail.gmail.com>
Date:   Fri, 03 Nov 2017 10:46:37 +0900
In-Reply-To: <CA+P7+xr0owJt4qvWeNkWhEionJ4468h0pTdB+h-FrEaBqi375w@mail.gmail.com>
        (Jacob Keller's message of "Thu, 2 Nov 2017 17:23:51 -0700")
Message-ID: <xmqq8tfoqgle.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5581EA4-C038-11E7-914C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I agree, "something" is better than "nothing", and we can work to
> improve "something" in the future, especially after we get more real
> use and see what people think. Only question would be how much do we
> need to document the current behavior might be open for improvement?

If 

 - it always digs to the root of the history no matter what; and/or
 - it almost always yields correct but suboptimal result

then that fact must be documented in BUGS section, possibly a brief
descrition of why that limitation is there, with a hint to invite
people to look into fixing it.

We should mark it prominently as experimental and advertise it as
such.  "It's too slow in real project to be usable" and "Its output
bases the answer on an irrelevant commit" are not something we want
our users to experience, except for those with inclination to (or
ability and time to) help improve the feature.
