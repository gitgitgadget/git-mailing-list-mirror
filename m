Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B350EC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiBGVez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbiBGVex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:34:53 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140CC06109E
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:34:52 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d8so12533140qvv.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40a/ahk9imMxQAtGwx2mZdR8pwZR51HWz+JBxaU4yu0=;
        b=g2yk3+D0NAzcLNuObUgS65O3SnLDJw1BWGp140vu+GyIr5q2tyO5wIVOlfIEAhsPDW
         k/yhiQ/j3b/KGfszeBiNRf3rFdIx0W7xpJN7mwZgX9BXDT+XFzckH2nYrb0zJLKn9Kpn
         3vcZv2NKa1jgLhvT/sdham03rNzlyOzB/ynCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40a/ahk9imMxQAtGwx2mZdR8pwZR51HWz+JBxaU4yu0=;
        b=vT0xQWDhi0ie6Bt3wqGAJtGyKSVriG8RYo7klRe6Qjna/rL5hEM2Jj1a4KokQ1sCWJ
         Lr/4z3g7sVpjVsfPFJw0LXhwjyIVm09U+YOdQMgMmxPeM4cmwBDdE5+i8fzLB/98Vstv
         u4B55EQOdGsfv5P0/5zz6+Ev1SJ52MFNRGyqAaMZamEHdUuICOOYO78tfSaYoQ3BXsxV
         C7y6LBXAAajb6N7RXt4NOcspQhsHR7qh1WiZMiLSLm61fsvfjmAHTVpen2SYnkHegkcD
         pMKzHNILUg3I+vPk5VWK5Eafl+mdgXFhWB3l+3yzDImL7e3ZdL0C7v80tCzNjLisZra8
         RLfQ==
X-Gm-Message-State: AOAM532pwktUdVqrU71+it4KzgS1IIJUuzdUTI7/C0uBTkTlHTGBXovC
        nVHsfN0wzuyKa2DoxogtXIhKUg==
X-Google-Smtp-Source: ABdhPJywsRY8yT6/+uwtU15XOI6PmuY6kFyT+yPqHZWbeRZUvRt84jzIzO6gqnkOg2BEyGk5IK7kmA==
X-Received: by 2002:ad4:5961:: with SMTP id eq1mr1161188qvb.20.1644269691759;
        Mon, 07 Feb 2022 13:34:51 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id e9sm6593195qtx.37.2022.02.07.13.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:34:51 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:34:49 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Message-ID: <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
 <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
 <xmqqee4fix0l.fsf@gitster.g>
 <20220207133244.kpyczjsxriepjtdt@meerkat.local>
 <xmqqczjyiecs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczjyiecs.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 07, 2022 at 12:57:55PM -0800, Junio C Hamano wrote:
> You are solving a different problem: "I have this tar archive; what
> git tree object would I get if I extract this archive to an empty
> directory and said 'git add . && git write-tree'?".
> 
> I agree that one is computable.

So, I was brainstorming about this today, and I'm curious if you think this
would be a useful feature to have, maybe even natively?

E.g. here's a scenario:

"git archive -S <signed-object>" creates an additional file that is added to
the generated tar/zip archive -- for example, a ${prefix}.GIT_ARCHIVE_SIG. That
file contains the raw contents of the signed tag and/or the signed commit.

"git verify-archive" would look for a toplevel .GIT_ARCHIVE_SIG file. If it's
present, it would verify the signature on these "detached" signed objects to
get a trusted tree hash. Then it would compute the tree hash of the tar
archive (minus the .GIT_ARCHIVE_SIG file) to see if it matches.

In my mind, that would provide the following benefits over the current
practice of detached .sig files:

1. environments like github/git.kernel.org would be able to create verifiable
   snapshot archives using an existing set of signed objects
2. packagers would be able to perform cryptographic verification without
   needing to track any extra sources like corresponding .sig files; they
   would just need to add a build-time dependency on git (plus whatever it
   calls for cryptographic verification, such as gnupg or openssh)
3. this would automatically support all git-native signature mechanisms like
   openssh and whatever else gets added in the future

Does this idea have any merit, or is it too fragile/crazy to bother?

> Of course, even that reverse problem will break once we consider the
> release tarball generation procedure where we _add_ some generated
> files that are not in the Git tree, for builder's convenience.

Yes, but it's increasingly rare and many build instructions now specifically
allow for things like "first, run autoconf if you don't already have a
configure file", etc.

-K
