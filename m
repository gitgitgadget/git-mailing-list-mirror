Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594A8C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349973AbiEDNGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiEDNGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 09:06:43 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF7366AE
        for <git@vger.kernel.org>; Wed,  4 May 2022 06:03:06 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id a127so1136869vsa.3
        for <git@vger.kernel.org>; Wed, 04 May 2022 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m9A8wU/0whDEzEoU9iW/mEsyFgC+Fi848X14e/iVWaA=;
        b=KsGkQely24q64Z5zmAm+x2gKGUp8UhLEJpo5vZOUxVDRforrkZFBvzsEN/ZgRPKqi3
         IfQD0h+8zsLzHOjJ2bd+YQTphkJDxKMKM0MtNmI4aFXftKp3rgjUQUDN8AnTo0dbiNq+
         QRlVV0bYTWynfv1y2Ji/jP8H298jtcYXIUwXR9HGpRGq+46oJevvThFIjpV3ARkdivGh
         DdFZu/xrNZ+XX81KqFes31EBYVP14cEDTzNeNSvuMhqgL+5d3yBTjtCcN/UX7ITdJbHE
         L/K48hFyahh3tLKtbE5ZCRt1XmqM78v/9Vke8fNUgVd3xW6XZYciBvc2AWQAd5uiUz53
         mhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m9A8wU/0whDEzEoU9iW/mEsyFgC+Fi848X14e/iVWaA=;
        b=zFCBwTNOInrntvsoVw1IsNirxDgZVqJaJlfwc/ZeFaAk6W+3xukUCXlJUlLO5KwPMm
         LH0XWUUFn7ag6YW0Nn0DfMdLlamwZ+vuLhXgAe/6StFd8WCQyAVf52V6BxwZ/meXShcQ
         ndqacWDBTME9AOfAoktBthRwu2Okj8NiDRZb70BXk4f+cY6T/e73eN/4Bh/bD5W8dujH
         N0xpMK2+zKiHXm91u4EhjxxJoW4tMI5cYvprtRLT9Emws2aDJku+Llis5VnV4qABSqdV
         xMDyjJXxvfQkf0igQrEOSBJF52ihu+WK3yhvUSbJX4YW87QZK8jYB8VQHv+7b+aE9WrP
         LVEw==
X-Gm-Message-State: AOAM53157zy053IKHG+2gU7uwPvbTo6S4wemE+aVY7sdb4mLhB2kz42F
        jTctvSOGEukrdt00Xy7pnZ8QNmsz2KIj81V/ufE=
X-Google-Smtp-Source: ABdhPJzvJFlwrPRGb4bsqCFzUvZ/1uMS7f1gb1K6k5hzgYPFISdCBKM9sD0VT/gCSRqBbdKPagnS1VJUL7dfBKDMhkI=
X-Received: by 2002:a67:c78d:0:b0:32d:1e85:9337 with SMTP id
 t13-20020a67c78d000000b0032d1e859337mr5997115vsk.76.1651669385428; Wed, 04
 May 2022 06:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com> <9b92b380-1da1-b76d-1eb4-469aba289694@gmail.com>
 <20220503155649.b4ehcez2ytfwyq6e@carlos-mbp.lan> <d54b7672-36ab-a2b8-1a73-7d1a444a5936@gmail.com>
In-Reply-To: <d54b7672-36ab-a2b8-1a73-7d1a444a5936@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 4 May 2022 06:02:54 -0700
Message-ID: <CAPUEsphJrD5VUp+QiDFr+rp7MiRrPQO8vO++O-ibXZ+BhC43HQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 4:15 AM Phillip Wood <phillip.wood123@gmail.com> wro=
te:
> On 03/05/2022 16:56, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > On Tue, May 03, 2022 at 03:03:59PM +0100, Phillip Wood wrote:
> >>> +
> >>> +# this prerequisite should be added to all the tests, it not only pr=
events
> >>> +# the test from failing but also warms up any authentication cache s=
udo
> >>> +# might need to avoid asking for a password
> >>
> >> If this is required for all the tests then it would be simpler just to=
 skip
> >> all the tests if it is not satisfied as you do above.
> >
> > it is obviously not required (as shown by some tests in patch 3 not hav=
ing
> > it and by my choice if the word "should"),
>
> I'm afraid it is not obvious to me. As far as I can see the only test
> that does not have this prerequisite is 'cannot access if owned by root'
> added in patch 3. That test needs a setup test to run first which
> requires sudo so there is no point running it if this prerequisite is
> not satisfied.

We are in violent agreement here, but again (and don't take it wrong,
since it is most likely my fault for not being clear enough in my
request), the issue is I can't figure out how to make it obvious to
you since just the use of the world "should" made it obvious to me.

