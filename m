Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7960FC433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F4E64F70
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhBDTJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:09:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59202 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbhBDTJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:09:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 233ECA87AD;
        Thu,  4 Feb 2021 14:08:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YuCJlsxyVzMH2CyiqCmR+EriY4U=; b=n3Gaqb
        47+OikEW4dlZ7c8uxPwrQqBlH0Ytmuws2JMH9gV5fcdLC2Bn57FIUyj4HvA5XOrR
        Qojyc6Dc6QANxH6Tnz7gp17Eiv2//fe9pH+nswIWulwdON0ZvmMfu2M24EfMw/ZY
        O87Wurg5PTsyzyBrVZEDWY8VtJX+Raq8TiM+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mwF7vFzXVH8rNqiiW7pOhT6fc4nDc9aB
        Vvw1bc+n6m2ZPdxM9iBnnhGbkXobGnVtw1PK1g2XlWe8QTTaXMVVCR9M3TqvGRhM
        Nhv/v9zXO0zI/tu1rgo+4YFNIH/XCcPsyCgWxYU/0zVPWKAXizffbnCg90Bipss7
        I0QW0USc5XE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17C4BA87AC;
        Thu,  4 Feb 2021 14:08:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 917A8A87AA;
        Thu,  4 Feb 2021 14:08:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/14] Simple IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <xmqq5z3bjuqs.fsf@gitster.c.googlers.com>
        <1be67634-4188-9ef3-306c-72b78ea856b5@jeffhostetler.com>
        <nycvar.QRO.7.76.6.2102030003300.54@tvgsbejvaqbjf.bet>
Date:   Thu, 04 Feb 2021 11:08:22 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102030003300.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 3 Feb 2021 00:07:32 +0100 (CET)")
Message-ID: <xmqqmtwj647t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A44AD34-671C-11EB-AFD2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The idea being that we want to be able to merge this branch as-is into Git
> for Windows (and also into microsoft/git), and therefore do not want to
> base it on a later commit that is not reachable from git-for-windows/git's
> `main` branch.
>
> Maybe it is time to merge `jc/macos-install-dependencies-fix` down to
> `maint`? Then we could base Simple IPC/FSMonitor on `maint` instead, and
> would still have the benefit we want.

Now you mention it, if we ever have an update to the current 'maint'
branch, we'd trigger this known failure in macOS build without a
good reason, even though we have a fix that has been in use on the
'master' and above.

I definitely qshould merge the jc/macos-install-dependencies-fix
topic down to 'maint' now.

Are there other topics that deserve to be in 'maint' that are
"obviously correct" people can think of?

Thanks.

