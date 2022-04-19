Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED0C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 23:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiDSXj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347459AbiDSXjy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 19:39:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144113D01
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 16:37:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i24so262799pfa.7
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eGpCMQeneIJ0TotQ+zD6YHcznkeRV94EoNS3qhpfdh8=;
        b=iDBMANZk4Ynwvm1MiJ8vjJ1e3a9Afn+cyFgXWOL73smfASk4WR7TQZ8iinFDCqQ9Zf
         W0lyVstJIwmTlowJMrflA+EzOrHARCkHYVk2i/i1iz6KA38mT8RjKhu9dX18k3If+wR1
         9ct5CYWbOIUIaRVBHHA0RHvHeZI2aM3PWemocG6Qd+NtN0KRHnoAe6ZpwTsdbZpv3Uo9
         XpyAzrDvusPOU0AYc5uVqYivzsWxBkDix2qNr7ZRKVRubyoKFxpdMOQrL7cjidaqH/TE
         iRqXC+yOzY1leu48Qx9PTo/1gho8sqmCKv/7Idy2jW76Vl+EUt0kXCsz4Bhcc84OFcro
         EI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eGpCMQeneIJ0TotQ+zD6YHcznkeRV94EoNS3qhpfdh8=;
        b=nlK/HHoRwaOOiFLRDe4N7ECA9eSuSId7TuyhTAiPgvTji7r0S1lT0ZzcYjBJ4fSrS2
         PV9xly7PdMKA3WnLnV+l1n/TEfWQqCrzy+NIuKMJgivaxW7y3nfXFZ8uufq1OgtorTMF
         f+p5uoHW6UOrlEoch44tYw2gdxz8ih7QEaznPIoxQZLMew+7/fBPH2w7ciJl97LeOCND
         nQZIw6qdafyZy3Dsd4Jetpbg76OCxRZPBzIY5MnunN56p/w3Go+enD91aQ5J/n1bPxPE
         6YSBuhSnBlTNXBQmvQqO33LhYZ6QM3ZzUTAsQ2kv9/pYEE9JGV50QZ3LnckcPHmpPIeq
         MkMQ==
X-Gm-Message-State: AOAM533jUTuu1+9C+2801qWMGkYyL65ZUOrMO7xFwa4/eWQ0B7i+Bv8j
        P8ssn+VgZUJPnAdkV++rBVEkfyUTqMc9tw==
X-Google-Smtp-Source: ABdhPJy2WSF9kdODTYIUKwto2bKbIyqbmvNmZqCtgOW26hF4MIny8G+WGUR6UU8dHITjhDW0Ydpq7g==
X-Received: by 2002:a63:f005:0:b0:3a3:ef7c:c8dd with SMTP id k5-20020a63f005000000b003a3ef7cc8ddmr16365575pgh.37.1650411429036;
        Tue, 19 Apr 2022 16:37:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:db68:2c97:40f3:5624])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b001ca3c37af65sm17695566pjb.21.2022.04.19.16.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 16:37:08 -0700 (PDT)
