Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BEB1F406
	for <e@80x24.org>; Sat, 12 May 2018 13:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbeELN6l (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 09:58:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50683 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeELN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 09:58:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id t11-v6so6664396wmt.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bm+whrg1oBlSrdupaLxWY3R/l5Cg5jC8antMdZ/L/A8=;
        b=U1baVmsH4a4sBgJ6VtzWm4zs+J88qYKwfrIkfj7d/gyaVerTaDXkMPwwJcoT4IMcMh
         tPv4jV8ajMqOZHufrWcfnNgokMcPUmbT4i4OOZaNLHjlVfJmc506DlbD+zHQBM6Wr7QT
         +VJ+V0tPb3PXBBlqs9fvKq7APBW9pag9xobxNwp4QhJX/21j5V+FRIZSWauqQVNLhbhS
         UI+vKzQe8/U80lZGkU3gt+SVsLi8rIxAnh4SF3G/qniLy0gheF8V771pD9QQ0Z6OTvnk
         sZXWDxwOd3bDomAo5whSNyEU5H5x2BFnblOOWHOnf/gDH/xFEqy7zbAa+dxquQoSHRAo
         DaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bm+whrg1oBlSrdupaLxWY3R/l5Cg5jC8antMdZ/L/A8=;
        b=bvB0ku873EwDPeOYwuFEj4YlWTT3bRRehwXpDTUS+wgan6j2FesUmakEK0XkuNwFM5
         6MZ0NSjl0gJ2q42WxS/rKO3bLg5UX9XDLi0Pufb6I8Um1JqhJv8wX8uhNLuTnd+WKw7p
         pchEidSUSJ2yPEIJesN/C9nd1JjTLkVB1FqQVa0Giermtb5RZqDFoT3trXMmOSRada87
         xghciOpq53f73rZ0kU/AWnkMb9NaGeh8l1od8Keq26SJFLdtmzWbRhnTU+AGg0CnyhMo
         wwfYNVw/DutJLxquOnlUtdiLrEuG9NlxqQ7KcGhmxVos9RS1zLuyqTBKjr5lim4wQVNS
         2tUw==
X-Gm-Message-State: ALKqPwf88UiKBgNXCIdHX7g153fzFQKLt410t7g6EWQFQD1uPHwWocRg
        pXCYx0l7Iu5QJOwwb2nWimQ=
X-Google-Smtp-Source: AB8JxZqqMo91j1n7+RD2e+pyyslLFoP9BCfQtZsm8e4zW05v2bxCqFZHQWhYahlxAGwLpXcV/wQjPQ==
X-Received: by 2002:a1c:95d3:: with SMTP id x202-v6mr1431972wmd.52.1526133518652;
        Sat, 12 May 2018 06:58:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p33-v6sm7839432wrc.14.2018.05.12.06.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 06:58:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 06/12] revision.c: use commit-slab for show_source
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180512080028.29611-7-pclouds@gmail.com>
        <20180512093344.GG28279@sigill.intra.peff.net>
Date:   Sat, 12 May 2018 22:58:37 +0900
In-Reply-To: <20180512093344.GG28279@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 12 May 2018 05:33:45 -0400")
Message-ID: <xmqqy3gpdlgy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, May 12, 2018 at 10:00:22AM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> diff --git a/revision.h b/revision.h
>> index b8c47b98e2..72404e2599 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -6,6 +6,7 @@
>>  #include "notes.h"
>>  #include "pretty.h"
>>  #include "diff.h"
>> +#include "commit-slab.h"
>>  
>>  /* Remember to update object flag allocation in object.h */
>>  #define SEEN		(1u<<0)
>> @@ -29,6 +30,7 @@ struct rev_info;
>>  struct log_info;
>>  struct string_list;
>>  struct saved_parents;
>> +define_commit_slab(source_slab, char *);
>
> Since this one is a global, can we give it a name that ties it to the
> revision machinery? Like "revision_source_slab" or something?

Should this one be global in the first place?  Can we tie it to say
"struct rev_info" or something?  I'd somehow anticipate a far future
where object flag bits used for traversal book-keeping would be moved
out of the objects themselves and multiple simultanous traversal
becomes reality.

Not limited to this particular one, but we'd need to think how the
commit_slab mechanism should interact with the_repository idea
Stefan has been having fun with.  If the object pool is maintained
per in-core repository object, presumably we'd have more than one
in-core instances of the same commit object if we have more than one
repository objects, and decorating one with a slab data may not want
to decorate the other one at the same time.
