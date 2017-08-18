Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9C1208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbdHRWFc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:05:32 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34758 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbdHRWFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:05:30 -0400
Received: by mail-yw0-f174.google.com with SMTP id s143so66434498ywg.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WHw0nWMWvqpZn2Q7SVfWtkv6Qtm3mBujdA6RGXfuQ4A=;
        b=G2NsRNXPz+6BSQJVmcE80qUU6ZiXek8N8vrO/R5PSmPZceK6MQBZF3zlLqe5+ONsQh
         PiUL/dAhoGx9m5Ixtb+KFDuliZfKL23EN11mRf+MztAbR8ZhxRDG4SB5rmgN17/gCexK
         Na2oL63klIvDfCGW5ew3KFCl3FlR1ChO/TeKnA//14DSN7atXVnHbausrMIHvatgyvuC
         1TLbyUzgTtAW54kEpYKUKB9EUBCE9FUk89ori4ictWgZnF//HBtGQ9cHO+FEbAKrnfIj
         B55WvmUQlkNtKe5o+ofieTnJGzLDOi6gRnS3e3yaDBwe6gFQHWoq3VacFkfvAg72AoRx
         Y68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WHw0nWMWvqpZn2Q7SVfWtkv6Qtm3mBujdA6RGXfuQ4A=;
        b=PnFK044/W72Ld43u9d98+Nw8GT42EfH4xiqlUVpb5oT5Q1ItWvQBdCKfmBqUZCq3j/
         oNvDTOQdwfrXafI3ErY5kEef2Y6tjgJVHKvsXrwIbGeKFqToaH+jM3whi3ukWJWXLtzk
         irdpTBcWnxiqG7BqKPfzQonwwtXbNadwHVV3deescTyzlW9nkSzbC06v8pPk2H8CIN75
         UDTFHj6MKbBP/CbLM8Y5WxxuUJTTIKCA2S/FCPPOo0hX2SheRvjJB8eInPoGeqKKoBZM
         gPNoSSzze4oj0jllzxbPPFuAlAQ3dE+Xl5wYgZ6yi+P5R3dGkL+Ci2zzPzfKcxnQ3j+T
         o/Lg==
X-Gm-Message-State: AHYfb5i/ZjITkjMYZBI5bLc1Px3xcbwWmQJeQeD+RK2cdwVGLSHUMChY
        AdQ/rDjJkND9jgNLyuFsDW5GYGk6Nt733RM=
X-Received: by 10.37.208.146 with SMTP id h140mr7814842ybg.151.1503093929667;
 Fri, 18 Aug 2017 15:05:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Fri, 18 Aug 2017 15:05:29 -0700 (PDT)
In-Reply-To: <20170818220431.22157-1-sbeller@google.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com> <20170818220431.22157-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Aug 2017 15:05:29 -0700
Message-ID: <CAGZ79kbQP8mR9Y5Yo7e4uDwQLP9NQjduuErx4YcTo=NpLCCn3A@mail.gmail.com>
Subject: Re: [PATCH] pull: respect submodule update configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 3:04 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>

eh, that is what I get for amending to Lars patch.
