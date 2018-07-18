Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A991F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGRVRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:17:46 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45469 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbeGRVRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:17:45 -0400
Received: by mail-yw0-f196.google.com with SMTP id 139-v6so2229963ywg.12
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5+VUsDZwsDVoTJm1KOgzYGLN4DSWR7WJMjFw/fqRJs=;
        b=uXVfUt9clojbEajIXxg9H/bqtzcfWo8LzEUcNcXxPadYS6XRh9Jjjg1T5GaMXU7Fj3
         SO5yE2icgkH0KoyDh6pbE9T855nrp0xvutEgzF90nakCIq4ykulzsRFzxtU3oWJ0925r
         ocXKCgCxjtWn0MoZOF+a2PguqARWM2gZxO+1amNhlNOnehr5sQEi72LLKuv+J29N8akf
         GPZohAvZJjPGbkbuhA9nAfcPdkJdHGRto1ZBwqCNosN+Kphk9Yz0UUHk/xjsj2p+E1gv
         AiLGZC3m/Af5OeVNlg2Vgi4ngIwMVvermug8kCFOQyElHSpYM5dCv7sLiu23UxLaUWWh
         5ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5+VUsDZwsDVoTJm1KOgzYGLN4DSWR7WJMjFw/fqRJs=;
        b=ZgjCCcj5SkpF2kpgePFBrQFC0y2emHVC0c/2PvZqvnfswt3ozYVyewjh7sPtYkU5yK
         oYB5bCBj9oL7e1tcxVxng6zVL4F3Wc5SNCsFtuMeCtTXD94NhcWFYP7tTW5V2tg96IXU
         pwBDu1F2Es5jaoUxZCckfHuT21eM/FLeKQF05zcDW4DQVPD9DF4AlsrKCIwiYmE49wxE
         uxfpC0wWZ2i99TMRe2KtMGJ35EepFN4x85+078xDU+qWVEUqEUa7cQGdbZbktSwmc0s2
         /ZACCtLwTV4jzexqzHvmdLNJIPLxv5eBQn6dKMrqNhO25jq+Jk1GpZEAmk60fTRvg6zu
         FVXg==
X-Gm-Message-State: AOUpUlEFgqbKkFEE6Ox63zZTbY17fa1c4V68Z/cvroMGsjiDHV6DnNTK
        OwUW7FiFYKT0dtWHjr9zpq/b1/5N1DwbFj4J5v35Ng==
X-Google-Smtp-Source: AAOMgpcPdZAUr9bMT+HN5ZotfIYIwHNPi5bdxECaSSZ3WGcp47/U5SmqPes5KGCZFDG+kkKDKdaQgDYQky2LxKbfpWQ=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr3835913ywh.238.1531946289748;
 Wed, 18 Jul 2018 13:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180718201702.GA15306@sigill.intra.peff.net> <c36c1b42-3f37-b32d-08a8-2ced5d254149@gmail.com>
 <20180718203152.GA26110@sigill.intra.peff.net>
In-Reply-To: <20180718203152.GA26110@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 13:37:58 -0700
Message-ID: <CAGZ79kYhDwrEBtA2b_Cp3B4Mj-Qr+yrNGdHFQapLPPkngnyRuA@mail.gmail.com>
Subject: Re: [PATCH] add core.usereplacerefs config option
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 1:31 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 18, 2018 at 04:23:20PM -0400, Derrick Stolee wrote:
>
> > This patch looks good to me. The only thing I saw was when I ran 'git grep
> > check_replace_refs' and saw the following in environment.c:
> >
> >     int check_replace_refs = 1; /* NEEDSWORK: rename to read_replace_refs */
> >
> > This does help me feel confident that the case where the config value is
> > missing will default to 'yes, please check replace refs', but also the
> > NEEDSWORK could be something to either (1) do, or (2) remove the comment.
> > Neither needs to happen as part of this patch.
>
> Yeah, it was actually that comment that led me to Stefan's recent
> c3c36d7de2 (replace-object: check_replace_refs is safe in multi repo
> environment, 2018-04-11).
>
> And ironically, back when I originally wrote this patch, it _was_ called
> read_replace_refs. That changed in afc711b8e1 (rename read_replace_refs
> to check_replace_refs, 2014-02-18), which was in turn picking up a
> leftover from e1111cef23 (inline lookup_replace_object() calls,
> 2011-05-15).
>
> Since Stefan's patch logically undoes e1111cef23, I think that's why he
> put in the comment to move back to the old name.

I think so, too

> Personally, I do not find one name any more informative than the other,
> and would be happy to leave it as-is (dropping the comment).
>
> But I'm also fine with following through on the "do". According to
> c3c36d7de2, that was waiting for a calmer time in the code base. I guess
> the best way to find out is to write the patch and see how terribly it
> conflicts with pu. :)

As someone burned by coming up with renaming (or rather lack thereof),
I'd happily watch from the sideline this time.

I think this patch is good; ship it. :-)

Thanks,
Stefan
