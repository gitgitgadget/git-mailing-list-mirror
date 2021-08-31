Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7207DC4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BCD610CB
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbhHaSDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbhHaSDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:03:04 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7480FC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:02:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id hu2so695163qvb.7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFzQO3s22OkvcbYqGJh7Vu3yoI/9Ud6Ees8LrVQbbSY=;
        b=u7ZL1JiwJWU4dT9AHwZxwDYDiFqfyGYOQm7XxLngHOVwsGC+zycBd/tQIKdXu3Rq41
         WqDyiOCOsFxhoQPOKRFqtMMzs/gXQBvQUyXaniXMEIh25Ia/yjJ1QFuEw8Y38Pw0Y27j
         TTE1Kh3mDCflXxuaWHFUJ0PjnmkS8M3nOU0Cer7dZqmode02D/UqQUoK/nj8DgRVb2iu
         u2jDX3d7mWM0ARgRBvlaSWdYA0c8bR71lWpysh50om4bkvcKBwtqzEKCD8f3JhWvNrEl
         8uhV5tc9+IaqXVuLKBsUl/Me4jqNgkq93epmK9MRjmg7fWOqAtyVCoUS5ZhHDHV6FhaO
         z9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFzQO3s22OkvcbYqGJh7Vu3yoI/9Ud6Ees8LrVQbbSY=;
        b=gn5+GnqJ6vW/6mEP/5otNsoYCE2HosUv4QiCRdG+yihyqq2FiZ9jXvS6rEjqHmVBMQ
         qn3c8QYsyTvFIVZpAPGp1lENJufgB8VkHA4q7sNMqh8xx08ID4nGC886QybVqDc2DM2e
         KWdMA2TXZ1u8Gt7K06iHYPgClvNyN7msmXSBDKNcPXcN1RFWbBUy+vq1XyLk3NAzeu4k
         OFNKVWH6n8vc4v/g9E6Amq6AgLPleHjIdgBCzZ2yVJSJNv58JOGTzGGnZXlndikNKVSP
         0OTmnzjwCJWrnf2Zod50JcGCIVs+4PajLlJw2JMu6iBqEllAr8OcEzFzxtOLYXVR7Cd2
         H8zA==
X-Gm-Message-State: AOAM5300jTS+kRjJRkq/HfWvS9Zqr5VNB9P2xgPhcaMPJcDwoSV1HNsW
        6tRSzQMMvCMxW++2iUw7tLwSRBqmf0IuPez/TXqk4D7n260=
X-Google-Smtp-Source: ABdhPJz3XmgV0EdR3eSZelu1YB1Br0w5Z+v9LhSvxkZsuoYwXatrHqJs3LCt/pWgQ0wXqx4ePXqBwGn6IrYMikAY1V0=
X-Received: by 2002:a05:6214:250f:: with SMTP id gf15mr30224184qvb.2.1630432928678;
 Tue, 31 Aug 2021 11:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
 <xmqq4kb5v6p1.fsf@gitster.g> <CAHBARKfLC0ie4p=xWk+xDbEH72fSF6qeWCf=9oOTH6M9V1Qh=A@mail.gmail.com>
In-Reply-To: <CAHBARKfLC0ie4p=xWk+xDbEH72fSF6qeWCf=9oOTH6M9V1Qh=A@mail.gmail.com>
From:   Andrew Thorp <andrew.thorp.dev@gmail.com>
Date:   Tue, 31 Aug 2021 14:01:57 -0400
Message-ID: <CAHBARKcKL8h-zHcyCHRAMCj8=-PghopTPkH9o-_8UYRJYNZFmQ@mail.gmail.com>
Subject: Re: BUG: `git commit` adding unstaged chunks of files to commits on 2.33.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> git commit" without pathspec would have made a partial commit that
records only the changes that were added with "git add -p" to the
index, though.

Yeah, that was the expected behavior, but not what I experienced.
