Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0046C433E2
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777ED2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh+QEdya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbgEMUGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388012AbgEMUGH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:06:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127DFC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:06:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z80so712138qka.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LCAhc1B9STU2Tma8D54li74+C+mRZyUyo6xDaafiIo=;
        b=dh+QEdyaZGSbivTDkM9VIIpxwGKjW4okN6OBzZ/pY/o2g5EjMvSoVo2j+mCr1GZLig
         o9SRF44llT3om5LOR3QqosLNlABoIYcSfYbV/rYlQOyfqIWLa6Fe4IW4rfL8pC9Cy5Q+
         V6VgXz6GqOCbdRP9Ud7vfjJNZlc8elE9tuqLWvWKcSfyQ0IYM04gLJg2h3PD4v3oI8/C
         nCKvIpZzJ3/ll7456O5J40uDKNWGyZ/L2+Xf7JadghYmWORCeWXsZhjhyuWk+jTqC2z9
         DgI4d8Pcg3svc/BK6tQ57HD3p33EcMy7+K2TjM5AVQ5jSBZ0pzgjVUYpoNK7vwPJojEo
         nO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LCAhc1B9STU2Tma8D54li74+C+mRZyUyo6xDaafiIo=;
        b=EVb3v/iomUJ+7u6ZQq7haohv9jYLZlwOOmc8m9WBjA1teLS3Uq1mfuED4dGVMuRMuF
         H0rmiq0uW+EGZyKWm0sXU6ZR0+r7fGipwjPucIudNCpAF2AqOdxdxZTkRb6w4H6/KkUZ
         UnIFplP0jVDD+9zKxQgA+7X5LkHLqQLEO6J60u6CUBq2WL2kSCQpRj7pt0TuhWeGcH0X
         X2iyWx0FcbyX05Frmh56DU4T8uUk6x8AGVMJtXQ4FoD/E+xS9prZJdi5YRLlZjzS5mBa
         Q/KrsqzO0ShMCky0gXbriV8h8q4+sM0f1ZPwrp7aDRYWmxgcqLhL8JgsJwIu+cS47zBU
         A1PQ==
X-Gm-Message-State: AOAM531oyx9meXQ3tUP+d2XZuAW8TiF9Q6969jImRYU9qMBigbuOvcKH
        b1l1KdPA8l08B0aaOHw3VilIIhbEPgkjj0sfCG8A2A/t
X-Google-Smtp-Source: ABdhPJwB58Aa+iAog286NrY85OYoizbxDABZIiH9hGr1sAvvgds6NZJBOHNi7QXz8IV+DZLPg2r3f+zIcwZlIZdjjHA=
X-Received: by 2002:a37:b847:: with SMTP id i68mr1410549qkf.431.1589400366339;
 Wed, 13 May 2020 13:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
 <xmqqblmsc0r1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblmsc0r1.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 01:35:57 +0530
Message-ID: <CAKiG+9VrKsckfnJiaf1xMYnOtJ6wvnbtZv4-3sz6H7h3aZH3Cg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
>
> s/added/add/; give a command to the codebase to "be like so", or a
> command to whoever is typing changes to the editor to "make this
> happen".
>
> > The CMake script now checks whether st_blocks is a member of struct stat
> > and set the compile definition NO_ST_BLOCKS_IN_STRUCT_STAT accordingly.
>
>         Teach the CMake script to check ...
>
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 4353080b708..975791c8b89 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -22,6 +22,7 @@ project(git
> >  include(CheckTypeSize)
> >  include(CheckCSourceRuns)
> >  include(CheckCSourceCompiles)
> > +include(CheckCSourceRuns)
> > ...
> > +#check for st_blocks in struct stat
> > +check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_STAT_HAS_ST_BLOCKS)
> > +if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
> > +     add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
> > +endif()
>
> All of these compatibility stuff makes sense, but how do we decide
> where to draw the line between the checks we saw added in [01/11]
> and the checks added here?  It feels pretty arbitrary to me and if
> that is the case, perhaps we want to move all the "add checks" to a
> commit separate from [01/11] (whose primary purpose is to add the
> basic rules without these build tweaks in the file at the final
> place)?
>

The checks are added on a "demand" based the target platform.
In the future, if apple support is needed, we need to add ST_TIMESPEC checks.

Thank You,
Sibi Siddharthan
