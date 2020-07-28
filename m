Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76214C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4697F2074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xpDA0LMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgG1WXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:23:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60121 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgG1WXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:23:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32D32D9D54;
        Tue, 28 Jul 2020 18:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ndpzGfyU8yNZgyFj3iRrorsYY8=; b=xpDA0L
        MYqbjuyMci+1ak74A03TkuFWIGe2cnotciJIVTsDouiiCLY2WDYL6Wt76jVOogHO
        lGAW8E/+hbeIEKTgajG5iuLsz8TyzEEDyKxnhc9zG3fT5cvb4nD89gwCNJXrWuNo
        wMNRdIelCTaGpISRxS8aafmSVBcH1bTljNvKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tRgJDBgogI+QCBRuXgl5BKel5EEpsxrD
        n30/OnTGwXsTLF6VYfaN4rgpkm5Ld7M8h4mmZAR8A8kD6wBKVpDGXlOwPTGhxNMy
        FQ1TehGY+m3MPK3pgabHAaUlSyDqj6J3cnqFysRg+UBvsJDdako0xNO9Ptdt7ZRw
        NcfOlAocOoc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26C13D9D52;
        Tue, 28 Jul 2020 18:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 700EAD9D46;
        Tue, 28 Jul 2020 18:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] strvec: drop argv_array compatibility layer
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <20200728202709.GJ1021513@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 15:23:45 -0700
In-Reply-To: <20200728202709.GJ1021513@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 16:27:09 -0400")
Message-ID: <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0155B83A-D121-11EA-AE84-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There are no callers which need it anymore. Any topics in flight will
> need to be updated as they get merged in (but the compiler will make
> that quite clear).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strvec.h | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/strvec.h b/strvec.h
> index 4be39c8a48..bd35de1ce4 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -86,17 +86,4 @@ void strvec_clear(struct strvec *);
>   */
>  const char **strvec_detach(struct strvec *);
>  
> -/* compatibility for historic argv_array interface */
> -#define argv_array strvec
> -#define ARGV_ARRAY_INIT STRVEC_INIT
> -#define argv_array_init strvec_init
> -#define argv_array_push strvec_push
> -#define argv_array_pushf strvec_pushf
> -#define argv_array_pushl strvec_pushl
> -#define argv_array_pushv strvec_pushv
> -#define argv_array_pop strvec_pop
> -#define argv_array_split strvec_split
> -#define argv_array_clear strvec_clear
> -#define argv_array_detach strvec_detach
> -
>  #endif /* STRVEC_H */

It was more painful than I would have thought to merge this topic,
as we seem to have gained quite a few new calling sites (it shows
how popular and useful this API is).  Hopefully some of the merge
conflict resolutions would be resurrected automatically from the
rerere database ;-)

