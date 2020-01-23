Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FEC33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B913524655
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lMDRN8ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAWGIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 01:08:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64203 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgAWGIR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 01:08:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0322DAFF7C;
        Thu, 23 Jan 2020 01:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4cWIFoYc9vNJQbT5rtKIwinfcuw=; b=lMDRN8
        MLbVBq8/dm8zOzrUk1LMRTxep2iQdoZIsu2aKH292diubdRU6XbSGuzFMNdmTUQM
        IVsW6534aXHnUcdRHVkra7QiEVUmB6D028cOhvw0RPUIPpt12aDSGSf4S2+D/P38
        cgQpJC1XCJSv4h4dIWqRaujxNpBcYV6Yji6Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hpLdeCo0cQ7WLgXn92tyjKix6ZVs1bNt
        ozuaP+vYxax2DWHwQMl6z+jTh1mEhd44gCyJfBeiI6s8cCHBeZ/Pv7Jqp1rg/QLf
        D0WF3wh0S+mYbJAM7Khx+yXrbjyzWgLjosZFnDzz1TmupM9NmFWEcMKTPyj7qM2u
        wDeON4XfWIE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF54DAFF7B;
        Thu, 23 Jan 2020 01:08:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 126CEAFF79;
        Thu, 23 Jan 2020 01:08:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <20200123042906.GA29009@generichostname>
Date:   Wed, 22 Jan 2020 22:08:11 -0800
In-Reply-To: <20200123042906.GA29009@generichostname> (Denton Liu's message of
        "Wed, 22 Jan 2020 23:29:06 -0500")
Message-ID: <xmqqblqu66yc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD7918B8-3DA6-11EA-993E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Sorry, I'm back in school so I haven't had the time to keep up with my
> contributions very much. Feel free to give my topics lower priority for
> the next couple of months if they interfere with any other topics.

Thanks for a quick status report.

> On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
>> * dl/merge-autostash (2020-01-13) 17 commits
>> ..
>>  What's the status of this one?  Are people happy with the shape of
>>  the code?
>
> I'm not quite happy with this yet. Phillip Wood pointed out that if we
> do `git reset --hard` mid-merge with a stash, the stash will pop _after_
> the reset, which is very surprising since it leaves a dirty tree.
>
> I think I will have time to reroll this on the weekend.

OK, no need for rush.

>> * dl/test-must-fail-fixes-2 (2020-01-07) 16 commits
>> ...
>>  - t2018: remove trailing space from test description
>> 
>>  Test updates.
>> 
>>  Will merge to 'next'.
>
> Eric Sunshine sent out a reworded version of "t2018: use
> test_expect_code for failing git commands"'s commit message. I'll send
> out that replacement patch later this weekend as well.

Thanks.

Good luck with your studies and have fun at school.

