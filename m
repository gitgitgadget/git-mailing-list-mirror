Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6EE20D0A
	for <e@80x24.org>; Mon, 29 May 2017 18:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdE2SSq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 14:18:46 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35270 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdE2SSq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 14:18:46 -0400
Received: by mail-oi0-f42.google.com with SMTP id l18so86437819oig.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DLZPVHCKxnFphhLFeCBpSrQh13YCti1UEMTm6Z+hp6Q=;
        b=frTFdInYr43CPuf8paMAAtbkywit5UEFUyApqzqjUE+aKHMikt6Q5/+S9EYuDLs0cJ
         UytG6uNKTFzQMVRHZdm5atxjgg8a7YU80LkfOmrmjDZ742S8urj4NlvTPIpT4W/4z9E9
         V7Kvo27CF5dTsrz313j1jRExg3A1aVUylMLnJb4FTe9uok+DA0pblKmVguoePcwBAUbq
         TcYHkzktDH6LYrffPUIf7/D+XNHfjxX2lWMhADnA+ih2xnzsbGNInYCAVsiYvy8AMUlO
         954a8I1wpBiRkkTi970zbv0Cm8h++bzcjSX7Z281n6+jnUBydueLE93zxV5fWCoT4XC/
         ltPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DLZPVHCKxnFphhLFeCBpSrQh13YCti1UEMTm6Z+hp6Q=;
        b=mDIV+udP91KvK6F+W0pko125rHUBi2PnfIZnUfHxdyNcxT02TrH2PZ+dqDOYB55HLS
         ITShtsShUUHrwIKC+3s0ovaTpENK0pEneQMJHBrOJDFU7ngIrGJ24g20hD8nwUayp3Fe
         PEgeCpiHCZndunBj04q6RFWtzhBypfQ4Jq64/1skIVPgOrEP2CAerjBMbhYdzUHXgdqz
         49IPp0+FGIgb2aA8HSNn5V0I/0loFhDS6+VvC4hYRnOZsWtbVikECS3/G0T95il8YPGe
         Pn2WWxfQpBvCGvnf6ZOQ/cbZTzaVJshzOnSRKvA3rxjxs+uDpULq2ERWRmDnrncOlvxB
         duxQ==
X-Gm-Message-State: AODbwcDWbl5ctvi3Wliw/XWRF0gWAQJvTMmhVmUuhmuN6U0qsEV2Plh4
        /NNE/zINtEQAsfdoeK05UxJ+7DN3kw==
X-Received: by 10.202.97.86 with SMTP id v83mr6570166oib.113.1496081925447;
 Mon, 29 May 2017 11:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.169 with HTTP; Mon, 29 May 2017 11:18:25 -0700 (PDT)
In-Reply-To: <20170528192149.dgzibu334n5ja57e@sigill.intra.peff.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com> <20170528192149.dgzibu334n5ja57e@sigill.intra.peff.net>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Mon, 29 May 2017 11:18:25 -0700
X-Google-Sender-Auth: LA_IFuwyr_3rgmixItrQylj0688
Message-ID: <CA+CzEk8NoGhDB6nX6RRL7J-KenoJBE7rVfskJfCQn_iCSnA4nA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once I have all those leaks fixed, is there a way to make sure I'm not
missing any? I tried using valgrind with leak-check enabled, but there
are too many leaks from other git commands.

Joel
