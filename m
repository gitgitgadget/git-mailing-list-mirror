Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309B2AEFE
	for <git@vger.kernel.org>; Mon, 26 May 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249808; cv=none; b=QsiyKJOb6SO1BvFv/zIbP/IH2218ziEnn+icXka2BE8ixv8xnYAM7pLKZiYSOV6Rxzwu44RpwZfr9O3Rnj2lp6BU5U9yxWseM2z8k5gbZjRB6tRPB1xTbljJWJBb6poJ/cI8Xtec0PICJuomSi02B9KTZTzXo/R6v02H8NWlq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249808; c=relaxed/simple;
	bh=JfM6u7d3tPlHTULUiH4BLbJVOFu0VrTTVqvO84XsZo4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciLxNAI2EgW+Gs91MuNo/rsPyxqi0Vc4bWS6q0x8KeZEbRID6mu6z0SX1JFRlf1yNyM/82SsUPpIjgj0UMVGRJuiH3/mfh/hjWp5iOKQKMHhqTsxrRf4Ti49QD4apw+Rf3Xk5YPjISS8HxweF45+u/PQZiCSXBs6iFMB/Jr9Rio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLt1om/5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLt1om/5"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52d9a275c27so1290702e0c.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748249805; x=1748854605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQJU4SZnXpSS3UTBpZ+Pywtn+a0LEXPWleVBXsmF/DM=;
        b=gLt1om/5MrOgQZPonZE31es80o5cmHV8Z1mqJOuDhsfENRnq3tmFC6OKWTeoiNUVXD
         UKUdid/G924h0Hsxt09lLQsdtsdhJ5dYXBXhf7rZ37DkV6s9kFRqTnuqqfFw8EB2b793
         zvU3XhaQYKQkqScXmn4DFqRSwa/ma/4R59nvEFDQLej2Li1RA8igR1qAtAypW8bPZcRs
         mPZB0ui/nLFsGH9EAmdw/v/+oAenVpWTtiJJNg6BkNQBG1BIXA4JgLWVqMKoVBBwk2ZZ
         TV5wF2DpH4cG/h1jwNZK/BfW59PI1LfSqdybNjVQtjl/qlJ4waJ66I67cmvX7MBfk3Jv
         cPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249805; x=1748854605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQJU4SZnXpSS3UTBpZ+Pywtn+a0LEXPWleVBXsmF/DM=;
        b=ogmcvqoYWu0lYPH6Ud+pkV1ESpK2GcI2ooCNwzWXOE4g8/zbQK96AtrTGdzJtaGv37
         oIPC679llxG+7qwvC7d3qjYEHmMnN678invsiYpBKXvxsyeoHf7mOY7FwpJ4ifex4QM6
         m3UuPSn/NYNfcoumkxSDhc6CaH0pSFqp99evJHKGHVFlAR4LtB4MoVI6VxbaXG3i1zhU
         7Bd2kz3+jQ5WSUA5CQZxcQjN0TN+PDqqYR8rRflCM97kqLrSxTkGraTwujPCynJacCec
         uXydtj/uKXwyERNdn39Fv7nsxFFD5CF752FszmfjaOAKbVLrGhkTJuGznd6t2VOUS11E
         YHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVKjR3kqlmVDlIGQpSDBNmwtBp8GZlTRtpWUScvkzFo/8JR707J/sISLR4gBbI9XM1p+9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35iZVlF8Cvec6UrcFjWFBJSlv7DVixTGslkYZL90S74jWKyxX
	z+CQRPIfnEI+sDCYsFnidt0W5a+1xYGM1xbrkQi2bdpSgwJ7w/cmARWl77nY3+zLHlU4r/HcSPs
	nL8QyOvY3YwDWyrx9uqH8eU7kt5vgn99yuex+
