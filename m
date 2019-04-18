Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B027620248
	for <e@80x24.org>; Thu, 18 Apr 2019 05:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfDRFTH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 01:19:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36267 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfDRFTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 01:19:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so1256157wml.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 22:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Px1qOJVD4tf2w+9EdIekdYXydZNDIvbPLiY+nGs73JA=;
        b=n0aq1/VdOOP2ci+q+eIfHFey3TyAq0jDVHSYCyOzeAtYMxO2ARYapgC4/YKp2tC4Yb
         dNBTz1YUbyxnbJ6p57q9ryJ60VzKR/wcjTsONAWrpdLsO6zipAKKiW6sJIsKBxLbVBKh
         Lzb/Q+6YfMJVRkzonE8e70ve/noQwJkWTUS5fqyAUmbG8zH0HAXFRQLaJoi20JQ9lIp1
         xtb06xGCcjCf4PsB8fOiL6bGrrsifNuBwdBFzjfnpp24n6KHvMfPrUcrPsDJffe8W+c2
         BhuzNggAsev4548uTLluTeIpws+H/XGXSuX5urKlRNHWJzvkNbzqfFhJ9/bDC4DAKjtD
         spWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Px1qOJVD4tf2w+9EdIekdYXydZNDIvbPLiY+nGs73JA=;
        b=kD3tCQopM1R15DMZwNTkI5bMxcsOHMhYm/sEdD21RlZO4zUlyn4WNH4NhVZmDjRPjy
         mrZypaI8DFS3AQf3wVvoQour4P0o8pYnOxN1RcXpzxym7LTzSljPdAftiWFeihXx/LKN
         VAS4d7hpv44BmevN32CxLLXmuMxPLmkKMIq5qNm1x0JV2EkozYk16o1eyU8b8Z6cbuQI
         4FU7Pl6zDiX2TrjtF60hMHjtmHqBQMTYb255KUo591rrMuiZDXtSmlnKENFtHvF5DsVX
         ApBk4LuLU0JgNJhSt2DOIMtWn2qa4coWO+hTlrCHVg+aCDp5eeIHwR4wyewse217nk+t
         uEiQ==
X-Gm-Message-State: APjAAAVq1LZJXYG+9Ah+OwPLc6JayGjVAJMJSC7Kdpfo99GoTrGMLvGn
        IF4hYh1BqAyKPy2T8jU8/YM=
X-Google-Smtp-Source: APXvYqyyW3COtXVbPrIVRRowJdx30L8E463Z20ZueLFZ/bK8QEki7AkN3KZH/2ycFUY3psG5FJf+7g==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr1423370wmg.19.1555564745525;
        Wed, 17 Apr 2019 22:19:05 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a8sm815668wmf.33.2019.04.17.22.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 22:19:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v10 00/10] Fix scissors bug during conflict
References: <cover.1553150827.git.liu.denton@gmail.com>
        <20190417102330.24434-1-phillip.wood123@gmail.com>
Date:   Thu, 18 Apr 2019 14:19:04 +0900
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Wed, 17 Apr 2019 11:23:20 +0100")
Message-ID: <xmqqk1frhovr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> With Denton's blessing I've rebased his patches on top of my patch to
> fix the message cleanup with cherry-pick --signoff and -x [1]. I've
>
> [1] https://public-inbox.org/git/20190329110842.30604-1-phillip.wood123@gmail.com/

Hmph, I certainly saw that patch, but I do not recall seeing any
in-depth review of it.  How ready is it?  Was it because it was
trivially obvious that we didn't see much activity on the patch?
