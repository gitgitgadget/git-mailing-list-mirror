Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA111F454
	for <e@80x24.org>; Thu,  7 Nov 2019 09:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfKGJ4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 04:56:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51629 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733271AbfKGJ4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 04:56:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68C218E7D5;
        Thu,  7 Nov 2019 04:56:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b3KMF5vkg2Vn/ZrsVpzqusCi1vY=; b=NHxCyz
        +87zYO9sQJ9eUFMX/lsxFOvPGwkQp4887RwngwmezBVRAfhWYyvfWu9QYdnBrJHg
        6hXcLyvgk9ufP9A2O8oGXpCvIS2pwcxN7LiXTefHVM7wl2HLm1dDkvGT6MNXe3Nx
        79Z4Nl7NEL+RLBQzlDzmMxkBEYlTrWClqsYH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mjVSWKr0Q5sEr4trzyAptX1fM/jaxnbI
        lx7hF+1JcnlV9kCEq3MCqxYGYuGZ29bJF1LQ2r5s5P3FDm/XjUM6NP+ed+TwPZQl
        7khZMLfcN9WQ9zbPmw9ZY4Qz3+a6KjLWhO5ybyMQKrzxmFhCSzZAOEYTooM18BXG
        qF5PGxXPb7o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6154E8E7D4;
        Thu,  7 Nov 2019 04:56:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 911D78E7D2;
        Thu,  7 Nov 2019 04:55:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 1/6] [Outreachy] merge-ours: include parse-option.h
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
        <5e3b370b3bf8f34cd975da41fb2a7cc0f633954a.1573114201.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 18:55:57 +0900
In-Reply-To: <5e3b370b3bf8f34cd975da41fb2a7cc0f633954a.1573114201.git.gitgitgadget@gmail.com>
        (george espinoza via GitGitGadget's message of "Thu, 07 Nov 2019
        08:09:55 +0000")
Message-ID: <xmqqy2wsovrm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCF3025C-0144-11EA-87BC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: george espinoza <gespinoz2019@gmail.com>
>
> Prepare this command which currently handles its own argv to use
> parse-options instead. A lot of the commands already have
> parse-options and in git.c cmd_struct with the "NO_PARSEOPT" are
> the one's that still need it.
>
> Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> ---
>  builtin/merge-ours.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index 4594507420..3980f4899a 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -11,6 +11,11 @@
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "diff.h"
> +#include "parse-options.h"
> +
> +/* parse-options.h added to initiate replacement of manual option parsing
> + * with parse-options. 
> + */

See Documentation/CodingGuidelines and learn how we write multi-line
comments.

Since there is no "manual option parsing" to be replaced, there is
no other change to this file, I guess (so what's the point of this
step?).


