Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634CC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 20:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8314611AD
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 20:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbhKIUjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 15:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbhKIUjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 15:39:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E89C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 12:36:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so696401plk.10
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 12:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bO6piobjAH3WtP9imtZZhsisd+sKXELFas5dIAd3dKI=;
        b=IEsMabSa9ZqJHTXKEpk6ESIw7d5puo13wUgerYGaIaC8PczfhbwNVlh3wiS6/olImm
         aMCW8RS403Aj+FZM5NCYpc4byI6sJ54di85R6643pv/GVJTCrt15iEQV9HDy7W+pXdEa
         tNL1XtA2YpDD8s5JqAQLa8OfBFpf9UtHR48LySRhbYNElnPB1p2epGz+eQIK+YcEx0xo
         LKCVcIVcVXFcHt5VhL1drj/aYNbiTHGbIfWEioxNepHWnRj7scsb3/6dT2fTSMUoZ4NN
         y0MwWcrTwQYt6eR6x61hiBUjRoXKJnlnn0atiwoeHjqGdg/4HjewBOiz4vvWAJEquavI
         Xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bO6piobjAH3WtP9imtZZhsisd+sKXELFas5dIAd3dKI=;
        b=ythjG8QfNsnUhHMaeR1ph/0UncN8XwsdpTzCbeWF6PF0qyBxBy6o5uFcC0Kx7cVIfL
         g1sd066br6zDHZq5U7RK7CyTkxFkuDwd4FM572zjaQNUqAkt0psS1qCB/846iSqKOloZ
         RMkvjueI0V7/rPNZGPQ78jTaSnPtYy4u6hZwUszQLiCE0An8QS4aLiOcKYJ32hfKZkdD
         FCHLOR+gfXGoFOqEd8ItsJ0zjmtMfX/BDN1gb5bxdRDCxaxQ9CeoP3VbDpwIMb1FFAAc
         pQPuRQEBuJnvtG1ffIe9U7h2Mzj9eSrK/ABcBlY5yVt12NecU7NACF+RbrBxOfRZy7hl
         Doow==
X-Gm-Message-State: AOAM530PDodTtzN8zo78d6iZx+54ssNcF1VTEb4iifcernmTOVwJKffw
        ZwOs/wM2l92hsA1cJhM90WGwXcJE7a8JjQ==
X-Google-Smtp-Source: ABdhPJy5GYZ0XVJxQBBsj7KgGavriCUnx5VqKgg90JMu0SXdY6MDaJoPl7LOKK021tui1j1XF0hFGA==
X-Received: by 2002:a17:902:7284:b0:142:728b:46a6 with SMTP id d4-20020a170902728400b00142728b46a6mr10262696pll.45.1636490216090;
        Tue, 09 Nov 2021 12:36:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c26f:39be:d0b5:a747])
        by smtp.gmail.com with ESMTPSA id m15sm3495686pjf.49.2021.11.09.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:36:55 -0800 (PST)
Date:   Tue, 9 Nov 2021 12:36:50 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Message-ID: <YYrb4oCaIXIwN/bF@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <xmqqzgqjxl4e.fsf@gitster.g>
 <211105.861r3vhtot.gmgdl@evledraar.gmail.com>
 <YYmw8vEyFnQpe58z@google.com>
 <211109.86v912dtfw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211109.86v912dtfw.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 01:42:03AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Mon, Nov 08 2021, Emily Shaffer wrote:
