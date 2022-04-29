Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84668C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbiD2QMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbiD2QMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:12:34 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1AA7743
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:09:16 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-deb9295679so8579590fac.6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F4w90LbvNU1tBJBaCjfjVt5Rux/A61zqjkRrYDE3920=;
        b=YirRaJCEkmkgVibi3sLN+SJy3UVGTZN6gDkDkuWqCMl6+h3GgrWoUdjg/BB2J2SR2w
         CNWw7wFUjGLVjhAu7npOl04EkGkIxq7Yjm1n2zGBbI64drb82InCoF3KLeI1qqniUgFj
         r21zeZDRIm/bjYY4bH8BFSMt6OllPHQl+Cu8TqHDsFdJ2Et2GPP1ME+A9+9zzkl3E3h8
         v2xOFw4qiqWwxKYDYN1SSthaAnrdflRr97nwHvM2b/ohb1mV8i1HBeOMtm/YyqrvPYWW
         AGM//LLByzD21LXDa7GPwoMP6AN0i/g/QpUJGtfpPRT2oF6CSInAedZwz6j6y3KkfNAa
         tmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4w90LbvNU1tBJBaCjfjVt5Rux/A61zqjkRrYDE3920=;
        b=SDxgIagZItsax3xe0xL7rMTZtoOChcq9B2bHkLmH3YS02f02VnpVJstHg1SnInivzR
         NyDcfIwaJXOmaWPuAp3WGR4iBRe/2yJR/UV94xdbPQlhNr4QnkGZQ4VBpu3qn0UDsz9G
         aBnAU62lVF0LHtImIIYULzyUwq1m0EY8MU4XxN0Y95tIDgRzHW3Up74k2w3ASpmqWvOW
         ELv6OpY6FxZDGb1+xE7vFmzmzeqrrlwsX7hBCKx6IxvpCiQSNc+DIXVR5uU7gnbyT8ox
         nxNtEXbSA1GzPUv0XFZ8ovxlKDKpkh4MrTEx8lEqLI3h8UkOSYMIZFGxBl1/9A9WsyjD
         YJdg==
X-Gm-Message-State: AOAM5302CdCIrq0OveL3xXXeZBqsCq3tuxANaY0cJw5x5CELQJxGu4Qe
        Cd43nDnFy8TTyX3sUACHOaVItXB8i40=
X-Google-Smtp-Source: ABdhPJwtOxPC+5E+VDRds4GgU6LvUljfoSF6hE0ecCOkkQ2JUwY0FeX4wtn9bsWd57hDVbzvYu89PQ==
X-Received: by 2002:a05:6871:78b:b0:d4:2636:b26 with SMTP id o11-20020a056871078b00b000d426360b26mr44574oap.14.1651248554838;
        Fri, 29 Apr 2022 09:09:14 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 62-20020a9d0dc4000000b00605db31d0b7sm1210483ots.2.2022.04.29.09.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:09:14 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:09:13 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Vladimir Marek <Vladimir.Marek@oracle.com>
Cc:     git@vger.kernel.org
Subject: Re: Fix for failing tests on Solaris
Message-ID: <20220429160913.wogvmyxosctdlosz@carlos-mbp.lan>
References: <20220429062337.bcpjizaujjmw65dt@virtual.cz.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429062337.bcpjizaujjmw65dt@virtual.cz.oracle.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 08:23:37AM +0200, Vladimir Marek wrote:
> 
> That paths contain posix conformant binaries, but the tests do expect
> Linux-like behaving binaries.

Expecting Linux-like behaviour is indeed not what the tests should be
doing, so correcting that might ALSO help other people that don't have
an alternative GNU implementation available IMHO

So detailing those failures and fixing them might be preferable (even if
likely more difficult)

> --- git-2.35.1/config.mak.uname
> +++ git-2.35.1/config.mak.uname
> @@ -162,7 +162,7 @@ ifeq ($(uname_S),SunOS)
>         NEEDS_SOCKET = YesPlease
>         NEEDS_NSL = YesPlease
>         SHELL_PATH = /bin/bash
> -       SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
> +       SANE_TOOL_PATH = /usr/gnu/bin

I haven't used Solaris for a while (since around OpenSolaris Indiana
development stopped), but wouldn't this break in Solaris 10 and older?

> Makes all tests but t7812 pass successfully. t7812 fails on locales and
> utf-8 which do behave differently in Solaris.

And additional fix for that (since you seem to have access to a fresh
Solaris 11.4 installation at least), would be forthcomming.

Wondering also if there is a way to plug one of those from Oracle Cloud
through a GitHub actions so we could prevent future issues by including
Solaris in our CI runs.

Carlo
