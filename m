Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A0C1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbcHXSAp (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:00:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59880 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752703AbcHXSAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:00:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8AD6372DE;
        Wed, 24 Aug 2016 13:59:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TfVpmlw+aihyGKpRF/ktAU4hqEI=; b=bW2OUT
        s9GDfdk6+vGU+eJpXpfCKU1Zfk/n/sB4iOAkY2hEH59hhsHk4Kr4GINjVG3KcbqA
        qruk3yLcxWqs55etJKjlJWvP/xK45MWxHtdf0/94HluYpvhw3ewhD6BD8waBf69v
        KbrNA2n7zBCaftK4V9couuX3NOnKSdnb5BaLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BjzZawrBm4A9CL/vU/HYT0Et2tSaelgw
        t5lkAQQRYVuo0x7MIg62YmYdpgi+wYuBJ5kUvi+Vprpa+c+pliKhY8AYafhhLWuD
        PiWlVSedENV/w+kO9HzDAQXQpvOYKSqDZMeANESkC1E6IN2xGj0zlQ3TBbshgiBW
        rdC59iB1a+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0D3D372DD;
        Wed, 24 Aug 2016 13:59:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57961372DA;
        Wed, 24 Aug 2016 13:59:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] release_delta_base_cache: reuse existing detach function
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
        <20160822215758.uamavr7koin3ze6c@sigill.intra.peff.net>
        <xmqqwpj7tauc.fsf@gitster.mtv.corp.google.com>
        <20160824174122.372c7pi4ub5bxcat@sigill.intra.peff.net>
Date:   Wed, 24 Aug 2016 10:59:54 -0700
In-Reply-To: <20160824174122.372c7pi4ub5bxcat@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 24 Aug 2016 13:41:22 -0400")
Message-ID: <xmqq60qqqc85.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90E57994-6A24-11E6-8BC3-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That is not too bad, I guess. I can switch it if you prefer that way.
> Since there are only these two callers with two different sets of needs
> (and the function is static), I just let them continue inspecting the
> elements directly.

I do not think it is too hard to refactor later when need arises; it
is not like we have too many callers and this is a file-scope static
helper to begin with.
