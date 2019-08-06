Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E581F731
	for <e@80x24.org>; Tue,  6 Aug 2019 21:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfHFVHM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 17:07:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfHFVHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 17:07:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so36011902pgc.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gZxNSAdkfUq+mMUVC2wRqywpj9JXQi6J3/PvDAaLPsY=;
        b=cyRvgwD8dy9VwlTcJ8659HyETAOm5ozCAxPz3la3ee5337pUqpYsb3woZQENgcC400
         6jRnYvtC4gFHDqf9mMhG5baKZTgvxojCIcYN/GBOEKTAop8AoQqHa78Khuv4G9Kv8Urj
         tKYa6pxoJdyN9taWq7pQgNF+VK/UOFEbEE54h7W1hYGeWZBSHL2Q9unkQxKE8tI1LhMy
         XWjTv5YwHF3rtVobdQqG5SG/Q64aSxVbnsBd7cHqayyeGTVjq4tyytDgp+gaEpn5Bgek
         QHXy4Yu8WCeQjbkDke9TssYV9CVYCQfkXCrLShvAit56jAYMvGLPOUGXhfImlnf0iBvI
         d56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gZxNSAdkfUq+mMUVC2wRqywpj9JXQi6J3/PvDAaLPsY=;
        b=qwSKI5l5PsmfhG3nBm/2tkMtVlIp2I9VeP8ATEtxb/bKGjgpJHJGssk86L8183WjVX
         omKjN3413PJJk/di4Ox/8lq+4dpByI8NC0dwTeUTZkZjca4yHbnYDDnhih2ens4+Z2XV
         f9XW8k50fYFpepmpYxJjvDDcUCpQyaJALgysycXPPVXK+dlitJeMmN/h9+LzdmwjUsCW
         lRgKJKQqvu4tEChkFzHag1i2Haq2F7IT+/DbWNz+QuUGjtryd4FydbU9VagGGmQw7HER
         itTebz2ShZc9asYKFnwgmPYOpoHIKjQkBAQs/0sbayV+U8+dQL7fTnfRWqyBS5qyp8bV
         Tu1Q==
X-Gm-Message-State: APjAAAXK4wYA5MNsNYdWR8vJJXOsFv720d6RVuR/2vTUZHKVhDQg5LEn
        oyYEUmCCU4UullkCVUYS2tbbgw==
X-Google-Smtp-Source: APXvYqxQ+ld46n7TZWjVw6lJGTbyx4IwkqJxiCJvOqq4zH6nBXeMaywpYPx5mfjEdOxeJGFXwS0Svg==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr4859006pgv.315.1565125630675;
        Tue, 06 Aug 2019 14:07:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id z63sm62819933pfb.98.2019.08.06.14.07.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:07:10 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:07:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190806210705.GC196191@google.com>
References: <20190806014935.GA26909@google.com>
 <xmqqlfw7klwk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD1XNGWf8=_LvrEsFswZdw5pydk2VyVWxWvwALfhVbBOsg@mail.gmail.com>
 <20190806132730.GC18442@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806132730.GC18442@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 09:27:30AM -0400, Jeff King wrote:
> On Tue, Aug 06, 2019 at 06:59:21AM +0200, Christian Couder wrote:
> 
> > When Git Rev News was started I thought that there could be such a
> > group effort to encourage each other to publish articles in it, but I
> > must say that outside the group of editors (currently Jakub, Markus,
> > Gabriel and me) it hasn't happened much.
> > 
> > Each month though there are a small number of people helping on
> > smaller things like short news, typos, releases, etc. And people who
> > are interviewed are doing a great job when they accept to be
> > interviewed.
> > 
> > Maybe it's also not clear that we could accept other kind of articles
> > than just articles focused on what happens on the mailing list. I
> > think we have generally tried to highlight articles by Git developers
> > that were published on their blogs or their company's blog though.

Wow, I definitely didn't realize that was an option - I have a couple of
Git-centric personal blog posts I probably would have sent along. Oops.

> 
> I think the audience may be a bit different for Rev News versus a blog.
> I'd expect the blog to be written for people who use Git, and want to
> learn how to use new features, or maybe broaden their understanding of
> it. Rev News seems a lot more technical to me, and mostly of interest to
> people who are part of the development community.

I wonder, though, whether it helps enforce the ephemeral nature of blog
posts like this: "Here is an interesting topic, which is valid as of
2.whatever, and we probably aren't going to come back and update this at
3.0 release."  (At least, that's the kind of maintenance I'd prefer to
do for this kind of blog. :) )

> 
> Which isn't to say those two things can't co-exist on a site[1] or a
> blog. But I think there needs to be some way for people to subscribe to
> one but not the other. Because I suspect that too many posts about the
> development process would drive away users who would be interested in
> the less-technical posts.

That's a good point, and one I wouldn't have considered since I don't
use RSS to subscribe to things anymore :) It seems reasonable, to me, to
roll up all this stuff under git-scm domain - because it wasn't clear to
me that git-scm existed primarily to host Pro Git. I thought it was "the
official Git website" until only very recently. Perhaps I didn't read
well enough. :)

There does seem like a reasonable case to have a separation between Pro
Git, Rev News, and this blog thing.

> 
> -Peff
> 
> [1] By the way, Rev News lives over at git.github.io, but there's no
>     reason it couldn't be integrated (from the user's perspective) with
>     the git-scm.org site.
> 
>     I wouldn't want it in the same repo for technical reasons, but it
>     could be revnews.git-scm.com or similar (and possibly styled in a
>     similar way).
> 
>     If you're happy with it separate, I have no objections. I just
>     wanted to make it clear it's an option.
