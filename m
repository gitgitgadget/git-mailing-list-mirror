Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89625C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5CA61103
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbhIGVK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:10:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62620 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbhIGVK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:10:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C3B71604F7;
        Tue,  7 Sep 2021 17:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LDIAWIZv3k2t0cDDNUtQifmHCx5qqhjjB+Rvx5
        4HasE=; b=CyMG5vtFU1cph4OjLr9smm5vYB7X6Ypr6jXYinikKntWtu8bHdrfvo
        kuKF7dIPEXJ2gLQv0MqRQSJq6RcQ2lzbEbQBJaUrKwrIZ7GxkgF4TFn7wEu8Hi8V
        Ahg+hYVpCURRJ0nWurxxZCUZot5YGDOUXIJMRtL+3UPsIdPD6KDOs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E13E71604F6;
        Tue,  7 Sep 2021 17:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30DCA1604F5;
        Tue,  7 Sep 2021 17:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: fix default directory of git bugreport -o
References: <20210903115933.622847-1-bagasdotme@gmail.com>
Date:   Tue, 07 Sep 2021 14:09:46 -0700
In-Reply-To: <20210903115933.622847-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 3 Sep 2021 18:59:34 +0700")
Message-ID: <xmqqa6ko9jol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF0B41F6-101F-11EC-A6C4-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> git bugreport writes bug report to the current directory by default,
> instead of repository root.
>
> Fix the documentation.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git-bugreport.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Emily, ack?  It seems that after we cdup to the top, we adjust
either the value of -o or "" with the prefix to come up with the
output location, so the default seems to be "the current" as the
updated documentation says.


> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index 66e88c2e31..d8817bf3ce 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -40,8 +40,8 @@ OPTIONS
>  -------
>  -o <path>::
>  --output-directory <path>::
> -	Place the resulting bug report file in `<path>` instead of the root of
> -	the Git repository.
> +	Place the resulting bug report file in `<path>` instead of the current
> +	directory.
>  
>  -s <format>::
>  --suffix <format>::
>
> base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
