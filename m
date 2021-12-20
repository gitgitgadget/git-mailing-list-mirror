Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6FC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhLTTEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhLTTEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:04:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C724C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:04:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y13so42315414edd.13
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cK8WpKM+VG1q++d9EFH+SXtzRFl/ahw8mtTW8yarsLA=;
        b=IcslehR1Srm2VPi80KF5TsTDDEf2q/OtU6TCbpJ5z4HO9LBO+nZPfjJBmwqFUh/eEb
         t7Czw/WhL8pupqSKFiu2md7Oxj6T8zZM/NAT+Of9c7yujbnWPHMKw1bJjCBrskwo8D9H
         Xt9XUgeDedO+u7wqGaqjyo9iFgoy+bgYqqXX70q/+tmID8VHLQ6R4CCFU8ntm7Ds7EK1
         FqVziYbJwybwrWmofomqsciT2AnXtP8CiDHo2Z+FhKMhGJLGdjt4VvMl6YogqWECGD6e
         s5zA1erwAIMHwWrAVIDMxpujpEf1iZlkNiLrrKSurWCIOxploaOnI9hRs2SaPy9iez0w
         jHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cK8WpKM+VG1q++d9EFH+SXtzRFl/ahw8mtTW8yarsLA=;
        b=uxcr6gzjeoLltM2qyZT7ZioJ++0XhewxS4PtpI+Yz9JWE8rQelOed3Zzst1byB6pd9
         oIhTcgSWJMRzjhXuvVzubBMs1kd+lOqBUl0jArSol0DjurR7KIHHDFO/1UiFBXEAE9+6
         wnZx0jeUp8x7vl7zD1eYu+V+Cr/neeP81S2xk//JkesiLpFz3KLCxfioGuHhKsCj/9US
         D0Q9NVa8FOReWTGqwbcpwRax/0fEy5DWRFMfEObEdoKDnx3coseKeH3y8nE6DelEOzuA
         y7D9LNsqnvzn9b7GvVskMEEzY+8+sS7rSqHvGq3wMgTA1mFyfqirtdcdTtyEWkepGGvV
         LTJA==
X-Gm-Message-State: AOAM530yDeHiUcW06/AmIfUjLBQbeTBXSJIHPuwwiVpaq0i4jW+u1yB9
        k3FEuK3BAy6W2Yb0RJ50zOdCGoX74LQJ0A==
X-Google-Smtp-Source: ABdhPJxSqYQksxuyiqc2r4rlg0p2+MYw9E0+vt4W31LWDe+8fB2kk2IQme0JC0y7NV9LYM7CKzbxiA==
X-Received: by 2002:aa7:d4d3:: with SMTP id t19mr15506802edr.289.1640027039522;
        Mon, 20 Dec 2021 11:03:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w3sm5571161eji.134.2021.12.20.11.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:03:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzNx0-000XBS-EW;
        Mon, 20 Dec 2021 20:03:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/2] Two small 'git repack' fixes
Date:   Mon, 20 Dec 2021 20:01:20 +0100
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
Message-ID: <211220.86r1a7t7xd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Derrick Stolee via GitGitGadget wrote:

> I was experimenting with some ideas in 'git repack' and discovered these two
> bugs.

This iteration looks good to me.

>      + ## Documentation/git-repack.txt ##
>      +@@ Documentation/git-repack.txt: to the new separate pack will be written.
>      + 	linkgit:git-pack-objects[1].
>      + 
>      + -q::
>      +-	Pass the `-q` option to 'git pack-objects'. See
>      +-	linkgit:git-pack-objects[1].
>      ++--quiet::
>      ++	Show no progress over the standard error stream and pass the `-q`
>      ++	option to 'git pack-objects'. See linkgit:git-pack-objects[1].
>      + 
>      + -n::
>      + 	Do not update the server information with
>      +

Nit: I think the addition of --quiet here is good, but also wouldn't
mind a prep change to add it as a separate step.

FWIW it appears to have been an unintended/hidden effect of a1bbc6c0176
(repack: rewrite the shell script in C, 2013-09-15), i.e. we started
using OPT__QUIET() which added "--quiet", but the shellscript just
supported -q.

Here we update the docs, but the SYNOPSIS stillj just lists -q.

I think all of that's fine & this v2 is good enough. Just braindumping
notes/observations while reading along/checking the v1->v2 diff.