> 
> > On Fri, Nov 05, 2021 at 09:43:56AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> 
> >> On Thu, Nov 04 2021, Junio C Hamano wrote:
> >> 
> >> > Emily Shaffer <emilyshaffer@google.com> writes:
> >> >
> >> >> A recorded hint path to the superproject's gitdir might be added during
> >> >> 'git submodule add', but in some cases - like submodules which were
> >> >> created before 'git submodule add' learned to record that info - it might
> >> >> be useful to update the hint. Let's do it during 'git submodule
> >> >> update', when we already have a handle to the superproject while calling
> >> >> operations on the submodules.
> >> >
> >> > We are hearing repeated mention of "cache" and "hint".  Do we ever
> >> > invalidate it, or if we have such a record, do we blindly trust it
> >> > and use it without verifying if it is still fresh?
> >> >
> >> > Also, this step and the previous step both say we record gitdir on
> >> > their title, but we instead record common dir.  Whichever is the
> >> > right choice to record, let's be consistent.
> >> 
> >> I had similar (AFAICT still unaddressed) feedback on the v2[1]. I'd lost
> >> track of this series, and see one reason is that the In-Reply-Chain was
> >> broken between v3..v4.
> >> 
> >> I.e. it seems to me that this whole thing started as a way to avoid
> >> shellscript overhead by calling git-rev-parse from git-submodule.sh, but
> >> now that the relevant bits are moved to C we could just call some
> >> slightly adjusted code in setup.c.
> >
> > No, that is not the case. It is the case that `git -C .. rev-parse
> > --git-dir` is *very* expensive in the case where `../` is not, in fact,
> > a gitdir; when I attempted another series which relied on finding the
> > parent superproject's gitdir in this way, our testsuite took something
> > like 5x longer to run than before. In other words, the expensive part is
> > not the shelling out overhead - the expensive part is searching up the
> > entire filesystem directory structure in the worst-case ("we are not a
> > submodule") scenario. This is still needed, even with 'git-submodule.sh'
> > moving to C.
> 
> Do you have that test code somewhere?

I messed around with it a little more, rebasing the no-caches-involved
older implementation and using an in-process lookup with
setup_git_directory_gently_1.
https://github.com/nasamuffin/git/tree/config-inheritance-no-cache

The recent experiments are in the tip commit, and the original series is
in the two commits prior if you're interested.

The upshot, though, is that I think there is still not a way around a
second subprocess. Before, we determined the superproject's gitdir like
so:

  # Does a git project at .. think I belong to it?
  git -C .. ls-files <args> -- path/to/submodule
  # Where does that git project's gitdir live?
  git -C .. rev-parse --absolute-git-dir

Even if we can do the second call in-process, we still will be
performing this ls-files call to ensure that the parent repo is actually
our superproject. (One good example of a time when the parent repo is
*not*: the entire Git test suite, where '/path/to/git/t/trash directory.t1234-abcd'
is not a submodule of '/path/to/git/.git'.)

We could reverse the checks, which will make this much less painful in
the real world, but will still slow down our test suites (and hopefully
you'll forgive me for combining C and bash so brazenly, but it's for
illustration purposes only):

  # Is there a git project above us?
  setup_git_directory_gently_1("..", out, 0);
  # Does it think we're its submodule?
  git -C $out rev-parse --absolute-git-dir

That will still result in an extra out-of-process call for every line in
the Git test suite, though, because of the trash directory layout.

I looked briefly at `git ls-files` // `cmd_ls_files()` and it's fairly
close to being callable on an arbitrary 'struct repository', but not
quite there. But I am pretty afraid of the rabbit hole ;)


And anyway, even with those possible changes, it turns out that
`setup_git_directory_gently_1` - which I had to munge a bit to make
non-private, anyway - wants to take shortcuts like looking at
getenv(GIT_DIR_ENVIRONMENT), which means it's will notice the
submodule's envvar before it will notice the path passed to it. I
actually am a little surprised that your experiment worked at all,
because of this wrinkle, but your printf lines show that it did somehow.


Taken as a whole, I'm not quite certain which is worse.

Approach "cache a pointer from the submodule":
- all the normal caching gotchas - creation, invalidation, staleness,
  etc
+ very easy lookup without need for significant refactoring
- since it's a config, if we do it wrong we're stuck supporting it
  forever anyway

Approach "do lots of in-process heuristics":
- need to refactor code areas unrelated to submodules or configs, like
  setup.c
- performance might differ based on filesystem speed
+ still pretty fast (compared to subprocess calls)
+ avoid all cache correctness issues
- still kind of based on heuristics; will someone envision a wonky way
  of organizing a submodule that breaks the heuristic?

I'll think on it more....

 - Emily

