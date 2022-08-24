Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AE0C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiHXSYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiHXSYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 14:24:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F279ECD
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:24:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 83so11576724pfw.6
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=Tnmg9y06F77DUnHdQLOnm2unRgrvRoXN3wG0ja7Re84=;
        b=Ilp/kteVW2Rd7nWeE3a9mgT+V5/sYabuUl6EzwtwC/GRw+ZAHJ7WRLkFT6mFqqd3Hv
         1+KziGYVgWSuYeAnw5X7amt8NPxghx1RML4pE7VnS3q0/63t9IpaY+gosg11zw7uT3Zj
         6A6BSE7ArjugQHbRJ7uSc/FawF4lQsh9XIqO7cnOeK0NoAJqXxwvYQaU3hWRsIJu8Yik
         0F6rGK1Lre+lEmqbizmOlO1O/0qDVDsrqE0pzNeqKPaqb9V2ftCRy9qpJLONNRdxZng8
         xg2yyZSSz1iMV09atyfb9LH3GM3FiO4YvYBWquRLu8/Jh58oI+1Kd22Vx1Tf1q2zpH9U
         wRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=Tnmg9y06F77DUnHdQLOnm2unRgrvRoXN3wG0ja7Re84=;
        b=bOwL7s9RSyU7r2EY6ygDYse5M7ElGBEj0IP7B5ULeGNQUCEi+JLczI6jyfMkb37d9w
         ihGIvJWrQYJfSVDi9/6qK5rvQsZ9SW2ZeyfGxLqH7hRsF13mqZlyAtz0hTeU+O5uU0R/
         x/LR8bvqz6BLoipazpDeYjJ54d8yKf9bnQafj67eWokHPXPRlfIuUuf33GyJ7FFk0JAv
         nt/2cVis2LQLVKFU0To6adOIwgbmF7b6+6YQb8ozGHep5H6H2oTJiT388baRHP/FoALL
         aVW9WYOqYZw3xoqM+nTHxWTnDl9Ib4wZCAR6xAPVnYh+IruyDooMC/R+WPhY2jjC7ZmZ
         Vblw==
X-Gm-Message-State: ACgBeo1o4TxYeGF3J56rOWSEffXOA1KsAWRCyx792dUfbKpd7SFELGSu
        GrmpVrBKK0BLBLYbGLcYXH8=
X-Google-Smtp-Source: AA6agR4LQ/j4Ek08LgoPIxRj+ppWXO4lnr46Fxl77jisWrSS+FjLAFQW0pTb7SFLQyLkC6LXnbnRog==
X-Received: by 2002:a65:5a0c:0:b0:429:c80e:959c with SMTP id y12-20020a655a0c000000b00429c80e959cmr169724pgs.279.1661365443419;
        Wed, 24 Aug 2022 11:24:03 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b0016d72804664sm7810493plm.205.2022.08.24.11.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:24:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
        <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>
        <41781ceb-bfad-2534-2970-c74618c93f2a@gmail.com>
        <145ddce5-8084-a024-39b5-9dea870d1afe@gmail.com>
Date:   Wed, 24 Aug 2022 11:24:02 -0700
In-Reply-To: <145ddce5-8084-a024-39b5-9dea870d1afe@gmail.com> (Philippe
        Blain's message of "Wed, 24 Aug 2022 13:49:30 -0400")
Message-ID: <xmqqmtbt7b5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>>> However, I've tried it on a more "real-life" example, and then I get:
>>>>
>>>>     error: mismatched output from interactive.diffFilter
>>>>     hint: Your filter must maintain a one-to-one correspondence
>>>>     hint: between its input and output lines.
>>>>
>>>> This is despite using "diff-so-fancy --patch" as interactive.diffFilter, which should
>>>> keep the number of lines the same.
>>>
>>> Would you mind sharing the example with me?
>>>
>>> Thanks,
>>> Dscho
>> 
>> In trying to write a reproducer, I realize that this is in fact a separate "bug".
>> I happened to have a submodule in the repository I was testing, and it had modified 
>> content. This is what was causing the "mismatched output" error, although I'm not
>> sure why. If I use a pathspec that does not include the submodule when invoking 
>> 'git add -p', it works correctly. 
>> 
>> I'm a bit out of time now but I'll try to write a separate
>> reproducer for this later today.
>
> So in trying to write a new reproducer, I found the cause of the
> bug. ...

I somehow had an impression that that the C reimplementation was
designed to be a bug-for-bug compatible faithful rewrite of the
original scripted version, but looking at the way how this bug is
handled, I am not sure (it looks as if the initial fix was to patch
the code to match the symptom, not to make the code to behave more
faithfully to the scripted version).  As with any big rewrite, a
complete re-implementation always has risks to introduce unintended
regressions and that is why starting with faithful rewrite with the
staged transition plan is valuable.

In this case, the staged transition plan, the step to flip the
default without before remove the old one, is working beautifully.
And it was only made possible with the actual users reporting issues
before they say "the new one is broken, so let's use the knob to
retain the old implementation".  Please thank those in diff-so-fancy
land for reporting the issue.

Thanks, you two, for working on this.
