Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22EAC433EF
	for <git@archiver.kernel.org>; Sun, 29 May 2022 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiE2SZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2SZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 14:25:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D65687A1C
        for <git@vger.kernel.org>; Sun, 29 May 2022 11:25:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9745013CA06;
        Sun, 29 May 2022 14:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=exMxxW2zqGnGECv67p3TTJBgdk4d6xTzJ2S7DH
        WhKqQ=; b=SiC8ENdG/GyPUcsrdNMJ9+xAwiOZRIu/m5nmS+E6rkeDf7ia72SKg6
        PyQ6led+GKUvyNhvGeRWyEMkYu+5mqByhcjkYPvd95vXY0wWZWiZ8cv415+2uz/P
        4/ijTxRLYtiT0UAq0/Y2wCMyaXrPwrU5P89+NtjoyXzRrxqyIzn9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F1CA13CA05;
        Sun, 29 May 2022 14:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05E7C13CA04;
        Sun, 29 May 2022 14:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Excluding paths with wildcard not working with add -p
References: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
Date:   Sun, 29 May 2022 11:25:37 -0700
In-Reply-To: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
        (Robert Dailey's message of "Sun, 29 May 2022 12:27:33 -0500")
Message-ID: <xmqqh758yz4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCEFB8F0-DF7C-11EC-ADB6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> If I run the command:
>
>     git add -p -- ':^*.cs'
>
> I get an error:
>
> fatal: empty string is not a valid pathspec. please use . instead if
> you meant to match all paths
> Cannot close git diff-index --cached --numstat --summary HEAD --
> :(exclude,prefix:0)*.cs  () at C:/Program
> Files/Git/mingw64/libexec/git-core\git-add--interactive line 242.
>
> However, it works if I remove `-p`. Also observed this works too:
>
>     git add -p -- ':*.cs'
>
> So it looks like we have a corner case where I can't do a patch add
> while excluding files. Is this intentional?

I do not think so.

Does this command

    git add -p -- . ':^*.cs'

work as you expect?
