Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC8AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C8360F56
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhIVUdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:33:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64268 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhIVUdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:33:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20D93E9AC2;
        Wed, 22 Sep 2021 16:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3s4xOLppHWjpQT8vfNJMQXTzoeqsKQXXbf1wKb
        NnPCI=; b=gi2acnxXoDbKDPX6+zO5gEc2QTp8JoAcu/yMrQOTJgN9rLHK1MVWTL
        PZFTN2xQ8bkZlJcROU8GFAREXghFFaBTmucV9TExdVz3VD9rKrWIqwNzvp6+4XAE
        a503C9aQV3DkV3/Js5o2E9e1Wk2TDnqLobHEIdeDHWm2Y4UqNemlI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 165D6E9AC1;
        Wed, 22 Sep 2021 16:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7122BE9AC0;
        Wed, 22 Sep 2021 16:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: clean .depend dirs under
 COMPUTE_HEADER_DEPENDENCIES != yes
References: <patch-1.1-b8bde2ee7b7-20210922T201615Z-avarab@gmail.com>
        <YUuRWT8+Q4ls6BHu@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 13:31:34 -0700
In-Reply-To: <YUuRWT8+Q4ls6BHu@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Sep 2021 16:26:01 -0400")
Message-ID: <xmqqpmt05p3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14AA3E10-1BE4-11EC-BF11-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> See http://lore.kernel.org/git/xmqqmto48ufz.fsf@gitster.g for a report
>> about this issue.
>
> This makes perfect sense to me. Nicely explained, and the patch is
> simpler than I'd have expected. :)

For the record, I did *not* (and I right now do not) consider this
behaviour as an "issue" when I mentioned it.  It's like building
with a setting that requires some compat/ stuff and then cleaning
without the setting, no?  i.e. cruft left behind is something the
user deserves to see.

Since there is no other useful purpose for these .depend directories
to exist, I do not mind if "make clean" removed them, though ;-)

Thanks.
