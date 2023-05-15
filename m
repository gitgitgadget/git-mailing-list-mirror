Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA70CC77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 07:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbjEOHDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 03:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbjEOHC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 03:02:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88367199B
        for <git@vger.kernel.org>; Mon, 15 May 2023 00:02:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B6AC1EAEFC;
        Mon, 15 May 2023 03:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=7fKqVgOBR8n5PHBYmKoE6F8qZqNVEQhb6Qn/9FxOICU=; b=Ou+/
        grFcec6HLpWWBqbJem6vs+KbCtpB4btpZBkDIcvUCzzeJQlCNWsZXimAP+SOxJGt
        l8WsDDPmCyWorpJa9OI5HSDaB41F+nKCRoDSGdz6lsqmOIT23ndKdUkYNpvrNmgG
        Fg9bATwtEA4JnZC8DOWYbtsr3pLMJThZZmoUoxE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03B781EAEFB;
        Mon, 15 May 2023 03:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 357071EAEF9;
        Mon, 15 May 2023 03:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Corentin Garcia via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Corentin Garcia <corenting@gmail.com>
Subject: Re: [PATCH] doc/git-config: add unit for http.lowSpeedLimit
References: <pull.1507.git.git.1683970203084.gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 00:02:43 -0700
Message-ID: <xmqqy1lq9iwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DA3598C-F2EE-11ED-BA35-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Corentin Garcia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Corentin Garcia <corenting@gmail.com>
>
> Add the unit (bytes per second) for http.lowSpeedLimit
> in the documentation.
>
> Signed-off-by: Corentin Garcia <corenting@gmail.com>
> ---

SOunds good.

>     doc/git-config: add unit for http.lowSpeedLimit
>     
>     Add the unit (bytes per second) for http.lowSpeedLimit in the
>     documentation.

You do not have to repeat your log message here.

> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index afeeccfbfa7..51a70781e58 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -246,8 +246,9 @@ significantly since the entire buffer is allocated even for small
>  pushes.
>  
>  http.lowSpeedLimit, http.lowSpeedTime::
> -	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
> -	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
> +	If the HTTP transfer speed, in bytes per second, is less than
> +	'http.lowSpeedLimit' for longer than 'http.lowSpeedTime' seconds,
> +	the transfer is aborted.
>  	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
>  	`GIT_HTTP_LOW_SPEED_TIME` environment variables.

As the variable is read with git_config_int(), this also allows the
usual k/m/g suffix to scale, i.e. specifying it to 500k would mean
500*1024 bytes.  I wonder if that is also worth documenting, or it
is too obvious.

Let's queue this patch as-is.  If somebody wants to elaborate on how
the numbers can be spelled, that can be done in a separate patch.

Thanks.

