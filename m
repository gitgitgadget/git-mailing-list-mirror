Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8ADC433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 22:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiCLWp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCLWp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 17:45:57 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610559A6E
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 14:44:50 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 195so14235254iou.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:from:to:cc:subject:date:message-id:mime-version;
        bh=mJG7lLcpFAte06qGK1VgYi0YD2cH/2GWJ279sWMwKlM=;
        b=d/sVjv6ed4L9a/Gw9VAnwCV6977W7dndcnQ9C1JXJFvlRRhD7l01Z0UNF3DH3gIT/6
         0v+IJGpKjg98LXCuhzATU9dMI+R9njZAurO+MWXaC9aDiTqnO8exGF1TjtwkYbmIQA1V
         25lYz/U/Q+oxCm5OTWuCU8acQjx6sSeF9aCJ9qV5P3Psx9ACCPyQ72XhyKkzyYn/bS7s
         xQsfIMhAys+iMlPeIpWUEPSuFgUS7YtP6JgzLqBEq8+Y98pSsmkJCde0uQyCluSF1BMd
         7tAN6k8yf3yBxOKDk0rZllz+ydmuXo7JqXht+KEVJGw78DNV30YluMQ7NzzgIhDf381r
         Pgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
         :mime-version;
        bh=mJG7lLcpFAte06qGK1VgYi0YD2cH/2GWJ279sWMwKlM=;
        b=vQgABkadX0McgrXj9tkgY/RXVzARHSlCcbSKIMgok2ygJD5eTwbiPcFo80NO3u6mUA
         DMCyrlsUTv4Vv77Vhpy2mI5gfd4jiMNWQZpM8gUyIyP9gxLE9cjiOf6OT86SgxQh6CZk
         56QXnG7/DUv6g0mbOOJx4boX1b+Vu83qfIrv8Lqc/9TigtcAsI7tgS8G3ezgfBERkmGR
         mgn2YlzdYJ4Y4q+kurgcpOlZwIt21XmVvQbKuX7Ojd6FsS8yHEBPrNm3pUtJ03U3grg4
         q0kEeqJsrc1bIWX56tR5YzLLhxhcrcIXEQsQ2zAwqem+2qoUtYVOk/JETT3tk/VeiqXu
         dKvA==
X-Gm-Message-State: AOAM530ZKG77KRANhTX7OM7TdGEeK1x/lSt3oWTH/tzA1hq+jJxkJFMK
        OoDnpeVf5Mku1WBgGEeiqPw=
X-Google-Smtp-Source: ABdhPJw0oOg7YV5LxrJBpQUKmi26oMaewHJ/vmLNR3Udb3nE24/e8NiEnv2E71zv7TikzQSvoELCZw==
X-Received: by 2002:a05:6638:25cc:b0:30e:2084:761d with SMTP id u12-20020a05663825cc00b0030e2084761dmr14339542jat.182.1647125089517;
        Sat, 12 Mar 2022 14:44:49 -0800 (PST)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id r2-20020a92d442000000b002c62b540c85sm6512021ilm.5.2022.03.12.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 14:44:49 -0800 (PST)
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     git@vger.kernel.org
Cc:     sallred@epic.com, grmason@epic.com, sconrad@epic.com
Subject: Dealing with corporate email recycling
Date:   Sat, 12 Mar 2022 16:38:56 -0600
Message-ID: <878rtebxk0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

We are currently replaying a 15-year SVN history into Git -- with
contributions from thousands of developers -- and are faced with the
challenge of corporate email recycling, departures, re-hires, and name
changes causing identity issues.

* Background

As you know (also to validate my own knowledge/assumptions), a Git
commit stores identity as a name and an email.  The only means to
validate this information is via signing; commits are otherwise taken
at face-value.  This seems pretty core to Git's decentralized design.
So to identify who is responsible for a commit, you have only the two
name+email pairs.

The problem in a nutshell: names and emails change over time.  The
simple cases can be handled by gitmailmap, but there are more
challenging cases:

  - A commit author might have had some email <one@corp.net>, but then
    was able to 'upgrade' to <two@corp.net> after a departure.

  - It's even possible that this departure might 'boomerang' and
    return to their old job, albeit now with a different email (since
    they forfeited <two@corp.net> upon departure).

