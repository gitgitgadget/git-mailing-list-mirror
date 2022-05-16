Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD3CC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbiEPSgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbiEPSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:36:45 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392693E5DF
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:36:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s2-20020a17090302c200b00158ea215fa2so8425358plk.3
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8izCZtjXwbQM9O+bnc4rujSPlPoihFyjLflTAmZpzjM=;
        b=M8p35tRb2PkWM+AEISYdSt5veql2gsV9NxLq/ysX05kJmTtPTg82W/dh4C0+Bg+kLC
         lIQlvtROO/ZB/jXexqVXORHe1S4JsxzEoXvNKw2S73pOC9oexQbFFOwJm+Ku9q+IuQPp
         icXUP9DWl0DKHDdT/v2mG0f0CK4DzBLm89SEbkkxo/XB3dj9svpBIYopjJr2BRsTx8Sm
         2tO+RbotW/lSBSyYSg8IYieLqN40rY8dKZjTvtxQ5TnIaaBqaNbVDfXRXugGIbuC/f9w
         qXk5P8vfY2cqhUX7+r1NHDlvCpXHcLbEVcyBVdju5NfXpFy/xzdasw3RRGR8/RxVcB2o
         tlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8izCZtjXwbQM9O+bnc4rujSPlPoihFyjLflTAmZpzjM=;
        b=dj2xBsG8iY8X3IA2rdIKRvc7DZ/F72WioZnsr+/4zqserF1DzaChGdDUZEpyvmRIZU
         pds+HR526yryJa/q1lyyWzoLzhQGG/vvcNw0gp+yh/qp+UGu9WUckyepawgIJ2qFaQFK
         JdLN+a3Wj5wJVLLMbUX3wp1mEaklKma1iOyMi0e6xXucnsCjjlKDiAhUccnwf8TzKFqy
         SG5irF7yzRA7Bbx+6Ep07JhvjXDRL3orlwywsKFngw+5Y6nR0LY+UewMLSB17cFnM+SD
         4lbuKMpgTYznG6q1ylo3rDMqtat9hRTptSvcpu0AvlZRZUc1/oqOSXEl8lBi0sUWaWdS
         dJ1g==
X-Gm-Message-State: AOAM532lGmdGNTRt3/k47G8RbkT6XGVlGqBUeraYmekvl1dngq+xG6pO
        8fPBEvxUtc9BLGjWpYzLwaUVrrv0QG4Izw==
X-Google-Smtp-Source: ABdhPJxijQsLBJxZk9EZXpKQsdouarTNMCQ8AcgeWBZUNDlBwCR9Lz4yB/vot/y0RPbBih5WCPdKj+Y5Pa2OWQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1809:b0:1dc:1597:20c with SMTP id
 lw9-20020a17090b180900b001dc1597020cmr20882016pjb.36.1652726203634; Mon, 16
 May 2022 11:36:43 -0700 (PDT)
Date:   Mon, 16 May 2022 11:36:41 -0700
In-Reply-To: <xmqqy1z12zxr.fsf@gitster.g>
Message-Id: <kl6ly1z1iati.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> <xmqqy1z12zxr.fsf@gitster.g>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  * die()-ing is necessary if we're trying to flip the default value of
>>    discovery.bare. We'd expect many bare repo users to be broken, and it's
>>    more helpful to fail loudly than to silently ignore the bare repo.
>>
>>    But in the long term, long after we've flipped the default and users know
>>    that they need to opt into bare repo discovery, would it be a better UX
>>    to just silently ignore the bare repo?
>
> Would a middle-ground of giving a warning() message help?  Can it be
> loud and annoying enough to knudge the users to adjust without
> breaking the functionality?

Personally, when my tool changes its behavior, I would strongly prefer
it to die than to "change behavior + warn". I'd feel more comfortable
knowing that the tool did nothing as opposed to doing the wrong thing
and only being informed after the fact. Also, I sometimes ignore
warnings ;)

When we _do_ transition away from die(), ignore + warning() sounds like
a good first step.

But if any of this flies in the face of the project's conventions, let
me know as such.

>>      +    Add a config variable, `discovery.bare`, that tells Git whether or not
>>      +    it should work with the bare repository it has discovered i.e. Git will
>>      +    die() if it discovers a bare repository, but it is not allowed by
>
> Missing comma before "i.e."

Thanks.

>>      +++
>>      ++The currently supported values are `always` (Git always recognizes bare
>>      ++repositories) and `never` (Git never recognizes bare repositories).
>>      ++This defaults to `always`, but this default is likely to change.
>>      +++
>>      ++If your workflow does not rely on bare repositories, it is recommended that
>>      ++you set this value to `never`. This makes repository discovery easier to
>>      ++reason about and prevents certain types of security and non-security
>>      ++problems, such as:
>
> Hopefully "git fetch" over ssh:// and file:/// would run the other
> side with GIT_DIR explicitly set?

Ah, I'll check this and get back to you.

>                                                        I do not yet
> find these "problems, such as..." so convincing.

What would be a convincing rationale to you? I'll capture that here.

I'm assuming that you already have such an rationale in mind when you
say that the longer-term default is that "we respect bare repositories
only if they are the cwd.". I'm also assuming that this rationale is
something other than embedded bare repos, because "cwd-only" does not
protect against that.

Perhaps "never" sounds better to folks who don't ever expect bare
repositories and want to lock down the environment. Randall (cc-ed)
suggests one such use case in [1].

(To Randall: Oops, I actually meant to cc you earlier, since you were
the first to suggest a practical use case for never allowing bare repos.
It must've slipped my mind).

[1] https://lore.kernel.org/git/005d01d84ad0$782e8fc0$688baf40$@nexbridge.com.
