Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B369C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiCNUyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiCNUyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:54:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB71C933
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:53:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B7BF1080B3;
        Mon, 14 Mar 2022 16:53:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yrwEIp8hG9/OW4vVtN+PL4iAbSrWHJ3XfZhnCo
        VOLU0=; b=GiB03wqcPvt3dfQWaXebWH4SUnwv6P9QmdoiKMPIqNOFHsO19qvvvP
        idnWXF97nVknu9HkgbnX1LPEuCePCjm7Ya7djNBcTOL0GjWQ0x9oR7FNHCDJOuiG
        GU/HabltLhEB1YbSGY+nklNX/3vd3sO/ryN/FHe+MEF0sw7K1UA68=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 326351080B2;
        Mon, 14 Mar 2022 16:53:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 575DB1080B0;
        Mon, 14 Mar 2022 16:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/9] git-sparse-checkout.txt: update docs for
 deprecation of 'init'
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <eb3b318b39ec3eed754eab7d2c9d20198117545b.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:53:03 +0000
In-Reply-To: <eb3b318b39ec3eed754eab7d2c9d20198117545b.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:16 +0000")
Message-ID: <xmqqwngwp87k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE5EB02C-A3D8-11EC-9E90-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
> -the input list is considered a list of patterns.  This mode is harder
> -to use and less performant, and is thus not recommended.  See the
> -"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
> -Set" sections below for more details.
> +When `--no-cone` is passed, the input list is considered a list of
> +patterns.  This mode is harder to use and less performant, and is thus

"less perfromant" can be quantified, but "harder to use" is probably
harder to defend.  Those on a project with need for more flexible
way to specify than "these are the directories I care about" would
not find it convincing.

> +not recommended.  See the "Sparse Checkout" section of
> +linkgit:git-read-tree[1]

The referenced section (I am reading "git read-tree --help" from
seen with these patches) may need updating.  It shows an example
of including everything except for unwanted, without mentioning
if that is for cone or non-cone.

> and the "Pattern Set" sections below for more
> +details.

Are we referring to "Internals - cone/full pattern set" sections?

This may be a topic of another step in this series, but the "core"
section starts by mentioning what characteristics the full pattern
set has and uses it to steer readers away from it, which I find it
less than ideal.  As we present "core" first (because it is the
default), we should present "core" by itself, without requiring to
know what the other thing is.  Perhaps replace the entire first
paragraph so that the section begins more like so:

	The "cone mode", which is the default, lets you specify only
	what directories to include and what directories to exclude.

	The accepted patterns in the cone pattern set are:...

Especially, the last sentence in the paragraph to be struck still
lives in the old world in which you needed to opt into the cone
mode.

Thanks.
