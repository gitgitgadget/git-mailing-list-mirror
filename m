Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE5720401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdFUR5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:57:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36326 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdFUR5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:57:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id e187so20576715pgc.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ts+lEkc9MrzHED4eHE5jt9BHkyBE1xyWJ8Y/UPKIJlw=;
        b=sTs4F0i81ceLS5Eoeqk/UtneS1l0k1kOhWn9QOOHfsIhgjkbXBJslvQqwT1J9Vyh5S
         H6WnMJtZg2SPqNxQ4jZ+Sce37JgYQWGDmvtml/equA9r6D/aqaOMn7LM37cIZr4na/ga
         mrDSGaa0TzC/f5uyCWszxHXvDOGOHcmVMi3TG9/3gQOVCdaFHV7RmC0c4AmDgd+Jwwfs
         tm0+Dq3G1rhargzZbdIaf5sd2Dvd/oEGYsTtKQ/WdjYqKEYwNzxN9BVM57DNo1mnZ/s8
         wM6NKom3AgJMvjXLuX5vZR+MR2eZkRJ99s220QkpuChXfsdP69uSCEfeMvtQanfkJlJr
         Izfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ts+lEkc9MrzHED4eHE5jt9BHkyBE1xyWJ8Y/UPKIJlw=;
        b=IT3629QQxaQL/dC62OCc5+KMjF5jyGafhEn6WOpE6An4E46aTispMIxwVWxbTZb/NT
         bHTxEbG0jvp5CIidpXEGdX3+WhvruV7ypyuMiOEXzwmkvvauuf7PYi6xtHu3k8udKCWr
         U8zQKbQqs2Z1amXGRBqLtxE53pGef2HlOvb5w012DdyhxXdWn9ruQKzGAkPgqKC5/HvQ
         x7JXemyocwMOYa1RaNe/OOEHhavomc6k20wJyiJPYNsIsXLM2r3SyLHKNgoj+X8pvWoD
         yHDtfFkspmX/+L5Am+iRKVH43zCvILcbFrs5YyQIRZ0goGaTebVUuJTzU9+HePamTFKb
         wO+A==
X-Gm-Message-State: AKS2vOwXes0MdeolqbnvLnOkq32uW6Ts0hYlVkk7GewJ4034pk3iPmdy
        OrYXnMeZTKnM8Q==
X-Received: by 10.84.217.156 with SMTP id p28mr20128361pli.206.1498067863763;
        Wed, 21 Jun 2017 10:57:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:14d3:6dca:1831:2943])
        by smtp.gmail.com with ESMTPSA id j27sm22461310pgn.63.2017.06.21.10.57.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:57:42 -0700 (PDT)
Date:   Wed, 21 Jun 2017 10:57:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 11/20] path: construct correct path to a worktree's
 index
Message-ID: <20170621175740.GE60603@aiede.mtv.corp.google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-12-bmwill@google.com>
 <20170621021024.GC60603@aiede.mtv.corp.google.com>
 <20170621154330.GA53348@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621154330.GA53348@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> So your suggestion is to completely avoid doing any location when asking
> for a worktree_git_path, I guess those code paths which request those
> paths should be aware enough that if they need something in commondir to
> use git_common_path instead.  My only worry is that it may be difficult
> to catch misuse of worktree_git_path during code review, at least that
> was one of the motivating factors for originally respecting
> GIT_INDEX_FILE and the like.

Correct: I'm saying that when someone calls worktree_git_path, the
intent is to resolve a path within the worktree git directory.  File
relocation just gets in the way of that.

I am not too worried about misuse because the only reason to call
worktree_git_path is to access a worktree-specific file like HEAD or
index.

Thanks,
Jonathan
