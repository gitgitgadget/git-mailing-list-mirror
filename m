Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D8C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F360C60E78
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbhJ0R03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbhJ0R01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:26:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9087C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:24:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x14-20020a63cc0e000000b002a5bc462947so1074800pgf.20
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gu5U1ShIZHYPu3kzRVSy+LflUrpMcx5I4rCYNMXw/uw=;
        b=F0YQvZnzJSCp5WNNv9dQtQ9skHVW1iuFoTwFrom/oNe3UY/gliABt/NOH7P4MoP8u1
         9w40NrwBaTqW1NtezqetehHCFALS87mZ9jsJSaPDYSDDJlCtD2lb6UeXNUmIo8rH3Y+j
         qgWoHMSVSN4pupmmVvvqVvGKVL1onMYhdcQ6BjdHPYPahF/ehiZ5zKbNDWd4tjCQwokB
         4lkBdLBKEXR4C0DaC/yW6JpOASpepFV0Y40EZVgIaKxpAxpd/QQOP78A+MArphqCnqZx
         WB+NFeX9e/sJbgJPtMz9joeeCd/g1v1rkZhHf5kJHxZbwqyjWrLjKQ7V7MuMMoh5ImHO
         RSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gu5U1ShIZHYPu3kzRVSy+LflUrpMcx5I4rCYNMXw/uw=;
        b=FV8t2AR7N2iHsvRZzl/UGgnMQooHJXvjlD5N64iGp7ws7inYhWWp14qxgFjtUYNIIn
         j1+TJw0o3CYCpC5WLW15x2IdG5m7KTUzF+hd/JsMaFRSaABztPNChWVG1NQEF6f31duH
         LvOwIVhjSRAbZP7EBqd13leEA1ot5mrviTBHbD/+MU0o5UjuaNDTq7sIKW6i39KLX3WV
         rvFdyg2YhBfR9weThzM8sx5XYDncIgfZGgjA4PtOY4yVILQDF3yv1iotBkUEq3k1IvgB
         2m6daNNSzuxikVv6ymlCKWgFuvM6VzHmVJKPW8hRCK4lEK6IjgUJ2wm0CjO4joPfWUj4
         u8qA==
X-Gm-Message-State: AOAM533fn5Ha1Dr/OL0U7FhXq42nRTNQQn0c/gFSvd+POvWopor+xePl
        tqCdDeRPEdcKyht5Sl3+ngRoU+zos5X8qMo0Ri6Q
X-Google-Smtp-Source: ABdhPJxvTOVAJuvxUyEVkx1VeztXyMgoqN3EY4Atu+4iTaq6jpNhKhAAxwRYskZVf+SCQGS6z7oY1fq9zLnGSH6yeq3J
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:b606:0:b0:47b:e32f:9ca with SMTP
 id j6-20020a62b606000000b0047be32f09camr25473864pff.57.1635355441128; Wed, 27
 Oct 2021 10:24:01 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:23:58 -0700
In-Reply-To: <YXk6nLJTZn1ilsf6@coredump.intra.peff.net>
Message-Id: <20211027172358.2227660-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YXk6nLJTZn1ilsf6@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: Re: [RFC PATCH 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yeah, I agree that it's not quite as turnkey if you have to assume
> something about the user's directory structure. On the other hand, they
> have to decide to put the included config file somewhere, too, so it
> seems like you need to give the user "do something like this"
> instructions rather than purely something they can copy and paste.

They can copy and paste instructions to add a package repository (e.g.
by editing /etc/apt/sources.list) and then install a package.

> I dunno. I guess you can assume they'll put it in ~/.gitconfig-foo or
> similar, and come up with copy-and-pastable directions from that.
> 
> I agree that the "match the remote" rule makes things _more_ convenient.
> Mostly I was just wondering if it changed things enough to merit the
> complications it introduces. I'm not sure I have an answer, and clearly
> it's pretty subjective.

I am almost done with the implementation, so maybe the community could
look at it and concretely see the extent of the complication.

> > > Just brainstorming some alternatives:
> > > 
> > >   - We could stop the world while we are parsing and do a _new_ parse
> > >     that just looks at the remote config (in fact, this is the natural
> > >     thing if you were consulting the regular remote.c code for the list
> > >     of remotes, because it does its own config parse).
> > > 
> > >     That does mean that the remote-conditional includes cannot
> > >     themselves define new remotes. But I think that is already the case
> > >     with your patch (and violating that gets you into weird circular
> > >     problems).
> > 
> > Hmm...yes, having a special-case rule that such an included file cannot
> > define new remotes would be complex.
> 
> I think that's mostly true of your "defer" system, too, unless you keep
> applying it recursively. The rule is slightly different there: it's not
> "you can't define new remotes", but rather "you can't do a
> remote-conditional include based on a remote included by
> remote-conditional".

I was thinking that deferred includes cannot themselves have other
deferred includes and that which deferred includes are included would be
computed only once, and those would be the only rules. (But I guess this
is moot now - we're not doing this approach.)

> > >   - We could simply document that if you want to depend on conditional
> > >     includes based on a particular remote.*.url existing, then that
> > >     remote config must appear earlier in the sequence.
> > > 
> > >     This is a bit ugly, because I'm sure it will bite somebody
> > >     eventually. But at the same time, it resolves all of the weird
> > >     timing issues, and does so in a way that will be easy to match if we
> > >     have any other config dependencies.
> > 
> > My main issue with this is that different config files are read at
> > different times, and the repo config (that usually contains the remote)
> > is read last.
> 
> Ah, right. I was thinking of the definitions within a single file, but
> you're right that the common case would be having the include in
> ~/.gitconfig, and the remotes defined in $GIT_DIR/config. So yeah, any
> ordering constraint like that is a non-starter, I'd think.
> 
> -Peff

Yeah. Thanks for continuing to take a look at this.
