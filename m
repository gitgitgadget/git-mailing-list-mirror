Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A14E1F461
	for <e@80x24.org>; Sun, 19 May 2019 01:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfESBop (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 21:44:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58306 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfESBop (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 21:44:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FB1562AFC;
        Sat, 18 May 2019 21:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0XS1yoaRzPEOTszldElToktdAUI=; b=u4FlTB
        OshJVP49jKIY0Ij6eP/ASMYbPSLAYxj8Hq65jy0JBhV/Jpnc7Owq/zYdPZv5hdxi
        +H4LeeoG7ENu6QdkQPCEAFnrkNn1N1k7vJi+FuHKjI5SNDc0h5TTfJ3ptURhavmJ
        f2dAXErMrKOXHfatnn59nn83AeGkxuYVDJtz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=whokdxd2+tkYZCjwvFCw3jB5gMEFnzjG
        LsDqwFwqTQVgE2CUN7kcHnFpAGwtvWxfVGKaUUtGHKaAQsjAXjbHMp2C1fUTF2bw
        fjihFYFuy/SqFCAjm2gRdLFWxQ0z6nBE1GBx9ZjYJyy7FR8m9XHUspQgyQpDjhFy
        WHkM7gsYSk4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56F0A62AFB;
        Sat, 18 May 2019 21:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8560762AFA;
        Sat, 18 May 2019 21:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/difftool-no-index, was Re: What's cooking in git.git (May 2019, #02; Tue, 14)
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet>
        <xmqqef508q0y.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905151015540.44@tvgsbejvaqbjf.bet>
        <xmqqsgtg5cff.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905172025450.46@tvgsbejvaqbjf.bet>
Date:   Sun, 19 May 2019 10:44:38 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905172025450.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 17 May 2019 20:27:30 +0200 (DST)")
Message-ID: <xmqqsgtb1am1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB041B80-79D7-11E9-B816-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 15 May 2019, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> I was imagining what would happen if we treat _everything_ in the two
>> directories being compared by "difftool --dir-diff --no-index" as if it
>> is tracked.
>
> Isn't this exactly what `git difftool --no-index` *without* `--dir-diff`
> does already (although without copying or hardlinking or symlinking any
> files)?

If that is the case, then I would imagine that running that command
for the user, instead of refusing to work, would give a more
pleasant end-user experience.  No?

Unless we anticipate that we might dwim incorrectly and mistake a
request to compare two things, to which the distinction between
tracked and untracked matters, as a request to compare two
directories that are not under Git control, that is.  If such an
incorrect dwim were a possibility, then it is helpful to refuse with
"when comparing two non-git-controlled directories, you cannot use
the '--dir-diff' mode", as that would not silently give an incorrect
output to the users.

In any case, all of the above can be left for future improvements.
Getting close to the final, I think it is preferrable to have a
"refuse to stop early" (i.e. the patch that is already in 'next')
instead of "do what the user meant" whose implementation may become
more involved (and error prone).

Thanks.

