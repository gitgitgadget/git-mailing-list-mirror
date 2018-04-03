Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1DD1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDCTj2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:39:28 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53860 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDCTj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:39:26 -0400
Received: by mail-wm0-f45.google.com with SMTP id p9so35712213wmc.3
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=C2Dl8XD1s5JYy5bFTXTMjUkMpDna9dzJb3US6eWlzfU=;
        b=MKRY9zmPYpuB9j4D7E20DHbtLBmNO6lqjDU3jH8Bm+bXB9uVtBBvQxMdlAvVZ3kSJP
         FY0+oFd05iKZ8/kV+xIkBLUyEfLl+soW9fqtDkB8T8Q6qShcavDsxC0je+vh+beYCqA/
         RZUoc0GC4KJ7R8ASpHlM1BTf9rOkACIzORatjdfETJlUWACpR+i3B7h1t9ErYIuKQDG3
         +SC5nq4qHjkGgam9CLcg5N3tsunn0nLGlYmlLUFHf18dDO5q93XR9MUHK0l9jo3XhcAf
         kthZmBjUy3x1ORFhGoUTy5/KyaFTZ7U2YrGdkWaeSsHbrgrVeuVuCVscsDfflSFN4r3q
         qvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=C2Dl8XD1s5JYy5bFTXTMjUkMpDna9dzJb3US6eWlzfU=;
        b=s5jFuOXaj1k0n+jtWqy3Ma76olLcwOuRLKBQ5NxSZpsmVX2jSvz++q6m1RHzB72ybE
         kibn8528Hkvilo0gEsvqzQbUG4+akbgGc86VEkw7YQzwZbKp+sQ8cdhXEfBJoQi1HEuE
         Fr4zb0jrwx05X2LV+hkA3h5GLqDHYWxkOVLanNo1aPqvMwGxSbp8nU9oie443+Bv9YDI
         LBsTZEQ9R9sZDrSE0ZNhbyor012T+mUHFAwckdC/YHYfk6DvplU8/chCBfCCfxukASfr
         fLur9fCln3MjeG09qLINaZNrd2WSkJNYmdu9XkeDdFW8AL/c0C0xRKX2+VnzYitmmomL
         BgHQ==
X-Gm-Message-State: AElRT7E4wUJ7ToYeC7G4yHBNS/ZU6HoErfveN5CJOTXLCGTRJm3O3ZXj
        r3nd5XjT0+/niymSFOJfJ3s=
X-Google-Smtp-Source: AIpwx490JL3wzlqRWSezEW7LgtxbPLST0QKSjvX8mi1cpFnQ1DPT2yDLxRn6zFW6Tg/LKWlKqeBeQA==
X-Received: by 10.80.203.203 with SMTP id l11mr17612622edi.48.1522784365487;
        Tue, 03 Apr 2018 12:39:25 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id t11sm2141751edh.46.2018.04.03.12.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 12:39:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org, git@vger.kernel.org
Subject: Re: [PATCH 5/7] diff.c: refactor internal representation for coloring moved code
References: <20180402224854.86922-1-sbeller@google.com> <20180402224854.86922-6-sbeller@google.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180402224854.86922-6-sbeller@google.com>
Date:   Tue, 03 Apr 2018 21:39:23 +0200
Message-ID: <87o9j0uljo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 02 2018, Stefan Beller wrote:

> At the time the move coloring was implemented we thought an enum of modes
> is the best to configure this feature.  However as we want to tack on new
> features, the enum would grow exponentially.
>
> Refactor the code such that features are enabled via bits. Currently we can
> * activate the move detection,
> * enable the block detection on top, and
> * enable the dimming inside a block, though this could be done without
>   block detection as well (mode "plain, dimmed")
>
> Choose the flags to not be at bit position 2,3,4 as the next patch
> will occupy these.

When I've been playing with colorMoved the thing I've found really
confusing is that the current config has confused two completely
unrelated things (at least, from a user perspective), what underlying
algorithm you use, and how the colors look.

I was helping someone at work the other day where they were trying:

    git -c color.diff.new="green bold" \
        -c color.diff.old="red bold" \
        -c color.diff.newMoved="green" \
        -c color.diff.oldMoved="red" \
        -c diff.colorMoved=plain show <commit>

But what gave better results was:

    git -c color.diff.new="green bold" \
        -c color.diff.old="red bold" \
        -c color.diff.newMoved="green" \
        -c color.diff.oldMoved="red" \
        -c diff.colorMoved=zebra \
        -c color.diff.oldMovedAlternative=red \
        -c color.diff.newMovedAlternative=green show <commit>

I don't have a public test commit to share (sorry), but I have an
internal example where "plain" will consider a thing as falling under
color.diff.old OR color.diff.oldMoved, but zebra will consider that
whole part only color.diff.old.

I see now that that might be since only the "zebra" supports the
*Alternative that it ends up "stealing" chunks from something that would
have otherwise been classified differently, so I have no idea if there's
an easy "solution", or if it's even a problem.

Sorry about being vague, I just dug this up from some old notes now
after this patch jolted my memory about it.
