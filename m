Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C010FC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 18:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiHJStq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJStp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 14:49:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3628832F2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 11:49:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z20so18328395edb.9
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8lnlSGh9EpmoCEjflPhFhjYhsJKbIMSnI3Q76iwVIdE=;
        b=YkgnFL0pMSna64SRSpXcPfJCwLur44VFBbKGyW4vjtNRoBmzxz+OXA0jPX4L8R9oU3
         ZsJ5cl0PDV3aZCGVlI8HmPZfHko2CyvUN/VTvEgQCAC+STMrEHNoTeJogk3dbJvtSVFi
         6SXgq/yjLZvJvey1JrAeiveN9P14PEpbMiM3I+euvFhqYeHoHoxlNMMLVUVG4Rupzyf/
         eWj+TEgtLhQNpKRl7Jph9CXXT/CQUa0z7pJPR1z9J/BQapZKcAhEK64JsjuLlZV+JKOe
         JHHDv5bUNHwrfKufzmMDIIbKqQvF1NF44JrenApEjV+SO1YhuCDL4+jwCj3ojIfV+vS2
         IQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8lnlSGh9EpmoCEjflPhFhjYhsJKbIMSnI3Q76iwVIdE=;
        b=xOFNKzFh0HQzjiTm2B+M6Rsuzfr5gj5MEj7og7YK3Eb7AF1cmxRnAqdjGXXrB65zoJ
         qwUcKv7xqKe14YP3IcLHWzrE7/sRlIK4LVoXaU3CZlAWt+OUJh0zrA8hZ2YFc/V45pCk
         L0uU8vI1xJILNtbVYoCzlaUJgBO+S9k4elg/SLE7+2WGSzCjxOP3sQSebz8Rs63dXY22
         5vEWWxpmtJyTbGs0ssZi9Xhpo6elo8kDN1dBjv5uNER15P/PUpHNYAKRxzBsab1yHD3H
         v0PQ9Y+ngj01SfUZie0HdAuUoB+y4WtJNaEgwXb8uYBBOIgvse7pWm//cr3HSHFHvd1Z
         1ioA==
X-Gm-Message-State: ACgBeo0z9DfuHBxpEHPrab7ZzBSRccmLkDc9h3YXn2dn7sGTPaWPv+5D
        xGhsYgnpbNdKSm8A+7nD+CvmadxulQ0BDsfNCM0=
X-Google-Smtp-Source: AA6agR4r+Lt0gN0jjM7ZfbnWm2RvJ9cOkYf5FGpD+gro3x65zahs+m+ZbK/cLN4CDSuDTRsGAMsyz3oChc4RHADOWMI=
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id
 ew4-20020a056402538400b004316d84b451mr27725839edb.46.1660157382338; Wed, 10
 Aug 2022 11:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com> <xmqqmtccniw4.fsf@gitster.g>
In-Reply-To: <xmqqmtccniw4.fsf@gitster.g>
From:   Eric D <eric.decosta@gmail.com>
Date:   Wed, 10 Aug 2022 14:49:28 -0400
Message-ID: <CAMxJVdH3B2An7La9knM=QJojQ334O+Z2-tqNvqRZz2Eu6CV+-w@mail.gmail.com>
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

On Wed, Aug 10, 2022 at 12:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Most modern Samba-based filers have the necessary support to enable
> > fsmonitor on network-mounted repos.
>
> My impression from the earlier discussion [*] was that having the
> necessary support and the support working well are two different
> things, and the network mounted directory being served via SMB was
> not enough sign of the latter.
>
> https://lore.kernel.org/git/16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com/
>
> I do not do Windows, so I'll leave it up to the experts, but if
> everybody who talks SMB behaves well, then the updated code that
> enables fsmonitor for SMB talkers and disables it for all other
> remotely mounted directories, with a configuration override, does
> sound like a good way to go.  I think the new code in check_remote()
> is broken, though (see below).

> > +/*
> > + * Check if monitoring remote working directories is allowed.
> > + *
> > + * By default monitoring remote working directories is not allowed,
> > + * but users may override this behavior in enviroments where they
> > + * have proper support.
> > +*/
> All existing multi-line comments in this file (and properly
> formatted ones for this project) ends with "*/" where the asterisk
> aligns with the asterisk on the previous line.

I'll clean them up, thanks.

> The three-line design goal is well written, but as you are special
> casing SMB, perhaps
>
>         By default, monitoring remote working directories is
>         disabled unless on a network filesystem that is known to
>         behave well.  Users may override ...
>
> or something like that may be warranted.

That reads much better, thanks.

