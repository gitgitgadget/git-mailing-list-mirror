Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C840C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiGaSoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaSoW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:44:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991CDF3D
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:44:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0062614E931;
        Sun, 31 Jul 2022 14:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N1c2jNvbFi/HZ+s6YVexutvbNf5LZJYPGf0PYe
        0uap4=; b=xiLgXxjTsUlAdav9wzLiOUp2TSdpgXJ9lhzXyRQU79DBNh6sD/+oka
        rlC/4OL0EbygH+e3yM/AT4a8zbgjesmbDHAPnjUJDeaZCMZ265Xnj1frTENFvG/I
        D/iRSVQsCXbb/bqsjHQ0PP1A/vdB28kVKygZKkL2qRFHU6qCxea+Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA86214E930;
        Sun, 31 Jul 2022 14:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E41C14E92F;
        Sun, 31 Jul 2022 14:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] merge-ort: clean up after failed merge
References: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
        <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
        <CABPp-BGKUkVKJK87jZn-7A3AuxDjKwttVpez9UVZrTJZyCFodw@mail.gmail.com>
Date:   Sun, 31 Jul 2022 11:44:18 -0700
In-Reply-To: <CABPp-BGKUkVKJK87jZn-7A3AuxDjKwttVpez9UVZrTJZyCFodw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 29 Jul 2022 17:50:30 -0700")
Message-ID: <xmqqles915rx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C958237E-1100-11ED-B3F2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jul 29, 2022 at 10:12 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> I was investigating why seen's CI runs fail, and came up with this fix.
>>
>> Changes since v1:
>>
>>  * Rebased onto en/merge-ort-perf.
>>  * Now we're not only cleaning up the merge data structure, but also leaving
>>    the Trace2 region when returning early from merge_switch_to_result().
>>
>> Johannes Schindelin (2):
>>   merge-ort: clean up after failed merge
>>   merge-ort: do leave Trace2 region even if checkout fails
>>
>>  merge-ort.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> Thanks, series looks good to me:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks, both.

The new "leave" calls immediately next to the existing ones that
look identical appear duplicated, but correcting the logic first
in an obvious way like the posted patch, leaving any clean-up to
later, is a prudent thing to do.

Queued.
