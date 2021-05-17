Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0CC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B64E61242
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhEQMn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbhEQMnY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:43:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83313C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:42:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a11so3066160plh.3
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/sZsR/wTaRxV2nvbNRuJXi45U7aPfOXZbHGq4kAGhs=;
        b=dbOHKpFygnD78ir119AKZa5wljCii+zx+MR1XA9Y63vk3iV5Yh/4F3tzvKEPotO6Xm
         sRc8fgnsX6b0hUVrNWCE/Kk13cMD1FSDWcyArDjsK2WGDdJtwLUboAmJcPLEvBrwnp21
         E42zCixEdZg7F9eynOv/KaQ6M0rrxKclCEKGeqaawZG7oLSsdDvNjczOurcP8ddwSMHa
         TDt3w4bNnpG3vpd/8FMZmAQW27XOA3QBLzEBxGHz2o2Txcouf5rsoliMZxMg3Xrw84QR
         8ViY3dVWTwKC43PR8iyEJ5nZj8OaAAL7AJE79ZQGdjGRXvGHdj7iMj9/Bi+MhCmOv6YH
         sbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/sZsR/wTaRxV2nvbNRuJXi45U7aPfOXZbHGq4kAGhs=;
        b=iWSUjDkZZFPPx9Q3msDFGbADOMRVn0P52ENOgAA3EvgSTAuV6hWwPgrNCco5rIRJg1
         MxCLe2I9NZgU6bLkQHF6FSLghnGM0KntTBd8PqrAr6BQCxhLarrCACV6GS0/kjd8MSfv
         t7oyxYY6q+K2y3b3R/UMjIa+HUBfbh+hUQ9F2R17f92hJvR9XQ1ko6kXLhOIOGG0cITv
         svV8JRio3i5dmIAFALNwn8tu4Ejj4dVnF/0jYIlwKNfj2IONQUFVqgmKt7cbIn71DHn0
         iujpW80Nn5fBmdF8X6TaCZVxgWr5McWwlsjL+4p6kmV1RWGWIDizj7MQwZfzQlZlLjJA
         7N9g==
X-Gm-Message-State: AOAM533r08junExCAGtkyM2sTLo9Ea2XYHbP9Z20YXNfcxz6hzpaFkPT
        D1lJLymocRabLAgpwYMVHd8=
X-Google-Smtp-Source: ABdhPJwcBo9jwxDeEbVWzZ4tAwm5UeGCCNoFsQspHBYR9e8EncFExUSI5UZ64PG4K0qPHHglTA57+A==
X-Received: by 2002:a17:902:8f85:b029:ee:f8b1:8666 with SMTP id z5-20020a1709028f85b02900eef8b18666mr59902174plo.31.1621255326043;
        Mon, 17 May 2021 05:42:06 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id u6sm1747206pfk.177.2021.05.17.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:42:05 -0700 (PDT)
Date:   Mon, 17 May 2021 19:42:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
Message-ID: <YKJkmws18M6oJZXy@danh.dev>
References: <87r1iakbyn.fsf@osv.gnss.ru>
 <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
 <YJ3LJ++lsAuSkCUJ@danh.dev>
 <875yzlu8gt.fsf@osv.gnss.ru>
 <87zgwtr7i4.fsf@evledraar.gmail.com>
 <87k0nxv8tt.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0nxv8tt.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-17 15:33:18+0300, Sergey Organov <sorganov@gmail.com> wrote:
> >> Probably add generic cmd.<cmd>.opts config support, so that I can say:
> >>
> >>   git -c cmd.rebase.opts="--no-fork-point --empty=keep" pull --rebase
> >>
> >> Thoughts?
> >
> > It's been discussed before (but I did not dig up the discussions,
> > sorry). It's been considered a bad idea, because our commands are a
> > mixture of plumbing/porcelain commands and switches, so we want to be
> > able to reliably invoke say ls-tree with some switches internally,
> > without config tripping us up.
> >
> > Of course we could make this sort of thing work by selectively ignoring
> > the config, but such a thing would be equal in complexity to the effort
> > of assering that it's safe to introduce new rebase.* config in the
> > codebase for every switch it has now, but with a less friendly interface
> > both for git itself and users.
> 
> I don't see much complexity here. We'd then just need to effectively
> invoke ls-tree internally like this:
> 
>    git -c 'cmd.ls-tree.opts=' ls-tree
> 
> Not a big deal.

It's a big deal.

Scripts was written with plumbing command and expect stable output.
If such change can be accepted, a lot of scripts will begin to fail.

> > I.e. instead of rebase.noForkPoint=<bool> we'd need to to getopt parsing
> > on some cmd.rebase.opts string.
> 
> As this is meant to be generic, then yes, every command will first parse
> corresponding config option, then command-line options, rebase not being
> any different.
> 
> >
> > I don't see why in this case what I suggested elsewhere in the thread
> > wouldn't be viable, i.e. you specify --rebase or --merge to "pull", and
> > that affects how we interpret the rest of the options. I haven't tried
> > it though, so there may be hidden gotchas there I haven't thought of.

I didn't follow that sub-thread. However, I think we can extend
git-pull with a dedicated option prefix for options that would be
passed down to git-merge or git-rebase.
Sililar to -W of CCLD (as in gcc -W,--as-needed)

-- 
Danh
