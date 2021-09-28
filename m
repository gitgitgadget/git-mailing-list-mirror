Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F37C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BBC60F46
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhI1Hd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhI1Hd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 03:33:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C322C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:32:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k24so20272964pgh.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56f/kM8mScFIYvDaIp1mQB1qYz6kx4lt3KokqP2sJ+4=;
        b=hFtuWAa3eCMOP5NZ8z9fA8+1ztxgrGp41qWSykzraNeS9Dd5eKeKmLau42Ez5538Cp
         /SzpxqjQO2hlu2twQkCsy1jRhfKEkBoUW2gvzQGaZM4q/+V7QjAndI7ydh26ID4uYcQp
         e8UNNn6SN89JUtxWbj939hRvpLar+9dcmdC9f1fxK09xHmwfc3W3aM5lVn55JBMXshBY
         i34nhufy3ch0dUfx+4BhdPuwtRHfAu51RDimfntVQEu2uUBAp4EH4lhHD5n7xUPF5Ll/
         a7Uv86DKStrlXoANADnFZ/d1e7r9VWmFlH3weU+UW0T9RdTtwQa5PTZ+tPGluWukCea+
         9nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56f/kM8mScFIYvDaIp1mQB1qYz6kx4lt3KokqP2sJ+4=;
        b=wD9Fvd73YoCZw1ydpODUk5Es4g/Y+3xHnLWV37Mom/zF5RPeXnIAYPA8tX1H4cl7q8
         Ku4RqoOSmOsnz+S0hgIoHAWx8OGNTJ0ulZbEPioxoy8aNKKe0thBYqHWeekq+sFfJF52
         CctYitatJiakGjftVjxBk4IGKroh4lfnPWeHKw5KGkBZ2VoSXxFv/tt8XTCOL2m9bB3P
         AGlhEeETQRmzNZ7+hcU60UGN8Uh9tyTWpS8wCXj/ixjn3WW16ASbYU63W8r7/FsK+Fps
         OjGvjyECXVl09xPRvzenJnNShbwaaU3HArioj57afonnzwVjale/rLtfix3lXs6iZT3K
         4WQA==
X-Gm-Message-State: AOAM532tFhNf9eprsgU18IfeLwX/rYILem0l/ATSHaQc8f9cWo+9MvEz
        05EaBswXSzRS4psQ+XKuRs+2/Ndr5IQx791fjeWwRQ==
X-Google-Smtp-Source: ABdhPJySSfq9SAT73FmlgKyEAbt0q8JemrGwjL2YdgKKyNmHHpIelMwV+v2PulKlLT9fkuwMRil6ktz0u/IrYbD3va0=
X-Received: by 2002:a63:7405:: with SMTP id p5mr3315240pgc.426.1632814336720;
 Tue, 28 Sep 2021 00:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
In-Reply-To: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 28 Sep 2021 00:32:05 -0700
Message-ID: <CAGyf7-FBgmRTmjKFjMi2p5MArGEQh9a4Z6RA6FO-2U4D5jGnmA@mail.gmail.com>
Subject: Re: Issues with newest version of openssh 8.8p1-1
To:     Kevin Kendzia <kevin.kendzia@googlemail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 11:40 PM Kevin Kendzia
<kevin.kendzia@googlemail.com> wrote:
>
> Updated to openssh (8.8p1-1) and git didn't get the keys anymore.
> Couldn't pull or push. After reverting back to 8.7p1-2 it works as
> intended.
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Updated system packages (openssh)
> What did you expect to happen? (Expected behavior)
> Can git pull without issues
> What happened instead? (Actual behavior)
> Permission Denied due to key error
> What's different between what you expected and what actually happened?
> I couldn't push pull whatever because the keys haven't been recognized somehow
> Anything else you want to add:
> I reverted from openssh 8.8p1-1 to 8.7p1-2 to make it work again
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

Ultimately this isn't a Git issue; it's an SSH issue. My guess would
be that upgrading to OpenSSH 8.8 picks up the change to stop using RSA
signatures using SHA-1 hashes by default.[1]

You can update your ~/.ssh/config to add these lines to revert that
and allow using those keys again:
Host old-host
     HostkeyAlgorithms +ssh-rsa
     PubkeyAcceptedAlgorithms +ssh-rsa

With that said, though, if possible a better solution is to generate
new SSH keys using ECDSA, Ed25519 or another stronger signature and
switch to those.

Hope this helps!
Bryan

[1] https://www.openssh.com/releasenotes.html
