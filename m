Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F533C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290AB61164
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhFPJYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 05:24:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhFPJYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 05:24:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02688145F88;
        Wed, 16 Jun 2021 05:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=czHUm6IeJZY9B7CniM9cZm77cE1EyWy+sEV7mj
        0iMMk=; b=GqrxcVVHaKH3g/5GgoK+VxjVH2oIY7yXM+zqSyj1yCeQ77ArJlg+IN
        rApaR2xgyWupLDTfYWBpNrx2Kc7qFQQp41NMvOO85cEKDYg6JZ/6Im/OL+8R/0q9
        Hrl3fVWM5VMilxfcBCA4WvSbfzyj3joMghnYaq5wWnOUEQuxSxwRE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EED7B145F87;
        Wed, 16 Jun 2021 05:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72EEF145F86;
        Wed, 16 Jun 2021 05:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
References: <xmqqa6nqsd2i.fsf@gitster.g>
        <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
        <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
Date:   Wed, 16 Jun 2021 18:22:10 +0900
In-Reply-To: <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 16 Jun 2021 04:36:39 -0400")
Message-ID: <xmqqeed2p3jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 552B8AB4-CE84-11EB-88D0-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Still, I kind of like the "set -f" version because it doesn't need
> the extra directory which could cause problems with "ls-files -o", etc,
> as you mentioned. You could also create the empty directory on the fly,
> though if "set -f" works portably, that seems less complicated to me.

FWIW, I share that.
