Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80961C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527716108C
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 19:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhDRTJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 15:09:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51765 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRTJi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 15:09:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 656E9BF078;
        Sun, 18 Apr 2021 15:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qh+bsgbR/9aJ+NrS0ywgSZiN7Jw=; b=WPB+Rx
        menH+xVHd9lfcqd6+aYrvlPPUJ0zxXC1Nl6fFPuO/04iQbGcXwbiVVtNCojAqtcu
        UWJls4sNgiVfEY05Kkf9lyoxBT697ovvMIX+bj6+D2PcyAgwXQSOP4q7xtP/8H0J
        YvtdrPGCDpsK3tPbepg+NijZXLasr7T+0clms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HcLs/kSsu+vRx5H0FkZNxOG9d5xYRMyp
        uFff2Z4Oyte19/PGxFMN6ZxxUsEVin3WyJhtegeE0IgL9+c0F5vY6mxa4BlwSkZE
        8YUn26P6+p5mVoRwOTnbb3iXY5ADKCtSofUAHzfeRyIGDUsOOiIOl0Zj2m7JIxTN
        i/wKQd83yVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C8C1BF077;
        Sun, 18 Apr 2021 15:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0EDABF076;
        Sun, 18 Apr 2021 15:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
References: <xmqqa6pznlgq.fsf@gitster.g> <87zgxvttvx.fsf@osv.gnss.ru>
Date:   Sun, 18 Apr 2021 12:09:07 -0700
In-Reply-To: <87zgxvttvx.fsf@osv.gnss.ru> (Sergey Organov's message of "Sun,
        18 Apr 2021 19:55:14 +0300")
Message-ID: <xmqqtuo39zqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D5C546A-A079-11EB-B6EB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
> [...]
>
>>
>> * so/log-diff-merge (2021-04-13) 5 commits
>>  - doc/diff-options: document new --diff-merges features
>>  - diff-merges: introduce log.diffMerges config variable
>>  - diff-merges: adapt -m to enable default diff format
>>  - diff-merges: refactor set_diff_merges()
>>  - diff-merges: introduce --diff-merges=on
>>
>>  "git log" learned "--diff-merges=<style>" option, with an
>>  associated configuration variable log.diffMerges.
>>
>>  Seems to break t9902.
>
> As far as I understand, it doesn't. It rather hits a deficiency of the
> build system where one needs to "make install" for completion tests to
> run as expected.

Yeah, the next issue of the report will show that this topic has
been moved on top of fix for config-list.h dependency in the build
procedure, which fixed the issue.

Thanks.
