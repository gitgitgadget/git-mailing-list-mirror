Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E804C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiFMTws (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347400AbiFMTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:52:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758637A2C
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:23:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3784E13625F;
        Mon, 13 Jun 2022 14:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hw1zZ2WzLamrCfFNLSq4WdjNSYYnrMOmlqeNm0
        dgM9I=; b=FH0OVoBsUqyDSCr3lujCiHEKXKR+KcSnkhlpylnF9Go5xSoYh2GXXF
        ldi07QfnuNRFAnvFNMg8B8w6+1Vm5sGrpsYh0WMaHMMd/UuCiOM0yBmyDXbzSnC9
        CGlRkFUwXhXVDqk+Q52JYZLh+Um3bm6QTfr6jMrQcRpmyW5mmzs40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2246313625E;
        Mon, 13 Jun 2022 14:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE49813625C;
        Mon, 13 Jun 2022 14:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/3] diff-format.txt: fix ancient copy-paste error
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
        <6eaf9b3829fa8f7300bc0123c916d5ffa7c7d80b.1655123383.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 11:23:02 -0700
In-Reply-To: <6eaf9b3829fa8f7300bc0123c916d5ffa7c7d80b.1655123383.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 13 Jun 2022
        12:29:41 +0000")
Message-ID: <xmqq8rq07795.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD50AA6C-EB45-11EC-B676-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Fix what is probably a copy-paste error dating back all the way to
> b6d8f309d9 ([PATCH] diff-raw format update take #2., 2005-05-23).

This indeed is an improvement.

"src" can legitimately be "0\{40\}" for a creation patch, e.g. when
the stat information is stale, but we can argue that it falls into
"look at work tree" case to justify removal of "creation", and use
the space to add "deletion".

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/diff-format.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index 7a9c3b6ff4c..b8319eeb41d 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -43,7 +43,7 @@ That is, from the left to the right:
>  . a space.
>  . sha1 for "src"; 0\{40\} if creation or unmerged.
>  . a space.
> -. sha1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
> +. sha1 for "dst"; 0\{40\} if deletion, unmerged or "look at work tree".
>  . a space.
>  . status, followed by optional "score" number.
>  . a tab or a NUL when `-z` option is used.
