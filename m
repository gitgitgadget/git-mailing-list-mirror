Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3DDC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3740761963
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 18:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhCWSfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhCWSfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 14:35:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA654C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 11:35:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o10so28127753lfb.9
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aPl+dKQ9kSqbq97TjO9L8t99wBcsu0etpWIiRnquvUs=;
        b=Fc4oGCfl9n3Oq4PYObPs6kjWW1z6hqOoqwLK6w4s5s/04bZIhDQlyqrkgIDELCvXcU
         QMUtWtBUUmEbZTvY9n+WLWx3jL4m6bcLvzJx4/jpRaN5clQdJ9HDY6K9dmhgIlSer0ic
         URCYJOi5ycnK5kSA4r5xSd9CUn6ArPsCkStJyVOT8B/yGqOdZnSe70cVJTpp6l45xia2
         6NhaVea7E1RJeFnAYvVTv3R1Dq1DlSt478svU7NrcdywEV4xvwmTbGDMSOtnFqVOK7db
         Af7fiYgQzLIGRPAE6p68ERhl86Z18Hy6uk/cUfxHyWzc2msUNQulzZALN7aa4DjnB3O7
         VDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aPl+dKQ9kSqbq97TjO9L8t99wBcsu0etpWIiRnquvUs=;
        b=QTNwpH01A4ExJT/D1to4zAj6oHxEm3IunVPq2lIpHFWvuNd/VdnxvC8Dev8U4ZbN2I
         Oo+n4foGB2l1S1VxW4w7lDWfEDpibZDi15/Q6puxeBv3pjfSRGRRfV8n8RiZhj8Xu0gN
         4PvM5TzSBw5RGZf30rJfFi3cgrnFIky05Dvcrlf0uKno60TJRBC+2mw+mL2CkGl3pVv0
         M6+bUrOTb8XyhQJQbf8HjBRk9Jilo66Dtj96TZZi6y5MZWqVdaYojTMWFXJXjqzgJBjE
         YtjRyIU2OR/QsjXFfVFe2tatsK4E31qSYJYvEZhC6bNB8vB1D2pdcy/pARj9R0xSiV2/
         mMLw==
X-Gm-Message-State: AOAM530hi959exRIbvFoP0QhHd4zh/WQUMFtJhjUU81KPkP9fvvkX4aL
        KfxOpD4ETXgVN2JmKgSiWrXOwXeukVofa8ctLvi7N/vv
X-Google-Smtp-Source: ABdhPJy7uFIV5+lrE7gBK7SPctEMJC24L4jYBDlad2eETPA1Z5nbz3jtZlBhl70yPpKENlFd5HPOJJILy09pztiCIBc=
X-Received: by 2002:a05:6512:10d5:: with SMTP id k21mr2443790lfg.552.1616524500970;
 Tue, 23 Mar 2021 11:35:00 -0700 (PDT)
MIME-Version: 1.0
From:   Linu Cherian <linuc.decode@gmail.com>
Date:   Wed, 24 Mar 2021 00:04:49 +0530
Message-ID: <CAAHhmWjLAO7EBEvcizFd1otDJDq8yesaA3FyDEYPWpuSLuy=Kw@mail.gmail.com>
Subject: Query on managing the order of commits in git merge
To:     git@vger.kernel.org
Cc:     Linu Cherian <lcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Had a query related to the order of commits in the command, git merge.

Lets say, we have a local branch(say A) tracking a remote upstream branch,.

A has the following commits,
A ---> 1---2---3--4

We do have another branch B, which is forked out of A and our
features/fixes has been added
on top of A.
B ---->1 --2--3--4--5--6


At a later stage, we sync branch A to the remote upstream branch
and it becomes,
A --> 1--2--3--4--7--8

Now, when we merge A to B, the order in which the commits are merged
into can be different based on date of commit. CMIIW

Like, case 1:

B --> 1--2--3--4--5--6--7--8--M

case 2:

B-->1--2--3--4--7--8--5--6--M

where M is the merge commit.

The query is, do we have control over in what order the patches gets
merged into B.
To be specific, is it possible to ensure that the local changes 5 & 6
is always on top of A,
without affecting the commit ids(ie. case 2 above).

We are not considering the option of git rebase, since it alters the commit ids.
Appreciate your thoughts on this.

Thanks.
