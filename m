Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D8EE49AD
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 22:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjIEWtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIEWtM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 18:49:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598D128
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 15:49:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAF6025923;
        Tue,  5 Sep 2023 18:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/tdZ81Z/r8/l5Ls/T/JodYdyZY6yM9U9eCbQDE
        EeV6c=; b=KZqIuOEQczLTuLPLl/aVshbrMS0qqqFdP8nLuAk23ex0SWVyKBgaSr
        kLfrqgbLTbjUBeLaA4UT3B/j77K3CwIJrj2QISwR5TJag4Tak1xaIsjsv7ypur+7
        HjUiI651osZHp7eCD4ow6aUOsUaO/4692ur352ybC39kSnMTuWAJo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A42F425922;
        Tue,  5 Sep 2023 18:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 526C225921;
        Tue,  5 Sep 2023 18:49:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/1] doc/diff-options: fix link to generating patch section
In-Reply-To: <87zg20qzhg.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        05 Sep 2023 20:52:27 +0300")
References: <87zg20qzhg.fsf@osv.gnss.ru>
Date:   Tue, 05 Sep 2023 15:49:04 -0700
Message-ID: <xmqq34zsqlr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A7FF708-4C3E-11EE-B1A0-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> First, there is no need for conditional referencing, as all the files
> that include "diff-options.txt" eventually include
> "diff-generate-patch.txt" as well.

Except for git-format-patch.txt which includes the former but not
the latter.  But this is inside ifndef::git-format-patch[], so the
above description being a bit imprecise does not cause any actual
damage.

    Documentation for all commands that want to describe the `-p`
    option by including the "diff-options.txt" file also include the
    "diff-generate-patch.txt" file, so an internal link would work
    for all of them.

or something like that, perhaps.

> Next, when formatted as man-page, the section title is rendered
> "GENERATING PATCH TEXT WITH -P" whereas reference still reads
> "Generating patch text with -p", that is both inconsistent and makes
> searching harder than it needs to be.
>
> Fix the issues by just referring to the section, without custom
> reference text, and then unconditionally.

That does make sense.

> Fixes: ebdc46c242 (docs: link generating patch sections)
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/diff-options.txt | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 9f33f887711d..c07488b123c6 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -22,13 +22,7 @@ ifndef::git-format-patch[]
>  -p::
>  -u::
>  --patch::
> -	Generate patch (see section titled
> -ifdef::git-log[]
> -<<generate_patch_text_with_p, "Generating patch text with -p">>).
> -endif::git-log[]
> -ifndef::git-log[]
> -"Generating patch text with -p").
> -endif::git-log[]
> +	Generate patch (see <<generate_patch_text_with_p>>).
>  ifdef::git-diff[]
>  	This is the default.
>  endif::git-diff[]
