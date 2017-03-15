Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8DF202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdCORqA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 13:46:00 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35916 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdCORp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 13:45:59 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so12293836pge.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/TVyhrZRGjc9q0jKfvORGxO7R3pBhaEyIx2quiX9PZI=;
        b=Bg+ZKMpfZ7JnMUr+d9qCalcd4E+fGP/Yas2vksFlmm2XRUcjQJG/6m3iit1VIh1vbG
         w/6CJKJK6+i6dcJ564wJcOG9ZkAMPR5CzuDiqR2F1sDRV3w7vaqs2WYkvviDsmYxvwq1
         LJSTFywp7O2hM6hcP4/knPtNbXyTDmyhyEjzTAYdWl4MQ0F+Rn6v5Gg33J4PKhpS5J8O
         CkbWCKjlZJGpBaBdfaNjTgGaWHfvyFlPrRY9XqdvB/CBUuWTKAGlc/08Z4t5UQe7AhYJ
         f5C2mLm6N4m7zw2SKaNFkBnEqOFcKwRJjaEyyLr9XC07b2J7B+cDQ2yM9XrTOnI9BQ8/
         LjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/TVyhrZRGjc9q0jKfvORGxO7R3pBhaEyIx2quiX9PZI=;
        b=TLFLk0VdZ5gFfRjsq9Dfl+mZhWhBek6arnYedfb7XOzGbda6m6Dmn+rjP9JSj1i/eR
         LqGsqT6EMdXep9rdZk01bvG+wv2LE0TmgTwXXpXSXStF/JmYlgQaAEVq4Uo1RkC72QZ5
         5zOkUF6X5VV+o0A0Z7b2IT9nrCjq1Ygv+pi//0uWS7drs50X1+/aPMaGloGziykwwf/k
         3z/ZP9RibRwzpGdZnEEqydhfE+zfJdFza3eB3OUvgWyxgo2ewhmMl6mW3N8evvqX5qb8
         sji554R4zvxGWh+6gUFUvVFLTiHBXQGNoDE3DFwS5txhzche2sm3XXeenF2AxX7Zgobm
         ZgKQ==
X-Gm-Message-State: AFeK/H14JvdVKEt7KJkk0220qVlSrT78dzPfo+HSOU0wT7CZXXkQ++OWlRz3OoUWkoOqguSr
X-Received: by 10.99.115.68 with SMTP id d4mr4919724pgn.146.1489599514340;
        Wed, 15 Mar 2017 10:38:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id s13sm5551751pfd.46.2017.03.15.10.38.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 10:38:32 -0700 (PDT)
Date:   Wed, 15 Mar 2017 10:38:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jens Lehmann <Jens.Lehmann@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/10] submodule: decouple url and submodule existence
Message-ID: <20170315173831.GB159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-6-bmwill@google.com>
 <CAGZ79kaqNUV_Wa_9-PSTf=NU7EcKASHqk6NcmGZSX5r610Zdew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaqNUV_Wa_9-PSTf=NU7EcKASHqk6NcmGZSX5r610Zdew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Stefan Beller wrote:
> + cc Jens, FYI.
> 
> Once upon a time I brought up different addressing/activating mechanism for
> submodules and I remember Jens having some uneasy thoughts about
> that back in the day. This series addresses the user confusion and documentation
> better than what I had back then.
> 
> On Mon, Mar 13, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> > Currently the submodule.<name>.url config option is used to determine
> > if a given submodule exists and is interesting to the user.  This
> > however doesn't work very well because the URL is a config option for
> > the scope of a repository, whereas the existence of a submodule is an
> > option scoped to the working tree.
> >
> > In a future with worktree support for submodules, there will be multiple
> > working trees, each of which may only need a subset of the submodules
> > checked out.  The URL (which is where the submodule repository can be
> > obtained) should not differ between different working trees.
> >
> > It may also be convenient for users to more easily specify groups of
> > submodules they are interested in as apposed to running "git submodule
> > init <path>" on each submodule they want checked out in their working
> > tree.
> >
> > To this end two config options are introduced, submodule.active and
> > submodule.<name>.active.  The submodule.active config holds a pathspec
> > that specifies which submodules should exist in the working tree.  The
> > submodule.<name>.active config is a boolean flag used to indicate if
> > that particular submodule should exist in the working tree.
> >
> > Given these multiple ways to check for a submodule's existence the more
> > fine-grained submodule.<name>.active option has the highest order of
> > precedence followed by the pathspec check against submodule.active. To
> > ensure backwards compatibility, if neither of these options are set git
> > falls back to checking the submodule.<name>.url option to determine a
> > submodule's existence.
> >
> 
> 
> 
> 
> >
> > +submodule.<name>.active::
> > +       Boolean value indicating if the submodule is of interest to git
> > +       commands.  This config option takes precedence over the
> > +       submodule.active config option.
> 
> ... which itself takes precedence over the (deprecated) .URL
> We conveniently do not talk about the URL here anymore.
> But! We need to change submodule.<name>.URL now?

yeah this patch introduces a change to the documentation for URL to
indicate the change.

-- 
Brandon Williams
