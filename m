Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D7C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 19:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiG0Tif (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiG0Tie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 15:38:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36F4F18B
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 12:38:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5DB11286B7;
        Wed, 27 Jul 2022 15:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LnsYXTWp0X7CEhSiyp8r3NAL+Xq4Gz/RWyGtcF
        3fXx8=; b=R3fmk8VKibvXAB7bPoHuHJgBluT3n1mVT9HmOrQz5azmaQmdNFERDm
        Mu3o3g/Jr+3vXhIRJ1zwfzUvNcw5sKrXg3NL+BEVNisEumH3hu+iJ5AumXVQe5n1
        8qVEl4I++YTy7sIq0eHj8h8H66puC0NWTdY6fodIZdrLXlNpydAc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE3081286B5;
        Wed, 27 Jul 2022 15:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 518961286B3;
        Wed, 27 Jul 2022 15:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com
Subject: Re: [PATCH 2/3] log: add default decoration filter
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
        <xmqqczdqtxro.fsf@gitster.g>
        <e437576e-537c-ecfb-9143-6e440f3bb893@github.com>
Date:   Wed, 27 Jul 2022 12:38:29 -0700
In-Reply-To: <e437576e-537c-ecfb-9143-6e440f3bb893@github.com> (Derrick
        Stolee's message of "Wed, 27 Jul 2022 15:07:08 -0400")
Message-ID: <xmqqk07ys5vu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1691022-0DE3-11ED-8104-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> * Notes (refs/notes/)
>> 
>> Questionable.  None of the notes commits are on the primary history,
>> so it is unlikely to be even used for decoration, so it would not
>> hurt to have them as part of possible decoration sources, but on the
>> other hand, the value of using them is dubious.
>
> I had originally left this out of the filter, but then noticed that test
> 4013.102 (git log --decorate --all # magic is (not used)) includes an
> instance of refs/notes/. Perhaps this is just old test cruft and could be
> changed.
>
> I could remove this from the filter and change the old test to match the
> new behavior.

I can summarize what I said to "Keeping this will not hurt, but it
is unclear if anybody depends on it"---and I am OK to err on the
safe side, i.e. keep notes and stash in the default set.
