Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D61C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383011AbhLCUL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383009AbhLCUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:11:26 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DBDC061353
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:08:02 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q72so597371iod.12
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WkYiPm6DrPFwD0Ad3m9iImPS3hyuVyqRdQK79k8DMxE=;
        b=jRF1UtG28LhKFcZLV2oP1/P03DQxtOfVp2J7TXbexnOnKOTZEH0J9EIuUZhmITyYGE
         xOjbku/DNFBSoVG9M/J0r1q8QllIp3IVrR6zx8FxrQF6s5bCPfdcEAaqzWZhNmp8z1to
         nJEwmO9zkZWz9vqMJqsT7zV9WYSXqk9lvvg/zdSC3nfT/uCb5i60kQ44z2thxuOYlctX
         VoHtXhbCkkvx/boBWi6XVBC+BuncrubhSUO0ay0xZ/1fnmAzVz1tn3/lg/pswHLGqL1Z
         XVSIEcM0FWi3HVOXIxWKVDs/MsYgK30kPdoe3GLG554UC3TKgNDaEDMpsu4n57fRoIFc
         T9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WkYiPm6DrPFwD0Ad3m9iImPS3hyuVyqRdQK79k8DMxE=;
        b=ai2v5wX/Yj6kV8tBWuC0RlQeh2d7ABVkWKHA8dNcrjOC/anm6KWC30tbPaF7+VsJlh
         VrRD5y3x1l7iuMNDrjHTASSHYKV9IY49z0V9iFruRVjT7THAG2DHT0DYQ6huPcwJMWab
         PiZXtlo2hUUAzv3K4BeGdHpfbG9jRZXnrvccrU/lH0OMyIlK8Pq4RnnWYYO5dBV9vE/k
         vm/44bIavvvNif9xZZTxw5W/KvvFP1rON9I1MWBvU9nPR8AHW+9UW2UUF3bdDqYaMlok
         Bwp3h94oqZ+NaF35pSwH7SI5nlR/IuRumkdT7jnVrWPi+Ya3DHP42JgWCQnYQlsQcFrA
         Qnhg==
X-Gm-Message-State: AOAM531XB+FApLri4Ab1IS9RCVyqUg9TIcCTQx3rzsFhef3h8BHeKHKD
        FdaRjI0vl7Q0f0VsFnVruL9LXz6lb6xbcw==
X-Google-Smtp-Source: ABdhPJw0PzNIgK3cZxkHyGbo185Wo8G3Dr/Lmr2hsvjwgYR2Jl/EZrjDNRdzNtm74KXTimZIyPLarA==
X-Received: by 2002:a05:6638:2105:: with SMTP id n5mr27656178jaj.32.1638562080924;
        Fri, 03 Dec 2021 12:08:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g15sm2295330ile.88.2021.12.03.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:08:00 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:08:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: Re: [PATCH 00/17] cruft packs
Message-ID: <Yap5INmX2ACfjoda@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <xmqq5ys5sbzc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5ys5sbzc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 11:51:51AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This series implements "cruft packs", a pack which stores accumulated
> > unreachable objects, along with a new ".mtimes" file which tracks each
> > object's last known modification time.
>
> Let me rephrase the above to test my understanding, since I need to
> write a summary for the  "What's cooking" report.
>
>  Instead of leaving unreachable objects in loose form when packing,
>  or ejecting them into loose form when repacking, gather them in a
>  packfile with an auxiliary file that records the last-use time of
>  these objects.

Exactly. Thanks for such a concise and accurate description of the
topic.

> That way, we do not have to waste so many inodes for loose objects
> that is not likely to be used, which feels like a win.

Yes. This had historically been a problem for GitHub. We don't
automatically prune unreachable objects during repacking, but sometimes
customers will ask us to do it on their behalf (if, for example, they
accidentally pushed sensitive information to us, and then force-pushed
over it).

But occasionally we'd get bitten by exploding many years of loose
objects (because we used to freshen packfiles too aggressively when
moving them around).

We've been running this series in production for the past few months,
and it's been a huge relief on the folks who typically run these pruning
GCs.

> >   - The final patch handles object freshening for objects stored in a
> >     cruft pack.
>
> I am not going to read it today, but I think this is the most
> interesting part of the series.  Instead of using mtime of an
> individual loose object file, we'd need to record the time of
> last use for each object in a pack.
>
> Stepping back a bit, I do not see how we can get away without doing
> the same .mtimes file for non-cruft packs.  An object that is in a
> non-cruft pack may be referenced immediately after the repack that
> created the pack, but the ref that was referencing the object may
> have gone away and now the pack is a month old.  If we were to
> repack the object, we do not know when was the last time the object
> was reachable from any of the refs and index entries (collectively
> known as anchor points).

In that situation, we would use the mtime of the pack which contains
that object itself as a proxy (or the mtime of a loose copy of the
object, if it is more recent).

That isn't perfect, as you note, since if the pack isn't otherwise
freshened, we'd consider that object to be a month old, even if the
reference pointing at it was deleted a mere second ago.

I can't recall if Peff and I talked about this off-list, but I have a
vague sense we probably did (and I forgot the details).

> Of course, recording all mtimes for all
> packed objects all the time would involve quite a lot of overhead.
> I am guessing (I will not spend time today to figure it out myself)
> that .mtimes update at runtime will happen in-place (i.e. via
> seek(2)+write(2), or pwrite()), and I wonder what the safety concern
> would be (which is the primary reason why we tend not to do in-place
> updates but recreate-and-rename updates).

Yeah, this series avoids doing an in-place update, and similarly avoids
recreating the entire .mtimes file before moving into place. Instead,
freshening an object stored in a cruft pack takes place by rewriting a
copy of the object loose, since we consider an object's mtime to be the
most recent of (a) what's in the .mtimes file, (b) the mtime of the
containing pack, and (c) the mtime of a loose copy (if one exists).

It can be wasteful, but in practice "resurrecting" an object in a cruft
pack is pretty rare, so on balance it ends up costing less work to do.

> Thanks for working on such an interesting topic.

I'm glad to have piqued your interest.

Taylor
