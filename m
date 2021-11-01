Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9FC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A31610A0
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhKAOOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhKAOOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 10:14:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3004C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 07:11:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f8so43266993edy.4
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2TcKkQyfDysO5JMEO7SQWpiwUEqs/pzU7kGZCWoB1v0=;
        b=L1gZ9/PxBqdTLCCHQo4v47p66LCM4aVQI5sznZazCf4IJbNAXDs7HzLSLOtdMsghp2
         eeJ6wYnQlwuiAM1BciBog7/OjHpHZ9XKWL+2HPWplBWqWRWJMOa/NROGNCJYNCxlqT8G
         WMjpbsnKQ14T3+Il7r04uDBFOBQ3xBFc1crne0IsFuAHe6TW/MR5tzHUKEJW5KTPnTFL
         rh98cDwUjKrVJvZJz0quYmxueEQnTJgi/4qh9mxwfBctnGS4abarqb2RQVgrdrZrssgh
         bea4fefZD/7fHLbeT/vvkTcJpu00q/Bp9O7Ku51CDL1gU4NhqLoaF5ZFWWT6Y2TOQlS7
         7fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2TcKkQyfDysO5JMEO7SQWpiwUEqs/pzU7kGZCWoB1v0=;
        b=DkjJLR42Cdd3wE80TjQSA3mxujFvEwvVnZfZTSRmEctEhRiEte+AA62tYQPindeheC
         H8VoUKF8XkDTWV9sXcV7E6x0cnP8OJKofLPfZsUgF15sq+g2xJ/hQpe8KCIV+evTqTDO
         vzMZRqtoHfWeIWAG+NdtFPyoGoCOkaxpwOTfKKUpmFEH8Wp78ustzL4njseHszn9ugB0
         eVACmHwF698fvSI9FdZZ6Hg67OnQvi9BQhxgM/AdEfiwLqiT3e4WmmSwp9x1zrML8v8H
         k/RGURV34TzEPr82+n3MvHToXGpxxUkLLWqHZimQVG1Pq0EfuuQ+gjC+DcT5hqCX26dk
         ShSQ==
X-Gm-Message-State: AOAM533tyDityVPUvzzyt72EAOAxuPHq92k40MuihRGKCY+fJwXo+soV
        nimFWUAWThJYy32bfILwG6dWazPHuyVnaKBi14vpbcS77NA=
X-Google-Smtp-Source: ABdhPJyFckzVxLWX0bU/vKTJM/Vp6N4tmO0SAEcakUimYHqbH2HVm8R3N/UriPv/lR1aUgv09bfvFdiMGZfBREuz4ss=
X-Received: by 2002:a17:906:6087:: with SMTP id t7mr36436693ejj.206.1635775891155;
 Mon, 01 Nov 2021 07:11:31 -0700 (PDT)
MIME-Version: 1.0
From:   Dominik <dominik.seifert@gmail.com>
Date:   Mon, 1 Nov 2021 22:11:17 +0800
Message-ID: <CACgoU8qhHunXwX=uG6AZrM=M3ofiM=AH37nVXAvN22Otwq=1eg@mail.gmail.com>
Subject: [Q] How to check git features for compatability?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Scenario: I want to offer a simple utility that (among other things)
automatically checks out git repositories. For that I want to use a
specific feature (that is `git clone --branch`).

Problem: Some user might have an old version of git where `git clone
--branch` is not supported at all, or not supported in the same way.

Q: How do I check which features which git version has? I fail to find
the (rather commonly seen) `changelog.md` on the official git
repository. Where should I look for a complete list? Is there a more
complete documentation that lists the "earliest supported version" or
some sort of "history of changes" for each of the git features, as is
commonly seen in the API documentation of other CLI tools (e.g.
https://nodejs.org/api/cli.html)?


(PS: First time user here. Let me know if this is how you participate
in this mailing list? I could not find any info on
question-asking-etiquette either?)
