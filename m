Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51CD207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 20:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbcJFULZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 16:11:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62138 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933172AbcJFULY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 16:11:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1346A4442A;
        Thu,  6 Oct 2016 16:11:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVY9U5MAbM6zGolvBl2ts7WXxIY=; b=c6L3tL
        O69gfYEHg2xOsUOJOoPk02E93xCZSK9GpTvYxzQG9Po3l1gRlJWkNhTw+qrzPfEC
        WUYuK01sj5US3i1g5B1STrALwMazkzFFGYqrpqUHJapQX8+h3Ef2k6OeLoRyMGZR
        YGZvI7cP9yoXb2gCKvs+OIn/p6qbQFGDKEGho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nHUWkc5iWv9ZF+bdEj9UVeW7vzD1SiEQ
        8m//9+NuVo/6F9hHR5c8NfkjMPlPFHJAWOd5bte/RQgq21qewHEKHNBIan8h2GZY
        W2p3Y8tBNY0WvHYULqnWMEsyn3J3JJG/RjSmO8Ig1PjMRmTIiCls4PR9c+NpxKIH
        W+7OPFYFoic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B86444427;
        Thu,  6 Oct 2016 16:11:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8005044426;
        Thu,  6 Oct 2016 16:11:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, peff@peff.net
Subject: Re: [PATCH 1/2] submodule add: extend force flag to add existing repos
References: <20161006193725.31553-1-sbeller@google.com>
        <20161006193725.31553-2-sbeller@google.com>
Date:   Thu, 06 Oct 2016 13:11:20 -0700
In-Reply-To: <20161006193725.31553-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 6 Oct 2016 12:37:24 -0700")
Message-ID: <xmqqshs9i6fr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D2E3B1E-8C01-11E6-91B4-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently the force flag in `git submodule add` takes care of possibly
> ignored files or when a name collision occurs.
>
> However there is another situation where submodule add comes in handy:
> When you already have a gitlink recorded, but no configuration was
> done (i.e. no .gitmodules file nor any entry in .git/config) and you
> want to generate these config entries. For this situation allow
> `git submodule add` to proceed if there is already a submodule at the
> given path in the index.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Yup, the goal makes perfect sense.  

I vaguely recall discussing this exact issue of "git submodule add"
that refuses to add a path that already is a gitlink (via "git add"
that has previously been run) elsewhere on this list some time ago.

