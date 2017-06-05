Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438A71F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdFERqg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 13:46:36 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33604 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFERqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 13:46:35 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so23381498pgc.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZVT8YenQzOPfvdb4pmPn48byQXrJYfFQK6nLBSw862Y=;
        b=ptaVrJgnmBT0Uw+dXSnGUdOQ6tEp/xdmdqFLfAUjWfYcM1rt3jQJDnSYDqAVivy7NG
         3FatMZDl+OjgY1zPILQUUBeravAZ5VOgABZprmDxUnu87KQ7t6nWWImrzbp+J38c07rA
         RysDuqCqO63ehRyEN9+odQshGenULgtUVQ8pJu/pRVuZaK/YOO5CPUxug5rfIGMlWEaW
         LeqBL7/NVQhO/1s/nCwgnYx3LVlN/Ug0w4pTnERFisPkcBbqWmMlL3W5AKeeXEMQLM6E
         ayY/d6lOrRe877GnA6DCFwzbSubetxXS/P0vlzcQo1NcCZJzrh27AHrkdID/CZnGYB+u
         DU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZVT8YenQzOPfvdb4pmPn48byQXrJYfFQK6nLBSw862Y=;
        b=ClXJ0lSMOKe2wrdF+zd82j7uzPjTP9pq9606qjvbIG0KjRoThP0oavL+LCbc7H6Eah
         DHtX4I0CSV8IkfLRYNCxDMuLw7Gkeecbtb1GalJq5q6xeQHiucqcJJsjIFQA9tXZ92BI
         0Ri20krVXeJAg6gfyuJDPkNuenzpRKpncJZT7rgJHVMNrox62n0yVbfTJZaPTXciiO3B
         yVYA5qaz207VobQc8j1dzRy+wIaJ74YMGGHBJywPCXC1X7febt4n0uBTkhmAABN/91AY
         zF49RbhdijDhpo/R8KYqlLHn1p3YMrnOzB8ui4+rwylqIrETLW8CDGoIeyYJ2Fft52hQ
         agTQ==
X-Gm-Message-State: AODbwcD+/QTTCRXNztzCOmFI/lvDohT7D1Ejxo6JHSyk/Mcu4rTGCfnX
        KFu68MiyjoX+TgKY
X-Received: by 10.84.217.73 with SMTP id e9mr5199594plj.133.1496684794761;
        Mon, 05 Jun 2017 10:46:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b834:3af4:2e37:8db3])
        by smtp.gmail.com with ESMTPSA id v69sm10013038pfd.63.2017.06.05.10.46.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 10:46:33 -0700 (PDT)
Date:   Mon, 5 Jun 2017 10:46:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 31/31] ls-files: use repository object
Message-ID: <20170605174632.GB40426@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-32-bmwill@google.com>
 <CAGZ79kY4iLWuCrPVA6mo6BbgwoF_-wyP_=ju5Fs0+n8cTifb=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY4iLWuCrPVA6mo6BbgwoF_-wyP_=ju5Fs0+n8cTifb=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/01, Stefan Beller wrote:
> On Wed, May 31, 2017 at 2:44 PM, Brandon Williams <bmwill@google.com> wrote:
> > Convert ls-files to use a repository struct and recurse submodules
> > inprocess.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> 
> > +static void show_submodule(const struct repo *superproject,
> > +                          struct dir_struct *dir, const char *path)
> >  {
> > +       struct repo submodule;
> > +       char *gitdir = mkpathdup("%s/%s", superproject->worktree, path);
> > +       repo_init(&submodule, gitdir);
> > +
> > +       repo_read_index(&submodule);
> > +       repo_read_gitmodules(&submodule);
> > +
> > +       if (superproject->submodule_prefix)
> > +               submodule.submodule_prefix = xstrfmt("%s%s/", superproject->submodule_prefix, path);
> > +       else
> > +               submodule.submodule_prefix = xstrfmt("%s/", path);
> > +       show_files(&submodule, dir);
> > +
> > +       repo_clear(&submodule);
> > +       free(gitdir);
> >  }
> 
> I like how it seems easy now to do work in another repository. :)

It really does make working with another repo easy!  No more compiling
argv options and spawning child processes :D

> 
> > -       { "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
> > +       { "ls-files", cmd_ls_files, RUN_SETUP },
> 
> With this step, we can get rid of SUPPORT_SUPER_PREFIX eventually.

Yes Ideally most of the little hacks I introduced when originally
teaching ls-files and grep to recurse could be removed.

> 
> I do not have comments on the patches in the middle, but they
> cleared up some of the questions that I asked in the early patches.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
