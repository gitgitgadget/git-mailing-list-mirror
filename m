Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5AC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BC12074D
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 01:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJjohj3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFPBiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgFPBiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 21:38:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDCC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 18:38:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id w1so17771348qkw.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SXrCf2mH+cmUTuA3pPnyR4vOuDxdRGFqI57nMojrwNw=;
        b=TJjohj3ql64h7JcjhusE6Gr5cBWpmq5AatOTbIpkSeFeGUsp+0Hw6JyVZgXtSjIeHw
         G+DIvFWNPJ5sLRckVTPNJ4lme8Yf9dxnX7dBbs7HwoKFREGngdUVfCVYpJJ5ksakChe6
         drq7ErTu/yU/4TxaKSYkCRWQZwFv5fOF5mJxixTNT7rwHEPvmNi/ngxL0dZMRX6RZB+i
         spG6b+JlAsd2Pua7/E8DKCxKOC6t2l27LTyU5lTZlnywjr6FtjkAjuUmLurFb2hG2eq2
         0UoC5TnM2BhQGw3HLElAg3WxsIzQT9gfDrUyMCarFi+K1JJiSX5QlyMrHBWDQ+x0PzWS
         IgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SXrCf2mH+cmUTuA3pPnyR4vOuDxdRGFqI57nMojrwNw=;
        b=pV2zEfBf6MBdPTFQULAEPt6NQPNISLn9ouivIZ0G2sWR7cKWDHdmaCCNsIDaSR+Zk1
         aOq1sg7JGAOJcw/ASsRKEPzrL6e1Y+/LyEFoyGjBdwLlgOqjx973sDCV0veKIbVb3TfL
         5RO1iri2l4sfBROOuC7K9iWC9+mAXbc6pWvCwOjDBtCtr4pOiJC2PrPBwmh52G0ZSIMI
         Ebh5l4D6Edl1aGQh/2NSwra1pqmqy8znxso8beq1jszTmO1hv8imvQ/E5dtfpoaUxu7L
         zsdFdiP/clRPo9rg7d7u90mMLiF4xjNzhKkGP4ohF8PFgWP1167aD5hRyAjJsqM+eanD
         6LjQ==
X-Gm-Message-State: AOAM530xtt/0lqnHSGALy//Isoz41W/BOqWiYC+/GetVVkSkWtG6aF1O
        Q/Id8aLMjf1eM2OCs5nX0wKEUSj96N4=
X-Google-Smtp-Source: ABdhPJwNpsxvucYyrg12U6dUVYWRbPp4/JV8AWgE2EvLmNQNlDHk4XUG2SuYraF5o+0r6PcYndSjRA==
X-Received: by 2002:a05:620a:13c6:: with SMTP id g6mr17651966qkl.453.1592271482549;
        Mon, 15 Jun 2020 18:38:02 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id v189sm12711655qkb.64.2020.06.15.18.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 18:38:02 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <e198b1a5-e104-d0e5-8904-37ce3937316d@gmail.com>
Date:   Mon, 15 Jun 2020 22:38:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I'd like to bring the opinion of someone that's black in this issue:

https://twitter.com/Speedkicks/status/1272283853617459200

 >Reading a thread of white people, including the CEO of GitHub, 
advocating changing the name of the "Master" branch to make black devs 
more comfortable... is the most racially uncomfortable I've ever felt 
about GitHub.


https://twitter.com/Speedkicks/status/1272291128000167937
 >Reasoning: Living as a black person is not to constantly remember how 
different you are but how different other people believe you are and how 
that changes your experience.

 >Now I can't even say "push to master" w/o the paranoia everyone around 
me's thinking about me being black.
So congratulations, white saviors, you just made things awkward for 
actual black people in the community. You keep treating minorities as if 
they are children. You don't actually respect them. You don't actually 
listen to them. This is what you do, you just create a greater divide. 
You just single them out.

