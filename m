Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221E61F453
	for <e@80x24.org>; Thu, 31 Jan 2019 06:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfAaGZC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 01:25:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43660 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfAaGZB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 01:25:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id z18so1244854qkj.10
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 22:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AH/myX0GSjYIeyB2VRyKZ1h+LeMZhpMvEg/DWf39jps=;
        b=bAUGFXDMMADwKSnamh+r4mcbze6ipDirzM/8UsAEUfJ09QXYt2ykqgFo+uNWP8v3Xz
         dTnqBJHQl0XDkdy34FHjX1epe48VbSoqMXU/YCSxEElvMJVms8ofcysvJrVokx5eAtwE
         B5+JimHBjHf0fu/+gCqNpVKMmLXFAB0B3poAiVDH4Af/PPiDaUXdxWkjPBObRraKQgUN
         RM9O6tu8OTd9jhIQHPsvJlNcT90F5I0+DlOzHDU/4IyssvB9SLPlNtp0ca6AdaRvjuYh
         e/Y3FedbYRhaicl2tKEDFdqVooyJTfadfKsDFl6GBkg2LbWsae6AbZIMbFonFeU4yHAx
         DGxA==
X-Gm-Message-State: AJcUukeGReZug3ua36lO8sE2PZw+upVpj3t4cy98Nq7BIvDMNR3zszPw
        EXxUlZpKT/pT7CoYS5i/JFOufplL6ommiPNz8vg=
X-Google-Smtp-Source: ALg8bN5G8h1tchpUDXz6ZycMOZLDWQr7iRzHyXBgiD7z8N0VYthdwhYfvlmu+l49d9stqLzHXJbVYiRg5/0Vv9VvMGA=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr29343654qkb.220.1548915900491;
 Wed, 30 Jan 2019 22:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
 <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com> <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com>
In-Reply-To: <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 01:24:48 -0500
Message-ID: <CAPig+cS4Dmgh+hCMXp8ND5DMy6QFVCJOgvDwpcbwZ0HV4MscpA@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 12:29 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 31, 2019 at 7:50 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Jan 30, 2019 at 4:49 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > > +'git switch' [<options>] [--guess] <branch>
> > > +'git switch' [<options>] --detach [<start_point>>]
> > > +'git switch' [<options>] [[-c|-C|--orphan] <new_branch>] [<start_point>]
> >
> > What does the third form mean when all optional arguments (that is,
> > _all_ arguments) are omitted?
>
> "git switch" is smart (or too dumb to be clever):
>
> $ git switch
> fatal: nothing to do

But does it need to be this way? Does it make a good user-experience?
I, personally, find it confusing to see that it can accept no
arguments. An alternative, perhaps more consistent with UX elsewhere:

    $ git switch
    fatal: missing branch argument

or something.

> > > +If it turns out whatever you have done is worth keeping, you can
> > > +always create a new name for it (without switching away):
> > > +------------
> > > +$ git switch -c good-surprises
> > > +------------
> >
> > I had to go re-read git-branch documentation to understand why you
> > recommended "git switch -c <new-branch>" (or even why this mode
> > exists) over plain "git branch <new-branch>". I wonder if the
> > difference between the two deserves a bit more discussion here and
> > above in the description of the -c/-C options.
>
> There is this bit in git-branch, will that help?
>
> -- 8< --
> If you are creating a branch that you want to checkout immediately, it is
> easier to use the "git switch" command with its `-c` option to create
> a branch and check it out with a single command.
> -- 8< --

That's pretty reasonable when reading git-branch documentation but
doesn't help when reading git-switch documentation.

(Also, shouldn't the bit about "want to checkout" be changed to "want
to switch to"?)

> Otherwise any suggestions are welcome, I guess I could rephrase it a bit like
>
> -c <new_branch>::
> --create <new_branch>::
>         Create a new branch named <new_branch> starting at
>         <start_point> before switching to the branch. This is similar
>         to creating a new branch with linkgit:git-branch[1] except
>         that `git branch` does not switch branches.

This is much better.

I find, however, that the top-level git-switch "DESCRIPTION" section,
which talks about "switching branches" doesn't actually ever explain
what it means to "switch" to a branch. Even adding a simple sentence
stating that "switching to a branch means that a newly-created commit
will be a direct child of the current head of the branch, and that the
branch will be updated to point at the new commit" would help cement
the meaning of branch switching in the reader's mind (rather than
assuming the reader understands that implicitly).
