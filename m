Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D7C6377E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FD46113B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383677AbhGSSBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382469AbhGSRjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC852C0611C4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:02:33 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w188so21657710oif.10
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=5W6UjcjrmHEZxZebsBHnqJowyj9nGrRBu0fb5RlowZQ=;
        b=HHQTyz8LAr5YKip+uEWsqACPWDExFvdfgQc8LSlWNHx3A3s0RKejhPqwTJk+3xXwgF
         pT9qy6zf/PfD1EzSw8ikiR6TfAN1jUIA0j6yjATFqxjFAq/hr8U8NINveU0VzF1gnJN1
         9dlB8XwbcH99fYLSCKGbwsUzKaLAzzcXuda0nT5I7W2vrVJcTzroCMcfmjDcpLaqhJGy
         eCqrDyq8igrZ5a22UT1y2PCui6M7stYcLTjdbD/nwF8VehGUrAgw2xNlaH1S5ni7AZMq
         HWYwgqgCDuWjGSV6HsGUdgRh/44cHqLPJpBMlqjpdzaGUUDKUUbF0M5oKsQua2EKWAA9
         5+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=5W6UjcjrmHEZxZebsBHnqJowyj9nGrRBu0fb5RlowZQ=;
        b=TS49GU14SyTBsOQ/lp6ESfnHJyRTXmkYON+AkRrTbtjqswQDRiGCf97Bb54+jejQIv
         1qpWSX8p7aKX84vhzPVz5TCNbItNAnXtbhROzoEV5QS6Y+WG1z2YAX/l17jtckRdu5eT
         FmsBnAF/SrkjBlGspXnv545qbOPYqVz7cRzyu7FXDPT4ALtGFO6V1melG3I/IiRptVMp
         WIMkIS0UO4HnDFmG56V/gc4wYPHrAaOn88VhtQMug8CyUNAtrzWlR4CeL3nZoFhs5lEV
         qK5WRx0x948Ue3dRWJqT6PBuZJz17JbrRRsjh79hzns+OVeYRoW3mHnyO1OxIJp1mF9R
         zdiw==
X-Gm-Message-State: AOAM5305+gPIzj3ApTvsjsJhVyOqDKM09q68A5kqOZkoxMWtZTp42Q73
        Dw5x9j1Z4xJq7OH+iRUqcf8=
X-Google-Smtp-Source: ABdhPJwmfWTqmWc0xwZjRsPKgJojFImE2XsWfmMlERyg6pNiQCSqUsRfK/8iymDuRo6yjOTG9MGMlw==
X-Received: by 2002:a05:6808:216:: with SMTP id l22mr2911614oie.24.1626718631650;
        Mon, 19 Jul 2021 11:17:11 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id a44sm3495293ooj.12.2021.07.19.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:17:11 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:17:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andy Zhang <zhgdrx@gmail.com>, git@vger.kernel.org
Message-ID: <60f5c1a5c8422_13f62b208e@natae.notmuch>
In-Reply-To: <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
 <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
Subject: RE: why "git rebase" searching the duplicate patches in <upstream
 branch> rather than in <new base branch>?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Zhang wrote:
> why "git rebase" searching the duplicate patches in <upstream branch>
> rather than in <new base branch>?
> 
> hi, all:
> 
>  I am reading the help of "git rebase", it says:
>     "If the upstream branch already contains a change you have made
> (e.g., because you mailed a patch which was applied upstream), then
> that commit will be skipped. "
> 
>  But, because we are applying commits to <new base branch> rather than
> to <upstream branch>, I really don't understand why we are searching
> the duplicate patches in <upstream branch> rather than in <new base
> branch>?
> 
>  In the following example, the git command is as:
>    git rebase --onto master next topic
> 
>  I think it should be reasonable to search the duplicate patches in
> <new base branch>(i.e, master) instead of <next branch>.

My understanding is that only applies when --onto is not specified:

  git rebase master topic

In this case "master" is both the new base, and upstream, and it's in
this case where duplicates are skipped.

If you specify --onto master, then this isn't done.

-- 
Felipe Contreras
