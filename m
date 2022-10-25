Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AC0C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 21:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiJYVXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJYVXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 17:23:07 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB777CAB1
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 14:23:06 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 185so5851614ybc.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YleD4TjUiGjSkgRFHYmtQ+kswTPlEx5ji3xeJp3NLT8=;
        b=kRakvJnJXPGseOtKsMTivi8pM8xVPWzPdJkL2nxU2qmZr/C5iAn0DOV612F2n99QNO
         48KBcAy1mOnY8+RfOPODFxy2CcZyajAHQKNdfTnYOp62s4nptdblMmYG2h97iAin/PLB
         EHxUWuJbl5Awov/EO1bLbTBzYGAv2Z782NsATm1+KvsRxIjJ20Dgw52XuGv2Bx8DcFnD
         +dnLQBL/aTRg2qkKXdsHXYOTTIOf4/4HBF55Lgjx1dO4o8Jwiyr75qHOTcPW6Mqwmc1W
         9ptgyLfUxIwJcXPvhqKQ8wW3XNRZlK03dPp26qIlTBbySBkZJ8y/cF43MMXLlnVFNEXY
         ucgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YleD4TjUiGjSkgRFHYmtQ+kswTPlEx5ji3xeJp3NLT8=;
        b=kpxHwm8AAv3ApsFc/tY7trBj4cOhg9NkWT7iFHUIkVkYk7cnW02oR7VdNdleXHRIxK
         BjlXERx8zmhwWL4wpvIf1ig+WYrqNbhzvyNvkIPEm6sjvNHFLQxzc+7eRG2KA07wXfl2
         Z90Vb+Y7vSI5R8Q/IoBwgR0roaieOE/3BcwT2cFKst981LXccMuhxJO20HY/GrtKA6xv
         U9h9MSM5Q4naglWlGOjg5UmbUlHx6iNJ5i48kyl19tiy4ZQm5dtnjMnsvoR52VMTTzke
         KfXOF/Ztp6Lv+kzkho1OnImIjYwXmLXA24m1jxvZBota0/W580lcUHFJQHPLamKruRwC
         aoKg==
X-Gm-Message-State: ACrzQf0FB80eXoqAuor6XKRcDDEavs6aYnFHenJnBqacA3kWIiY1wVka
        SIJJAyLarUils5G0yIfAKUyaB3ed0a/iONvDXqeAkw==
X-Google-Smtp-Source: AMsMyM4dJZnVzurc/fMCpiWyiYQcWi+omLXXFVBQIhuAJR9GLVfvQZzp0BR6yaYLkZnvwYT06iNTnAP00aYdbXmAg7A=
X-Received: by 2002:a25:ac8e:0:b0:6ca:a19:fae8 with SMTP id
 x14-20020a25ac8e000000b006ca0a19fae8mr30968999ybi.417.1666732985236; Tue, 25
 Oct 2022 14:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221020232532.1128326-3-calvinwan@google.com>
 <221021.86lep9g9ja.gmgdl@evledraar.gmail.com> <CAFySSZCFrfhdKuOT=kxqPPBGBD0T2FtD4vJHfa9M3cMAPCSBtA@mail.gmail.com>
 <221025.86fsfbd64l.gmgdl@evledraar.gmail.com>
In-Reply-To: <221025.86fsfbd64l.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 25 Oct 2022 14:22:54 -0700
Message-ID: <CAFySSZBQ8XWpFEOit4DcL6fV6Kbn15WTn+jR4w8YnjF9Fm1vVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] run-command: add hide_output to run_processes_parallel_opts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Setting "no_stdout", "no_stderr", etc. in a
> > "child_process" shouldn't imply that we still pass the stdout and stderr to
> >  "parallel_processes" and then we send the output to "/dev/null".
>
> Sure, but if they're not producing any output because it's being piped
> to /dev/null how worthwhile is it to optimize that?
>
> We still can optimize it, but I still think the interface should just be
> the equivalent of:
>
>         parallel -k -j100% 'sleep 0.0$RANDOM && echo {} >/dev/null' ::: {1..100}
>
> Whereas what you seem to be trying to implement is the equivalent of a:
>
>         parallel -u -j100% 'sleep 0.0$RANDOM && echo {} ::: {1..100} >/dev/null
>
> Except as an option to the parallel API, but the end result seems to be
> equivalent.
>
> > That being said, I can understand the aversion to adding an option like
> > this that doesn't also add support for stdout and stderr. I can remove this
> > patch and instead reset the buffer inside of pipe_output and task_finished
> > in a later patch
>
> I'm not necessarily opposed to it, just puzzled about it, maybe I don't
> have the full picture.
>
> In general I highly recomend looking at whatever GNU parallel is doing,
> and seeing if new features in run-command.[ch] can map to that mental
> model.
>
> Our API is basically a small subset of its featureset, and I've found it
> useful both to steal ideas from there, and to test
> assumptions. E.g. "ungroup" is just a straight rip-off of the
> "--ungroup" option, it's also had to think about combining various
> options we don't have yet (but might want).
>
> In that case the supervisor API/parallel(1) needs to do something
> special, but for "I don't want output" it seems best to just do that at
> the worker level, i.e. equivalent to piping to /dev/null.

Well I want the output to be able to parse it, but not to print it. Piping
to /dev/null at the worker level denies me the ability to parse it in the
parent process.

Am I understanding correctly that what you're suggesting is if a child
process has "no_stderr" and "no_stdout" set to true, then
parallel_processes would temporarily set them to false before
start_command, and then honor it later after the output is read?
This would allow me to call pipe_output and parse it before sending
the output to /dev/null without the need for "hide_output"