Do you have any suggestion I could include in a v4 reroll?, which will
be also sent as an RFC, so hopefully this time, we get at least
agreement in patches 1 and 2, so we could move forward and unblock the
development pipeline.

> > but it still recommended, which
> > I was hoping would be explained by that comment since if sudo to root i=
s
> > only allowed "temporarily" by someone typing their password, then sudo =
keeps
> > that authentication in a cache, that could probably expire otherwise.
> >
> > Ironically, this comment was meant to explain why it was not checked on=
ce
> > at the beginning and being used instead in almost every test, but presu=
me
> > I wasn't clear enough, not sure if worth rerolling either.
>
> That was not clear to me. Prerequisites are evaluated once and the
> result is cached.

This is indeed a bug, my intention was that it will be called in every
request so I need to at least make it "not lazy"

> Making it lazy just means it is evaluated when it is
> first required rather than when it is defined. You're right that we want
> to avoid sudo hanging because it is waiting for a password. We should
> define something like
>
> sudo () {
>         command sudo -n "$@"
> }

This gets us half way to what is needed.  Indeed I explicitly use sudo
-n in the "prerequisite" for this reason, and originally I used a perl
function that called sudo with a timeout and then killed it after a
fixed time.

The problem is we ALSO don't want the tests to fail if sudo suddenly
decides to ask for a password, so by design I wanted to detect that
issue in the prerequisite and disable the test instead, which I
obviously didn't get right.

> >> Running "sudo env" shows that it sets $HOME to /root which means that =
these
> >> tests will pick up /root/.gitconfig if it exists.
> >
> > I think this depends on how sudo is configured, but yes ANY environment
> > variables could be set to unsafe values that would confuse git if it as=
sumes
> > it is still running as part of the test suite.
>
> I think I'm using the default configuration for that setting (or at
> least the default configured by the linux distribution I'm using).

As Junio pointed out in the discussion, this is likely not going to
run in a lot of places because of issues like that.
Indeed in Debian 10 (and therefore most likely all our Ubuntu based
CI) the prerequisite fails probably because of the same reason it
fails in your workstation.

sudo is configured to do '-H' by default (which we can't disable
unless we change the configuration AFAIK) and also doesn't run with
'-s' which means that even the following shows an error

  sudo command -v git

my hope was that it will at least run in the macOS part of the CI
which is better than nothing, or alternatively we could define an
alias as you suggested and force -s on it.

The problem of doing that though, is that then sudo might run the
wrong shell, which is also part of the reason why I was forcing it by
calling the script explicitly through the shell we want to use
instead.

> > My approach was to make sure (with the prerequisite) that at least we h=
ave
> > PATH set to the right value, so we won't start accidentally running the
> > system provided git, but you are correct that at least for patch1, the =
only
> > thing I can WARRANT to work is `git status`, but it should be also clea=
r
> > to whoever writes tests using sudo, that it can't be otherwise since gi=
t it
> > is not only running as root, but it is running in the environment that =
sudo
> > provides when doing so.
> >
> >> Normally when running the
> >> tests we set $HOME to $TEST_DIRECTORY so they are run in a predictable
> >> environment. At least anything pointed to by core.hooksPath or
> >> core.fsmontior in that file is expecting to be run as root.
> >
> > which should be the same expectation of anyone running `sudo make insta=
ll`
> > in their own repository, so we are just mimicking the use case we care
> > about.
>
> Two of the most important promises the suite makes are that (i) tests do
> not write outside $TEST_DIRECTORY and (ii) the tests are not affected by
> the user's or system's git config files. By having $HOME point to /root
> we are clearly violating the second promise and making it much easier to
> accidentally violate the first by inadvertently writing to $HOME.

While I think I'd seen my fair set of violations of those 2 principles
before, I agree that not violating them here would be a good option,
but I also consider this as part of the "integration with the
framework" that was explicitly punted.

Patch 1 only concerns with making an accurate reproduction of the
problem that was presented as a regression, so having the wrong shell
or having root's HOME if your sudo so prefers is by design what we
should do as well, and my ONLY warranty is that I would be able to
call the `git status` command I am trying to test by making sure that
at least sudo will (mostly) respect the PATH the test suite provides,
and which is also why I would rather have the prerequisite fail than
to make it work where it does not by default create a shell.

FWIW I don't think even that is perfect because a sufficiently evil
sudo configuration could force git to call a different status builtin,
but I thought calling the builtin directly by using git-status was
probably too much and also likely to fail in places where that binary
doesn't get created.

Patch 3 got what would be the beginnings of that "integration with the
framework", with an ugly and minimal "this is how we can inject
environment variables we care about" implementation that got of course
discarded in the RFC because it wasn't good enough and not strictly
needed.

