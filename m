Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D42FC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FA964E7A
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBWS42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhBWS42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:56:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C7EC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 10:55:47 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e2so15123040ilu.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0weBwNBKemSlDJrizGDgjDuZKQC2Mo8tErZUQcYE2g=;
        b=l8jTL82hVPF6cvvbaPrpNGHfAA/eJvzUN8E30rq6A0spCKmf1Hn+l1ZOH01PIY6Ft0
         FaI4uYoc5al6s7zBVgc31F/Rs+zzSvc7PDr2CUrJrt3woVzi0ybn9+gHN970ainns7Ep
         h48uMNj1xWR8y/KpGDy83RXvd9Li6ezvIehtoIAX0u1VXKhUQrlIZMLMXeys7/ZWCFj8
         USVT76Mf/unPWUqoQAAGysGvWsvsi7BpdCVzCbJKCYEyl4ZniVBFTRB/bzqlQkL49fez
         ndTb1mWdCZZ9vtjvvM/lt1vkFGkEZpwPYPM9JdnnlRCmRl18aZ7/eylS3ZoMhE0TOfs1
         2lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0weBwNBKemSlDJrizGDgjDuZKQC2Mo8tErZUQcYE2g=;
        b=LjmFG3WRQaRVKIF/KapDMRe/1toJyiKesTK/SS9/VLGErUapW8H0J3UhjK9YsAjrwn
         vW0vyJbwugTAgw0wFfYhrr4JkF91PR8+zV49k5EblUYcqNCbIVFpS6IRSjKRZHaMAguL
         c9VykDQMT2lIh4TeeUYMTOGFldHNxjlllMVd+N/zfu7cxqZ9xX/qf8+kkO3prWN2RHPb
         zQczJXY1rliu5SQ/1AqX5VB/uPsIPjTRV/TKc4pB/EdHqdC0uIZfsAib/I20pVpKMpeu
         IcNJNMH0LNRYOKLLK+2oSk3n9dJlau3lG5T3P8l379BJaNYbMUbky7TDvXDCrYkA6vAM
         Fdjw==
X-Gm-Message-State: AOAM533wRBe/WWqeWuxXoUpr3uMJIwZGhXxk4G5aresf/yHJ9bIBvEgt
        H1N4aS9xFpxDuNtDiZr2j5teiEM0TNPZAJgiQGlzyulLZz0=
X-Google-Smtp-Source: ABdhPJzE78uKJeJ14i/lfwn8igXOmlNCd9yBybXyJ79/pE4cxb9UPMu95qQk9tmrYr40dyUV7T1qroXQOITBgFTyYLo=
X-Received: by 2002:a92:ab10:: with SMTP id v16mr21319256ilh.100.1614106547313;
 Tue, 23 Feb 2021 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20210214022840.849312-1-seth@eseth.com> <20210214022840.849312-2-seth@eseth.com>
 <xmqqk0r7rh7l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0r7rh7l.fsf@gitster.c.googlers.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Tue, 23 Feb 2021 10:55:00 -0800
Message-ID: <CAJDDKr7ibQH9fJEF2TuZ+S7cRFydX27d7sVvXt5bdfENqba_JA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mergetools/vimdiff: add vimdiff1 merge tool variant
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Seth House <seth@eseth.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 10:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Seth House <seth@eseth.com> writes:
>
> > This adds yet another vimdiff/gvimdiff variant and presents conflicts as
> > a two-way diff between 'LOCAL' and 'REMOTE'. 'MERGED' is not opened
> > which deviates from the norm so usage text is echoed as a Vim message on
> > startup that instructs the user with how to proceed and how to abort.
> >
> > Vimdiff is well-suited to two-way diffs so this is an option for a more
> > simple, more streamlined conflict resolution. For example: it is
> > difficult to communicate differences across more than two files using
> > only syntax highlighting; default vimdiff commands to get and put
> > changes between buffers do not need the user to manually specify
> > a source or destination buffer when only using two buffers.
> >
> > Like other merge tools that directly compare 'LOCAL' with 'REMOTE', this
> > tool will benefit when paired with the new `mergetool.hideResolved`
> > setting.
> >
> > Signed-off-by: Seth House <seth@eseth.com>
> > ---
> >  mergetools/vimdiff | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
>
> Any vimdiff$n + "git mergetool" users care to comment?  Thanks.

Nicely done, thanks Seth.

Looks good to me.  FWIW,
Tested-by: David Aguilar <davvid@gmail.com>

cheers,

--
David
