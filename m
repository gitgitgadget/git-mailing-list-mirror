Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D23D1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbdCaVSi (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 17:18:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60846 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753430AbdCaVSh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 17:18:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 810887F38E;
        Fri, 31 Mar 2017 17:18:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KiBRPNoXdaEP3LnnAFPqLU+y9vU=; b=Wjusq0
        MzJO9wThKaRuM73KAFNId91JaYVOu+c7czsFs8aNowb55fgFK8qzTM8Lo23QoBbM
        ssQwqs7TKf7G/H26rLBBiEiON9QzCpaYSE1xJd5AF8O6csG8Qwp0gDrQzvuuFGva
        TBHIzfYHl9/K7H9ozBrmntnT3unmYlpSbCR4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a+UkZXNi49iQpn7IGNa112m+dlILeVdG
        zZ4iBbWY9ZTMSa2TXqpfGlXQH4UdHYIVlgLN+BDbtOWEF4xawbb34lo0jZN4I8N2
        GzT5NDpiPGE7F0Dx4mZivlNmtYvSlL9Osp3i8jAuXzHJUlEy9VQyVyo5tR0vj4gC
        rWpZNbLq8c0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 791067F38D;
        Fri, 31 Mar 2017 17:18:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C71907F38C;
        Fri, 31 Mar 2017 17:18:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, kewillf@microsoft.com,
        Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] name-hash: fix buffer overrun
References: <20170331173214.47514-1-git@jeffhostetler.com>
        <20170331173214.47514-2-git@jeffhostetler.com>
        <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 31 Mar 2017 14:18:34 -0700
In-Reply-To: <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 31 Mar 2017 12:35:21 -0700")
Message-ID: <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99F3A7A6-1657-11E7-99DE-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Will queue with ...
>
>>  name-hash.c                             |  4 +++-
>>  t/t3008-ls-files-lazy-init-name-hash.sh | 19 +++++++++++++++++++
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>  create mode 100644 t/t3008-ls-files-lazy-init-name-hash.sh
>
> ... this thing fixed by "chmod +x" (otherwise the tests won't start).
>
> Thanks.

Also, https://travis-ci.org/git/git/jobs/217303927 seems to say that
MacOS is not happy with this change.
