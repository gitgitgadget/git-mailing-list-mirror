Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1086CC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79F860FC0
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhHKHOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:14:41 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:40784 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234960AbhHKHOl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:14:41 -0400
X-Greylist: delayed 36987 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 03:14:41 EDT
Received: from [192.168.1.103] (089144194204.atnat0003.highway.a1.net [89.144.194.204])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Gl1K23gYnz5tlL;
        Wed, 11 Aug 2021 09:14:14 +0200 (CEST)
Subject: Re: Re* [PATCH v4] userdiff: improve java hunk header regex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
References: <20210810190937.305765-1-tsdh@gnu.org>
 <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
 <xmqq35rhc5la.fsf_-_@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <157a0c35-1c82-9a2e-3bcd-ae6059ec71bd@kdbg.org>
Date:   Wed, 11 Aug 2021 09:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq35rhc5la.fsf_-_@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.21 um 00:12 schrieb Junio C Hamano:
> Subject: userdiff: comment on the builtin patterns
> 
> Remind developers that they do not need to go overboard to implement
> patterns to prepare for invalid constructs.  They only have to be
> sufficiently permissive, assuming that the payload is syntactically
> correct.
> 
> Text stolen mostly from Johannes Sixt.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  userdiff.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git c/userdiff.c w/userdiff.c
> index d9b2ba752f..1a6d27fda6 100644
> --- c/userdiff.c
> +++ w/userdiff.c
> @@ -13,6 +13,16 @@ static int drivers_alloc;
>  #define IPATTERN(name, pattern, word_regex)			\
>  	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
>  	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
> +
> +/*
> + * Built-in drivers for various languages, sorted by their names
> + * (except that the "default" is left at the end).
> + *
> + * When writing or updating patterns, assume that the contents these
> + * patterns are applied to are syntactically correct.  You do not have
> + * to implement all syntactical corner cases---the patterns have to be
> + * sufficiently permissive.
> + */

IMO, as written, the comment falls short of suggesting that patterns can
be simple. How about appending "and can be simple"?

>  static struct userdiff_driver builtin_drivers[] = {
>  IPATTERN("ada",
>  	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
> 

