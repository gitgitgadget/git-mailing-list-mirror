Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016571F462
	for <e@80x24.org>; Fri, 31 May 2019 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfEaS46 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:56:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54658 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfEaS45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 14:56:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7298D140BFF;
        Fri, 31 May 2019 14:56:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yBmIA/99NHHxpHvUF5NZz0Glils=; b=aRZa3B
        0XXS5JBql++aEMPL/qYjmbRWfE6LSLmaOnJxBW1O+35D6JM1fr11HaCRy3hU/mE3
        9tYln9mjQzSaWGmOIvuL/A+g3uVWv6jOi76G9IqCwv1R25uG6f0idRdqnyDEn9Ej
        U7nBorsvlWE/RfLRSXp+kNjtzg89HJr+Jnvfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=suDWqs8F3/rCSyyO671ZYeCSI9bmebjZ
        Hg4/BlT1/O5+T3AICKApPe1HFkGhYh3pY6pBwTnOIQ2MODnRWxqjVJaNCaXrsOIj
        hs7B3hb9yH3+kxWq9WtUIvz6kyFtmBFh2qH5w0XdT+GlidUHUm0f8snzcPbpUW6K
        yqlsZ3/jqAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AE7D140BFE;
        Fri, 31 May 2019 14:56:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0F10140BFD;
        Fri, 31 May 2019 14:56:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet>
Date:   Fri, 31 May 2019 11:56:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1905311346170.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 31 May 2019 14:42:30 +0200 (CEST)")
Message-ID: <xmqqwoi6v4ei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBB3158A-83D5-11E9-8E02-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * cc/list-objects-filter-wo-sparse-path (2019-05-29) 1 commit
>>   (merged to 'next' on 2019-05-30 at 5a294203ad)
>>  + list-objects-filter: disable 'sparse:path' filters
>>
>>  Disable "--filter=sparse:path=<path>" that would allow reading from
>>  paths on the filesystem.
>>
>>  Will cook in 'next'.
>
> Not sure whether we want to fast-track this into v2.22.0. There is a risk.
>
> But then, the longer we ship with `--filter=sparse:path` *enabled*, the
> more we invite users to actually try and use it.

This one I wasn't quite decided on, for exactly the same reason why
you said "Not sure".  I am inclined to merge it to 'master' at this
point, as it indeed is a risk to keep it enabled.

The only remaining question it raises is if it makes it worthwhile
to add another rc; it introduces one new localizable string, too.

Thanks.
