Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F151DC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15931613D4
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGPQpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:45:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65118 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGPQpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:45:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28705DEC25;
        Fri, 16 Jul 2021 12:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d0iYlimKTt4Q+Mxvl1WnlDjGUd/Ul3gAQipg+T
        Tv+4I=; b=NLuU8GC4K73D46SpbznRefnlAqleLaLD4KTiiR5031ggHpAn2pbwJg
        Eqyiwr7yzheS0sAaU67oR6EOL51WBkku5r54HLgpBaB4m4fC+WRo4cOO4eokWrOT
        EMOF5WCYeHEvr0QOE1Tpo+5RMT3wyKR7Hn20jWyF7xLmHvqTYHCRA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C734DEC24;
        Fri, 16 Jul 2021 12:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9507DDEC23;
        Fri, 16 Jul 2021 12:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
        <xmqqbl7525w7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet>
        <xmqq35sgzy0d.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet>
        <xmqqa6movcly.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107142350570.59@tvgsbejvaqbjf.bet>
        <xmqqsg0gttt5.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107161714290.59@tvgsbejvaqbjf.bet>
Date:   Fri, 16 Jul 2021 09:42:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2107161714290.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 16 Jul 2021 17:25:38 +0200 (CEST)")
Message-ID: <xmqq4kcurz0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D68F581E-E654-11EB-9973-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Besides, for all we know the problem might go away at any stage because
> pretty much all other main CI systems have a way to re-run only failed
> jobs.

Yes, that is something I find plausible.  That's one more reason why
we currently feel it is OK to roll it into the primary job.

Now we've left a handful of messages on the list, I think we are
safe against anybody who will soon complain that we are piling more
and more on top of the primary job---instead of pointing at the log
message of the change that did so, we can point at this discussion
thread to make them understand why we decided that it is OK.