I think your suggestion makes sense as an enhancement to patch3, but I
am not sure of how to get it done without reintroducing the
environment I got wrong already in the previous round.

> > core.hooksPath or core.fsmonitor might be relevant now, but there is no=
 way
> > for me to predict what else might be in the future,
>
> exactly, they are just examples and show why setting HOME=3Droot is a bad=
 idea

I think that the current prerequisite prevents that already by failing
to work as I described before, is the prerequisite working on your
setup and still changing HOME?

this is what I get in macOS 11:

  $ sudo 'env' | grep HOME
  HOME=3D/Users/carlo
  $ sudo -H 'env' | grep HOME
  HOME=3D/var/root

> > and then again `sudo -H`
> > will behave differently than `sudo` and there is nothing git can do to
> > prevent that, so I keep thinking $HOME is not that special eitherway.
>
> I think $HOME is important enough to worry about because the test suite
> deliberately resets to avoid reading the user's config. Whether some
> other random variable such as GIT_COMMITTER_DATE is set or not does not
> matter in the same way.

I meant not important to our concerns that it will negatively impact
running these tests, I cannot provide any warranties that the sudo
environment provided wouldn't be evil enough, for example by setting
the path where git looks for its builtins.

but then again, I think that worrying about that is a stretch.

If root in a system we are running can change the sudoers
configurations or put configurations in root's home, that system has
more things to worry about than having this test running.

> > it might be worth adding that as well as a constraint into the prerequi=
site
> > though, so if your sudo does change HOME then we skip these tests, or w=
e
> > try harder to call sudo in a way that doesn't change HOME instead.
>
> It would be better to call git via a wrapper that sets HOME correctly

I would rather make sure the prerequisite fails and all these tests
are skipped in that system.

Getting a wrapper that fixes THIS specific case won't protect against
many others

> >> I think it is
> >> worth spelling this out explicitly in the commit message (currently it=
 is a
> >> bit vague about what the implications of not having better integration=
 with
> >> the test framework are) and the top of the test file. Note that t1509
> >> sources test-lib.sh as the root user so does not have this issue.
> >
> > As explained before, there is no way to "explicitly" document all thing=
s that
> > might be relevant, and being vague was therefore by design.
>
> Being vague by design is unhelpful, just because it is difficult to list
> all the possible implications of a changes does not mean that one should
> not list the important known issues. Commit messages should be
> transparent about the known implications of the changes the commit
> introduces and whether there are likely to be other unanticipated
> implications.

fair enough, care to come with a suggestion?
again I think the "we are running things as root folks!!" is enough to
trigger a "better do not set that IKNOWWHATIAMDOING" variable on me,
but it might be my sysadmin experience talking.

> > t1509 has also a different objective AFAIK, which is to test in an envi=
ronment
> > where everything is running as root, which is not what we want to do he=
re.
>
> Indeed - I brought it up because we're reusing IKNOWWHATIAMDOING but not
> documenting that we using it in a different way.

It is not used in a different way.

IKNOWWHATIAMDOING is meant to keep developers from running potentially
dangerous stuff, that yes could mess with your system badly and which
also applies here.

BTW while trying to test this in CI, I realized it is not set there,
so might as well be changed to something different that will be and
that would ease your concerns.

> >>> +test_lazy_prereq SUDO '
> >>> +   sudo -n id -u >u &&
> >>> +   id -u root >r &&
> >>> +   test_cmp u r &&
> >>> +   command -v git >u &&
> >>> +   sudo command -v git >r &&
> >>> +   test_cmp u r
> >>> +'
> >>> +
> >>> +test_expect_success SUDO 'setup' '
> >>> +   sudo rm -rf root &&
> >>> +   mkdir -p root/r &&
> >>> +   sudo chown root root &&
> >>> +   (
> >>> +           cd root/r &&
> >>> +           git init
> >>
> >> Using git -C <directory> would eliminate a lot of the sub shells in th=
is
> >> file
> >
> > My assumption (and help me understand if it was incorrect) is that thes=
e
> > tests should document the expected use cases, so you are correct that
> > both cd and -C accomplish the same in the end, but I think that cd is w=
hat
> > users would more normally use, and by writing with it (specially since =
it
> > requires a subshell) is also more easy to spot and understand that an
> > invocation of git with -C.
> >
> > I have to admit I didn't even thought of using -C originally because of
> > that, but if you think that makes the test easier to understand and bet=
ter
> > I am sure happy to include that in a reroll.
>
> I think it's pretty common to use -C in the test suite when running git
> in a repository that is a subdirectory of $TEST_DIRECTORY.

I get that, but do you think that in this case makes the tests simpler
and more importantly more recognizable?

I'll try to use it more in the reroll, but examples where it actually
improve the tests would be useful.

Carlo
