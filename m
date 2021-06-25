Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E3C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 06:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746DF613B9
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 06:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFYGJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 02:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYGJj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 02:09:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86BC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 23:07:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s15so11814179edt.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 23:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ml0FDZYP/5f4jpUHHJZ1vPsXPoDVXlMHJvil7jnstA8=;
        b=T+ahUBQCXFU5R152bb+yJ3XSuzeFWvDtzuHqLSAvsMQoPztcvymBHU08POJmY44Mhq
         X7YkhV1hUtzB0wOAzAC+FmAuS2UmEW3dqNCNuBTNgW6huy6BSHqW7AaN9H1QjJAnu52c
         +n5trt5KhSkfS0TNJgtUX+DfyPwoOD8dBsNIHuM8FIXCQVITGlSLezdl1xkkZaNhQbeR
         glF3C749ZbINZb6McLAD2SQ9tLO0TGusQtMcX0F2vNu45UMKBcpdmfOgh3NZoaoo7OUZ
         OEn1q+hoZskhlS3SPD18hTic9ERx/uHp6xqwvd39GhozzdCznmbMY9laU54yfzuuDvDl
         pBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ml0FDZYP/5f4jpUHHJZ1vPsXPoDVXlMHJvil7jnstA8=;
        b=OYMgFIo7HbSIZYtRhRHGMVX1XUvo33ET+cNj4UnfSo7rR9iQ0vMPEwxhg9PlicQiyL
         7nD2PDY27AwY5sEfXJAB3ODxbXOUeW0vnGssB1yfB+ZXoeeisPIL2QHs7qMEAyh0a4bz
         HzL7mrq8PX8smNA+npIqezvr69dz4jFdrQ6KaNjbL9NV84mlfRoo3IuqOanphGFyCILk
         1NaCg2HOJ3ru57RBBTVxyQZysDyy3EFkytARBZ30c26YWGwH3yTv8IoACBjwasDt5sSO
         1i4xb4XEtkLV9SE2C6ekiz1LstgXiG1NkycF61RxcQWtTQ65DivTvjsOa6UB7SdVA+t5
         zRvw==
X-Gm-Message-State: AOAM532aKiYspcV+sprbJjpjbxD/V8Uw/kjSpdhbSAjlyz4zsZRGCqz6
        Vu26XuMDA1Us+3ilsRaD44w=
X-Google-Smtp-Source: ABdhPJwgaVoWNE17BsT3hNXLKlIDCKPYAGGueHlasNYkRjeunf3bFiwgH1BZODbdG2GfgbiN2453/g==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr12291335edu.380.1624601236325;
        Thu, 24 Jun 2021 23:07:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d25sm3293214edu.83.2021.06.24.23.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 23:07:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>
Cc:     git@vger.kernel.org
Subject: Re: Definition of "the Git repository"
Date:   Fri, 25 Jun 2021 07:56:49 +0200
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Message-ID: <87tulmxyss.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 25 2021, Kevin Buckley wrote:

> Hi there,
>
> raising this on the back of a discussion over at the Software
> Carpentry lesson about Git,
>
>    https://github.com/swcarpentry/git-novice/issues/810
>
> I used the book to justify my claim that it is the .git directory
> that is the repository, but I do have to concede that the way that
> the text in section 2.1 of the book reads, does suggest that one
> can refer to the working directory PLUS the .git directory as a
> "repository" as well as being able to refer to the .git directory
> alone as the "repository".
>
> In the way I think of it
>
> git init
>
> initialises a Git repository, however, the only thing that changes
> as a result is that a .git directory has been created, ergo, the
> .git directory is the repository.
>
> Furthermore, the fact that one can take the .git directory, move it
> to a new directory and start using it there (very much a nice feature)
> also suggests to me that it is the .git directory that is the repository,
> as distict from a working directory, under Git control because of the
> existence of a repository within it.
>
> Interested to hear any thoughts around the semantics here,
> Kevin Buckley

I think the right answer to this is that there is no right answer, if
you read gitglossary(7) you'll find it mostly backs your argument, but
you'll also find mentions in git's own documentation that say things
like "a subdirectory of your repository" when referring to the
repository's working tree.

More importantly it seems like this is documentation for novices, I
think it's generally more important to get important notions like their
historical data being stored in that .git thingy than it is to nail down
every concept involved in that with 100% accuracy.
