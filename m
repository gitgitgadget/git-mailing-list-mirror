Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E7C433EF
	for <git@archiver.kernel.org>; Sun,  3 Jul 2022 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGCA5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jul 2022 20:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGCA5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jul 2022 20:57:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9364AE73
        for <git@vger.kernel.org>; Sat,  2 Jul 2022 17:57:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83DB71A1909;
        Sat,  2 Jul 2022 20:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/epN9S+JRXpJZwlIy7kVsYvGS6gfaoe+GPxesO
        mzj4Y=; b=J5AaSGR2+24+2WkHCpgvF3bPOs7jPuGcOOUXloXKnw2AF7I4j45+W/
        uFN5hLYXonEhh4Lwdt87erf9kmLu8ttcy08O4fNn3riwfYnQwDX5DIzKpAMKLOb4
        Qqj8FfXWK81vfDOtvPysJi90mJWU/H/wBC4u13B5GIAtOg5MnPuTs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CA651A1908;
        Sat,  2 Jul 2022 20:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 36AD41A1907;
        Sat,  2 Jul 2022 20:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
        <220609.86leu6thon.gmgdl@evledraar.gmail.com>
        <2022061010332322021051@oschina.cn>
Date:   Sat, 02 Jul 2022 17:57:40 -0700
In-Reply-To: <2022061010332322021051@oschina.cn> (lilinchao@oschina.cn's
        message of "Fri, 10 Jun 2022 10:38:38 +0800")
Message-ID: <xmqq1qv3m2rf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23E645FC-FA6B-11EC-818B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

>>I think the end-goal of having the "remote: " messages translated, if
>>possible, is very worthwhile, but I'd always imagined we'd do that with
>>a protocol extension, because even if we do this with HTTP headers we
>>won't get the same over ssh/git transports.
>
> As for ssh transport, can we use ssh environment to reach our goal?

Not really.  Before forcing us to invent completely separate
mechanisms for different transports, it is a very good idea to
consider if we can use a single mechanism that can apply to all
transports.  Adding something at the protocol level would be a
step in the right direction.
