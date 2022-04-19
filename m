Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D4C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 23:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiDSXzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 19:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiDSXzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 19:55:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2122CC8B
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 16:52:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b24so192255edu.10
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=umGoMKVQO3j6AxA3oNtd28bglL+qb+EJIgvqzKKeisI=;
        b=Igk0ED4N2iBcojQar8A4lZgTKMTjShs+kXfyR7BzOd1tmKGKvawNbk0nCnp+XGJQ7b
         fGXoesmzfeTfFa51K70bKTe3GPkU3fjReJzEUp9WmJKEiochKXnNlO25mUYAEbgDsUHJ
         UXboEtP/cubDOtKkIuByf4R4ihcCnIxbAlhtACMkxHbhMy+vB0Jj3kwck0R7e7kVi/AZ
         R5VeC3GlrdpwQtNanGiAGVQvyQpKDsN2BstuTcsr1mfLgzkisCNXo3MDSukxt9KhPOaM
         eD/6MO/jwSnQeMesnOnDMOrDfWAXOnZUBDzBEIV3Vb4LkbR5iovmpvYedeHNOO7PD4Pn
         hS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=umGoMKVQO3j6AxA3oNtd28bglL+qb+EJIgvqzKKeisI=;
        b=F55osCnz9OYsBZl/YJMIZdSahz6W5I3sU/qSwpZd+9XUExCuBugb+zHAul7wwTvpPJ
         ZkrSvfTT0yu1PC/oGd1eRFJ+gIhFYURYsMl0UxrX95TI6PbMsO3iEqWTTS0K7p5nd74K
         AXH6Zi8bKoPiqwEiCuDZ9dVU8eBvr8+4bKsvZR4iI4q/wfBsF8FIVWTu/nvuPMqVguaA
         CBmBcJdwP1ySo6LHgmGkzJBluCFN9tXPhomdUjBbRDu1wlJ3XGej086AnMz75EmPLIdT
         R6+/wDIGkdYUt/qbhCLDq/rT3DptkyPaH93pW2ndIs1FbN6++3ZZLcGqlrhXr/NAcvVJ
         hldQ==
X-Gm-Message-State: AOAM532PwRJEDY5QF2z9txvK0Sd+y8pid8j1mrew1xFKYLUe09fJRTpU
        xPx/zf5CbocYIkgLJsMX5v+fYGToq9gagfYei4T1YaMJsT0=
X-Google-Smtp-Source: ABdhPJw2+YxxnDVPH2MuDVSSjq2FVjHDRQKF6IvHxNQyNvjDRwBBmlCLkZKCM6jc5d6QaPKgq+ecFGj3XV2YHjpUQdw=
X-Received: by 2002:a05:6402:34c8:b0:423:f53f:6365 with SMTP id
 w8-20020a05640234c800b00423f53f6365mr9509417edc.274.1650412345582; Tue, 19
 Apr 2022 16:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <Yl9Hn0C0TwalASC0@google.com>
