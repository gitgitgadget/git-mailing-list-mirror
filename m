Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B38A1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFEU5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:57:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50048 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfFEU5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:57:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48E236392E;
        Wed,  5 Jun 2019 16:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Do9sNDZw3vdaTG4f/4fnjx47Ahc=; b=xjkAB+
        +wq9sf9EPjfs6fn5Ouzt36Ir0oRhLafCLj1efaSYU3y9XVWL7umcQuZhg0ZDWweA
        uA8LS0DJ1c3wKFu/hxdm/Sl2xOt1z/aDi+y7MFZfrwzAskuwzMnBRIz1U6zkX1Wq
        JBaQGmHBnrX/34soQNQ6ltkpGxkOHvMH7HFJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PYpnUgBzinTFtHyUvR1HPGRmM8v4IOVU
        fxgsBGZgwyc1B/MNjbxEQwFeUmN54xhsfZU0GC5YowxbidqGiujxvZDrbKmf6jIF
        Uwr0Yq86h3zFVyblS1o5fu3/8Yad9Vh7b8a7gVgSNEWsC4K89EJVGz8buwcjegch
        o4SDP628fPA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 432BB6392D;
        Wed,  5 Jun 2019 16:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 719956392A;
        Wed,  5 Jun 2019 16:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mkrtchyan\, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags be GPG-signed
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de>
        <20190605155300.26506-1-tigran.mkrtchyan@desy.de>
        <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com>
        <1933659713.10490718.1559765529240.JavaMail.zimbra@desy.de>
        <xmqqblzbsquq.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 05 Jun 2019 13:57:34 -0700
In-Reply-To: <xmqqblzbsquq.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Jun 2019 13:46:05 -0700")
Message-ID: <xmqqzhmvrbr5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C19653A-87D4-11E9-BB45-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de> writes:
>
>>> But more importantly, I think we should justify why this "not
>>> allowed" makes sense as the design of the feature. A plausible
>>> alternative design would simply follow the "last one wins" paradigm,
>>> ...
>> This is matter of convention.
>
> Oh, if you put it that way, it is quite clear that we should redo
> this part, as the rest of Git command line processing all pretty
> much follow "last one wins".  I was mostly curious if there was any
> strong reason why this combination has to be different.

One reason why "last one wins" aka "you have a chance to correct
yourself" is so useful is because people can then use alias to
define leading options, e.g. with

    [alias] myfoo = foo --option1 --option2 --option3

a user can say "git myfoo" to save typing, but in a rare occasion
where only options 2 and 3 (but not option 1) are desired, can use
"git myfoo --no-option1" to countermand it.

Unfortunately, I do not think we can use the same technique for
options that is given to the "git" potty, e.g. with

    [alias] paged-status = --paginate status

you can say "git paged-status" to have your "git status" output sent
to the pager, but you cannot say "git paged-status --no-pager" to
defeat that leading option.  We may want to find a way to correct
it, but it is rather low on the priority scale ;-)


