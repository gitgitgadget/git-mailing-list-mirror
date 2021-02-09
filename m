Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623A5C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147FB64E7C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhBITuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 14:50:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59559 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhBITpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 14:45:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B672B10B87B;
        Tue,  9 Feb 2021 14:08:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WbzInRD8ojPk/3kBzwCrVir08hY=; b=Km7gVK
        2zl3k8YY0qNpY18SCPqLEdJOqOdtlS7pMTszROErPO4DqnMt5CpG2Sm80GoccVFj
        WbAcPpOcX6x1YRzilFTlXfkJgBvhhNaH+z94Rr+uaEvuVoAFLgdjN5RCvPnX3itv
        I7vAlKKbaW2M3ZQ/YPeW7TJ+bKG+44t2FDb7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RXUyijJ0nC8qIcUdNhwkdZ8cLfS51job
        Q7fNa+tQQDK2P/hEnmqJe2fkkZbDXjRkl16ajZOicwPyB6vXp/pPGteb6w13c5x5
        4OVmZb5avP3fRdAGus5OhJhfy6CldXljq550oM8XsXlOl0lkvYY1o/blRGBAUaih
        MKiQF7u/0Bo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF2BC10B87A;
        Tue,  9 Feb 2021 14:08:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C572C10B879;
        Tue,  9 Feb 2021 14:08:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c'
 rebase-todo help
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210208192528.21399-4-charvi077@gmail.com>
        <xmqq5z325k3j.fsf@gitster.c.googlers.com>
        <CAPSFM5dN=gs7m8VskCPMzD10i42ETQ_7UzuGKmi=X-xs2QkYSg@mail.gmail.com>
        <CAPig+cSoa4Vw0N53vJgMCWiW5yVS0j1H0ejS_01xs1WDF2d82g@mail.gmail.com>
Date:   Tue, 09 Feb 2021 11:08:11 -0800
In-Reply-To: <CAPig+cSoa4Vw0N53vJgMCWiW5yVS0j1H0ejS_01xs1WDF2d82g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 9 Feb 2021 03:33:40 -0500")
Message-ID: <xmqq5z312h5w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27E74300-6B0A-11EB-9E36-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Here's another more concise attempt:
>
>     like "squash" but keep only the previous commit's log message,
>     unless -C is used, in which case keep only this commit's message;
>     -c is same as -C but opens editor

Nice.
