Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65727C433EF
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbhK0T5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 14:57:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45862 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238787AbhK0Tzr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 14:55:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BEB0C1F953;
        Sat, 27 Nov 2021 19:52:31 +0000 (UTC)
Date:   Sat, 27 Nov 2021 19:52:31 +0000
From:   Eric Wong <e@80x24.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
Message-ID: <20211127195231.GA4636@dcvr>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
 <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> wrote:
> Just to be sure I'll do what you expect to be done: I assume you want to see
> it changed like this?
> 
> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> +	perl -pi -e 's|^Message-I[dD]:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> 
> Or are there even more variants of Message-ID out there known that
> need to be taken into account?

The entire match should be case-insensitive[1], so I'd add `i'
at the end:

	perl -pi -e 's|^Message-ID:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|gi;' "$1"

Fwiw, every mail and HTTP/1.x header parser I've looked at works
case-insensitively.  Also, I'm not sure if `g' is needed, actually...

[1] https://datatracker.ietf.org/doc/html/rfc822#section-3.4.7
