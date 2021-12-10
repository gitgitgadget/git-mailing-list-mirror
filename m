Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9191C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 11:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhLJLkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhLJLkO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 06:40:14 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02FC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 03:36:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf39so5410288lfb.8
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 03:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timining-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qga+zP0YsQGXOuThRiqvL2E6hKVAWnxUJrKtLrGJiqY=;
        b=Xejz7xkp+mtBsVEK2gMxTcN36r7v93zWhGtS9NNDBwzDFN+rnRNKBTgvazH5OckaKl
         a0i3JLAR0HajRnaxmI6kcEJcHNgkD9+MoSG1flCWJrxvWLPCLxb2arDm5rbbVInSJZK2
         LdBCo6lkAgPhqyvEZVbVxq31eYs+g7nMVe0dp8EL3HEtnWQkjRZuagb0ERkkXXdRQj6H
         jncdWyYoyGchDyWRbek43KZM9KJr8q9BpjXgWNoXdPnfPiO1v5UJfHb1rxvYx5RDF6fb
         t/r9D/hkKvBkXMOo0gZ0ESWB7K8f6qbnJloCbc059CglaK18h3JElklvIvILzd5BqUKo
         kInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qga+zP0YsQGXOuThRiqvL2E6hKVAWnxUJrKtLrGJiqY=;
        b=dufJW+Mn8gzfAoSeOuNtCKmhc/pylITR5Z22dqPuYmrQ2U/xQD/pJxGG0qP/IRU0Rv
         pPx92asqMU/K4Y570fb1sPGUeTGluFqo+G+XP22EKx2XXczpWRqwlLN0aXNs/eGGKH0f
         bOLx83lj06SqOp43HH6LCDMk8IFCbPY69I958gWORdB00bnKHV9HSKy59Vj0uyp6ftBN
         /ZzPvpC/ZSS1wWliNsIzfplCUsbE25pvyUveLEvr/TOaoQhqKSe6EtgLY85sdGNh+RCD
         BBSlq2wLUBqryURNsWQ3X2SYMfq6ICMZ5ORMySpBpPgZ21Kd+teC6URgD7VrFSMGccmu
         bDfA==
X-Gm-Message-State: AOAM530igsXVeQkVLYZKBx7NLMWf5aT34MI0vTmNcww2eBIab3JBoSiw
        h2gLFqhrDoVXpmvfVUJlmYwSFUPUNzzvWK4v2ax3HQYbIVoSxA==
X-Google-Smtp-Source: ABdhPJzo7wUcbfBZZH3xQ9ZfK/vVIvXxkLIGWM1JCMBlvd6SXlFESqD9ShrIOz1c2r0NbvKGm4+xZQ0zr1xFUjjb36k=
X-Received: by 2002:a05:6512:3b07:: with SMTP id f7mr11801366lfv.567.1639136197830;
 Fri, 10 Dec 2021 03:36:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:e346:0:0:0:0:0 with HTTP; Fri, 10 Dec 2021 03:36:37
 -0800 (PST)
From:   Jose Wielandt <jose.wielandt@timining.com>
Date:   Fri, 10 Dec 2021 08:36:37 -0300
Message-ID: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
Subject: Please, paint new branch errors in RED (or any visible color)
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi community,

At my work we've been struggling a lot with not realizing that our new
branch creation actually failed, ending up with a push directly to
develop. What are those cases?

$ git checkout -b feature/solve p-eq-np
fatal: Cannot update paths and switch to branch 'feature/solve' at the
same time.

What's my proposal?

$ git checkout -b feature/solve p-eq-np
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

FATAL: CANNOT UPDATE PATHS AND SWITCH TO BRANCH 'feature/solve' AT THE SAME TIME

                 YOU STILL IN THE SAME BRANCH ! ! ! !

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

***(but in bright RED)***


Another case!

$ git branch feature/solve p-eq-np
fatal: Not a valid object name: 'p-eq-np'.

I'll let that one to your imagination but please, make it appear in
red so we can easily (visually) realize that something went wrong.


This has been the third time in a month we accidentally pushed changes
to develop bc we didn't realize that the command failed.

Thanks!
