Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C8C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 04:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA3660F11
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 04:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJMEuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:50:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62241 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhJMEuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 00:50:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E808A167CBE;
        Wed, 13 Oct 2021 00:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=gBD7IcX5oqSkYeCqap38eGcezKrqGIYQSFPkZLTC1Fs=; b=u0zJ
        acah1L5uvD3Zn3zzZCxeTwd9bR5rf5jOtSJSdmwACLmXWjk+E3/SAhQzQisD/EXL
        zOHYmZyOfSE4UmEU/bVc//KIC719dM0ZAEE39O6RU+o/52pH/VyR93LERBO3ldi7
        w0p7HDNo2EKToIkKDQGpQLuJy10bQrMAZ5PvYXY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0FB4167CBC;
        Wed, 13 Oct 2021 00:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A2CE167CBB;
        Wed, 13 Oct 2021 00:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
        <xmqqa6je8n5c.fsf@gitster.g> <xmqqo87u777d.fsf@gitster.g>
        <87k0ii446g.fsf@osv.gnss.ru> <xmqqzgre40ff.fsf@gitster.g>
        <87lf2yqevj.fsf@osv.gnss.ru>
Date:   Tue, 12 Oct 2021 21:48:04 -0700
Message-ID: <xmqqo87til8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C10D7620-2BE0-11EC-87FC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I didn't ask you what --staged is suitable for, sorry. I asked how do
> you solve the problem of saving an *entirely unrelated* subset of
> changes for future use?

Ah, OK.  I do not think I would "git add" unrelated pieces in the
first place, so "add -p && stash --staged" as a way to stash away
such a change would be quite foreign concept in my workflow.

IOW, I'd concentrate on finishing the step I am working on, leaving
unrelated changes in the working tree, and when I came to a good
stopping point, I'd do the "stash -k && test && commit" dance,
followed by "stash pop".  At that point,the working tree would have
only unrelated changes that I can stash away with "stash save".

So I guess perhaps your "no such problem for me" is the closest?

Thanks.
