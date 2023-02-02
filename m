Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE547C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjBBRGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjBBRGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:06:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E1B45220
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:06:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so6219048pjq.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDpYAtbrKPMZlRIhNixP+yBYFnRLh0cbFkblJC+pl7A=;
        b=Zwfrvna+Q3dsP7/upeMyLcx5MTsKXVSEE2YbvM9AO75b+dSXcBp6rNwx5IhIgKfDC0
         cpwe2IFPWLnv4GhPYUF3ahc4EtjMV+BkGoBy0Nx4ms3dlv8dwzxD2zQnPG2UOOlXoM4i
         7m7acQAFfH0BQo/ALY8ASgUuuu2XHZboxXpT7U2k/ph/RkqiObD61Zx+/t45t4h7x5S9
         KmD1UfhhYq8mVYGf4CuRqq+6vN0f9E9/HPrbth34IgUJANhnaHk/XCbzwwIWga0Lwlqm
         F107+LRLJcdM/drni21u/ZDD3xTZF+ff8OLaoHXaKAhgaNmJ5IJ7f29Fx2rh98IPZW1i
         6VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aDpYAtbrKPMZlRIhNixP+yBYFnRLh0cbFkblJC+pl7A=;
        b=qtnqcm4wqEAlxxPzM/U3AXBKQ2uQJp/nw8L7AkNj2ovELmeQyJBdaXwq9LcGg1FCX8
         gTlUlEwkUGWgle8lOOcVAM2JulI3aBzeeBOVsH3U3SFy8wGCsyTjynSbdG1EizYjK2UG
         H1suRk6+s+dO+T7e+1L2KUzJBZoJi2TMp0aaOq0iSzz0ZJBamUTA0COnN01W4CVmBd/3
         SgsCjkSASM0PJlNJQ/UhLbL3gh9H+/SphIPi5PfoINzrBN5UKNr29q96DYMx8LMZpfcV
         X9LIzMyx5mVlQoj4QPFFUuKC6uizhvszsHw9akb6AzTzBKty/UNTcO3HZZ78/lVGv9IC
         YUFg==
X-Gm-Message-State: AO0yUKWIcEhExx0Poq03LUtQNoa4UoX3z7Zd7QwxYMgWIOpJPirKJbN1
        GSs0Di5iwVwEza7drrK/8cY=
X-Google-Smtp-Source: AK7set/adthwBHAeAegzoBvcsYb/JA2RQNslKJSckvFEIbDudHEfIzpJRuMJXbKagjxmnr9vG+vr2w==
X-Received: by 2002:a05:6a20:4281:b0:be:b220:bf78 with SMTP id o1-20020a056a20428100b000beb220bf78mr9660124pzj.30.1675357569306;
        Thu, 02 Feb 2023 09:06:09 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id q7-20020a63ae07000000b004da5d3a8023sm7966pgf.79.2023.02.02.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:06:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Is GGG mislabeling topics?
References: <xmqqpmba1ld4.fsf@gitster.g>
        <52c9ed08-43c3-80c6-32f6-42209b799af6@gmx.de>
Date:   Thu, 02 Feb 2023 09:06:08 -0800
In-Reply-To: <52c9ed08-43c3-80c6-32f6-42209b799af6@gmx.de> (Johannes
        Schindelin's message of "Thu, 2 Feb 2023 15:20:24 +0100 (CET)")
Message-ID: <xmqqk010uhdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 19 Jan 2023, Junio C Hamano wrote:
>
>> These comments from GGG bot
>>
>>     https://github.com/git/git/pull/1435#issuecomment-1386301994
>>     https://github.com/git/git/pull/1435#issuecomment-1386302018
>>
>> add 'next' and 'seen' labels, citing merges e3ead5f and c52b021
>> respectively, but these merges are of a topic that has little to do
>> with this pull request (#1435).  Is this expected?
>
> Since I could not make `amlog` work reliably for GitGitGadget ...

"git rev-list e3ead5f^..e3ead5f" (as the comment claims that GGG saw
e3ead5f merged this topic) should be able to identify the individual
commits merged, in this case three topmost commits from Peff leading
to 6c065f72 (http: support CURLOPT_PROTOCOLS_STR, 2023-01-16).

> What you see in action is that this is imperfect. Because in the absence
> of actual git/git commits that correspond to the GitGitGadget Pull
> Requests' commits, `range-diff` will even identify replacements or
> alternative patches as the git/git commits corresponding to the PR.

Hmph, so the three topmost commits were mistaken to match the
patch(es) on this branch.  That's sort-of understandable but not
very satisfactory.

And amlog seems to know the message ID that resulted in that topmost
commit that was merged to 'next'.

    $ git notes --ref notes/amlog show e3ead5f^2
    Message-Id: <Y8YQUD8bMHc4Lmph@coredump.intra.peff.net>

Perhaps GGG can be told to recognise that it is not one of the
messages it sent out before, or something?

