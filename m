Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043512047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdHGTV5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:21:57 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35944 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdHGTV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:21:56 -0400
Received: by mail-pf0-f180.google.com with SMTP id c28so5126752pfe.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toB939VVtdQwWud33/xKEClHcjRqw0dYQ1sR61lPTig=;
        b=XvDxOVBlGq02JG4ScIlkUxmEKIuNBOdpES8o/JK5wbF04kVV0bwNOlwHlhBgd120bJ
         kE/lJaM/jUJaCIlsieT72OjZMT2a8Ii+BHl3MjV21t7Ekw7+VaQeoW+cuYNgYBNjfTa6
         x69hfl2pzftwPuL7hA5A53JbVszu/HykPPw1iPZ8n7fvlxN5cQz1ZDCRXCVlXfDK/io8
         Jpjx6oLKRZUrFVeQpkaJ3AMCKa2C/bpnBVMq+kC+/j4AP/oQ6ykP3dclA+95RG6A2WAQ
         n4F3LlbOwRR5Q4jaUcNPKG4fNFC1K48YnlBYsDkdGq8XfN9yFseB6qYI2x6UB2jALN0v
         AaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toB939VVtdQwWud33/xKEClHcjRqw0dYQ1sR61lPTig=;
        b=LTtFd06teHsC+IZ43CsldfcKC7/EvLWxGZEhE6pEJSb6Kpw7cjIiE0gj36RUh/4fg5
         fmD1xTGkBYCV5AoBeLCzCbxC3SAU9d9jpTNCkxHw8Tvd/egb9PtPgI6mY1iMSC3C3sZh
         sJgd8RoK9qxqi5L/U/DdBnhbrDkKi2E/VTjgvfmp6hoODyEA73d9YjMLkBW61eUFdnto
         rBzCi5HMJTcJ5UPGiV7uGbUzvDiif7d4xcM5QSVSAcFVD6kXgvzTaC2mdtSqD5VSQPDj
         ti1q00KSwSkCBrJ2/yc++sHRk+DV7XZGM9X73uJ0lshJgwnQ8dhwO8ZoDThCiOu/Xm6A
         enNA==
X-Gm-Message-State: AHYfb5h+kfR1lFQvMembmTt+SwxGnyRbL1xJ67zc7t5lgTRpVMslHHlc
        4PqY+Wgmt0N/zA==
X-Received: by 10.84.163.75 with SMTP id n11mr1741987plg.475.1502133716028;
        Mon, 07 Aug 2017 12:21:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:f50a:fad9:e416:8b99])
        by smtp.gmail.com with ESMTPSA id q5sm13783911pgn.21.2017.08.07.12.21.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 12:21:54 -0700 (PDT)
Date:   Mon, 7 Aug 2017 12:21:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com
Subject: Re: Partial clone design (with connectivity check for
 locally-created objects)
Message-ID: <20170807192151.GX13924@aiede.mtv.corp.google.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
 <20170804172137.42f27653@twelve2.svl.corp.google.com>
 <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:
>> On Fri, 04 Aug 2017 15:51:08 -0700
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Jonathan Tan <jonathantanmy@google.com> writes:

>>>> "Imported" objects must be in a packfile that has a "<pack name>.remote"
>>>> file with arbitrary text (similar to the ".keep" file). They come from
>>>> clones, fetches, and the object loader (see below).
>>>> ...
>>>>
>>>> A "homegrown" object is valid if each object it references:
>>>>  1. is a "homegrown" object,
>>>>  2. is an "imported" object, or
>>>>  3. is referenced by an "imported" object.
>>>
>>> Overall it captures what was discussed, and I think it is a good
>>> start.
>
> I missed the offline discussion and so am trying to piece together
> what this latest design is trying to do.  Please let me know if I'm
> not understanding something correctly.

I believe
https://public-inbox.org/git/cover.1501532294.git.jonathantanmy@google.com/
and the surrounding thread (especially
https://public-inbox.org/git/xmqqefsudjqk.fsf@gitster.mtv.corp.google.com/)
is the discussion Junio is referring to.

[...]
> This segmentation is what is driving the need for the object loader
> to build a new local pack file for every command that has to fetch a
> missing object.  For example, we can't just write a tree object from
> a "partial" clone into the loose object store as we have no way for
> fsck to treat them differently and ignore any missing objects
> referenced by that tree object.

That's related and how it got lumped into this proposal, but it's not
the only motivation.

Other aspects:

 1. using pack files instead of loose objects means we can use deltas.
    This is the primary motivation.

 2. pack files can use reachability bitmaps (I realize there are
    obstacles to getting benefit out of this because git's bitmap
    format currently requires a pack to be self-contained, but I
    thought it was worth mentioning for completeness).

 3. existing git servers are oriented around pack files; they can
    more cheaply serve objects from pack files in pack format,
    including reusing deltas from them.

 4. file systems cope better with a few large files than many small
    files

[...]
> We all know that git doesn't scale well with a lot of pack files as
> it has to do a linear search through all the pack files when
> attempting to find an object.  I can see that very quickly, there
> would be a lot of pack files generated and with gc ignoring
> "partial" pack files, this would never get corrected.

Yes, that's an important point.  Regardless of this proposal, we need
to get more aggressive about concatenating pack files (e.g. by
implementing exponential rollup in "git gc --auto").

> In our usage scenarios, _all_ of the objects come from "partial"
> clones so all of our objects would end up in a series of "partial"
> pack files and would have pretty poor performance as a result.

Can you say more about this?  Why would the pack files (or loose
objects, for that matter) never end up being consolidated into few
pack files?

[...]
> That thinking did lead me back to wondering again if we could live
> with a repo specific flag.  If any clone/fetch was "partial" the
> flag is set and fsck ignore missing objects whether they came from a
> "partial" remote or not.
>
> I'll admit it isn't as robust if someone is mixing and matching
> remotes from different servers some of which are partial and some of
> which are not.  I'm not sure how often that would actually happen
> but I _am_ certain a single repo specific flag is a _much_ simpler
> model than anything else we've come up with so far.

The primary motivation in this thread is locally-created objects, not
objects obtained from other remotes.  Objects obtained from other
remotes are more of an edge case.

Thanks for your thoughtful comments.

Jonathan
