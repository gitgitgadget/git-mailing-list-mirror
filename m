Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2674C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8701860F5B
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhH0RPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:15:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56118 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhH0RPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 13:15:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7595FED9EF;
        Fri, 27 Aug 2021 13:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=642Ij28XIYG1oDMcoFuSomm0Z0yCheDyPAARbk
        vgGVw=; b=K9X0xlMl238rXrWPtQFDUUWG9Z59BjOBCtX/2KTd9EH13WKxrpMuAS
        qxAv+Jmn5V5qcfjODf/cA5fqvojg3o56qx3PAsH28jN/Nbx09JmN1DxyVjOpnJjC
        rSf2E/YDmsEChUWXkzb5XkyWjzcaKZCfEzaZc5zD4y3JuT+U9f8lg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BF7AED9EE;
        Fri, 27 Aug 2021 13:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1DB2ED9ED;
        Fri, 27 Aug 2021 13:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Kratochvil <jan@jankratochvil.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: bugreport: git apply -3 confusing "lacks the necessary blob"
References: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
        <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
        <xmqqtujkui9v.fsf@gitster.g>
        <YSkBg3lBAZ2pxCP2@host1.jankratochvil.net>
Date:   Fri, 27 Aug 2021 10:14:46 -0700
In-Reply-To: <YSkBg3lBAZ2pxCP2@host1.jankratochvil.net> (Jan Kratochvil's
        message of "Fri, 27 Aug 2021 17:15:15 +0200")
Message-ID: <xmqqwno6ajy1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 477C1866-075A-11EC-A067-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Kratochvil <jan@jankratochvil.net> writes:

> On Fri, 20 Aug 2021 19:40:12 +0200, Junio C Hamano wrote:
>> But I think Jan is talking about the case where users get a patch
>> that lacks the "index" information out of other people's "diff"
>> implementation and try to "apply -3" without realizing that it is
>> not Git's "diff" output.
>
> For example from Phabricator:
> 	https://reviews.llvm.org/file/data/3ceoc32b3yv43vk3nw4q/PHID-FILE-lfeeh2qu4vrngdcwwudo/D107456.diff
>
>
>> Perhaps something like the attached patch would be a good start.
>
> Do you plan to check it in?

Maybe eventually but not yet.  When I say "a good start", it is
because it is known to be insufficient.  I haven't had a chance to
revisit the issue.

