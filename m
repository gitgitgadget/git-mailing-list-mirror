Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C04C1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfJFACs (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 20:02:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60950 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfJFACr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 20:02:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E76019A17;
        Sat,  5 Oct 2019 20:02:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TBQWn/2zwdqmc4DMUa9pwgjMHMU=; b=ixu89a
        8dKTRSFtjMY1YTDrb4d/9fDRJ0eU5Wn5B2wgp/bl6mQ5vXGMvBGZdjbCmgxfZXY3
        GkmrnbjGeR/HUO65b3Hu8rUoN0GfpJcmsrwdBDdG89cB6jaEZ1FxwXnHOcuhANdF
        fxJ5rKYvdovxhY1q8TMvVBK3l5VUaYoEAmhvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LztBMzkXilA2sq70mlUO9hUyaikvKmwt
        qOdR1kA1YxOloAZc7ol7MjpvpGv7gPP1u7JnF2ctkpkl57ws+m+UaBbyY7UwMVO7
        C/NtPtVIuslIssEKr+HrSI0cfBAOScIvEo6lT831NW6ItJYlGbngYJAytpPGtZni
        yDn/Ln8S08A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 857A619A16;
        Sat,  5 Oct 2019 20:02:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0E7A19A14;
        Sat,  5 Oct 2019 20:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned types
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
        <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
        <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
        <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org>
        <nycvar.QRO.7.76.6.1910042319190.46@tvgsbejvaqbjf.bet>
Date:   Sun, 06 Oct 2019 09:02:43 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910042319190.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 4 Oct 2019 23:24:26 +0200 (CEST)")
Message-ID: <xmqqr23q68rg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FB0FC72-E7CC-11E9-97C8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> IMHO, if you don't accompany insert_pos_as_negative_offset() with a
>> corresponding extract_pos_and_found_condition() and use it everywhere,
>> it is more obfuscating than necessary.
>
> I do disagree here. No overflow checking needs to be performed for `-1 -
> <int-value>`. And that's what the opposite of this function really boils
> down to.

I do not think j6t is referring to the over/underflow issues at all.

The suggestion is that, because insert-pos-as-negative-offset
abstracts away (in addition to the overflow checks) the fact that
"does not exist but here is the location it would be inserted" is
encoded in a certain way (i.e. not just the array index negated, but
also is offset by -1, because we wouldn't be able to say "at the
very beginning at index 0" without the -1 offset), the side that
consumes the encoded "pos" (i.e. "we got a negative, so we know the
element does not exist, and the index into the array we would insert
a new element is computed this way") should be abstracted away, as
it must know that the extra negative offset used when encoding is
"-1".

I think that is a reasonable thing to consider; it is not necessary
for correctness, but contributes to the conceptual clarity (iow, it
can be left as a separate clean-up step done after the series is
done).
