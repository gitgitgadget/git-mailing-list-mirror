Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C97E7E638
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 14:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjIZOT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjIZOTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 10:19:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4AEB
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:19:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A58F19A460;
        Tue, 26 Sep 2023 10:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=2mwIPiRI06h/96pcm2i46itOT5hQWQrdT5OEi5
        LUCtk=; b=d8N9x2kyPCFO4/0jThB0uORsYpg9h73bXAoJRT3aPhKN2sduBe+fsw
        0pfAgmS2Q/qezWDuzuy0dps+crRAJ3ouMGulxqr+iA93IlDia+4jDqndG6g8nGmS
        I8Qn/1lVOko66uZGHGTajLWO9v56qA7u/vd6WjzLohydMqRW2wzME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 417FC19A45F;
        Tue, 26 Sep 2023 10:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AC5B19A45D;
        Tue, 26 Sep 2023 10:19:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
In-Reply-To: <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de> (Johannes
        Schindelin's message of "Tue, 26 Sep 2023 16:02:27 +0200 (CEST)")
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
        <20230923070019.GD1469941@coredump.intra.peff.net>
        <a839daf1-9e32-96f8-4eab-7c845e128488@gmx.de>
        <20230925121157.GB1623701@coredump.intra.peff.net>
        <4e0f404e-0c49-b085-c35d-be53b0381402@gmx.de>
Date:   Tue, 26 Sep 2023 07:19:46 -0700
Message-ID: <xmqq4jjhow3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF53504C-5C77-11EE-9746-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I meant that the default should be $user/$fork from the Actions
>> environment,
>
> I'd much rather default to the value needed by the Git project than a
> value that may be needed by any other user. I do aim to support the Git
> project with this patch series, first and foremost.

I appreciate the sentiment.

At the same time, it would be one less thing they need to tweak
before starting to use it, and if there are two or more users to do
so, it would already have paid off.  Developers typically outnumber
projects they work on.

I also have to wonder if it might make it more obvious what is going
on if you made the default to $user/$fork and have the project
override it, which hopefully may make it easier to find out what
they need to do for those who want to override it to a different
value to suit their need?

Thanks.
