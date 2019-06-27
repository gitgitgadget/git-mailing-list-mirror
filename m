Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7659F1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF0Wd2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:33:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF0Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:33:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so1928228pfa.4
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QaQSt8d6JHHJxbY6lW8eFlfuxszjvspu9R5/W9d4878=;
        b=hCHfZiQpZuy/yS+ScW+4NSZjL2Z8wFiZIfTqsWtAYb/nHdkGcLDGd0quxA7tzPtt8X
         qdcZUvmxtqFpL1L5FY4p+3K6LCB0vHcIyUufvRhkRV8WVUo3e9m26DiVpuOTHnLZbsCJ
         /mTNCsEc2qzOJvMG27ZCv4rDHzvozQlUv3E5XFpBNdr3tx7Xe8KaTzWMb3c91FUYs6Og
         97vbVwfUf3gwwsgTSkXeX+Ve/E0Y7FdvmWXmarO13pHI70SJ94ltAcV56LV+jMthgwzh
         SO00sT3M08Ok7hdhZcbVKENVs7Xg4sIysYFtji+GQbt5fJV3tMnl45cS16NzOcBP8nSc
         Ai5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaQSt8d6JHHJxbY6lW8eFlfuxszjvspu9R5/W9d4878=;
        b=jaQ9Hth0bQhLjIlYO/lQSCPNZ9Q/txPSTeWLJL5ebpZfuyIaBCilCVXyG4hl82d1Su
         g1p47q3YpsUqvZ/wge1cwdU0QysNxG8uXV+f/FijS6zs3OR2hGrxQ7YGKzobLlB5cvJd
         U/74pGN1Xm8JIdoML+MmnYOvK85B91z19cEmuKtSwdC5ub/5OytGlGpGyqzjMjxdytN1
         NxYsCr5xMt7O7dLOhwRhF4Lzv7Hthl9t3qF8UXM6O3SJADr8RriM+rOoyOY5i0/5Apaw
         ZOtm4vQhiobOFoUpKVX5zfq/9Js5+wpfN8aHKeBkk0462PwAEh/m8tOBxTUK3v8Y1rvs
         UdqA==
X-Gm-Message-State: APjAAAWRQskQzbn6j3Na0EXPXQjDwg9xSqCyXTfDDBo4fpq+GzMXACwg
        QoKcGmTdu/eoCxqTQFBSB8ZZ1g==
X-Google-Smtp-Source: APXvYqxylqejBTofdePytnxGx2uNCrx/vFtDE3/UtIGVS9jou1QPGIU7nMTVWcKMZL5XaK+wPEQ4NQ==
X-Received: by 2002:a63:18c:: with SMTP id 134mr5892199pgb.432.1561674806967;
        Thu, 27 Jun 2019 15:33:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id q126sm107763pfq.123.2019.06.27.15.33.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:33:26 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:33:22 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 11/13] walken: add filtered object walk
Message-ID: <20190627223322.GI245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-12-emilyshaffer@google.com>
 <CAPig+cSJLbeVawxRhHwqLEXBr6-3QoaYd+1zF169m5N=kq4J4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSJLbeVawxRhHwqLEXBr6-3QoaYd+1zF169m5N=kq4J4Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:42:45AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > Demonstrate how filter specs can be used when performing a revision walk
> > of all object types. In this case, tree depth is used. Contributors who
> > are following the revision walking tutorial will be encouraged to run
> > the revision walk with and without the filter in order to compare the
> > number of objects seen in each case.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -143,6 +144,10 @@ static void walken_show_object(struct object *obj, const char *str, void *buf)
> >  static void walken_object_walk(struct rev_info *rev)
> >  {
> > +       struct list_objects_filter_options filter_options = {};
> > +
> > +       printf("walken_object_walk beginning...\n");
> 
> Is this debugging code which you accidentally left in? Or is it meant
> to use trace_printf()? Or something else? If it is a genuine message,
> should it be localizable?

The former. Removed.

> 
> > @@ -157,7 +162,24 @@ static void walken_object_walk(struct rev_info *rev)
> >         blob_count = 0;
> >         tree_count = 0;
> >
> > -       traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
> > +       if (1) {
> > +               /* Unfiltered: */
> 
> The subject talks about adding a _filtered_ object walk (which is in
> the 'else' arm), so should this be "if (0)" instead?

Done.
