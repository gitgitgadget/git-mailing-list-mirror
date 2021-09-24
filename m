Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E9C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204AE61242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbhIXVcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:32:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34377 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347407AbhIXVcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:32:15 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4HGQDt6kRzz5tlC;
        Fri, 24 Sep 2021 23:30:38 +0200 (CEST)
Subject: Re: js/win-lazyload-buildfix (was Re: What's cooking in git.git (Sep
 2021, #07; Thu, 23))
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqa6k2yj1j.fsf@gitster.g> <YU2W24RUaN4OHrcn@carlos-mbp.lan>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3f963bba-3197-8c52-9828-6d78ef1d25b1@kdbg.org>
Date:   Fri, 24 Sep 2021 23:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YU2W24RUaN4OHrcn@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.21 um 11:14 schrieb Carlo Marcelo Arenas Belón:
> Subject: [PATCH] fixup! lazyload.h: fix warnings about mismatching function
>  pointer types
> 
> The original patch will require the declaration this macro creates
> to be moved to the end of the local variables or will trigger
> -Wdeclaration-after-statement because it will likely end in ";;" if
> the macro call has one, as it is common.
> 
> Remove trailing ';' from macro definition, for easy of use.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  compat/win32/lazyload.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
> index c688e545ad..2b3637135f 100644
> --- a/compat/win32/lazyload.h
> +++ b/compat/win32/lazyload.h
> @@ -29,7 +29,7 @@ struct proc_addr {
>  	static struct proc_addr proc_addr_##function = \
>  	{ #dll, #function, NULL, 0 }; \
>  	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
> -	static proc_type_##function function;
> +	static proc_type_##function function
>  
>  /*
>   * Loads a function from a DLL (once-only).
> 

Good find! This looks correct. The trailing semicolon was not present
before I added it with my change. Thank you very much for fixing up my
carelessness.

-- Hannes
