Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4293B1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfEPBqW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:22 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38202 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfEPAgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:36:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id x184so135174vsb.5
        for <git@vger.kernel.org>; Wed, 15 May 2019 17:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxKNcrD6h8UaOlBq47/Xi7MjuZGs9+1h1KLKCCGeqv4=;
        b=DrafAhCk+Qe33huDST6iS7yNtzDtdszL8kyUJtatVn6A+Po8M9eapYlK7nuWQ1Dth+
         4Q65KsjzzCl5Dbe271cXCm8Oy+auNQftnO1NDgD16aSf6Czzr1XuBMPwd5zSHbpqXThg
         zojvv71YK1ZrPc9GIKkjIp/kTgYcPxSWD4HuHCwk3JVLxQlwnWdSRMbWYFaKc9hUiebQ
         FXhrNyinsHjkamDMvZDRCrxBIOW55DG/kvt/VfPMD8+TVkvrRUSYpL0rU9hf0yMi/otG
         r/vHRaRFNPkL/8wVUislT+04z+nCfy6YetXaptrUrSkivEVGfNNw1e546xwHwc+imjf6
         1bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxKNcrD6h8UaOlBq47/Xi7MjuZGs9+1h1KLKCCGeqv4=;
        b=QdeRFaP6cikrwgkqtrytWjoQ5Ii8qwtEiA4PYAETZgcCMg0vTQgHdn4pRhtY/pQmKZ
         RZsr2ys/iHumpIqRwNO1DkXJxGKdcnkHXGFDPUVnZYj+09FyL5Clcnz/L2G32sp0iQPw
         cHdhO9xBNP8PKVVLBRQYvUSug9qCS/MjrEasa/bh+peovqmAQnowjcpiOcknsUa1aM6f
         9WrXAWfnJd6cP4aXEGh6ThWX9cI1iyCHvPPNKPWAUrQj7sANb7uVZB8H6ebd5m5cSitx
         /tzXFrbgnluKG4L50pi4p6YCzWFKSaqaHMk8TwrN+FlZ9g34HSTR5PJkgqGLmqAckdOw
         N9Dw==
X-Gm-Message-State: APjAAAVmaH0KJMuBNLB6aONX1ZleuE/2jntHJgf1HfavzOt//nqzFzDc
        M0lG90ldXD6qPW6iKUbeJJPKwOxYv3IfPLAH3cA=
X-Google-Smtp-Source: APXvYqzt/HoaGc8k6Pw3zC5gRXpr/SOIi2y/4AzeyiFDERcuqC94Or7YsVmSD3qR2MlQhmyHyVvg+wgNEfFj0HaM8n8=
X-Received: by 2002:a05:6102:388:: with SMTP id m8mr7500939vsq.53.1557966963340;
 Wed, 15 May 2019 17:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <ad63393c24c7346c5b606b29579dfacad4d307f3.1557477247.git.e@nanocritical.com>
 <xmqq8sv8709a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sv8709a.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 May 2019 17:35:52 -0700
Message-ID: <CABPp-BGZQz=4KVpZ6v+p12tDPMBJ8eFWuOH1mjQQrhpksU8NzQ@mail.gmail.com>
Subject: Re: [PATCH v3] fast-import: checkpoint: only write out refs and tags
 if we changed them
To:     Eric Rannaud <e@nanocritical.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 10:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Eric Rannaud" <e@nanocritical.com> writes:
>
> > We now keep track of whether branches and tags have been changed by this
> > fast-import process since our last checkpoint (or startup). At the next
> > checkpoint, only refs and tags that new commands have changed are
> > written to disk.
>
> And when we notice that we have been competing with some other
> process and the ref that we wanted to update has already been
> updated to a different value, what happens?  That should be part of
> the description of the new behaviour (aka "fix") written here.
>
> > ---
>
> Missing sign-off.
>
> It sounds like a worthwhile thing to do.
>
> It seems that Elijah has been active in fast-import/export area in
> the last 12 months, so let's borrow a second set of eyes from him.

I glanced over the fast-import.c portion of the code and it seemed
sane, modulo this question about handling of failure to update
branches/tags during a checkpoint.  Didn't read the testcase portion
of the patch as closely yet, but I think the big question is failures
during checkpoints.

First, I have to admit to having never used checkpoints, and I'm
struggling a little bit to understand the usecase here.

For context on my angle, I've been always using --force and 'feature
done', which ensures that either all branches and tags successfully
update, or fast-import terminates with having made no changes (other
than perhaps having written a garbage packfile that can be pruned).
I'm particularly worried about the frontend hitting errors and not
completing its output.  With that in mind, I was surprised to notice
that explicit checkpoints update branches and tags; it seemed
incompatible with --done to me, though it turns out to only be
incompatible with my intended use (no partial updates).

In your case, you are clearly interested in partial updates for some
purpose.  It's easiest to figure out the 'right' behavior for partial
updates in conjunction with --force: as you state, if someone else
updates some ref after a checkpoint and the input stream continues to
change the ref, then tough luck for the external party; we were told
to `--force` so we overwrite.  But the case without --force is most
interesting, as Junio highlighted.  I don't think that case has been
thought about deeply in the past, for two reasons: (1) the fast-import
documentation is somewhat dismissive of checkpoints ("given that a 30
GiB Subversion repository can be loaded into Git through fast-import
in about 3 hours, explicit checkpointing may not be necessary") , (2)
I think most folks assume the repository isn't going to be interacted
with during the fast-import process.  However, the whole reason for
your patch is because checkpoints are in use *and* people are updating
the repo during the fast-import process, so this area that was likely
overlooked in the past now is pretty important to get right.

Looking at the fast-import code, it appears that update_branch and
update_tag both set a global 'failure' flag whenever a branch cannot
be updated due to it not being a fast-forward.  It prints a "warning"
but this is likely because it wants to update whatever branches and
tags it can and report issues on any it can't, and then after that's
done then exit.  Since branches and tags are typically just updated at
the very end of the process (again, based on the documentation
suggesting checkpoints aren't necessary), the end of program exit can
also be thought of as the "exit immediately after failing branch/tag
updates".  My current suspicion is that the current checkpointing code
not checking the 'failure' flag was an oversight.  If the user doesn't
want branches/tags forcibly updated, and they do want checkpoints when
the branches/tags get updated as input comes in, and there is the
possibility that external folks modify thing, then I think it makes
sense to abort the import once the checkpoint is finished (i.e. update
whatever branches/tags we can and then error out); continuing to
process the input stream seems wrong, because:
  * the reason to use checkpoints is because the fast-import process
is taking a long time; if it was quick, there'd be no reason to
manually checkpoint.  Therefore...
  * the user may be forced to backup and redo the long-lived
fast-import process anyway; we've cost them time by not erroring out
immediately
  * we allow errors to accumulate (other branches could have failures
to update later in the fast-import process), causing users to have to
figure out whether one or many failures were reported and then have to
try to track down if they have one or multiple causes
  * the users are less likely to notice early "warning" without
erroring out, but the cause (someone else updating a ref) may be
harder to diagnose the longer it has been since the external ref
update.

That's my impression looking over your change and reading over the
relevant bits of fast-import.c, but as I noted before I don't
understand the usecase and perhaps there's something important I'm not
grasping based on that.  It'd be great if you could provide more
details to help us determine if we need to update the checkpoint code
to appropriately handle errors.


Hope that helps,
Elijah
