Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7078D1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 00:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeJSITq (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 04:19:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSITq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 04:19:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so35462763wru.13
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8LTXTabS2fP3R9dQlDLWAMuKP1Gxjv5/TsYIAH8ruD8=;
        b=BeXd9ojyBN1HLLbZMhYp74fmBaFlVfP6TsY55ijTnIMBCkdlw2j8acn7Y5xsXxIPvb
         9zDS8UvIyO+j4/CmUCESMMPzHBYy7uGjGS1vjl0X57hcm0POSlsef3hDka0UvMPTV2Rb
         Q4bHvX0uZHWAYZSj0BE/Njp2Y+10tkWT54GFAcjtBM5gDw1dyUHlQlNGlJ59NZexIwrp
         WrLCjhVDS3Nj69d6pEeRZMGWrAi+psecnNmy9PWOzMcNzIL/cmYIpCm2rYIcl44A5dqL
         vStGDpr4yM/k5w0jkTD7F9sQ9IjL9fIWhhTXDW7OpvWZBfN8jbxQ27HBaH9k/xx4qisx
         4nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8LTXTabS2fP3R9dQlDLWAMuKP1Gxjv5/TsYIAH8ruD8=;
        b=GEtGZKf4xHCu4HoW111a+CbbTXPMDNvTlR7cIIT5hHWm7YKaSNFQ3sIP3uLCLd81QY
         NxrZaQ+2/zozs/07OPbZBXZ6n2fDAzi2FK2yjniPCxUcMTG3CUVtzs1BaLmGrCzzKxtX
         KbAlNQa2pVOv/10SQUnUQBCWk1cB6Yl9HPicTP9jEoLy5USvcmmQlJfydd84ReRU32Pe
         9L6dV/K9MHv+I1Mvk1cqPjRLCbIO19FgLnStkJDbATisepuiaSW3e/kfa5cWnRzqhpDj
         9iOGkpiEQTgIGtcG23cxGqH+pdpCxteUDBYux0wPPScZv8Yy7bG6xzC1cuqOLyhdnyo+
         1mPg==
X-Gm-Message-State: ABuFfoiwxuWGSteHvRI7tySLNmobT7zDOi+qIaZ69U3PwKG8u/7Th7a4
        C860USarg5q/7DX2Cz7wzQk=
X-Google-Smtp-Source: ACcGV60oLVEEiXsVk6NhQQ3nU4M5ihZFJBNUwGkhV2Km7TTbGtciVpwmp4ZywMtehwbzxhoIQGj0hQ==
X-Received: by 2002:adf:ce10:: with SMTP id p16-v6mr29462221wrn.118.1539908173774;
        Thu, 18 Oct 2018 17:16:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1802149wmi.23.2018.10.18.17.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:16:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rajesh Madamanchi <rmadamanchi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: receive.denyCurrentBranch=updateInstead updates working tree even when receive.denyNonFastForwards rejects push
References: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>
Date:   Fri, 19 Oct 2018 09:16:12 +0900
In-Reply-To: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>
        (Rajesh Madamanchi's message of "Tue, 16 Oct 2018 13:54:48 -0500")
Message-ID: <xmqqsh124wqb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rajesh Madamanchi <rmadamanchi@gmail.com> writes:

> Hi, I am looking to report the below behavior when seems incorrect to
> me when receive.denyCurrentBranch is set to updateInstead and
> receive.denyNonFastForwards is set to true.

It seems that we took a lazy but incorrect route while adding the
DENY_UPDATE_INSTEAD hack to builtin/receive-pack.c::update() and new
code went to a wrong place in a series of checks.  Everythng else in
the same switch() statement either refuses or just decides to let
later step to update without taking actual action, so that later
checks such as "the new tip commit must have been transferred", "the
new tip must be a fast-forward of the old tip", etc., but the one
for DENY_UPDATE_INSTEAD immediately calls update_worktree() there.
It should be changed to decide to later call the function when
everybody else in the series of checks agrees that it is OK to let
this push accepted, and then the actual call is made somewhere near
where we call run_update_hook(), probably after the hook says it is
OK to update.

