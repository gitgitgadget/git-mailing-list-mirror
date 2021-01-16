Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE5FC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 03:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3614323A03
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 03:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbhAPDXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 22:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhAPDXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 22:23:38 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12586C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 19:22:58 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a6so7568553qtw.6
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 19:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Kw/ozimtYOgoScJLIEo8tydYe0gl81mXp3k0B3FGeE=;
        b=0Q8TKpAXcrjG/ssUb5wU2w1CAYzh4lwExs8clYRTJU+ZZ0BM2YqkKVzUNCvs9sE85c
         hm6Tnn7wxTdKDhGoVHIIzEyy6ncDXhyiF5MmWG+pblfXk2uISYLYX3ynXJ1Z8kARMc38
         93KfMtrQkwCfdwNONJ3ODaeq1JeaNC/9RlGjCqTtLU3/v+76DKNOScZvVktADAYe5VeE
         PkX+EL6JMCeW+i7jYDnh9kQ5gbqOluVc64akl8ChzDbK3g7lv5J1T44xQyT9xR9qgPuv
         IFj7/BGTmOMUW40JGQlkjahmwUiWbFJiYVrrQhBxXGiZZ5tXKwvuSnn6841HtZyuj+uH
         KlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Kw/ozimtYOgoScJLIEo8tydYe0gl81mXp3k0B3FGeE=;
        b=RXHmjWcvOlIGgAY+DDFOanqkjzOXDVezyhfkOauP1Jk8YTU6JZyGlfXky1O/UyKwhP
         emfZJRCvXKlEmWoV27QcpBZwmCqNj1s2AHFMoya/BVquWYHJKYSP5iHMnwTVJnlj1IeT
         D99C/qi6Bnkkv8et+TncffThUE6Y1CvtUs2jNCU1Mbtmm3xbK5V30Vq7aB+DhVH6F2ZS
         StyAlZqKlWXZJHndQDtmwSwUpr9RQZHYh/L/26Zci9IpCsDHMxd5HRIiVT2nC8PyaK3E
         +jwcF/0lTzZ6uhUI0FRCLgFWsFgyoUxMutUF2zomJiNt4OFhpZ08Mz8PZ3DYNMsfVl2m
         O9Ww==
X-Gm-Message-State: AOAM530SR+jTNtmu05tTcLjfRZVweTZba1klwI88Ky7oDG+biPbEecp5
        mMUoeiD6noD5SXxpncJjwUx25Xo9vNBZrg==
X-Google-Smtp-Source: ABdhPJwy4GutsNYNdakU202wQrLx5SQb5M1G8YkxowmvnJob4pwUP/f5ycripH6bnbrpFaNBBSAJ6w==
X-Received: by 2002:ac8:44a2:: with SMTP id a2mr14786253qto.91.1610767377198;
        Fri, 15 Jan 2021 19:22:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4081:f2ff:d6a2:cb33])
        by smtp.gmail.com with ESMTPSA id j203sm6227610qke.134.2021.01.15.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 19:22:56 -0800 (PST)
Date:   Fri, 15 Jan 2021 22:22:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: RFC on packfile URIs and .gitmodules check
Message-ID: <YAJcDr0EPkKk0aR/@nand.local>
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <xmqqim7xraeo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim7xraeo.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 04:30:07PM -0800, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > Someone at $DAYJOB noticed that if a .gitmodules-containing tree and the
> > .gitmodules blob itself are sent in 2 separate packfiles during a fetch
> > (which can happen when packfile URIs are used), transfer.fsckobjects
> > causes the fetch to fail. You can reproduce it as follows (as of the
> > time of writing):
> >
> >   $ git -c fetch.uriprotocols=https -c transfer.fsckobjects=true clone https://chromium.googlesource.com/chromiumos/codesearch
> >   Cloning into 'codesearch'...
> >   remote: Total 2242 (delta 0), reused 2242 (delta 0)
> >   Receiving objects: 100% (2242/2242), 1.77 MiB | 4.62 MiB/s, done.
> >   error: object 1f155c20935ee1154a813a814f03ef2b3976680f: gitmodulesMissing: unable to read .gitmodules blob
> >   fatal: fsck error in pack objects
> >   fatal: index-pack failed
> >
> > This happens because the fsck part is currently being done in
> > index-pack, which operates on one pack at a time. When index-pack sees
> > the tree, it runs fsck on it (like any other object), and the fsck
> > subsystem remembers the .gitmodules target (specifically, in
> > gitmodules_found in fsck.c). Later, index-pack runs fsck_finish() which
> > checks if the target exists, but it doesn't, so it reports the failure.
>
> Is this because the gitmodules blob is contained in the base image
> served via the pack URI mechansim, and the "dynamic" packfile for
> the latest part of the history refers to the gitmodules file that is
> unchanged, hence the latter one lacks it?

That seems like a likely explanation, although this seems ultimately up
to what the pack CDN serves.
> You've listed two possible solutions, i.e.
>
>  (1) punt and declare that we assume an missing and uncheckable blob
>      is OK,
>
>  (2) defer the check after transfer completes.
>
> Between the two, my gut feeling is that the latter is preferrable.
> If we assume an missing and uncheckable one is OK, then even if a
> blob is available to be checked, there is not much point in
> checking, no?

I'm going to second this. If this were a more benign check, then I'd
perhaps feel differently, but .gitmodules fsck checks seem to get
hardened fairly often during security releases, and so it seems
important to keep performing them when the user asked for it.

> As long as the quarantine of incoming pack works correctly,
> streaming the incoming packdata (and packfile downloaded out of line
> via a separate mechanism like pack URI) to index-pack that does not
> check to complete the transfer, with a separate step to check the
> sanity of these packs as a whole, should not harm the repository
> even if it is interrupted in the middle, after transfer is done but
> before checking says it is OK.

Agreed. Bear in mind that I am pretty unfamiliar with this code, and so
I'm not sure if it's 'easy' or not to change it in this way. The obvious
downside, which Jonathan notes, is that you almost certainly have to
reinflate all of the trees again.

But, since the user is asking for transfer.fsckObjects explicitly, I
don't think that it's a problem.

> As a potential third option, I wonder if it is easier for everybody
> involved (including third-party implementation of their
> index-pack/fsck equivalent) if we made it a rule that a pack that
> has a tree that refers to .git<something> must include the blob for
> it?

Interesting, but I'm sure CDN administrators would prefer to have as few
restrictions in place as possible.

A potential fourth option that I can think of is that we can try to
eagerly perform the .gitmodules fsck checks as we receive objects, under
the assumption that the .gitmoudles blob and the tree which contains it
appear in the same pack.

If they do, then we ought to be able to check them as we currently do
(and avoid leaving them to the slow post-processing step). Any blobs
that we _can't_ find get placed into an array, and then that array is
iterated over after we have received all packs, including from the CDN.
Any blobs that couldn't be found in the pack transferred from the
remote, the CDN, or the local repository (and isn't explicitly excluded
via an object --filter) is declared missing.

Thoughts?

> Thanks.

Thanks,
Taylor
