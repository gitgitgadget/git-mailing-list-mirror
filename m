Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0160C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D8D224DF
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLXASS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLXASS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:18:18 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B2C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:17:38 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id s6so601930qvn.6
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ddyQHTx7vXetr0oGZ9rhZWWt8bbc+Po0JXZR6WoSYIk=;
        b=S3Mm6SI6Tn84x3BOZgKkyqXmlq69ECKnHVQuOW+2ce0jOxaJe6p2Zqb7p1SJgpvFOh
         B+GQ0BeSufpzVrehIa/KQBRLHUL/mSdYurLmaCZ4FjbtmwOLGXN1gmD5M0NLj4eeVFW7
         DpiCiv46eqkW7rEAgCVP0BO+4+n9nZrli2rBg+ZK3PU7vcejRqd87mQyr/k2rnEyrIMc
         1wXlKWrkd9HzUvXIgDyMjNz3W+9jtv9LoZUeRFM3asCq4HUrUOqTy0P9g8HhwpnwPwCg
         KEnoN3bYmxL2IQKaHBUfXTbXeSse9njA7K007cpS9a8egqaR71leHVmFAlzu0O72GwEt
         M3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ddyQHTx7vXetr0oGZ9rhZWWt8bbc+Po0JXZR6WoSYIk=;
        b=Vc3OTxpgLASo0ne+2f0iRyMkT4wNAD2JkWxW7C7yqP2yjW5KnMU5L7DJAmVhnRUkrK
         EJLXcP2xGkHLr4SmzNoONS9lsXaufVLan/eN80wgx2KicZXRE87Ob7j1XOKYH9C5nKl2
         3F2p2xK51H7mQCEDGolqcHzEb9kKa0EJHl9X+k8Btq31QK5mf947ek7j8blqiW2anfsD
         SJiwc2fhN3nmNh5Wy6tnXMPfp/Yb3iRAdSrvvgYog8WK4PFjlbOhpDYfzAVe7JKvzV78
         B2JePv5jAbeINfOd+dmlGOy1jqJbLRPv33eAupJaZ1DsOrLkiZahP4CO855JsyMmIQn0
         DbRQ==
X-Gm-Message-State: AOAM531G/oftX9akWnteRKrQh14sJFhnsE/DF0oGZDgmtDlouJxgSP/1
        baojWUQ3Civ+K7j7MB+9faOxuInZjVkibeUccf1iZ+iO
X-Google-Smtp-Source: ABdhPJyA47RYgzGmCZo7zVFRVZ56Q23saLuzTlcWtT9vhcAZkZcFas4SC3baMGAozEJoaU68yjJhtS33Rc0IfRzHxOY=
X-Received: by 2002:a0c:fe90:: with SMTP id d16mr29829013qvs.13.1608769057276;
 Wed, 23 Dec 2020 16:17:37 -0800 (PST)
MIME-Version: 1.0
References: <CAM0jFOfx+vxvUAqZqnxeOvGmn0F0Q6vyTKWPjtsSh1bmq__SsQ@mail.gmail.com>
 <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com> <X+PbbVNIspvJx/yE@camp.crustytoothpaste.net>
In-Reply-To: <X+PbbVNIspvJx/yE@camp.crustytoothpaste.net>
From:   Mike McLean <stixmclean@googlemail.com>
Date:   Thu, 24 Dec 2020 00:17:26 +0000
Message-ID: <CAM0jFOfA2HH9gC0RRX52NSEPGcsCg_7fhVUYt8cmM8G5=nhtpg@mail.gmail.com>
Subject: Re: Git Feature Request (Commit Message editing directly from
 interactive rebase control file)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These seem fair concerns.

Detailed multi-line commits are something that I know exist, but I've
never seen much need or use for, personally, and no project teams I've
ever worked on have used them.
But if that's the declared preferred-approach then I agree that this
feature would be actively detrimental to that and thus is not
appropriate.

Thanks for the responses!

On Thu, Dec 24, 2020 at 12:06 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-12-23 at 23:07:43, Mike McLean wrote:
> > Indicator that the commit-rename should use the text in the control
> > file (rather than the later editor prompt) could either be A) a new
> > command (rename-inline, or similar) or B) existing rename command +
> > "the text on this line is different from the text on the original
> > commit".
> >
> > Obviously this wouldn't support multiline commit messages - those
> > would still use the existing workflow, but adding this new feature
> > wouldn't impinge upon them, so they've not lost anything.
>
> I know people tend to do this quite frequently, but it's extremely
> uncommon for me to write such a message.  I normally write a reasonably
> verbose commit message, and in the vast majority of the cases where the
> change is so trivial that I write a single-line commit message, I'm on a
> project with sign-offs, so this wouldn't work there.
>
> That doesn't mean that this couldn't be useful in some cases, but I
> think we're likely to encourage single-line commit messages, which I
> don't think we want to do in the general case, or cause user confusion
> when their commit message inline is either (a) truncated unexpectedly or
> (b) not honored because the message is already multiline.  So I feel
> like such a feature is a foot-gun waiting to happen.
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US
