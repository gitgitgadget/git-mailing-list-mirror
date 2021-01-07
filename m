Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82204C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAA023125
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAGH4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbhAGH4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 02:56:24 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1CAC0612F5
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 23:55:44 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y25so1974316uaq.7
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 23:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvNi3qQREBEVoRUoNCJ5bMHkO2mznRXTZ+pHQupCYog=;
        b=WmGf3nceu+gHDo/TJ60foTlCfis1siE2csYT/qkkTci5ZZKkEoqjzrA2oZ06iOXidL
         afZymDZf69pxaOKkxaS5Dv75egPBSaPYqaHjmnttrLtdaMMOZCllWtDTs13IxgtJKfJc
         Jdxpq0o7lcYfoCOXsd39P3gThZpzNNvdVPulF+a0iSf3ODzGALYcNkSChJyg62UjbEpS
         5CJHwL4azXj/S18kajFVcDAlDqIdNU1ssqbcKaff0v7UcQnLTuxIU1wp8gM7jAUUWLj9
         rwtKgGOb7wN7hqbpLNQiCDTUactHjbvw1n6tNzAFm+rQ/R6DWzl8OmvdR0XYGHBkhw9Q
         QQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvNi3qQREBEVoRUoNCJ5bMHkO2mznRXTZ+pHQupCYog=;
        b=aunr5mNVVj+08zOUO8hu1acS6fGBsjoqcOQzm2t/RA6xFl/M6Ar0V/xjtEvY7lhXM9
         6ebmZGvOX9bfFx02H2eHqLVjcrx1mFlGyIItjjq6NMQpkt3p5a/3zt+0ik6DXG/In+Pa
         SFEO0FZBv/P0q/3VkFpb2OSSPG2EE/hffucbwZP3gLVSNsMgKEZzHXujAw4Cm9mRbAW7
         SUuG5dd7P+Vy10epX9YonPD02P/ULsI3fDCIhHWl9qeivWBM3Yz98CB66eqsECn1CJWK
         xmShNiHCuRCZuTJojdntTlTYB5uytIRZyt5Zt0JXFHy4KkTB8sWZAqjNKaIYhrpM+9hh
         mi4g==
X-Gm-Message-State: AOAM532xyokrxNHjddSbK2Rny/MycUTUjdlf0CnB8C1eTAXDINExRfsj
        ZZH3XGjEAy9FmdZCgPT4dsNVNO9LHcoFkOf8UYo=
X-Google-Smtp-Source: ABdhPJw9qhO70dFCAqgOeeous20zOfcQqGM9aUU5JKi7zdImvFphBgJviR2U8N8WSBnIotx5jsXqSJkWFovagBf9sC4=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr6477155uad.15.1610006143251;
 Wed, 06 Jan 2021 23:55:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609874026.git.martin.agren@gmail.com> <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
 <xmqq5z4as2j9.fsf@gitster.c.googlers.com> <xmqqim89pu9k.fsf@gitster.c.googlers.com>
 <8ae92e79-ef13-3faf-2fc2-d4b107e73c36@gmail.com>
In-Reply-To: <8ae92e79-ef13-3faf-2fc2-d4b107e73c36@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 7 Jan 2021 08:55:32 +0100
Message-ID: <CAN0heSqdphJWgG6gLM4a8mrDLh6qGUVq5w2FYAr7g8uePrcd2w@mail.gmail.com>
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Jan 2021 at 03:08, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/6/2021 5:36 PM, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > I liked what I saw.  The code after these patches got certainly
> > clearer.
> >
> > But it was not quite clear what I was *NOT* seeing in these patches.
> >
> > IOW, how extensive is the coverage of these patches?  If we renamed
> > the .tempfile field to, say, .tmpfile in "struct lock_file" in
> > "lockfile.h", for example, would "lockfile.[ch]" be the *only* files
> > that need to be adjusted to make the code compile again?  The same
> > question for various fields in "struct tempfile".

To be perfectly honest, I just grepped around. I just tried your
suggestion and it seems like I really did catch everyone who looks at
`->tempfile` or `.tempfile`.

I could add a remark in the commit message of the last patch along the
lines of "After this commit, renaming the `tempfile` field only triggers
compilation errors in lockfile.[ch] and this one instance that we're
intentionally leaving here.".

> There was a note in patch 5 about how do_write_index() takes a
> tempfile instead of a lockfile, because sometimes the index is
> written without a lock.

Right, so outside of lockfile.[ch], that's the one spot where I needed
to do s/tempfile/tmpfile/ to be able to build again after trying out
Junio's idea. (We could have `get_lock_file_tempfile()` but it feels
funny to me to have an API for leaking the implementation. Just having
one user who needs to access the internal tempfile also sort of argues
for punting on introducing such a function, to me at least.)

I did on purpose avoid doing the same "don't peek" for tempfiles,
because I sort of assumed it would be a much deeper rabbit hole. Except
for in the last patch: In read-cache.c, the use of tempfiles/lock files
is intertwined/entangled enough that I felt silly modifying the spots
where we use lock files without doing the exact same cleanups to
tempfiles.

I just tried quickly renaming `fd` of `struct tempfile`. There aren't
*too* many hits, but from a quick glance it seems like some of them
might want a more informed rewrite of the logic to express intent even
better. For example, rather than grabbing the `->fd` using the "proper"
function and handling it sort of as a boolean, it might express intent
even better to not grab it at all and instead explicitly ask "do we
hold the lock?".

I'm tempted to promise I'll try a similar round of cleanups for tempfile
users, rather than rerolling and turning ~5 patches in v1 into ~10 in
v2, especially when those might be slightly more invasive. Hmm?

> I think the only way to enforce this is to make 'struct lock_file'
> anonymous in lockfile.h and actually defined in lockfile.c, assuming
> that's possible. It seems like external callers would only be able
> to declare a pointer to one, but without access to sizeof(struct
> lock_file) these callers would be severely limited.

I've never used coccinelle, but I'm guessing it might be a decent fit
for the problem. Either by encoding all 10(?) "don't do this, do that"
or if it's somehow possible to more generally say "don't look at
lockfile{.,->}tempfile". We'll obviously need some allowlisting as well.

Thanks both for your comments.

Martin
