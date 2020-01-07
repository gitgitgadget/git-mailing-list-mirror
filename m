Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04CEC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49DF21744
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JXWmb2T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgAGSCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:02:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50712 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgAGSCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:02:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ED522C7B1;
        Tue,  7 Jan 2020 13:02:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KqSYLYrLDdHoD6obdekzRfeY/wA=; b=JXWmb2
        T8vqr9GXasOaG6MoEyqXrNPPeXOzwpqVPW1QSTSbtfeZ0zcstgdjj3iVJD9pY7jQ
        hs7iPEpFm9NGYHFATrSrug8M6htVXrLngvuquyw3ToNBtIR+Q2S0hPAdTrGOQePj
        duN9IgbH0MV8ZPk5ReWChRcsNd7v6q9cSB6WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XyFN8WkmLIg34YFxOx9lYZBrCF9Edl//
        pWCHihubKSOO/npfJZnbVEO/Jg1DE2xjeWLTAgWuwlUDzI0FgdLwRdju7kF1czte
        0Y5OuiXbWH/muuTfEuc6arlKzwXGWMzsGjZbYU2aLMbNvUbWUq2y6nYXUUg0lusw
        Rvon67SVa98=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5482B2C7B0;
        Tue,  7 Jan 2020 13:02:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B60082C7AF;
        Tue,  7 Jan 2020 13:02:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>, James Coglan <jcoglan@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] t4215: add bigger graph collapse test
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <f74e82bea68701beb734537cafd147162d1bb2c6.1578408947.git.gitgitgadget@gmail.com>
        <20200107153922.GC20591@coredump.intra.peff.net>
Date:   Tue, 07 Jan 2020 10:02:48 -0800
In-Reply-To: <20200107153922.GC20591@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Jan 2020 10:39:22 -0500")
Message-ID: <xmqqftgr5elz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAC235E2-3177-11EA-AB1A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2020 at 02:55:47PM +0000, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>> 
>> A previous test in t4215-log-skewed-merges.sh was added to demonstrate
>> exactly the topology of a reported failure in "git log --graph". While
>> investigating the fix, we realized that multiple edges that could
>> collapse with horizontal lines were not doing so.
>
> Thanks for constructing this larger case.
>
> As for including this patch, I could take or leave it for now. I like
> the idea of documenting things further, but unless it's marked
> expect_failure, I don't think it's going to call anybody's attention
> more than this thread already has.
>
> So I'd love to hear what James thinks should happen here, given that
> it's an extension of his other work. But I'd just as soon punt on the
> patch until we decide whether it _should_ change (and then either mark
> it with expect_failure, or include the test along with a patch changing
> the behavior).

... and nobody CC'ed the person from whom they want to hear opinion?

;-)

