Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30BC1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfJWCpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:45:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60773 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbfJWCpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:45:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25166364B6;
        Tue, 22 Oct 2019 22:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X+6MtmN9wpeX0aB5Z0JIkj9uQrY=; b=waYWOr
        sIRPcza/bUbBtDfvDGvWuQSuHtNgNlqxr1ahipzE9ds8tf1y3b08VcjC0xv6E4oL
        Q4DFYYH06Kj0bum2tO4P0p4RGsekrm3iEK/VrMor1IwLkvJXP8oaLmzteM550Evz
        IaJuEr7hOxhs8AMdjeZ4dWnFwU4Ub5/imZu90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nQkBzKOt8S1+TVK/lQqIg2EUaRuZ9q0S
        trAKEQNu3puver0QEiODdvUHEhFKgL4OSqqu57IUgCVR/7+ls4Hk65Ry8vvqHoIY
        o3uvqAu/LsccP/FyGwuvsewuy8mmicD/MnqkILi5LrTopsHI9GkV8TbJZLbcQFp+
        rUCvnCWXuCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BE90364B5;
        Tue, 22 Oct 2019 22:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 638C5364B4;
        Tue, 22 Oct 2019 22:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] commit: give correct advice for empty commit during a rebase
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
        <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 11:45:04 +0900
In-Reply-To: <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 22 Oct 2019
        23:30:22 +0000")
Message-ID: <xmqqv9sgi3in.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F0DFE6E-F53F-11E9-ABF4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Note: we take pains to handle the situation when a user runs a `git
> cherry-pick` _during_ a rebase. This is quite valid (e.g. in an `exec`
> line in an interactive rebase). On the other hand, it is not possible to
> run a rebase during a cherry-pick, meaning: if both `rebase-merge/` and
> `sequencer/` exist, we still want to advise to use `git cherry-pick
> --skip`.

Good description of why the code does what it does, that future
readers will surely appreciate.  Nice.

