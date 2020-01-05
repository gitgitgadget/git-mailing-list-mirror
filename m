Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05FC00523
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 06:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7CD24650
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 06:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US+T2uI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgAEGCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 01:02:21 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45555 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAEGCV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 01:02:21 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so39992183iln.12
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 22:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BzvwHm905fyXXy4BwUcAKpGXbD4sxuzWUz78BuPed+0=;
        b=US+T2uI4ix3lnKnIK7Mbfjq7+lU3QjMJ98tWWZ7JJ5nAmhn7/OlMXDNmQxlLg6tUT4
         AEniBgtKqTvkfGenc1dFbTy4pG9Fzs2Z3h79PnYZkcxbTol6NeSGwrGV8GmfdGvELsER
         BturA8F8RkmsllHi/EMXVS2ZxQCiekBLquAn65e20M0L36cHppXXZ4/FwExLpTkh59ue
         IWL7j9A6VUj5z9WifCVhVT++hmFuI8rzYJGs866KJP1qpFqiGeRSHhlidbRN4lCZBf+K
         l0M5uPm79/gDyIrK5uppcCQyAaoKx1puIfAJywCmMJhyNR2BG8fOFfuvy8DMZDCovrWk
         E+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BzvwHm905fyXXy4BwUcAKpGXbD4sxuzWUz78BuPed+0=;
        b=F314nQGRdp6Ll1N7coE5GdtFCXsQYnWI8gPIhj0OT/bCdIFdVTsvB68LBUZorDhi/h
         Kag3eCGiYHJ0miuZ7FmuCspKG+3OpLYcDuxt7SrMHGR6hMdJfQ2ghugAbMFN5jV1MSVE
         BDSr6T2weFQFxnJq/ljIhSbBY7MXkQVtgS4anqCk5nW+XLrZNYThil+im0JBY3JNebkB
         PZaLVUAmfcZBaWuXSqQN1koQJvkL0G43jSmkAyA/0+JEc5lV9jy53Kw1m9R/botyknMI
         NLLYOXETrXzXQVr6stCZGt2uilw+FDpISFecGaDUx/6bn4RL3R41GUiR/bRUR42PhSS0
         qsRw==
X-Gm-Message-State: APjAAAUC8WMDTEPnM/QPjc3YmMxLensu/Vmns7yET0pXBUzVlZNaz5Rb
        h6RiAMvwJRkoADAqWsLYBjov/OHYmJA674CNgVc0wEbN
X-Google-Smtp-Source: APXvYqwWEHPHZcctFUpn5zkH+L8F6jCQlWjDfdy9Uu1rWAWQRJfGEMEbqdf5dGUoEuFxtj01AdAjnAEPG9RWlMzHoWY=
X-Received: by 2002:a92:d902:: with SMTP id s2mr86207467iln.223.1578204139997;
 Sat, 04 Jan 2020 22:02:19 -0800 (PST)
MIME-Version: 1.0
References: <CAFFaXszwB6F-Y9hHWW5ZuvuFSPqrOwkK=c2wUVMDm4yGq44X-Q@mail.gmail.com>
 <CAFFaXszUdyfun1W0TuvJuRihLo7Mz-XYL13Fm5gCv_gWrir-_Q@mail.gmail.com>
In-Reply-To: <CAFFaXszUdyfun1W0TuvJuRihLo7Mz-XYL13Fm5gCv_gWrir-_Q@mail.gmail.com>
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Sun, 5 Jan 2020 11:31:42 +0530
Message-ID: <CAFFaXsx3Mtrq4mEGq6GYct7ZcRtucmZdRG-PQmjLrvVVTfq2Wg@mail.gmail.com>
Subject: Fwd: My Introduction and a Doubt
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everybody!

I'd love to use this email to introduce myself to the community and
ask for help.

I'm Nirmal Khedkar, student from India. I love making end user
applications, and in this FOSS world, there simply aren't many as big
and impactful as Git. I'd love to contribute Git for GSoC 2020 as well
as for long-term.

Now the doubt:
I'm trying to wrap up the issue mentioned here
(https://github.com/gitgitgadget/git/issues/486) : basically allowing
git bisect to work from subdirectories.  I do consider myself okay in
C but I'm still kind-of stuck here: hence emailing this on the mailing
list.

 When you do "git bisect" in a subdirectory, an error "You need to run
this command from the toplevel of the working tree." is raised. The
error is raised in "git-sh-setup.sh" and the command begins execution
in "bisect--helper.c", but I cant understand how the error appears.
Additionally I'd love to know how the C files linkwith the numerous
shell scripts within Git.

I've searched all I could within the Git project, but if there's any
existing documentation on this, please let me know.

Thanks in advance!
Nirmal Khedkar
