Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85861C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 05:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5367220801
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 05:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxcDgYJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgFJF52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgFJF50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 01:57:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590FC05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 22:57:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gl26so1131541ejb.11
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 22:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gk+rBX07Se09Tyxk9lKuyCifkNMNM2xtpHxHa4GC66o=;
        b=IxcDgYJEny5IP0ZMhvz6znMPEQ7o5RaDkuWvcBTju3OWXLkl/uwtJZltB+dScuqoJe
         VAsXdQjFxtYdAJo9xtGpOrkkRnCtDLwHf8YjS25nQx/KMaJvbtVIg1x7VlVS/dNC6fP8
         AXRZN5WqePvdTcyj3czydUiM/agWKtDNHkLkaft3iAi0wgxhMbLr6Q6V0pseF4gHRWCa
         whqm+OwxfMifiZoIdnS++P4ADCG8/6Tjc3yJR6cFFCEQMiHbvNuemLq+8Ol0mmCeeec2
         sQZRNG+gnj9LSFZQ1V59EXS6FlXFaGk5FkmuKJBaAOXywNVPpJBMv+GoCW2gtr4HWAJl
         OaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gk+rBX07Se09Tyxk9lKuyCifkNMNM2xtpHxHa4GC66o=;
        b=U8g+dxdHq7XvcNsPgJdTXAqiNw+/On54EnVwsB2Iq9sgzaOu8zppQ9DLDRJuV+/zQL
         sViDqwA4nMRqLTsumg/Maw4t4n7SVYTOFX8ryVkNA9oIO6swqdo1sosmY2ujcjuVh44M
         BqKl8DqpWQxAgO2sCCyMEwQTc/tSZ4y0Scs6tDEABmxPPYb3tuTImTWzlkJmkGUYELUi
         hsAGqScJZx+6kdP95oDvgfBw3l9WZTzkfVwyoeXKAMAe1ZfeuhUjv3pOmNVl2rIxWtL5
         K4dIDU+GYk02UOLsP0L93MT2aOw7pq/3rytdIpE48MGqM028hSK7WR4zhzI9WjWtkYCX
         iwgA==
X-Gm-Message-State: AOAM533l/rHO/sree/xUGBUS9QgI/ZIRDvPbY1xBUNJ8G4YTuT4gJ8JG
        0sUS9rxKgq824EtquKW7e/wAoZrzNRwL3gGzGCqa8sZ1PW8=
X-Google-Smtp-Source: ABdhPJwMylSaJlErr3u0C/943DtK8Orz8Y4q1hvDwKimAtVu31TwTCwiitj7lAX8qB89f+vC5ppyZldWkmHnSM+fFQA=
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr1843387ejb.201.1591768644656;
 Tue, 09 Jun 2020 22:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB88a39G-GkGu1LuRE8na45Pav_cWb3cJLQFJM+FuW3BnromA@mail.gmail.com>
 <CABPp-BHv+5XSXMpZ=-kM=a3C0Y+v=JY5m11s-QWj_krjCvvO4g@mail.gmail.com>
In-Reply-To: <CABPp-BHv+5XSXMpZ=-kM=a3C0Y+v=JY5m11s-QWj_krjCvvO4g@mail.gmail.com>
From:   Brian Malehorn <bmalehorn@gmail.com>
Date:   Tue, 9 Jun 2020 22:56:48 -0700
Message-ID: <CAJB88a23uU2WfB0mnB9NfNbtgmABhNOWNOEMBt7rRVu7uL_C9A@mail.gmail.com>
Subject: Re: git stash --include-untracked walks ignored directories
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, my original message was a bit misleading. I believe git slows down
based on the number of directories, not the number of files. Here's an
updated version of your script that creates a lot of directories
instead of a lot of files:

#!/bin/bash

rm -rf stupid
git init -q stupid
cd stupid

echo ignored >.gitignore
seq 1 10 >numbers-tracked
git add numbers-tracked .gitignore
git commit -q -m initial

seq 11 20 >>numbers-tracked
seq 21 30 >numbers-untracked

mkdir ignored
cd ignored
for i in $(seq 1 50); do
  for j in $(seq 1 1000); do
    echo "$i/$j"
  done
done | xargs mkdir -p
cd ..

echo "Number of directories in ignored before: $(find ignored -type d | wc -l)"
time git stash --include-untracked
git --version
echo "Number of directories in ignored after: $(find ignored -type d | wc -l)"

----

I got it to reproduce with the versions I have handy:

$ ./repro.sh
Number of directories in ignored before: 50051
Saved working directory and index state WIP on master: 0dabddf initial

real    0m0.023s
user    0m0.012s
sys     0m0.010s
git version 2.25.1
Number of directories in ignored after: 50051


$./repro.sh
Number of directories in ignored before: 50051
Saved working directory and index state WIP on master: 175d4ce initial

real    0m0.619s
user    0m0.157s
sys     0m0.452s
git version 2.27.0.83.g0313f36c6e
Number of directories in ignored after: 50051

On Tue, Jun 9, 2020 at 8:21 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jun 9, 2020 at 1:39 PM Brian Malehorn <bmalehorn@gmail.com> wrote:
> >
> > Hi,
> >
> > Not sure if this is the right place to send this, but I'm here to
> > report a performance regression with git stash --include-untracked.
> >
> > Here's a quick way to reproduce:
> >
> > 1. make a directory with a lot of ignored files
> >
> > $ find ignored -type f | wc -l
> >    50000
> >
> > $ cat .gitignore
> > ignored
> >
> > 2. touch foo
> >
> > 3. time git stash --include-untracked
> >
> > git version 2.26.0:
> > real    0m0.094s
> >
> > git version 2.27.0.83.g0313f36c6e:
> > real    0m1.913s
> >
> > This is a much bigger pain point on my work repo, which has 1.4
> > million ignored files(!). As you can imagine it takes a long time to
> > run git stash. While it might be valid to question why anyone would
> > need that many files for any purpose, the bottom line is that I told
> > git to ignore this directory, and it didn't ignore it.
> >
> > In the meantime I've reverted to 2.26.0 which doesn't have this
> > performance regression. Let me know if you want any other information
> > related to this issue.
> >
> > Thanks,
> > Brian
>
> I seem to be missing some important step to reproduce; what else is
> needed?  Here's what I see:
>
> <Set path to use git-2.26.0>
> $ ./repro.sh
> Number of files in ignored before: 50000
> Saved working directory and index state WIP on master: e2b0471 initial
>
> real 0m0.029s
> user 0m0.014s
> sys 0m0.014s
> git version 2.26.0
> Number of files in ignored after: 50000
>
> <Set path to use git-2.27.0>
> $ ./repro.sh
> Number of files in ignored before: 50000
> Saved working directory and index state WIP on master: 5c596b8 initial
>
> real 0m0.052s
> user 0m0.014s
> sys 0m0.034s
> git version 2.27.0
> Number of files in ignored after: 50000
>
>
> Where repro.sh is:
>
> #!/bin/bash
>
> rm -rf stupid
> git init -q stupid
> cd stupid
>
> echo ignored >.gitignore
> seq 1 10 >numbers-tracked
> git add numbers-tracked .gitignore
> git commit -q -m initial
>
> seq 11 20 >>numbers-tracked
> seq 21 30 >numbers-untracked
>
> mkdir ignored
> cd ignored
> for i in $(seq 1 50000); do >$i; done
> cd ..
>
> echo "Number of files in ignored before: $(find ignored -type f | wc -l)"
> time git stash --include-untracked
> git --version
> echo "Number of files in ignored after: $(find ignored -type f | wc -l)"
