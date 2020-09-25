Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C9C4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE94F21D7A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lzzcIK1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgIYUdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60338 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIYUX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:23:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5648ED228;
        Fri, 25 Sep 2020 16:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H+4V0w7lCKWlUbl+qyT+1qhC5Tk=; b=lzzcIK
        1ukBtcyAU4MIox+nlQC0rbKbT/+9S75qS1lRUABZDGaedWO1ntRFw3Cilwt1/O8/
        U6/Jqm39wMbdDhubUybHN4OM4iZrfxWZHVaNHclk8Sr9Hk6L6n4POi6UrCZby1sg
        SgQ6OZKG/uYHq3B2vjlLn9yY9WojtfP7oyaMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GUlje3ljp8Nhwyv43gU0Ys8fobNRFT95
        81PTBSvqZlxDQ/2GVSSvUm0OQTEErigG2PIVg+ECtWd7+iaR2mE/dzE6PUUIB38i
        8GH8zHO8fgNFMoltoadQEDc4xL89JT7P2cyiNaNZGGbDmnn3xn4zgozYbFTvj9ps
        ZLZad/BAy1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE71EED227;
        Fri, 25 Sep 2020 16:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33E90ED225;
        Fri, 25 Sep 2020 16:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     shubham verma <shubhunic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/11] t7001: use here-docs instead of echo
References: <20200925170256.11490-1-shubhunic@gmail.com>
        <20200925170256.11490-10-shubhunic@gmail.com>
Date:   Fri, 25 Sep 2020 13:23:52 -0700
In-Reply-To: <20200925170256.11490-10-shubhunic@gmail.com> (shubham verma's
        message of "Fri, 25 Sep 2020 22:32:54 +0530")
Message-ID: <xmqqr1qpk3l3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0832AA94-FF6D-11EA-8484-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

shubham verma <shubhunic@gmail.com> writes:

> From: Shubham Verma <shubhunic@gmail.com>
>
> Change from old style to current style by taking advantage of
> here-docs instead of echo commands.
>
> Signed-off-by: shubham verma <shubhunic@gmail.com>
> ---
>  t/t7001-mv.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 94c5b10f8a..30714a8200 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -222,7 +222,10 @@ test_expect_success 'git mv to move multiple sources into a directory' '
>  	git add dir/?.txt &&
>  	git mv dir/a.txt dir/b.txt other &&
>  	git ls-files >actual &&
> -	{ echo other/a.txt; echo other/b.txt; } >expect &&
> +	cat >expect <<-\EOF &&
> +	other/a.txt
> +	other/b.txt
> +	EOF

This could be written with test_write_lines but a here-doc would be
a better option in this case, as we will see the expected output from
the tested command in the exact form.

