Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A97C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBUWHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBUWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:07:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D4132536
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:07:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ec43so22484033edb.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G0vzu3fvxYGEVTrdq+em3p7KC0hhya2oPo7U1uYT7RE=;
        b=Bs2/XKSzTXmSjvOyXFPeBtcBGsCVZnsKQgOz6EVKlTZ5aGd28mSGKRe+eVrWYf78o7
         KaGg2v60tG+BLXjPatm73Pk9z/5RrzoKyZ10erqkbZN8X/geC6km7mVDeMbHB5h4lp5e
         +DZDclRmUDSUAhAYLBlFAz71TuddBI9gMJccNYv/CpSpE/dnl9u3cAepoJuDYvSXknJS
         kSLzWkHtTVvm049KoKy3e/N5WZJrPwLFdtvMY8tGVDX10O7vp4wyCyVcJ6J9QfZbVYZa
         CrQQ86HP4azOLTPdO75XiTKcztt9C9QVB0wI0sOjuqvmztnFxeXo3KWFyEYK3hhqJep2
         Ht6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0vzu3fvxYGEVTrdq+em3p7KC0hhya2oPo7U1uYT7RE=;
        b=eIcb3f/qTXr+HrZtAjTV9whQIVVS5mcXAsuTrzoe1eC6Aw+kYB8baV+nHgfYm4avTN
         Lv3odyNUOyqnxru0vks5288oCC6Hwy19/hCvbNArj/UvFNx3qgSOnjLdoG7enw97sT8Q
         urZP2qvOgbsMMBqQYL4fi5dIqEFMMU44LO6UIZlxt/Vbme3Vt9zcMrlC3WUWYoWrGaWf
         cXxAqfkYJe4yx1u/IxgGSl92XFqVctobdda8iQ5OHTi1HswjOCFgwrQdtcNkYgka5Daz
         8v4L7mK+Ujlj7m6BlhNM259s/9vkxHjNymoMMtZ30YloN9e1duUam+tM1+A0dF9/be1b
         lL+A==
X-Gm-Message-State: AO0yUKWQ9YdYsTzIOE8pMaT+xibdxMoUP2UXikY9NYBOIMP3cekx/LZ9
        DBZGJq1d/lSAkGBYrk0XPopzOHJh7qqZdJ6+uhx2VXMrmRFToowxBTP0uw==
X-Google-Smtp-Source: AK7set/07q3aNb8AMxdkNjdDBdxjLqrlG/Eq7FScIMrHQ6dMH4/xdIUSw/TRsvwN1h2OSpL8G1UWn8YSRKg/0Ezna0I=
X-Received: by 2002:a50:aa95:0:b0:4ab:c702:656 with SMTP id
 q21-20020a50aa95000000b004abc7020656mr2766713edc.1.1677017227348; Tue, 21 Feb
 2023 14:07:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <CABPp-BE6EA+vXLXJtn8CHO9pHJgLH_uh7_t7AYBRN2gAAA5C+Q@mail.gmail.com>
In-Reply-To: <CABPp-BE6EA+vXLXJtn8CHO9pHJgLH_uh7_t7AYBRN2gAAA5C+Q@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 21 Feb 2023 14:06:55 -0800
Message-ID: <CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 8:05 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 1:45 PM Emily Shaffer <nasamuffin@google.com> wrote:
> [...]
> > The good news is that for practical near-term purposes, "libification"
> > mostly means cleanups to the Git codebase, and continuing code health
> > work that the project has already cared about doing:
> >
> > - Removing references to global variables and instead piping them
> > through arguments
> > - Finding and fixing memory leaks, especially in widely-used low-level code
>
> Does removing memory leaks also mean converting UNLEAK to free()?

I suspect so - as I understand it, UNLEAK is a macro that resolves to
"don't complain to me, compiler, I meant not to free it."

> Thinking of things in a library context probably pushes us in that
> direction (though, alternatively, it might just highlight the question
> of what is considered "low-level" instead).

