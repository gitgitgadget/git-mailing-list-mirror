Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F44C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiGRS5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGRS5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 14:57:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA352F38A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 11:57:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B6C114D308;
        Mon, 18 Jul 2022 14:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XXlCx8H8Auiid8BQr4UK+LqzlpJ29c2PA2CaW+
        YLwkc=; b=XKo3sWrCglnbkaUiLUG+evd8/JbBCLz9P4fO8rfDwF0iET+zSD1RrW
        gzTLdanEgp0OR3z40A8dIYF9F5tb1olfoP9ATThX4gzVQUMQ0+Gva23rkFYpR3wW
        HfCmIEEJr2I8rD0HyVFvIaFYDlLAQhPDcyMet3ODkVao6LxdKt48Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7370B14D307;
        Mon, 18 Jul 2022 14:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF96214D306;
        Mon, 18 Jul 2022 14:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 0/7] trace2: dump scope when print "interesting" config
References: <cover.1657540174.git.dyroneteng@gmail.com>
        <cover.1658159745.git.dyroneteng@gmail.com>
Date:   Mon, 18 Jul 2022 11:57:13 -0700
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com> (Teng Long's message
        of "Tue, 19 Jul 2022 00:45:59 +0800")
Message-ID: <xmqqa696fdva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703AB598-06CB-11ED-B454-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Changes since v6:
>
> 1. [1/7] Fixed the mistitled commit mesage.
>
>    [PATCH v6 1/7] "clean: fixed issues related to text output format"
>
>    to:
>
>    [PATCH v7 1/7] "pack-bitmap.c: fix formatting of error messages"
>
> 2. [4/7] replace "warning()" to "warning_errno()" and rewrite commit message.
>
> 3. [5/7] fix the logic error, move "error_errno()" before close(fd) to
>    avoid errno lost.
>
> 4. [7/7] update Documentation/technical/api-trace2.txt here too.
>
> Thanks.
>
> Teng Long (7):
>   pack-bitmap.c: fix formatting of error messages
>   pack-bitmap.c: mark more strings for translations
>   pack-bitmap.c: rename "idx_name" to "bitmap_name"
>   pack-bitmap.c: do not ignore error when opening a bitmap file
>   pack-bitmap.c: using error() instead of silently returning -1
>   pack-bitmap.c: continue looping when first MIDX bitmap is found
>   tr2: dump names if config exist in multiple scopes

This has been "cooking" on the list for quite some time and I found
that all parts that I had comments on earlier iterations are now in
good shape.

Fellow reviewers, how does this round look?  The only gripe I have
is that the last one seems totally disconnected from the rest, but
That's minor.

Thanks.