> > +static enum fsmonitor_reason check_allow_remote(struct repository *r)
> > +{
> > +     int allow;
> > +
> > +     if (repo_config_get_bool(r, "fsmonitor.allowremote", &allow) || !allow)
> > +             return FSMONITOR_REASON_REMOTE;
> > +
> > +     return FSMONITOR_REASON_OK;
> > +}
>
> This is not wrong per se, but it probably is easier to follow if you
> write them the other way around.
>
>         if (!repo_config_get_bool(..., &allow) && allow)
>                 return FSMONITOR_REASON_OK;
>
>         return FSMONITOR_REASON_REMOTE;
>
> After all, as the big comment before the function says, by default
> we deny and only on exceptions we allow.
>
> Actually, the above is not quite right.  You'd probably want a "not
> set" or "undecided" bit.  I.e. something like
>
>         if (!repo_config_get_bool(..., &allow))
>                 return allow ? FSMONITOR_REASON_OK : FSMONITOR_REASON_REMOTE;
>
>         return FSMONITOR_REASON_UNDECIDED; /* invented... */

Makes sense. How about FSMONITOR_OVERRIDE_REQUIRED ? The error message
could then indicate that remote repos are normally unsupported but
that setting the fsmonitor.allowRemote flag overrides this behavior.

> > +/*
> > + * Check if the remote working directory is mounted via SMB
> > + *
> > + * For now, remote working directories are only supported via SMB mounts
> > +*/
>
> "*/" -> " */".
>
> > +static enum fsmonitor_reason check_smb(wchar_t *wpath)
> > +{
> > +     HANDLE h;
> > +     FILE_REMOTE_PROTOCOL_INFO proto_info;
> > +
> > +     h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> > +                                     FILE_FLAG_BACKUP_SEMANTICS, NULL);
> > +
> > +     if (h == INVALID_HANDLE_VALUE) {
> > +             error(_("[GLE %ld] unable to open for read '%ls'"),
> > +                   GetLastError(), wpath);
> > +             return FSMONITOR_REASON_ERROR;
> > +     }
> > +
> > +     if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
> > +                                                                     &proto_info, sizeof(proto_info))) {
>
> Overly deep indentation that unnecessarily causes an overly long
> line. "&" in "&proto_info" should align with "h" in
> "...HandleEx(h,", we use fixed-width font, and our tab-width is 8.
>
> The second line of CreateFileW() call is also overly indented and
> may want to be fixed, but it does not overly extend to the right end
> of the display (we aim to fit in 80-columns, as CodingGuideline says)
> so it would be nice if it gets fixed, but it may be tolerated.  This
> one is not.
>
> > +             error(_("[GLE %ld] unable to get protocol information for '%ls'"),
> > +                   GetLastError(), wpath);
>
> This line gets it right ;-)

Got it. I'll check my editor settings too :-)

> > +             CloseHandle(h);
> > +             return FSMONITOR_REASON_ERROR;
> > +     }
> > +
> > +     CloseHandle(h);
> > +
> > +     if (proto_info.Protocol == WNNC_NET_SMB)
> > +             return FSMONITOR_REASON_OK;
> > +
> > +     return FSMONITOR_REASON_ERROR;
>
> Is it?  Shouldn't it be REASON_REMOTE, not ERROR?  Unlike the
> earlier case where you couldn't figure out the protocol information,
> at this point you know you learned what protocol is in use, and it
> is just that the protocol was not what you liked.

Yeah, I noticed that myself this morning.

> > +}
> > +
> >  /*
> >   * Remote working directories are problematic for FSMonitor.
> >   *
> > @@ -76,6 +128,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
> >   */
> >  static enum fsmonitor_reason check_remote(struct repository *r)
> >  {
> > +     enum fsmonitor_reason reason;
> >       wchar_t wpath[MAX_PATH];
> >       wchar_t wfullpath[MAX_PATH];
> >       size_t wlen;
> > @@ -115,7 +168,11 @@ static enum fsmonitor_reason check_remote(struct repository *r)
> >               trace_printf_key(&trace_fsmonitor,
> >                                "check_remote('%s') true",
> >                                r->worktree);
> > -             return FSMONITOR_REASON_REMOTE;
> > +
> > +             reason = check_smb(wfullpath);
> > +             if (reason != FSMONITOR_REASON_OK)
> > +                     return reason;
> > +             return check_allow_remote(r);
>
> This does not fulfill the promise you made in front of
> check_allow_remote().  As we saw, check_smb() returns something
> other than REASON_OK when it is talking to a remote that is not SMB,
> and when that happens, you are not giving check_allow_remote() a
> chance to intervene and override.  It should be more like
>
>         reason = check_allow_remote(r);
>         if (reason == FSMONITOR_REASON_OK || reason == FSMONITOR_REASON_REMOTE)
>                 return reason;
>         /*
>          * check_allow_remote() did not decide, so use the default
>          * based on the network filesystem.
>          */
>         return check_smb(wfullpath);
>
> I would think.

If we do as you suggest above, then fsmonitor.allowRemote=true would
override regardless of the protocol being used. The more conservative
path is to only allow the override if SMB is being used.

It could perhaps be better written as:

reason = check_allow_remote(r);
if (reason != FSMONITOR_REASON_OK)
        return reason;

return check_smb(wbfullpath);


> >       }
> >
> >       return FSMONITOR_REASON_OK;
> >
> > base-commit: c50926e1f48891e2671e1830dbcd2912a4563450
