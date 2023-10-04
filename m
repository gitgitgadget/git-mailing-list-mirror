Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC8E8FDD1
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 08:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjJDIUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJDIUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 04:20:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B3AD
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 01:20:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3B5A1BCF44;
        Wed,  4 Oct 2023 04:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=waOjhozLKI8LQKNgQDXdivb/D2iKmYnFwKLVSJ
        DocLc=; b=CyclQtHslRVW28VsijHesWvgoCTBH7twQ0pkwcqqX3LsvEif9epViX
        UqMU1EqyRvKlhzqW0lTJawJS1ayYFBv5QlvzxevY5++qzhdtYh4Skl5wpyLBNN34
        wMbnaYlQjXchUAvoztNdYAtReeTvMESx8db3MRj3nnzB+ItZKmoAE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA49D1BCF43;
        Wed,  4 Oct 2023 04:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E22B1BCF42;
        Wed,  4 Oct 2023 04:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
In-Reply-To: <874jj7lh7x.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        03 Oct 2023 20:59:46 +0300")
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
        <xmqq34yr3btn.fsf@gitster.g> <874jj7lh7x.fsf@osv.gnss.ru>
Date:   Wed, 04 Oct 2023 01:20:43 -0700
Message-ID: <xmqqo7hessro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9D09394-628E-11EE-8E6C-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> I believe I've addressed this in details in my reply here:
>>> <87o7hok8dx.fsf@osv.gnss.ru>, and got no further objections from you
>>> since then, so I figure I'd ask to finally let the patch in.
>>
>> You need to know that no response does not mean no objection.  You
>> repeated why the less useful combination is what you want, but that
>> does not mean the combination deserves to squat on short-and-sweet
>> 'd' and prevent others from coming up with a better use for it.
>
> Yep, but I've asked what's better use for -d than "get me diff"? Do you
> really have an idea?

The primary point is to leave it open for future developers.

If I have to pick a candidate for "get me diff" that is the most
useful among those currently are available, it is "give patches to
all single-parent commit, and show tricky conflict resolution part
only for merge commits".  Before "--remerge-diff" was invented, my
answer would have been "give patches to all single-parent commit,
and show combined diff in the compact form for merge commits", aka
"git log --cc".  Even though we did not know if a better output
presentation for merge commits would be coming, we did not let it
squat on any short-and-sweet single letter synonym.