Date:   Tue, 19 Apr 2022 16:37:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
Message-ID: <Yl9Hn0C0TwalASC0@google.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 02:59:36PM -0400, Anthony Sottile wrote:
> 
> here's the shortest reproduction --
> 
> ```console
> $ cat ../testrepo/.git/hooks/pre-commit
> #!/usr/bin/env bash
> if [ -t 1 ]; then
>     echo GOOD
> fi
> ```
> 
> in previous git versions:
> 
> ```
> $ git commit -q --allow-empty -m foo
> GOOD
> $
> ```
> 
> with git 2.36.0:
> 
> ````
> $ git commit -q --allow-empty -m foo
> $
> ```
> 
> why I care: I maintain a git hooks framework which uses `isatty` to
> detect whether it's appropriate to color the output.  many tools
> utilize the same check.  in 2.36.0+ isatty is false for stdout and
> stderr causing coloring to be turned off.
> 
> I bisected this (it was a little complicated, needed to force a pty):
> 
> `../testrepo`: a git repo set up with the hook above
> 
> `../bisect.sh`:
> 
> ```bash
> #!/usr/bin/env bash
> set -eux
> git clean -fxfd >& /dev/null
> make -j6 prefix="$PWD/prefix" NO_GETTEXT=1 NO_TCLTK=1 install >& /dev/null
> export PATH="$PWD/prefix/bin:$PATH"
> cd ../testrepo
> (../pty git commit -q --allow-empty -m foo || true) | grep GOOD
> ```
> 
> `../pty`:
> 
> ```python
> #!/usr/bin/env python3
> import errno
> import os
> import subprocess
> import sys
> 
> x: int = 'nope'
> 
> 
> class Pty(object):
>     def __init__(self):
>         self.r = self.w = None
> 
>     def __enter__(self):
>         self.r, self.w = os.openpty()
> 
>         return self
> 
>     def close_w(self):
>         if self.w is not None:
>             os.close(self.w)
>             self.w = None
> 
>     def close_r(self):
>         assert self.r is not None
>         os.close(self.r)
>         self.r = None
> 
>     def __exit__(self, exc_type, exc_value, traceback):
>         self.close_w()
>         self.close_r()
> 
> 
> def cmd_output_p(*cmd, **kwargs):
>     with open(os.devnull) as devnull, Pty() as pty:
>         kwargs = {'stdin': devnull, 'stdout': pty.w, 'stderr': pty.w}
>         proc = subprocess.Popen(cmd, **kwargs)
>         pty.close_w()
> 
>         buf = b''
>         while True:
>             try:
>                 bts = os.read(pty.r, 4096)
>             except OSError as e:
>                 if e.errno == errno.EIO:
>                     bts = b''
>                 else:
>                     raise
>             else:
>                 buf += bts
>             if not bts:
>                 break
> 
>     return proc.wait(), buf, None
> 
> 
> if __name__ == '__main__':
>     _, buf, _ = cmd_output_p(*sys.argv[1:])
>     sys.stdout.buffer.write(buf)
> ```
> 
> the first commit it points out:
> 
> ```
> f443246b9f29b815f0b98a07bb2d425628ae6522 is the first bad commit
> commit f443246b9f29b815f0b98a07bb2d425628ae6522
> Author: Emily Shaffer <emilyshaffer@google.com>
> 
>     commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
> 
>     Move these hooks hook away from run-command.h to and over to the new
>     hook.h library.
> 
>     Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>     Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>     Acked-by: Emily Shaffer <emilyshaffer@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
>  commit.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> bisect run success
> ```

Interesting. I'm surprised to see the tty-ness of hooks changing with
this patch, as the way the hook is called is pretty much the same:

run_hook_ve() ("the old way") sets no_stdin, stdout_to_stderr, args,
envvars, and some trace variables, and then runs 'run_command()';
run_command() invokes start_command().

run_hooks_opt ("the new way") ultimately kicks off the hook with a
callback that sets up a child_process with no_stdin, stdout_to_stderr,
args, envvars, and some trace variables (hook.c:pick_next_hook); the
task queue manager also sets .err to -1 on that child_process; then it
calls start_command() directly (run-command.c:pp_start_one()).

I'm not sure I see why the tty-ness would change between the two. If I'm
being honest, I'm actually slightly surprised that `isatty` returned
true for your hook before - since the hook process is a child of Git and
its output is, presumably, being consumed by Git first rather than by an
interactive user shell.

I suppose that with stdout_to_stderr being set, the tty-ness of the main
process's stderr would then apply to the child process's stdout (we do
that by calling `dup(2)`). But that's being set in both "the old way"
and "the new way", so I'm pretty surprised to see a change here.

It *is* true that run-command.c:pp_start_one() sets child_process:err=-1
for the child and run-command.c:run_hook_ve() didn't do that; that -1
means that start_command() will create a new fd for the child's stderr.
Since run_hook_ve() didn't care about the child's stderr before, I
wonder if that is why? Could it be that now that we're processing the
child's stderr, the child no longer thinks stderr is in tty, because the
parent is consuming its output?

I think if that's the case, a fix would involve
run-command.c:pp_start_one() not setting .err, .stdout_to_stderr, or
.no_stdin at all on its own, and relying on the 'get_next_task' callback
to set those things. It's a little more painful than I initially thought
because the run_processes_parallel() library depends on that err capture
to run pp_buffer_stderr() unconditionally; I guess it needs a tiny bit
of shim logic to deal with callers who don't care to see their
children's stderr.

All that said.... I'd expect that the dup() from the child's stdout to
the parent's stderr would still result in a happy isatty(1). So I'm not
convinced this is actually the right solution.... From your repro
script, I can't quite tell which fd the isatty call is against (to be
honest, I can't find the isatty call, either). So maybe I'm going the
wrong direction :)

 - Emily
