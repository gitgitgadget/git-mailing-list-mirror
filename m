Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1021F461
	for <e@80x24.org>; Fri, 19 Jul 2019 16:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfGSQan (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 12:30:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58574 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGSQan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 12:30:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64CD715123B;
        Fri, 19 Jul 2019 12:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FKjIycr5pJm60dZHfd0ex8yMbd8=; b=FKFjC+
        hfTfMZoHBgwPANdL6xT2TSie+UPLnXbFqw8/ioen3/HFnTEFsfUTCdw/eXoXF4qA
        xvLh/hhPo0Q+2tIuTmh5Y89kigZEK0Rm+qC+osHp1/4os5hmP9OkK10kupNKOPD3
        zqW1vMyG0Om7v0EdxieaS6k11ydh1jbFZ6BUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t+HVb5oMUQ8unZSJp3Cz4hVcp9eeuAM4
        7qOtV6LU3Fzn7iEwKhP4Tii3y61EGk220x/ExZvQLpqLLtP30lH9mECU0mC4OGyu
        LK9IzjEpWW56YEhg/CXbcurHRNEwG/dG7BV4kqAvwciK0BKlvYcJpM6sKWlnbSdW
        P0fVyFHhE8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DDAF15123A;
        Fri, 19 Jul 2019 12:30:41 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD45D151238;
        Fri, 19 Jul 2019 12:30:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 23/24] t5505,t5516: create .git/branches/ when needed
References: <pull.287.git.gitgitgadget@gmail.com>
        <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com>
        <xmqqftn3xet7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907191555180.47@tvgsbejvaqbjf.bet>
        <xmqqd0i6vxwt.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Jul 2019 09:30:39 -0700
In-Reply-To: <xmqqd0i6vxwt.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Jul 2019 08:36:50 -0700")
Message-ID: <xmqq8ssuvvf4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C2E3100-AA42-11E9-A02F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> You probably forgot that I already proposed that, long time ago:
>> https://public-inbox.org/git/cover.1494509599.git.johannes.schindelin@gmx.de/
>
> No, I haven't.  It was actually meant as an invitation to you to
> help us come up with a reasonable deprecation path.

By the way, while the "deprecation plan" still has my attention ;-),
there is another thing I've been wanting to see happen *without*
burning me like the last time it was brought up [*1*], which is also
hard to come up with a reasonable deprecation path.

A newer port like Git for Windows, where I suspect that most of the
users are not even aware of the "git-foo" form, can probably get
away by not shipping the libexec/git/git-foo without getting its
users complaining (and as you repeatedly said, nobody on Windows
write shell scripts, so lack of support for old scripts writtin in
the days back when git-foo was a norm is perfectly fine there).  But
I am not sure about my tree where audiences are beyond Windows, and
I certainly do not want to get burned again myself.  

Somebody else volunteering to take both blame (and flame) and credit
would be most welcomed ;-).


[Reference]

*1* https://public-inbox.org/git/7vr68b8q9p.fsf@gitster.siamese.dyndns.org/
