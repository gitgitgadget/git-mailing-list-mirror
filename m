Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE154C6FA8E
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 01:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIUBsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 21:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIUBsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 21:48:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A27C1AC
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 18:48:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z20so5253116ljq.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4KP/hQLjCsiLTEZvd3Ae0GLBfXY5NcogeI1FtOrXd00=;
        b=FLy3THTVwrUL5cbHOBg0uOUwzX33VSpNqlNtV0r6WJAnLxfJiBxvWGksQcTQPwspaD
         A1IuYsTfFemnPNKNrWZ03dHS8aTSX364i9IM3jcaCAz+oTuPHBCQseCDgDdL3XTDqd3Z
         FLWx1/EjbXpDDWFi+REwWzcqJ/627/kyTBpaDwOSvnmZGj2x28wDqJakZ5e+v/VSLbrC
         IaV1vaSB7LzARAIKF1oOPw1xawSXe4gtjkRnivW4UDjfxlVZ9yDXhJOwo+5KL49F0ZCf
         pPgCEfFn2QLefqGyYtXH4J97yYIbUMFMEWUDNNeBBhdBXtNRKbbepfMmEmev9Lt2hPHT
         SdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4KP/hQLjCsiLTEZvd3Ae0GLBfXY5NcogeI1FtOrXd00=;
        b=07rqmiIbyTs290qFg+f82aqqMZXGAVTVqb1K/+pPKhV59B8hLXFzZfcec4tpDp7TPg
         fGhYDklh42RIQw9l2bU4mTUAceC6ACtpDB8vtzBvKwF92AS1t/eeoi1HIaoeHDCLXSlT
         BMXSUDo8JqbIK/3h55mKOw6ZvPm9EOXC97LFrCRuK5BbtiMMo+iE7XmnELsOF/RrKGN6
         RrNsrPIObxQo+uWTm6gK8UZpPaBHYdh6HjmA+5ZWLwa7BtazFSzc0gBE9HaNVBAm6Hgh
         +u6a9fTZUzd7VPvJcCahqxKAQ6Hr4bXFeq0aQ2aEKFtm+BRjF69lKpU0S00nwQlnoZ1G
         HG+A==
X-Gm-Message-State: ACrzQf33hTes4Vt21HrSsmWGZjqzoXu/obCJTeF9CwPc/U5RniCW7e4k
        lZqt1WbpyM0EWsXLGwIKsxjoypjyZJV99hoyuKE=
X-Google-Smtp-Source: AMsMyM4mKfcOENleY+55XNQtfGE3EP5g6OKuThu73srFID2L+gC37tjPYcLW80050r90OKKGGy94aN8f2QVlls4SXt4=
X-Received: by 2002:a2e:bd03:0:b0:261:8b4d:7c5c with SMTP id
 n3-20020a2ebd03000000b002618b4d7c5cmr8428302ljq.194.1663724879215; Tue, 20
 Sep 2022 18:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
In-Reply-To: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Sep 2022 18:47:47 -0700
Message-ID: <CABPp-BHFw_Qw3d=j3awFtm2OD8WFVHSRFqYzm5Z0WQNHf-ECpA@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 5:42 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hey, guys,
>
> If two users of git monorepo are working on different sub project
> /project1 and /project2 by partial-clone and sparse-checkout ,
> if user one push first, then user two want to push too, he must
> pull some blob which pushed by user one.

This is not true.  While user two must pull the new commit and any new
trees pushed by user one (which will mean knowing the hashes of the
new files), there is no need to download the actual content of the new
files unless and until some git command is run that attempts to view
the file's contents.

> The large number of interruptions in git push may be another
> problem, if thousands of probjects are in one monorepo, and
> no one else has any code that would conflict with me in any way,
> but I need pull everytime? Is there a way to make improvements
> here?

No, you only need to pull when attempting to push back to the server.

Further, if you're worried that the second push will fail, you could
easily script it and put "pull --rebase && push" in a loop until it
succeeds (I mean, you did say no one would have any conflicts).  In
fact, you could just make that a common script distributed to your
users and tell them to run that instead of "git push" if they don't
want to worry about manually updating.

Now, if you have thousands of nearly fully independent subprojects and
lots of developers for each subproject and they all commit & push
*very* frequently, I guess you might be able to eventually get to the
scale where you are worried there will be so much contention that the
script will take too long.  I'd be surprised if you got that far, but
even if you did, you could easily adopt a lieutenant-like workflow
(somewhat like the linux kernel, but even simpler given the
independence of your projects).  In such a workflow, you'd let people
in subprojects push to their subproject fork (instead of to the "main"
or "central" repository), and the lieutenants of the subprojects then
periodically push work from that subproject to the main project in
batches.

I don't really see much need here for improvements, myself.

> Here's an example of how two users constrain each other when git push.

Did you pay attention to warnings you got along the way?  In particular...

> git clone --bare mono-repo

You missed the following command right after your clone:

   git -C mono-repo.git config uploadpack.allowFilter true

> # user1
> rm -rf m1
> git clone --filter="blob:none" --no-checkout --no-local ./mono-repo.git m1

Since you forgot to set the important config I mentioned above, your
command here generates the following line of output, among others:

    warning: filtering not recognized by server, ignoring

This warning means you weren't testing partial clones, but regular
full clones.  Perhaps that was the cause of your confusion?
