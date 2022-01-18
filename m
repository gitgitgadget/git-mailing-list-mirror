Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB82C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350196AbiARXaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 18:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343990AbiARXaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 18:30:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F92C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 15:30:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n11so426847plf.4
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 15:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G52hFoV6ruGvCzTbPrlJfMrRo03il1MiwztQvJezzxE=;
        b=i71vDQdTR2hl0MuZJ3rFKnIoJXyCupkAw9uOzPX/kMfkzLeD+djy+9jDO9wJu+rdnS
         YTqnSpqHEA60WSLsQteIelb/LrkBeQ9kDRsMgRjjONw8rzbFz7SbPsL8BowL+ePK0Cq0
         fFx0L49CePKj5iOD1jAkzyO6T3I3Uu0hqYYuU4S5Xa7NxPphgypIfMCcfV96kmLzgKMz
         nHrxM2zD9dq7bJjXokqPX4qQqc4dApI+5VoosIJGQsZD7VflOdiA+2OlFlALeQULSd5i
         tu90FINA9N1RDIRkKea4tc2La9gNfWUak0RCvhZnxgF5EQ2klLTzZFhztzYwA+Lfjcff
         VE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G52hFoV6ruGvCzTbPrlJfMrRo03il1MiwztQvJezzxE=;
        b=AHhnoXr+E1O6SF3yoGOQeumHtr23G8dyHQmGwD7Jpo124FTrHaSF9KMas5LLAzfli2
         +u8FVzzaRwaK045qba32HpuQ5Ghc3pJt7tOUwtxC3co1rgm+U/XSDKdVXkPz804cQuOT
         gMoyzQVAu2Lu98T0kRKmV31Zlie9l2scQDJbavCE+M6b/J3R5zbuK2aUHaX7CCmfDeM0
         VdDlaKOoQT/MOMWC0dRAd/Csl+lYyR9quzZhpTzfCVHbClXndz7LKwnS0ZEtxUaFe5jg
         1j/3w7KyMJ0z1yJQVl1MbOOtzEnl0MYkJ3VK0TlE0ijbtNkEWg7SZj5WTDnbsk1NpE2H
         K8RA==
X-Gm-Message-State: AOAM5315dSxxniJ4d4bsClUyrfqsq7jJfACzNB1fWTSuoFISKWWIsegW
        QoHw86W1O9a59unFcL2bX0jDO1600E7Z7o8Pq7c=
X-Google-Smtp-Source: ABdhPJyxnzJQj4R34cU0ml2W+HCbLjYoKhWPTmR2T6i6AiofmyN23re+dl4ry0S6LTMNuIiCQOIKHNGeW+OvTxamABk=
X-Received: by 2002:a17:903:8b:b0:14a:2b58:ad7b with SMTP id
 o11-20020a170903008b00b0014a2b58ad7bmr29636520pld.163.1642548618825; Tue, 18
 Jan 2022 15:30:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com> <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev> <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <20220118222234.GB2632@szeder.dev>
In-Reply-To: <20220118222234.GB2632@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Jan 2022 15:30:05 -0800
Message-ID: <CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKuLbArXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 18, 2022 at 2:22 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sat, Jan 15, 2022 at 05:03:24PM -0800, Elijah Newren wrote:
> > On Sat, Jan 15, 2022 at 1:57 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
> > >
> > > On Mon, Jan 10, 2022 at 06:59:51PM +0000, Lessley Dennington via GitG=
itGadget wrote:
...
> > > > 4. A list of directories (but not files) is provided when users ent=
er git
> > > > sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
> > >
> > > Why limit completion only to directories?  Both of those subcommands
> > > accept files,
> >
> > Discussed in part at [1], but let me give a more detailed answer.
>
> It was a semi-rhetorical question.  Whether the reasons for expluding
> files are sound or not, it should be convincingly justified in the
> commit message.

Fair enough.

...
> I used the following command to create a sparse-checkout from
> linux.git to build and play with 'perf':
>
>   git sparse-checkout set tools/perf/ tools/scripts/ tools/build/ tools/i=
nclude/ tools/arch/x86/ tools/lib/ /.gitignore /.gitattributes
>
> Including the top-level '.gitignore' and '.gitattributes' was
> important, becase those ignore object files and specify userdiff.
> Now, I wouldn't mind having other files present in the top-level
> directory, because there are only a handful of files there.  However,
> being able to specify just those two files to 'git sparse-checkout'
> was great, because I didn't even have to think about what wildcard
> pattern to use, and what negative pattern to use to exclude anything
> that might have been included recursively.

Yeah, we should really make cone mode the default, because then this
simplifies to:

    git sparse-checkout set tools/perf/ tools/scripts/ tools/build/
tools/include/ tools/arch/x86/ tools/lib/

In cone-mode you automatically get the directories specified PLUS:

  * all files in the toplevel directory (you always get these in cone mode)
  * all files directly within a parent (or ancestor) of one of the
directories you specified (thus all files directly under tools/ and
tools/arch/).

> I don't remember having any performance issues with it, on the
> contrary, I do remember that Git suddenly became much faster that in
> the full worktree.

Cool, thanks for testing it out and reporting.

If I can be permitted to share a bit of my experience...

In this specific case, you did keep it to 8 patterns and the linux
kernel "only" has ~60k files.  So O(N*M) isn't too bad here...but
experience at $DAYJOB is that even with only 60k files, the pattern
list tends to grow and it's not clear to users why there are so many
ugly pauses when "Git used to be fast".  Users tend to not make the
connection either between the sparsity patterns and the slowness for
whatever reason, and when I'm asked questions about the slowness, I
may have to check a few other possible causes before finally realizing
that it's just "too many sparsity patterns".

At least, that's the way it was at $DAYJOB before I switched our
internal "sparsify" tool to just use cone mode.  Then that type of
problem went away.

> So I'm fairly convinced that specifying files to sparse-checkout is a
> feature that can make users' life easier.  It certainly made my life
> easier.

Or we can make it even easier and faster by using cone mode.  That
really, really should be the default (as we've been talking about for
a couple cycles now), and I think your email reinforces my belief in
it.  I've got a series ready after some other things merge down to
next.

> On a related note: I just noticed the leading slashes in '/.gitignore'
> and '/.gitattributes'.  __git_complete_index_file() is not ready for
> that, I'm afraid; but I don't think the proposed patches could deal
> with that, either (but I didn't actually try).
>
> It would be great if completion could cope with patterns starting with
> '/' and/or '!'.

Ah, very good point.  The leading '/' is kind of critical here,
otherwise you get all .gitignore files in every directory at every
depth, so completing on files (as currently done) wouldn't really help
at all in your case.


Since you brought up a new good point here, can I also mention two
others not previously covered in this thread (i.e. besides scaling)?

* If we complete file and directory names in non-cone mode, and those
file and directory names contain a leading '#' or '!' or contain
anywhere in their names a '*', '?', '\', '[', or ']', then the users
may be in for a very nasty surprise.  (Which perhaps suggests that in
non-cone mode, we shouldn't provide file OR directory completions for
set/add?)

* sparse-checkout currently ignores prefix[1], causing file and
directory completions to be wrong if the user is running from a
subdirectory.  This is just a bug in cone mode, though I'm not sure if
it's bug or feature in non-cone mode[2].  A decision about what it is
might have a bearing on what kinds of completions make sense in
non-cone mode (and might reinforce files/directories, or suggest
something else.).

[1] https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.=
com/
[2] https://lore.kernel.org/git/CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcP=
FkOAvn_A@mail.gmail.com/
