Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709DC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5422071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CAeR7Doe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbgAXSMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:12:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60107 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390883AbgAXSMt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:12:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7F20BBB3F;
        Fri, 24 Jan 2020 13:12:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=e8lSBvpKCS9G2y+GgDLUtdRKIzY=; b=CAeR7DoeylcP+zZ1WlHw
        IiOLIl9QJlIOHlkwDRMeKakgqckkRj7z3i2zhMmbl06cX7RUveSRsourAuRYJ7TH
        tvDp0tnd3mJHuKmOv7Okzs15X/9xAl592rUawnvjT5wLkVkU1JH4fdxXJ8VwhtNb
        163BahnzyYlNv0LZ/vv4AXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=L4HT6R6tBk8584aKH175Aztj0QRsR8Di6ypmnX9OIFFnUg
        2MXPyXDjquAp5CeezjYAvqzYF8Q8ipw1Zx4Ksjk+ufbt8zWHMcqcKClmBB1q4Y5j
        NVX6MmBK8pO/9f7pi+oLiXFNi2m+uPkoP3HrrIjYoSoqT+HtFUFB7QWxR8qeM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFBF2BBB3E;
        Fri, 24 Jan 2020 13:12:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6819BBB3D;
        Fri, 24 Jan 2020 13:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lucius Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Lucius Hu <orctarorga@gmail.com>
Subject: Re: [PATCH] templates: fix deprecated type option `--bool`
References: <pull.522.git.1579474412847.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 10:12:41 -0800
Message-ID: <xmqqo8us206e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E76D19E-3ED5-11EA-AAB3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lucius Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lucius Hu <orctarorga@gmail.com>
>
> The `--bool` option to `git-config` is marked as historical, and users are
> recommended to use `--type=bool` instead. This commit replaces all occurrences
> of `--bool` in the templates.
>
> Also note that, no other deprecated type options are found, including `--int`,
> `--bool-or-int`, `--path`, or `--expiry-date`.
>
> Signed-off-by: Lucius Hu <orctarorga@gmail.com>
> ---
>     templates: Fix depracated type option --bool
>     
>     The --bool option to git-config is marked as historical, and users are
>     recommended to use --type=bool instead. This commit replaces all
>     occurrences of --bool in the templates.
>     
>     Also note that, no other depracated type options are found, including 
>     --int,--bool-or-int, --path, or --expiry-date.

That's a bit redundant but I suspect it is not Lucius's fault ;-)

>  # If you want to allow non-ASCII filenames set this variable to true.
> -allownonascii=$(git config --bool hooks.allownonascii)
> +allownonascii=$(git config --type=bool hooks.allownonascii)
>  
>  # Redirect output to stderr.
>  exec 1>&2
> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
> index 80ba94135c..5014c4b31c 100755
> --- a/templates/hooks--update.sample
> +++ b/templates/hooks--update.sample
> @@ -43,11 +43,11 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
>  fi
>  
>  # --- Config
> -allowunannotated=$(git config --bool hooks.allowunannotated)
> -allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
> -denycreatebranch=$(git config --bool hooks.denycreatebranch)
> -allowdeletetag=$(git config --bool hooks.allowdeletetag)
> -allowmodifytag=$(git config --bool hooks.allowmodifytag)
> +allowunannotated=$(git config --type=bool hooks.allowunannotated)
> +allowdeletebranch=$(git config --type=bool hooks.allowdeletebranch)
> +denycreatebranch=$(git config --type=bool hooks.denycreatebranch)
> +allowdeletetag=$(git config --type=bool hooks.allowdeletetag)
> +allowmodifytag=$(git config --type=bool hooks.allowmodifytag)

OK.

>  # check for no description
>  projectdesc=$(sed -e '1q' "$GIT_DIR/description")
>
> base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0

Offtopic.  This is probably what GGG added, but can we hide it
behind the "-- " marker?
