Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD722157F
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627737; cv=none; b=PMwSEj/Jn9Mqj8HR4DQRFf6cN/iZ55M/ApMgsRDwC3gr9pLrUjhcxt9WmX0Ts3lwyLgcSmpcbD3opUoEZbCMD/F56Nz0c/cB9SaxW3WkWjMoidn1GdXxNnsV7fZEVV4cvzHOOEdyzebzIhS83p9C58/wPsDIAq0U5QKLmyYb308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627737; c=relaxed/simple;
	bh=wmhVmfdtHwCMj+I9i7eIudeGQooXhgefGDNIeT7RtJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnXDwdODMdv3pS+VKEL4brk7BHV1CT1UeCwjGmh76HW+NfTk9msdrDK9ZvdqavlRRDWIhUw3PKCXFtbpYDlbXdQQ0RCFhyO+BnO/8LCgpMrjBvdVFFdX9JOGh7VEscs7vY4+mvKxmxsQx1beZu+rVopRokIw8zC9vjZRufPJROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b=TsbkC4fA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="TsbkC4fA"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b794743so8889698a12.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google; t=1755627731; x=1756232531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S2Zcu0h2MLFwR0PwvtmiLm442qTebwVNvMoppXc16HA=;
        b=TsbkC4fAfMq2tHazwpTmxUnqJHKUTPPrCaXUyLv6dcj7Bo8wCK+pLBLXseXMsTbBSl
         +TX5SVn5s54Q5i04bnv38QMRdWrmXV0Dz20iMVoD7erS2HYoYnd/CoUlIpsQ75ICRjNP
         ZhVDOz+wBpngneeFhbH51Zg+SQVzli8y5ZeXQtdhGuf/jmOlHCu3I0kdsNAOyNjFaBO3
         6y0uWz3K3ELWMsctbIAy2JSS7vN014cVdn7BQgHR6lQPhoJxwVuNh7VCZDFkudNDSoe6
         mUpoICUxr8gYZE9nQywztfBuKtblaiuAZKO661UVx/FlEUc+Uo7FMrhY/IgzgyygwIGr
         zZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627731; x=1756232531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2Zcu0h2MLFwR0PwvtmiLm442qTebwVNvMoppXc16HA=;
        b=OsOB8219tNgohql8OULPUYqCjMVdcRtb3qoHo4UbltOjfeR/SiEjIO48yPsdSrTQtU
         bBRlZeOVeZwpJTKhLTTWTsbe3N5ffLCx5G4CQa3CG4aHw8E1RTKkqjoJ3iYwuMD9KVOg
         Sk9uF6CoiVGp52EMl0P/S0CTLdwdwxegSDF89E8vP94JjGv4VbnIQHqqxpioo7xRvIOl
         l6UidolWuzwmBOFU5QG2FeHsL0EKeHTQ045Tjci+siobMtuVK/PYgU9aSpTzP9Q4gzip
         SYbqle9OUJsbj0C3Et8BKoL8IrcgjefKN9FMVMFDtxEi94kxlk5iV4Icx9kVBsbP2YDy
         Y4mw==
X-Gm-Message-State: AOJu0YzwjVhvN0RelboxXvjO6QpjalnPHGwBeAO6FPWfisFmNTtlXIUf
	+BQzU7/ggEEuTZWqfmMpEpnyh0f3raCKZJl1GLy8c0MJUDDBexYGzfeliXyprCEmDTCsL6EG/9g
	6dWvsXbR3fwa+4n3kRVvWjK4iXPLYEmeMPKKdDdjSjz+6/m2WxMQ9Xw==
X-Gm-Gg: ASbGncvARg6gAkoGQfgRDLpF2ZcKAcZTJNI3j5cQ1dDhh8J8nMFyJEGEmocPE3yHAIL
	gRhKSaioKjGjbgjr8hI+qTlwfaETOC2tHve5U4XOGKCvafE/va89+wQ6GEIWyvaMr3vc7Ugf3gq
	f9dtEuIHfi7fhmj8Gwjze4jgpPINvRZG032vENJ0B51JgrCa+rtYbDWe5rYMPSzoYT+Ar1bz/gT
	NAnDAnB95dtHe8MpyPo4XcxuPXT+1uFfigSP9o=
