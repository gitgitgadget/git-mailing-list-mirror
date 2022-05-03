Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC519C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 00:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiECAFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiECAD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 20:03:56 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40172F5C
        for <git@vger.kernel.org>; Mon,  2 May 2022 17:00:19 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id u205so15023716vsu.6
        for <git@vger.kernel.org>; Mon, 02 May 2022 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ieJ7DmSxWKlE5/onTPS1I8da0JLydaGd388lWlTlEp4=;
        b=eL808YsisrpVDmFFlW9ijkudxbEKouIxRVw7EwCVCvr8IKktexbANn3id+AQWQbBKq
         E2uq8EwNodXYtpMqZ5GOhIpr1Tv/grNtQ3jqASMHMiGjiUqULW1paAlwHze5gQtMQmMi
         aKDmkve4RcqgGFtqOBd3NOq7rWoNTFrCyRnlYO7nlnKGTpaM04PqP1c3SeVL1eQfVpRl
         0N0tiG3wPwr28hDlT+zsyElOWI8EbwVLNEhCEkGIju6G2Eiye70gdfe4RV3iJ+66ulGQ
         VnXDenVvfn2/DPcmH7UkLjuGIoTuELxUq8XEwQFw9aVJbRhC+S70/332Y6q25saUJVod
         RyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ieJ7DmSxWKlE5/onTPS1I8da0JLydaGd388lWlTlEp4=;
        b=PjTk2yVHqMXii2+ltu9V/NWI0zUkFo4GYHdSOtfXluhq1LMSYmfjzV9mPLvIbU5Q6M
         m3Rj5WoDezgvSTKJa/kmvBFRG6eAid4pq00+Yj8PIe7WpKinG5gLd+3HnUPzdPKozxx0
         SkINlcVVwmGtgk3jflVfqDjLYGLgd8s+uWubNSHd2uhNHc/1ibRutDTNuMjBIHubDQJd
         A6hgcePnLXEv6J+mjY2sTWdG5sSdbp5Mc5kSD5W+i4b65ANMHXDyqV1O9U5GNXpVGQmh
         UMdv9dzsc+YS9nNDKa/6Pzt4BGIi5uzveL+t75T6ZiEbJVsJQr5z4m3RoI12qhFsO+4l
         7Mjw==
X-Gm-Message-State: AOAM532zxF1Y/F5wLyNx0AtCBZb+s5bDHxE7hNOHGnU0yQLAkXXGz+qG
        J/cSRxyrDzUKxMx8fmtR6MzIoASBnDKClriOVLhzzzfS
X-Google-Smtp-Source: ABdhPJyaRIEggGZVJmzRXgFhMgMUZwhvukmDUS8TgQFd6NvXcdvHgtrZABiIKZzxh9u7+FqfPPXOQvYAInTqHAT08kM=
X-Received: by 2002:a67:c78d:0:b0:32d:1e85:9337 with SMTP id
 t13-20020a67c78d000000b0032d1e859337mr3795751vsk.76.1651536018302; Mon, 02
 May 2022 17:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220502183920.88982-1-carenas@gmail.com>
 <20220502183920.88982-4-carenas@gmail.com> <xmqqo80fvb5q.fsf@gitster.g>
In-Reply-To: <xmqqo80fvb5q.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 2 May 2022 17:00:07 -0700
Message-ID: <CAPUEspi+2ZA3jxfggiwp43XJ2+LmzymVeNBFFnWtyptZ8Tj41w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] t0034: enhance framework to allow testing more
 commands under sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 2, 2022 at 3:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > +# Runs a scriplet passed through stdin under sudo.
> > +run_with_sudo () {
> > +     local ret
> > +     local SH=3D${1-"$TEST_SHELL_PATH"}
> > +     local RUN=3D"$HOME/$$.sh"
> > +     {
> > +             echo "#!$SH"
> > +             echo "set -e"
> > +             echo ". \"$HOME/env\""
> > +             cat
> > +     } >"$RUN" &&
> > +     chmod +x "$RUN" &&
> > +     sudo "$SH" -c "\"$RUN\""
> > +     ret=3D$?
> > +     rm -f "$RUN"
> > +     return $ret
> > +}
>
> I wonder if write_script can be used for better readability.  It is
> especially true as I am going to suggest ripping out $HOME/env stuff
> that is not absolutely needed (and its support with this patch looks
> inadequate when we do need one).
>
>         local RUN=3D$HOME/$$.sh &&
>         write_script "$RUN" "$TEST_SHELL_PATH" &&
>         sudo "$RUN"
>
> or something?

