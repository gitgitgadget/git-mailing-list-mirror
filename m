Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A28C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 05:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E395611AE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 05:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhJGFpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 01:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbhJGFpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 01:45:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8FC061755
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 22:44:00 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id g125so695068oif.9
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 22:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=acyVd3mq0EVzWo6lwYPZ7get3Dl2qL9FIepzImAx9Qc=;
        b=Az4oVa0inGJ3PPdwSdIv8KCVpQQ1MP3G6I5WVNeeeJsTmS//49WEmKD7zpE9r+th04
         A5U11991xKARqw7ozxnFXC8NdWrHAuMz9Md5mBGC/kA+L3Nq9z2Jpsr41o4BsxqljFT3
         5vQu1L37IGeP+zyu1j9jOL8PXXAAQodYz7b51lghyHpZWl2OP9qTZpf9RrAGvPPhSI/m
         j8NAGIAci4NzIKLQ8EYpQdPBV8XVGip+EKxqt3043cob5mrWiSnD6ll1cMd/ujccTB8X
         1rHg3PpvgBUsRKXhQ5WPy9amZ0ULIuAfSBkBXlXV4LOiZy6HcYPTMaqyQNjpzW4VeKYh
         FZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=acyVd3mq0EVzWo6lwYPZ7get3Dl2qL9FIepzImAx9Qc=;
        b=VgPOUE3/rUjW4zd81klZO1AyO5OmzKVd5nIdPg3tij1XqShzqNyWfZrfqFiqHTxfTD
         5hEEiwq21t7rJhGOUBBFfTAGFr5yfN15BxaGLn2kOwB+kgszZNQPpVpJbNHxue9TMAQM
         lAmy0k1M7YKURSuRgDplNVDrK0ZJ3TCpA4tFcrJb0YiaLKlL1Yg+iLMXoD5ENZxF8pZN
         2XfbEhg3G5rbxMnvmsSaXHF5CpXAXHqgMBHlyQiz9bU9DhcGmKPS41aRl23Nd11mUS69
         LBuQ6JSK/HBeVoCfuV/UwewAOTPl2CO11gifENYWy85e3bA5ZFnL6+KyVmLFL4JkQgHD
         6d9Q==
X-Gm-Message-State: AOAM531UXbvuAiVxhaM4FID31RmCE7a7WppODErKFd9ggWIB5T5Tv67N
        J14nVNkVtRTWuHj9/Lmv7biWVl+KAVfcsQJlgfru1ZVC2gw=
X-Google-Smtp-Source: ABdhPJw5hyBbKtX8s/kW9N9QvcQtHVqbO7YEfpWDVQQHOrS4CgAUFS5hlqU6jai5++dlESbgtwkQs22nUJj8ZRnb3VA=
X-Received: by 2002:aca:de83:: with SMTP id v125mr7016985oig.71.1633585439862;
 Wed, 06 Oct 2021 22:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANcBuaZstymNMvbPX553kgr=FsrFFcDEivfiDPsPe3uyGLb78g@mail.gmail.com>
 <61ee8bec-1e6c-e3c7-2cef-7520f376c18c@gmail.com>
In-Reply-To: <61ee8bec-1e6c-e3c7-2cef-7520f376c18c@gmail.com>
From:   Eddie Ridwan <eddie.ridwan@gmail.com>
Date:   Thu, 7 Oct 2021 16:43:49 +1100
Message-ID: <CANcBuabe3px0N=awsuBGxdHgU8ChGHJdG8PAPoMJGnG98ntjdA@mail.gmail.com>
Subject: Re: Git push subtree fail unknown revision or path possibly due to
 missing git-subtree-split commit
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe

Many thanks for your help, and thanks for the tip regarding including
the subtree URL in the question. Your suggestion worked in that the
'missing' commit is now in my local clone. And now the git push
subtree does not generate any error.

Unfortunately it did not update the remote subtree repo. This is the
only output of the push command:

git subtree push --prefix themes/natra
https://github.com/OpenSID/tema-natra.git premium
git push using:  https://github.com/OpenSID/tema-natra.git premium
1/     131 (436) [436]

On the other hand, git pull subtree continues to work as expected.

Any suggestions on how to find out why the git push subtree command
did not update the remote repo?

Many thanks.

Eddie Ridwan

On Thu, 7 Oct 2021 at 13:52, Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Eddie,
>
> Le 2021-10-05 =C3=A0 00:53, Eddie Ridwan a =C3=A9crit :
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > git pull/push subtree as normal, although it is possible that one of
> > the contributors to the subtree repo may have done a force push.
>
> I think that is indeed what happened (see below).
>
> >
> > What did you expect to happen? (Expected behavior)
> > git push subtree to update the remote subtree repo.
> >
> > What happened instead? (Actual behavior)
> > Failed to update the remote subtree repo. Error message:
> >
> >         fatal: ambiguous argument
> > '3f44cc87ceb87df1d9171096596a824fc3050a27^{commit}': unknown revision
> > or path not in the working tree.
> >      Use '--' to separate paths from revisions, like this:
> >      'git <command> [<revision>...] -- [<file>...]'
> >      could not rev-parse split hash
> > 3f44cc87ceb87df1d9171096596a824fc3050a27 from commit
> > 8577911bf6183497cc246aa620e7be1b6becec29
>
> It would be easier to help you if you gave a URL for your repository :)
> (or at least for the subtree). I managed to find you Stack Overflow
> post [1] by Googling these commit hashes (!). Fortunately you mention
> the subtree URL in your question, and that's enough to go by in this case=
.
>
> >
> > What's different between what you expected and what actually happened?
> >
> > Failed to update the subtree repo, as expected;
> >
> > Anything else you want to add:
> >
> > I am not able to find the commit/hash
> > 3f44cc87ceb87df1d9171096596a824fc3050a27 in the repo. In gitx, I can
> > see that the commit is a git-subtree-split. But it appears to no
> > longer exist in the repo.
>
> Here, I'm assuming that by "in the repo" you mean in a clone of the subtr=
ee
> repo, i.e. a clone of https://github.com/OpenSID/tema-natra.
>
> Indeed the commit with hash 3f44cc87ceb87df1d9171096596a824fc3050a27 does=
 not exist in
> such a clone. But, it still exists on GitHub:
>
> https://github.com/OpenSID/tema-natra/commit/3f44cc87ceb87df1d9171096596a=
824fc3050a27
>
> GitHub almost never removes commits in practice. This is good news, becau=
se
> it means you can fetch it locally.
>
> > How can I bypass or recover from this apparent missing commit? Any
> > help would be greatly appreciated.
>
> The git-subtree script does need the commit locally to work. So, just fet=
ch
> the commit by its hash. In your project repository (the one which uses te=
ma-natra as
> a subtree), run:
>
> git fetch https://github.com/OpenSID/tema-natra.git 3f44cc87ceb87df1d9171=
096596a824fc3050a27
>
> This will download the needed objects. After that, you *should* be able t=
o
> run your 'git subtree push' command.
>
> Note: I think that the 'premium' branch (mentioned in your Stack Overflow=
 question)
> was indeed force-pushed, since 'git log --oneline dadcd0167^..' does not =
show the two
> commits that appear in your image [2] that read "Update statistik_pengunj=
ung.php"
>
> Hope that helps,
>
> Philippe.
>
> [1] https://stackoverflow.com/questions/69431546/git-push-subtree-fail-un=
known-revision-or-path-possibly-due-to-missing-git-subtr
> [2] https://i.stack.imgur.com/1tMln.jpg
