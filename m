Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848AA20248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfCKRya (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:54:30 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35460 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKRya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:54:30 -0400
Received: by mail-vk1-f195.google.com with SMTP id o64so927206vkd.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GE9dQaXEx93nTQZ2FGbkOvto8x40U/8jnuQNwGL7Vb0=;
        b=H1FFa5WlNoTpRSyrA4357Ngldko0Wmji/C1Ca8fesZ3yRO68jZQIOWB5M51l8Lc+gf
         qIkDNn8Fs7JQxd4HHrmwmYfPmlm/iReeebuuZQTAY94Q3Lpv/9ilStJGefI+4JJUcOLt
         Elju5QlXSrwNQuq4M50+k3vnPnhLji66wUFgAYU83tFxayFkMJ0hwdg9QDbZt30UAOsq
         cXLV2O8KBXCwRvsACJJj5DNKAxhk6vRuzGdEf3kq0FCAas7uoVJgKXXkx+GpY8TDJ4QK
         HYFXXdYcZntqxnikPSVI8YZhyFgt3D7mLGaepCvSId0GMGtoU/hKBBKFHs2O2vE+DLRH
         ZnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GE9dQaXEx93nTQZ2FGbkOvto8x40U/8jnuQNwGL7Vb0=;
        b=ryKYUldJlcfCNBrVctjA3/yVovVoTmi3uIUkq55704S2H4j7x3ooGYsSaoIJfg8Ase
         tq+ac+Z1zAwP2QR/Qrf9exEoFE8rCi0M4sqCrF+DkvDfEyb31qa8JeAYOmPPMp6oVKs6
         SylQNvCY7Epm6JPe/4kNo8hH6DrLJfwqS2dtXYfnqKw40Ol0gvaynNfuKeP1OEvfZFip
         R16fLMnYTUzVkfDEjN4JEweAy31a5D9VO9rhj/eYJNVDIchaihsFsuqsyCG2fhHyWTSz
         LXNu/V5C40o4eTEepLwlaEhJIBx8VBWrq7f2DBt5Xz09ptahLi4RUWODlvF+BYe6NXU7
         QfYg==
X-Gm-Message-State: APjAAAU6nRZ2hwFDbR/Tkzb/UJ06THmkhlXp2VeYaD3R0zobawXgIchv
        QIWFRxADAiNfq8383P6CGQ/JbXNcrJbDKFLLlew=
X-Google-Smtp-Source: APXvYqzOb7QhPZYb9/oycuxDiRtw+hSl7UkrhI8044vJm1A95xOoV0epP3n7/ehUCfAbktoavPk0MJmiblEEFNidoO4=
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr16864591vkq.92.1552326868141;
 Mon, 11 Mar 2019 10:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
In-Reply-To: <20190308095752.8574-11-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 10:54:16 -0700
Message-ID: <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few other comments that I thought of while responding elsewhere in
the thread that didn't make sense to include elsewhere...

On Fri, Mar 8, 2019 at 2:00 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> "git checkout" doing too many things is a source of confusion for many
> users (and it even bites old timers sometimes). To remedy that, the
> command will be split into two new ones: switch and
> something-to-checkout-paths. The good old "git checkout" command is

s/something-to-checkout-paths/restore/ ?

> +-g::
> +--guess::
> +       If `<branch>` is not found but there does exist a tracking
> +       branch in exactly one remote (call it `<remote>`) with a
> +       matching name, treat as equivalent to
> ++
> +------------
> +$ git switch -c <branch> --track <remote>/<branch>
> +------------

I'm not sure if it'd be better or worse to simplify this to
   git switch --track <remote>/<branch>
Thoughts?

> ++
> +If the branch exists in multiple remotes and one of them is named by
> +the `checkout.defaultRemote` configuration variable, we'll use that
> +one for the purposes of disambiguation, even if the `<branch>` isn't
> +unique across all remotes. Set it to e.g. `checkout.defaultRemote=3Dorig=
in`
> +to always checkout remote branches from there if `<branch>` is
> +ambiguous but exists on the 'origin' remote. See also
> +`checkout.defaultRemote` in linkgit:git-config[1].
> +
> +-q::
> +--quiet::
> +       Quiet, suppress feedback messages.

--quiet and --progress should be adjacent in the man-page since they
are touching upon the same concept.  It'd be nice if we had a way to
group similar items like this besides simply putting them together,
but we can at least do that.

> +
> +-f::
> +--force::
> +       Proceed even if the index or the working tree differs from
> +       HEAD. Both the index and working tree are restored to match
> +       the switching target. This is used to throw away local
> +       changes.

--force (or --discard-changes as mentioned elsewhere in this thread),
-m/--merge, and --conflict are also similar options and should be
adjacent in the man-page; they all reflect on how to handle switching
when local changes affect the same paths that different between HEAD
and the other branch.

> +--progress::
> +--no-progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless `--quiet`
> +       is specified. This flag enables progress reporting even if not
> +       attached to a terminal, regardless of `--quiet`.

This again makes me curious what --quiet actually supresses; in the
case of branch switching, are there any non-warning informational
messages other than progress reports that are printed?  If not, the
extra sentence at the end of the description for --progress can (and
probably should) be stripped.

> +
> +-t::
> +--track::
> +       When creating a new branch, set up "upstream" configuration.
> +       `-c` is implied. See "--track" in linkgit:git-branch[1] for
> +       details.
> ++
> +If no `-c` option is given, the name of the new branch will be derived
> +from the remote-tracking branch, by looking at the local part of the
> +refspec configured for the corresponding remote, and then stripping
> +the initial part up to the "*".  This would tell us to use "hack" as
> +the local branch when branching off of "origin/hack" (or
> +"remotes/origin/hack", or even "refs/remotes/origin/hack").  If the
> +given name has no slash, or the above guessing results in an empty
> +name, the guessing is aborted.  You can explicitly give a name with
> +`-c` in such a case.

Slightly disappointed that we couldn't remove --track; it has always
seemed a bit complicated.  But I don't see how to do so, since people
do want upstream branches to be tracked with their new branches.

> +
> +--no-track::
> +       Do not set up "upstream" configuration, even if the
> +       branch.autoSetupMerge configuration variable is true.
> +
> +-m::
> +--merge::
> +       If you have local modifications to one or more files that are
> +       different between the current branch and the branch to which
> +       you are switching, the command refuses to switch branches in
> +       order to preserve your modifications in context.  However,
> +       with this option, a three-way merge between the current
> +       branch, your working tree contents, and the new branch is
> +       done, and you will be on the new branch.
> ++
> +When a merge conflict happens, the index entries for conflicting
> +paths are left unmerged, and you need to resolve the conflicts
> +and mark the resolved paths with `git add` (or `git rm` if the merge
> +should result in deletion of the path).

Now that Phillip highlighted issues with -m and -f, it's hard not to
wonder about other corner cases.  For example, what if the user made
some changes, staged them, then made more changes, then tried to 'git
checkout -m <other branch>'?  That's no longer a three-way merge, but
four way.  How does that work?  Does it just rely on merge-recursive's
(poorly defined) choice of when to bail out and when to permit such
craziness?

> +--conflict=3D<style>::
> +       The same as --merge option above, but changes the way the
> +       conflicting hunks are presented, overriding the
> +       merge.conflictStyle configuration variable.  Possible values are
> +       "merge" (default) and "diff3" (in addition to what is shown by
> +       "merge" style, shows the original contents).
> +
> +--orphan <new-branch>::
> +       Create a new 'orphan' branch, named `<new-branch>`, started from
> +       `<start-point>` and switch to it. See explanation of the same
> +       option in linkgit:git-checkout[1] for details.

Sigh...does this mean --orphan will remain broken?  It has always
driven me crazy that it leaves you with a fully populated rather than
an empty index.  It seemed broken to me before I figured out the
special usecase, though it still seemed like the wrong default (an
empty index wouldn't surprise due to the "orphan" name, but a full one
does to those without the special usecase in mind).  Oh well, that's a
much smaller battle than the big picture of getting switch and restore
in place, and I don't want to derail the bigger picture; anything
using --orphan is a somewhat special case anyway.

> +You can give the `-m` flag to the command, which would try a three-way
> +merge:
> +
> +------------
> +$ git switch -m mytopic
> +Auto-merging frotz
> +------------
> +
> +After this three-way merge, the local modifications are _not_
> +registered in your index file, so `git diff` would show you what
> +changes you made since the tip of the new branch.

...even if the local modifications were registered in the index file
before?  Is this why Phillip's "x" was missing and how it avoided
doing a four-way merge?  I guess it kinda makes sense, view from this
angle, but I'm not so sure I like it.  Hmm....
