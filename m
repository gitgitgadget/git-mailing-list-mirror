Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E621F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIQW70 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:59:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36648 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQW70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:59:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so18192141wrt.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VVvRBpGuHGrne7ZQJj4h/w/gMpqKnlEj24qTrIZKDeE=;
        b=m3GCdxg2P62pcPitxLzJKkfb0a9OeAlbqbn484XCYBAAORByQZ5qBGfs+JOtTttc6s
         2MEiKcE04saw4SDbHmUaVTo5QTM1YeYW37W5EtzrU4D+5mfsIs6/9CaVq4SHEIqLuOEd
         PF93+zTmcBopPuiWR//8+hVoAwAW4Kpu5rtNO2YOOByuYjaczwFkUdX+cmD3KO99kAMx
         yzkh4f+tUbAuyqM1fFDQg4laT0OTwZ6g9QlFhST7q0PUYaqKyijb6tYQOB1Yh9yjKAGH
         Gg2btmOxp8CGsNjQw2Pm8aMqHrLOElOf4LfjCxSMkTbGgAKMWzI/WX7yYcvNZD4W4VXA
         vmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VVvRBpGuHGrne7ZQJj4h/w/gMpqKnlEj24qTrIZKDeE=;
        b=gzywoW8gAUTWwBiG207Z5fUwwT5Ca2wL4fkqJd8blNGMUrgIIPgtNtjgKAovE+gR/3
         Yba93Hi16XgOpC0yxRbc5JXrW7jeAIa4vBGHlpGrYMJbBR9JpXoSPih3N6oRa5uLbhbA
         DUEgfgpOXik4CwwnFpgEylwhJdr6HM8ptB1kxEP5Ge8ZOK9lCCjOa74JZpS+AM5cbugw
         oE3tYUcfpmyAGnat91NTx+bwas3T2JKjMuqZ09G6uxZkn2DSLj+tbKtM1KXKKuMwUjq+
         OwIlA3TZEFDfHdkKEvwM0O9QmFQHolZnK1cwutYsGWfIUKaW0iRkSKaOtFfRuFAvOV/u
         5nHg==
X-Gm-Message-State: APzg51Cp4x0hd1Be/u03x3qqklsn414e8ZvQb/dzXOzLvmuE35kWApql
        D+RAqYkEGzS4wg4GYAPB0HA=
X-Google-Smtp-Source: ANB0VdZCf+3D7hXgRVE2Nx9Bi1/qAUgp3X9mgAu0f7B8JILz5GkeNj6H8YQasSlgOkt/OJd/mlLXIQ==
X-Received: by 2002:a5d:61c1:: with SMTP id q1-v6mr20747379wrv.33.1537205464324;
        Mon, 17 Sep 2018 10:31:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l16-v6sm5570504wmc.38.2018.09.17.10.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:31:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180912161832.55324-1-benpeart@microsoft.com>
        <20180912161832.55324-2-benpeart@microsoft.com>
        <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com>
        <f7250999-71a3-0113-2858-e66bad283db3@gmail.com>
        <CACsJy8DEvLJYBm0P1VtvKFD-CAo6_4Z13dBHWkuuAavghbGBag@mail.gmail.com>
Date:   Mon, 17 Sep 2018 10:31:03 -0700
In-Reply-To: <CACsJy8DEvLJYBm0P1VtvKFD-CAo6_4Z13dBHWkuuAavghbGBag@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 17 Sep 2018 18:05:10 +0200")
Message-ID: <xmqqsh286nfs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> But it _is_ available now. If you need it, you write the extension
> out.

Are you arguing for making it omitted when it is not needed (e.g.
small enough index file)?  IOW, did you mean "If you do not need it,
you do not write it out" by the above?

I do not think overhead of writing (or preparing to write) the
extension for a small index file is by definition small enough ;-).

I do not think the configuration that decides if the reader side
uses parallel reading should have any say in the decision to write
(or omit) the extension, by the way.