correct, I tried to use write_script initially, but I thought that
since I needed to inject code at the beginning for env, I could also
inject "set -e" and make sure that any scriplet used would work (and
more importantly fail when not) even without the "&&".

so the scriptlets themselves would be more readable.

My function is just a slightly modified version of wrte_script for
that reason, as making write_script do that seemed more complicated
than what I ended up doing.

> +# Makes all variables passed as parameters available to the scriplet tha=
t
> > +# run under sudo with run_with_sudo
> > +export_to_sudo () {
> > +     while test -n "$1"
> > +     do
> > +             local v
> > +             eval v=3D"\$$1"
> > +             echo "$1=3D$v" >>"$HOME/env"
> > +             shift
> > +     done
> > +}
>
> Two potential issues:
>
>  - This forces the caller to list _all_ the relevant environment
>    variables that would ever matter, which would not be feasible and
>    would not be maintainable.  For example, by forgetting to export
>    GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS, "git" commands run in the
>    sudo tests change their behaviour.  Whoever writing a new test
>    need to see what obscure GIT_TEST_* thing may affect the test
>    they want to write, and whoever enhancing the test framework to
>    add new GIT_TEST_* knob need to pay attention to the users of
>    export_to_sudo if their new knob need to be exported.
>
>  - I think the assignment to $v under eval is correct, but I am not
>    sure the string accumulated in the $HOME/env file is safe to
>    eval.  We can pass TEST_DIRECTORY via this mechanism, where the
>    value deliberately has a whitespace in it, but if the leading
>    path to our source directory had a single-quote in it, it
>    probably would not work well.  Of course, any variable that has
>    LF in its value would not work without proper quoting.
>
> I think both are not impossible but are hard to do right.  Because I
> do not see anything that absolutely needs the $HOME/env mechanism to
> work in the rest of the tests in this patch, I am inclined to say
> that I'd prefer keeping things simple and only make sure we use the
> right $SHELL to run our script (which write_script may help).

makes sense, would prepare a formal v3 with those changes and that
should be safe to queue.

> > +test_expect_success SUDO 'cannot access if owned by root' '
> > +     (
> > +             cd root/p &&
> > +             test_must_fail git status
> > +     )
> > +'
>
> OK, but strictly speaking, we do not need the SUDO prerequisite for
> this one.  It still need it for the test directories prepared in
> previous steps anyway, so perhaps we want one check upfront, just
> like we do for NOT_ROOT?
>
>         if ! test_have_prereq SUDO
>         then
>                 skip_all=3D"You do not seem to have a working 'sudo'"
>                 test_done
>         fi

my only concern doing that would be that then could confuse people
adding new tests later that might also not need SUDO and that would be
skipped because they were added at the end, but I agree it is overall
cleaner so would also include in the reroll

> > +test_expect_success SUDO 'cannot access with sudo' '
> > +     (
> > +             # TODO: test_must_fail needs additional functionality
> > +             # 6a67c759489 blocks its use with sudo
> > +             cd root/p &&
> > +             ! sudo git status
> > +     )
> > +'
>
> OK.  So we cannot by default access root-owned repository by
> default, which is OK.  I wonder what happens if we did "sudo sudo
> git status".  Perhaps the inner sudo will notice that SUDO_UID is
> set in its environment and does not update it to 0?

funny enough sudo itself doesn't honour SUDO_UID.

>       ... goes and checks ...
>         $ sudo sudo sh -c 'echo $SUDO_UID; whoami'
>         0
>         root
>
> So that gives us another workaround, I guess, which might be even
> simpler.

correct.

> > +test_expect_success SUDO 'can access using a workaround' '
> > +     # provide explicit GIT_DIR
> > +     (
> > +             cd root/p &&
> > +             run_with_sudo <<-END
> > +                     GIT_DIR=3D.git
> > +                     GIT_WORK_TREE=3D.
> > +                     export GIT_DIR GIT_WORK_TREE
> > +                     git status
> > +             END
> > +     ) &&
> > +     # discard SUDO_UID
> > +     (
> > +             cd root/p &&
> > +             run_with_sudo <<-END
> > +                     unset SUDO_UID
> > +                     git status
> > +             END
> > +     )
>
>         # double sudo
>         (
>                 cd root/p &&
>                 sudo sudo git status
>         )
>
> I do not know if it is worth adding this third workaround.

I think it is, as it helps document them, and makes sure they remain
viable, but still think that the one added to the documentation is
"better", because it is direct and not an implementation detail

removing SUDO_UID from your environment "means" you want to be
identified as root by git from then on, and that the fact that you
might have become root through sudo is no longer relevant.

Carlo