In-Reply-To: <Yl9Hn0C0TwalASC0@google.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 19 Apr 2022 19:52:15 -0400
Message-ID: <CA+dzEBntTx++n0QVcd3KHr_ri5Vmo4wEqY4_BBg8zuT7R4e7-Q@mail.gmail.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 7:37 PM Emily Shaffer <emilyshaffer@google.com> wro=
te:
>
> On Tue, Apr 19, 2022 at 02:59:36PM -0400, Anthony Sottile wrote:
> >
> > here's the shortest reproduction --
> >
> > ```console
> > $ cat ../testrepo/.git/hooks/pre-commit
> > #!/usr/bin/env bash
> > if [ -t 1 ]; then
> >     echo GOOD
> > fi
> > ```
> >
> > in previous git versions:
> >
> > ```
> > $ git commit -q --allow-empty -m foo
> > GOOD
> > $
> > ```
> >
> > with git 2.36.0:
> >
> > ````
> > $ git commit -q --allow-empty -m foo
> > $
> > ```
> >
> > why I care: I maintain a git hooks framework which uses `isatty` to
> > detect whether it's appropriate to color the output.  many tools
> > utilize the same check.  in 2.36.0+ isatty is false for stdout and
> > stderr causing coloring to be turned off.
> >
> > I bisected this (it was a little complicated, needed to force a pty):
> >
> > `../testrepo`: a git repo set up with the hook above
> >
> > `../bisect.sh`:
> >
> > ```bash
> > #!/usr/bin/env bash
> > set -eux
> > git clean -fxfd >& /dev/null
> > make -j6 prefix=3D"$PWD/prefix" NO_GETTEXT=3D1 NO_TCLTK=3D1 install >& =
/dev/null
> > export PATH=3D"$PWD/prefix/bin:$PATH"
> > cd ../testrepo
> > (../pty git commit -q --allow-empty -m foo || true) | grep GOOD
> > ```
> >
> > `../pty`:
> >
> > ```python
> > #!/usr/bin/env python3
> > import errno
> > import os
> > import subprocess
> > import sys
> >
> > x: int =3D 'nope'
> >
> >
> > class Pty(object):
> >     def __init__(self):
> >         self.r =3D self.w =3D None
> >
> >     def __enter__(self):
> >         self.r, self.w =3D os.openpty()
> >
> >         return self
> >
> >     def close_w(self):
> >         if self.w is not None:
> >             os.close(self.w)
> >             self.w =3D None
> >
> >     def close_r(self):
> >         assert self.r is not None
> >         os.close(self.r)
> >         self.r =3D None
> >
> >     def __exit__(self, exc_type, exc_value, traceback):
> >         self.close_w()
> >         self.close_r()
> >
> >
> > def cmd_output_p(*cmd, **kwargs):
> >     with open(os.devnull) as devnull, Pty() as pty:
> >         kwargs =3D {'stdin': devnull, 'stdout': pty.w, 'stderr': pty.w}
> >         proc =3D subprocess.Popen(cmd, **kwargs)
> >         pty.close_w()
> >
> >         buf =3D b''
> >         while True:
> >             try:
> >                 bts =3D os.read(pty.r, 4096)
> >             except OSError as e:
> >                 if e.errno =3D=3D errno.EIO:
> >                     bts =3D b''
> >                 else:
> >                     raise
> >             else:
> >                 buf +=3D bts
> >             if not bts:
> >                 break
> >
> >     return proc.wait(), buf, None
> >
> >
> > if __name__ =3D=3D '__main__':
> >     _, buf, _ =3D cmd_output_p(*sys.argv[1:])
> >     sys.stdout.buffer.write(buf)
> > ```
> >
> > the first commit it points out:
> >
> > ```
> > f443246b9f29b815f0b98a07bb2d425628ae6522 is the first bad commit
> > commit f443246b9f29b815f0b98a07bb2d425628ae6522
> > Author: Emily Shaffer <emilyshaffer@google.com>
> >
> >     commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
> >
> >     Move these hooks hook away from run-command.h to and over to the ne=
w
> >     hook.h library.
> >
> >     Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> >     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
> >     Acked-by: Emily Shaffer <emilyshaffer@google.com>
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> >  commit.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > bisect run success
> > ```
>
> Interesting. I'm surprised to see the tty-ness of hooks changing with
> this patch, as the way the hook is called is pretty much the same:
>
> run_hook_ve() ("the old way") sets no_stdin, stdout_to_stderr, args,
> envvars, and some trace variables, and then runs 'run_command()';
> run_command() invokes start_command().
>
> run_hooks_opt ("the new way") ultimately kicks off the hook with a
> callback that sets up a child_process with no_stdin, stdout_to_stderr,
> args, envvars, and some trace variables (hook.c:pick_next_hook); the
> task queue manager also sets .err to -1 on that child_process; then it
> calls start_command() directly (run-command.c:pp_start_one()).
>
> I'm not sure I see why the tty-ness would change between the two. If I'm
> being honest, I'm actually slightly surprised that `isatty` returned
> true for your hook before - since the hook process is a child of Git and
> its output is, presumably, being consumed by Git first rather than by an
> interactive user shell.
>
> I suppose that with stdout_to_stderr being set, the tty-ness of the main
> process's stderr would then apply to the child process's stdout (we do
> that by calling `dup(2)`). But that's being set in both "the old way"
> and "the new way", so I'm pretty surprised to see a change here.
>
> It *is* true that run-command.c:pp_start_one() sets child_process:err=3D-=
1
> for the child and run-command.c:run_hook_ve() didn't do that; that -1
> means that start_command() will create a new fd for the child's stderr.
> Since run_hook_ve() didn't care about the child's stderr before, I
> wonder if that is why? Could it be that now that we're processing the
> child's stderr, the child no longer thinks stderr is in tty, because the
> parent is consuming its output?
>
> I think if that's the case, a fix would involve
> run-command.c:pp_start_one() not setting .err, .stdout_to_stderr, or
> .no_stdin at all on its own, and relying on the 'get_next_task' callback
> to set those things. It's a little more painful than I initially thought
> because the run_processes_parallel() library depends on that err capture
> to run pp_buffer_stderr() unconditionally; I guess it needs a tiny bit
> of shim logic to deal with callers who don't care to see their
> children's stderr.
>
> All that said.... I'd expect that the dup() from the child's stdout to
> the parent's stderr would still result in a happy isatty(1). So I'm not
> convinced this is actually the right solution.... From your repro
> script, I can't quite tell which fd the isatty call is against (to be
> honest, I can't find the isatty call, either). So maybe I'm going the
> wrong direction :)

ah, most of the repro script was just so I could bisect -- you can
ignore pretty much all of it except for the `pre-commit` file:

#!/usr/bin/env bash
if [ -t 1 ]; then
   echo GOOD
fi

this is doing "isatty" against fd 1 which is stdout (it could also try
the same against fd 2 which was also a tty previously)

Anthony

>
>  - Emily
