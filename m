Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA935C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 09:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjDCJgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjDCJgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 05:36:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383708A7C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 02:35:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so114754347edb.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680514500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/cgS+CBEf7OcMVKnMJjK67zXxXtfu2iIXcN896QISYY=;
        b=o5oadg6Fsx/Zq7o+nNY7ai1DoXkv6Ec4ajalyrYl5gaNAj0IJpY+61FKDoZcll8ftZ
         +SPOKWGs1Qt2A0Zd6K/kmQzsaIHw0I++gOz+950QW/CK7OjTxqag7fnbDg2bvSuIWlIt
         2ebTUxipIKUOTmMTYiwechsm1rZ1y4wqB5r34xkAmgS1L2q0iCjUTx9iludJvUHp83FN
         qz5dZ32RoUi/FBTBue76SP7IPLCpuUJyKPoo9/Xo9Rp1hRAZX3XwobZzWOG34TTq5IOY
         D4BYQg/xl/wtcz467kCzj4Ocog0CVpRm+7wcs0+KpuGENuF7tRV4wcfmg0CIEVQiertB
         xo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cgS+CBEf7OcMVKnMJjK67zXxXtfu2iIXcN896QISYY=;
        b=jQ+sarr5IhSeMRXigYL+mksRQumN07SLsgW1ikmHfy9EiEJ5J2Cw2FQBE8JNPBDlk1
         5HFtafHCNGknaWcTlQ0NiKzvGqYUTn0Y7xuwoQK2zr7uIZYhzwMzoEuRVfoHLy5XjStc
         O7rQlWTN9ciP1gCab7AqhCn+yOb2ydOsdPmg+Usd/l9mSeC8iNpq3CQCsyPKClvPMT6j
         M6QB8WtbYUqnepb3MQQwosYK1tOu0cQBjloGnE3dvfWYX+wmMPh9z/Jwars6q8Rj05t/
         w5sh1O9c1NSoOIXICyZ0yxpZ2cWHqR1TBzsGun5LLXdXUKZFXUzJmh4axXoZaU++X4ve
         LJcw==
X-Gm-Message-State: AAQBX9fAixmlW4bIbsIAOKa4sFzcwfYMwIYUdM6u2RMMX8sv5zlz7yiL
        1FUjE2nt3vhY8v4TlhwshsJF/bD83YVFqj1R/d4rFs8wLW2ZMw==
X-Google-Smtp-Source: AKy350aNCz7hi1ta6/VVZm4KH6rI8UpOTfZOF72KXnazi6Kq9Vq3phNEwAIqb6o2CRfaYzhGn13vORoI6R+nZsmFkQM=
X-Received: by 2002:a17:907:6d18:b0:932:39bf:d36e with SMTP id
 sa24-20020a1709076d1800b0093239bfd36emr19041958ejc.11.1680514500442; Mon, 03
 Apr 2023 02:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230402113607.2394-1-edwinfernando734@gmail.com>
 <20230402191709.19296-1-edwinfernando734@gmail.com> <CAPig+cTq9mmLGmmNWQ0E73nsmwu+Lj1jDfvnniUe-O6iQrisnw@mail.gmail.com>
In-Reply-To: <CAPig+cTq9mmLGmmNWQ0E73nsmwu+Lj1jDfvnniUe-O6iQrisnw@mail.gmail.com>
From:   Edwin Fernando <edwinfernando734@gmail.com>
Date:   Mon, 3 Apr 2023 10:34:49 +0100
Message-ID: <CAPNJDgeHTpoU_eCPPL-adT7R112SyoBdwJF+RbZR6fPPKqSkMg@mail.gmail.com>
Subject: Re: [GSOC][PATCH v4] t3701: don't lose "git" exit codes in test scripts
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Apr 2023 at 07:25, Eric Sunshine <sunshine@sunshineco.com> wrote:
> It's not normal to have broken tests in the repository; they should not exist.

Sorry the test did not break after all.

> However, it's not clear what breakage you are seeing. In my testing, I
> don't see any failures, either in a9f4a01760 or after applying your
> patch to "master". Can you provide more information about the failure
> you're experiencing?

I cloned git again, ran "make" and all the tests in t3701 passed. The
local repository I have been working on so far still gives the same error
though. The error message is not very helpful so I haven't included it. I
ran "make" on the faulty repository and the tests passed this time. So I
think the problem was that whatever "make" does was not up to date.
Also please ignore some mails you may have received because of
misconfiguration.
