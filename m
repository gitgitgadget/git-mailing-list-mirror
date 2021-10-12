Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6EEC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1DF6109E
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhJLVn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhJLVn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:43:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D09C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 14:41:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x8so416326plv.8
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ7881MTtdjtewdWuHoFGQlj2FPdCXAnLvQ4LKnD8Ss=;
        b=AMijib1pAKMxZNXCgsQabeMBFC0e63MSBGSyCfQH9ImReE8cr6gj8i2TrrPexvn7tN
         ZoosB/thmghPqTEqElvWsStEV5mBlT9cVlrzyTJgXVq6W+2ARmgCfGOdC9tnd9TFH8ci
         aladzbUNM2kGe6C7A0g05UXduwF6Yg+vbzuq26AXOlN/xF1SnUZsLJnN7WAF6naF2gy1
         ysEd9+YxPUZeioU9rpTY2WHp09bDClVoocQHZ0rfzLMKJwghNzgwowq25M7Vf/0u9EKh
         k2FOyHEsRMC3qzzw0uldYrmgot0yD6Ts3bk5f4XNxku6ZHQypqesjrkA8oouxuCU2oGx
         poeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ7881MTtdjtewdWuHoFGQlj2FPdCXAnLvQ4LKnD8Ss=;
        b=cB3MKkZ3G6j9gv+tr9TpxznA/pBzteKU6+SoNPkCUwicBJc5n5f+q7ezY5GBS5edQ0
         rdDBXcRBxHqTNPO9+cPEGpu4X4DuLNgPG5eWc3SZaQYiGw6BwtIDKNzf6XtYQ1sH3g9l
         yv5RlJDpW0jWcNM8m6VtXiC4ZJW+VX1Q54Shl/Dh1mtSGCDqJaMpa/nmuBS2JuuL9FnJ
         jSB1yRbHuLtGGzRC3NrgF+N97ENPZh4kDOLdOeKZlq4hLZ6CfJ/nDdzc/4iFkf4ZcRH2
         wr1oX8ZJqjmxevDZKe5ZMAksp4o7MTCxOkyFDGNaAIIo0GZ720Hl3R76tXt0J72bgqRi
         Zsmg==
X-Gm-Message-State: AOAM532eOwZB7oXBO5lIggLn0T9LvZlEMcvVJPPOMrU4dcFHpWhreKTH
        Rbb3EZy62EglCPWQcyhgvS93tWBalBhw4sbMhfOKyOglgZo=
X-Google-Smtp-Source: ABdhPJxACyscHlgKMvisAD+xvH3qrcmwT8KzG4AVfva4SnTfJ+utIy930C38osh3UoVeHozJEBJ2ZFST/SmgDgCH1rY=
X-Received: by 2002:a17:902:cec9:b0:13f:17c2:8f14 with SMTP id
 d9-20020a170902cec900b0013f17c28f14mr25035717plg.66.1634074916001; Tue, 12
 Oct 2021 14:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOrononRUYK0HmW_tknApUV+ZJeDBwOYMa1Ax-VHXZmoJQ@mail.gmail.com>
 <YWX7cd5e5q84CDEv@coredump.intra.peff.net>
In-Reply-To: <YWX7cd5e5q84CDEv@coredump.intra.peff.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 12 Oct 2021 14:41:20 -0700
Message-ID: <CAMe9rOqQxk3cfxvJiJQRoG5=KVn2SkPbZKVa+w4MZP56OA-Z1g@mail.gmail.com>
Subject: Re: Commit ae1a7eefff may have broken git behind a firewall
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 2:17 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 12, 2021 at 02:03:39PM -0700, H.J. Lu wrote:
>
> > https://github.com/git/git/commit/ae1a7eefff
> >
> > may have broken git behind a firewall:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=2013288
> >
> > I am behind a firewall and using gitproxy:
> >
> > exec socat - socks4:proxy-server-name:$1:$2
>
> It's not the firewall; it's socat not handling half-duplex shutdown very
> well (though you are right that it is related to the commit you found;
> that's when Git started closing the write pipe when it's done writing).
>
> More discussion in this thread:
>
>   https://lore.kernel.org/git/YS1Bni+QuZBOgkUI@coredump.intra.peff.net/
>
> (the short answer is: use "socat -t 10").
>
> -Peff

Yes, "socat -t 10" works.

Thanks.

-- 
H.J.
