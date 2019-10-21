Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91491F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfJUU5J (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:57:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44891 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUU5I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:57:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so15515373wrl.11
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7kEFRYpTe/jcTdR4R6UfrSHTlVTb0zjnLbv/simF0e8=;
        b=vYPf9VucpuVlNcN7ZCEizMCx04R5LsGnfZr2Wy2XxSM6ipbCfwtQc75JSkvKFUrXbe
         5kyX5l3HYQGIoC7BG+Z7LKi0sHQbTlPQdf3rLHZZme4NRaeGecshz1b4m9jkVCi+su2z
         PfA3Oio/PPtokFXnHvDdMZMMqW+olyZ77b6PXSrd5VL3yRoM4niwQYcR0xIbv1JL1FL+
         K7ApgHdHWlIZSdaO4pejJUh2ea9bgiy0B5gHuMgjc+NSR7khL3NzNHG1vTeIquj6frn2
         lCxSbkWiZTqfQyRAyiTS+DpnlyEBfhfC166XdPz2zBQrtD8H3+ZomTMpJvLdjAq7XoU0
         1WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7kEFRYpTe/jcTdR4R6UfrSHTlVTb0zjnLbv/simF0e8=;
        b=uBhp6GSqVPtFqgfMVZCEGRH/rEX1FwchFGxKFjCAGKUWUM0sMMR4FxU1kT3afsWp86
         R4s7bwCyZa1+S8g8zszV7ojdhLpYNC3g0863orA8OEIWhfBkixhxNfwcBfQYzBkIcADF
         eP9ObFi9miGDCt1hcT5kwpQxUiqi/D8IPk6eEllkRO2ifwD8bQky3jF5rfihMmB+CoYJ
         l3tShz6WAFkJsHxog6iG2SjYSOeHcowx9VTflas65dSLcK5b83mRhi1gG6lCVm1AgjM0
         vUy+7GYiz5Nk2opYQDxr000i7GPEcJbPURBf3LO9dRIej5OmPSv8aicHC3tT74DLYv2p
         L3Cw==
X-Gm-Message-State: APjAAAVJ/uOYrPnRpyI0ydGtemS1tfiivbUEB/gdy41PPBUVFO7bE+gb
        JqjqQR1fL2ZkkfJnC3NqQeI=
X-Google-Smtp-Source: APXvYqziOkihPp0pxAcoPAEJNHEjzUDNhWkuO73z3ZfTl7oraq8ZMTmWqLSQSMYc++yeglAQjEBpKw==
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr201035wrc.202.1571691426754;
        Mon, 21 Oct 2019 13:57:06 -0700 (PDT)
Received: from szeder.dev (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id 65sm9104358wrs.9.2019.10.21.13.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:57:05 -0700 (PDT)
Date:   Mon, 21 Oct 2019 22:57:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value
 in trie_find()
Message-ID: <20191021205703.GB4348@szeder.dev>
References: <20191021160043.701-1-szeder.dev@gmail.com>
 <20191021160043.701-6-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021160043.701-6-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 06:00:43PM +0200, SZEDER Gábor wrote:
> 'logs/refs' is not a working tree-specific path, but since commit
> b9317d55a3 (Make sure refs/rewritten/ is per-worktree, 2019-03-07)
> 'git rev-parse --git-path' has been returning a bogus path if a
> trailing '/' is present:
> 
>   $ git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
>   /home/szeder/src/git/.git/logs/refs
>   /home/szeder/src/git/.git/worktrees/WT/logs/refs/
> 
> We use a trie data structure to efficiently decide whether a path
> belongs to the common dir or is working tree-specific.  As it happens
> b9317d55a3 triggered a bug that is as old as the trie implementation
> itself, added in 4e09cf2acf (path: optimize common dir checking,
> 2015-08-31).
> 
>   - According to the comment describing trie_find(), it should only
>     call the given match function 'fn' for a "/-or-\0-terminated
>     prefix of the key for which the trie contains a value".  This is
>     not true: there are three places where trie_find() calls the match
>     function, but one of them is missing the check for value's
>     existence.
> 
>   - b9317d55a3 added two new keys to the trie: 'logs/refs/rewritten'
>     and 'logs/refs/worktree', next to the already existing
>     'logs/refs/bisect'.  This resulted in a trie node with the path
>     'logs/refs', which didn't exist before, and which doesn't have a

Oops, I missed the trailing slash, that must be 'logs/refs/'!

>     value attached.  A query for 'logs/refs/' finds this node and then
>     hits that one callsite of the match function which doesn't check
>     for the value's existence, and thus invokes the match function
>     with NULL as value.