In effect, the email address (or even email+name pair) used by a given
developer is not enough to identify that developer.

This issue is exacerbated by the features of some Git forges (e.g.
GitHub, GitLab, etc.) that will map an email address to a user
account.  In the degenerate case, this would cause the forge to
attribute the commit incorrectly -- causing communication issues as
developers use the misattribution to reach out to the wrong people.

As a baseline, we know the following statements are true:

  1. A person's preferred name can change at any time.
  2. A person's preferred email can change at any time.
  3. Neither of these pieces of information are necessarily
     identifying in a given codebase.

* Current Options

Setting aside the dubious practice of email recycling, how should we
look at resolving this confusion in a sensible way?  I see three
general options that are possible today, each with their drawbacks:

  1. Do nothing.  Leave it to the developer to determine the correct
     contact information without assistance.

     This doesn't really resolve the confusion, but it is technically
     an option.

  2. Use gitmailmap(5) functionality to resolve historical emails to
     primary emails.

     Sadly this doesn't actually solve the email recycling problem.
     Since one email could be used by multiple developers, there's no
     way (that I can see) to use a single mailmap file to resolve one
     of these emails to a single person.

  3. Use and require commit signing -- using some separate system to
     keep track of who used what public key when
     (valid-before/-after).

     This is an attractive option and very much fits the 'identity'
     portion of this problem, but evidently, it's not yet supported
     by git-fast-import.  This becomes a non-starter for at least all
     our SVN history we're importing over.  Even a potential concept
     of providing personal private keys to an impersonal import
     process also seems less than appealing, but I'm open to the
     possibility that I'm being too paranoid here.

At this point, I'd like to ask the community what approaches have
already proven successful.  I have a design sketch below, but I would
not want to propose introducing a new standard if a standard already
exists.  I tend to think this is not the first time this problem has
come up.

* Bad Proposal: Using Mailmap Over-Time

In the absence of other options, this leaves us to consider another:
if the mailmap file is tracked in history, we can know who had which
email when.  Taking advantage of this fact right now is a bit
roundabout, but workable.  Using the `mailmap.blob` config and
pointing to the mailmap version as of a given commit yields behavior
that *looks* promising: we can resolve an email in a commit to the
person who had that email when the commit was made.  Mentally
extending this concept to do this automatically in git-log and
friends, however, shows that this wholesale removes the value of
mailmap: the ability to change your name as it appears in history
*after* that history is created.  More details at [1].

There are of course legitimate reasons for a developer to change their
name and desire that name to be used throughout the history.  It would
seem then that current mailmap functionality is insufficient to create
an external system that solves the problem.

* Proposal: UUIDs

To get what we want (i.e., the ability to run `git show HEAD~1`, know
that Ada wrote it, and report her current contact information), we
need some way of tracking identity over time.  A naive solution could
be to extend the mailmap format as recognized by Git:

    $ git cat-file blob HEAD~1:.mailmap
    A. U. Thor <foo@example.com> [uuid A] <ada@example.com>

    $ git cat-file blob HEAD:.mailmap
    A. U. Thor <ada@example.com> [uuid A]
    Roy G. Biv <foo@example.com> [uuid B] <roy@example.com>

Now, when I run `git show HEAD~1`, Git would determine the UUID of the
email on the commit using the mailmap version in that tree:

    $ git -c mailmap.blob=HEAD~1:.mailmap check-mailmap --uuid "<foo@example.com>"
    A

Then, we can use that UUID to resolve to the current contact information:

    $ git check-mailmap --uuid=A
    A. U. Thor <ada@example.com>

Mailmap-sensitive commands can use this logic internally -- possibly
guarded under some new config setting.

** Criticisms

