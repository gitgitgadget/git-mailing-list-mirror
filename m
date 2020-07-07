Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA919C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 01:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB86120708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 01:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lg2BT94+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGGBil (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:38:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64946 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgGGBil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 21:38:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 476526897F;
        Mon,  6 Jul 2020 21:38:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gu2vVK8zKWJ6fpAMq5rrj14N0fI=; b=lg2BT9
        4+iHsNzGRE14FQ9Hg7W8nmCh66qOSzUMl0z9Vi7afIhCGroLB/UIB5VHCjtpCten
        CyOP/eoJ9bn44oQEQPgUNpcQVl4v67Okt1L3AHpdD1uFxDW2iv/f5D8u1+lDn3/E
        F/k2m2bHPMGh+yP8V2xTV/Q1tykJ5yKC0i9fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hW4PgPtwcwYRbBQZvxPpHujIgGsYooz1
        BzP7+XqrTxoNS09PvqHPyB5El59VM1TBYpKD0aFQ7EQzsKOGPKtjtnMvRbtw+yF/
        z9vevF/yPWz8KTV7r1xaD1yinN1ephQm2FpC1zXQm6zxf0iPQyMCacBnDUnhCaYF
        na2sUUHFTeU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ED9C6897E;
        Mon,  6 Jul 2020 21:38:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C20346897C;
        Mon,  6 Jul 2020 21:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     trygveaa@gmail.com, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] Wait for child on signal death for aliases to externals
References: <20200704221839.421997-1-trygveaa@gmail.com>
        <20200704221839.421997-2-trygveaa@gmail.com>
        <20200706211403.GB85133@coredump.intra.peff.net>
Date:   Mon, 06 Jul 2020 18:38:38 -0700
In-Reply-To: <20200706211403.GB85133@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 6 Jul 2020 17:14:03 -0400")
Message-ID: <xmqq5zb085pd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94D3B368-BFF2-11EA-BB0C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sorry that ended up so long-winded, but my conclusion is: this is doing
> the right thing. We should probably embed some of that discussion in the
> commit message, but I think the simplest argument is just: this is what
> we do for external commands we run, so treating shell aliases the same
> in terms of passing along signals makes things simple and consistent.

Thanks for a great analysis to help the author.

