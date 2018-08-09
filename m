Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA5F1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeHIUSe (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:18:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34929 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeHIUSe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:18:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so5901769wru.2
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pPt/IE97ibymATQMnuek3VQLugXA17lAswiCVv5XapQ=;
        b=L/vzovM9O0e9hid6J6ENBlFMZulRNBIiaJpeDQY2IITQPDK1C5LsbOa/g8xATTYFev
         mUdxPN1Jl1z/xMXQeupX337BH9m6Z4tig37uSfeUTd6NJEhudsQd5BLbcq1crXan2r8/
         xTqoNmXU0dSbp5qWICgFVfjmsq3cU59yQaLODuzScFEPnrQ0AUCZ+7K820gtqbD0EcgV
         KMgEIrCDeBglRExnOl40KWz9WZV5PPUlme+fBg57KvEgVV0KEj8IUV88CVkCxl3dHIEM
         nv7t38rHyfMMuFrBSSicuqCWztGpVT+VodEXt7a1lBUgZllEwhaQeHG3xpwRPIfW/VuF
         BNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pPt/IE97ibymATQMnuek3VQLugXA17lAswiCVv5XapQ=;
        b=W96GNFao/pMH1JBNfAWbp9xmL7F3v+lOE/2+kEOHUsonXKc/H+cl83f+WnI2JFMw1M
         bLED81K6LSnByUjXCGO5HuH7dNOVGQsoCEd5WORR/RUM42E6sKl3vW9y9pf6L9eC0K+l
         VCJ3LLC2dYk0HDk+9U2y808e+hkOVOwh/S5Dv8Yh8sNYXgqzcak2fCoXgBY9smKeneXg
         3kfWAKiTZ3//L5yNmq5Zeodo+QQRjfG+Q6gNoY7K6qCbBnGxaGt62aVsP3+Hg02yX3uw
         u6p4O1kzLTp++P3QJj33lwbm5rCe0jdg0JIxyvnYmtotLsQPP/3No4+8Zk1UBMMZXwOJ
         AExw==
X-Gm-Message-State: AOUpUlGHEhacd8/Z7Y3fQeUbuzpOrtwx2D2+AtR44ip6DYbG6tqg9hIv
        VbLRo/HJV5udDST5gCJzsKc=
X-Google-Smtp-Source: AA+uWPyGFzUWamPGnpeuCHrQWaZTZUCRfKMH/0M87EXhRcUpPaZNjVzBDaVzhjoxUfDfMfStuRdCfA==
X-Received: by 2002:adf:9ac7:: with SMTP id a65-v6mr2043838wrc.125.1533837155638;
        Thu, 09 Aug 2018 10:52:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a184-v6sm8604191wmh.41.2018.08.09.10.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:52:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/WIP PATCH 0/3] Modifications to handling of non-textual file merge conflicts
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
        <20180806224745.8681-1-newren@gmail.com>
Date:   Thu, 09 Aug 2018 10:52:34 -0700
In-Reply-To: <20180806224745.8681-1-newren@gmail.com> (Elijah Newren's message
        of "Mon, 6 Aug 2018 15:47:42 -0700")
Message-ID: <xmqq600jctr1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> 1) Representative example: A modify/delete conflict; the path in question
> in the working tree would have conflict information at the top of the file
> followed by the normal file contents; thus it could be of the form:
>
>     <<<<<<<< HEAD
>     Conflict hint: This block of text was not part of the original
>     branch; it serves instead to hint about non-textual conflicts:
>       MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
>     ========
>     Conflict hint: This block of text was not part of the original
>     branch; it serves instead to hint about non-textual conflicts:
>       MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
>     >>>>>>>> BRANCH
>     Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
>     sed diam nonumy eirmod tempor invidunt ut labore et dolore
>     magna aliquyam erat, sed diam voluptua. At vero eos et
>     accusam et justo duo dolores et ea rebum. Stet clita kasd
>     gubergren, no sea takimata sanctus est Lorem ipsum dolor
>     sit amet.
>
> Alternative ideas for handling the explanatory text here are welcome.

In a modify/delete conflict, we currently do not leave any in-file
clue, so smudging the modified side like this might be a change that
helps those who "grep e '<<<<<<<'" to find the set of paths that
need to be examined.  I personally do not feel it would be all that
useful, as "ls-files -u" is how I'd learn about these paths.

What I would want to see when faced to a modify/delete conflict is
how the modification side changed the contents, as the change, or
its moral equivalent, would need to be ported to other locations in
the context of the deleting side.  But I am not sure if it makes
sense to attempt to somehow include "diff HEAD...MERGE_HEAD" (or the
other way around) in the file to show the contents change on the
modification side.

> 2) Representative example: A binary edit/edit conflict.  In this case,
> it would be inappropriate to put the conflict markers inside the
> binary file.  Instead, we create another file (e.g. path~CONFLICTS)
> and put conflict markers in it:
>
>     <<<<<<<< HEAD
>     Conflict hint: This block of text was not part of the original
>     branch; it serves instead to hint about non-textual conflicts:
>       BINARY conflict: path foo modified in both branches
>     ========
>     Conflict hint: This block of text was not part of the original
>     branch; it serves instead to hint about non-textual conflicts:
>       BINARY conflict: path foo modified in both branches
>     >>>>>>>> BRANCH
>
> This file would also be added to the index at stage 1 (so that 'git merge
> --abort' would clean this file out instead of leaving it around untracked,
> and also because 'git status' would report "deleted in both" which seems
> reasonable).
>
> This type of example could apply for each of the following types of
> conflicts:
>   * binary edit/edit
>   * any of the conflicts from type 1 when binary files are involved
>   * symlink edit/edit (or add/add)
>   * symlink/submodule
>   * symlink/directory
>   * directory/submodule
>   * submodule/submodule
>
> It could also apply to the following new corner case conflict types from
> directory rename detection:
>   * N-way colliding paths (N>=2) due to directory renames
>   * directory rename split; half renamed to one directory and half to another

Hmph, I am starting to wonder if it may be easier to access if
instead you did not touch any working tree file to do any of the
above, and instead write a single file in $GIT_DIR/ to explain what
kind of conflicts these paths are involved in.  That would probably
give a better and easier-to-read summary than "ls-files -u" output.

Or do we have _enough_ information in the "ls-files -u" already to
infer "Ah, we are in symlink edit/edit conflict.", etc.?  If so,
perhaps "git status" can be extended to show what kind of conflict
these paths are in by reading the higher-stage index entries (and
lack of stages thereof, when dealing with a conflict with deletion
involved)?
