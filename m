Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6762FC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D857613C0
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhEDMjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 08:39:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54483 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 08:39:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC34F145425;
        Tue,  4 May 2021 08:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wsoXoIEHWDORCVGyOKmpcydOQUsYFbklRf2O87
        RkQ+g=; b=xPkGew7cKfmKqpqwtHaA5gb/vryBO7oc5FWzbv/3dSdsU6IYf/eiQ6
        HC6buDAwOjNDYZWS/YaIyy21VQOyCyLBq/iNShPDbSeD+/8khr2Luxj9lnsH/N24
        17Dnpz6iDoS69X8Q4r/nElTbc0eSj7Jb0uwE4vdCGkVN4zvt8as0A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E56EB145424;
        Tue,  4 May 2021 08:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38D01145423;
        Tue,  4 May 2021 08:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru>
Date:   Tue, 04 May 2021 21:38:52 +0900
In-Reply-To: <87eeemhnj4.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        04 May 2021 12:10:55 +0300")
Message-ID: <xmqqbl9q7jxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFCE3AFA-ACD5-11EB-ABC4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> That said, what do we decide about -m to finally join -c/--cc party and
> start to imply -p? Last time we've discussed it, we decided that -m has
> been simply overlooked when -c/--cc started to imply -p. Should we
> finally fix this?

I thought I already said this, but in case I didn't, I think
"--diff-merges=separate" should imply "some kind of diff", and not
necessarily "-p".
