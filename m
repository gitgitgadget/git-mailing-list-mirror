Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336BC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2590D611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbhERB1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbhERB1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 21:27:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225AC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:26:06 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id c3so8250622oic.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SQai7ZfsLKrAocUzLiWTOsRbCYuQjaQAmHtDaPnEdXc=;
        b=G4XAFtu202HmM7KXAzEvOTKOi3G/zpAX6e2uI6X+JSZNtYcbpjx+mVn6+kFLsMlUND
         9uxK0WVmr0gfskeh1nIIzE71SrqreFki874pAUfeNQmu7/qdWmTeOz5oUFOO+FQm+55L
         m0KurnErWQe8jchm8Gib3Cf4a3vs0HrZqjqlsdsko0aWkFCJP4a9gMIPiU7JAJqsJUSh
         LTRiFVjaid6PhH4LyA6Yqn02xgmQUEOycd0GU1BbN0QWybrXfCLxf2JmJPSbIzTSYqoX
         njTq1SvtrGh8ulLNPewdgu5OTAP0Wn8N+XxHB4CthACtATXoCpvyJp6WTv6B9dlIgJIj
         r9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SQai7ZfsLKrAocUzLiWTOsRbCYuQjaQAmHtDaPnEdXc=;
        b=aW1H0zBsbaefmemEbzh6d+tbI1ZiA7GruNPQthqqMUDq5q2QAKroTrlW2ezlXC5Wz6
         pgsOZP1i1zGcgLYpXai7Pn43F1a7mPQX/zCVEycoqnpOHQW9WFJTcVhK4txiWLOUx8Xf
         YpCPU0GCXiKkdh7oUUt9uwfQ+Xygxlyyted1xZQhaZfhvq5lrKtPAAZphGyv9597mE6/
         C+DksRUlWc6B+tFbvHYIxz3qfY20xJ5OYVSSW8x7vdQdNM3xwRHwQsGUMxBvQHVp6+Bh
         slEobpxuwpnIkcojX1Vu6bUCvHDebOnS+4p1o5FMHt+W5XL9UWaKAh6Ys6wuh75jt3VM
         Fj3g==
X-Gm-Message-State: AOAM5302YzqI+N2SYZQWnRi4hWIVhN/zD1ZnF/yLjdUTdrBOwYpUb4+X
        KZpfTGhbgxAzjQuCZDDLJPY=
X-Google-Smtp-Source: ABdhPJyBWCQuV5yi3aFWdJjgYKqBh6nugWvMJWGFSROFZi90byxf65RBTGmJvXnxoqX/li4Lv4/tZg==
X-Received: by 2002:a05:6808:54d:: with SMTP id i13mr2079209oig.100.1621301166001;
        Mon, 17 May 2021 18:26:06 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x6sm3359581ool.6.2021.05.17.18.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:26:05 -0700 (PDT)
Date:   Mon, 17 May 2021 20:26:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a317ab5068_149b6620891@natae.notmuch>
In-Reply-To: <xmqq1ra46f0h.fsf@gitster.g>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <xmqq1ra46f0h.fsf@gitster.g>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Junio C Hamano wrote:

> >> Perhaps.  Being illustrative for common use case is also important,
> >> so I do not mind teaching "missing endpoint at either side defaults
> >> to HEAD" early.
> >
> > A glossary is not a place to teach (anything other than the definition).
> > It's supposed to contain glosses (brief explanations).
> 
> Fair enough.  Then let's limit ourselves to the definition, but give
> a correct one.  It is not "syntax" that the phrase "revision range"
> refers to; it is what is specified by that syntax.

That's a distinction without a difference.

Like saying "Felipe is a person" is wrong, because "Felipe" is not a
person, but the _name_ of a person. This is excessive concern with minor
details to me.

In the minds of most people object identifiers are used interchangeably
with the object themselves: "Felipe" is a person, "master" is a branch, and
"master..@" is a revision range.

> [[def_revision_range]]revision range::
>         A set of connected commits to work on, usually specified by
>         giving two end points, like `origin..mytopic`.

endpoints.

As for the rest I already raised my concerns.

Cheers.

-- 
Felipe Contreras
