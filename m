Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429EDC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4F720705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wWqXDCcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAHSuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:50:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64207 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAHSuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 13:50:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DB6137102;
        Wed,  8 Jan 2020 13:50:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mn6zQDZR7lo75786ZQKTAJNgACQ=; b=wWqXDC
        cHSmC9i6OqBg6gQjpyFSaplWQILpZw2mpkCwnyjEIMv7kewonlw7dAy/i+V4KLry
        7S8wFfu6N4+j3GKfOo+1a8hm1dkAyo2okj3LsD5ryr2y2pWRCb8Fgn1vGoBMFIIL
        kj8CwIKtkBNPW1RhvaO1GiwZmccU2dR8IXVvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jruB0SKYfMr7ITNhi2J8Pftf5Bl2MKe4
        WgwAUUVK9HKWbzjy2EjeRpCLl3arl20n/kwzkodwQR6PlNcjtuAD7ZDcP+R5zd4P
        3KbeAhkPmArZHGtV/y3F/e8whwvI0jA8YB0lczIQV4sKl0y+hRloXDxmfIAPvGaC
        xcn0/bQZZbM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5434737101;
        Wed,  8 Jan 2020 13:50:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B974D37100;
        Wed,  8 Jan 2020 13:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] t: rework tests for --pathspec-from-file
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
        <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
        <xmqqh8173r8e.fsf@gitster-ct.c.googlers.com>
        <12861b02-386c-3ae8-cd2f-ffe07c6aabc7@syntevo.com>
        <xmqqimll3lmn.fsf@gitster-ct.c.googlers.com>
        <0b54d95c-a5e0-c156-b972-a1e171678785@syntevo.com>
Date:   Wed, 08 Jan 2020 10:50:09 -0800
In-Reply-To: <0b54d95c-a5e0-c156-b972-a1e171678785@syntevo.com> (Alexandr
        Miloslavskiy's message of "Wed, 8 Jan 2020 18:42:13 +0100")
Message-ID: <xmqq1rs93hr2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B28AF954-3247-11EA-B463-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> I will still provide a few tests for every new command to make sure
> that said command works as intended. I will only skip indirectly
> testing global API again and again.

Ah, OK.  Then leaving those removed by the third step there may get
in the way.  So let's assume that we'll have an updated third step
already applied and your new series are written on top of it.

> ... For new commands, it doesn't really matter if "third step"
> patch is applied or not.

OK, again.  Thanks for a clarification.

