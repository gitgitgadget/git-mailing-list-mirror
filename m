Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A376CC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A4721527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="faeqzX+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464863AbgJWQAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:00:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58830 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464584AbgJWP7p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:59:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 837BC9283C;
        Fri, 23 Oct 2020 11:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YSx5GmmLnIVxJOr0PDO+eHQXa8I=; b=faeqzX
        +R3HdJBZj8zOFOLAeUjBnkgbuREdJYqfLSODtg+WJR3FmQ+chy1lqAdy4r+g8HUL
        0BQYFCO6vXTYVgMghHwPsavBuJmoOW7PkdgH7OfT5zBIbVgx5UCD7dY+XxfQpJ3S
        +64qzpp5b+/tIEkLzU2nSRE8uqw7eGBMRRiF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pv2pun9Kng2fc8uJI2bDNd6MFGvIi3pQ
        x0XV31gV4Jomg1y5AbOkL2fzI/KlYLo/Pfm9i8m0v7AcTKM6uQchdcDyaURIQTGw
        VNAzBC5rM6GdS5FJ6R/88A6+tQQSSH73DHeZORMsAnAaNka5dBxfejoQT0jXlYoO
        OtZagL1ojEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BC789283B;
        Fri, 23 Oct 2020 11:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A10D9283A;
        Fri, 23 Oct 2020 11:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/9] Prepare for changing the default branch name
 main (last manual part)
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 08:59:42 -0700
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 23 Oct 2020 13:59:57
        +0000")
Message-ID: <xmqqzh4dgcgh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3BB4230-1548-11EB-A90B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v1:
>
>  * The t4013 patch was moved out of this patch series, to be re-submitted at
>    a later date, to avoid clashing with other patches in seen.
>  * The commit message of 'fmt-merge-msg: also suppress "into main" by
>    default' was adjusted to mention that we do the same for main as we do
>    for master.
>  * The t5703 patch now uses rain instead of none, to be closer to the
>    default branch name.
>  * The glob in t6200 was tightened to avoid matching maint.
>  * The commit message of 't3200: prepare for main being shorter than master'
>    stopped talking about main2 (which itself was a left-over from a previous
>    iteration of a previous patch series).

All looked sensible.  Thanks; will replace and hopefully we can move
these to 'next' once we rebuild it on 2.29.