I'm not sure whether use of UNLEAK has so much to do with "low-level"
or not. In cases when Git is being called as an ephemeral single-run
process, UNLEAK makes a lot of sense. In cases when Git is being
called in a long-lived process, UNLEAK is just a sign that says
"there's a leak here".  So I think the distinction is not low-level or
high-level, but more simply, within a library or not.

I do anticipate that we'll still have "non-libified" code for the
builtins, and that those builtins will invoke libraries at whatever
layer. So UNLEAKing memory allocated by the builtin - seems fine to
me, even if that builtin is a "low-level" plumbing command.

>
> > - Reducing or removing `die()` invocations in low-level code, and
> > instead reporting errors back to callers in a consistent way
>
> What delinates "low-level" code?  (A "we don't know yet but we'll
> start with obvious places and plan to have good discussions on the
> appropriate boundary in the future as we submit patches" is a fine
> answer, I'm just curious if you already have a rough idea of where you
> intend that boundary to lie.)

The biggest one is our "standard library" - stuff like strbuf,
string-list, strvec, etc. etc. I'd like to expose those to callers so
that we don't end up having library interfaces passing around
unterminated buffers, which means that they'll be used in almost any
other library.

That sort of hints at the next criteria - stuff that's used by lots of
operations, or lots of other parts of Git code. So that means things
like run-command and config.

Past that, we're determining libification order based on internal
priorities. A request like "our VFS helper needs to do `git commit`
with this specific set of constraints, please give us library calls to
do it" would probably result in us working on library interfaces to
hook execution, index parsing, and ref manipulation, and anything
that's a dependency of those three. It's very unlikely that it would
result in something like `git_do_commit(struct git_commit_flags)`.
(That's what I meant about avoiding high-level libraries to begin
with.)

> > - Clarifying the scope and layering of existing modules, for example
> > by moving single-use helpers from the shared module's scope into the
> > single user's scope
> > - Making module interfaces more consistent and easier to understand,
> > including moving "private" functions out of headers and into source
> > files and improving in-header documentation
>
> I think these are very positive directions.  I like the fact that your
> initial plan benefits all of us, whether or not libification is
> ultimately achieved.
>
> [...]
> > So what's next? Naturally, I'm looking forward to a spirited
> > discussion about this topic - I'd like to know which concerns haven't
> > been addressed and figure out whether we can find a way around them,
> > and generally build awareness of this effort with the community.
>
> I'm curious whether clarifying scope/layering and cleaning up
> interfaces might mean you'd be interested in things like:
>   * https://github.com/newren/git/commits/header-cleanups (which was
> still WIP; I paused working on it because I figured people would see
> it as big "cleanup" patches with no practical benefit)
>   * https://github.com/gitgitgadget/git/pull/1149 (which has been
> ready to submit for a _long_ time, but I just haven't yet)
> or if these two things are orthogonal to what you have in mind.

Extremely yes. :) Even "small" stuff like the need for header cleanups
have already come up for Glen and Calvin working on config and strbuf.

