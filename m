Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACED5207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972696AbdDXQau (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 12:30:50 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36504 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972296AbdDXQaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 12:30:05 -0400
Received: by mail-io0-f176.google.com with SMTP id p80so79550304iop.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjEtOOsbg7ZplOo8rvQoiMmlg5PHnT7MVThjIqCxIug=;
        b=DWPqMLlO1Z0AfwBQXY1YJrJfFzo+B91XPLouFFMeKq1PqRl3gdPjY0Eagc57VTPEkj
         dqrMhOu75+/lSFK0FPuP6O/UjkYJ78gJwfeblFfwYOW4vFzLOQ3np7YDm1iMtwZrXfDw
         VQZmq8Y8drfgp2W8yN/3i/HCiWKEe8aAiTa3zZi4s97NPJeOWg/1NfAdXcOmx62JgwV5
         MEpXCxjnxiNUQL9SnBfFqvvIUtJnBVIFQJYRk48ZxjuXYNzJVue5Y7neIlVp6aCE1hd5
         foZmA7QdVBqUrgoxsYlsA2LK4n+H6u/jLg2qt7rW6L7t1YKsoWR+3RUvvGvqOxhEFbFm
         6LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjEtOOsbg7ZplOo8rvQoiMmlg5PHnT7MVThjIqCxIug=;
        b=rvN6t3SpC28M5G+jY4Ln0wdgrnyiZiHu20eeKJUkRAvfYjrA/QB2HqcRDHHstg0ewU
         gl7ufiPEzpFviYJzIUWH/TcUxFDgpKBWkTH7O9OffjvYHeUXM8rypfgQfldZV9M4MTUN
         PFQXCpQwcAIoDWxyDh8dSSDNvFGZUnouiTBUHTnE3rZyvX44lQwrDDs/W0A3qj5QxceR
         YRezevLchE6fGqiboTDrH2RsrDLdD88xcRyynL/xge5nC6SRBv21kd9uY+8Ruy6uGJro
         Ea5ux79+RUYaOvdq6+OLLzAmK1FaZYoW1kNMkP4qgMFf8JEh6EzPiUrCyMMhGaN+4Saq
         mKSQ==
X-Gm-Message-State: AN3rC/55cWgj929gEymN1KDNmG0EdQTYqObOmk1ZR+cd9I5LPHPK7UzB
        0IKwubeKD1SiE7Dp
X-Received: by 10.107.55.68 with SMTP id e65mr8027212ioa.55.1493051404884;
        Mon, 24 Apr 2017 09:30:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:fd4c:a29e:d4e5:1c03])
        by smtp.gmail.com with ESMTPSA id e90sm289622itd.30.2017.04.24.09.30.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 09:30:03 -0700 (PDT)
Date:   Mon, 24 Apr 2017 09:30:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: optionally disable checkout DWIM
Message-ID: <20170424163002.GB195761@google.com>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
 <20170421202705.4uhbk3okccszxvgl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421202705.4uhbk3okccszxvgl@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/21, Jeff King wrote:
> 
> When we complete branch names for "git checkout", we also
> complete remote branch names that could trigger the DWIM
> behavior. Depending on your workflow and project, this can
> be either convenient or annoying.
> 
> For instance, my clone of gitster.git contains 74 local
> "jk/*" branches, but origin contains another 147. When I
> want to checkout a local branch but can't quite remember the
> name, tab completion shows me 251 entries. And worse, for a
> topic that has been picked up for pu, the upstream branch
> name is likely to be similar to mine, leading to a high
> probability that I pick the wrong one and accidentally
> create a new branch.
> 
> This patch adds a way for the user to tell the completion
> code not to include DWIM suggestions for checkout. This can
> already be done by typing:
> 
>   git checkout --no-guess jk/<TAB>
> 
> but that's rather cumbersome. The downside, of course, is
> that you no longer get completion support when you _do_ want
> to invoke the DWIM behavior. But depending on your workflow,
> that may not be a big loss (for instance, in git.git I am
> much more likely to want to detach, so I'd type "git
> checkout origin/jk/<TAB>" anyway).
> 
> Signed-off-by: Jeff King <peff@peff.net>

May not be relevant to this patch per-say, but is there a way to have
the completion for checkout only complete up to a part of
remotes/branches?  Say a forward-slash '/'.  For example git.git has
lots of branches which have the form: origin/<initials>/branch-name.  It
would be convenient if when I type:

git checkout <TAB> 

Instead of getting a long list of 2k or so branch names that instead I
would get see the remote's name e.g. 'origin/' kind of like vanilla
directory completion.  This way, unless I'm actually interested in the
remote, I don't see the thousands of branches related to it.

-- 
Brandon Williams
