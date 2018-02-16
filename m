Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89701F404
	for <e@80x24.org>; Fri, 16 Feb 2018 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbeBPWeJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 17:34:09 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36820 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeBPWeI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 17:34:08 -0500
Received: by mail-pl0-f68.google.com with SMTP id v3so2433397plg.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a88CAl6KLBh+lI1SUDi8Dbam7szY7p+zg/DvpqPzOv4=;
        b=GRCD3ia2MksGROqtfMWmqijtWlcIL96B4ieyCev2Gcs71xB2BCimVx/6FaCYNIZBYG
         24sW2LMcBb3dFWmMguHPGMnds8RH9MgdjT2qGHrbWCjAlooS42F52JTAFMYush7WV2Cc
         Q9Ef03xuXjo/ApZFur0b2g2k+vamB/LGid4zt9KTiaUQ5cU5Lb4+NiP9d+hI8do2oEWX
         PJxUfJf5iT6BvDIw993IzcoilPhwxoYF5LhO4J74rK7Ifcvli0bDcdv3+QR1z92CvzB5
         YF5gxwWYTAwk0n+xPkd4f+y24KIiyjeDFxG0sNaVT1yuqMajV6r06kE2pt1wiG0kWc4E
         CxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a88CAl6KLBh+lI1SUDi8Dbam7szY7p+zg/DvpqPzOv4=;
        b=IQgF9FAXc1aWq9py3pLLSXAq/RZKQEEMEvqqtq9y0EAKC1FCLzRT43/jwf1Bcc8KCV
         ENS7GG+04gfY0rTS6Xn5l7QxJ3jnYFx1r96zuCb1PRBAG68uNfR6n4+QylX/NeUiS1lO
         eZUTu2X/xiKvzENn+BHBfgtM7BQ79QOHKA0VuGGMiHNhbGOh3BqAyzb93ABO8tirBPRC
         /fDgcoSmoCZ65PgvV+/cjZKcawn0CvBb6ZqII7KBgylbkGkp9Juv5gsd/3f4btaUp6k1
         RLYC/Iv7FNZByQfDi8PazWLRfGd0wuYVbIfAVUEaopP6QTX+FlxXg3TV+TQkltoOcLJq
         v+OQ==
X-Gm-Message-State: APf1xPDdMDXxDvEFbHvvjQCLmwLennXO9C3U7dSI0JkHc3ExsCWkf4FO
        dQyEEFoerqYWicJ3+D+uqGs=
X-Google-Smtp-Source: AH8x226gxlpT5E9DmjkRTJcwbVjVlA1bIZZ0/1Wh9xBCw77Zj5+0IXx1vR3Gq24NhjN0Q0F6XfaUiw==
X-Received: by 2002:a17:902:7182:: with SMTP id b2-v6mr7055553pll.331.1518820447550;
        Fri, 16 Feb 2018 14:34:07 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u90sm24090742pfk.114.2018.02.16.14.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 14:34:06 -0800 (PST)
Date:   Fri, 16 Feb 2018 14:34:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object
 (part 1)
Message-ID: <20180216223404.GD216564@aiede.svl.corp.google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> v2:
> * duplicated the 'ignore_env' bit into the object store as well
> * the #define trick no longer works as we do not have a "the_objectstore" global,
>   which means there is just one patch per function that is converted.
>   As this follows the same structure of the previous series, I am still confident
>   there is no hidden dependencies to globals outside the object store in these
>   converted functions.
> * rebased on top of current master, resolving the merge conflicts.
>   I think I used the list.h APIs right, but please double check.

For what it's worth, I think I prefer v1.  I put some comments on why
on patch 0 of v1 and would be interested in your thoughts on them
(e.g. as a reply to that).  I also think that even if we want to
switch to a style that passes around object_store separately from
repository, it is easier to do the migration in two steps: first get
rid of hidden dependencies on the_repository, then do the (simpler)
automatic migration from

 f(the_repository)

to

 f(the_repository->object_store)

*afterwards*.

Thoughts?

Thanks,
Jonathan