X-Gm-Gg: ASbGnctfPy2EIAdXSdzco0ywLfKpfefhegl239ieIwhCdhPeWWkgvBxb8rYo5IDLq3X
	wDfP5LechtthM6i4uZ0zjFUUWdHjaJn0wQKA7LjbOF+gGqAa9RoEumxOrM4QU1OpvZUduUhfieT
	oBGpecEAce6pX+8L5n7X+ocK2bSedOB8Bra8acCOYzGDslGpW8387niS96j+hNA9zwkcQ=
X-Google-Smtp-Source: AGHT+IFfX7IJG7b0vu+58pD5uyE9gWVdSmxxMSq8haFD1Cr6sOBM/QqdGzHU3Wkaw3UP7w1aAlDXNX1kaHHHXCHAcO8=
X-Received: by 2002:a05:6122:54b:b0:520:98ec:b25c with SMTP id
 71dfb90a1353d-52f2c4be23cmr5222022e0c.1.1748249804385; Mon, 26 May 2025
 01:56:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 May 2025 04:56:43 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 May 2025 04:56:43 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1972.git.git.1748005233977.gitgitgadget@gmail.com>
References: <pull.1972.git.git.1748005233977.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 May 2025 04:56:43 -0400
X-Gm-Features: AX0GCFvcjHEaSwzaXX9p3W6JDJXNpQr27TkyrVdqNYH8nApHJJW-2QOIt8Or07k
Message-ID: <CAOLa=ZTZWuGnivDMTnQoyZj4vX4qb0_wt++0+Hp6yjbWbzE+2Q@mail.gmail.com>
Subject: Re: [PATCH] docs: revise MyFirstContribution codelab for clarity and usability
To: Arnav Kapoor via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000091dbce06360620a5"

--00000000000091dbce06360620a5
Content-Type: text/plain; charset="UTF-8"

"Arnav Kapoor via GitGitGadget" <gitgitgadget@gmail.com> writes:

[snip]

>  Documentation/MyFirstContribution.adoc | 125 +++++++++++++------------
>  1 file changed, 63 insertions(+), 62 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ca1d688c9ba..bd702cbfdf3 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -12,7 +12,7 @@ the Git tree, sending it for review, and making changes based on comments.
>  === Prerequisites
>
>  This tutorial assumes you're already fairly familiar with using Git to manage
> -source code.  The Git workflow steps will largely remain unexplained.
> +source code. The Git workflow steps will largely go unexplained.
>

Why do you think this is an improvement over the exiting sentence. While
the commit message touches upon the different improvements made in this
commit, it doesn't go over 'why' a particular change is actually an
improvement.

