Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E9C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 05:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKVFmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 00:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKVFmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 00:42:13 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119921834
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 21:42:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q71so13148239pgq.8
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 21:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGc6hluevtIUh96rKgtlnma5iop3TNEPzTft9laFkSg=;
        b=VJ2K8aytmGo7EzytN8DzXciiVCSZ/dUmZQ6tPnxGU/a+FbQnAEwg/pKXUH2DyeHPix
         +adsjF08V6kqeBBnbRi9bNX/s4H6EZfY3tJJ0J3OK4HtWPt16a3j3gCm5tVyikPmZloT
         H1iFxseS2hWmWdpysO4d5ADFIJqcMbBUZicj+qycwLNpMtFK/HPhqRO/H2f2bXX2VLaf
         EZZcHtSHGGIHyKJ23b/rS/IxRHtaZEhAkh+j+aWo/JmNoyUmo9UrkyTlJ9KLAZdz+uWU
         q6TFTH9ajA1EBZGD6lcvS4TOHEALJweMnD9R/SMXBCmXgM4bbM05Jm3lb+H5jxISOkHF
         g6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGc6hluevtIUh96rKgtlnma5iop3TNEPzTft9laFkSg=;
        b=UsJFxXjubFxF4dVeUHbg7bEcfDjuxxkMlgjFFQwu/YNlwPBnxB9UyL28Zfob2PBMzE
         UiGHvEEdB4vFKs7u4NH7lXMlulhZAxIq+7sSvfxd5jqw3RALX1sL8sadirqlOTCoKwff
         CoI2BgSqtwDS5OdS8SD9euuSFxCpah/MSPmWMjYKtGzmMia2x2syQy22tIiMg5gXqkAh
         KjNbq7aYgl8/OT6e0Hy3oi2Ms0QV4/2z/n3SA5XEsei74w6bfnSy9/xNfDTEssHFGYm/
         UGiCuZ7HcyCWzTPS4A1xA6yuOBxkJYsx23PyUKKOe4eSOzZXg5jB733EtnJAPahO9+XI
         Fd0g==
X-Gm-Message-State: ANoB5pm9jJETQgPwn44Z7lZKqegohWI9jV9P33ZYa57096fOqJEfyDRS
        utNHbTqlZeoLI6Zj615RUb3nYM0AsdRfBA==
X-Google-Smtp-Source: AA0mqf4LetL6iynY61UqNT9k74UO7MbO2KCWuBeAAgvtSM9VtX/Q/pHT1hefvcf54otf6LM/Xs8N1Q==
X-Received: by 2002:aa7:8bc3:0:b0:571:8aec:ac4f with SMTP id s3-20020aa78bc3000000b005718aecac4fmr2454758pfd.78.1669095731779;
        Mon, 21 Nov 2022 21:42:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c5-20020a17090a4d0500b00203ab277966sm2344600pjg.7.2022.11.21.21.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:42:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [Internet]Re: [PATCH v7 1/2] merge-tree.c: add
 --merge-base=<commit> option
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
        <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1668210314.git.gitgitgadget@gmail.com>
        <xmqqsfibsn9o.fsf@gitster.g>
        <3e5cdd224d76499bbddf55b0b649439b@tencent.com>
        <xmqqcz9fsjdr.fsf@gitster.g>
Date:   Tue, 22 Nov 2022 14:42:10 +0900
In-Reply-To: <xmqqcz9fsjdr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        22 Nov 2022 13:28:16 +0900")
Message-ID: <xmqqr0xvr1e5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "kylezhao(赵柯宇)" <kylezhao@tencent.com> writes:
>
>> I went to check the api-parse-option.txt, but I didn't found an
>> elegant solution to stop when the users uses the second
>> "--merge-base".
>
> That's not even a fix, as it does not allow specifying more than one
> merge bases, is it?
>
> Just like how builtin/merge-tree.c::real_merge() is prepared to
> handle parent1 and parent2 that have multiple merge bases and pass
> all of them to the underlying merge machinery, you can accumulate
> multiple strings using OPT_STRING_LIST() and use all of them as
> merge_bases, no?

I am a bit torn on this, though.  

Because it uses lookup_commit_reference_by_name() to obtain
base_commit in addition to parent1 and parent2, and then
get_commit_tree() on them to get their trees, the real_merge()
function in the posted patch is incapable of accepting a single
"pretend as if this tree object is the common ancestor tree" and
merging the two tree objects.  But once that flaw is fixed, using
merge_incore_nonrecursive() with an explicitly given "base", we can
merge totally trees regardless of how the commits they are found in
are related in the history, which is a very logical thing to do.
And while operating in that mode, there is no way to accept more
than one "base".

So, I would be PERFECTLY HAPPY if this new mode of operation can
take only one "base" tree object, if it allows BASE, PARENT1,
and PARENT2 to be all tree objects, not necessarily commit objects.

But if we insist that PARENT1 and PARENT2 must be commits, then I
would find it very unsatisfying if we only took a single BASE that
also must be a commit.  If the merge-base has to be a tree or trees,
then there is no way to perform recursive merge (because you cannot
compute common ancestors across tree objects) , so it is perfectly
justifiable to take only a single base (and error out upon seeing a
second --merge-base=X option).

But it has to be a commit, then there is no justification to forbid
recursive operation, and I do not see a good reason to take only one
COMMON thing.

So, it is easy to say "let's take the current patch as a good first
step", but it is unclear what the good second step would be.

We could correct the code to allow PARENT1, PARENT2 and BASE to be
tree objects, not necessarily commits, when only a single merge-base
is specified.  That corrects the current flaw that tree objects
cannot be used.  And then when more than one BASE is given (or no
BASE is given---which is the original code), we could correct the
code to call merge_incore_recursive() instead.

But the amount of the effort to get there from the current codebase
(without your patch) feels more or less the same ballpark as the
patch in question, so...
