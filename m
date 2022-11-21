Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08947C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKUDgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKUDgj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:36:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9364509F
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:36:38 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d192so10220658pfd.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzUR988eBRUAITGdF941lW2W6pnvwLFFYrdxKuE9ZRI=;
        b=o/HO+2sLWvqogBZg/u+OVhZo9QWaeKtN234lE5GhWV9e4ulqoPXDBZFXmnQgauwtQY
         /WF5L70qvDfZfYzePUEEgVqv0UeVAe8YSelDHNARmdfyjP9Q1ePPXeK51RY3Zi1PwVfP
         mULvxlQzf3lRTvF3Due3us6EMmgx2d4mov2PKCqEzVRVwKl5xHs3iJ51sOn0qR2p5tSK
         oWMckhOdjR+Og98Yl/33vsEqRrqGFjZrjbk9t5yfqLG+AuPPyKnNwUCtc9A8RHI1m3PR
         uKvzn3D7E1T/WUBDgV9IxYIzEhtAIMr/JGIpF2ueQ5jxLK+5NOy5UhqJG3oRyO9V8MEn
         gkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzUR988eBRUAITGdF941lW2W6pnvwLFFYrdxKuE9ZRI=;
        b=dR9IfEfkuqnmURA/h47ExxZcykGpkny1ZDuXagoGvBJzmei08oyWHBy1kH/oG9SzX2
         oUK/jpSO52bayKOxzKQdHEmbGviHQpyB4FFjjnAjPeMfHucby1f4xK2yD+znItLa0ZOZ
         vamIdgN05dKUbkL3F94yeynnm2nSzIwdeIsCxo5eTkPzdw7sZ8tQ1shESVx6TcVRpc7B
         CqJeAoPAnrZjo1jSaNx1dTr+1IqZiAslVc8lLJZMsZofOv8DmdMkC7bOMG4sRempt/3M
         liYgSCWC0EwSjAYzdESWWSEwtPD3v8Fdg0ep4aG2c3q1nOmB6ZCeBzZJAUHPs01KlfvS
         WnQA==
X-Gm-Message-State: ANoB5pmJtU3zRhFOpHLNmDxemV21TOKm5GSJz0a4Xd9jPJxt66WK6Crl
        QtGzXGj/rlc16bz9OebubckOX5q1UV+nUw==
X-Google-Smtp-Source: AA0mqf4QqkG3R43Cr5rGuQI2LZ0gKaMLt451VvYQK/4aYJiunD2aoWzsD/KxoWhyTue9TAtI5fhSrQ==
X-Received: by 2002:a63:f301:0:b0:45f:88b2:1762 with SMTP id l1-20020a63f301000000b0045f88b21762mr15492002pgh.341.1669001797833;
        Sun, 20 Nov 2022 19:36:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a23-20020aa79717000000b0056bc31f4f9fsm7432050pfg.65.2022.11.20.19.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:36:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
References: <Y3g95OYdwzq2OP3z@nand.local> <xmqq7czp1a6y.fsf@gitster.g>
        <Y3q9xrq5u9YSuVQC@nand.local>
Date:   Mon, 21 Nov 2022 12:36:36 +0900
In-Reply-To: <Y3q9xrq5u9YSuVQC@nand.local> (Taylor Blau's message of "Sun, 20
        Nov 2022 18:52:38 -0500")
Message-ID: <xmqqpmdhx9kr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Nov 21, 2022 at 08:24:21AM +0900, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > * ab/various-leak-fixes (2022-11-08) 18 commits
>> >   (merged to 'next' on 2022-11-18 at 8828bb7161)
>> >  ...
>> >  (this branch is used by ab/merge-index-prep.)
>>
>> > * pw/rebase-no-reflog-action (2022-11-09) 2 commits
>> >   (merged to 'next' on 2022-11-14 at 790dadc8d3)
>> >  ...
>> >  (this branch is used by ab/merge-index-prep.)
>>
>> The other topic referred to is not described anywhere, and not part
>> of 'seen'.  Intended?
>
> It was merged intentionally via 790dadc8d3 (Merge branch
> 'pw/rebase-no-reflog-action' into next, 2022-11-14) as you note, though
> I'm not sure why the description from 790dadc8d3 didn't make it into the
> WC report.
>
> In any case, the description I went with is:
>
>     Avoid setting GIT_REFLOG_ACTION to improve readability of the
>     sequencer internals.

Sorry, but the question was about ab/merge-index-prep that does not
exist in the report and not in 'seen'.

For now, I'll ignore that phantom user of these two topics.  It can
come back when dust settles ;-).