>
> > I'm also planning to send a proposal for a document full of "best
> > practices" for turning Git code into libraries (and have quite a lot
> > of discussion around that document, too). My hope is that we can use
> > that document to help us during implementation as well as during
> > review, and refine it over time as we learn more about what works and
> > what doesn't. Having this kind of documentation will make it easy for
> > others to join us in moving Git's codebase towards a clean set of
> > libraries. I hope that, as a project, we can settle on some tenets
> > that we all agree would make Git nicer.
>
> I like the sound of this.
>
> > After that, we're still hoping to target low-level libraries first - I
> > certainly don't think it will make sense to ship a high-level `git
> > commit` library in the near future, if ever - in the order that
> > they're required from the VFS project we're working closely with. As
> > far as I can tell right now, that's likely to cover object store and
> > worktree access, as well as commit creation and pushing, but we'll see
> > how planning shakes out over the next month or so. But Google's
> > schedule should have no bearing on what others in the Git project feel
> > is important to clean up and libify, and if there is interest in the
> > rest of the project in converting other existing modules into
> > libraries, my team and I are excited to participate in the review.
>
> If we can't libify something like commit, does that prevent libifying
> higher level things like merge?
>
> I spent some time thinking about this a while back.  I tried to
> carefully design merge-ort to improve the odds it could be used
> elsewhere, maybe even libgit2.  (I hope it shows in the many comments
> in merge-ort.h, and I think the "priv" field in particular allowing me
> to hide the first ~300 lines of merge-ort.c declaring data structures
> from users was really nice.)  However, I still had to accept data in
> some known format.  So input parameters are things like trees and
> commits.  But tree.h and commit.h both include object.h first, which
> includes cache.h, which is basically all of Git.  And the functions I
> call to interoperate with the system are similarly entangled.  So, the
> odds of merge-ort being reused by libgit2 or otherwise used in a
> library seems essentially nil, at least without some broader
> libification effort.

Yeah, it depends a lot on the usage. For merge, it would be tricky to
get the scope just right - should the merge library be responsible for
locating the merge-base? Should it just perform the conflict
resolution? Something else?

As for "I tried to include this thing which eventually included
cache.h" - yeah, I think we will be pulling stuff out of cache.h quite
heavily. But IMO this falls under "cleanups we want to do in Git
anyway" - I think it's widely understood that cache.h is not
well-scoped and could use improvement.

>
> I'd like to make that story better, time permitting (which is much
> more of a challenge these days than it was a couple years ago), but
> I'm curious if you or others have thoughts on something like that.
>
> > Much, much later on, I'm expecting us to form a plan around allowing
> > "plugins" - that is, replacing library functionality we use today with
> > an alternative library, such as an object store relying on a
> > distributed file store like S3. Making that work well will also likely
> > involve us coming up with a solution for dependency injection, and to
> > begin using vtables for some libraries. I'm hoping that we can figure
> > out a way to do that that won't make the Git source ugly. Around this
> > time, I think it will make sense to buy into unit tests even more and
> > start using an approach like mocking to test various edge cases. And
> > at some point, it's likely that we'll want to make the interfaces to
> > various Git libraries consistent with each other, which would involve
> > some large-scale but hopefully-mechanical refactors.
>
> Would these plugins resemble the pluggable merge backends that was
> added to builtin/merge.c?  Would it replace that mechanism with a
> different one?  Would it be more like the refs backends?

I suspect that it's likely to be most similar to the refs backend
replacement, although I investigated it only a little bit just now.

The pluggable merge backends are an interesting thought - right now
all those alternatives are built in and we decide based on config,
right? But if we were able to easily decide which library to link
based on config during runtime, then I could see that being an
appealing use of plugins too. I wonder whether "custom" merge backends
make the story for people doing compiled asset storage in Git (like
game assets or hardware layouts, both of which famously merge
horribly) any easier.

>
> Would this plugin scheme allow us to, for example, use gitoxide[1] as
> a clone replacement to make clones 2x as fast (and with half the
> memory -- although I suspect they cheated and used sha1 instead of
> sha1dc, so maybe it wouldn't really be 2x)?

Interesting. It would depend on whether we can match the interface to
gitoxide, or write a translation layer. I could see it! I'm also a
little curious how much of that speedup is because of corner-cutting
(since you mentioned skipping the collision detection) vs. how much is
due to Rust magic. In theory, building the Git CLI out of a handful of
libraries means that we could write some of those libraries in
something besides C; in practice, I understand there's a
maintainability issue around introducing new languages into the pile
of stuff the community is expected to understand and maintain. (For
example, I think many people don't like to touch git-gui, probably
primarily because it's in Tcl.)

>
> Oh, and it's totally okay if you don't know the answers to any or all
> of my questions right now.  I'm just curious, because I've long
> thought these kinds of directions would be good.  Since I've spent
> time thinking about it, I have questions that I don't know the answers
> to, but I figured it couldn't hurt to bounce them off others who are
> thinking about this area.
>
> Anyway, it's a large pile of work that you're undertaking, and as
> Junio comments elsewhere in this thread it's unclear if libification
> can be achieved for a big enough component (and you seem to admit as
> much in your email as well), but I applaud the general direction and
> your initial plans.

Thanks for your thoughtful reply.

 - Emily

>
>
> [1] https://github.com/Byron/gitoxide/discussions/579
