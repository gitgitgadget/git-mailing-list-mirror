Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665AC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1882072A
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 16:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B71jKGub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFQkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:40:37 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:39120 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCFQkh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 11:40:37 -0500
Received: by mail-pf1-f170.google.com with SMTP id w65so816787pfb.6
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4NP5xq8e+xu0xLRY1Sh/ugow7RlHzCCI+wCuWfnG6VY=;
        b=B71jKGubVBEffPzsXFeRk7/vflNbZ6tKkknsrXfJIJP+P0eDQJRdJu1Q2Gk3SGlIQp
         q0Cuq5lB0RU7DibTvz4/v6IwiFdJnF74L7LYJ3ekv1uYDIrd8QGqZghJmW3M06dRKXW/
         2RLRGrBkod6vdN+BpCuGiZQNox4UGWB6UB0eYZAE6mFZCsoXeo0Ssd0AeKv9e0l5CrMJ
         tb4Zb5aD9vI5P7Skkxn2Kp+lWvpDr3LmsqjGmYsLe7HYiwEGTXJVzfszz0NCfHWzQHYv
         mfWVuETnPQts2d7LzMrEWA2fKrap9ElUcU4cdil+hcH9nDLPgxq8m1yQlKrd7r37JEJJ
         mgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4NP5xq8e+xu0xLRY1Sh/ugow7RlHzCCI+wCuWfnG6VY=;
        b=SiHWJmfO1MWErhcr3GO/5y5KjmRkL1ieVYcMhvU5MuVjOgSFoWQobcVM+3ec8sulN0
         RjJe541okq91PLfz9debPb+MouIxx26E/zyj7SsJ7oKoaDbJC7SzhC+0vQHW6V2isj07
         ifDkUUihIrTK9V8MgErc6S5RJnTWpUswIhlXcIR6Qx9MvMhcOlPeEzZDjCburC4Lqdmv
         +khVT6NxqQnyhNl54ymGl385NAe942fNpOQGLF4pI56mXoEC5gB8U9dUxmivyb+THuhB
         F1ccqGghtjie3w5qKsTmOhI3WRDAWjJlbvNJ8/8sc2FXDMXqLOb4h4Fz8/CEfmqkuz4P
         GeQA==
X-Gm-Message-State: ANhLgQ1rIoZhvM6ferwWwNLJbu/4WeqDTbiDwRk/+sYlAZ1BbWOheJ2d
        N9KBMvieFSGTkDP19UQzqOP0L7Tt
X-Google-Smtp-Source: ADFU+vsFY9gERpW3SGV8JyBjGznNKO7iczkvbjfRmEf80ps+dDVoFAwFr7a7SmQ2AZt5J6+WhrcUvw==
X-Received: by 2002:a62:2fc2:: with SMTP id v185mr2018237pfv.192.1583512835494;
        Fri, 06 Mar 2020 08:40:35 -0800 (PST)
Received: from [100.70.86.73] ([12.129.159.194])
        by smtp.gmail.com with ESMTPSA id x12sm26566380pfi.122.2020.03.06.08.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 08:40:34 -0800 (PST)
Subject: Re: Git Merge 2020 slides and reproducibility
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <14db3e6f-6919-aa58-7084-e4404452820c@gmail.com>
Date:   Fri, 6 Mar 2020 11:40:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/6/2020 10:00 AM, Elijah Newren wrote:
> Had a few different folks ask me at Git Merge about slides for my
> talk.  I said I'd post them on github somewhere, but in case you were
> one of the folks and have a hard time finding it...they are up at
> https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

Thanks! I guess I can post mine, too:

https://stolee.dev/docs/git-merge-2020.pdf

> and steps to reproduce the speedups I got can be found at
> https://github.com/newren/git/blob/git-merge-2020-demo/README.md
> (though be forewarned that the code is has lots of fixmes & ifdefs &
> other problems, has awful commit messages, etc.; I will be cleaning it
> up soon).
> 
> I know the "suggested" way to make this stuff available was on
> Twitter, but I don't really have any much of any social media presence
> (I can't even access the blog I once had) and don't want to make a
> twitter account just for this.  (If someone else wants to repost my
> slides, feel free.)

Done: https://twitter.com/stolee/status/1235968445637771265?s=20

Thanks!
-Stolee
