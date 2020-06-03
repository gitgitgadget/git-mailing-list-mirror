Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202BEC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 01:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E682920738
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 01:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYLF9OHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCBxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgFCBxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 21:53:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C171C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 18:53:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t7so636436pgt.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ll3KviZ6Sw8Viis99zIflLaE+5gxn8HS4B3bzRNMHXk=;
        b=BYLF9OHFu24RbY3fZQSUmnTYUyCTcctTQHu2TEicPcHBde0aDpQGSH4372Pn93xzaW
         68BzKh0lwlKb6GEdeIOS5zU4GMdvTMIAzfBiKvq6OvWuD4u+D/vfNC6+2jwVc7J95KTU
         R5df1zNmos0TA2ng7wpk/lxr5E7LAd73lMj7nDl4Sup6l9Rwb3aZ0UQcQphNjktHJW4T
         9EVU3TtsLhO0g+yKTMei0Jp1VLXxcNt9zzWksrnCgTFr1M0I5pr/LDm5FN1LzLs2Itvp
         AfUj4+u7zbpExQ4VRfkt3oU8dODiH5tZJQA16Er0JwhZ6iKLISLjttwCi9+LIV2IT4S3
         4v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ll3KviZ6Sw8Viis99zIflLaE+5gxn8HS4B3bzRNMHXk=;
        b=jL9Zdx6Bsvy8C0/zEtNSerHbe6Ezl+iYD2ZIE1ubssX46RkZQouu+OvbGwEMBUzQA0
         hqDthMCOte+6Yf9jOmgLio9EWiLc/yx16Xpw+JFDMhJTDx+JUSnOzB/q+aYqxjuTrTgt
         EJCYoJqBFVtX+60Qltfp9Ek4l3yNeg81sn/QkRTFGF9wivhFIhjAy/5HHJ4KbBuQQHBN
         PsUSRqCP4EZkrjLzPybXm0+j9QKV3A1N9otyukkeZCe8Wi4OO0AZT4L0XRA3VwcjrOND
         nma6CGmErhihJfdnvtmlFJzE/SEBopBxUgC5hCUH0eLmoB3QLoT4LZbao74VBbjkeGJD
         NwBw==
X-Gm-Message-State: AOAM533/PUJm0SzvVgSHJXtvM+lJKTBzkB7jWzp+yMpTHK4aq8817Dtc
        nNKjwFb9k2vtnzSczebWT7A=
X-Google-Smtp-Source: ABdhPJzy9xa1sisNkniK4b9apIwZ8IUdvBYy+VupBattX5bxZI7rqwaENSoo28qxiYl7bWnqHNRhQA==
X-Received: by 2002:a63:9e12:: with SMTP id s18mr27717987pgd.333.1591149197500;
        Tue, 02 Jun 2020 18:53:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q193sm331818pfq.158.2020.06.02.18.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 18:53:16 -0700 (PDT)
Date:   Tue, 2 Jun 2020 18:53:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Minh Thai <mthai@google.com>
Subject: Re: Huge push upload despite only having a tiny change
Message-ID: <20200603015314.GA253041@google.com>
References: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc: Jonathan Tan for "git push" discussion; Minh Thai for negotiate
 hook discussion)
Hi,

Elijah Newren wrote:

> I had a user report that two nearly identical pushes (the second being
> an amended commit of the first) took dramatically differing amounts of
> time and amount of data uploaded (from 4.5 seconds and about 21k
> uploaded, to 223 seconds and over 100 MB uploaded).

Yes, this is why I want push negotiation.  (It's been something we've
been discussing for protocol v2 for push.)

If they fetch before they push, does that help?

[...]
> * The server was running Gerrit 3.1.4 (i.e. jgit).

Gerrit servers have the interesting property that many people are
pushing to the same Git repo.  (This is common in some other hosting
scenarios such as Gitlab, but the most common case among Git users
still seems to be pushing to a repo you own.)

When you push, because there's no negotiation phase, the only
information we have about what is present on the server is what is in
the ref advertisement.  (We have remote-tracking branches which seem
potentially useful, but we don't have a way to ask the server "are
these objects you still have?")  The ref advertisement describes the
*current* state of all refs.  If I am pushing a new topic branch (in
Gerrit jargon, a new change for review) based on the *old* state of a
branch that has moved on, then we can only hope that some other ref
(for example a tag) points to a recent enough state to give us a base
for what to upload.

There is one trick a server can use to mitigate this: advertise some
refs that don't exist!  If you advertise a ref ".have", then Git
will understand that the server has that object but it is not an
actual ref.  Gerrit uses this trick in its HackPushNegotiateHook[1]
to advertise a few recent commits.

At $DAYJOB we ran into some clients where "a few recent commits" was
not sufficient to get to history that the client is aware of.  We
tried changing it to do some exponential deepening, and that helped.
We should probably upstream that change for other Gerrit users.

Gerrit also advertises some other ".have"s, for example for recent
changes by the same author in case you're uploading an amended
version.  That's less relevant here.

But fundamentally, this is something that cannot be addressed properly
without improving the "git push" protocol (adding a negotiation
phase).

Summary: (1) try fetching first (2) let's improve
HackPushNegotiateHook#advertiseRefs (3) let's improve "git push"
protocol to make this a problem of the past.

Thanks and hope that helps,
Jonathan

[1] https://gerrit.googlesource.com/gerrit/+/e1f4fee1f3ce674f44cb9788e6798ff8522bb876/java/com/google/gerrit/server/git/receive/HackPushNegotiateHook.java#111
