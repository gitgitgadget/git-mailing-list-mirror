Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04104C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiCIT3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiCIT3A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:29:00 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCE6D3B1
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:28:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C10918F4AE;
        Wed,  9 Mar 2022 14:28:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PHhDHLDNmJGEekOdQEou34K3lO3WcVXkti2MJu
        LUFGc=; b=j1i4EKBIxGUnWR6+909F0c/yO+ARfvasV7Qs7LiAgyC8qYeQMO1Rss
        poUNu4tRk+MmVzgCJhVW3iGlYhPfr2QJhZantnvEDkWZfqzGgryD+aDNsJ0YjeZW
        9kHLQMq6GsHJgCA6LHxwSDe99pp7Wx53lsBNXcbL+Uhc5BxLs9p6o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0491D18F4AD;
        Wed,  9 Mar 2022 14:28:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A24118F4AC;
        Wed,  9 Mar 2022 14:27:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: ar/submodule-udpate (was Re: What's cooking in git.git (Mar
 2022, #02; Mon, 7))
References: <xmqqilspp5yg.fsf@gitster.g>
        <kl6l8rtj57gh.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 09 Mar 2022 11:27:57 -0800
In-Reply-To: <kl6l8rtj57gh.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 09 Mar 2022 10:03:42 -0800")
Message-ID: <xmqq7d93kjsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06F90240-9FDF-11EC-9C50-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ar/submodule-update (2022-03-04) 13 commits
>>  - submodule--helper update-clone: check for --filter and --init
>>  - submodule update: add tests for --filter
>>  - submodule--helper: remove ensure-core-worktree
>>  - submodule--helper update-clone: learn --init
>>  - submodule--helper: allow setting superprefix for init_submodule()
>>  - submodule--helper: refactor get_submodule_displaypath()
>>  - submodule--helper run-update-procedure: learn --remote
>>  - submodule--helper: don't use bitfield indirection for parse_options()
>>  - submodule--helper: get remote names from any repository
>>  - submodule--helper run-update-procedure: remove --suboid
>>  - submodule--helper: reorganize code for sh to C conversion
>>  - submodule--helper: remove update-module-mode
>>  - submodule tests: test for init and update failure output
>>
>>  Rewrite of "git submodule update" in C (early part).
>>
>>  Will merge to 'next'?
>>  source: <20220305001401.20888-1-chooglen@google.com>
>
> I don't anticipate further comments, so I think this set of patches
> should be pretty safe to merge :)

No news is no indication, though ;-)

As long as the previous rounds, except the parts that have been
changed in this round, have been favorably reviewed, and the updates
in this round have already been reviewed well, it would be good,
and I think that is true for this series.

> A comment on the branch name: we kept the name 'ar/submodule-update'
> from when Atharva Raykar <raykar.ath@gmail.com> prepared v1 of his
> series that converts all of "git submodule update" to C. When other
> authors sent subsequent versions, it still made sense to keep this name
> because the patches still reached the same end state of having all of
> "git submodule update" in C.
>
> However, I've since broken this series up in two (to play better with
> other topics), and the above-named patches don't do a _full_ conversion
> of "git submodule update". Is something like "ar/submodule-update-1"
> more appropriate?

You've already taken over the ownership of the majority of patches
in the series, and it may not be a bad idea to rename it to
something like gc/submodule-update-part-1 before it hits 'next'.

How many more parts do you anticipate to have, by the way?

Thanks.
