Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5D4C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4635060FEB
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFOV37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOV36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:29:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3094CC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:27:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so2674356pjs.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iu3PWOOlg5V1xadYExkv00PtjlQdaxxR1IqEKJTuhCE=;
        b=m1WuqcMqkLWNvCp/VjXEUyVFCulVZ9t3R1Agdohg8dfLtCXVWgo+x+IVdlcQ9atfbG
         wDEcBWH67sA+4YK/geL264xLVF1QDLJ2GtQvMxIvH6Nf/HxZr7zvPO2hIFSTlHr9UCOX
         +WB4QeSIpVTkliUON6vPLAwwKwb2G6B2ERt98O2KyyzzHbJJSEFA0jR0YPsbjIkZJEYn
         trWAJl2HzLE+DsUKpWDyagqEC1/HTi7cUqjIrH/YZ6/MYGF2wS2sqh4X16VO3RrA5YgB
         ScDSa1QKZ6I7N9Pjub5oMCbYY2x7q5PHrJBCuCePr72A6p9zqXXthv+sTimI9TM8R8sz
         Z4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iu3PWOOlg5V1xadYExkv00PtjlQdaxxR1IqEKJTuhCE=;
        b=o28+EqQQH9HgrkLbPV9FBVF6/ejN/OrYUtUYNgjiTsGyJdJ2HjPvw0knjaTDaUNroe
         lVirkkqdpRtav0mgMJSfjDwOKPAy360t2XaPkMj/1MnHq2rbPJH/QfVRSLhOBLHE5xug
         lQfEoxuOO8zSrk24Bv0Uho7JZ0GZE+N7pFMtzU1NuCekVagK28uLJB9QS3k+tHsJvan1
         AD2lZ0JX48R7KgxKEDTyHt4UjItEpcDEzTK9uBHr5TGY9rFMGBQreRXNlv47I+gEY8yu
         MVYXkQ1N6/efyR9s9CCb+W6nLXMvbdTjX7i/SGUO7DJBcYPRdnVkLwS6+w+aww4ZutWM
         X5kQ==
X-Gm-Message-State: AOAM532QC+qIiMd63GdtF4Nvs7OP24muLXTH69MButcIVGtTHI6nV+C7
        JvREEDgJislToKt//0t82a+FjnQbp5fSDw==
X-Google-Smtp-Source: ABdhPJyjF1dVUBbST5x3zXmzX+6jnZ4WAXRKsGxDZTUiQBjJgOIbO4jlluSC26r2x7il4qKdajX+lQ==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr6119686plk.62.1623792472551;
        Tue, 15 Jun 2021 14:27:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
        by smtp.gmail.com with ESMTPSA id s7sm97579pfh.57.2021.06.15.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:27:51 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:27:45 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] submodule: cache superproject gitdir during
 'update'
Message-ID: <YMkbUYmefgp6erxD@google.com>
References: <20210611225428.1208973-1-emilyshaffer@google.com>
 <20210611225428.1208973-5-emilyshaffer@google.com>
 <xmqqeed5x8wq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeed5x8wq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 03:22:29PM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > A cached path to the superproject's gitdir might be added during 'git
> > submodule add', but in some cases - like submodules which were created
> > before 'git submodule add' learned to cache that info - it might be
> > useful to update the cache. Let's do it during 'git submodule update',
> > when we already have a handle to the superproject while calling
> > operations on the submodules.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  git-submodule.sh            |  9 +++++++++
> >  t/t7406-submodule-update.sh | 10 ++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index eb90f18229..ddda751cfa 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -648,6 +648,15 @@ cmd_update()
> >  			fi
> >  		fi
> >  
> > +		# Cache a pointer to the superproject's gitdir. This may have
> > +		# changed, so rewrite it unconditionally. Writes it to worktree
> > +		# if applicable, otherwise to local.
> > +
> > +		sp_gitdir="$(git rev-parse --absolute-git-dir)"
> > +		relative_gitdir="$(realpath --relative-to "$sm_path" "$sp_gitdir")"
> 
> realpath may not exist on the target system.  Discussions on the
> patch [*1*] may be of interest.
> 
> It might be a good idea to push to your github repository to trigger
> CI on macOS (I am guessing that you do not test locally on macs from
> the two issues we saw in this series).

I typically do, sorry for forgetting to do so this time.

> 
> Thanks.
> 
> 
> [Reference]
> 
> *1*
> https://lore.kernel.org/git/20201206225349.3392790-3-sandals@crustytoothpaste.net/
