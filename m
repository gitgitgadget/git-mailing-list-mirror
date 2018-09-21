Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9795C1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbeIVDNR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:13:17 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:53668 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391586AbeIVDNR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:13:17 -0400
Received: by mail-wm1-f42.google.com with SMTP id b19-v6so4380710wme.3
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Et4oXev1BkqY9TcB6H5OzvmVdKWyOPQZ+9pkM5PhcCY=;
        b=cJYeQjWQvliov2dn2C/J7UoH4uiDSvWX4DAfN1bqas2r3jxfbzhQjAxo9aBlqJgjdp
         YlJ6Xnz1HSyJRJpkERqOazMEyzOMmAITZmwXRe2pRzge4zqVt1LsNA6/Z0tZXXxSCdST
         0AL+uMaIxwPKUYHNRvghIlUBCE9RopCkQ6BhdQ7DovgJ2XujmNVts79GmVLaMV9mk73c
         SQNWsC7wCW0TgjB9FiJwO2ZxmS+njMPzDB3bEisdWXO+3zRiOKsUcyNnTZLQVMIIRh+8
         dK5/X4f54ayxMry6XUpldo7ugaSCk/aEkVAxMHPFkiCHmXYBkX2+yD8cgCdluWerCQMU
         SLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Et4oXev1BkqY9TcB6H5OzvmVdKWyOPQZ+9pkM5PhcCY=;
        b=qNVTkL+xfgmegn4hxx/UOxh6NLCYuzzT1pQ0PCqcZ6fpsHRVHC4KZvO24oH91KQ7sH
         570tyk4oBU0JOfb1rnszgn3jMQQsgUdCviZy+3S+H3XuKZ+tShQc+5R+ic/naDCB24Od
         1YwdOVZbF3u0i6hIjf50gIGx+QhI0gjUs2ElX7phXBmVwpnMqlY20nzY9tnOKULZfe+z
         eX4MexO88PJPVFtJeBTvjC5udxXX45BZdmGhlNJE0HBwyZNALq2VqtlPl3CRzPIsNpRI
         KTRb4PjcagaQ35KPthOWejJWihNKvZrVK+HYJMBICYU5uNboA1BYFeXRCriNXvAYPp7u
         v1BQ==
X-Gm-Message-State: APzg51AvadGRsYW+itiMRH4xv2iwhhxlJEw+ozP3Lt9KvHf+g9Jmyi7X
        L/6i8mn2rJ64BmdzYFBHnqw=
X-Google-Smtp-Source: ANB0VdaZyF3UDhVH4k58F1y+R7IC/W+Y2WuHga8Q1ZA4CNWadR3Q9zZ45B2DtomlwWAPqzdHtxZVjw==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203-v6mr5786541wmu.19.1537564954559;
        Fri, 21 Sep 2018 14:22:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm5688837wmd.7.2018.09.21.14.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 14:22:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 0/7] Use generation numbers for --topo-order
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Sep 2018 14:22:33 -0700
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Fri, 21 Sep 2018 10:39:26 -0700 (PDT)")
Message-ID: <xmqq7ejev946.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in V3: I added a new patch that updates the tab-alignment for flags
> in revision.h before adding new ones (Thanks, Ævar!).

This is most unwelcome while other topics are in flight that caused
unnecessary conflict.  It would have been very welcomed if the
codebase was dormant, though.

I'll live, and there is no need to resend, but this change may not
appear in today's pushout (I'll have to push out the result of
integration before I saw this new reroll with all the other topics).


