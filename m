Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81372013A
	for <e@80x24.org>; Mon, 13 Feb 2017 02:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdBMCjh (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 21:39:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36743 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdBMCjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 21:39:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so8419641pgf.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 18:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNNYMVvtNhu8VIYCv9yisAXoPxuwEwYaRDlJ8cnFdSc=;
        b=gELezxEYe1aM6iGReX5DL2vfvaqkBlUXdYG60nd8TxPN7RbQ2llK7Lc30/faR9EbwE
         YZC+1aaH0DialyviniR/TNUQI9V5Yrs12GrIZ56RpV2yWKpkv0IyKLhJv3kQT+Tei4Bw
         qe/2N8f+RaJHRoa1p5NB0vZNSYdJRizrglhR/0a6EkKLf6v8IjCfT+hQDn7D/RXPfA1Y
         Z0HvqEjebDuhsm5zzl+mEDa2FqC+9qGkwITC46x0mzq0k+6FJhWIB7uWL5PiX1HpGGQU
         pJ2iGk6AWkUdk4AzsPMfrU0xm9Qo0tArXztqdHat1zNGor9qPJjHrraEK6Ti9fJsjukB
         xcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNNYMVvtNhu8VIYCv9yisAXoPxuwEwYaRDlJ8cnFdSc=;
        b=hdUof9NFYHMQBGWVQJm5xX1nI1Lu0Qq86HgYdSHuuAI3dfKqGLIfhS2jpfzIndCh5F
         kfPqlZnQdiavb2CfXtBXq5I61awHOQjPeArsHEmxBuU1GAWuOINbdfrxzkEMbd5zzBSd
         K2K1oBioiOcPM1LB2s8CeFTe9zswOy1/0O2ay//G+3BJvmPbG/FanM0K/fLfS+alsua4
         DGxUtWMkT0M8XXYxmqrHIG4HFHI4IbiFt6isEjKX56R4e0IAuXcMeN292+5SpTfvyAA2
         RDj//mNJcK0wiCN0t3xQwAxO4UwExVK0pY30CrfWD92EqqCuo/ndPp6vuuTloaryNC0e
         CayQ==
X-Gm-Message-State: AMke39nmyxqvmd4ozxhCpL78pX8eg3p3VLX+FEqu+wC4O6jZomNXh59y/NmAnGLuzE1NXw==
X-Received: by 10.99.99.193 with SMTP id x184mr24495027pgb.226.1486953575720;
        Sun, 12 Feb 2017 18:39:35 -0800 (PST)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id i73sm10866984pgc.62.2017.02.12.18.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Feb 2017 18:39:34 -0800 (PST)
Date:   Mon, 13 Feb 2017 09:39:30 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] Store submodules in a hash, not a linked list
Message-ID: <20170213023929.GA24018@duynguyen.vn.dektech.internal>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <20170209195812.dbbmko4sas3wtdy5@sigill.intra.peff.net>
 <9ba16176-b388-4c70-a479-fda4c9244e67@alum.mit.edu>
 <20170210004033.cgqmovhvoylad5cf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170210004033.cgqmovhvoylad5cf@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 07:40:33PM -0500, Jeff King wrote:
> On Thu, Feb 09, 2017 at 10:23:35PM +0100, Michael Haggerty wrote:
> 
> > >> So push the submodule attribute down to the `files_ref_store` class
> > >> (but continue to let the `ref_store`s be looked up by submodule).
> > > 
> > > I'm not sure I understand all of the ramifications here. It _sounds_ like
> > > pushing this down into the files-backend code would make it harder to
> > > have mixed ref-backends for different submodules. Or is this just
> > > pushing down an implementation detail of the files backend, and future
> > > code is free to have as many different ref_stores as it likes?
> > 
> > I don't understand how this would make it harder, aside from the fact
> > that a new backend class might also need a path member and have to
> > maintain its own copy rather than using one that the base class provides.
> 
> Probably the answer is "I'm really confused".
> 
> But here's how my line of reasoning went:
> 
>   Right now we have a main ref-store that points to the submodule
>   ref-stores. I don't know the current state of it, but in theory those
>   could all use different backends.
> 
>   This seems like it's pushing that submodule linkage down into the
>   backend.
> 
> But I think from your response that the answer is no, the thing that is
> being pushed down is not the right way for the main ref store and the
> submodules to be linked.

I think it's more about "pushing out" than "pushing down". Once files
backend takes a path to .git directory, we could have a submodule
ref_store that resolves submodule path to that .git directory,
files-backend will not need to know anything about submodules.

I imagine in future lookup_ref_store() will take a .git path instead
of a submodule path, then iterate through all backends and call the
backend-specific "probe" function to let the backend figure out if
it's the right backend and whatever parameters it needs (e.g. IP
address or path). There would be submodule_lookup_ref_store() wrapper
that converts submodule path to .git path for lookup_ref_store() to
consume.
--
Duy
