Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0161F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGQS1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:27:16 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34005 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeGQS1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:27:16 -0400
Received: by mail-wr1-f46.google.com with SMTP id c13-v6so2108439wrt.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MaARojrrOHHnX5Zyhk/tgETqEPezb8dGguXXPaynOp4=;
        b=g+Qtbbodch+ti4TJHpSwKt9OVqGM4UQdjBWw+E7k9Y2JAU3nT06yr3A7e4bBp8dxTh
         ZZquZADN9d+5gu2oa8nkdrwikNBDrmD6BmV05OSwdASmHa/EXKUMbup2BTu/GkuO0oqC
         Noa3KcoGSGgeN4YVZYUV3MMU4XVFDK5p4Oya+v1GFUItDzo8DukVCGKHh/m8mL0oPy6p
         qMywtuftz0wxIsflr6KIwCKL027oxu0cY1+bYMpCYIVFGboqm0IPBMmixApCjynDuhxv
         m8/2KslGlpybrDvhG7lFYgWlNTArz8MWayRwCGsKI9kwbUHPJF1LsBN2yb2pLrF0i/ZO
         oQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MaARojrrOHHnX5Zyhk/tgETqEPezb8dGguXXPaynOp4=;
        b=KpDfZhzTkZK6brCMsUlmpG6xi4EzOtBaqDCmkDrGEiClniZ/BvW4NsmFkRpAE5XLLz
         Xr8QM6nO24F9CwhhO5K6/ywhTtENsz8x2c6eaeiPhop0TlHDzYtdKy3yeHJkM/getCeU
         2mdVRHonhwRVr6sKF7Wod90Nn7DVchXYo7yzN9BHZyFox9wGaa/7b+q2ffLxGwb8hZOU
         9oRvV97hoOU122LKqtu8ohhIJqM2mzvzIhmvxgb+7bvbKzXGTuLqS0bNhyC85qmPqKuK
         y2JoUxYjK65VFlhp3csk5kk6On8jFFlCwmWUtYuVrlkfM49ekTK35xD2F8Y/zybH0QTX
         vhLQ==
X-Gm-Message-State: AOUpUlHUVa7LNZH0fUf1dlHhJ/z+egqDAbn+aypOcNc6vdQsoh6eeQIX
        dtfeTcr/tRv96CUPJ+HAX10=
X-Google-Smtp-Source: AAOMgpcN4vU7I8u4qOidcGh3j13efxANoT5Ddi0X5rzCzM7DdOHJS+sOK1P8pwsNoMKHwltsKWQSow==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr2223537wra.90.1531850009706;
        Tue, 17 Jul 2018 10:53:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d15-v6sm17597706wmb.0.2018.07.17.10.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:53:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure --force" test
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-12-sunshine@sunshineco.com>
        <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet>
        <CAPig+cRFeNt9FVDGnbGcp8Bvfh0ohay+p+tLhfx=EFvJg=Q1Sg@mail.gmail.com>
        <xmqq7elusvz7.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 17 Jul 2018 10:53:28 -0700
In-Reply-To: <xmqq7elusvz7.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 16 Jul 2018 14:37:32 -0700")
Message-ID: <xmqq8t69px47.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So, this SQUASH looks like the correct way forward. Hopefully, Junio
>> can just squash it so I don't have to flood the list again with this
>> long series.
>
> The topic already has another dependent topic so rerolling or
> squashing would be a bit cumbersome.  I'll see what I could do but
> it may not be until tomorrow's pushout.

OK, there was only one topic that forked fro this one, so squash
with rebase are all in the 'pu'.

Thanks, all.
