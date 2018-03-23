Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE9B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 02:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCWCGH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 22:06:07 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40058 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCWCGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 22:06:06 -0400
Received: by mail-wm0-f41.google.com with SMTP id t6so901674wmt.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x0Y/RE8cQ40NwenAY249rAuQhKae+1bZsEFv4eVy7FU=;
        b=poLviqs2xNNSqdi7mUezeFwedXnXymhFrFiPXkIfQpUbGYFOAs51mSSP7DRVQfKM9U
         KbJR3byZS09Uy3jygPuWKABue+3NhTag6I/ZlvjJz4vGbv5uO94rYgWkklTTM+kXS1eS
         q5W1l/i1AyI/3ecDk2lxslfiS/rMQd38j8I0XOP77g5qebASzGhYZlJ+hlxTeY0HJ7ZC
         Op4F8kbk0zQDxsqiqVAHuxO0Q8DoTK3QbJn8xhTujcWZ53ujE6ReWiQJImoGTXiP7iBn
         WlPhaceeEBuM6GaKBK5qZqhiHXY3mVAYeyJpG7AvgcWWWfrnUwj9B9Qtex20+NVysvuu
         t4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x0Y/RE8cQ40NwenAY249rAuQhKae+1bZsEFv4eVy7FU=;
        b=SOQgb2lozKojURHuyDoFnZ8fE0O4xoKgjeQmRQsV4YidxI+kprGLM2XK/OfnxF6JOQ
         kEKW/DRFbA1/dYmj3S1uwRmZRUIp+ET0rXNusy/hgRdX01E/2rD5qwnBoTNrHNzwYL2P
         V+t0wEpbWQzm/rrGmEe5vGEYe+WJ3YQSZCIHQ2KZb7xcGT09DlLq6OtDC2XHsPztpaZb
         CEevGzG7HuQTpKqvxt603XdTGMdfhkKHVXGCjCW8dYts7KOxllBn2YEpRQyMb68Tmim4
         MLGSjnLO54Nv6VIqmTMIrTqocpD3vj/X33NVQDSZljM50XpCi+MvHWxd01zHQsuAksYG
         GAqg==
X-Gm-Message-State: AElRT7HOETLoc6Z4qdYyjkuQlBasxasCqa9Ki5us+03uyb/ZPbKK2z5i
        xLz9LZ8lVpiG4p3zVprdnys=
X-Google-Smtp-Source: AG47ELtU+QLhMlC1XOFzpCm77+UhJrhlpekCbdxKiIzVKzeHKbnh1/AObDrL1AaKTEIslre37AcIkg==
X-Received: by 10.28.125.84 with SMTP id y81mr7120735wmc.66.1521770765323;
        Thu, 22 Mar 2018 19:06:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y68sm9696762wrb.73.2018.03.22.19.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 19:06:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3.1 2/9 2/2] rebase-interactive: Do not automatically run code
References: <CAKk8isoL--f1gt_p5XZ99ybN+xts=0_AKBo52Ej=n3SMPoMq3A@mail.gmail.com>
        <7ce3cfef9ff3ab97ac8292fae94a0024a1d85505.1521748846.git.wink@saville.com>
        <xmqqefkbltxv.fsf@gitster-ct.c.googlers.com>
        <CAKk8isrLrE+sC0Rfv6WUzjziSqGzRgk2xTOh-OKCeEpdxsPfkA@mail.gmail.com>
Date:   Thu, 22 Mar 2018 19:06:01 -0700
In-Reply-To: <CAKk8isrLrE+sC0Rfv6WUzjziSqGzRgk2xTOh-OKCeEpdxsPfkA@mail.gmail.com>
        (Wink Saville's message of "Thu, 22 Mar 2018 15:45:48 -0700")
Message-ID: <xmqqzi2zk0l2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Currently I'm not rebasing the other commits (3..9)
> to reduce the amount of work I have to do in each
> review cycle, is that OK?

Yeah, I want to see others more heavily involved in this part of the
system to comment on your patches.  As to the organization of the
changes, I have some more opinions of my own, primarily regarding to
reviewability, but they are of secondary importance than reviews by
area experts.  I think it would be helpful to give them a target
that is not moving too rapidly ;-)

> Also, will you merge commits 1 and 2 before the other
> commits or is the procedure to merge the complete set
> at once?

I am inclined to take the early preliminary clean-up steps before
the remainder.
