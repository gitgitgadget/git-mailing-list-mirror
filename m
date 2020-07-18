Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDE8C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A792076A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595096784;
	bh=XYHIu9a/tBy12f9fcv04tPCJFJcYkqIXzcL4heHIjDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AcJO9sDsWzZooetb70vt+J8ead+SRi7IebQWoArMMQb7X68+7ANzsyRvJPGXIfmiL
	 FWtJzwLrE8Eh1UQkqm4qf1eXFSr4MvlWNvh61DWtr7TXtXxQ2Kd8iZuDZARe1NANqh
	 UvvVubBRhBs8Is4uvW7Rf4PJEwEk6HIjp1S+OMzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGRS0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgGRS0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 14:26:22 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51223C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 11:26:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b185so11740443qkg.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uoTm8zOrE1zG8ktUcZPFZHQ+CGFN7I49jcBAzNFgRfg=;
        b=E+hpApYvP/CZJqhLNRH6d/liJrjSJ/z6SIXn9/4Pb/8puUTtqZCkUw0KFrx62p/9Ju
         8UfIGpHOYVcku+uni2JlaBCNm/IRuPtW4tprT4eQ+RlVKWnSe4qwAR5K14m2L2IFtntI
         vxDAiCtrgM9ipLyrDethj768smiCd0Q9FTTHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uoTm8zOrE1zG8ktUcZPFZHQ+CGFN7I49jcBAzNFgRfg=;
        b=DcwsI0NbpdBNTxVAEaJAeorRYpZBPZPc4Ynhozgk/n7snhjiNNbJf/+GNHWZO7wBFk
         dGu1BWgqYqqgfK5dPqEHRXa49DkbLDfvWWzFqLdGt2CiM5qzVSxtXL/A3dYN1faXp9BB
         XAxbaWNMCVkCbxhhKTKtUyt8mjaxSGHLkUQJzujNmEtFlWogVvGPjk/PK6YzmAPPJbfS
         CBRBa/66G9d6z6Yst7+VIU1+Ov6rTFhY1Lwe7/LsjNMjPC22XdchAnuoHLhdmIjVB6Zh
         sEQNYVCQwFKKYbqYjB64C3Y+u87TPRyjcpJwWO+UznnNJiUaRspQYQSh70yEciE51/4i
         FOSg==
X-Gm-Message-State: AOAM530rauYhsycuJgwUfFwa2l2yCd/kvrBDfjx0IxuiH19IR06yYkJa
        5eDaqrvEPAJW9LK1qT68qx/Xrg==
X-Google-Smtp-Source: ABdhPJyoMFMlgwiYTHSMhFpOSZHOWg/H1IH8ow+tkMg3GKX0oRMJxYXZWp7Oo2PrjygHhEQjf19+zA==
X-Received: by 2002:a37:b987:: with SMTP id j129mr14795967qkf.120.1595096781213;
        Sat, 18 Jul 2020 11:26:21 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id r2sm13802237qtn.27.2020.07.18.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 11:26:20 -0700 (PDT)
Date:   Sat, 18 Jul 2020 14:26:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Compressing packed-refs
Message-ID: <20200718182618.yqo5dcljf3h6q57q@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200716221026.dgduvxful32gkhwy@chatter.i7.local>
 <xmqqsgdrf64c.fsf@gitster.c.googlers.com>
 <20200716225429.i7pb6xorkwdsf5fn@chatter.i7.local>
 <20200717062723.GA1179001@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200717062723.GA1179001@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 02:27:23AM -0400, Jeff King wrote:
> > Which really just indicates how much duplicated data is in that 
> > file. If reftables will eventually replace refs entirely, then we 
> > probably shouldn't expend too much effort super-optimizing it, 
> > especially if I'm one of the very few people who would benefit from 
> > it. However, I'm curious if a different sorting strategy would help 
> > remove most of the duplication without requiring too much 
> > engineering time.
> 
> You definitely could store it in a more efficient way. Reftables will
> have most of the things you'd want: prefix compression, binary oids,
> etc.  I wouldn't be opposed to a tweak to packed-refs in the meantime if
> it was simple to implement. But definitely we'd want to retain the
> ability to find a subset of refs in sub-linear time. That might get
> tricky and push it from "simple" to "let's just invest in reftable".

I'm fine either way, but a better approach seems to wait for reftables 
to land.

> You might also consider whether you need all of those refs at all in the
> object storage repo. The main uses are:
> 
>   - determining reachability during repacks; but you could generate this
>     on the fly from the refs in the individual forks (de-duplicating as
>     you go). We don't do this at GitHub, because the information in the
>     duplicates is useful to our delta-islands config.
>   - getting new objects into the object store. It sounds like you might
>     do this with "git fetch", which does need up-to-date refs. We used
>     to do that, too, but it can be quite slow. These days we migrate the
>     objects directly via hardlinks, and then use "update-ref --stdin" to
>     sync the refs into the shared storage repo.

This is definitely interesting to me, as git fetch runs into objstore 
repos do take a long time, even after I move them into a "lazy" thread.  
It's not so much a problem for git.kernel.org where pushes come in 
sporadically, but for CAF, their automation usually pushes several 
hundred repo updates at the same time, and the subsequent fetch into 
objstore takes several hours to complete.

Can you elaborate on the details of that operation, if it's not secret 
sauce? Say, I have two repos:

repoA/objects/
repoS/objects/

does this properly describe the operation:

1. locate all pack/* and XX/* files in repoA/objects (what about the 
   info/packs file, or do you loosen all packs first?)
2. hardlink them into the same location in repoS/objects
3. use git-show-ref from repoA to generate stdin for git-update-ref in 
   repoS
4. Consequent runs of repack in repoA should unreference the hardlinked 
   files in repoA/objects and leave only their copy in repoS

I'm not sure I'm quite comfortable doing this kind of spinal surgery on 
git repos yet, but I'm willing to wet my feet in some safe environments.  
:)

>   - advertising alternate ref tips in receive-pack (i.e., saying "we
>     already know about object X" if it's in somebody else's fork, which
>     means people pulling from Linus and then pushing to their fork don't
>     have to send the objects again). You probably don't want to
>     advertise all of them (just sifting the duplicates is too
>     expensive). We use core.alternateRefsCommand to pick out just the
>     ones from the parent fork. We _do_ still use the copy of the refs in
>     our shared storage, not the ones in the actual fork. But that's
>     because we migrate objects to shared storage asynchronously (so it's
>     possible for one fork to have refs pointing to objects that aren't
>     yet available to the other forks).

Yes, I did ponder using this, especially when dealing with objstore 
repos with hundreds of thousands of refs -- thanks for another nudge in 
this direction. I am planning to add a concept of indicating "baseline" 
repos to grokmirror, which allows us to:

1. set them as islandCore in objstore repositories
2. return only their refs via alternateRefsCommand

This one seems fairly straightforward and I will probably add that in 
next week.

> So it's definitely not a no-brainer, but possibly something to 
> explore.

Indeed -- at this point I'm more comfortable letting git itself do all 
object moving, but as I get more familiar with how object-storage repos 
work, I can optimize various aspects of it.

Thanks for your help!

-K
