Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA91F20A26
	for <e@80x24.org>; Wed, 27 Sep 2017 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdI0Uth (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 16:49:37 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:47541 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdI0Utg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 16:49:36 -0400
Received: by mail-pg0-f44.google.com with SMTP id d8so8426589pgt.4
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9bpFeGe7zVPP+zEC2W4/l1lqImS/QYCIY6N5/vpoHg=;
        b=mbFobKYv3opH/+7WFw+/EvbYSI4rS3mVNzrXB/xsL142K7LEO2pYg03nsybNMe9e/B
         fV0yTdIz348rGnafGVBU1G9YyeAc/TJzmGqiFz9ZeRWdCLx3yuHW1tyCLowgsqym1BTa
         wtNziraRX6p0zH8qmplS3nB1EQi+iByUZ+OFCyIDs7RQKcdYCO8X2Vqk8dKECxBZxv32
         Jr4mccLQ+2xK1pMcpU0mVIYuYZ1ByGY5DEjPRKiBU2xB8B10sg6xX1IkyHXMlceMnbVH
         Y2l3b6e5pwjf0QNqr9x8zIEfjcgLWLeIssw/15P6ESwyO+pCw8k653XPHrqcR9+gciTU
         p3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9bpFeGe7zVPP+zEC2W4/l1lqImS/QYCIY6N5/vpoHg=;
        b=NXyWufo121Ycl4JSqKakql88ZPOFZnXdjzwTlbE0FeXAn+71y4ZueFgvwwRdok1DYN
         PVbtDDs9SuEkpf6bUMIo1tsPriTGdDpzLoisOyGfv4b3Kpo0sj2la/RSbZPTJQKTfNK5
         EGdZWuuJT45Wb+3EwYwnClkjznZHdNl1XRxGFQUnmmQPqesEwvVYo6BhVcrkCZcdKDVP
         rGAPZQQFyVMpr06EQFY4Lz6bQv1oSs85VEZ0G5U3dYaQp0zBJ7RPxHZFZH7mfBAKTsue
         g/JTZvAbnhKcWZg28iw0Y6c7lG/NcA2CWZ3z8Q1WEadisy2E3jbHs/YV4VXJoan8Guex
         7SGQ==
X-Gm-Message-State: AHPjjUhssKoYACwsb33+8zvudp0eGP1vpnQg2sTeiiDtQLPi2A7TtLrx
        Nl6GPrP5/n/whqqjeUg7JDlYC03jlIE=
X-Google-Smtp-Source: AOwi7QCpadL5++I/1uZsWjrMoD6xKxiyfeEXYZwjb0CxPBQWgTs0PQ9Dq4VHg3dF6yLL+P/ur83C5A==
X-Received: by 10.84.228.207 with SMTP id y15mr2099888pli.301.1506545375795;
        Wed, 27 Sep 2017 13:49:35 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:6d10:3370:77a8:b2d0])
        by smtp.gmail.com with ESMTPSA id y7sm278405pfy.35.2017.09.27.13.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 13:49:35 -0700 (PDT)
Date:   Wed, 27 Sep 2017 13:49:34 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
Subject: Re: [PATCH 03/13] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20170927134934.d40b24d08749c6d4589e8b33@google.com>
In-Reply-To: <1577b87b-d6de-1434-930a-83fde384d4ca@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
        <20170922202632.53714-4-git@jeffhostetler.com>
        <20170926153141.6a8d7e5024eeed5bbda838c8@google.com>
        <d5de0eda-18aa-a796-e7d0-d536d2e59605@jeffhostetler.com>
        <20170927110007.9ee2f725c01f0c7465838c04@google.com>
        <1577b87b-d6de-1434-930a-83fde384d4ca@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2017 15:09:43 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> By adding it to the set of provisionally omitted objects, we
> have the option to capture a little extra information with it
> and refer to that the next time we see the object in the traversal.
> For example, in the sparse-checkout case, the first time we see the
> object we know the pathname and know that it does not need to be
> included.  The second time we see that object, we can see if the
> new pathname is the same as the previous one with a simple strcmp
> and avoid the expensive is_excluded_from_list() computation.  Keep
> in mind that rev-list or pack-objects could be called be on something
> like HEAD~100000..HEAD or that there may be 50,000 tips.  So a file
> that doesn't change across that range will be visited many times
> with the same {pathname, sha}.

Ah, capturing the extra information makes sense. I missed that detail.

> Right now I want to force the tree to be shown the first time it is
> visited (because I don't want to do tree filtering yet).  I don't mark
> it SEEN yet because we may want to revisit blobs within (say, after a
> folder rename like I described previously).
> 
> I do, however, mark the tree object as SEEN (in the _END event) when I
> can verify that I've included ALL of the children.

This optimization makes sense too.

> So it might be possible that I could change the flags and not use
> FILTER_REVISIT on tree objects, I hesitate to do that right now.

You're probably right that we need some sort of flag on tree objects,
and FILTER_REVISIT can do the job. (My suggestion SHOWN plays a similar
role anyway.)

> Having the FILTER_REVISIT flag on blob objects means I can avoid
> doing a hash/oidset lookup on subsequent visits.

By the hash/oidset lookup, I presume you mean the lookup on the set of
provisionally omitted objects? If yes, this makes sense.

Thanks for your clarifications - I'll take another look at the code
here.
