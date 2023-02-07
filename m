Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA5C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 17:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjBGRea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBGRe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 12:34:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154893A589
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 09:34:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so44575697ejc.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgwtlE86vCwe/Gb3A2XxmXYGVM8xnFqnXde/IAHLX58=;
        b=PGb9riUzwTxyeK0u3YhqRoI5mgR7Zuo/x0yBQXSPifF0O8/ZB7fqlP1hvTvJpS51tA
         MJw6TEysxvwbX1ptPoRv7EL+w56yOGveqT3ShtcEpfHimWCWuXhXz9acP3oCKTEV4Xsk
         Qg5kmWD9WmKPsSSHBFQVXNVxijvW61KGYTrKGDQ6G6lb+lSsguNdBEFHPbNPfHNVyMcH
         4r7pFfiNFVmraNQiRlfZN7xS0kCmEHnZHL7E/jnXli2CQGKZwzmsF8sln1eYAdBW30el
         WJ66biGPSo50oUkwVp/5LC6NLObXRAQgIBUWAec0FgOnasCCSIUDg+yjD/8kjvyVsAc1
         Zvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgwtlE86vCwe/Gb3A2XxmXYGVM8xnFqnXde/IAHLX58=;
        b=C71nNlZsolh280HAQQ0ch/1SE6Gi1w2BxeNyqMkndqHBSYKQGXdgtY5sV+UW6SqGhB
         e2CKtgezW1xgHZqn6z5qBBn3SHhGUC8oxw1/BEnVvhkMRsJQGFm2oI0YOpp1b2QiUPw3
         /MRwDe5tn1ORjV6oTKD2/7uKFKgTayKHRO2DqADjs5uomPus3+8kmKDPOy8w4+1iOQD/
         pMPXnRU4F9Pg3+jPAxe5uWDCVjSYyXBrAKF69GcjQ4yBNoSXrsKkxgolmTDVThTPk/Hx
         a7mf99mBv+3gx1oIBKprbVKxYKF87UsZ8Tk9N2gkfrHRlkpQkm+AVTzpKiiwtUJ+TNcn
         bBVg==
X-Gm-Message-State: AO0yUKXZzr5tRYNOfXQBUP9PvdHkRNqMrBXccywPdhM+l1lI/EuPNwpw
        TRe+no7Pj07LlOJ5xQtlm/o=
X-Google-Smtp-Source: AK7set/AmHNlQY7+cDKEFZNYB4QGV21FQAuJGGe1gJWbzlRFA50EVdexAawjFgJ+uSJlEqVf45pSvQ==
X-Received: by 2002:a17:906:4e96:b0:88d:3c85:4ccf with SMTP id v22-20020a1709064e9600b0088d3c854ccfmr4783863eju.25.1675791266561;
        Tue, 07 Feb 2023 09:34:26 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0088a2aebb146sm7148065ejt.52.2023.02.07.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:34:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPRrN-000uKL-1I;
        Tue, 07 Feb 2023 18:34:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Tue, 07 Feb 2023 18:27:02 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
Message-ID: <230207.86sffh2xcu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Phillip Wood wrote:

> This is slightly off topic but one thing I'd really like is a way to
> tell diff use automatically use --diff-words on some files
> (e.g. Documentation/*)

Unlike changing the algorithm, -U options, diff.orderFile etc. doing
that would give you a diff that can't be applied with "git apply" or
other tools that expect a valid unified diff.

So I can imagine that it would be neat in some contexts, but such a
change would have much wider implications than options that tweak how a
valid unified diff looks, or is generated.

We'd need some way to mark a diff as "for ad-hoc viewing only".

But as it sounds like you want this for git.git the
Documentation/doc-diff script is much better than anything word-diff
could spew out, as it diffs the resulting generated docs.

I wonder (but haven't tried) whether you can't "diff" that using the
same method that can be used to diff binary files using a custom driver.

Hrm, except that in that case (with includes etc) there isn't really a
1=1 mapping between files within Documentation/ and generated docs (due
to includes etc.). But I suppose it could be used only for those files
that 1=1 correspond to the generated manpages.
