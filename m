Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B723BC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91653610FD
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbhIXQGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbhIXQGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:06:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BAC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:04:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t10so42256979lfd.8
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mhfW8oIRuyOK6vIfWhsYTBYFGlbypPQ5spLXImENDWw=;
        b=eA/nGgSRzxNMPKEMr/+6MFclAa3UzGBEUDWrGTik3WGu3jN4FihdM8k3e5YkOlK/oP
         k5Qq5sD+1CIK+ihz/Qbu/P4LNTfxi0Kg8LDiUojNkUYJfrJvixD0zbaU72qPaGrQKVWe
         uqyGQXY5pgPDwDMqjHjAqHmat/FSss6ziNhMkScJETy0WpQ8ujLytlXJsnXHinZdygz4
         y78dnEbGT+HgtMz/4+utFAqfrnIiTK4BuhSCH0RcN3q0jixTQAIySu4Gi6qxOyONqBiz
         iZZ76APA5y0AMzFk0QICk27+NXsAP2pm88jlbsXFhgRB/ooM8qrkSv7xy2L+iio+j7dk
         +TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mhfW8oIRuyOK6vIfWhsYTBYFGlbypPQ5spLXImENDWw=;
        b=1tQR9WTiG0esoS7ShPny7kvZ5j1eVu0zJIlNaMmmg9Hc6CiWDAULweYlVvdEBLMDwe
         JvhnEAhddZNpa9VYa5oBxJCFThyvAzBxgJapWgVAwfKKtfeALNrEVVKkxm4QEp4Plmo4
         2jHywCUxx4ht0kSTntrNEQnAsaX+3iuTXKduRq0LK7ijfdHljCDO0jI5ehVk7NYMb9b5
         LMvSKiOGKkKVxiISA6Cbbjc5yquN3I86n3D6yEG/PUl3cX8dh1oxIk0LvT/U4f6ousP0
         g4FFxD+Co/71BOQQT/PV51a9WgcbYWWl4cRx/6ZxMtUty/svZ2y5NGuFO9Rb466NSMA6
         XKoA==
X-Gm-Message-State: AOAM532BSTRxttcnIo/LUqdy11mt7Xm/ilUPWRGSNAyv6HD5N/K0BPg8
        5cL2SdZs2FZL+aGiU/355Tag1i+AaJYj+yvpdafYN1pc
X-Google-Smtp-Source: ABdhPJzyTZS9y0Fv0GQADf7KSIvt+bfJXa0s4GhIyilAtiQV/dUChTuH1To5v9ldoobwXjnqTOklhHua72xF+NvewBc=
X-Received: by 2002:a2e:a782:: with SMTP id c2mr12015323ljf.458.1632499485595;
 Fri, 24 Sep 2021 09:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
In-Reply-To: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
From:   Aidan Gallagher <aidgal2@gmail.com>
Date:   Fri, 24 Sep 2021 17:04:34 +0100
Message-ID: <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
Subject: Feature Request: `git commit --amend-to`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --amend` is very useful for adding changes to the previous
commit quickly.

Unfortunately, it is more difficult to add changes to older commits.
To do so I have to enter interactive rebase, mark the commit to
change, make the changes, amend the previous commit, and continue the
interactive rebase.

It would be nice if there was a single command to do this like `git
commit --amend-to SHA`

I have solved this issue for myself with this handy alias I found online
```
git config --global alias.amend-to '!f() { SHA=`git rev-parse "$1"`;
git commit --fixup "$SHA" && GIT_SEQUENCE_EDITOR=true git rebase
--interactive --autosquash "$SHA^"; }; f'
```

I think it would be beneficial if a command `git commit --amend-to`
could be officially added.

Thanks,
Aidan Gallagher
