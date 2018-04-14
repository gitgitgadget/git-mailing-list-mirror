Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313C31F404
	for <e@80x24.org>; Sat, 14 Apr 2018 13:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbeDNN1u (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 09:27:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41670 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeDNN1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 09:27:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id s12so14544726wrc.8
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9oFf+a+OeoybrwyCzZJOdMjG25WEL7FYHbjrRwTWNsM=;
        b=dJeysp+/H9elwSCmDyv9x7bs3kxCFHPCVKGOxqSHGpH0+IK3k4Km1hEzotBV53J2w2
         RkYcmvQ80JRQsG4SyR1XONEnNUZ6KxPw+4qx4MU3LiIhVTEaha+lGy/YnBGrwAy5AnWJ
         wZmchmGzUpS6Jy1/pzZ9tHEwowzE99ZTy+dfVYIj8GRgNvvrwzl8576Uy7WOY4+dbZmP
         a1PvDJwebYiad6e3pFd3CpfvStmJmCaR1OikyK/jSO6Dda5oNymuRI8K8q6HLZl1EyZw
         CQJw6ikXKSrVDPPk8VyOgbLCJqVoyG529GkNWVO5sF0GA9r/45ZjrASxOCDIl1u/TlWB
         aq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=9oFf+a+OeoybrwyCzZJOdMjG25WEL7FYHbjrRwTWNsM=;
        b=G9cdBxHYNHrxSCHaDjGi53VcQsnZULgqS9H1SwtOf+PDJl+pXwqUN+NVT9sdjd76n0
         2DDStzYfx+RSlXRDQHxH6L3XYRDpVLtXuPDQ1mcmilrltLUVM+DT4/rPbmnccpTPtVy3
         iSrBkbkydVHYH5wiCEkH0/4XBSo8kQTWhdtt9KV2AeYAgaGeL5G+6W/OwUQAoAH296z4
         p9CHlwJezaGaoibczlBhgr8Cx71Q9Qen+w/VXpejQ2aOPd+rivgKeWUShfMKFuUzVtqI
         dqP+WJriX3503mpHe5nXxlvkqCI1jedVCK//eKPibUL2MjzzlxZs/sWNoNzLmBuQRXEe
         5Hmw==
X-Gm-Message-State: ALQs6tCBUl/IRlut2kshW3bwc85ycaU8Ff28uK3JfdxCtRcpGx0bzQU4
        lX9ZertR06yZfG90RWKRL5QndBr2
X-Google-Smtp-Source: AIpwx49ZMjoDeHM+dB+7XAdCvH7pWyfGOrOolghOO/w3+B5Osg9BNi71/J10/JV4L6WJpKIX+u1bjQ==
X-Received: by 10.223.146.193 with SMTP id 59mr3660475wrn.39.1523712467476;
        Sat, 14 Apr 2018 06:27:47 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm16.neoplus.adsl.tpnet.pl. [83.21.76.16])
        by smtp.gmail.com with ESMTPSA id b5sm7617122wrf.40.2018.04.14.06.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 06:27:46 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
        <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
        <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
Date:   Sat, 14 Apr 2018 15:27:42 +0200
In-Reply-To: <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
        ("SZEDER \=\?utf-8\?Q\?G\=C3\=A1bor\=22's\?\= message of "Sat, 14 Apr 2018 00:23:32
 +0200")
Message-ID: <86sh7xlxyp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>>
>>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>>> builtin command, which lists the same variables, but without a
>>> pipeline and 'sed' it can do so with lower overhead.
>>
>> What about ZSH?
>
> Nothing, ZSH is unaffected by this patch.

All right, so for ZSH we would need LC_ALL=3DC trick, or come with some
equivalent of 'compgen -v __gitcomp_builtin_' for this shell.

Good patch, though it does not solve whole of the problem.

Best,
--=20
Jakub Nar=C4=99bski
