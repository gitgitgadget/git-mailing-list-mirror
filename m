Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6A31F453
	for <e@80x24.org>; Mon, 29 Oct 2018 06:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeJ2PJU (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 11:09:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35300 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeJ2PJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 11:09:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so4248112qka.2
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 23:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY0I8rrEMLlUwMB573bECYM3jcvSGiFeUvr2NInNmtg=;
        b=BuOQxRG1Wg1P0wUir1YrjWrkBgmAXtUh7vXYoHFhKGtMUIVxJSq3f2dkk8ZoG/rB0h
         lIdyMfv4p5LwHUqIb5vKx9tACCHJ4kY0Y/pzz3mY8u+G4p5hs4zJpXzSM9z94q36aItU
         yBoT3RVrXRaO++p8KjAteCWKgVBRq+i70R4dvKKwFczJO5xP7VyzY35+9nPGeadLGbr6
         kaOjQdpWR0wEJM8uGOyHOqX+F1tEj5OtEg80cTVLQPos75unzHNav3F0ZAxkZ62FGotX
         wr5/4qsg+Dc5+lRXijKQ1sYqb8QylW49CvQ05mvGIZKV8hlFNg1rd085mK/ocUG1x53F
         aNgA==
X-Gm-Message-State: AGRZ1gKD1gMKtF0kXguB9XFYLUJ5X+tdREGHXMOXiWZejv4X9VXn48Y5
        HILT/loShsa7XQOPCiBLUl7gdmsGdB2JdF3FPzw=
X-Google-Smtp-Source: AJdET5d6g4IAmePdmz0Ms0Xn51OyULB6EZMGF4WmVjjyilKJpL2K9IdVdmKMToP3I39NOjMOvy3ZJ8FWEEuLBCBK954=
X-Received: by 2002:a37:8fc7:: with SMTP id r190-v6mr11156803qkd.36.1540794124688;
 Sun, 28 Oct 2018 23:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
 <CAC05386cSUhBm4TLD5NUeb5Ut9GT5=h-1MvqDnFpuc+UdZFmwg@mail.gmail.com>
 <CAPig+cT1XYt60PsRGJ0FUa_qCn1vPjdXHygsWzYZYg2Ey=yqkg@mail.gmail.com>
 <CAC05387mfDhJ5_=LyzxZZX09MoY1hsmSB1gseNeLCmMOUx2O4A@mail.gmail.com>
 <CAPig+cTTsbz1pygq6G281V+fR2VVMuchvy1Q1H-KEvJpjJ9ejg@mail.gmail.com> <CAC05387rFq0yJ3nUVkb0jUyQy=EmZiCnBW9L53A6GS5=U0qUDg@mail.gmail.com>
In-Reply-To: <CAC05387rFq0yJ3nUVkb0jUyQy=EmZiCnBW9L53A6GS5=U0qUDg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Oct 2018 02:21:52 -0400
Message-ID: <CAPig+cS+djfZjoEbBNrVGpd4g6ZhsioSqK=ZyKprTwA0Hy4iiw@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 1:45 AM Nickolai Belakovski
<nbelakovski@gmail.com> wrote:
> On Sun, Oct 28, 2018 at 9:01 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > That said, I wouldn't necessarily oppose renaming the function, but I
> > also don't think it's particularly important to do so.
>
> To me, I would just go lookup the signature of worktree_lock_reason
> and see that it returns a pointer and I'd be satisfied with that. I
> could also infer that from looking at the code if I'm just skimming
> through. But if I see code like "reason = is_worktree_locked(wt)" I'm
> like hold on, what's going on here?! :P

I don't feel strongly about it, and, as indicated, wouldn't
necessarily be opposed to it. If you do want to make that change,
perhaps send it as the second patch of a 2-patch series in which patch
1 just updates the API documentation. That way, if anyone does oppose
the rename in patch 2, then that patch can be dropped without having
to re-send.
