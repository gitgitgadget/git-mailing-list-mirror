Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52CC4332F
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiCVVrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiCVVqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 17:46:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E455F8DB
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 14:45:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gb19so16779496pjb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uibyLFfh2Ey0Zu1WKW2hDc9u7dNACIQo45E4l9uW/D4=;
        b=fP3Ox4ihZjEg+CdPHzazoD7sxgN8gM1SkMIhata2ndVeAvw38XS27+H7lf0X7ghNpR
         /JMP57vCmxE2S7OOk+xbTx4u2X0HgntwpjIjZfBzKydxRTFEdXCg9CaX33Y40A6CspAy
         y4aJ8Faftress+aaeu7FxB41a5k/r2Z8zPTuzGF0Ntki0YDAjPFXz2A155gSYL/89Qrg
         qFuCleB5Egd88M3fSeY1YnJI5mDLOOn8K+BAtYE86wU+2/kVZsTqu0MPfPWph12nu/XH
         D22g2zYwQEHHLtnoFB9YZ8AYrsKUVwFrVvtMpcpZxhTs9W9zTzfTIG2Cja+j60mzh2Nj
         ryqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uibyLFfh2Ey0Zu1WKW2hDc9u7dNACIQo45E4l9uW/D4=;
        b=kO6wgecoOHw3GHWjavyjfgLC0C/wWVChDllU22fQbB5S55kk5NaeibWZ9/NkwJV5ah
         ior3F6uJdmZIm8kLvR9leICw4IJsEe005VqPo7GD6uR2YavoITtKIM4d4XvfMF7nMLgB
         i2Gx1bu5mC92xwANbz0Lqo+lxp3u+cuNvhUSzVVAa2DZn+zIk1wxw2FMUAG3mLZqqVp7
         CXZHlhxrttJmZ7VFNwouFuFm07T97I2WLc/wML2HPQSspWXHbEaUS9ObXRME3QbzRbZl
         L5fVyPiitWC46EjvtIIEr3hMVMNbKciZrEFVH6qRoyAGc27Rwvz5NqTrj1R7phZ1bKSy
         PHjA==
X-Gm-Message-State: AOAM532LeEb7TZNZmvkSIu4W5//xYDJKu8gfc3Ta39IrNy9Zh3KCqZhs
        VPt/mMkGVlTucCBLHX3IJVM=
X-Google-Smtp-Source: ABdhPJxKPJOwtJihQzTK0ZOyU15+3pyefy6yKin8ZKQpZIuoRHC+bzfoKMZMtHgkumylOmfVYEXs8w==
X-Received: by 2002:a17:902:b094:b0:151:be02:8e27 with SMTP id p20-20020a170902b09400b00151be028e27mr20598851plr.50.1647985519306;
        Tue, 22 Mar 2022 14:45:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2e30:848f:8047:6e70])
        by smtp.gmail.com with ESMTPSA id p125-20020a622983000000b004f6c5d58225sm23942578pfp.90.2022.03.22.14.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:45:18 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:45:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YjpDbHmKY9XA2p0K@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
 <YjkjaH61dMLHXr0d@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjkjaH61dMLHXr0d@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:
> On Mon, Mar 07, 2022 at 10:03:35AM -0800, Jonathan Nieder wrote:

>> Sorry for the very slow review!  I've mentioned a few times that this
>> overlaps in interesting ways with the gc mechanism described in
>> hash-function-transition.txt, so I'd like to compare and see how they
>> interact.
>
> Sorry for my equally-slow reply ;). I was on vacation last week and
> wasn't following the list closely.

No problem --- thanks for getting back to me.

[...]
> (After re-reading what you wrote and my response, I think we are saying
> the exact same thing, but it doesn't hurt to think aloud).

Great.  Can the doc cover this?  I think it would be helpful to make
that easy to find for others with similar questions.

If it's a matter of finding enough time to write some text, let me
know and I can try to find some time to help.

[...]
>> Can this doc say a little about how "git prune" handles these files?
>> In particular, does a non cruft pack aware copy of Git (or JGit,
>> libgit2, etc) do the right thing or does it fight with this mechanism?
>> If the latter, do we have a repository extension (extensions.*) to
>> prevent that?
>
> I mentioned this in much more detail in [1], but the answer is that the
> cruft pack looks like any other pack, it just happens to have another
> metadata file (the .mtimes one) attached to it. So other implementations
> of Git should treat it as they would any other pack. Like I mentioned in
> [1], cruft packs were designed with the explicit goal of not requiring a
> repository extension.

Sorry, the above seems like it's answering a different question than I
asked.  The doc in Documentation/technical/ seems like a natural place
to describe what semantics the new .mtimes file has, and I didn't find
that there.  Is there a different piece of documentation I should have
been looking at?

Can you tell me a little more about why we would want _not_ to have a
repository format extension?  To me, it seems like a fairly simple
addition that would drastically reduce the cognitive overload for
people considering making use of this feature.

[...]
> The key advantage of cruft packs is that you can expire unreachable
> objects in piecemeal while still retaining the benefit of being able to
> de-duplicate cruft objects and store them packed against each other.

Can you say a little more about this?  My experience with the similar
feature in JGit is that it has been helpful to be able to expire a
cruft pack altogether; since objects that became reachable around the
same time get packed at the same time, it's not obvious to me what
benefit this extra piecemeal capability brings.

That doesn't mean the benefit doesn't exist, just that it seems like
there's a piece of context I'm still missing.

>>> +Notable alternatives to this design include:
>>
>> This doesn't mention the approach described in
>> hash-function-transition.txt (and that's already implemented and has
>> been in use for many years in JGit's DfsRepository).  Does that mean
>> you aren't aware of it?
>
> Implementing the UNREACHABLE_GARBAGE concept from
> hash-function-transition.txt in cruft pack-terms would be equivalent to
> not writing the mtimes file at all. This follows from the fact that a
> pre-cruft packs implementation of Git considers a packed object's mtime
> to be the same as the pack it's contained in. (I'm deliberately
> avoiding any details from the h-f-t document regarding re-writing
> objects contained in a garbage pack here, since this is separate from
> the pack structure itself (and could easily be implemented on top of
> cruft packs)).
>
> So I'm not sure what the alternative we'd list would be, since it
> removes the key feature of the design of cruft packs.

Sorry, I don't understand this answer either.  Do you mean to say that
JGit's DfsRepository does not in fact have a cruft packs like feature
that is live in the wild?  Or that that feature is equivalent to not
having such a feature?  Or something else?

To be clear, I'm not trying to say that that's superior to what you've
proposed here --- only that documenting the comparison would be
useful.

Puzzled,
Jonathan
