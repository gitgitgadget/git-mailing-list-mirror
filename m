Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F782C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 00:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4385564DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 00:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhBPAjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 19:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBPAjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 19:39:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CDC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 16:38:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b14so8039270eju.7
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=w2k8lSUCRTG2I4mZxWXzEE6ZDNbN1cZ59brxziIpF/g=;
        b=DojmQLy6+NfG1Y2cQ774k1oUiA4HuyOh62z/+ok5+9XcHiBM+WXH1m5E1g0aUpfFGb
         DdPQ31JMbcus7fnt4OHBA7GLRkoQCbhZcWEBD6ReAvvELNr5hrGejx70LNAnW7QXx13u
         4YGyeFu7HJTYJawSkTKKgGkWlF2fH7ycnZymHWlK+ln8fCFGuZ8kp/rEhhCHeNrAPaPg
         jltv/g/+eLSovoBmbxfkZXQonYYqVl2r1OOEV00V00YRT8zqbWcvogByJa7InPfnt9Vx
         r8QydHHWdvgnGyF1zUThB+TmyAKUinbX874vYvVKhAfKr0JTE7qlFrtqNEW+OkEro0Ay
         ScRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=w2k8lSUCRTG2I4mZxWXzEE6ZDNbN1cZ59brxziIpF/g=;
        b=sByd6GnFcyxvbegGMPKRT/IGIm7FF5Dsp5LWcVNuKQtRXW9bgnswQDtG040ipQ/UY4
         UR1S89Sfvw4ioYCtSKJ74GvpX0B3nWE6WZpqg7M/9OTctC+G4q10RB82PewG6p22AbdL
         grYTTx2GSZah0ILeILP2lDCya9h1XR4yc5sEVe8gclTeXPcr3THZSh1kdd3VsBRgWmra
         8Xso13/phO776aI0zpA26XAi6r0km+ogqU9lYl7Cy6UMrTVAwXQaS4OHVKe7pdir/A+I
         n9whhIwbp5CVlMMpNQtPrbES7nEe8CAKQWyD0ch0jJxqCPuRmy2D/LqwbsN4YTNmUXsf
         1GYw==
X-Gm-Message-State: AOAM530Q3F4aSQ8IeMbephl5sYM9E7V9A6XJTmkTmJsAEE27smn1J2IG
        pke+FqMmLxSM+U5F2F9Ont90HiBd+Rdayw==
X-Google-Smtp-Source: ABdhPJwaQI5s1boiInDgOEnS/U7GLabkCjxZszOvEK4CWF9jGlFXKmP6SYQ18GhCb6PlW6WwwyDu6A==
X-Received: by 2002:a17:906:fcd6:: with SMTP id qx22mr12697357ejb.533.1613435912483;
        Mon, 15 Feb 2021 16:38:32 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f13sm11789108ejf.42.2021.02.15.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 16:38:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsck: make symlinked .gitignore and .gitattributes
 a warning
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
 <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
Date:   Tue, 16 Feb 2021 01:38:30 +0100
Message-ID: <87y2foaltl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 16 2021, Jeff King wrote:

> While there are some minor security implications to having these files
> be symlinks, this is out-weighed by the inconvenience of blocking
> historical commits in some projects that might include them.

Digging up the relevant thread that's the projects noted at
https://lore.kernel.org/git/20201027033518.GH2645313@google.com/ ?

I cloned the openmrn.git repository noted there, and checkout dies with:

    error: invalid path 'applications/clinic_app/targets/linux.x86/.gitignore'
    fatal: Could not reset index file to revision 'HEAD'.

I'm running a recent-ish snapshot of next at d98b1dd5eaa7, so with your
verify_path() change in current "seen".

So this series changes nothing about the checkout, just the fsck check?

I see there's your
https://lore.kernel.org/git/20201027075853.GH3005508@coredump.intra.peff.net/#t
to improve the !!symlink() codepath in apply.c

Still, it seems like a rather jarring gap in implementation to just warn
about this in fsck for the benefit of e.g. server operations, but then
hard die on the current client.

There seems to be no way around that hard die, and both repos in that
report are ones that are just symlinking .gitignore to a
../somedir/.gitignore deep in their own tree.

So aren't we both making the fsck check too loose and the client too
strict? Would anyone care if this was an error on fsck if we did the "is
outside repo?" check?
