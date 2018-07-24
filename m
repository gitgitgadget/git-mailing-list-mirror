Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C501F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbeGXTUw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:20:52 -0400
Received: from [195.159.176.226] ([195.159.176.226]:56130 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbeGXTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:20:52 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1fi1lx-0003dp-VJ
        for git@vger.kernel.org; Tue, 24 Jul 2018 20:10:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v1] msvc: fix non-standard escape sequence in source
Date:   Tue, 24 Jul 2018 20:13:00 +0200
Message-ID: <e443fe24-e072-d11c-a6b0-53e7de8a7f5c@drbeat.li>
References: <20180724144249.2857-1-git@jeffhostetler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
Cc:     gitster@pobox.com, peff@peff.net, larsxschneider@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
In-Reply-To: <20180724144249.2857-1-git@jeffhostetler.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff

On 24.07.18 16:42, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Replace non-standard "\e" escape sequence with "\x1B".

This was already fixed in <20180708144342.11922-4-dev+git@drbeat.li>.

Cheers,
Beat


> 
> In commit 7a17918c34f4e83982456ffe22d880c3cda5384f a trace message with
> several "\e" escape sequences was added.  This causes a compiler warning
> under MSVC.
> 
> According to [1], the "\e" sequence is an extension supported by GCC,
> clang, and tcc.
> 
> [1] https://en.wikipedia.org/wiki/Escape_sequences_in_C
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  convert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/convert.c b/convert.c
> index 56cfe31..52092be 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -335,7 +335,7 @@ static void trace_encoding(const char *context, const char *path,
>  	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
>  	for (i = 0; i < len && buf; ++i) {
>  		strbuf_addf(
> -			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
> +			&trace,"| \x1B[2m%2i:\x1B[0m %2x \x1B[2m%c\x1B[0m%c",
>  			i,
>  			(unsigned char) buf[i],
>  			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
> 


