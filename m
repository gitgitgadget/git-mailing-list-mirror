Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75226C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhLPQoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:44:38 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:40948 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhLPQoi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:44:38 -0500
Received: by mail-il1-f171.google.com with SMTP id l5so22529650ilv.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIc3gLAqAttC95+zaHTqmpcXuqWX4jP5mJWJgF/gkRE=;
        b=y6IIdpjkFB3k1qfRUw+vqRPthXA+FBeiuqUCUJ9kaq8gxUDnRnieGKG26zBZYWXr//
         UzJhMP8FGS2rohcjKS1B407lRlB+QSQtfa34sA2+8aD6lBoUXfCNXVyZcVtkB0KOufbc
         GNBWVQDZXcwuZc8kqbGh+wfwI4j94/061BoBcQir3eHDgl9kVvsqWgnPWnCMxbFakwGG
         OZbV19vmBW5WeoOocVxf9Lg14jhycp3rXYuykrOHtmjW9b3iTr+4gcT2/wzVjtvLslFW
         SDZEkOKf39vbry0piE/6VjLE34N68gOIedAvfyyJrmfD5Wq0wMMosvvzRwL1cO+6qg0t
         jM3A==
X-Gm-Message-State: AOAM5306hxJB8rI4S8oMq17DZeeTXeqE4HutEWS76vjKePvo5HKkYJ4b
        s/C5UT3K/M1ha/wzW1IDh+eAoAGZwORJ2KoxXigUcSG2
X-Google-Smtp-Source: ABdhPJz7lMBrGchZDDTUd5LN0JzV625mRzKe4+75kWdjqFyM3shook5BSHDG8uX01Rkfok3xQDq49EzUPe6ZxeHjVfE=
X-Received: by 2002:a92:c609:: with SMTP id p9mr3963124ilm.49.1639673077758;
 Thu, 16 Dec 2021 08:44:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
 <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
In-Reply-To: <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 16 Dec 2021 17:44:02 +0100
Message-ID: <CA+JQ7M9G8HqqieRAK3C6csMM93PHOmaMd8GMPrDEfogWG0bteA@mail.gmail.com>
Subject: Re: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Yes, I know.
It's just that I was under the impression ORIG_HEAD was to be reverted
to .git/rebase-merge/orig-head at the finish of the rebase.
Personally, it's the behavior I would expect.

Thanks for the tips.

Regards,
Erik

On Thu, Dec 16, 2021 at 5:27 PM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> Hi Erik
>
> On 16/12/2021 14:30, Erik Cervin Edin wrote:
> > Steps to reproduce:
> > 1. git-rebase -i
> > 2. edit XYZ
> > 3. git-reset HEAD~
>
> "git reset" will update ORIG_HEAD to the current HEAD before resetting
> so here ORIG_HEAD gets updated to point to XYZ
>
> > 4. git-commit -C ORIG_HEAD -a
> > 5. git-rebase --continue
> > 6. git-show ORIG_HEAD
> >
> > Expected behavior:
> > ORIG_HEAD should point at the previous HEAD of the rebased branch
> >
> > Actual behavior:
> > ORIG_HEAD points to XYZ
> >
> > My understanding from reading https://stackoverflow.com/a/64949884 is
> > that this is incorrect behavior.
> >
> > Perhaps this is as intended but I would at least personally prefer
> > that ORIG_HEAD would point to the previous HEAD of the rebased branch.
>
> You can use the reflog to get the previous HEAD of the rebased branch
> after rebasing. Immediately after the rebase branch-name@{1} will point
> to the pre-rebase HEAD.
>
> Best Wishes
>
> Phillip
>
>
> > Seen in:
> > git version 2.31.1.windows.1
> >
> > Possibly related to
> > e100bea481 - rebase -i: stop overwriting ORIG_HEAD buffer
>


-- 
Erik Cervin-Edin
Erik.CervinEd.in
