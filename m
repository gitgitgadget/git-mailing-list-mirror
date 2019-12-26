Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE43C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3CB20838
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t/Kbaild"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLZVRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:17:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64307 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVRu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 16:17:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C675F9FE39;
        Thu, 26 Dec 2019 16:17:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l720KVuuCeAZLbKPIC+TBsoirmY=; b=t/Kbai
        ldDZceHxBeJC6+3od8HU3QBz51cw873q51sG9HTaZjvfAL0AwPeJ7hkiDl3eLdVN
        WaSK9Wxsjge7VwH4R+QhSL7Ykw2KSbXxBpjttNYysqLvPxRM6m5dsPpCmVCSHfXv
        6qnJpyl9TXdWCcXy96fwUbnAq6eCN7SJAlqTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TpzI4xhOmRblz/x4OQMvqWkUTDyDP6iT
        hQzi02fMyqrKxAT39H7u3FfMZQyhQKl8AsKwTNnwdy7wOfAfHlF+3j+V4wx3GNxF
        oIpoapAij/7/yTiUsO/90TcFOLODSyMX//VqoUzfplbVygteHW2zYuWzPsT4DNNF
        JXOZB7hv9yA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEF1D9FE38;
        Thu, 26 Dec 2019 16:17:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF2889FE37;
        Thu, 26 Dec 2019 16:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sparse-checkout: list folders in cone mode
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
        <07be7b8dda679d79ac9b218b2a9b08e47d7762fd.1577393347.git.gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 13:17:44 -0800
In-Reply-To: <07be7b8dda679d79ac9b218b2a9b08e47d7762fd.1577393347.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 26 Dec 2019
        20:49:07 +0000")
Message-ID: <xmqqo8vukcqv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29E4273C-2825-11EA-BBE7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>

> Subject: Re: [PATCH 1/1] sparse-checkout: list folders in cone mode
s/folder/directory/ everywhere as the rest of Git.

> When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
> command taks a list of folders as input, then creates an ordered

"takes"

> list of sparse-checkout patterns such that those folders are
> recursively included and all sibling blobs along the parent folders

In this sentence, what does a "blob" really mean?  Do you mean a
filesystem entity, that is not a folder, that is immediately
contained in the "parent folder" (in other words, regular files
and symbolic links)?

How would this interact with a submodule by the way?

> are also included. Listing the patterns is less user-friendly than the
> folders themselves.
>
> In cone mode, and as long as the patterns match the expected cone-mode
> pattern types, change the output of 'git sparse-checkout list' to only
> show the folders that created the patterns.
> ...
> +In the cone mode case, the `git sparse-checkout list` subcommand will list the
> +folders that define the recursive patterns. For the example sparse-checkout file
> +above, the output is as follows:
> +
> +--------------------------
> +$ git sparse-checkout list
> +A/B/C
> +--------------------------
> +

Sounds like a worthwhile usability improvement.

