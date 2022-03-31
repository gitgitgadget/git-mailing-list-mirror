Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB84C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiCaJqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiCaJqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:46:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAF63DA78
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:44:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c62so27486915edf.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9ixD92TpuBDTbsxDU4hA9zCL0qfTd+INvk9XT6XST7k=;
        b=HHg+qEitFdYyZbLf96LSgc/0sO5qKirqRJJFc3jm8cV696oc2pGNYYBkDZT2fb0po/
         mBhK5+j97IbzHassiT01apT/5qhl5e6vXgyrM5hG7XxGah5CMnSDlmtpva3PCVDXLdUy
         UqF+555hQuu7OMMGQ6ttgxt/WmchKuBA2VilsE0V4UN2N8qXb1qNkydrf8YlFHPoF5wN
         KzK3zGhhhXtd5qHskZQsnAWk7bdLKLJN0CvEsC36e6+5pHC72jFL95Y0win7zU+BLiRy
         FrOr/K+fN+f/Lalq2onYp/kGocr2fgUJWYC5jAOyesQGGG5t0pfB8WpKwW2XbQcrEUTM
         rMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9ixD92TpuBDTbsxDU4hA9zCL0qfTd+INvk9XT6XST7k=;
        b=q1yv7E7TmNXfow+VQFkHU7M5iGF3l67toqj+4SH6qHRLhQ+CjeW3sy40Gkzim+g9Jc
         28kQNvYbEP3JdJQHH2sDokPOmzU8cYSPeS5NB5XHY1+W2F7DSZ3Tu/Zda+G/6W/zo+RS
         iB1tcYZO/Bkfwa4XC5c4wz0LJR7VxexpfDrphA8vSDtKur4D0MgEcOR2EYKUU9Y6KqFN
         agOVwKQX5SJMoVQDk+hl37JoNiHcA1QmCByhmSx7stuU+p2wzEo8m7s/KA22gjpTLbq3
         kqZdJ2xASWY7srm940oQaOGbXMyYZuyJbyQAWiIr/wkAB1A9Mh/yu+7WkErk8gWSFY9L
         oYzw==
X-Gm-Message-State: AOAM530XwDuzC6g8ApFBnLtgklqU/XrdtQhWyHCwsuT5IP4aScy9Dlt8
        ccVNbasxgppTZkvBpit3LBs=
X-Google-Smtp-Source: ABdhPJyNGpn1VC41O90GuBZFiSN4W4VOdt3+TGF2Rhoy+YvIPCMx6x19QllaNXyUOMfK1sNjvOmeFg==
X-Received: by 2002:a50:99c7:0:b0:419:225:80b6 with SMTP id n7-20020a5099c7000000b00419022580b6mr15828406edb.240.1648719884367;
        Thu, 31 Mar 2022 02:44:44 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090651d100b006dfa26428bcsm9287227ejk.108.2022.03.31.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:44:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZrMB-000KVW-Di;
        Thu, 31 Mar 2022 11:44:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Joel Holdsworth <jholdsworth@nvidia.com>
Subject: jh/p4-various-fixups (was: What's cooking in git.git (Mar 2022,
 #07; Wed, 30))
Date:   Thu, 31 Mar 2022 11:41:36 +0200
References: <xmqqee2i50h9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee2i50h9.fsf@gitster.g>
Message-ID: <220331.86czi2sbg4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> Also, there are a couple of "git p4" patches, for which we seem to
> totally lack reviewers.  Help is appreciated, here, too.
> [...]
> * jh/p4-various-fixups (2022-02-10) 22 commits
>  - git-p4: sort imports
>  - git-p4: seperate multiple statements onto seperate lines
>  - git-p4: move inline comments to line above
>  - git-p4: only seperate code blocks by a single empty line
>  - git-p4: compare to singletons with "is" and "is not"
>  - git-p4: normalize indentation of lines in conditionals
>  - git-p4: ensure there is a single space around all operators
>  - git-p4: ensure every comment has a single #
>  - git-p4: remove spaces between dictionary keys and colons
>  - git-p4: remove redundant backslash-continuations inside brackets
>  - git-p4: remove extraneous spaces before function arguments
>  - git-p4: place a single space after every comma
>  - git-p4: removed brackets when assigning multiple return values
>  - git-p4: remove spaces around default arguments
>  - git-p4: remove padding from lists, tuples and function arguments
>  - git-p4: sort and de-duplcate pylint disable list
>  - git-p4: remove commented code
>  - git-p4: convert descriptive class and function comments into docstrings
>  - git-p4: improve consistency of docstring formatting
>  - git-p4: indent with 4-spaces
>  - git-p4: remove unneeded semicolons from statements
>  - git-p4: add blank lines between functions and class definitions
>
>  Various cleanups to "git p4".
>
>  Needs review.
>  source: <20220210164627.279520-1-jholdsworth@nvidia.com>

The tip here lacks a Signed-Off-By, but this otherwise looks good to
me.

I don't have a setup to actually test it, but aside from the import
re-shuffling these are all purely stylistic changes.
