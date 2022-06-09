Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA4BC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 20:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiFIUNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240844AbiFIUNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 16:13:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4852BCE01
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 13:13:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F947137692;
        Thu,  9 Jun 2022 16:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eLy/OaYnOnHLYH2l2sjUxid5O1gznHZFVlbibf
        Fz7DM=; b=ayyZRPEEif+cQVp74Lmr96E8cWGvlIHDZ2yz7/dgVoo2DgBjxCM4yR
        Znq2czBwwyICzIUeTnIXdGy6BgMFbxOVnbEVKvojbHRF+1mhWHnKaDjHJaCmUDup
        h3X/F8zCZzlJ29H4lubcyOO8B+WMKSTHKz+eSH70gMPEr9ec4tqxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97326137691;
        Thu,  9 Jun 2022 16:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC356137690;
        Thu,  9 Jun 2022 16:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqtu8x1fd4.fsf@gitster.g>
        <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
        <xmqq5ylarhsg.fsf@gitster.g>
        <3d67b69b-fac8-3171-92dc-303ea672efbf@github.com>
        <xmqqk09plnze.fsf@gitster.g>
        <1ad2435b-f6a5-dc17-1ee1-ffa8c127f04a@github.com>
Date:   Thu, 09 Jun 2022 13:13:28 -0700
In-Reply-To: <1ad2435b-f6a5-dc17-1ee1-ffa8c127f04a@github.com> (Derrick
        Stolee's message of "Thu, 9 Jun 2022 15:39:38 -0400")
Message-ID: <xmqqo7z1ioif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0F19F12-E830-11EC-81D2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Further, the provider might want to cover a large number of refs,
> not just the default ref. That would increase the size of the
> table of contents more than necessary.
>
> With these things in mind, I do still think bundles are a good
> way to store and share this data.

If you keep the refs and filter information separately from the
packdata (i.e. in the table-of-contents like I outlined in the
message you are responding to), one downside is that you lose these
pieces of information but still have packfiles, such an accident
would make the set of packfiles pretty much useless.

But if you have bundles, the filter information to be placed in the
table-of-contents can be recovered from them.  Which is much better.
I wonder if we should add more to the bundle, like what we would
write to the .timestamp field of the table-of-contents, though, if
we are to go in that direction.

Thanks.

