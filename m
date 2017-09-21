Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E4D202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 23:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdIUXEX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 19:04:23 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:43074 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUXEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 19:04:22 -0400
Received: by mail-pf0-f174.google.com with SMTP id y29so3940288pff.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLskyVHUBI2YjpqwXcIxybA27mqD/pzYiJiF5CXfnQU=;
        b=DsznNzRticwkuJ0qv/7i02F7M1tGfPdCNx29FBf9FzFQr5l2nVMvJftgNMeTqFC71f
         dF2ola7tY7EToH9lZ7lMiJUZM82NTw9oTnIXfVssctIOqPDP/8HbsLC9VfG6JKd7I5VK
         1rO6FYXNAbhI0L1n23mAi7Z9DL/hsfNz/kQLOLtvbbmXLtj/lNwaDWS9Hy00EavztZTB
         4dEIcgwM+MH003zPX2uDaBDjtwGpCjhr//SDhk5bYFoizZS7sqwm45I8kf0cTgzYhCj/
         jKOIkSwPSWlxQnErkb7Gp89AEi2Iej87eaieVjKTY0qH36u3BRysmC8bUyMZ0N1CisW0
         Jk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLskyVHUBI2YjpqwXcIxybA27mqD/pzYiJiF5CXfnQU=;
        b=U5XqdftQ1zri0eTkD97e56XAJSPuV92Dma9AA7ZXLLKeNbMBdrmM+IFzJrMLu1Lc9W
         LQqOTCU097HbvpoEozJA7uZBnDrTET6sAa95NrZm57hQlhf/iCvISUPd2MkXNLlN4nt8
         N45GSi/CBMuoc10yQzvaA/GmFxGCUkT8mX1zwYQUGvoWKG60NmRpklU9hjmwPeJazxLZ
         fV8O8owxjDFOUPfToQ2xehLnNjp1JnKBfsNraRaO4SNZ/ofbyBK6qB09v+lzRKwLXKxc
         T6uQmVryConDa3gBHUcxyQdbOj3ypvXtHFB5kGuSav4r0rDhZpmRTj+DXaQkaFl3EkO4
         HO/g==
X-Gm-Message-State: AHPjjUg3Q8rVTYQDyKxNWcpOtrtDMraesXQsz0hm2OBm/xupByKOcQKM
        NWti9AbkzsuIOkohe80FEDeppw==
X-Google-Smtp-Source: AOwi7QCRU2MhCreDPpNXOnhHiSeLxD0Fj6e9xHLOKq20zAsG+zqFpZ6dUSjIIJkWbvdi9NCpihutKQ==
X-Received: by 10.84.148.203 with SMTP id y11mr7031305plg.277.1506035059290;
        Thu, 21 Sep 2017 16:04:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:b4a5:cd04:4e1a:a2a0])
        by smtp.gmail.com with ESMTPSA id b7sm3563286pge.79.2017.09.21.16.04.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 16:04:19 -0700 (PDT)
Date:   Thu, 21 Sep 2017 16:04:16 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK) (part 3)
Message-ID: <20170921160416.1c4c6e2c@twelve2.svl.corp.google.com>
In-Reply-To: <af717446-95bf-c5a5-cd27-aaf20531db0f@jeffhostetler.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <af717446-95bf-c5a5-cd27-aaf20531db0f@jeffhostetler.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Sep 2017 14:00:40 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> (part 3)
> 
> Additional overall comments on:
> https://github.com/jonathantanmy/git/commits/partialclone2
> 
> {} WRT the code in is_promised() [1]
> 
> [1]
> https://github.com/jonathantanmy/git/commit/7a9c2d9b6e2fce293817b595dee29a7eede0dddd#diff-5d5d5dc185ef37dc30bb7d9a7ae0c4e8R1960
> 
>     {} it looked like it was adding ALL promisor- and
> promised-objects to the "promised" OIDSET, rather than just
> promised-objects, but I could be mistaken.

As far as I can tell, it is just adding the promised objects (some of
which may also be promisor objects). If you're saying that you expected
it to add the promisor objects as well, that might be a reasonable
expectation...I'm thinking of doing that.

>     {} Is this iterating over ALL promisor-packfiles?

Yes.

>     {} It looked like this was being used by fsck and rev-list.  I
> have concerns about how big this OIDSET will get and how it will
> scale, since if we start with a partial-clone all packfiles will be
>        promisor-packfiles.

It's true that scaling is an issue. I'm not sure if omitting the oidset
will solve anything, though - as it is, Git maintains an object hash and
adds to it quite liberally.

One thing that might help is some sort of flushing of objects in
promisor packfiles from the local repository - that way, the oidset
won't be so large.

> 
>     {} When iterating thru a tree object, you add everything that it
>        references (everything in that folder).  This adds all of the
>        child OIDs -- without regard to whether they are new to this
>        version of the tree object. (Granted, this is hard to compute.)

The oidset will deduplicate OIDs.

>        My concern is that this will add too many objects to the
> OIDSET. That is, a new tree object (because of a recent change to
> something in that folder) will also have the OIDs of the other
> *unchanged* files which may be present in an earlier non-provisor
> packfile from an earlier commit.
> 
>        I worry that this will grow the OIDSET to essentially include
>        everything.  And possibly defeating its own purpose.  I could
> be wrong here, but that's my concern.

Same answer as above (about flushing of objects in promisor packfiles).

> {} I'm not opposed to the .promisor file concept, but I have concerns
>     that in practice all packfiles after a partial clone will be
>     promisor-packfiles and therefore short-cut during fsck, so fsck
>     still won't gain anything.
> 
>     It would help if there are also non-promisor packfiles present,
>     but only for objects referenced by non-promisor packfiles.
> 
>     But then I also have to wonder whether we can even support
> non-promisor packfiles after starting with a partial clone -- because
> of the properties of received thin-packs on a non-partial fetch.

Same reply as to your other e-mail - locally created objects are not in
promisor packfiles. (Or were you thinking of a situation where locally
created objects are immediately uploaded to the promisor remote, thus
making them promisor objects too?)
