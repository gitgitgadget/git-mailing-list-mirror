Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8156C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 12:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiLAMeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 07:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLAMem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 07:34:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EAE3B8
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 04:34:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so2126012edc.12
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qpI+6n9qpn8hXUs/PQNKh7YBenWA9vbs8Jm/rIJQNc=;
        b=qzjqyyc128GdxAUij7hZDXDIOGEh+2uw5zDa37zgDFluUPZpT77guwZpm3x1ckaTOv
         5ghD/TQAzKc1VkPrFMIa0FT+EGdK9YAnxjdO6wUgh+UmDy+jcNS3OzG4aDpBWxdGnnHy
         RLmP/+MOXs1UejJasTdwZOizRTQplomSl15/Vru89kMB2TsofPLJQgbhn4tK0Xo023RG
         vZbyQm4Bn+XNsEg8gtKO4WzGX1RU6NYTOte6SrVuZrhgtzd2hpkfeaS3SaEsp5vuwDGi
         FN+7ETNsUcvulWL/yDjhytKX4/6bDLnZ6r1sQGNNCfdS9KDeblzcr/tzaJKS5nDt94bd
         8kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qpI+6n9qpn8hXUs/PQNKh7YBenWA9vbs8Jm/rIJQNc=;
        b=PKlmOUsLsKCrdSwzdAdhRtgO8dEaA9PBwtTWLUchHWkyDumgCvnddZosN9o4iydc2Y
         AP1kdvjtUVOARfqixIjVYZS3r4KtjAV/MMfely/3zlgEy36yjaNpaUGelmolSlzdcPnZ
         5NefiOOF8fY6Zv5a8K2mCsecmU2W9pL86SWTtLfAHu6i4lfaxibOLoi5swo70oNSt8VS
         n3DzkBCFd9UEZ5HxpY0O196LO+p8s9QQX5IPR/EoxOgEqTBz1ss258zcEOibjnduBDJa
         sfeAkpctfqX09JIhBcLtgIEJb0wtJxTGSQzrTqA2LCd+rlkRoociTQcCC4BzZ1tyYAQ5
         3rpw==
X-Gm-Message-State: ANoB5pkvBeKqyI/JE3D1APpDfEtSfTfcI7V+KFIDbvgMwl47TGtz+Ocv
        9b6NdPIp21+zVXCOoe+5qi3m8Kx+upo=
X-Google-Smtp-Source: AA0mqf5cbXAYyOyZfhC9em2NAmgFa8M+M/gn+rObFR+ypahEk50lKvho1LorH6LSpB3jBtLH2ckPrg==
X-Received: by 2002:aa7:cd04:0:b0:46b:34c:5574 with SMTP id b4-20020aa7cd04000000b0046b034c5574mr21051774edw.175.1669898079525;
        Thu, 01 Dec 2022 04:34:39 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907138700b007c0ad7fcb7dsm798621ejb.108.2022.12.01.04.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 04:34:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0ily-002CQx-0N;
        Thu, 01 Dec 2022 13:34:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What are cherry-pick's exit codes?
Date:   Thu, 01 Dec 2022 13:19:58 +0100
References: <878rjry5a7.fsf@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <878rjry5a7.fsf@gmail.com>
Message-ID: <221201.86zgc7gv4x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 01 2022, Sean Allred wrote:

> Hi folks,
>
> We're developing some internal tooling wrapping git-cherry-pick and need
> to be able to distinguish its different error codes. Problem is: these
> exit codes don't seem to be documented in git-cherry-pick.txt.
>
> Looking at the source, I found myself down the rabbit-hole very quickly.
> I'm not too familiar with the coding patterns quite yet -- but I'm
> pretty sure I eventually found myself redirected to git-commit in one
> case. At that point, I thought it better to ask here.

This is definitely worth doing, and there's a bit of a rabbit hole here,
so it'l also good you asked.

> I'd like to document these exit codes in the manpage and I'm more than
> happy to submit the patch, but I thought I'd confirm my understanding
> first since it's based purely on reading the cherry-pick tests:
>
> Exit code:
>
>   - 0: success, sequencer complete -- no conflicts
>
>   - 1: 'success', sequencer incomplete -- conflicts encountered

In general I think you'd do well to follow the template of what I did in
9144ba4cf52 (remote: add meaningful exit code on missing/existing,
2020-10-27).

In particular, I don't think we should exhaustively document exit codes
for a given command, as we really have a hard time controlling all the
possible values.

Rather, we should define specific non-zero values as having specific
meanings, as I did with "git remote" in that commit.

We'd also ideally leave "exit(1)" alone, and if we need to disambiguate
it start with "exit(2)", but maybe it's easy to make it unambiguous in
this case, or it's already unambiguous...


>   - 127: fatal -- lots of reasons -- I'm guessing this is value for the
>     'return -1' and 'return error(...)' statements speckled throughout
>     the code, but it's been a long time since I cared about two's
>     complement so I may be wrong here.

If it's "return -1" you generally end up with 255 in your shell,
although that's unportable both for the C language, and for POSIX.

See 19d75948ef7 (common-main.c: move non-trace2 exit() behavior out of
trace2.c, 2022-06-02) for some code dealing with that (where we fake up
the -1 to 255, for logging).

But from looking at cmd_cherry_pick() we catch any <0 return values and
die() on them, but maybe we exit() elsewhere? Do you have an example of
these.

>   - 128: fatal -- sequence is interrupted, possibly due to some other
>     fatal error, e.g., 'commit doesn't exist' or 'mainline parent number
>     doesn't exist'
>
>   - 129: fatal -- there was nothing to cherry-pick at all (e.g. empty
>     range)

I think as in 9144ba4cf52 (remote: add meaningful exit code on
missing/existing, 2020-10-27) it's good to just leave these
undocumented.

We typically return these when we invoke die() or usage_with_options()
(or similar).

So, if we are documenting them (which would be a good change, as an
aside) that probably belongs in gitcli(7), we could then reference that
from other man pages.

> I'm reasonably confident about 0/1 just anecdotally -- I'm less sure
> about everything else.
>
> Obviously the actual text put in the manpage should be friendlier and
> possibly vaguer for clarity (paradoxical, perhaps, but it seems more
> direct to say '0 for success, 1 for conflicts, and anything else is a
> fatal error'), but I wanted to make sure that I have an actually-
> accurate understanding rather than something only surface-level.
>
> Two questions:
>
>   1. Are the exit codes actually documented somewhere already that
>      should simply be linked from git-cherry-pick.txt?

No, just when we promise specific codes for specific
commands. E.g. git-remote, git-config etc. come to mind.

>   2. If not, is the above listing the exit codes accurate and complete?

I don't know, but skimming the code I don't see the "return 1", unless
by the above " - 1" you mean "minus one", i.e. 255.

I.e. cmd_cherry_pick() calls run_sequencer(), which on error seems to
return -1 for most things, which we then coerce to that die().

But I haven't looked in much detail, so...
