Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA5C1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCVQs5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:48:57 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33585 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCVQs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:48:56 -0400
Received: by mail-wr0-f179.google.com with SMTP id z73so9412190wrb.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/SmzKvOQjqfIkWR2BTDuuv9dGvcGbfIIGgM5RQK3E5Y=;
        b=oH9u16b2Vp53hJX6/yX5FwUx77EaKr+TFeNaTPW51DQ/5me4ocpmumom+An66GOlxs
         oaCrStdyMrUbDdM67chVUkZNMEBes+jWzKZPef/61rqJr2ovPu7HHtPm/0gJQyGBCIYx
         NtVv/SWSrtcIvRxOuvyUMuLxV2ajY1/F3u41VSty7WBVG+gr6VnAXROpAoPZaKsjs5du
         kv4pqDShaSfHPRnEDuDSiT1OAjqZVzR4mLEOG4BKRdc1uPiJ4z7tcxt4piUaYGIfXiMC
         j+FYLWvrXQn5fLFUExmfzLCA3q/CvOvJW4/mRa3tfCODk127jAd2IXiKs+2yQ3gcwhmo
         GGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/SmzKvOQjqfIkWR2BTDuuv9dGvcGbfIIGgM5RQK3E5Y=;
        b=BXbiUJ9CPCdvKt3YJbICNjB/pIYHv4VNLbMsokNCKW+ezVERNNAf9/pmMXN232yZQZ
         rVohwzrZZ8WTlCxEVuqaoWr36XM+Z/IkRRpi7lgirTsWqbfIq+l6TbUEmJRmXBH/gJjx
         oLOEIR2srQS2o5U/F4bQm36XNM4y69v0d+9fTULGVA7ybBlXCt9kmSx89XqKF8rgs3Bl
         CMO2pXGVROAPuYiU8NZIj2MJyt0HeD7LRIe333jwgcInRA77ja668OYEduWWZdPCDZ4L
         NpNn4x12KvIqSswIAx8WUYUbLWF1d9aKX0SNIVI7VOhFRKssVxnLE4eONnBj+5UD2gQe
         TA7g==
X-Gm-Message-State: AElRT7GHoAVH7j1/ZCxlseobMXvtQ/YcwGxNG/f9+r4d6fPPb4JnoU5F
        hmVw8Hxnfxc7NsYA74LSBig=
X-Google-Smtp-Source: AG47ELtnT93c8OSFwRWTthnqDuztyQu8FTFMXJc6t0WfIZbslPOTVmywL1wHtcTHwZ0/tsE/Z8SEtQ==
X-Received: by 10.223.131.37 with SMTP id 34mr20962128wrd.169.1521737334939;
        Thu, 22 Mar 2018 09:48:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm12928735wmf.20.2018.03.22.09.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 09:48:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] rebase --recreate-merges --keep-empty: don't prune empty
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
        <nycvar.QRO.7.76.6.1803201639540.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <e306f33a-3cd9-b753-ed61-66b7ff614087@talktalk.net>
        <xmqqr2oer19v.fsf@gitster-ct.c.googlers.com>
        <1f7194bb-f48b-e229-94ae-44c58636172f@talktalk.net>
Date:   Thu, 22 Mar 2018 09:48:51 -0700
In-Reply-To: <1f7194bb-f48b-e229-94ae-44c58636172f@talktalk.net> (Phillip
        Wood's message of "Thu, 22 Mar 2018 11:03:59 +0000")
Message-ID: <xmqq8takm4y4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 20/03/18 19:32, Junio C Hamano wrote:
>
>> With or without the above plan, what we saw from you were a bit
>> messy to queue.  The --keep-empty fix series is based on 'maint',
>> while the --signoff series depends on changes that happened to
>> sequencer between 'maint' and 'master', but yet depends on the
>> former.
>
> Yes, that is awkward and unfortunate but the idea behind splitting them
> into two separate series was to have a single set of bug fixes in the
> history. The feature needed to be based on master, so if I'd had the bug
> fixes in the same series you'd of had to cherry-pick them to maint which
> would break branch/tag --contains. I'm not sure if that is a better option.

I said "a bit messy" but that was a statement of a fact, not a
complaint.  Sometimes, we cannot avoid that necessary solutions to
real-life problems must be messy.

I still think what you sent was the best organization, given the
constraints ;-).

Thanks.
