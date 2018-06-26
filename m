Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96B81F516
	for <e@80x24.org>; Tue, 26 Jun 2018 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeFZQkd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:40:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39307 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeFZQkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:40:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so2526453wmc.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FW3ZGLCZuVPQebp/n62PzsERwGEvih+vHwcbdVHgxwE=;
        b=JQHLMVPbKJxGqSUsiVkGMUD3RK0SUfc5rhcN+wgcZ7P0hvRflqFVsCAr8+kOGxuUUl
         CUkxfc9BOnLPIIdmwxXZAV6h9pGMZmdtRNYoiiEDaZm0CRMMdymCgR8DgUWTVhUUDzZv
         8Mr21vo1Cl0uFjAL2qwn1o2e5Tj+Y5UuEPPGO4l6eHcZhPdyp44n4A7lfhLTON8wl1KR
         SnQSuOyNvnqR75Vp4uYXhBS0kYCvu57gtHMARzFq+xrTbOoPFhpyg98iY6eJa97RiEPa
         vP7E+NRDtTErkO7NlXSuZ/Sw4USsqZ/4+XGfD+RM0W8TFKnu013MzHcPqAaCMmK8DyGF
         YH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FW3ZGLCZuVPQebp/n62PzsERwGEvih+vHwcbdVHgxwE=;
        b=k5iBobzoKsshC2yhOYpygnY972YwxaGODwkwXr/srbpNcrXCsmJRUKgB3Rmaizhbp9
         iwOPyarA6fJe9nH1kDn653sDEutPjNZRsaIgu7F9s0eQA9QcAnBbuLunzi5vrjS15HAq
         eqUxllbXefBLb5Z4nmsFsgzoDEGJyjy8mG7h44zCVm/jBi+JAvQ7hyOTWbFdBlfEr7bQ
         4KYp4IFfJcImB2XizSI7OkOqWvSIzjZbnU53blWHZhCf9qvurbgzHtZFKEzdcYzDLhvG
         tFgFSHEX+e4XD4OH3aX+0a9HQxWPoElasyRnodguf1U/I+RXrfucB8mfwla35tHT51yD
         CFpQ==
X-Gm-Message-State: APt69E2kX1B3+XNWjHp8gFBLuWrtXIN6qVryCT5n4coUrkqYQivfClFT
        sTx3TucxN6JiQuKg0q6bqzA=
X-Google-Smtp-Source: AAOMgpch/BigrDP0L75U5A3d0MxX1XHp+YSgvnrCnOETZmf9VJicqDaVmtfWBkcvsepWf/3h0NXi/Q==
X-Received: by 2002:a1c:d287:: with SMTP id j129-v6mr2119639wmg.106.1530031231371;
        Tue, 26 Jun 2018 09:40:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v15-v6sm1626939wmc.16.2018.06.26.09.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 09:40:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org
Subject: Re: [PATCH 4/5] commit-graph: store graph in struct object_store
References: <xmqqwoummvmw.fsf@gitster-ct.c.googlers.com>
        <20180625220915.198932-1-jonathantanmy@google.com>
Date:   Tue, 26 Jun 2018 09:40:29 -0700
In-Reply-To: <20180625220915.198932-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 25 Jun 2018 15:09:15 -0700")
Message-ID: <xmqqefgtmrgi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> As for whether both these functions are necessary in the first place, I
> think they are.

I do not mind their existence.  

I was wondering if they can share more implementation; such a design
would need s/the_commit_graph/the_repo->objstore->commit_graph/ only
once as a side effect.

