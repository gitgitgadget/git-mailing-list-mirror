Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18401C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC386619B8
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhCXUXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:23:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54672 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbhCXUXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:23:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF4E9C3D1D;
        Wed, 24 Mar 2021 16:23:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0DLrlxRIx4E6BEgx+OkqxQWfyHg=; b=xGGViI
        SZb1D0bw8Q4dpqt2xH++CIa4YsaqYA+NhwLBXL8a1uGXlZt3gdjcadX21NxTk5/k
        YzzO4z7Cr15l80GJzfCtQoWGCoCMPq89C7sY9+z8TW1MER2gUqPDK7xHSnF7jyzk
        9dy80MjO6AFIDxwVJIGXCDss49PE9qE2A5Wfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h43qGSLVJngCPYAQytLInTYlN9JW6PfV
        /R5YbsD8ic5zV9aSLdRiUQi8nG0t/WvaCsomLX1I6bE2gWQ+x2XiyngWH0PuJzJf
        X5dTTxj/ff6rSVNysyJKk6Ktg6rYCvXhVTlIkxvj0hPtFIUtANpxOQeJSJMtF3d4
        yJFmzPDpTgQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7ADFC3D1C;
        Wed, 24 Mar 2021 16:23:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45C1EC3D1B;
        Wed, 24 Mar 2021 16:23:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] transport.c: modify comment in transport_get().
References: <f64df5f88c6211eb9c9a0024e87935e7@oschina.cn>
Date:   Wed, 24 Mar 2021 13:23:10 -0700
In-Reply-To: <f64df5f88c6211eb9c9a0024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Wed, 24 Mar 2021 13:36:47 +0800")
Message-ID: <xmqqblb8xpw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0F7C600-8CDE-11EB-B5A1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lilinchao@oschina.cn writes:

> From: lilinchao <lilinchao@oschina.cn>
>
> Signed-off-by: lilinchao <lilinchao@oschina.cn>
> ---
>  transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport.c b/transport.c
> index 1c4ab676d1..71b3d44cf3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1078,7 +1078,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  		data->conn = NULL;
>  		data->got_remote_heads = 0;
>  	} else {
> -		/* Unknown protocol in URL. Pass to external handler. */
> +		/* Http/https and other unknown protocol in URL. Pass to external handler. */

The previous block says

		/*
		 * These are builtin smart transports; "allowed" transports
		 * will be checked individually in git_connect.
		 */

where it lists file:// git:// and ssh:// URLs.  And contrasting with
that, it should be clear "unknown" refers to "not a builtin that is
known to the C code linked to the same binary" and includes http://
and https://.

IOW, I am not sure adding "http/https and other" to make it an
overlong line is worth doing.

Thanks.
