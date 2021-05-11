Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D2BC4360C
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FE2611C1
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhEKT5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhEKT5w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:57:52 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46BC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:56:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so18536142otf.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejMtyi5c+LhgKT5e94JWnDuMIk80b3LrEGu6vWDE1oE=;
        b=FdccL2R5mpMqO5JYgxor8xBTYSvQkhPzrQRgFNUkVAVbNannqAoJjCn+LVESmjYJoA
         oWWddC3tTiwR5SF6Qg3P3xEGzJozLKxQIBf9rYXWn4STYZlDDzxr9cJ0bV9YH/RbGqSS
         t63H79HdmM8TNAz+piGKbtRueX6BSDsxvjPV/wOn3P+T+0qJAd8+KA1oxmI2Z0KgvFA1
         xsRAExMemHEkDcRuJ7TWIO64QFsM/DYp7GjzHCn4/IMAo/Y82Q98n1ubOCSRDchlNSpC
         5kw1e2l8aIubZvuxPZjFQWSjy3RhQ8JI1Cfi/tblVUkg8BOwwpSxc+FoZxjkb+QGpvK7
         mLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejMtyi5c+LhgKT5e94JWnDuMIk80b3LrEGu6vWDE1oE=;
        b=VidweUqUrQ/4gu/JJwrJjN9gbmzpX369Nd/kAESiXiFOW5RsNNQQO5ikPrMZ/Fusyh
         daqUgZlDYB70bZAc38fJghn4RxDKZVoAbl2LYeuORn1IcMVGPu7TS6ZXr2G7sTnSAhFK
         k94za+k2Woxwezu+U/Hpg5XJrQZNTsj9p4vUxlp3K1PVVfSiceGm4NWqR1tTPDKJECp+
         ASvWGEH0OPwZSiTbSwPxp/sfl4PhNoCqvfalo9/R1p8tKe5FFDGl/iMn3veFCqdtZGOq
         TiEqB1uKZV5kZhA4/kCQ0Xk9YOz1OYTuU3dyviHQRbM2WV0btn47Z05SVe6b0qYVSgem
         GCLg==
X-Gm-Message-State: AOAM533VMzx3LYjPyzZRhNVoi2IR7FtYpgXhIhfNJD7urZj2B5BQ9h2t
        dE1vgv5ppzOPpMNnPpfY2w9wyvMpe39TjL52IQ4=
X-Google-Smtp-Source: ABdhPJxW/3AvFZsoLZJiNatdpZrsbqx07lhDOC8ft+SKcjNXUon1nhUUe32J53Fuxk8sd7TFee+BUuYmADq5xkROG2Q=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr4954568otq.316.1620763004396;
 Tue, 11 May 2021 12:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com> <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g> <87v97pv04p.fsf@osv.gnss.ru>
 <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com> <874kf9qeof.fsf@osv.gnss.ru>
In-Reply-To: <874kf9qeof.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 12:56:32 -0700
Message-ID: <CABPp-BHf45K3P8kKfTEWu-acWMdjTz74xvSPJwZVS_o=qagA6w@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 12:00 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, May 11, 2021 at 7:03 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> [...]
> >>
> >> > If we enable "some kind of diff" for "-m", I actually think that by
> >> > default "git log -m" should be turned into "log --cc".  As you told
> >> > Alex in your response, "log -m -p" is a quite unpleasant format to
> >> > read---it is there only because it was the only thing we had before
> >> > we invented "-c/--cc".
> >>
> >> Please, no! --cc has unfortunate feature of outputting exactly nothing
> >> for a lot of merge commits, causing even more confusion than historical
> >> "-m -p" format.
> >>
> >> The best default for -m output is --diff-merges=first-parent. Everybody
> >> is familiar with it, and it's useful.
> >>
> >> > But that might be outside the scope of this series.  I dunno, but if
> >> > there is no other constraints (like backward compatibility issues),
> >> > I have a moderately strong preference to use "--cc" over "-m -p"
> >> > from the get go for unconfigured people, rather than forcing
> >> > everybody to configure
> >>
> >> I rather have strong preference for --diff-merges=first-parent. --cc is
> >> only suitable for Git experts, and they know how to get what they want
> >> anyway. Yep, by using --cc. Why spare yet another short option for that?
> >
> > Interesting.  I have a strong preference for --diff-merges=remerge
> > (yeah, I know it's not upstream, but it's been ready to submit for
> > months, but just backed up behind the other ort changes.  Sorry, I
> > can't push those through any faster).  I've had others using it for
> > about 9 months now.
>
> Once somebody uses it for 9 months and starts to understand what it is
> and really loves it, she can still set log.diffMerges=remerge (new
> feature) and have fun.
>
> >
> > I think --cc is a lot better than -m for helping you find what users
> > changed when they did the merge,
>
> Yes, but it doesn't mean it should be the default.

I didn't say it should be.

> In my workflows, the first thing that matters is what commit did what
> changes on the current branch. I don't typically care what the user
> changed during the merge operation, only about the result. If I do care,
> then only after I find the merge commit is responsible, and I can then
> use --cc if I want to.
>
> > but I agree the format is somewhat difficult for many users to
> > understand. (--diff-merges=remerge, or --remerge-diff, fixes these
> > problems, IMO.) I think --diff-merges=first-parent, while fine when
> > explicitly requested on the command line, would be wildly misleading
> > as a default because it would attribute changes to a merge commit that
> > were made elsewhere.
>
> No, it's exactly this merge commit that made these changes to the
> current branch. The changes you refer to have been made on another
> branch, and not by this particular merge commit, and we fortunately have
> the reference to those commits through the second parent of this one.

If you only care about "what introduced these changes to the current
branch", then it's not only the diff against second parent that is
irrelevant: ALL commits that are part of the history only via the
second or later parents are also irrelevant and thus you should be
using --first-parent when asking this question.  That changes both
history traversal and the diff output.  It's a reasonable question,
sure, but I didn't see you suggest that -m should change both.
Perhaps you did mean that, in which case I think that's a proposal
that would make -m become useful.  It'd be a drastically different
option than what -m is today, which would normally make me wonder if
it'd be considered a backward compatibility issue, but given how
useless -m has been and since Junio apparently even suggested changing
-m, this might be okay.

> >> Overall, let's rather make -m give diff to the first parent by default.
> >> Simple. Useful. Not confusing.
> >
> > I think it's confusing.
>
> I think it isn't, once you accept that merge commit does introduce
> changes to the branch, by itself.

Asking what commits introduced changes to the branch is a useful
question, but one which requires changing history traversal.  Unless
making -m imply --first-parent is part of the proposal, I still find
it somewhat confusing.

Granted, "what changes were introduced to the branch?" is certainly
not the only question you might be looking for answers to.  Others
include "what changes were people making in each commit" or "who added
calls to this function and why" (e.g. with git log S$function -p
$maybe_some_merge_diff_flag) or "who caused this function to end up
the way it is" (e.g. with git log -L :<funcname>:<file> -p
$some_diff_merge_flag).  For any of those, a first parent diff is
pretty terrible and highly misleading.  A separate diff is no better.
--cc would often be useful, with some caveats -- the biggest of which
is just how esoteric combined-diffs are.  --remerge-diff is way more
natural for each of these questions I'm coming up with.  Are there
other questions that -m helps us answer where first-parent diffs make
sense and are generally correct without also needing --first-parent?
I'm not thinking of any right now.
