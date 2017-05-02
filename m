Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9D4207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbdEBA0S (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:26:18 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36714 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdEBA0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:26:17 -0400
Received: by mail-it0-f49.google.com with SMTP id r185so40059914itd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jfGWRQ4MU49/ttKFNkJoR00d0pRDHrKcmBEchQZ+7DQ=;
        b=aR94D9rkbx8scdEx3EY4IBORFUnKJmhIaeCqjkuRSRS2s+qzFDeSZ7aWiljwAVnu3J
         iKJ/9XSbzaz15K/qDJ54PMZRj3HKSe7tsZBcP2nl4GJe9eUBjh8KdRAg92niFQClORTu
         6RQlx2uhr4zdfJlIY6VivX3saXpfTsnfLlk2Jjo1En9oYQMCpo5XU3SYVhz/yVFs/8y9
         Z4gjv+WeK3v+9ysSYK2WJtxWO3jBK5rCInk9QYq/AtPlPaTGLrIrbTJkDxIlf2aseeN6
         eA8EfEV/4INwn3hugVvIvCgMs0iaEgd9lnBkIH2NwV/Cgu7tSFlXjos6zw3sHZ6N5Uwv
         /e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jfGWRQ4MU49/ttKFNkJoR00d0pRDHrKcmBEchQZ+7DQ=;
        b=d4nhPEei4fyxG4r8U8/GsnZrxwCged7vFB2AZPEQe2l+DdBelI7Xd5d+1qxnBt57lY
         SxhHRAr+/hBLKbRm9qS8pAA2C7kAmUc1v1bxak0UPueGX3ihM0ujCvFY0n0Gvk1oc7VQ
         t2tNhZqoGFhJUz3g/sG7PHqm5A+Y12vFVuEIgot0tsjxSqmt5si1kEp4tBzEberuUAOc
         dtzktySzbcrDSym/ZLwxnlQHjLa8LSY5tKyyFi/XWv5CZqIwb8TQI3akStoh3SltQ5m9
         xs4EyS6gsHz+gTSFJVxGH5r8/LKKvakcb9vo4CXUE7RiR4aD8t+JKkehP++WDuR0SmJL
         Q5Qg==
X-Gm-Message-State: AN3rC/4D32lNuF6qCg4b2httzfiCAu8PEPNJWNoa5Rgj7A0du4sZJ9nG
        7tM8i8sHrIzGgg==
X-Received: by 10.36.69.106 with SMTP id y103mr408535ita.30.1493684776214;
        Mon, 01 May 2017 17:26:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id 15sm7089040iok.43.2017.05.01.17.26.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:26:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Chris Johnson <chrisjohnson0@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug Report: .gitignore behavior is not matching in git clean and git status
References: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
        <xmqq60hljqud.fsf@gitster.mtv.corp.google.com>
        <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
        <CAJZjrdXfcaUrJXbAoPtRtvigouZ2eNyNsZ=2WtSY20_D+Ow6qw@mail.gmail.com>
        <CAJZjrdXVopdvDoDwnsmqvrLESKQq=-a2waDgu5HYYoP2WvSrPA@mail.gmail.com>
Date:   Mon, 01 May 2017 17:26:14 -0700
In-Reply-To: <CAJZjrdXVopdvDoDwnsmqvrLESKQq=-a2waDgu5HYYoP2WvSrPA@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 1 May 2017 10:34:08 -0500")
Message-ID: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> After some more digging (and familiarizing myself with the
> behind-the-scenes logic) the issue is that dir.c has this implicit
> assumption that a directory which contains only untracked and ignored
> files should itself be considered untracked. While that works fine for
> use cases where we're asking if a directory should be added to the git
> database, that decidedly does not make sense when we're asking if a
> directory can be removed from the working tree.

Thanks for digging.

> I'm not sure where to proceed from here. I see two ways forward: one,
> builtin/clean.c can collect ignored files when it calls
> dir.c:fill_directory(), and then clean -d can prune out directories
> that contain ignored files; two, path_treatment can learn about
> untracked directories which contain excluded (ignored) files.

My gut feeling is that the former approach would be of lesser
impact.  Directory A/ can be removed "clean" without "-x" when there
is nothing tracked in there in the index and there is no ignored
paths.  Having zero untracked files there or one or more untracked
file there do not matter---they are all subject to removal by
"clean".
