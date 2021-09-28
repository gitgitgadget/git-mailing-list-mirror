Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D609C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB0C61159
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhI1QyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbhI1QyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 12:54:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369FEC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 09:52:28 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l3-20020a05620a28c300b0045db8137fa9so79593042qkp.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qEhD/JCMI+xRyk6WRyzGZa2uYoDcHLWmsS6rFA7au78=;
        b=HQ6f9mDQ+s5lfc0NZeyT4nAcvkgN+u4e0e/IK0Q2avg4Hv765k849MZaMhnNfS3w1L
         RSFX1KWDSzhffHlORF4BqUrx/ms+K+yvS1sVSRCZf/n5r32mheb8+UiGF1U/XUDxUke+
         ajKDAwR5Kl147DNhQ1knI4qlzuEYMucoFI2qGxWst9fI/C6QFFDPaHxGInm99b1Yh2Np
         EWsWVW2EAG7BzD0EPZXuZYClpBYq5f6QZYtTd7MFS8mfAz/fXi5tZADmAUKCoDtX7MFR
         3asFPbK2ufhGyl3wd0XBM/wzErp/ytCDS64KL64mpM2r6ZiOYbo4G0ePN8x86QU7fwmR
         gjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qEhD/JCMI+xRyk6WRyzGZa2uYoDcHLWmsS6rFA7au78=;
        b=0RF4zhtKO5loH42TRoJmRLM2dmCoDWrYVM9EpvcEB7SHTN2A6Xrhn5VMbZ5El2mMDI
         U/qfuk5iZ/N6mPoowhNTiJV9VxpQ0fUUXpAofj6b+bnhr0hlKXOEveUZoBVoJ88AUU/7
         DA/pfcMUMhrnSOwPbiUvlNaobvcRLeYQ/usHi3k/cdAmX4e3znINX59OWD/5XqSBWeT5
         VB/tiSgBzftPWTjyGmhTR47dmZPt7QBQDgngLCunBEpD6saqm6IR3KqyqzusNk9YaWN7
         JTcdl1XRGmATOyayDWv5IX6knvSdIoiQpjI9mEU7FTuv/XSDe+1Iv4Ed9tFAdvC05728
         Xo0g==
X-Gm-Message-State: AOAM5320oSvZhbXjKAb1CgD2QCC+5ikWYQ6bHf22iMN5muJIK9c1PHRf
        8YOwtKSaG/kaPzWBuVFHeP5I/qp/epPKqA==
X-Google-Smtp-Source: ABdhPJzwY8HnarOfpbaqyzqY5BRtPZJp5afUExbLEIsVLqw7cQtuoIjOSJQtdlQb4lrA2Is7FKw/VUbz3RTNyg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:4c9:: with SMTP id
 ck9mr6942915qvb.52.1632847947363; Tue, 28 Sep 2021 09:52:27 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:52:25 -0700
In-Reply-To: <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
Message-Id: <kl6l1r58r6ba.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
 <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com> <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
Subject: Re: Feature Request: `git commit --amend-to`
From:   Glen Choo <chooglen@google.com>
To:     Carlo Arenas <carenas@gmail.com>,
        Aidan Gallagher <aidgal2@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:
>   git commit --fixup reword:$SHA && EDITOR=true git rebase
> --interactive --autosquash "$SHA^"
>
> granted it is not 1 command, but usually I find it useful to do
> several of those and then one single
> rebase at the end.

This is fairly similar to what I use, though I use this through the
Magit Emacs plugin.

My concern with "--amend-to" is that the semantics aren't as simple as
--amend.

With --amend, you know you're working on the branch tip, so
it's relatively simple to discard the last commit and create a new one.

With something like --amend-to, you aren't just modifying a single
commit, you are also introducing a potential merge conflict with every
commit after that. You would have to provide some kind of facility for
users to fix the merge conflicts. A command like git rebase --autosquash
does a good job at communicating to users that they are actually doing a
rebase and they need to be prepared to fix problems through a rebase UX.
However, git commit --amend-to communicates none of that. A user who
takes a cursory glance at git commit --amend-to has no idea that they
are potentially comitting to a rebase.

I personally think the current UI makes sense given how Git works. I
also wish that it were easier to do --amend-to, but I think the problem
has more to do with how Git manages merges and conflicts and less to do
with having shortcuts in the CLI.
