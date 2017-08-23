Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A469B20899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbdHWU3B (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:29:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932407AbdHWU3A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:29:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E05279ED5E;
        Wed, 23 Aug 2017 16:28:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=926Lf8NIqpfAKPLd0iv+SK959J0=; b=iyFpSs
        Ca7IKJF12I5vqEIHRY1R66vXEIvltnkX1gUUvdtLIaYO72zjAaVAzieNrHYevSCv
        xuS+sj8/6IcjThItrFX382lQ/C75Pslvbep+SyytkgaHSLwA6BJL6e8qZdnXU90v
        OlrEabY0HzIst2xyyifNdLDq9sc71fhfhms9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZkpjwJtWDfjzNtKS0e+w50ZM7b7f/x6
        Y8aDeFQIA/dOmVQB6HEdcd1QAAiAnelsE9E8z9tdnraLxRJ1BHng8VYYgGTpHAie
        OskvCs6EIlHLKIxxdTlT0JY/auUOm6VIY670m69JdOKZAqUP90HCeuGYC3NKZJMN
        mXIEYKGOI1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D87ED9ED5C;
        Wed, 23 Aug 2017 16:28:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45E5F9ED5B;
        Wed, 23 Aug 2017 16:28:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>, <peff@peff.net>
Subject: Re: [PATCH v3 4/4] imap-send: use curl by default
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
        <bb94cace-6bc5-2009-7c9d-a6965e3b84c6@morey-chaisemartin.com>
Date:   Wed, 23 Aug 2017 13:28:57 -0700
In-Reply-To: <bb94cace-6bc5-2009-7c9d-a6965e3b84c6@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Tue, 22 Aug 2017 17:56:32
        +0200")
Message-ID: <xmqqpobmxc3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1A93F6C-8841-11E7-90D1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> Now that curl is enable by default,

s/enable/&d/; 

But it is unclear what the above really means.  You certainly do not
mean that [PATCH 1-3/4] somewhere tweaked our Makefile to always use
libcurl and makes Git fail to build without it, but the above sounds
as if that were the case.

> use the curl implementation
> for imap too.

The Makefile for a long time by default set USE_CURL_FOR_IMAP_SEND
to YesPlease when the version of cURL we have is recent enough, I
think.  So I am not sure what you want to add with this change.

> The goal is to validate feature parity between the legacy and
> the curl implementation, deprecate thee legacy implementation

s/thee/the/;

> later on and in the long term, hopefully drop it altogether.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hmph, the patch itself is also confusing.

> diff --git a/imap-send.c b/imap-send.c
> index a74d011a9..58c191704 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -35,11 +35,11 @@ typedef void *SSL;
>  #include "http.h"
>  #endif
>  
> -#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
> -/* only available option */
> +#if defined(USE_CURL_FOR_IMAP_SEND)
> +/* Always default to curl if it's available. */
>  #define USE_CURL_DEFAULT 1

The original says "we want to use CURL, if Makefile tells us to
*AND* if Makefile tells us not to use OpenSSL", which does not make
much sense to me.  I wonder if the original is buggy and should have
been using "|| defined(NO_OPENSSL)" there instead.  

Perhaps that is the bug you are fixing with this patch, and all the
talk about curl is default we saw above is a red herring?  If that
is the case, then instead of removing, turning "&&" into "||" may be
a better fix.  I dunno.

>  #else
> -/* strictly opt in */
> +/* We don't have curl, so continue to use the historical implementation */
>  #define USE_CURL_DEFAULT 0
>  #endif
