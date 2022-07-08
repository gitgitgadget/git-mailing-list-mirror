Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD63FC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 01:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiGHBHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 21:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiGHBHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 21:07:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83CF70E77
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 18:07:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 006221B12E4;
        Thu,  7 Jul 2022 21:07:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2yO/RZVuHQ2u6l8lh5ETPhABex7C3nsxksJjRP
        dDkKs=; b=qwDCY8gjF3iki3hRshVcyfci4FMTWmaIx2RV2gkyfaVdnf2hcnCoJF
        TovAUzbbbT8+D04W/gj7z+L1JAjxAK3IT0DsCdQyhoEyYG9YPBqk2UevPQP8Fm8t
        +to9LiVTFQjTpOT1OqChH5dNJHMhH6BevT2Kwc3SnpUIDUxF2mLfs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF6CC1B12E3;
        Thu,  7 Jul 2022 21:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 810D01B12E2;
        Thu,  7 Jul 2022 21:07:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 0/5] config: introduce discovery.bare and protected
 config
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 18:07:26 -0700
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Thu, 07 Jul 2022 23:01:49 +0000")
Message-ID: <xmqqtu7swgxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556E743A-FE5A-11EC-ACBC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This version incorporates most of Taylor's comments and suggestions. Thanks
> especially for the wording suggestions, I struggled with those a lot :)
>
> (I believe) I've responded upthread with my intention for each comment. The
> only differences between that and the actual changes are:
>
>  * In Documentation/git-config.txt, I dropped a suggestion to mention that
>    "git config --local" is identical to the default behavior when writing
>    options because I found it too hard to fit in.
>
>  * In Documentation/config/discovery.txt, I took Taylor's suggestion, but
>    didn't mention "discovery" for the same reasons.
>
>  * I decided to leave out the protected config lookup functions. I made some
>    POC patches at:

These patches overall looked ok.  I am not very happy to see the
proliferation of namespaces like safe.* and discovery.* that would
not likely to get the second variable, though.
