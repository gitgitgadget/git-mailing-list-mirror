Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCCC001B2
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLPHxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 02:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPHxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 02:53:30 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542820F5A
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 23:53:28 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id pj1so568999qkn.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newsbridge-io.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TFgdM5CSUf57rDxEM9IbYYhWmNRmVFmBuNcM2Uu8hE=;
        b=4fSjscceHqPUU9rbseiMyD7XiR/bEqJ9LopRL5M5vHGJquYJCuDxQy3PR5jPCIQ3m9
         P4ON/ByvAzclhjIxfia+eIES0lT0ijTYpupoQnq4Tow1LhgJER+n2lsRfw+lnEyjA7Oy
         cYDLP8sG5AXFiGY3g998/RKoF5QCrk2XwUrzh877Via97MPefoPm+kwu+BE3BP4fntA9
         9FUW+RZWM16VqBvHouaNcQkrYkvDH5Iyi5FiyTBao8pxr1gRCU2qti4+xZzPEbabgYAY
         odjUmx9pdruvr07+fntm7NT2a71CYadcjx0zJ/b0JtGlP4VzKcb554qGyiA8LSt0Dnue
         cb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TFgdM5CSUf57rDxEM9IbYYhWmNRmVFmBuNcM2Uu8hE=;
        b=lNSYbLe9+KlRk0ddQ1rRor5ChD5lG5LjQGVwdVF37f9deBTxaRNEpAHmt5WtgJYDUG
         ajZwueq9oQDzEKA78OkSj8KYsFCTECwyBzNT/GUCVMOHe6h2Df1qKIqP9btweS8M+eDM
         UjE0lCVC7q7LaaZpyKA7wvPeisokjLa+uexHpju0HEZm/1iQ3EoxCWESlZ8mh8GXrq7v
         jqEuLmXUyHaaQ3tnH+biPKyjkneYt6LzLZ0WSY/pRT00REpB2WEywXaxmggGG7HjhAa+
         zeQEbF/vUM4TwWWZMGSZltiRIc7/J7iX5WqMVGyAC8OLeZUA/ubChvLCNChwcq9fXFBN
         fyqQ==
X-Gm-Message-State: ANoB5pkgyFzQ2IaV21gRHiRrJE9T7F8w5S08fZjaxNQNG+Trc/BYsY0Z
        WJ0om9airsEcO2lQTSi6zPMusbeCOPGhA5ls8q0b6Y9ofUIeMg==
X-Google-Smtp-Source: AA0mqf7ekLm3tDYe3hfGTqoKPwdtD4bi3a6Kt/E5u1HzsV3f2yfDwBOxHIeLdYB+rblqfNmXnzLYXlS52spEWTIWvSA=
X-Received: by 2002:a05:620a:2ac4:b0:6fe:b1c6:3e60 with SMTP id
 bn4-20020a05620a2ac400b006feb1c63e60mr15937440qkb.589.1671177207575; Thu, 15
 Dec 2022 23:53:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
 <Y5u/E04V0QWQTDhu@tapette.crustytoothpaste.net>
In-Reply-To: <Y5u/E04V0QWQTDhu@tapette.crustytoothpaste.net>
From:   Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>
Date:   Fri, 16 Dec 2022 08:53:19 +0100
Message-ID: <CAOLx1Biwd9KzqipoEPaw0M2AecW7XfuyvNeVW4F59e696gMt-Q@mail.gmail.com>
Subject: Re: feature-request: silently stops ssh-agent.exe when upgrading (windows)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian

Many thanks for pointing me in the right direction.
Sorry for bothering

Keep the great work and have a great end of year time

Cheers

Jean-Michel

On Fri, Dec 16, 2022 at 1:43 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-12-15 at 08:38:01, Jean-Michel MERCIER wrote:
> > Hello
>
> Hey,
>
> > I've looked in the public-inbox archive without finding any similar request.
> >
> > I believe it is a bit annoying that upgrading git-scm always generates
> > an error when ssh-agent.exe is still running. User than have to open
> > the Task Manager, find the task and kill it.
> >
> > Could you consider silently stopping ssh-agent during an upgrade, and
> > may be restarting it afterward ?
> > Most installer do that or at least offer the user to do it to allow
> > seamless upgrading.
>
> The Git project doesn't distribute any binaries at all, and it doesn't
> distribute OpenSSH.   It distributes source code for Git, and that's
> all.
>
> It sounds like you're using Git for Windows, which does distribute
> binaries, both of Git and OpenSSH.  If you have feedback for them,
> you'll probably want to use their issue tracker
> (https://github.com/git-for-windows/git/issues) and, if it hasn't
> already been reported, you can request a change there.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
