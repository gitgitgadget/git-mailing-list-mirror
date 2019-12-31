Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFFC2D0C3
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB59C2071E
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uz6tKwQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfLaAEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:04:25 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46878 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfLaAEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 19:04:25 -0500
Received: by mail-pl1-f202.google.com with SMTP id t17so2661905plr.13
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 16:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xk4APnXaHddH0v49lS7xOukxLH1KeAd1fdEP+SLRCSk=;
        b=Uz6tKwQ12yQhEvi92IEEtt7ZD5YPqcUp9HOSkEyeqheOXAriiv1qCvoehXQxljAxdB
         1qVjT3/Y1u9siDQFp/qkcv6wWyOBfpLRPgkbevtPkUXJfnC6wD5b3lXhbeDGpWGLwuIz
         3sD+UoIpUh2xcycep/7KfDGyhJ4O2wv9qb7d5733BoJe4KsgXPcZkvjHFDrMvQyXKjCH
         Ji5+/B50zNdCSXg2kLVf0D5u87MbsTuRKEKqeBno4Z5e9WfObJrAvGhyPkuiDk4Oyywg
         QLYoKYybpJEeKCPK2EPJTL1aYSclK8Rh6WVp/KVH8JDfmhg0Og/jFrsvyJdc3bxMb+uL
         wLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xk4APnXaHddH0v49lS7xOukxLH1KeAd1fdEP+SLRCSk=;
        b=bu6paxA02kdFIrO6ALSu1eXChZM+8NpspmvnwNLHLfl8n2b9m0hm9X9VoVPaekxvKW
         KpifV2zP28GaQj3Gf8tqmwLWie4f0HbttxHDqfB8T7VfJd6QgSV06IUPESvHvfHi5dQh
         sT2hsCw0K0M9fNF5P7rfkFesnqb4jLhxfbzGC0nTNZwC+X2MdhMwBzCN3n1Lv67RZkPw
         eqH4VFjJyOhDzCTklF/e1aCc/p/ZaDcA15oVKlIZbOlsoscsCW9k62S2cKnMZUHlTCqk
         2DXbGnr6hUYTLzekBhlCMjqxCUE4genRjlDamxUMu1sTQfjubvLgMAyG3YnB0GZw7xCg
         8Z4w==
X-Gm-Message-State: APjAAAWrgkrRj/RNq1Jv4L+qa2KkdZOzf+mRl2Fg4ihaxxWNkS0quvo2
        a9BAOH7KN1b3frw+V0W5LYuGM0LMkjurNMT8RKuL
X-Google-Smtp-Source: APXvYqwI1yTnXsq1J9CpG4N0Zkp/Yy/jbAeqofD1tXeBTAWe0MTUM3kfZKTmeeVhRDvvWDp/lbnp7HNzBBfH5+4uoq8a
X-Received: by 2002:a65:488f:: with SMTP id n15mr38375483pgs.61.1577750664605;
 Mon, 30 Dec 2019 16:04:24 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:04:20 -0800
In-Reply-To: <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191231000420.32396-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, heba.waly@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This fix was about "we do not want to unconditionally drop the
> > advice messages when we reject the attempt to commit and show the
> > output like 'git status'", wasn't it?  The earlier single-liner fix
> > in v1 that flips s->hints just before calling run_status() before
> > rejecting the attempt to commit was a lot easier to reason about, as
> > the fix was very focused and to the point.  Why are we seeing this
> > many (seemingly unrelated) changes?
> 
> In any case, here is what I tentatively have in my tree (with heavy
> rewrite to the proposed log message).

Junio, what are your plans over what you have in your tree? If you'd
like to hear Heba's opinion on it, then she can chime in; if you'd like
a review, then I think it's good to go in.

I think the main area of discussion is whether we should go with Heba's
attempt to address Emily's comment [1]:

> I think the intent of that commit was to not put hints into the editor,
> so does it make sense to instead wrap this guy:
> 
>   /*                                                                       
>    * Most hints are counter-productive when the commit has                 
>    * already started.                                                      
>    */                                                                      
>   s->hints = 0;  
> 
> in "if (use_editor)"?
> 
> I didn't try it on my end. Maybe it won't help much, because we think
> we're going to use the editor right up until we realize it's not
> committable?

And I think the answer to that is "s" is used throughout the function in
various ways (in particular, used to print statuses both to stdout and
to the message template) so any wrapping or corralling of scope would
just make things more complicated. In particular, the way Heba did it in
v2 is more unclear - at the time of setting s->hints = 0, it's done
within a "if (use_editor && include_status)" block, but (as far as I can
tell) the commit message template might also be used when there is no
editor - for example, as input to a hook. And more importantly, when
s->hints is reset to the config, we don't know at that point that the
next status is going to stdout. So I think it's better just to use the
v1 way.

The second area of discussion I see is in the commit message. Commit
messages have to balance brevity and comprehensiveness, and this can be
a subjective matter, but I think Junio's strikes a good balance.

[1] https://lore.kernel.org/git/20191217224541.GA230678@google.com/