>  [[related-reading]]
>  === Related Reading
> @@ -103,8 +103,7 @@ Use + to indicate fixed-width here; couldn't get ` to work nicely with the
>  quotes around "Pony Saying 'Um, Hello'".
>  ////
>  In this tutorial, we will add a new command, +git psuh+, short for ``Pony Saying
> -`Um, Hello''' - a feature which has gone unimplemented despite a high frequency
> -of invocation during users' typical daily workflow.
> +`Um, Hello''' - a feature that has gone unimplemented despite its frequent invocation during users' typical daily workflows.
>

Similar. Plus this introduces a new non-wrapped line.

>  (We've seen some other effort in this space with the implementation of popular
>  commands such as `sl`.)
> @@ -125,8 +124,7 @@ development like so:
>  $ git checkout -b psuh origin/master
>  ----
>
> -We'll make a number of commits here in order to demonstrate how to send a topic
> -with multiple patches up for review simultaneously.
> +We'll make several commits here to demonstrate how to send a topic with multiple patches for review simultaneously.
>
>  [[code-it-up]]
>  == Code It Up!
> @@ -134,6 +132,8 @@ with multiple patches up for review simultaneously.
>  NOTE: A reference implementation can be found at
>  https://github.com/nasamuffin/git/tree/psuh.
>
> +They are implemented in C and compiled into the main git executable.
> +
>  [[add-new-command]]
>  === Adding a New Command
>
> @@ -164,7 +164,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix);
>  Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
>  `#include "gettext.h"` to use functions related to printing output text.
>
> -Go ahead and add some throwaway printf to the `cmd_psuh` function. This is a
> +Go ahead and add a throwaway `printf` statement to the `cmd_psuh` function.Go ahead and add some throwaway printf to the `cmd_psuh` function. This is a

The sentence is repeated here.

>  decent starting point as we can now add build rules and register the command.
>
>  NOTE: Your throwaway text, as well as much of the text you will be adding over
> @@ -182,7 +182,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>  ----
>
>  Let's try to build it.  Open `Makefile`, find where `builtin/pull.o` is added
> -to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way next to it in
> +to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way, placing it in
>  alphabetical order. Once you've done so, move to the top-level directory and
>  build simply with `make`. Also add the `DEVELOPER=1` variable to turn on
>  some additional warnings:
> @@ -196,10 +196,10 @@ NOTE: When you are developing the Git project, it's preferred that you use the
>  `DEVELOPER` flag; if there's some reason it doesn't work for you, you can turn
>  it off, but it's a good idea to mention the problem to the mailing list.
>
> -Great, now your new command builds happily on its own. But nobody invokes it.
> +Great, now your new command builds successfully on its own. But nobody can invoke it yet.
>  Let's change that.
>
> -The list of commands lives in `git.c`. We can register a new command by adding
> +The list of commands is in `git.c`. We can register a new command by adding
>  a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
>  with the command name, a function pointer to the command implementation, and a
>  setup option flag. For now, let's keep mimicking `push`. Find the line where
> @@ -237,8 +237,8 @@ add an entry for your new command in alphabetical order:
>  ----
>
>  Checking `git status` again should show that `git-psuh` has been removed from
> -the untracked list and `.gitignore` has been added to the modified list. Now we
> -can stage and commit:
> +the untracked list and that `.gitignore` has been added to the modified list.
> +Now we can stage and commit:
>
>  ----
>  $ git add Makefile builtin.h builtin/psuh.c git.c .gitignore
> @@ -284,7 +284,7 @@ on the reference implementation linked at the top of this document.
>  [[implementation]]
>  === Implementation
>
> -It's probably useful to do at least something besides printing out a string.
> +It's probably useful to do something more than just printing out a string.
>  Let's start by having a look at everything we get.
>
>  Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
> @@ -307,10 +307,10 @@ existing `printf()` calls in place:
>
>  ----
>
> -Build and try it. As you may expect, there's pretty much just whatever we give
> +Build and try it. As you might expect, it just shows whatever we give
>  on the command line, including the name of our command. (If `prefix` is empty
>  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
> -helpful. So what other context can we get?
> +helpful. So what other context can we obtain?
>
>  Add a line to `#include "config.h"`. Then, add the following bits to the
>  function body:
> @@ -333,7 +333,7 @@ a specific key ("user.name") and give you the value. There are a number of
>  single-key lookup functions like this one; you can see them all (and more info
>  about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
>
> -You should see that the name printed matches the one you see when you run:
> +You should see that the printed name matches the one you see when you run:
>
>  ----
>  $ git config --get user.name
> @@ -351,13 +351,13 @@ NOTE: Again, the above is for sake of brevity in this tutorial. In a real change
>  you should not use `-m` but instead use the editor to write a meaningful
>  message.
>
> -Still, it'd be nice to know what the user's working context is like. Let's see
> +Still, it would be nice to know what the user's working context is. Let's see
>  if we can print the name of the user's current branch. We can mimic the
>  `git status` implementation; the printer is located in `wt-status.c` and we can
>  see that the branch is held in a `struct wt_status`.
>
>  `wt_status_print()` gets invoked by `cmd_status()` in `builtin/commit.c`.
> -Looking at that implementation we see the status config being populated like so:
> +Looking at that implementation, we see the status config being populated as follows:
>
>  ----
>  status_init_config(&s, git_status_config);
> @@ -399,7 +399,7 @@ $ git commit -sm "psuh: print the current branch"
>
>  Now let's see if we can get some info about a specific commit.
>
> -Luckily, there are some helpers for us here. `commit.h` has a function called
> +Fortunately, there are some helpers for us here. `commit.h` has a function called
>  `lookup_commit_reference_by_name` to which we can simply provide a hardcoded
>  string; `pretty.h` has an extremely handy `pp_commit_easy()` call which doesn't
>  require a full format object to be passed.
> @@ -507,7 +507,7 @@ The most important pieces of this to note are the file header, underlined by =,
>  the NAME section, and the SYNOPSIS, which would normally contain the grammar if
>  your command took arguments. Try to use well-established manpage headers so your
>  documentation is consistent with other Git and UNIX manpages; this makes life
> -easier for your user, who can skip to the section they know contains the
> +easier for your users, who can skip to the section they know contains the
>  information they need.
>
>  NOTE: Before trying to build the docs, make sure you have the package `asciidoc`
> @@ -540,7 +540,7 @@ Go ahead and commit your new documentation change.
>  [[add-usage]]
>  === Adding Usage Text
>
> -Try and run `./bin-wrappers/git psuh -h`. Your command should crash at the end.
> +Try and run `./bin-wrappers/git psuh -h`. Your command will likely crash at the end.
>  That's because `-h` is a special case which your command should handle by
>  printing usage.
>
> @@ -584,7 +584,7 @@ specified in `options` from `argv` and the locations pointed to from `options`
>  entries will be updated. Be sure to replace your `argc` with the result from
>  `parse_options()`, or you will be confused if you try to parse `argv` later.
>
> -It's worth noting the special argument `--`. As you may be aware, many Unix
> +It's worth noting the special argument `--`: As you may be aware, many Unix
>  commands use `--` to indicate "end of named parameters" - all parameters after
>  the `--` are interpreted merely as positional arguments. (This can be handy if
>  you want to pass as a parameter something which would usually be interpreted as
> @@ -614,7 +614,7 @@ git-push                                mainporcelain           remote
>  ----
>
>  Build again. Now, when you run with `-h`, you should see your usage printed and
> -your command terminated before anything else interesting happens. Great!
> +your command should terminate before anything else interesting happens. Great!
>
>  Go ahead and commit this one, too.
>
> @@ -622,7 +622,7 @@ Go ahead and commit this one, too.
>  == Testing
>
>  It's important to test your code - even for a little toy command like this one.
> -Moreover, your patch won't be accepted into the Git tree without tests. Your
> +Moreover, your patch will not be accepted into the Git tree without tests. Your
>  tests should:
>
>  * Illustrate the current behavior of the feature
> @@ -642,7 +642,7 @@ the schema shown in the Naming Tests section of `t/README`.
>  [[write-new-test]]
>  === Writing Your Test
>
> -Since this a toy command, let's go ahead and name the test with t9999. However,
> +Since this a toy command, let's go ahead and name the test t9999. However,
>  as many of the family/subcmd combinations are full, best practice seems to be
>  to find a command close enough to the one you've added and share its naming
>  space.
> @@ -698,7 +698,7 @@ $ make
>  $ cd t/ && prove t9999-psuh-tutorial.sh
>  ----
>
> -You can run the full test suite and ensure `git-psuh` didn't break anything:
> +You can run the full test suite to ensure `git-psuh` didn't break anything:
>
>  ----
>  $ cd t/
> @@ -726,8 +726,8 @@ specific way.
>
>  Before taking a look at how to convert your commits into emailed patches,
>  let's analyze what the end result, a "patch series", looks like. Here is an
> -{patch-series}[example] of the summary view for a patch series on the web interface of
> -the {lore}[Git mailing list archive]:
> +example of the summary view for a patch series on the web interface of
> +the Git mailing list archive:
>
>  ----
>  2022-02-18 18:40 [PATCH 0/3] libify reflog John Cai via GitGitGadget
> @@ -783,7 +783,7 @@ to do, and why, in a way that's more apparent than just looking at your
>  patches.
>
>  The title of your cover letter should be something which succinctly covers the
> -purpose of your entire topic branch. It's often in the imperative mood, just
> +purpose of your entire topic branch. It is often in the imperative mood, just
>  like our commit message titles. Here is how we'll title our series:
>
>  ---
> @@ -791,7 +791,7 @@ Add the 'psuh' command
>  ---
>
>  The body of the cover letter is used to give additional context to reviewers.
> -Be sure to explain anything your patches don't make clear on their own, but
> +Be sure to explain anything your patches do not make clear on their own, but
>  remember that since the cover letter is not recorded in the commit history,
>  anything that might be useful to future readers of the repository's history
>  should also be in your commit messages.
> @@ -845,16 +845,16 @@ need to fork the Git project and upload your changes. First thing - make sure
>  you have a GitHub account.
>
>  Head to the https://github.com/git/git[GitHub mirror] and look for the Fork
> -button. Place your fork wherever you deem appropriate and create it.
> +button. Create your fork in the location you deem appropriate.
>
>  [[upload-to-fork]]
>  === Uploading to Your Own Fork
>
>  To upload your branch to your own fork, you'll need to add the new fork as a
>  remote. You can use `git remote -v` to show the remotes you have added already.
> -From your new fork's page on GitHub, you can press "Clone or download" to get
> -the URL; then you need to run the following to add, replacing your own URL and
> -remote name for the examples provided:
> +From your new fork's page on GitHub, click "Clone or download" to get
> +the URL; then you need to run the following command, replacing the example URL and
> +remote name with your own:
>
>  ----
>  $ git remote add remotename git@github.com:remotename/git.git
> @@ -902,8 +902,8 @@ https://github.com/gitgitgadget/git and open a PR either with the "New pull
>  request" button or the convenient "Compare & pull request" button that may
>  appear with the name of your newly pushed branch.
>
> -Review the PR's title and description, as they're used by GitGitGadget
> -respectively as the subject and body of the cover letter for your change. Refer
> +Review the PR's title and description, as they are used by GitGitGadget
> +as the subject and body of the cover letter for your change. Refer
>  to <<cover-letter,"The cover letter">> above for advice on how to title your
>  submission and what content to include in the description.
>
> @@ -922,8 +922,8 @@ When you're happy, submit your pull request.
>  [[run-ci-ggg]]
>  === Running CI and Getting Ready to Send
>
> -If it's your first time using GitGitGadget (which is likely, as you're using
> -this tutorial) then someone will need to give you permission to use the tool.
> +If it is your first time using GitGitGadget (which is likely, as you're using
> +this tutorial), someone will need to give you permission to use the tool.
>  As mentioned in the GitGitGadget documentation, you just need someone who
>  already uses it to comment on your PR with `/allow <username>`. GitGitGadget
>  will automatically run your PRs through the CI even without the permission given
> @@ -977,7 +977,7 @@ $ git push -f remotename psuh
>  ----
>
>  Next, go look at your pull request against GitGitGadget; you should see the CI
> -has been kicked off again. Now while the CI is running is a good time for you
> +has been kicked off again. Now while the CI is running, is a good time for you
>  to modify your description at the top of the pull request thread; it will be
>  used again as the cover letter. You should use this space to describe what
>  has changed since your previous version, so that your reviewers have some idea
> @@ -989,9 +989,9 @@ changes.
>  == Sending Patches with `git send-email`
>
>  If you don't want to use GitGitGadget, you can also use Git itself to mail your
> -patches. Some benefits of using Git this way include finer grained control of
> +patches. Some benefits of using Git this way include finer-grained control of
>  subject line (for example, being able to use the tag [RFC PATCH] in the subject)
> -and being able to send a ``dry run'' mail to yourself to ensure it all looks
> +and ability to send a ``dry run'' mail to yourself to ensure it all looks
>  good before going out to the list.
>
>  [[setup-git-send-email]]
> @@ -1040,9 +1040,9 @@ $ git format-patch --cover-letter -o psuh/ --base=auto psuh@{u}..psuh
>     which means "commits on the current branch since it forked from
>     its upstream", which is the same thing.
>
> -The command will make one patch file per commit. After you
> -run, you can go have a look at each of the patches with your favorite text
> -editor and make sure everything looks alright; however, it's not recommended to
> +The command will create one patch file per commit. After you
> +run it, you can look at each of the patches with your favorite text
> +editor and make sure everything looks right; however, it is not recommended to
>  make code fixups via the patch file. It's a better idea to make the change the
>  normal way using `git rebase -i` or by adding a new commit than by modifying a
>  patch.
> @@ -1078,13 +1078,13 @@ Make sure you retain the ``[PATCH 0/X]'' part; that's what indicates to the Git
>  community that this email is the beginning of a patch series, and many
>  reviewers filter their email for this type of flag.
>
> -You'll need to add some extra parameters when you invoke `git send-email` to add
> +You will need to add some extra parameters when you invoke `git send-email` to include
>  the cover letter.
>
>  Next you'll have to fill out the body of your cover letter. Again, see
>  <<cover-letter,above>> for what content to include.
>
> -The template created by `git format-patch --cover-letter` includes a diffstat.
> +The template created by `git format-patch --cover-letter` includes a diffstat section.
>  This gives reviewers a summary of what they're in for when reviewing your topic.
>  The one generated for `psuh` from the sample implementation looks like this:
>
> @@ -1133,7 +1133,8 @@ now, you can send it to yourself, to make sure you understand how it will look.
>  After you run the command above, you will be presented with an interactive
>  prompt for each patch that's about to go out. This gives you one last chance to
>  edit or quit sending something (but again, don't edit code this way). Once you
> -press `y` or `a` at these prompts your emails will be sent! Congratulations!
> +press `y` or `a` at these prompts, your emails will be sent!
> +Congratulations!
>
>  Awesome, now the community will drop everything and review your changes. (Just
>  kidding - be patient!)
> @@ -1270,7 +1271,7 @@ index 88f126184c..38da593a60 100644
>
>  Please give reviewers enough time to process your initial patch before
>  sending an updated version. That is, resist the temptation to send a new
> -version immediately, because others may have already started reviewing
> +version immediately, as others may have already started reviewing
>  your initial version.
>
>  While waiting for review comments, you may find mistakes in your initial
> @@ -1288,8 +1289,8 @@ reviewers as follows:
>     a reply like "I am working on a much better approach, so please
>     ignore this patch and wait for the updated version."
>
> -Now, the above is a good practice if you sent your initial patch
> -prematurely without polish.  But a better approach of course is to avoid
> +The above is a good practice if you sent your initial patch
> +prematurely without polish.  But, of course, a better approach of course is to avoid
>  sending your patch prematurely in the first place.
>
>  Please be considerate of the time needed by reviewers to examine each
> @@ -1306,9 +1307,9 @@ fewer mistakes were the only one they would need to review.
>  After a few days, you will hopefully receive a reply to your patchset with some
>  comments. Woohoo! Now you can get back to work.
>
> -It's good manners to reply to each comment, notifying the reviewer that you have
> -made the change suggested, feel the original is better, or that the comment
> -inspired you to do something a new way which is superior to both the original
> +It is good manners to reply to each comment, notifying the reviewer that you have
> +made the suggested change, feel the original is better, or that the comment
> +inspired you to do something in a new way which is superior to both the original
>  and the suggested change. This way reviewers don't need to inspect your v2 to
>  figure out whether you implemented their comment or not.
>
> @@ -1327,13 +1328,13 @@ your v2 clear enough so that it becomes unnecessary for you to give the
>  same explanation to the next person who reads it.
>
>  If you are going to push back on a comment, be polite and explain why you feel
> -your original is better; be prepared that the reviewer may still disagree with
> -you, and the rest of the community may weigh in on one side or the other. As
> -with all code reviews, it's important to keep an open mind to doing something a
> -different way than you originally planned; other reviewers have a different
> -perspective on the project than you do, and may be thinking of a valid side
> -effect which had not occurred to you. It is always okay to ask for clarification
> -if you aren't sure why a change was suggested, or what the reviewer is asking
> +your original is better; be prepared for the possibility that the reviewer may
> +still disagree with you, and that the rest of the community may weigh in on one side
> +or the other. As with all code reviews, it is important to keep an open mind to doing
> +something differently than you originally planned; other reviewers have a different
> +perspective on the project than you do and may be considering a valid side
> +effect that had not occurred to you. It is always okay to ask for clarification
> +if you are not sure why a change was suggested or what the reviewer is asking
>  you to do.
>
>  Make sure your email client has a plaintext email mode and it is turned on; the
> @@ -1343,8 +1344,8 @@ https://kernel.googlesource.com/pub/scm/git/git/+/todo/MaintNotes[Maintainer's
>  Note], which are similar to etiquette rules in most open source communities
>  surrounding bottom-posting and inline replies.
>
> -When you're making changes to your code, it is cleanest - that is, the resulting
> -commits are easiest to look at - if you use `git rebase -i` (interactive
> +When you are making changes to your code, it is cleanest - that is, the resulting
> +commits are easiest to review - if you use `git rebase -i` (interactive
>  rebase). Take a look at this
>  https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch10.html[overview]
>  from O'Reilly. The general idea is to modify each commit which requires changes;
> @@ -1369,7 +1370,7 @@ document, you can read `Documents/SubmittingPatches` for some more info about
>  the use of the various integration branches.
>
>  Back to now: your code has been lauded by the upstream reviewers. It is perfect.
> -It is ready to be accepted. You don't need to do anything else; the maintainer
> +It is ready to be accepted. You do not need to do anything else; the maintainer
>  will merge your topic branch to `next` and life is good.
>

Overall none of the changes seem to make 'improve' the status quo. It
would be nice if you could go into detail on 'why' the changes are made.
The claims made in the commit message are not really true. I don't see
how these changes make things easier for a newcomer. Mostly seems like
sentences are replaced with synonyms without actually improving
anything.

--00000000000091dbce06360620a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ac466c9b8be41454_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nMExNa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2dKQy85M2xnU21yNXJiUitwTHFsTzBlaXZKdUM5cgp1aWsxM1Rpa2Zj
RUEySk11UmpsWFUxQ0VqTUJIUzdISkNnQ2ZEYVZoWlJWeWRhM1Rjank3aStxMnR0U1l2dXNTCno4
M2FyZkxnR1ZLYXFmeG5WMlBVcEJaVXZ4OHNxZFF5NC9BWmJIMEMrOWJBTCtsZVpyTkF2aXRpY0Zp
QkYxSm0KdzcvVGQzczdqZm15dzNSRU9GR2RYUktrYkZxVk9qYVk1dnV3dngxT0lmVndNeGNUNEds
dFVnRk5obWFBOTNuTwpLQ3NNWXJ1YnlXLzdRdnJMbUpsaGt2N1IveVVRS3JKN1hoKzRjWEdkR3JX
RlVTRkRiRFVWODkwVyttbWk1NksyCk5YT2tFZnE3NkZhYUlUNnA1NkNFZ2x2a1VDcHF0TE96SnlL
SzdBSmREYnZxTDZqN3puU2VHT3IyRTlNaXp0SkQKS2VBcWRxZVVqcUtKeEpTSVdraExqUjRTZFBk
ZlQrM2hnZ09paW9ZUVdFUFZOb1RKYjdxY2tNUFBBblZEazhqeApaUDY4NjUvekhrWm9MdE9sbHJQ
WkYwWTR2MzhEZkZPYllBd2NxVEt6bWlRZHFCbXEvd0l0c3BjNVR2RHIxbktKCkRNdkNrUTVvWW1q
TkNoZFNnRmZYOTNSdjhEbGNmbHJNNllZdmpRZz0KPThKV1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000091dbce06360620a5--