> I tried to reproduce this &
> can't. I run my tests in /home/avar/*, and just created this:
> 
>     $ find /tmp/some/ -name '.git' -type d
>     /tmp/some/dir/.git
>     /tmp/some/dir/a/b/c/d/e/f/g/i/j/k/.git
> 
> I.e. a deeply nested structure in /tmp, if you ask for the git-dir in
> /tmp/some/**/k you'll need to search several levels up.
> 
> Then with the patch below we'll instrument almost all git commands to
> optionally do that search, i.e. anything that does setup_git_directory()
> at all:
> 
>     $ GIT_TEST_SETUP=true GIT_TEST_SETUP_PRINT=true ~/g/git/git rev-parse HEAD
>     warning: from '/tmp/some/dir/a/b/c/d/e/f/g/i/j' found '/tmp/some/dir' ('/tmp/some/dir/.git')
>     <some hash here>
> 
> And as a quick test to run a few tests I tried:
> 
>     rm -rf test-results/; GIT_TEST_SETUP=true GIT_TEST_SETUP_PRINT=true prove -j8 t741*submod*.sh :: -V
> 
> Which runs quickly enough for a tight test loop, and does that work >600 times:
>     
>     $ cat test-results/*.out|grep -c warning.*from.*found
>     662
> 
> I can't get that to show me any meaningful difference, just to pick on
> one test (since it was easier to run repeatedly):
>     
>     $ hyperfine -L v true,false "GIT_TEST_SETUP={v} ./t7416-submodule-dash-url.sh --root=/dev/shm/git"
>     Benchmark #1: GIT_TEST_SETUP=true ./t7416-submodule-dash-url.sh --root=/dev/shm/git
>       Time (mean ± σ):     527.5 ms ±   7.2 ms    [User: 431.6 ms, System: 125.9 ms]
>       Range (min … max):   522.6 ms … 542.5 ms    10 runs
>      
>     Benchmark #2: GIT_TEST_SETUP=false ./t7416-submodule-dash-url.sh --root=/dev/shm/git
>       Time (mean ± σ):     526.7 ms ±  10.8 ms    [User: 421.1 ms, System: 131.6 ms]
>       Range (min … max):   518.2 ms … 546.8 ms    10 runs
>      
>     Summary
>       'GIT_TEST_SETUP=false ./t7416-submodule-dash-url.sh --root=/dev/shm/git' ran
>         1.00 ± 0.02 times faster than 'GIT_TEST_SETUP=true ./t7416-submodule-dash-url.sh --root=/dev/shm/git'
> 
> I.e. it's all fuzzy and within the error margins.
> 
> Now if we do e.g.:
> 
>     GIT_TEST_SETUP=false strace -f -c -U calls,name,time -S calls ./t7416-submodule-dash-url.sh 2>&1 >/dev/null | grep -A9000 calls >a
>     GIT_TEST_SETUP=true strace -f -c -U calls,name,time -S calls ./t7416-submodule-dash-url.sh 2>&1 >/dev/null | grep -A9000 calls >b
> 
> We'll see the syscall difference, in summary:
> 
>     -   110086 total            100.00
>     +   114765 total            100.00
> 
> And some of the real big differences are:
>     
>     $ diff -u <(head -n 12 a) <(head -n 12 b)
>     --- /dev/fd/63  2021-11-09 01:57:16.023991556 +0100
>     +++ /dev/fd/62  2021-11-09 01:57:16.019991593 +0100
>     @@ -1,12 +1,12 @@
>          calls syscall          % time
>      --------- ---------------- ------
>     -    11504 openat             2.15
>     -    11496 close              2.07
>     -    10672 read               4.15
>     -    10465 rt_sigaction       0.32
>     -     9913 lstat              1.50
>     -     9456 mmap               0.67
>     -     7545 stat               0.81
>     -     6349 fstat              0.62
>     -     3896 access             0.61
>     -     3490 mprotect           0.26
>     +    11783 lstat              1.80
>     +    11600 close              1.89
>     +    11599 openat             2.19
>     +    10887 read               4.36
>     +    10465 rt_sigaction       0.33
>     +     9742 stat               1.07
>     +     9455 mmap               0.75
>     +     6346 fstat              0.57
>     +     4113 access             0.65
>     +     3490 mprotect           0.28
> 
> But syscalls are fast, so it doesn't show up in real results.
> 
> Now, of course a real implementation could be less stupid, e.g. even if
> we think we need *a cache* if these are the performance numbers why do
> we need to risk the cache being incorrect v.s. say just writing "I am a
> submodule" somewhere in the config (if we don't have that).
> 
> Then we'll only do that work for submodules, so not all git invocations
> will pay the cost (and it this point we'll usually have read config
> anyway).
> 
> But I really just don't think it's that expensive at all. I can see how
> it would be for actually shelling out, but we don't need to do that.
> 
> This could also just be that I'm running this on a really fast FS, which
> is true. So I went and tested on an AIX machine I have access to.
> 
> I/O on AIX is slow, *really slow*, so slow that if you "rm -rfv"
> something you'll have time to read individual lines scrolling by.
> 
> That ~500ms t7416-submodule-dash-url.sh test runs in around 50s on that
> AIX box (power-aix.osuosl.org), most of which is I/O overhead, I created
> the same /tmp/ directory structure and tried with
> GIT_TEST_SETUP=[false|true] and it's ~55s with/without the env variable,
> with no clear winner.
> 
> I don't have access to hyperfine on that box, or the patience to wait
> for AIX I/O to wait for meaningful results, but to a first approximation
> that seems to indicate that it doesn't really matter there either.
> 
> diff --git a/setup.c b/setup.c
> index 347d7181ae9..8453d397676 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1209,6 +1209,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>         struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
>         const char *prefix = NULL;
>         struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +       const char *str = "/tmp/some/dir/a/b/c/d/e/f/g/i/j";
> +       struct strbuf a = STRBUF_INIT, b = STRBUF_INIT;
>  
>         /*
>          * We may have read an incomplete configuration before
> @@ -1231,6 +1233,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                 die_errno(_("Unable to read current working directory"));
>         strbuf_addbuf(&dir, &cwd);
>  
> +       if (git_env_bool("GIT_TEST_SETUP", 0)) {
> +               strbuf_addstr(&a, str);
> +               setup_git_directory_gently_1(&a, &b, 0);
> +
> +               if (strcmp(a.buf, str) && git_env_bool("GIT_TEST_SETUP_PRINT", 0))
> +                       warning("from '%s' found '%s' ('%s/%s')", str, a.buf, a.buf, b.buf);
> +       }
> +
>         switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
>         case GIT_DIR_EXPLICIT:
>                 prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
> 
