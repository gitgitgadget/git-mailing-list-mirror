Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9DFC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 00:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiDNAHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiDNAHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 20:07:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD0DEE1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 17:04:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h14-20020a63530e000000b0039daafb0a84so1858573pgb.7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hu9ugPB0uH8yzABGk1R6MNg1xeMlY0iOghZQv2ZW5zU=;
        b=kBMsXc12VdgFJS2VvDcuL6qzMW7bf153n3HTjHLWn6ZmigkEkW/BSipVbXgKRupvSW
         6EZ9kOrrhBeOFBr+XwT8s3WJPbaRIxHY6OdlhqhmyEpaFK1vwxsk2JVld9H3FEu4Adq+
         SWIAuj4qtbza18bbmY6qnaVijvYtvxn/L7IdKZYQfzIXer8KNRy7LZfz//ar0648Esm/
         dSBEB1qh1Oac4tKRX+VIijgKalbeI3ntR1/2J1JUHxj5IjZ+S2TeE6pNH1nMY/aSJcy1
         jro8Oec4rz0c0w2sm0Z0LnNTd0Uvmbd5VsW8AyzAyBIp7jfkZVzpoW+YBk8C8Qq2T6Pr
         p4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hu9ugPB0uH8yzABGk1R6MNg1xeMlY0iOghZQv2ZW5zU=;
        b=7AJt7GwzwNHukijrVxvWHYszb2kygcsXwiwUDqxsjNmCLU8Ktkgb5lwnOKRL8Xjamj
         b/3BHxV/s3HvDQTRTkkgMd+qnhiklBeUEboNglPT00bKdeLmwDco4Yec5pygCRfz2ndD
         suwmjR1nC+T/Uo/N2h21HMMHXQmN9fqY0KYshkuP4oJB43UXfiPgpcQGot4T54yuB15E
         /bRi7CvFoA330+UW28SQs7pAbqtOZLXIjFR8bHAxr/2f/HpxJSpnChu4Ojl53BYTTfN6
         mQmjYMKegz4XegXX8mx+C7F9rD5FR6/9QXrS31fCPSkIdtnH7jNNUDuOIP/U0KQmKjNR
         tSbw==
X-Gm-Message-State: AOAM532cQWLCimWNji1z4OWlS5IzS6gz8V0375LpFT2HkM8pRiQVcPcL
        5k5vi5BZ8dw/YkyTYCm0+q5tRXLNTzrM9Q==
X-Google-Smtp-Source: ABdhPJxW0HEpimW+Eln3QaY0zJiGTdAIkxbepom4ctafZA2VWvyusAjwBQqjGxsicQ18RcIECGJUWUo0G9HHIA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:2384:b0:1cb:5223:9dc4 with SMTP
 id mr4-20020a17090b238400b001cb52239dc4mr133078pjb.1.1649894681738; Wed, 13
 Apr 2022 17:04:41 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:04:39 -0700
In-Reply-To: <xmqqmtgwp1aq.fsf@gitster.g>
Message-Id: <kl6lk0bs8r8o.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net> <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com>
 <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net> <xmqqmtgwp1aq.fsf@gitster.g>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Justin Steven <justin@justinsteven.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Then we'd probably be better off just walking up the entire hierarchy
>> and excluding worktrees from embedded bare repositories, or otherwise
>> restricting the config we read.  That will probably mean we'll need to
>> walk the entire directory hierarchy to see if it's embedded (or at least
>> to the root of the device) in such a case, but that should be relatively
>> uncommon.
>
> I find this direction to notice iffy "user data" and disable it
> quite reasonable.  A configuration file can define alias, and it
> would be yet another attack vector to overload common ones users
> likely use ("git co", "git st", ...).  There may also be a hooks/
> directory.
>
> I wonder if it is an acceptable defence to deliberately "corrupt"
> such user data when we notice that they smell fishy, perhaps by
> renaming "config" and "hooks", when they are found next to "HEAD"
> and "objects" and "refs", to "config.disabled" and "hooks.disabled"?
> I am just thinking aloud without assessing if it is sensible or
> feasible at ths point.

Interesting idea - so the final result for the user is that they can
check out a valid bare repository, but it will not have anything
"sensitive".

I suspect that it will be difficult to define "will not have anything
sensitive" in practice. e.g. Justin's original article [1] shows how
.git/index can be used in surprising, malicious ways. And if we're going
to corrupt the repo anyway, it just be easier block the entire bare repo
from entering the worktree by default (but with an escape hatch for
users who know what they are doing).

> I am not sure if "walking the hierarchy up" is an effective enough
> defence offhand.  Do we consider it too much social engineering to
> make the user follow cloning instruction of the malicious project to
> prepare a repository, with core.worktree set to elsewhere, and pull
> into it?  Since walking up from any subdirectory of the directory
> the core.worktree points at will never see a directory, with ".git/"
> subdirectory that is the malicious project, "git status" run in the
> "embedded" place in such a scenario will not notice that it is a
> repository lookalike that came from outside.  But we can write it
> off as an approach needing too much  social engineering, that's OK.

IMO that sounds like too much social engineering :)

[1] https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bare_repos_and_fsmonitor_various_abuses.md
