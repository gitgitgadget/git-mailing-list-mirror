Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4CC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjFBTTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjFBTTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:19:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AA1B8
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:19:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so3304946e87.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1685733553; x=1688325553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFmtxcrNCLR5q5hFWzib7MCmxFZKQTulC6tggPC1YZs=;
        b=S9dfRYl/tP1buBfo8WTVfQ+lGwqyPdwi9oPVG8utmw3Bimi6WXdA8/sxMM0sZIw7qj
         M6LXnryUe7EUZNhhKQvfCgc3ax4XpqJHue4LmTO5P/DDuMbQp1JCEGPMYzbViqwZ9HvB
         hyMUZ7txoLinlsiipgVOKVCY4vytuognYdztQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685733553; x=1688325553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFmtxcrNCLR5q5hFWzib7MCmxFZKQTulC6tggPC1YZs=;
        b=d0mFU24cxYeuzhg8SO4SHlBn1yB6B8GBgh3oKloMVrbs+UzjcImmt9UEYdwPpw7fyU
         Kuv+ihx55N3TqUc5neaRae21Hn8G0ctAjCI8jmNrs47cdSfcZ8zn5+f5xAm9P8cfuJdx
         REsfUAQ8mmxDL+3FLev47RYINAZbZ7TvV5aPuQ6AFIeNA99OgIFjtpwwrtQ4KfOW8sRB
         1YcRN9/hm3v87CT6zT0HNhKdb6mJhzwrxGNEJ2M8Hk5oU9H1Ma351mxk8DieY8gUDWe1
         lYkGv4vz7IHA26Lvau5NyjDJI3xFieTR1YJXUi5VRJeaVyzo1siForZdBpscw38eYifb
         zHdw==
X-Gm-Message-State: AC+VfDykOsDV5D3XfQpB/neczChR/eZAe//JPuXHYVcfW0Hpwv3ueb91
        WGGahtVxvTW9teWpUWN5YyQFbLAzkiCsHqXj1QgOJB28Uv1n20Akd+w=
X-Google-Smtp-Source: ACHHUZ7/bFbmrYC+0MUkILEiHbaoCku7ITLFyAukRN9DAnEYUTpgtwFGOuljAhc2mLaMS3IYf4+Nt4RCx2J63RhLgpc=
X-Received: by 2002:a2e:87da:0:b0:2af:2871:9a66 with SMTP id
 v26-20020a2e87da000000b002af28719a66mr594799ljj.39.1685733552776; Fri, 02 Jun
 2023 12:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohHo2co7n_NjD9XntBs3DVU91Rqx8dmRrSWg=1eof+Rhw@mail.gmail.com>
 <CAPig+cQ6tuh1nGG+t6c2O8VL-=Ggy+hWzJHTFWCb7xRH2HZkXg@mail.gmail.com>
In-Reply-To: <CAPig+cQ6tuh1nGG+t6c2O8VL-=Ggy+hWzJHTFWCb7xRH2HZkXg@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 2 Jun 2023 21:19:02 +0200
Message-ID: <CAPMMpoikxfpcoN1T7A6FD76MSAvBqjJNsc55-mJc2ubM7gUAYw@mail.gmail.com>
Subject: Re: When someone creates a new worktree by copying an existing one
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2023 at 9:48=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Wed, May 31, 2023 at 3:00=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote=
:
> >
>
>
> Aside from the corruption you describe above, there may be other types
> of corruption worth detecting early, but any such detection may be
> prohibitively expensive, even if it's just the type you mentioned. (By
> "prohibitively", I'm referring to previous work to reduce the startup
> time of Git commands; people may not want to see those gains reversed,
> especially for a case such as this which is likely to be rare.)

Will keep that in mind, thx.

>
> Unless I'm mistaken, the described corruption can only be detected by
> a Git command running within the duplicate directory itself since
> there will be no entry in .git/worktrees/ corresponding to the
> manually-created copy. Hence, Git commands run in any other worktree
> will be unable to detect it, not even the "git worktree" command.
>

That matches my understanding.

> I was going to mention that suggesting to the user merely to use "git
> worktree repair" would not help in this situation, but I see in your
> followup email that you instruct the user to first delete one of the
> worktrees before running "git worktree repair", which would indeed
> work. However, you probably want the instructions to be clearer,
> saying that the user should delete the worktree directory manually
> (say, with "rm -rf"), _not_ with "git worktree remove".
>

Makes sense, thanks for the tip!

> It wouldn't help with early-detection, but it might be worthwhile to
> add a "git worktree validate" command which detects and reports
> problems with worktree administrative data (i.e. call
> worktree.c:validate_worktree() for each worktree). However, the above
> caveat still applies about inability to detect the problem from other
> worktrees.
>

Yep, that might be interesting, but wouldn't obviously address the
case I'm most interested in.

My objective is to tell the user "you've done something wrong, and are
now in a problem state" as soon as they start operating in their
newly-copied worktree.

> Upgrading "git worktree repair" to report the problem might be
> worthwhile, but it also is subject to the same caveat about inability
> to detect the problem from other worktrees.
>

Yeah, I would have appreciated a "git worktree repair -n" option when
I was writing the hook scripts, to avoid having to "bash" my way
around the .git and gitdir references.

To your point, my hook script could do a much better job than it
currently does: instead of saying "there's *something* wrong", it
could actually check whether the "wrong" original worktree gitdir path
stored in the repo actually corresponds to a real path,. and thereby
differentiate between "run git worktree repair to fix things" and
"delete this unholy worktree you have created with rm -rf".

> One might suggest that "git worktree repair" should somehow repair the
> situation itself, perhaps by creating a new entry in .git/worktrees/,
> but it's not at all clear if that is a good idea. Any such automated
> solution would need to be very careful not to throw away the user's
> work (for instance, work which is staged in the "index").
>

Yeah, I agree that could end up weird. Imagine:
* The user creates a copy (B) of the original worktree (A)
* Initially, the index, HEAD etc is all correct for both worktrees -
they are identical
* The user keeps working in the original worktree, A, staging stuff,
committing stuff, switching branches - git has no way of warning of
anything wrong. There *is* nothing wrong with the git repo.
* The user changes directory to the "bad" worktree, "B".
* Now git can warn that there is something wrong, and offer "repair by
creating a new worktree from the shared state?"... but the resulting
worktree would still be a complete mess, with a large set of
unexplained unexplainable unstaged changes, some of which might have
originally been real unstaged changes at the time of the copy.

As far as I can tell, the only "right" thing is to tell the user to
delete the duplicate-and-mistargeted worktree. As long as the warning
from git comes early enough, the user is unlikely to have managed to
do any work in that folder before they find out it's unusable.

> It may be possible to add some option or subcommand to "git worktree"
> which would allow a user to "attach" an existing directory as a
> worktree. For instance:
>
>     % cp -R worktreeA worktreeB
>     % git worktree attach worktreeB
>
> would create the necessary administrative entries in
> .git/worktrees/worktreeB/ and make worktreeB/.git point at
> .git/worktrees/worktreeB. However, I'm extremely reluctant to suggest
> doing this since we don't want to encourage users to perform worktree
> manipulation manually; they should be using "git worktree" for all
> such tasks. (We also don't want users hijacking a worktree which
> belongs to some other repository.)

Agreed - my main concern with even attempting to offer this is that
the user who does this by accident is ill-equipped to let git know
what the correct HEAD for that directory is!

Thanks again for the feedback.

I'll add this to my list of "things to see if one day I could help
with", but likely won't get to it.
