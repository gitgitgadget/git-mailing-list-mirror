Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B056C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF1B2075E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eg/31vyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDGVE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:04:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59973 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGVE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 17:04:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0063B5741D;
        Tue,  7 Apr 2020 17:04:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GVsAAYbald8BWjSFS5EUJOK6bSM=; b=Eg/31v
        yAk3ihDHScXLyQ15WMVK3NBEb2zq3/Ockcqk0BZFkQZnqZ7xuTjvLuxKs9l0kBvg
        4hbk7RPOZ8EWTfqCSwccRGxt7ZahLZUoxAEXIuoqSVbmgit5FkXad3JgetMtjsDr
        XRNvz1oPTFPggr631NjrxJF3clKFNQCa5UI50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nBRTbvDZqTBJEkFoRrEkBusmYvuNg5Bk
        wT3REYBN1wQ0T7I104nbA6SXd5NCedYbvZ1b3feXJsX7NXmwRmeKU3FAddBIRPVw
        cDNj7QhHu1TE0t1O9Mfu9zB5hpKrAC57Z0IVLNMHpkkosjW+eIwX5eV51WtFYqVL
        /TbKrtbc3vQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB50E5741C;
        Tue,  7 Apr 2020 17:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68F365741B;
        Tue,  7 Apr 2020 17:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200407141125.30872-2-phillip.wood123@gmail.com>
        <CABPp-BEnmpET=6rEdDXJWnPjzV33a2x6rKB6FQ-o8y+8ssK4jw@mail.gmail.com>
Date:   Tue, 07 Apr 2020 14:04:55 -0700
In-Reply-To: <CABPp-BEnmpET=6rEdDXJWnPjzV33a2x6rKB6FQ-o8y+8ssK4jw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 7 Apr 2020 08:16:09 -0700")
Message-ID: <xmqqv9mbroqw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F28A112-7913-11EA-A425-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This reverts commit 4d924528d8bfe947abfc54ee9bd3892ab509c8cd.
>>
>> This is being reverted to enable some fixups for
>> ra/rebase-i-more-options to be built on this commit.
>
> This makes sense to me, but it will be only the second 'Revert
> "Revert..."' commit in all of git.git and I'm curious if Junio will be
> unhappy with it.

Nah, there isn't much to become unhappy about.  

I however suspect that the alternative would certainly be much nicer
and easier to understand, which is to rebuild the 7-patch series
c58ae96fc4..d82dfa7f5b but bugs already fixed, instead of doing this
patch to take us back to a known buggy state and then fix the result
with 5 more patches.  Is that what you meant?