X-Google-Smtp-Source: AGHT+IG7KvvM3Ep2E1itqxqbmXFl7NVPrxbMo0mtM37Thtc+7YfVAfH+N7vxYk1aT37RTkfZR2m+gY4seSCeG8t0EjA=
X-Received: by 2002:a05:6402:3595:b0:61a:949a:b5c with SMTP id
 4fb4d7f45d1cf-61a97611bdfmr266658a12.23.1755627731498; Tue, 19 Aug 2025
 11:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816103656.1693607-1-adam@dinwoodie.org> <20250819074631.3303-1-adam@dinwoodie.org>
 <xmqqect7fhnp.fsf@gitster.g>
In-Reply-To: <xmqqect7fhnp.fsf@gitster.g>
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Tue, 19 Aug 2025 19:21:34 +0100
X-Gm-Features: Ac12FXwEjEffUX2KxUutX5cFBaCLuSLwJGm-dCMC6jSlV2-gJCT-T59iezyeumo
Message-ID: <CA+kUOak76QJXnWhNOmS0W4q9emOtJp7RWO42y7FCLLL4WmsDdw@mail.gmail.com>
Subject: Re: [PATCH v2] t/t1517: mark tests that fail with GIT_TEST_INSTALLED
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble+github@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 16:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
> > The changes added by 39fc408562 (t/t1517: automate `git subcmd -h` tests
> > outside a repository, 2025-08-08) to automatically loop over all "main"
> > Git commands will, when run against an installed build using
> > GIT_TEST_INSTALLED rather than the build in the build directory, include
> > some extra git-gui commands that are installed by `make install`, or
> > credential helpers that might be installed manually from the contrib
> > directories.  These fail the test, so record them as such.
> >
> > Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> > ---
> >
> > This re-roll adds a few more commands to those marked as known failures,
> > notably credential helpers I see installed in various builds for the
> > Nixpkgs packaging of Git.
> >
> >  t/t1517-outside-repo.sh | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>
> I'd appreciate these efforts, but I am not sure if this is a losing
> battle.  Your ~/libexec/git-core/ directory, when GIT_TEST_INSTALLED
> is in effect, likely has old commands that are retired, commands
> that are added by third-parties (so that their users can say "git
> frotz" and run their "frotz" software), and/or commands from the
> future that the running t1517 has not seen yet (while bisecting and
> running t1517 from an older commit, say).  For example, I have these
> differences...
>
>         archimport.perl
>                 citool
>         cvsexportcommit.perl
>         cvsimport.perl
>         cvsserver.perl
>         difftool--helper.sh
>         filter-branch.sh
>                 gui
>                 gui--askpass
>         instaweb.sh
>         last-modified
>         merge-octopus.sh
>         merge-one-file.sh
>         merge-resolve.sh
>         mergetool.sh
>         p4.py
>         quiltimport.sh
>         request-pull.sh
>         send-email.perl
>         submodule.sh
>         svn.perl
>         web--browse.sh
>
> ... in what t1517 $(git --list-cmds=main) sees between 'master' in
> normal test mode and with GIT_TEST_INSTALLED set to ~/git/jch/bin
> (i.e. the version I run for my everyday use).  "last-modified" is an
> example of a new-ish command that the t1517 test being run is not
> yet aware of but included in GIT_TEST_INSTALLED.
>
> I am wondering if we are better off skipping this test, or at least
> limiting to some known subset (e.g. "git --list-cmds=builtins") to
> skip the files on disk when GIT_TEST_INSTALLED is in effect, instead
> of "git --list-cmds=main" that is quite broad)?
>
> In any case, this is a strict improvement over the previous one, so
> I'll replace and queue this for now, but we may want to rethink the
> approach this test uses.  Even without GIT_TEST_INSTALLED, the fake
> GIT_EXEC_PATH we use during test has somewhat different from the
> real thing, I suspect.
>
> Thanks.

If someone's using GIT_TEST_INSTALLED, I think it's reasonable to
expect them to keep their install directory fairly clean, so this test
would only need to worry about things that might be there because
they're included with Git. The cases I've patched for are all ones
that are installed as part of the Nixpkgs Git build, which does copy
in some things from contrib directories, but by design always installs
into a new, empty root directory.

None of which is to disagree with everything you've said. I imagine
most people building Git aren't doing it using the Nixpkgs build
processes, so if they're using GIT_TEST_INSTALLED, they're much more
likely to be testing in an environment that includes other old scripts
or tools or whatever.

Having t1517 know what executables to check without requiring someone
to remember to update a list is clearly valuable, but it seems that
list should _somehow_ be built based on what's in the Git repository
at build time, not what's in the user's environment.
--list-cmds=builtins seems like it's more limited than ideal, but it
might be a better approach than the current one. This is a balancing
act I'll leave to people who are much more involved in the project
development!
