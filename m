Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004B3C4707A
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 13:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiBGNsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387380AbiBGNct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 08:32:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6920C043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 05:32:47 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id fh9so3463531qvb.1
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/TBBB1yMHv/D8mmynzCdQ4Gr+0DJyea1oNgkvTRQ+90=;
        b=fOlOoYPDgZYTVzPuJT3RDEPh4IslAUebWbs/9PCnAE5CsEhctN1B56uIHXJqFgtMMD
         jC4lKA8kuLwWCROtTEZI/BA2gY76rRxJL1ZrJMf1y7GhKI0brie0GlS9vmoblqeJUUqA
         1+0soMJ4q2i/ZzEjDYCVL7Wt4+32rMEncu+u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/TBBB1yMHv/D8mmynzCdQ4Gr+0DJyea1oNgkvTRQ+90=;
        b=xeaIOdurrbvSj4mOKzDT+WRAJ+zjYcwQ6neQlXinsMYBVdUXIC7k9FFC6V4OEQDgnJ
         h24WY5Vky9XPpe2hrtNzA+G517QIIv3jK3td8LTN289JhnrB1tL+S9cTIB4GlPI5VRWT
         UWbYLWtEv31iv3PMvr5VWzNvJ93ARPAcKvk9cWOHx2xDEp8Of1f1bAkA8OBWtvfP1N30
         3CTkSZ6adScb6K6bGa8fV+DovzMw86Du+KI8j/th6DgDAEq5k3kMLD+aFm1I6v2NaIdh
         qixfGOgdWEbPOIpSM4rALQMfMvkk2B3ruOeEcbyA21HcOL2epsQLOBZzICgUhNL0mrDl
         AAww==
X-Gm-Message-State: AOAM532CiglJfNqomXy8XMvcHwP9yPkVx6Nsa24She+uAuuTRSjUFJCy
        TzsK2gayvpgizCIdVQ/ph0yuSw==
X-Google-Smtp-Source: ABdhPJwxc9EVtYuMlHYnDVXpneEoyUaYHhYiky1qavBA0IOGT35jQli2/xJTmYaqSqPRPC5XdC6WXw==
X-Received: by 2002:a05:6214:19ce:: with SMTP id j14mr10719306qvc.43.1644240766931;
        Mon, 07 Feb 2022 05:32:46 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id s1sm5742513qkp.40.2022.02.07.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:32:46 -0800 (PST)
Date:   Mon, 7 Feb 2022 08:32:44 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Message-ID: <20220207133244.kpyczjsxriepjtdt@meerkat.local>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
 <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
 <xmqqee4fix0l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee4fix0l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 06, 2022 at 12:02:34PM -0800, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
> 
> > I think part of Todd's question was how the tag and uncompressed archive
> > 'checksums' (e.g. hashes) relate to each other and where those
> > guarantees come from.
> 
> There is no such linkage, and there are no guarantees.  The trust
> you may or may not have on the PGP key that signs the tag and the
> checksums of the tarball is the only source of such assurance.
> 
> More importantly, I do not think there can be any such linkage
> between the Git tree and release tarball:

Hmm... I've actually considered writing a tool that would verify whether a
tarball corresponds to a signed tag/commit. It should be entirely possible,
no?

1. list all the files in the tar archive and calculate their hashes
2. use that info to rebuild blob and tree hashes all the way to the top of
   the archive tree
3. verify the signature on the git tag and obtain the corresponding tree hash
4. compare the in-git tree hash with your calculated archive tree hash

It would be slow, but it would be perfectly workable. I didn't end up writing
that tool mostly because if you already have a git tree to run "git
verify-tag", then you might as well just run "git archive". :)

The only cases where doing the above would make sense would be specifically
for forensic/verification purposes.

-K
