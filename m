Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853FC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 20:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B8B20752
	for <git@archiver.kernel.org>; Tue,  5 May 2020 20:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uJvgS4fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEEUkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 16:40:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51130 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEEUkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 16:40:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 012A4574EC;
        Tue,  5 May 2020 16:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iqeM7bD9P6jIr5QiRCXaZCxS4q8=; b=uJvgS4
        fMCflW3XCrRq+2AJijCbfzYHpMGN/pscr/LhfN6OlsLXM1HlEajxH09gnzjTFGrK
        kCW6HibKhkWI/uHTTh/LTUOb1TbW4pu2HvG0gR9uPzvuP/b/qRetWtGKTMelwisC
        LR4qKqWBnlMeU+wZfDCe508hG4Ro2kzw+TQrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYa7EEHDUsRMqq1kJXVT9+U7uLFTSxoJ
        r7kLL14+igPFIHy5Mm9MLN66NZ4Ms+z5UJsEGJhKmVOTzKQimhW4fo5c+XqWned4
        raU/iHY3OsymZywPhkY0QoZhayCa9T3Z7VAXGsU/oyjSy+uWVXbhlyp81wHP97Uo
        x+63fUua46g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A11D4574EA;
        Tue,  5 May 2020 16:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1D9C574E6;
        Tue,  5 May 2020 16:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Danh Doan <congdanhqx@gmail.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: drop arithmetic expansion advice to use "$x"
References: <20200503090952.GA170768@coredump.intra.peff.net>
        <20200503091157.GA170902@coredump.intra.peff.net>
        <20200503114351.GA28680@danh.dev>
        <20200504151351.GC11373@coredump.intra.peff.net>
        <xmqqh7wviud9.fsf@gitster.c.googlers.com>
        <20200504160709.GB12842@coredump.intra.peff.net>
Date:   Tue, 05 May 2020 13:40:03 -0700
In-Reply-To: <20200504160709.GB12842@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 4 May 2020 12:07:09 -0400")
Message-ID: <xmqqr1vy9kv0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A36E6BC-8F10-11EA-9BFD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 390ceece52..a89e8dcfbc 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -95,10 +95,6 @@ For shell scripts specifically (not exhaustive):
>  
>   - We use Arithmetic Expansion $(( ... )).
>  
> - - Inside Arithmetic Expansion, spell shell variables with $ in front
> -   of them, as some shells do not grok $((x)) while accepting $(($x))
> -   just fine (e.g. dash older than 0.5.4).
> -
>   - We do not use Process Substitution <(list) or >(list).
>  
>   - Do not write control structures on a single line with semicolon.

A new entry in the "What's cooking" report has this:

    * jk/arith-expansion-coding-guidelines (2020-05-04) 1 commit
     - CodingGuidelines: drop arithmetic expansion advice to use "$x"

     The coding guideline for shell scripts instructed to refer to a
     variable with dollar-sign inside airthmetic expansion to work
     around a bug in old versions of bash, which is a thing of the past.
     Now we are not forbidden from writing $((var+1)).

Writing the last sentence made me wonder if we should go one step
further and actually encourage actively omitting the dollar-sign
from variable reference instead.
