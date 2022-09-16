Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57475ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 22:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIPWCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIPWCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 18:02:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6B7A74D
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 15:02:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BE9E149CAA;
        Fri, 16 Sep 2022 18:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZWobb1I4T/jNAqy07mUgG1RTK+jFRQUqmeR4WF
        2Hf80=; b=jTdTIs6GuSKQ5MH7t0wLBi26kBboVSoxfcyH1m4K6lZ3U9VUdDdM7z
        WvFu7HI3RvXRdbt1moHtpBwRe0AmzgqX7i/JSbN/Uh6fQBL22p9J3y1gTq5scjX0
        vkTza1h45Ivg42Kgv4x2L2zHdVDrgmfsByqK9RZd2ScJdB6zZx4zE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23374149CA9;
        Fri, 16 Sep 2022 18:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D587149CA8;
        Fri, 16 Sep 2022 18:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH 1/3] doc/cat-file: allow --use-mailmap for --batch options
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20220916205946.178925-2-siddharthasthana31@gmail.com>
Date:   Fri, 16 Sep 2022 15:02:45 -0700
In-Reply-To: <20220916205946.178925-2-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sat, 17 Sep 2022 02:29:44 +0530")
Message-ID: <xmqqk063f056.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BF6059C-360B-11ED-A67D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> The command git cat-file can now use the mailmap mechanism to replace
> idents with their canonical versions for commit and tag objects. There
> are several options like `--batch`, `--batch-check` and
> `--batch-command` that can be combined with `--use-mailmap`. But, the
> documentation for `--batch`, `--batch-check` and `--batch-command`
> doesn't say so. This patch fixes that documentation.
>
> Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  Documentation/git-cat-file.txt | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index ec30b5c574..5792f21a72 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -89,24 +89,22 @@ OPTIONS
>  --batch::
>  --batch=<format>::
>  	Print object information and contents for each object provided
> -	on stdin.  May not be combined with any other options or arguments
> -	except `--textconv` or `--filters`, in which case the input lines
> -	also need to specify the path, separated by whitespace.  See the
> -	section `BATCH OUTPUT` below for details.
> +	on stdin. May only be combined with `--use-mailmap`, `--textconv` or `--filters`.
> +	In the case of `--textconv` or `--filters` the input lines also need to specify
> +	the path, separated by whitespace. See the `BATCH OUTPUT` section below for details.

The above is not wrong per-se, but I suspect that phrasing it like
so

    * When used with `--textconv` or `--filters`, the input lines must
      specify the path, separated by whitespace.

    * When used with `--use-mailmap`, THIS HAPPENS.

    Cannot be used with any other options.

would be easier to extend.  The same comment applies to the other
two changes in this patch.

As you do not have any code that implements the behaviour of
`--use-mailmap` at this point in the series yet, it might be nicer
to restructure the existing text for existing options in a
preliminary preparation patch, and then add the explanation and the
implementation of `--use-mailmap` option in a separate patch.

Thanks.
