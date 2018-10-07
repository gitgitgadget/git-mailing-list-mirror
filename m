Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0941F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 00:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeJGHia (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 03:38:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34195 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeJGHia (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 03:38:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so6190832wmf.1
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 17:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D79fjWWAOpzeiyAnflR+q97SJDHy8v9bL8PIudHZwL0=;
        b=dWUTG7wsuehf+Z/LurHn822FXxb7NT++c8r8k/hkS6FOULU9y+dtYatJH2kjvNG8/9
         q7w/t0sJLWSwYAnTLRnCF0sELA6gVKCDrpphYw3hBw/8DJmyNtAThwwIxh/MEP0qw0iV
         Wp+M+qikJ2KhRum7Rmla9Om/vfOCU1j+3fmPJN5SWgcaFyHNW1iUIZU8wtvgMU5xHZCX
         VwSWdykNYH/weVaQBrj4mFQMMznYlH2ypT4a+DD1ogwNxL9j+K/W9F7Zf1/DQFaFWTdX
         yql94Hlo1Rci6NuQ1YbEYdwmV8ozbSL4HiPbwwUDilefJhclsE9vUtprRSCEGTqM+sYE
         3jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D79fjWWAOpzeiyAnflR+q97SJDHy8v9bL8PIudHZwL0=;
        b=bqCjt03lkki3KPyWnfw5Prxa0osv3GwnNpNuEOpEOBLgLjpmzYl3QQG8bTC6rkrzU8
         y9bd0vf6jmgyjJxJeEb0y74E55NW02G2qNxOim9hKRIPsCbU0hcyA6jGw/Qc9OHdyVwc
         +q3iy72EPiUWBLGNj1v+ca9urpqZIgoFMOqwQoRQXKXrClaL7xcfrjQgs4VgBrJ5KaSL
         6vklV53jEHz37i2rlh2fQeEc2/23OexaeUlFrF8yson5y27wN4ZFbdVfTEX90XfIm2Ta
         gEpd507W8Lkk7mJQuIo0mo7uGOGtuKk3Gosb3ZU8DesbK75Akib3HxlsCTc3lbJ9hXax
         Qviw==
X-Gm-Message-State: ABuFfohsdsaiTHZTBU9uOH8TlT92IOP6vPaka+6pRWGD+tarnLO5v3WT
        aBdBCUgH9LpjlMPYIJowcvU=
X-Google-Smtp-Source: ACcGV632aGLvvmpD3ZI2IHdNzF/UUlyoBWIWmiL7OnsJNNDvix+v5biKQNuixF4AhJz0JBmyAxH7kA==
X-Received: by 2002:a1c:9fd5:: with SMTP id i204-v6mr11941224wme.88.1538872392169;
        Sat, 06 Oct 2018 17:33:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v16-v6sm9804774wru.31.2018.10.06.17.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 17:33:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, ao2@ao2.it
Subject: Re: [PATCH] builtin/grep.c: remote superflous submodule code
References: <20181005224557.31420-1-sbeller@google.com>
Date:   Sun, 07 Oct 2018 09:33:10 +0900
In-Reply-To: <20181005224557.31420-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 5 Oct 2018 15:45:57 -0700")
Message-ID: <xmqqh8hyvbnd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> After ff6f1f564c4 (submodule-config: lazy-load a repository's .gitmodules
> file, 2017-08-03) this is no longer necessary, but that commit did not
> cleanup the whole tree, but just show cased the new way how to deal with
> submodules in ls-files.

The log message of the above one singles out "grep" as a special
case and explalins why it did not touch, by the way.  You probably
need to explain the reason why "this is no longer necessary" a bit
better than the above---as it stands, it is "ff6f1f564c4 said it
still is necessary, I say it is not".
