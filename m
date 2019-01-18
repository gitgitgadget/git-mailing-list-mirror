Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDEE1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfARRtk (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:49:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37496 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfARRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:49:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so5285363wmd.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FsmCUZ+x76XQtqTEfxrAg4ZDlQCpgrddmufqiAbGOvM=;
        b=aHKNyPqzHKhN6P8GNRF0tCyV4AIwOMqzAXpvbcP7v9Qv6vN90k2Bff19odbhsIcG97
         70JBrTkBkbR9TIxsG2gIBaOB6K9SnTmOUUZdABjCkueCHO582otleJiUXfmX0fHG10zr
         YGHNZXmX4S+6/v/MuiBBhe5j2bMwImuzbn9J4e+u5DX9GYfe+wXeLh3/MG3ZrWM47S5H
         mNU/SKfsjqF+JFYndLF6F2sj4sA8DrXzsCExUcEhyuzH3UpE37fhqFtEdM98o4OUnrjj
         bxG71lC2coOzKKjakFaSNVLO2a9srIB6tliDqlRAizpfSTygZopR9L9lDltRRireD3pX
         CWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FsmCUZ+x76XQtqTEfxrAg4ZDlQCpgrddmufqiAbGOvM=;
        b=lY0S9V7MdOUS+H56cIlc9cFJcnO80XpKsnecq2Q17dtO/6nsAIL++UnQfOUQ6KY2uY
         OWivo8aH4HwsKUvfXhNiT442eJ9NJ+WnhIr00C0vP5GX7+1FJCPGm8BaKcnvG/L7r86G
         lyMAaYaN2pvgzcFjP/akkp1d3k02z+Q1i3TqDc9sxkbjOW7PaPU3I3wlBB9OvWIB8Q3Y
         0aTgLGwaZYFzPvTZ7XgR89OYJqErRUT0t/wKebVq3ULm3dOPjgjVbjA6bGTDM8baEk9Q
         YEcIL4W6hG7yZuaWtbmHXEJ9Fip9hmZBVFRAZbV4RwVjUgZWvMrFs21YGF6pnvZ56TLp
         g8QQ==
X-Gm-Message-State: AJcUukfqYHa8unxuSXep13yJ1wWqxGP/chkvJD2dUVBnHJ/AiIYua4AA
        AcepBuD+RuzVKGz8I8ClsgM=
X-Google-Smtp-Source: ALg8bN6/AU9fqpiGd6J9ldC03zSXswmOYBe87spfMGbYeNH/U6deihj2vR0gACO2i/x00gf6NyLXdQ==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr16677452wmc.68.1547833778334;
        Fri, 18 Jan 2019 09:49:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f191sm1385846wmg.12.2019.01.18.09.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:49:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v12 00/26] Convert "git stash" to C builtin
References: <https://public-inbox.org/git/cover.1542925164.git.ungureanupaulsebastian@gmail.com/>
        <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
        <xmqqa7khfh0c.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901181305460.41@tvgsbejvaqbjf.bet>
Date:   Fri, 18 Jan 2019 09:49:37 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901181305460.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 18 Jan 2019 13:06:40 +0100 (STD)")
Message-ID: <xmqqr2d9lutq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 3 Jan 2019, Junio C Hamano wrote:
>
>> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
>> 
>> > This is a new iteration of git-stash which also takes
>> > sd/stash-wo-user-name into account. I cherry-picked
>> > some of dscho's commits (from [1]) to keep the scripted
>> > version of `git stash` as `git-legacy-stash`.
>> 
>> I took a brief look and left a comment on 04/26 last year.  I had
>> some time blocked for this topic today to take another look at the
>> whole series again.  Thanks for working on this.
>> 
>> It seems that the last three or so steps are new, relative to the
>> previous round.  I made sure that what is added back at step 24
>> exactly matches the result of merging sd/stash-wo-user-name into the
>> current 'master', but such a manual validation is error prone.  Is
>> it possible to avoid "remove the scripted one prematurely at step
>> 23, and then add it back as 'oops, that was wrong' fix at step 24"?
>> That would have been much more robust approach.
>
> Sorry, I should have thought of that. My mistake.
>
> As it is, Thomas verified that they are identical, so should we go forward
> with ps/stash-in-c as-is? I'd prefer that...

Yes, before sending the message you are responding to, I made sure
the scripted version added back is identical to the current one, and
also there is no in-flight updates/fixes to the scripted one.

The benefit that would come from a possible reroll to start the
series from the last three patches would be fairly limited.

Such a reorganized series would have allowed investigation of
regressions and bugs during the development comparing the original
and rewritten implementations slightly easier, but experience from
seeing the evolution of these "reimplement in C" topics tells us
that we see major part of the regression fallouts after the series
is declared "feature complete" anyway, so in the long run, the
less-than-ideal organization of the topic does not matter much in
practice.