Main criticisms of this proposal that I can think of off-hand:

  1. As far as I know, the mailmap format is pretty well-established.
     I don't know how additions/extensions to the format will be
     interpreted by other tools.

     This could be mitigated with a config option or even a magic
     comment in the file itself noting its format version.

  2. This also assumes that any given email can belong to at most one
     person at a time.  This is true for us, but may not be generally
     true.  I don't know if this is a new assumption for mailmap.

     I don't know of any mitigation here.

  3. The current mailmap format of 'one line per pair' potentially
     opens up the format to ambiguities when resolving an email
     address -- ambiguities that become more apparent with the
     introduction of a UUID.  For example:

         A. U. Thor <foo@example.com> [uuid A] <ada@example.com>
         Ada Thor <ada@example.com> [uuid A] <foo@example.com>

     When evaluating `git check-mailmap --uuid=A`, which line is used?
     Perhaps this is not a new problem, but it is a disconcerting one.

     This might be resolved by allowing many aliases on a single line
     and restricting UUIDs to be unique in the file.  Since the
     introduction of UUIDs would be a change to the format that by
     definition would need to be opted-into (to provide the UUIDs),
     this would not be a breaking change in and of itself.

I am additionally unsure of how the following current behavior (from
gitmailmap(5)) should play into this proposal -- mostly because I
don't understand the use-case to carve out a specific author/committer
name for the mapping:

    > [...] and:
    >
    >     Proper Name <proper@email.xx> Commit Name <commit@email.xx>
    >
    > which allows mailmap to replace both the name and the email of a
    > commit matching both the specified commit name and email
    > address.

* Proposal: Valid-Before/Valid-After

Another potential idea is to record a transition point in the mailmap
file:

    A. U. Thor <foo@example.com> <ada@example.com> valid-before=<timestamp>
    A. U. Thor <ada@example.com>

This draws on the valid-before/-after pattern used in commit signing.
While I've signed a few commits in my day, I'm admittedly not versed
on that infrastructure/implementation.  I'd be curious if this idea
would have a champion to argue for it.  I personally prefer UUIDs.

** Criticisms

There are a few things I can identify:

  1. While it's potentially good enough to solve the immediate
     problem, this doesn't actually establish a tangible identity.

  2. Parsing this as a human being could become difficult if there are
     a few transition points.

* Summary

All of this is under the assumption that there is no viable approach
out there, which I'm not convinced of.  This proposal is only a
suggestion of how it *could* be standardized with development if no
standard practice currently exists.

So, two questions remain:

  1. Is there a standard approach out there already that was not
     discussed above?  (Are there statements I made about those
     approaches that are not true?)

  2. Assuming there is no suitable standard, is the above proposal
     worth investing development time, or are there fundamental flaws?

Thanks,
Sean Allred

---

[1]: See below.  I removed this from the main body to try and control
its length.

* Failed Plan: using mailmap over-time

(I'm going to say things in the course of this example that are 'wrong'
and/or 'working as designed', so bear with me!)

Consider the following.  At some point in the past, <foo@example.com>
belonged to Ada.  She wrote the following commit:

    $ git cat-file commit HEAD~1
    ...
    author A. U. Thor <foo@example.com> ...
    committer A. U. Thor <foo@example.com> ...

    $ git cat-file blob HEAD~1:.mailmap
    A. U. Thor <foo@example.com> <ada@example.com>

Somewhere down the line, Ada has left, <foo@example.com> transferred to
Roy, and he wrote the following commit:

    $ git cat-file commit HEAD
    ...
    author Roy G. Biv <foo@example.com> ...
    committer Roy G. Biv <foo@example.com> ...

    $ git cat-file blob HEAD:.mailmap
    A. U. Thor <ada@example.com>
    Roy G. Biv <foo@example.com> <roy@example.com>

If we check the mailmap to resolve <foo@example.com> from HEAD~1, we
get the wrong answer:

    $ git show HEAD~1
    ...
    Author: Roy G. Biv <foo@example.com>
    ...

It's only when we provide the version of the mailmap file that was
active at the time do we get the right answer:

    $ git -c mailmap.blob=HEAD~1:.mailmap show HEAD~1
    ...
    Author: A. U. Thor <foo@example.com>
    ...

So, if we can instruct git-show and friends to check the mailmap
version at the time of the commit, we get what appears to be the
desired behavior.  Great, right?

Not so fast.  This loses sight of one of the main purposes of
gitmailmap.  This idea failed.

You're at the end now; thanks for reading :-)

--
Sean Allred
