Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87443C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B3E2075B
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FV0lYn3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbgHQRRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:17:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51436 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389636AbgHQRRj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:17:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 824ED6E7A4;
        Mon, 17 Aug 2020 13:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Rto4Br/N5jbbBBrsk6kkh3qwOE=; b=FV0lYn
        3HN/N4A2h7RunWZVPDmormyht+N1KEJiRQL8LqHH04FSvUje2Jvv9myiz2Xn/jyW
        YxUdsdcLuzkA/YkZkgows4W8xcHNF3wCbho3TBEmzjfyvt3A5Rnxqu9N3xMQMZf2
        qOdF1BIaR17pdkzlmvG6E5DV0ffr4ZqTVgiOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gSZlEsppxwHibJ0TCNExO1bbc6Y65BjL
        09wXIJrJMefkKgqRHuvTJiiVOhx2vMRm5mTpfWzQV677LRn3qJq/yupvYm6bsdfW
        QmB+kaZmAMgDMXDOq2542KVIu4WCne5YrWr7UD7YCn9FE2oScc1WBXEoUBiqBlTX
        K3ITehCJNXQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41B046E7A3;
        Mon, 17 Aug 2020 13:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7266C6E7A1;
        Mon, 17 Aug 2020 13:17:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
        <xmqqtuxglksy.fsf@gitster.c.googlers.com> <87ft90uq8w.fsf@osv.gnss.ru>
        <xmqqmu37lmym.fsf@gitster.c.googlers.com> <874kp4uoic.fsf@osv.gnss.ru>
Date:   Mon, 17 Aug 2020 10:17:34 -0700
In-Reply-To: <874kp4uoic.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        08 Aug 2020 02:11:45 +0300")
Message-ID: <xmqqr1s52nv5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B0A4456-E0AD-11EA-A5DB-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> So, do these both effectively resolve to:
>
>       git log -m --no-diff-merges --first-parent --patch 
>
> where first -m is the one implied by --first-parent, ...

Eh, why does --first-parent even affect the choice of -m/no-m when
--no-diff-merges is explicitly given?

> This is too complicated for my taste.

No one is forcing you to rely on the implication by --first-parent.
You can always give an explicit --[no-]diff-merges when you use the
"--first-parent" option.

Thanks.
