Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C951F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbeDTMSD (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:18:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41216 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbeDTMSC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:18:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id v24-v6so22423972wra.8
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CKFmUJzvotRgKUzGBXAXGQ6lVmX4+hFmXkueP3dzpxw=;
        b=H0aMICZAacQsQy6Yzw8wNY2QNJV29xPIelCJAgD8vkh95EBTTxquHNJLtakOhyxWsN
         fUR8RruYm2b4uA0l7wp1XIIDGy0imvyBiegXxo/OD3fW5jjFdIXFaP5EiROuBuTpMtyn
         OWtemAdBN1wL5taSuSDdg0CAq9KkkMGt8+oRTMAMaocQVvkGgS5GuZ+mtVovCIvpcMnn
         tSEJD/aLJMP0UiUuakoQZpTicopk2Tq/oRdnnN1+gfToX7wluqbkP7iPTvUBh6HwlKQC
         0CaoWzeqGAmGfbaNgFKSaJi+pJ88cHb8UW2qKhjFz0glvM4jcpLMa/YbhawfeVx4VDdK
         Q+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CKFmUJzvotRgKUzGBXAXGQ6lVmX4+hFmXkueP3dzpxw=;
        b=R539cb99Ks+o+28Ev6s4PB2y03aSF9x2PqanjLtbICMJf8SQ4d23JScoUm065JKEA7
         vFrxxPv2KiUvrFh8e3+sMYpH5dIHpiEqRVC9NRBTYHTCP6nO6rYEr0a81S1B3efaN3nk
         EP4uglqjYe2n8hNXnupqEcb3zg/Bk0MfEZG1A4buL8vXV02VbZsR23mn3DhIcT/nDfNc
         +0Bxyfq42gFbST8GMdGoY+IT6qBFciN8JWybQt9Mr5qjmxVCiUa6W6NigVWxsfqE1DXf
         yTr99WsN98rQ4vnZKmuHGcv9vC+yXSRuHtryuHB7MliDyMhazWGGuk1VRG0ogR46fdj+
         jkEQ==
X-Gm-Message-State: ALQs6tBzDF3eEd3sHuGi4hpi3ga5IAFm7LgOLZ/DIOzLKmS/CS5CWBXp
        Iaw75jq/GcABGBColbxHq6qcNdOY
X-Google-Smtp-Source: AIpwx489oUlXuhOaLARIy1l+uCfwNAcEQK/NF6mAwIL65aBMvMfdNWo/5mFmwEcG3lCaUUfAgtYBcA==
X-Received: by 2002:adf:dfcc:: with SMTP id q12-v6mr2590390wrn.68.1524226681546;
        Fri, 20 Apr 2018 05:18:01 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id e185sm1860934wmg.5.2018.04.20.05.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 05:18:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 07/12] commit-graph: load a root tree from specific graph
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-8-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 14:18:00 +0200
In-Reply-To: <20180417181028.198397-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:42 +0000")
Message-ID: <86o9iedqbr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> When lazy-loading a tree for a commit, it will be important to select
> the tree from a specific struct commit_graph. Create a new method that
> specifies the commit-graph file and use that in
> get_commit_tree_in_graph().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Looks good to me.

> ---
>  commit-graph.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
[...]
