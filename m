Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519E8C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiBHBF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbiBGXCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:02:09 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144DC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:02:08 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 13so12300600qkd.13
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1blxxYPLjMyWvmvRXnEcDMEn+4s+7F/gR9e2/c4wPZs=;
        b=PwDdOyZi+b8iKCdft6sEzSHFw8Yn/6b2VtxNdxusAia9fpSbZwfoZrh8EocwG52D6j
         7pVCLRuB8RXcQO7SUCKe7ldaSc1OMGrsgw9+etnG/InrCzqI3X5XjLy0TvDHgT87ygMM
         a8I3KW5RFkJI0heOsao6JPNaLis5D3FNz70aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1blxxYPLjMyWvmvRXnEcDMEn+4s+7F/gR9e2/c4wPZs=;
        b=vXTXB+e9bdcr8j2n/Q30o7WIEDBdXnRrtlofVxj8In6kjLRdQj5G7hNXXEZiBZ7mJQ
         dhnEPPlvSNoq96grJQJzevNJYkALZ92i9MVJPLxGWw6o/BAeQ9tymjok6f0y3cZluK8y
         AFhIZlGmPFK7otnuo3arJ4jVJGjhIcuB5LfiZuc6zFKMaxhmIks1SXcFrKe122XPCfqp
         wnPPkBOdVRYLIS2N9ikKxyvOjeAg83+qv3Y+xlzhbuS+k9/333BMWYFsrvqAGwEe7j+L
         M4OUU72MRgsc0SrCFyqn5eyqQlJLosHE79znVzQ4SApkCpcSrHu6Acs8ovlgjz0SpEOW
         MrKg==
X-Gm-Message-State: AOAM531YWmQ6DjWvJbfCkXtmOIRs0lI+kqrjzk8C1yRHXMYuR7zRsb0W
        iDzSNV9GTGYNlrOGwRY4hfQaMQ==
X-Google-Smtp-Source: ABdhPJwR4F0paTVoEjOdfHXcPz0v5jDeUcZFpM3NQg2yK7RgM0dmhx0gQ6iA7YtGzPxBynZEO1UXqA==
X-Received: by 2002:a05:620a:2809:: with SMTP id f9mr1215049qkp.527.1644274927445;
        Mon, 07 Feb 2022 15:02:07 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id l9sm6331920qkp.38.2022.02.07.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:02:07 -0800 (PST)
Date:   Mon, 7 Feb 2022 18:02:05 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Message-ID: <20220207230205.m5dibcb52u7qemq4@meerkat.local>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
 <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
 <xmqqee4fix0l.fsf@gitster.g>
 <20220207133244.kpyczjsxriepjtdt@meerkat.local>
 <xmqqczjyiecs.fsf@gitster.g>
 <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
 <xmqqzgn2gumr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgn2gumr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 07, 2022 at 02:49:16PM -0800, Junio C Hamano wrote:
> Given a signed commit or a signed tag that points at a commit, your
> enhanced "git archive" would create a .tar file with the contents of
> the tree object, and adds copies signed objects that tells what tree
> object the archive ought to have.  E.g. if you start from a signed
> tag, "git cat-file tag $tag" output would allow you to learn the
> object name of the tagged object, and to verify the PGP signature
> embedded in the tag, but it is likely that the tagged object is a
> commit, not a tree, so you'd also need to include "git cat-file
> commit $tag^{commit}". 

Correct, unless it's a snapshot of a signed commit, not of a tag (cgit, for
example, makes them available for download). In this case we only need to have
the cat-file contents of the commit.

> So you'd store the raw contents of the tag
> (so that we have a hash-protected record of commit object name), and
> the commit (so that we have a hash-protected record of tree object
> name).
> 
> You as the recipient will find these in the tarball:
> 
>  - the files that are supposed to be the contents of tree X.
> 
>  - the raw contents of the commit C that is supposed to record the
>    tree X.
> 
>  - the raw contents of the tag T that is supposed to point at the
>    commit C.
> 
> Starting from the contents of tag T, which is PGP signed, you know
> that the signer wanted to call commit C with the name of the tag T.
> Then the raw contents that alledgedly are from commit C, you can
> "git hash-object -t commit" it to verify that it indeed hashes down
> to C (hence, it what the signer wanted to give you), and find the
> name of the tree object X the commit records.  And when you added
> all the blobs contained in the tarball (and nothing else) to the
> index and ran write-tree on the resulting index, you would know what
> tree object the tarball contained, and if it hashes down to X, you
> know that the cryptographic hash chain starting from PGP signature
> on T attests that that tarball matches what the signer wanted you
> to have.

Exactly right. It would be slightly more complicated for things like openssh
signatures, since then you have to worry about where the allowed_signers file
comes from, but these are implementation minutae. Even if we start with just
support for PGP signatures, that would already be a great improvement over
where things are with snapshot downloads right now.

Best regards,
-K
