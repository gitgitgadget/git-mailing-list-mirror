Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF0C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4105022245
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJnzmjoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKBSa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:30:56 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07524C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:30:56 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p7so15928141ioo.6
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rxL4knbf/9Wxvz2xUxPDKTWNWocpdg9k3IKMKmaZ4kQ=;
        b=CJnzmjoXQhhPfeq6eyUKRVBEnBgIxGzl2MNI+WDJM7Rr/yN+/+KoLa4P9k1Uv9wdRr
         HewHOQGgIflKDNeKrW4jwUMu9OlWpwq9Dd8f0OScT7rwL6smh2Qa25ooYJYCS16Z5QHo
         RtMYbQSaGo8yBsiShlq8iv+CBOE6IDK8LXdgQ7xnTn5L8i5BmdvCEs85+Wbd7I3li3eo
         k34/ycpRpwB0pXpgvGjtPI83G7uIHJzaMM6Fy5lf5OTrBIGms+xCvvWND7YcoZVWyxVx
         bCe3BpERzFJvUlE7gjqp0l/PapDvZVlgSsTTpz3MRbA6raX54r0BBl4+54HcDCCsjODc
         delA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rxL4knbf/9Wxvz2xUxPDKTWNWocpdg9k3IKMKmaZ4kQ=;
        b=WqigqR5mfGci5TLECmSWpSIA//0gBuI/IQdVfXAmncrgYoElAhq4AYpvrHvk5DpNJH
         AW3+PKqvOaPTXvnX7Q1UlwvHPG6dHQRAcAYVJykrRfYRrVYtHLRZr+HA6QSyajW+FFgY
         tpWqRF7qid0TcxixkRgEK63YtpLn6aAdVyA+rx/JXk1Ql8TWMrq4bBFWvI5+C7MaQ2HE
         9r6bMeu+O2j6pgvxq1eNihJtHCxh1BKdh7TNNqJu+LtolLp3TZtzsKNsWbcUwVjHM1e7
         db6Je7yeDwor1kJGTwGmbo8rVlLyjywTZf859kfXIun4VsEaHv8ROQUxSGSqboDDLPlj
         geHA==
X-Gm-Message-State: AOAM531Rz/dK2mB4Jr5/clTKZgqLagWUYq9+NEfAelqcTt+x/DNRtESh
        6IIYegUPd+w4ve9KF8rksJiw1C58UGbKOmF7G6D7o93kccWJSb63
X-Google-Smtp-Source: ABdhPJyVwi2E/Lzco0z/4Vi397xbB5uUyC2J1ykvYO0LX0E9G4gX5j99MZoBE/km+aguEMBOD4j6Sw9snjkElr5sD90=
X-Received: by 2002:a02:3716:: with SMTP id r22mr12401529jar.12.1604341855196;
 Mon, 02 Nov 2020 10:30:55 -0800 (PST)
MIME-Version: 1.0
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Mon, 2 Nov 2020 19:30:30 +0100
Message-ID: <CAFzd1+7xQHgaOYKW7WZaWCPdp85Pfk8k_M-gVtBq6Wf7bbJTzg@mail.gmail.com>
Subject: BUG: commit-graph.c:1068 when doing `git pull`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

I'm stuck with this error message

    $ git pull
    BUG: commit-graph.c:1068: missing parent
104f5eb377763b2ed9663e8949aed265b69f000f for commit
c59ed9b7b6d4268ae6cb1069a9b51e02ad9aa1d8

This happens since the last `fetch --prune origin`.

If I do it again, I get

    $ git pull
    fatal: Unable to create 'C:/Users/c-flo/AppData/Roaming/Sublime
Text 3/Packages/GitSavvy/.git/objects/info/commit-graphs/commit-graph-chain.lock':
File exists.
    ...

And upon removing that file, I get the first error message again.

I actually don't know yet how to move on from here.  I'm stuck, so I
appreciate any help.

    $ git --version
    git version 2.29.2.windows.1


Regards
Caspar Duregger
