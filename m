Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93009ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 21:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIMVIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMVIp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 17:08:45 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2AA5FF68
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 14:08:44 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127f5411b9cso35635710fac.4
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=+Q01JHM/gcUItMb7x495s30l+oauJCaNk76IAmmD9G0=;
        b=QP4IY5ZPysMyd6B2T0tEeh3yT+4QbJNtCS1tf2LvQWqksh6hotx8CtmvHnHZ/Maj0q
         m6PyNZ20KTTRTTCxiBOGodgH+INocXVEC3rBcWboFKgieI6Ck+w5e4grz1wLOpEX4lV9
         EQ92y+9zROPtlKq1rpaVhj97zlXcnStHWDSyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+Q01JHM/gcUItMb7x495s30l+oauJCaNk76IAmmD9G0=;
        b=QT7olyL9he5+rEOu/tyeXh2mOD8VA8TArMbNF755QHmlyaZYXKZGONUS3Y4kbPEC1y
         I4T5BNX+N3rt8c78Ik9AjmPboJYSiRzOLZ8t4y+s0aTpHSMVKwtPpKSmchQp0wmt/fWm
         tp+L6FeiqCEU9VmL7bzO5Lwbd/RNAk+eTHHrE+7o99phlC4kw/hAXMc3BF9xrAnKL/xI
         9689foceMm7vfs8B+gAXYpFxPuWblF1DigmB5vERaZCw1u4ey24jDUDiscTv9uUoV/rT
         orTqfTgC5K4y72yGhvabZyB5CbkAeptodai1dK29ZNbyiYqHipC31etQBWsSfqJ+SQ3L
         6UyA==
X-Gm-Message-State: ACgBeo1Q1dS4NkEkILJMhA23fGCrI6lJbHPz5Nvbz8MLpFdvKC0QPu/v
        l5Vy7AE7d7H77hDhd7I+SRgdnzmUTgBsY53GjuwOyw==
X-Google-Smtp-Source: AA6agR4JEncgX8YxvF2g/D9BssRV7zyuSgPoCzcvaPtBQeKxGRzvrrYgQl1iS1i55i9yLXlQu//vIq3JNEDjEMOFmGA=
X-Received: by 2002:a54:4e97:0:b0:345:4cd0:20fd with SMTP id
 c23-20020a544e97000000b003454cd020fdmr576188oiy.206.1663103324073; Tue, 13
 Sep 2022 14:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
 <4s7o04s9-3052-rqq6-584n-978p9758p580@tzk.qr> <xmqqy1uusyez.fsf@gitster.g>
In-Reply-To: <xmqqy1uusyez.fsf@gitster.g>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 13 Sep 2022 22:08:10 +0100
Message-ID: <CA+kUOa=DP6c417ZXXtxsJuyqJgpLZeAyr4URQPtMs0JhH1zVWQ@mail.gmail.com>
Subject: Re: [PATCH] t1800: correct test to handle Cygwin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Sept 2022 at 21:49, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> @@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a ba=
d shebang' '
> >>      # TODO: We should emit the same (or at least a more similar)
> >>      # error on Windows and !Windows. See the OS-specific code in
> >>      # start_command()
> >> -    if test_have_prereq !WINDOWS
> >> +    if test_have_prereq !MINGW
> >
> > ... this to be `test_have_prereq !WINDOWS || test_have_prereq CYGWIN`
> > instead.
>
> My understanding is that there are CYGWIN and MINGW prereqs that are
> mutually exclusive (if you are on MINGW you cannot be on CYGWIN and
> vice versa), and WINDOWS is a short-hand for "we are either on MINGW
> or CYGWIN", and I am not sure if it clarifies anything to rewrite
> "we do not want to be on MINGW to run these tests" to "anything non
> Windows is fine, by the way, CYGWIN is also OK".
>
> If we are planning to add another variant that falls into umbrella
> WINDOWS that is not CYGWIN, and that new variant falls short of the
> requirement of the tests in this script just like MINGW does, then
> the suggested rewrite does make quite a lot of sense.  There would
> be not just two but more variants in Windows family, and if Cygwin
> is the odd man out, then the rewritten one would convey that more
> clearly.  But with only two, as long as everybody understands what
> MINGW is, I think "this part does not work on MINGW" is more concise
> and clear.

This is definitely how I was thinking about things. I've no particular
objection to taking some other approach, but until/unless there are a
wider variety of Windows variants, it seems like doing so would cause
more confusion, not less.

The only caveat is the "as long as everybody understands what MINGW
is" part. This is well beyond the scope of this small patch, but I
think "MINGW" is probably needlessly opaque these days. It makes sense
given the history of Git for Windows, but it's not a term many people
are likely to be familiar with unless they've already been playing
around with the MinGW/Cygwin environments, and I'm not sure that's a
useful prerequisite for folk to be able to contribute to Git. I'm not
sure what a better solution here might be; maybe retire "MINGW" and
redefine "WINDOWS" to take its place, with current uses of "WINDOWS"
being replaced with "WINDOWS || CYGWIN"?

> As =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh pointed out, the TODO: comm=
ent may need to be
> updated.  For future-proofing, perhaps "a more similar) error on all
> platforms." would be appropriate.

I'll respin with some updated comments shortly=E2=80=A6
