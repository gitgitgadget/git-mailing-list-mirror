Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C33C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiHJVaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:30:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD34CE2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:30:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y13so29987911ejp.13
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aF+/Jz3YLIXunnsquF/1sgCAc6nAoNPYfkHoxcbBfsU=;
        b=o1EXlfnvvmI6JyrH5ap0fRTyCUUlB6k0yG+RSlnTYHFflCGyaAR/drL8OJA1Hpx6K1
         iDYbfO1ejSIyKg8QoYfqpXSbSkCFeYyFtHyYRPluC08tA22oQrNelZFly+JhBf8m+jMz
         CodtkCuCrnaPDq7rnbfUnD1VTssz/Kpzigx8lDxDJJTxvhSheVEaFUl91AudBz8mkd0R
         lau0eFmQ7tzdYaX+YrTgpKLz6N+ly2Fn1dm4bQv+tpEjQvS8a3bc9+fR7OyJOTg6hWur
         963YkXEXKbhO7SjXtbNKQB4iwP5CVcPRFTUzREwfyGOQ0sQj8EmqjEwlozoEQ0HDtcuW
         tKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aF+/Jz3YLIXunnsquF/1sgCAc6nAoNPYfkHoxcbBfsU=;
        b=1qG9/1THkhuRhK6P6mKsTpgEVoT3YvmlbRhiGx86L5TAk5f7qhdR85hLknRLe4A1P/
         oH3V1j7ib2Vt61axkHO4wwyM1UPUHWS5V2oSE0TnDmSWWCTXjIfKF7x1W/m8aSTyLo7a
         zXUS40XaZemZPtfbL4vtQPlI/lPG/xSCVslwrXKAdoJNeC5c84DlokSmbhp4orOf+0ky
         s/6FHZOKEQi9rmQGwjupK4EGcpcP0nru1m/xtfphxECnq0IF44E6B6o3VQqd3M9daRhn
         6Y47SSXKF3CWp9P3e/0VqZqB0VOxTXxSjNtNbG1dQ60m8GM+BJt+OyWCAdR0NKBA+Bw8
         csLg==
X-Gm-Message-State: ACgBeo0CNuAoQJMNGInLU0lIaBfxtzIbe5MfI5yKIhEQfz58IHCuxM8e
        NmI7LsQLxAf3K962mrwe2M/1AfiMDSCwweLBASI=
X-Google-Smtp-Source: AA6agR6V2qaJEbq+5/aHhOYB307YfvWxvcyUuu7Zf+C/wFazmJlR4u8gR7dsvpoun5wRTjnD11OGAq+MdnSDIL98TtQ=
X-Received: by 2002:a17:906:c154:b0:733:197:a8c with SMTP id
 dp20-20020a170906c15400b0073301970a8cmr4738393ejc.483.1660167013792; Wed, 10
 Aug 2022 14:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
 <xmqqmtccniw4.fsf@gitster.g> <CAMxJVdH3B2An7La9knM=QJojQ334O+Z2-tqNvqRZz2Eu6CV+-w@mail.gmail.com>
 <xmqqbksrlvyb.fsf@gitster.g> <CAMxJVdH-UbCZYp1hcvy4efEYd33jk0bFosJOtag5S4F9-m3-sg@mail.gmail.com>
In-Reply-To: <CAMxJVdH-UbCZYp1hcvy4efEYd33jk0bFosJOtag5S4F9-m3-sg@mail.gmail.com>
From:   Eric D <eric.decosta@gmail.com>
Date:   Wed, 10 Aug 2022 17:30:00 -0400
Message-ID: <CAMxJVdEvNKzwbHkRHcbd=_8yEuYZiNsNABVieU1tV5kna_nJ_g@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 4:36 PM Eric D <eric.decosta@gmail.com> wrote:
>
> On Wed, Aug 10, 2022 at 3:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Eric D <eric.decosta@gmail.com> writes:
> >
> > > Makes sense. How about FSMONITOR_OVERRIDE_REQUIRED ? The error message
> > > could then indicate that remote repos are normally unsupported but
> > > that setting the fsmonitor.allowRemote flag overrides this behavior.
> >
> > I actually think check_allow_remote() should be renamed to have
> > "config" somewhere in its name, and return -1, 0 or 1 and not "enum
> > fsmonitor_reason".
> >
> >         static int check_config_allowremote(...)
> >         {
> >                 int allow;
> >
> >                 if (repor_config_get_bool(..., &allow))
> >                         return allow;
> >                 return -1; /* undecided */
> >         }
> >
> > then caller can do
> >
> >         switch (check_config_allowremote(...)) {
> >         case 0: /* config overrides and disables */
> >                 return FSMONITOR_REASON_REMOTE;
> >         case 1: /* config overrides and enables */
> >                 return FSMONITOR_REASON_OK;
> >         default:
> >                 break; /* config has no opinion */
> >         }
> >         return check_smb(...);
> >
> > > If we do as you suggest above, then fsmonitor.allowRemote=true would
> > > override regardless of the protocol being used.
> >
> > Exactly.  The code should not try to outsmart the user.
> >
> > If the user says they wants to use it on a particular remote, even
> > if you do not know if that particular remote system works, just let
> > them try and see if it works.  If it does not, they can easily
> > disable, because the enabiling was a deliberate act by them in the
> > first place.  They know how to fix it.
> >
> > Thanks.
> >
>
> 100% agree with you, thanks.

The only thing that is somewhat gnawing at me is that just because the
remote worktree is mounted via SMB is no guarantee that fsmonitor will
work correctly. In many (most?) cases it should, but who knows what
support the filer server has.

I think we should allow the user to override regardless - as you said
let the user try it. But, conservatively, just because SMB is there
may not be enough to let the monitor start without the explicit user
override. Being able to report on which protocol is being used could
provide useful diagnostics, but that's about it.
