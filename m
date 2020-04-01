Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1556C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 06:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF32071A
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 06:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+bNTPVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgDAGf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:35:56 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44008 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbgDAGfz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 02:35:55 -0400
Received: by mail-ot1-f41.google.com with SMTP id a6so24795122otb.10
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMC1K4IIftozRGA8A6xjeRQRvpUt5Cj98f7GDU+pt0M=;
        b=d+bNTPVN2fwPl7upeYrQhxjL6ugWNJtyxrym0auYA5b3cAvEfoVwMD+DUVywk1YSB4
         icxXYIMmmNfIcC8W1/Jk/nMpAiHqYUHkUteMCsQ7iaqEijI7CQl2c1cJhrJRzQi+rxDa
         NYJbOzMn15ChQR6dDWwrUNnW9tgeq4pUTQD2y33WBa8ByxY6d+DT0Nd6WxuHEVR0y/gK
         k48iSoQsBgMY4xJc1jIJpScVbmRqbtnytw95UiRmLetHBljuhVrrO6heQG0NDFi3E9nP
         6IrG9szm/9rA4O6ajip0OCQf3+20qgm1UvMY6yonziUfu1Flk9jwQf6cevOp/4NqQ4lT
         l7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMC1K4IIftozRGA8A6xjeRQRvpUt5Cj98f7GDU+pt0M=;
        b=lFfzZ4J0/Mei9lzg9OzpaGvv9sc6fQUXEa17dBIy1qeXaCwQyfXGmJgRKo4UepTWjF
         y/Ga8jaxnCAb9vswwlpWq5DAUaRvZEDVX1omHRXwRfJsCR0L/CAy16NGt6PFcxFp+7QS
         3/yTEEkZSd/wPSqWIP7cgmRYRBPTGgi6S2cWyKVgFeIZl9ClJpOSLcqGLZendT+dLqm6
         BbNWbC+PzuS3J/5f8XOJsXqz0Tdb0IM7Z9W6NBjQxpygFozWJfaFXtsaRmd+jYL4FU/t
         sJFW0U1jQUfTXT722NkA/WuszL3r5VYNSQISALkUXLEh3NawiriioO6cGHmso8chOq5b
         IAjg==
X-Gm-Message-State: ANhLgQ1NKwkCiSbpOI5b5uKGA2vhsYOUJ/i0+ewxA6YnDrR+2PMbXFy4
        zMjY7GM23aMl8yiHA29WHT2v/c+m5Dl03BRE+2GNQdCXuPs=
X-Google-Smtp-Source: ADFU+vuJp4mgYw+OAOvUvzyxT7ipuiPAPJ+CL/HiYtCCY+3HM/jvo/MJSgIPV0TSazHbeL33rnJFA+WGOScuL6lxfBQ=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr11689568ots.345.1585722955099;
 Tue, 31 Mar 2020 23:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-FUjCefwGjvCcwmjO=GADd5S0cU_=S_tVy4nMaj07+rQA@mail.gmail.com>
In-Reply-To: <CAGyf7-FUjCefwGjvCcwmjO=GADd5S0cU_=S_tVy4nMaj07+rQA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Mar 2020 23:35:44 -0700
Message-ID: <CABPp-BFDx2j5Kf584Myb6wuEq5G7wbogJ2vos8OTDsh+ySfk8w@mail.gmail.com>
Subject: Re: Rebase-via-merge behavior difference between Linux and Windows
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 4:25 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> With the default rebase backend changing from "apply" to "merge" in
> 2.26, I've seen several threads about behavior changes between the two
> backends. This is _not_ one of those (although, as I mention at the
> end, the "apply" backend doesn't appear to have this issue).
>
> Instead, what I'm observing is a behavior difference between the same
> "merge" backend depending on whether the command is run on Linux or
> Windows.
>
> A little context: Bitbucket Server has a set of zipped repositories
> that provide consistent initial state, and we have tests that download
> those zips and then run various Git commands against them and verify
> we get expected outcomes. These same tests run on both Windows and
> Linux.
>
> Using our merge test repository[1], one such test performs the following steps:
> * Unzip bare repository
> * `git clone --shared -b branch_that_differ_by_empty_commit_trgt
> <unzipped> rebase-test`
> * `git rebase -q --no-verify 7549846524f8aed2bd1c0249993ae1bf9d3c9998
> 298924b8c403240eaf89dcda0cce7271620ab2f6`
>
> 298924b8c40 is an empty commit (i.e. `git commit --allow-empty`), and
> is the only commit not already reachable from 7549846524f.
>
> On Linux, when this test completes, "HEAD" in "rebase-test" is
> 7549846524f because the empty commit was discarded. This is the
> expected behavior. On Windows, "HEAD" is a new empty commit, which
> causes our test to fail.

I don't have a Windows box to test, but it's good that you are seeing
the correct behavior there.  I do have a Linux box, and cannot
duplicate the behavior you state, even downloading the zip you
mentioned and following your steps to reproduce.  Actually, I did
reproduce that behavior the first time because I was accidentally
using git-2.25.0.  But with git-2.26.0 on Linux, I see a new empty
commit after rebasing, as expected.

Is there any chance you accidentally ran with an older git version
when on Linux?  If you really were using git 2.26.0 on Linux...then
I'm totally confused at how you got that behavior.

And yes, I am stating the exact opposite expectation than what you
did; let me quote from the relevant bits of the 2.26.0 manpage for git
rebase:

BEHAVIORAL DIFFERENCES
-----------------------
...
Empty commits
~~~~~~~~~~~~~

The apply backend unfortunately drops intentionally empty commits, i.e.
commits that started empty, though these are rare in practice.  It
also drops commits that become empty and has no option for controlling
this behavior.

The merge backend keeps intentionally empty commits.  Similar to the
apply backend, by default the merge backend drops commits that become
empty unless -i/--interactive is specified (in which case it stops and
asks the user what to do).  The merge backend also has an
--empty={drop,keep,ask} option for changing the behavior of handling
commits that become empty.


So the apply backend has the wrong behavior, we just haven't bothered
updating it.  Perhaps we should.
