Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E1C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBED6152A
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhKHWMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 17:12:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64157 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhKHWM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 17:12:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EB3CEF5CE;
        Mon,  8 Nov 2021 17:09:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nE1wk/rxGUqdpG8b2RSpmsPUnZjziF0qZhnIEV
        qqMLE=; b=wA9Hg5nLDe4//2SADmf00ZY84xGk2BZAGJkLs1+5+zTzEpldzx9qN3
        2HtIst6yty6aPEfGO/L710g+9sjPlwIK0SrIFZrg2EOW1SMWEN1c4+UiP/SMqNaN
        bWepALrIabuqRkAzgnWExdxd4wudDKPk2OSUB3LHlVCqjsT89IIbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F49DEF5CD;
        Mon,  8 Nov 2021 17:09:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98B15EF5CA;
        Mon,  8 Nov 2021 17:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/3] gitfaq: add entry about syncing working trees
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
        <20211107225525.431138-4-sandals@crustytoothpaste.net>
        <CAPig+cRtOpaPd_HCQAW=33-vxhP4Knijo3g0dUA9HVb4_=JH4w@mail.gmail.com>
Date:   Mon, 08 Nov 2021 14:09:42 -0800
In-Reply-To: <CAPig+cRtOpaPd_HCQAW=33-vxhP4Knijo3g0dUA9HVb4_=JH4w@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 7 Nov 2021 19:12:14 -0500")
Message-ID: <xmqqmtmes3ix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93B24D8A-40E0-11EC-8010-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Taking into consideration that people who are experiencing such
> corruption will likely include the name of the syncing service in
> their search query, would it make sense to mention some well-known
> services here in order to make it more likely that people will
> actually find this entry? Something like this, perhaps:
>
>     It is important not to use a cloud syncing service (such as DropBox,
>     FooBar, CowMoo, BuzzingBee, etc.) to sync any portion of a Git
>     repository...

I do agree that in a repository being actively modified, any
backup/sync solution that works per-file fashion would not work
well.  But is "cloud" a good word to characterise and group these
per-file backup/sync solution?  

Doesn't rsync work the same per-file fashion, and the only reason
why it is a better fit is because it is not continuous, not
attempting to "sync" while the repository is in use, until the user
explicitly says "OK, I am ready to go home, so let's stop working
here and send everything over to home with rsync"?

>> +* There are no additional worktrees enabled for your repository.
>
> I don't fully understand this restriction. Can you explain it (at
> least here in the email discussion)?
>
>> +* You are not using a separate Git directory outside of your repository root.
>
> Same question about this restriction.

As long as you know what you are doing and catch everything in
quiescent state, you should be fine, I would think.
