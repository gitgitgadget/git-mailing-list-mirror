Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F981F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfIZVhb (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:37:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43185 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfIZVha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:37:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so170768plj.10
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tms3NUj/+Eqn8TiIl5gjDIMKTbDrjDKIZssPCLylH+U=;
        b=CCvDswy3GTUxWXSbJRNHMIMUS/c6aTcnDFJnjX6DiyK1/c8G9remxiX7qS6h3zzxy8
         0JrRUqATc3N+UqqX8qNoV5OveT6CFfAEnNinfn6IjPddbwwyKXNhkSEpuZ6MzSNMl/ZN
         kzLBrm7T7tB98NvCzI1mSw9liui7Egg0eTnTXKYdwaKc9lQNOc1V7RzgETYBhrl+BrdK
         QRM5EwLuEm0q7KFhPF4jVXpl+f+98WExJN5dw6W/T77J7+D8R0x8kDoA/ZlJT7H/Sbz5
         3FcAuzh5cHdUQN76vL2aVvq2N/6YvshOYpAAFjqx/ik96KYQ4TLvNt1koDW6FyRj+Ggc
         4vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tms3NUj/+Eqn8TiIl5gjDIMKTbDrjDKIZssPCLylH+U=;
        b=tvM5ILpsFXpY69fz3ur3GNDc/SbuumgxwqaqeRcPU7HTs5dIclPpr1DIsjQjrmQ/O+
         HKMXCqkWT6Ht3Ln9wBUnJSE84e9Ooqdy5U1aC6nmgguCuV4NnDGUK1jksgH30xcLZRWS
         Fqbxgoiibfq9hgvsTHfWQzOyhLE2gi89G7xyutiGwXq6WFVqTtXycwTcTOXi7A2vOFCh
         ++CcIjwS70VWOIxTdLkSLe18rr/4Eotq4tu2MKVQl8zedTA/KD84ueIClNRbqRS2FM44
         0mgWsBrbizx7Yixi92Wc27YZSFhCiPf9NGdNulVmVbm7+XxXHPJEs+p9/RnW3hpvffF0
         OKjg==
X-Gm-Message-State: APjAAAUPxMgZKNmOKcsVRcG+yCf6Yk9yxmbKjkxmTTwhSpRlcbMOEKWm
        NDacJjtJ60W8Xit8UGbQ1pZoAw==
X-Google-Smtp-Source: APXvYqziF3hIoBbxMcVr5Yd2pBlIGrowFHr1g5Tb6BgYZ0rpkc3GGAVSiC7Ucacg+ihny9Bgfpjxlg==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr740612pls.117.1569533849885;
        Thu, 26 Sep 2019 14:37:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 71sm225033pfw.147.2019.09.26.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 14:37:29 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:37:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>, Git List <git@vger.kernel.org>,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] CODE_OF_CONDUCT: mention individual project-leader emails
Message-ID: <20190926213724.GB223193@google.com>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
 <CAJoAoZkw08A_nkJNMwgTTFvGMCRUqR2UqEckOp65Vg_TW7K8bg@mail.gmail.com>
 <20190926072046.GB20653@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926072046.GB20653@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 03:20:46AM -0400, Jeff King wrote:
> So here's a patch that I think improves the situation.

Looks great to me and addresses my only concern with the original patch.
Hearty ACK.

 - Emily
