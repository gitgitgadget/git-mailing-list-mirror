Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC85C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A090D64F18
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 17:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhCORZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhCORYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 13:24:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69CC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 10:24:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z13so34220098iox.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technoplaza.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dju07xnMk4CGxbhu+FtfMMw93SmtISaf/irZj/vgrPs=;
        b=DOQnFrIaQcFF5RWz0rS5lmluTiXn7dgEN1cpN50kYG/2BF8hJVPWxWs96JRjE95mXG
         aAvPFsUzzfHS/hkGO617i0peBeVCwws/aQWS304O/2pKCvwVN3+iRqjwQYDlpOlvrZ9y
         Qjjnz5n0gk3sXEJWZHwaHL4yqXQpIz7Z5bC5IyaGfiNbXt2/+rsBqjbE/LVqEJcO1Yu+
         dkosrKWlUrePeTTXAgOSx9C7FvLG+I93JfWQIpjizStgm6K8T7oWiVNQq3HRnCTKclGu
         5oUnqCFQCWuO5/+cQWJis9UWVg55p3NF6DHKewNMH8PtTX3WHvel+yXpKWfsWCeOc3ML
         j53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dju07xnMk4CGxbhu+FtfMMw93SmtISaf/irZj/vgrPs=;
        b=ZlVR7qYDrPYx8Qz5XKXLtW8QrZKc3lDI2nJ64gbuvqpol64pNud6XiGrG1qaaFpvIS
         By9zIy1n2dP5R8C+0oMDy1Gifs9XkKohYSc6kIjM25MdSX0sl7/Twggd3WWmiydeOIDJ
         JubN4WPqV0SPIs/OfNJFvZOrlw9m0wRiac/gZdelvSVBAHUQNSPNFiHnRcwFONR71byw
         v7n5+S9rTdYjkeCROV1o/IKVuh53TIwh8CxbSTJcFAqYiApyMGj5FDYIXPBh+I72VBVv
         OIEPdazhupDc1J9ylvfZU6PhWvE51dm6xvtTqxaAq5scqx+9aEL5q+4md6LXor5uH4rN
         bepg==
X-Gm-Message-State: AOAM530bcNt6PUOJjZqUDPhhBrVl4/aoqsxiliG+xOq3csmVKwJWjBwT
        rrYUXzE8beDY+Y0DD8YASPiQKYEvVitNxpr3zg80bA==
X-Google-Smtp-Source: ABdhPJwPPfl6DT4+Mp6U0ttdbERlRvOvwH/paQTsoyhzOSMJ9Mw6Fbl5e70rUQ4UEnC03/1BA/u14+cSbVXhjcrEOJ8=
X-Received: by 2002:a5d:850c:: with SMTP id q12mr465965ion.13.1615829092200;
 Mon, 15 Mar 2021 10:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UukjW_TeswTHHfiwzc989U+wZMVcHeS1siRF0Rbg5nc3D5w@mail.gmail.com>
 <YEvPQS1+1sxd/aGw@coredump.intra.peff.net> <YEwoyeYM7ac+6aIx@google.com>
In-Reply-To: <YEwoyeYM7ac+6aIx@google.com>
From:   John Ratliff <john@technoplaza.net>
Date:   Mon, 15 Mar 2021 13:24:41 -0400
Message-ID: <CAP8UukjOghB7yak-tk=+YvCDkgsMt7bobfrbdiRmPpus3LaZJA@mail.gmail.com>
Subject: Re: git credential cache and sudo
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a shared git repo for our production puppet environment. I
have my own environment for testing things, so my git credential cache
is already created as my user before I move things into production. My
environment is in a github fork of the production environment though,
so I don't think rsync is an option here. It's possible the directory
permissions could be ACL'd to enable us not to need sudo, but I do not
have the authority to change that myself.

I think I will try referencing the socket and see how that works.

Thanks.

--John

On Fri, Mar 12, 2021 at 9:51 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jeff King wrote:
>
> > Note that it's a little funky to be accessing the cache as a different user than
> > the one who created it. This should work reliably when the cache was created by
> > your normal user, but then accessed as root, because root has permissions to
> > access the socket. But if you spawn a cache daemon as root (because the _first_
> > operation you perform is as root, which automatically starts a daemon to store
> > the cached credential), then it's likely you won't be able to access it as your
> > regular user.
>
> I wonder if this suggests a missing feature in
> git-credential-cache(1): if the manpage advertised a way to launch the
> daemon through an explicit command, similar to 'ssh-agent', then a
> user could run that as themselves before running other commands that
> communicate with it as another user.
>
> All that said: John, why are you running git as root in the first
> place?  It's likely that it's safer to run git as a different user and
> use a separate command such as rsync to perform the privileged deploy
> action.
>
> Thanks,
> Jonathan
