Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73FDC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912AA6101E
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJ2UNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:13:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62757 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJ2UNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:13:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BBBEE15FC;
        Fri, 29 Oct 2021 16:11:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Npp3bRlUZl4hoBdF80kogWmKcGKfgTfs5tcqqw
        nfg8I=; b=gd3WLvrtsSzziZTxX3hQUwY9Fbm3OF/U/TLSah5rLoFSNmlJeaeGva
        LiQUoHrkvm4vNoiygxhatgRkMHrWl6iOtr+luQu+1yTMBZGC6ShF70mC8UiaCToU
        G+j/AWnW4OMdby8Npj4Bw41lTyCFOeGPi0q7pRFuthvoY7wQaOvQU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72283E15FA;
        Fri, 29 Oct 2021 16:11:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC4CBE15F6;
        Fri, 29 Oct 2021 16:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] pretty.c: rework describe options parsing for
 better extensibility
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
        <20211029184512.1568017-1-eschwartz@archlinux.org>
        <20211029184512.1568017-2-eschwartz@archlinux.org>
Date:   Fri, 29 Oct 2021 13:11:21 -0700
In-Reply-To: <20211029184512.1568017-2-eschwartz@archlinux.org> (Eli
        Schwartz's message of "Fri, 29 Oct 2021 14:45:10 -0400")
Message-ID: <xmqq35ojlhg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 632A599E-38F4-11EC-BD30-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

> +	struct {
> +		char *name;
> +		enum { OPT_STRING } type;
> +	}  option[] = {
> +		{ "exclude", OPT_STRING },
> +		{ "match", OPT_STRING },
> +	};

I floated OPT_<TYPE> in my earlier illustration as "something like
this", not "literally use these tokens".  We have CPP macros of the
same name in parse-options.h API---we may not see troubles from the
name clashes today, but let's not leave it to chances.

Perhaps call it like DESCRBE_ARG_STRING or something that ensures
uniqueness like that?

Thanks.
