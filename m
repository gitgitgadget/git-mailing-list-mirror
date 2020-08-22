Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1266BC433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB95C2072D
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LxuDhIVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgHVT1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:27:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57065 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgHVT1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 15:27:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3DE483E75;
        Sat, 22 Aug 2020 15:27:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JgNsqbHlR9Ei1FI1MECCsUoWCF8=; b=LxuDhI
        VN1LZ395U7dkdF/YKy380k6jmxrAyp/Vtxk7x/7cuxJQxnw2O/eR+A1e2eqBDaSE
        tNcU6JPXdnLDxu4Gds8Euzp9D3PYe3p27XLRL5Nf/yd/ABwhuVnmdR9sW8ksvo94
        L5vm9/WdxDyDfuz0cNDOeA8+S4qo6LRQtwQt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tb3fnKgtcs62OLO4xQtfd0Xmfe4EFXWW
        RSPqnXmVECCM3Zyl+ATunLcQC5g9CXswL+g9P6jotpk/agJnFr3Ih9GjoWB2O8+n
        tQyxRHSIfZ/PBpuSGnMo3eryGre9b/1D7M4GZFzmfKJy3RTDUpY0i/V16F0CxCOO
        3dULgPlZj14=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9934783E74;
        Sat, 22 Aug 2020 15:27:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0778283E73;
        Sat, 22 Aug 2020 15:27:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: style(git-gui): Fix mixed tabs & spaces; Always use tabs.
References: <20200822105616.68296-1-serg.partizan@gmail.com>
Date:   Sat, 22 Aug 2020 12:26:59 -0700
In-Reply-To: <20200822105616.68296-1-serg.partizan@gmail.com> (Serg
        Tereshchenko's message of "Sat, 22 Aug 2020 13:56:16 +0300")
Message-ID: <xmqq7dtq7a7w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7324C402-E4AD-11EA-985C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Serg Tereshchenko <serg.partizan@gmail.com> writes:

> Hello.
>
> I want to improve styling of git-citool, so it supports dark themes.
> But first i want to remove "mixed indent warning" from my editor
> modeline.
>
> This patch does not change anything besides indents, and sometimes i
> replace
>
> ```tcl
> if {long ||
>     multiline ||
>     statement}
> ```
>
> with more readable
>
> ```tcl
> if {
>     long
>     || multiline
>     || statement
> }
> ```
> But only in lines with mixed indents.

You don't ever want to do that in a patch for "fix indentation"
patch.

Besides, the comparison between these two styles is subjective, and
you do not represent the majority view of who needs to work on the
code in git-gui, so "with more readable" is not a very good
justification to do so.

If the existing code in the whole file uses mixture of both styles,
and one style is used overwhelmingly more than the other, a
follow-up patch to adjust the style to one, with "consistency" as
the justification, would be a good idea, though.

Thanks.
