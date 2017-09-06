Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CF7208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 01:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbdIFBnn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:43:43 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34926 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbdIFBnm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:43:42 -0400
Received: by mail-ua0-f169.google.com with SMTP id c27so11458546uah.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HK5++7FKbETcIsQtvPZoDF29oQ8hwBKPb52DCerDxEw=;
        b=zktpf+lOHMuTkpSv5e668nQhTT0Vk5IipObUfJ1YWXdoUCo14LpXYt/7ZQ3UuT6aO2
         TUZvCmhfWe1zyF7SALSk/wI+mXlo1t1Sr7wsQw2qtYvASaSxv952TVaHJ8RIuyXSLrm6
         v0TM3OtylUFDTlV53vS98VypmwHOpiANF5EsuZgkx06CD2vEE40bpVkSsIP157DAO5xX
         iCpTtopyDqIlZgVdxhzl2X/yo2m6/VdjNcazYes8RUu9EG+2nSnoejnLkBYC/KtFepK6
         UDikOTFzVY+vrrFHeTuYuodEAbhxcqlWUJC9jL+UBukHWUYabobh12RX2kCB9aSaiyiY
         n/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HK5++7FKbETcIsQtvPZoDF29oQ8hwBKPb52DCerDxEw=;
        b=aU9URF31icXh1YXHgX9TBb07PGPTmMZwXUtkda9IQGLKtR2b8qtolJf9AYFVgxPMyq
         lrdmb80Pu//NjlBKaK9G5c+yNMVbgKYW6viK8gypFbVDLd2MTBy8lUq0bcRIVGUA+PzR
         FmQ0VyRmtq7/+V4L8oA6zT3vUAnVmp7oHx7FzNnfzR1ZtF0K7X4gAvqOaYgRVbgLPUxM
         NfkWIYNDQ2V897rAzHC5yHe+oYu4jmcQO38A+80woOYkr5N1+xSJKKs0SAmiTR0gNL0x
         /DVSa6E0aVgIpFxlacnnASSasa/aulWawWtN773jetTp5L0sVhm5Xyv+6eNOIVJMsnIo
         JtMQ==
X-Gm-Message-State: AHPjjUhFvU7Pee8edkM36OXZ9991MjB9B0igCYVGBK3oIrPp9Pf1tPXz
        9KwI2Lz4kJzFz8RYhib8ofNJejKzCFta
X-Google-Smtp-Source: ADKCNb5kebYpj9FatHShnGbXesIl4U7EWgdsNt12CXtK0q97aOTdgWEvT09TzGvBEYYsh2qh0OsVMaysOG+WRvMFnIQ=
X-Received: by 10.176.7.3 with SMTP id h3mr758460uah.66.1504662221848; Tue, 05
 Sep 2017 18:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.72.226 with HTTP; Tue, 5 Sep 2017 18:43:41 -0700 (PDT)
In-Reply-To: <92605DF3-9274-45A6-88B7-6281D192203F@google.com>
References: <202EE2E2-1D0B-4772-85F7-7C7804905297@google.com> <92605DF3-9274-45A6-88B7-6281D192203F@google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 5 Sep 2017 18:43:41 -0700
Message-ID: <CAGyf7-EVoqV8VCvnpmGivvuQ7MHN2X2mPG7ioAWouGEtAh-ibA@mail.gmail.com>
Subject: Re: git merge algorithm question
To:     Daniel Biran <dbiran@google.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 5:53 PM, Daniel Biran <dbiran@google.com> wrote:
>
>>> I'm trying to better understand one of the merge algorithms as I had some triumphs and tribulations with using a set of commands during a merge. tldr: can a git merge -s recursive -X patience; // result in a fast-forward merge? will --no-ff stop it
>>>
>>> So, the scenario is this:
>>>      - Merging a master branch into a feature branch that is 2+ years old
>>>      - We found this command was more beneficial when merging a large 20k line text file:
>>>              - git merge -s recursive -X patience master
>>>      - In a recent merge using this approach the reflog shows that the merge was performed using a fast-forward from the feature branch's head
>>>              - 082517-1, feature/branch) HEAD@{23}: merge feature/branch: Fast-forward
>>>
>>>
>>> My question is, is it possible for that command to use a fast-forward like this? (or did something else go horribly wrong? possibly an atlassian git GUI tool corrupting the work):
>>>      - If it is possible for the command to fast-forward the merge when making the commit does --no-ff force the command to never use fast-forward in this case

Unless you specify --no-ff, git merge is always free to create a
fast-forward "merge", even when you request the recursive strategy
explicitly:

$ git init recursive-merge
Initialized empty Git repository in C:/Temp/recursive-merge/.git/

$ cd recursive-merge/

$ echo "Test" > file.txt

$ git add file.txt

$ git commit -m "Initial commit"
[master (root-commit) ad48617] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt

$ git checkout -b feature-branch
Switched to a new branch 'feature-branch'

$ echo "Edit" >> file.txt

$ git commit -am "Feature branch change"
[feature-branch b226557] Feature branch change
 1 file changed, 1 insertion(+)

$ git checkout master
Switched to branch 'master'

$ git merge -s recursive -X patience feature-branch
Updating ad48617..b226557
Fast-forward
 file.txt | 1 +
 1 file changed, 1 insertion(+)

With --no-ff:

$ git reset --hard ad48617
HEAD is now at ad48617 Initial commit

$ git merge --no-ff -s recursive -X patience feature-branch
Merge made by the 'recursive' strategy.
 file.txt | 1 +
 1 file changed, 1 insertion(+)

With fast-forwarding disabled, you can see the recursive strategy is
used as requested.

>>>
>>> Thanks for the help,
>>> Daniel
>>
>
