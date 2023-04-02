Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFAC7619A
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 19:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDBTkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBTka (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 15:40:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1851BA26C
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 12:40:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p15so32468782ybl.9
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680464429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsuOq9ncmmIBdd87thMfvIhgSPUDnNULn32azrwmRz8=;
        b=DADM5IfpDAMZouOhM4jp61zjre4T+zKkOn4n8E0897Q8v568ihCStvQJbikEzUroCl
         JjUgZXPInQVba9vlM4qcQaO33ZeAx9WQKfva2XAwPEwjo+R1z+EKYY53BOR4s7oi5KFR
         6ZzWoH19JuCuufXuAMeVexU7A0FfJwn9POtHAolAU20VKERpxjVD90ug1QqPQwE1OTz2
         XXVAUdgMNIeEObeQRH76WyCK2vCCRts8Al2dpoKonbQEICiq6u2AM5f5Q7TDIZbV+D7p
         BEWANWJawcu75zjrFz9nEkMZ1GdETYSbZMUTI7AoXZrPqShfkST1WbblxvWnhdmYHzzc
         kEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680464429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsuOq9ncmmIBdd87thMfvIhgSPUDnNULn32azrwmRz8=;
        b=xNtsCqOIJ21oqOvYFJ0atRcDbMKuq3ABG/jmawbx3dlinQagXA0vhjfKYUB0GxKP9J
         XXu0apRc5p3MYzSdrXhNQ2DnprW8BZJESVznzKRHaNEAQkPqCbNhSWN/KRINJ7zNodWO
         P+sAgaonI9CHw4sS6+zcoUbNzrbhmfwW/BlMMjWCNL499S+FqmPXKsXhaQgk4LCLtv3E
         TQ4JTPQXgGSY9mZAkXwOXPuGWgTqeT5ToXuGqdc+vAwgfc54Gi4AtTWZL4z3pk2ldRY5
         mbl0r9D+PW7RKc+wHTxbBYJz4YjM1i+IT2T38I6UFxD38lq45l7SlZp2HmTzfohpzLqV
         B8tQ==
X-Gm-Message-State: AAQBX9f7CTNzS9FUtD6pWgr00JjpS+GK8Rwk2dg2cQAZLarmwqvHUeEF
        5w4r8mYZ4HMcfIgr0r1PsU9lJmnxpZd+SqiPwKs=
X-Google-Smtp-Source: AKy350ZxLT47HiEQDfer+8AfGApJwUtFO3VSl0hI2ShvfMP710ypcW3msGsIGWTTmuPjve3kV6qbJ7va/A1aARxJmi0=
X-Received: by 2002:a25:680e:0:b0:b78:3a15:e6fe with SMTP id
 d14-20020a25680e000000b00b783a15e6femr16058283ybc.2.1680464429216; Sun, 02
 Apr 2023 12:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <100814d1.2603.18735b059bb.Coremail.18994118902@163.com>
 <CAP8UFD3Lns7pQQ-yNc5W8d2bfPBmJ0pcD52yCbkFOmymhWKw9Q@mail.gmail.com> <3cea7bba.1e54.18742678107.Coremail.18994118902@163.com>
In-Reply-To: <3cea7bba.1e54.18742678107.Coremail.18994118902@163.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 2 Apr 2023 21:40:17 +0200
Message-ID: <CAP8UFD2Tjqf0A+xv69pHDZFUDG2rPU7tj=9KSYh36_zTg0hG6g@mail.gmail.com>
Subject: Re: [GSOC] [PROPOSAL v2] Draft of proposal for "Unify ref-filter
 formats with other pretty formats"
To:     ZhangYI <18994118902@163.com>
Cc:     git@vger.kernel.org, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2023 at 4:38=E2=80=AFPM ZhangYI <18994118902@163.com> wrote:

> I have one questions here:
> I used gdb to track the function call related to ref-filter of the comman=
d
> "git log -2 --pretty=3D%h " by setting breaks on all no-static functions =
in
> ref-filter.c but found no stop.
> Should I use another command?

`git log` uses pretty formats. If you want to see how ref-filter
formats work you should run for example `git for-each-ref`.

> Or as I know, Git use different branch for different purpose, like todo, =
next.
> Should I use another branch?

No this is not an issue with development branches.
