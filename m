Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F61C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53966113A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhIJFBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 01:01:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61525 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFBf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 01:01:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60950E2729;
        Fri, 10 Sep 2021 01:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rEFd8vY/YCfAwGMOPP8YRR6h72jcHFil333Kp9
        wUaBo=; b=xWlx4iONsQXJFxBxpmcZbfrZjDRitVQ7eyoD8a6iD6jZO5numEdnqS
        /qEn/9TtGMBYEgpMZ14IlYVCvi2P/weJ6/XWbpa3DpJ8SR3AMC+IcVktrmOfP65p
        etseCJ49NjXvNGm0yfsZijMePMnUj3ZuJXMU22ueacitVgDNOjIl4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57638E2728;
        Fri, 10 Sep 2021 01:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFEE2E2727;
        Fri, 10 Sep 2021 01:00:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/retire-preserve-merges, was Re: What's cooking in git.git
 (Sep 2021, #02; Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109091307070.59@tvgsbejvaqbjf.bet>
Date:   Thu, 09 Sep 2021 22:00:23 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109091307070.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 9 Sep 2021 13:08:06 +0200 (CEST)")
Message-ID: <xmqqv939uis8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01A0F740-11F4-11EC-95F9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 8 Sep 2021, Junio C Hamano wrote:
>
>> * js/retire-preserve-merges (2021-09-07) 11 commits
>>  - sequencer: restrict scope of a formerly public function
>>  - rebase: remove a no-longer-used function
>>  - rebase: stop mentioning the -p option in comments
>>  - rebase: remove obsolete code comment
>>  - rebase: drop the internal `rebase--interactive` command
>>  - git-svn: drop support for `--preserve-merges`
>>  - rebase: drop support for `--preserve-merges`
>>  - pull: remove support for `--rebase=preserve`
>>  - tests: stop testing `git rebase --preserve-merges`
>>  - remote: warn about unhandled branch.<name>.rebase values
>>  - t5520: do not use `pull.rebase=preserve`
>>
>>  The "--preserve-merges" option of "git rebase" has been removed.
>>
>>  Will merge to 'next'?
>
> I think so, given the rate of reviews still trickling in tending toward
> zero.

We need to be careful about making our decision on such a trend.
For a later iteration, the lack of comments does not give us much
information.  It can happen if all the comments have adequately been
addressed, but it also can happen if none of the suggestions given
in earlier rounds are addressed---the reviewers can easily give up
and leave.

I think I've followed the topic well enough to tell that it is the
former for this instance (i.e. the patches have been polished well
enough).  Let's merge to 'next' so that we can keep it there long
enough.

Thanks.

> We probably want to keep it in `next` for quite a while, too, to make sure
> that people get the memo.
>
> Ciao,
> Dscho
