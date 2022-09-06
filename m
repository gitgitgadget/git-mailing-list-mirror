Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83935C38145
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 18:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIFS0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIFS0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 14:26:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8A9AFA6
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 11:26:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso7946169wmr.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=aBFj6uft2mUelAgyvCkWBdpXTiCaA33xN9vwrri9wfw=;
        b=lpEi+1vVdowYomFVfLksD1zH47bcpRp9lPqp3IiMx01kQoK4XG4eDT7z7KxNjnpuHf
         Pm/kgnzd5jAhxetbmX73hsgW9Gowm+dyRG3AXJUBMDMFnozDXrD4kpdYVoH5CCfZV/+C
         930BL7JBoWkn9wlnFpaJHwArHdWWonheXkF/rMxZC52WTMKWX/wpR5p1kf6/VC2ZtX9D
         LxYLd/yhu/AQl0vtQE/eeOxrz1RoyX2bEueUnoKNwMlXcGu6gHGNIb0wPrUYV3qd1FSK
         0HYETD2gmAk6dk3+BGz/0cPDb7Ui2QUkky7Tft4c5KPcItRuRBjJIIPBQrCs95mDNOau
         fW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aBFj6uft2mUelAgyvCkWBdpXTiCaA33xN9vwrri9wfw=;
        b=f17o/IU4JBrcfuPTR760EVtQ1eLC4lZobt+5Yhn2F5rPLmzi6b4R4qxjEaPQSwFEeB
         huTkAI1zGO08mxXbGHhMCBlwbz3SBiKe72Eip2WLkMs+CCaPKQ9c3jETIxuJTjeHKM4/
         BdQUagjiksFsFxbOmpGN/FE6TYwD7N3XISI1CBmfSNDC+Yfm4qibHcjX8cHAFJJVEcdh
         XptecP506aviExdYgVclCZ2tJCxINUtkfLyZlpKs63Xc3OZFvycq40wFBYuOjQ/Njxne
         8A6to+mZJtshrdG8DOn/NoA5e5lPtlOERVAIniZMfN+rkOWvLQQi53ZnWYAv/M9kBAOG
         uYTg==
X-Gm-Message-State: ACgBeo1u81ftK8Pq9Iy4QogO1qOhR9iA7UwT+cAzYqvvRLEuipIoXyrX
        Ou+OjmIXIuwYsaUkN7Rj+f0X5w7gP2ujWMKM7HpZAKN52gY=
X-Google-Smtp-Source: AA6agR4Z8h8HMjvuMP1z518ZZdm61w+ly5G47+vHsrngk4ezbdsbUBqPIjsFa6QnYEEm51xS8+OeFdaGbfvFBhsqJRM=
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr14860638wml.51.1662488808639;
 Tue, 06 Sep 2022 11:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxJkn7K3zRm1u3Vn@tapette.crustytoothpaste.net>
In-Reply-To: <YxJkn7K3zRm1u3Vn@tapette.crustytoothpaste.net>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Tue, 6 Sep 2022 14:26:12 -0400
Message-ID: <CA+4x=b_KP4rMH-EDmVCD_4LHPiLx32J2OJC6Mm5xpQ-QUcSKuA@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lana Deere <lana.deere@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git ls-remote origin' command on both produces about 3600 lines
of output which appears to consist of all the branches in our repo.
The two outputs are identical according to diff.  Both include a
single mention of the switch-to-qt5 branch,

$ diff /tmp/ls-remote*
[no output here]
$ grep switch-to-qt5 /tmp/ls-remote.*
/tmp/ls-remote.2.18:6a9363081d05c313ba6a6ac59183193f1340bb1f
refs/heads/feature/switch-to-qt5
/tmp/ls-remote.2.37:6a9363081d05c313ba6a6ac59183193f1340bb1f
refs/heads/feature/switch-to-qt5

The 'git config -l' from both versions is almost the same - two lines
have moved around.
$ diff /tmp/config*
1,2d0
< filter.lfs.required=true
< filter.lfs.clean=git-lfs clean -- %f
4a3,4
> filter.lfs.required=true
> filter.lfs.clean=git-lfs clean -- %f

$ cat /tmp/config.2.37
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
filter.lfs.clean=git-lfs clean -- %f
user.name=Lana Deere
user.email=lana.deere@gmail.com
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
color.branch=false
color.diff=false
color.grep=false
color.interactive=false
color.pager=false
color.showbranch=false
color.status=false
color.ui=false
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=http://lana@githost:7990/scm/dp/sw.git
remote.origin.fetch=+refs/heads/master:refs/remotes/origin/master
branch.master.remote=origin
branch.master.merge=refs/heads/master
branch.feature/switch-to-qt5.remote=origin
branch.feature/switch-to-qt5.merge=refs/heads/feature/switch-to-qt5


.. Lana (lana.deere@gmail.com)

On Fri, Sep 2, 2022 at 4:16 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-09-02 at 19:27:55, Lana Deere wrote:
> > I'm testing an upgrade to git 2.37.2 from the current version we're
> > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > gives me an error but 2.18.0 things all is fine:
> >
> > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > Your configuration specifies to merge with the ref
> > 'refs/heads/feature/switch-to-qt5'
> > from the remote, but no such ref was fetched.
> >
> > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > From http://githost:7990/scm/dp/sw
> >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > Already up to date.
> >
> > Anyone have any ideas about this?  All I could find on google was a
> > suggestion that the "no such ref" message indicates the remote branch
> > was deleted, but that's not the case here.
>
> Can you provide the output of `git ls-remote origin` (assuming that's
> the remote you're using) and `git config -l` (the latter with both
> versions)?  I don't know of any reason why Git 2.37 should be broken in
> this regard, but I suspect that there's a difference in configuration
> between the two leading to this.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
