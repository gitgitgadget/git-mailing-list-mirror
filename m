Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CEC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712EB61923
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 08:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCVIuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCVItg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 04:49:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADBC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 01:49:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so19861614ejc.4
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlkQiDl11YIjYuyR1ccWXrL5KHIHXuUTF3IcNdXO2X0=;
        b=OIVq74eiHjx2Xw15EA00HbjRSgOZKpsN6aI8A5IQxNos1h3gbxtOlh6miJqQaMrqc5
         5BgvhLZV039KC5pkY9Gp+6YvJlhoM9iqUVQnrl3xV6qNH97sqt/Dta44TSx11IgjIUOt
         Cx2AeItH3KuQSNAPF/3UgsjGKwI8WMyJseAjZyoBXI7ZKa7YE/wlDMzYyrT7YIDkvt9t
         zOJfny1tlTTQpsTESOJeVET7bCwhPmTsf8JWpbGC9XYIKe4GxoGRP9pfDWTKYXXFihFq
         EDaRpEG1u+S25wm28DZ2Z1CZ7U5wdNnQeCfKXTqIZUK7uBIpFvVGyUO95BkxSJVpv0vM
         kThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlkQiDl11YIjYuyR1ccWXrL5KHIHXuUTF3IcNdXO2X0=;
        b=YcQ3qoQHKkzPt///LLPuaD+Rcp3SWutuybTOWor3lM0vKh3BQXFe+bpoIz1whFcI3Q
         OCfd5S6tYAZ2A8qI7FnO7MiyQqNUjct4hD0n4kiu71OTAetzAe7/jYcnPXMm72g57MCR
         BSetv7DHLYoB/oaVSFsX6SrbUGFBSIK/lZlyuCIIot9bMwvuzzf9b2vMeJpNVYvfmKuZ
         qS3gQhE4fQMY1rNmf1lQWGCCABcU8HRoQtok1N5aYWkc0a3xn32BYdKe3qHnS35CK5sY
         hSAjeNIHTG7qzbF4d2j93cyoaC61zXgl7MN4sp5QkBi9ersOuJMk3YbYf2UeI526jfQ9
         2MXg==
X-Gm-Message-State: AOAM533mHKi24vWB0Sq57vN2MjE7wouztXIvSejzv9142sAvu/GGlAll
        sSq+IvtYj/GNKfuL+0faNqppfMfRYZcNew4VyHM=
X-Google-Smtp-Source: ABdhPJxh/sCSuhYAwLgTJKiqo4esVKzab45wTm1aFgmpzlZ+HTMYvO07e9MOwvbCBXYXAusteZN/wm806OHdVmwXfq8=
X-Received: by 2002:a17:906:86c6:: with SMTP id j6mr17430287ejy.197.1616402974469;
 Mon, 22 Mar 2021 01:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <1641138664.431077840.1615652537045.JavaMail.root@zimbra39-e7> <139173043.431119331.1615653441685.JavaMail.root@zimbra39-e7>
In-Reply-To: <139173043.431119331.1615653441685.JavaMail.root@zimbra39-e7>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Mar 2021 09:49:23 +0100
Message-ID: <CAP8UFD3r+kJTxYCvaToyQXO59PNJiZOfOFwUz7FzTfs=hMuHWQ@mail.gmail.com>
Subject: Re: [RFC] git-rebase-rewind, nested rebases, remembering stgit
To:     Yann Dirson <ydirson@free.fr>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yann,

Nice to hear from you on the list!

On Sat, Mar 13, 2021 at 5:45 PM <ydirson@free.fr> wrote:
>
> Hello there,
>
> I often find myself doing iterative refactorings, which can lead to
> long branches, and while rebasing to edit HEAD~10 realize that I first
> need to edit HEAD~20 or to add more commits below that stack.
>
> If you've used stgit when it was a thing, you probably see how it
> helped doing that.  While git-rebase has grown to do much more than
> stgit in most areas, this is still one area where with a pain point
> for me.
>
> Here is a small git-rebase-rewind script I've been using for a few weeks,
> starting with my most common use-case: automate worklow "edit git-rebase-todo
> to prepend 'pick' commands for the N previous commits, then reset --hard HEAD~N".
>
> As you will see from the new needs revealed by using this script (see in the
> script header), I believe it would be valuable to integrate such a mechanism
> directly into git-rebase.  Notably, "git rebase -i" itself can be seen as a
> form of rewind, and this rewind feature would benefit from all the interactive
> rebase work.
>
> Does that sound like reasonable premises ?

Sorry for the late answer. It sounds reasonable to me.

It looks to me like a way to restart the whole interactive rebase
process though, so I wonder if calling it "--restart" would be better
than "--rewind".
