Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E856C433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiFLG6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLG6P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:58:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9026830D
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:58:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 25so3550792edw.8
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgp3RF0rg5nDfjyTFqE42NFGAT/nFAOvQAl8LMmB6CE=;
        b=qTQxDJeTx/dgn5qiwk+DN83zxrsCrmdeSiBarHWN398WYTFT60OBQGL9K8gw58TnGc
         DVALGoWb6erye+5yavebqzyj5SHXeTVsQS63tch7R0eO2YZFKrmSbmyJZwOApO7wVEN1
         K4IpVmMSuyGKax5fefnBCnTQGSsVEQiawUYW+CfQpxgZNNc2eX5QXsDEr/DEGzozoeky
         8IMphvryiHVjuIPITFGuBtuAn+yAxry3OfO2ZZAImG1wI6yrKDzqHIJMCDIKrkeggQGO
         sp5Og0ObC1uXR//93sADv4+rXbcMUKi/jGO2xicWQeiaG4OC5MO6v3cmi3YashFWtcrM
         hnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgp3RF0rg5nDfjyTFqE42NFGAT/nFAOvQAl8LMmB6CE=;
        b=8Cv5h4KXeP+joASuWuPO9QNcLoLAi7WPh+vZc2lWxqF37LpkPO+z82D8QGOPmtHqFZ
         JINO49JWj6AEkMAxQjZiu2wu8VYJxQH0FGu+k6i2qKbZm+EZuznuGZigpZxwNCXqIub1
         aAcXCRQ2fFZzqamYb+OPVkNNH/9qXqMHBXMWTO8jJUpDnGm+67njWEU9QJIYYHyhxxwE
         v7mRBeYkr1eGezsUoBiY2toO1PzqxuNYvC3VG9p2fWYuWbXYc3uceIfTI2KV7xO3XXXW
         r0+72V1JNSK3PhoGi7NlFSg3EITzbMChBYaCtNuPIyB0RcfjNBJmVlT5jfZwNuF94x2w
         ZdQg==
X-Gm-Message-State: AOAM531pTVtsvAROAVJlUHRH3igRCSLM2IkLPnIVaA0gMdhC/Ll6wnVV
        49si+2L7dmeSAuCMT1yzvs+ULVK+Sy4LKbhsRTYxK0vU7Z4=
X-Google-Smtp-Source: ABdhPJyMpVnRdyavxTz5r8hWNP/ytPuGHGiUOFJHafgqbD9TaMiTU1jfLRAb03IEuRSqDGZ8p4bhy37lhuPwYAbU9cY=
X-Received: by 2002:a05:6402:4255:b0:431:34c3:6018 with SMTP id
 g21-20020a056402425500b0043134c36018mr44620110edb.146.1655017093287; Sat, 11
 Jun 2022 23:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Jun 2022 23:58:02 -0700
Message-ID: <CABPp-BHfdo_JK-NyhMv=_7FpAGNj_vxGwGRoSYXRK==ARzh1Cw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix merge restore state
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 9:26 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> A simple series to fix restore_state() in builtin/merge.c, fixing the issue
> reported by ZheNing Hu over here:
> https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com/

I updated this series a few weeks ago, I believe addressing all the
feedback.  But I hesitated to type "/submit" over at
https://github.com/gitgitgadget/git/pull/1231.  I've done virtually no
development on "interesting" (to me) projects for quite some time; I'm
only responding to email questions and review requests on the list.
And the review process takes quite a bit of work at times, and on the
chance there was more feedback to address, I just didn't have it in me
to submit a new round even though it _might_ be complete and certainly
fixes some known issues.  I haven't even gotten to review Dscho's
updates of my patches this whole week (spent the time I had mostly on
the merge-ort issue reported).

Does anyone else want to take this topic over?  There are updated
patches and even an updated cover letter over at
https://github.com/gitgitgadget/git/pull/1231.  It might involve
nothing more than submitting those patches; they might be good enough
already.  (Alternatively, I can type "/submit" to send them in...if
someone else agrees to respond to any feedback.)
