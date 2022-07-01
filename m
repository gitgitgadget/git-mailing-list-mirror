Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A2C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiGATPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiGATPP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 15:15:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E22B244
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 12:15:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so5658193eja.8
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bpUHBJi1HIOPU4wNikvqBsSMZpy3osWFqlOVBNYvXA=;
        b=qFPTFpGIXz4G8uvZqI83Pgc7/OnhMU6LP9P2shml0MkOjCNjanA1EHuVId5KMz68Nq
         L/YMqpm/0WV5LEbf1mI75A88gJ9Ft4DxG2WvbQTGMDPawH42E8QjcKMVvnvqU6wH2tyY
         EG31YQ8BHvSe0dX3RYu+gX2nmxU3/gWG82aFOd/FBJZOWvJ96zZDc1CZrJXUjNSR7uOx
         1PCkNQ+OJvreoUuInAXFv0alKLyFGS/AZYWFtUsoFJls2xe4JSLY18/wFrYY5N8QRzvi
         YqkH/PaV+wtqOUYbfQJHgcHRNDnEn3VY0K6xUGqoBa8kyclr+m0ZhmZ0sd+iqkcCBK91
         //4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bpUHBJi1HIOPU4wNikvqBsSMZpy3osWFqlOVBNYvXA=;
        b=mnxZVlojB7GNoJF/xOIV5P0+ozF+mLdjtzUJ4fpehu6c5u6rU5TZEj+0zWURo7GScH
         GuueSPtPqT5bU+smauVYpVWB5L6FywXWXP6LCorekZSD8h1tMDgPGGoV3katTvNeMjQN
         bjIP7SRSfRzK0oJ+vGIj0XKEHDgHAR4C4d6tbvCRMBFlpZSTz5JDVlhy1Opvqvu7/FFZ
         w7aERuttMWhxaWlum61yeqB6JP1icJ5eftxMi3QU9WtpBAEU/scMURJkR1V3DE4vsE+L
         joHFSLppvLv9/m71+dh1J9toUDyN1C7IxxrXE5APeQRNK67Cgc2t+6kdZo2LtNpDUoKy
         xhwg==
X-Gm-Message-State: AJIora+Qo6lCuV9jbO9KQDQF1w1kz6ugAlddfs4T6tFB6zUyh/JBAswn
        mRnJ/JS4cqX1+/n+UB0Jp24Wi98ko9MbtdzOUhE=
X-Google-Smtp-Source: AGRyM1tESbVoQExpKwqMn7dg4haUEdkF3ZMLCkynWKy1rvAON15ox/hg2298ymaGh2LdUy0lYuqLjblKQIn+mZTJIGw=
X-Received: by 2002:a17:907:d29:b0:726:9e67:df9 with SMTP id
 gn41-20020a1709070d2900b007269e670df9mr15967077ejc.242.1656702913114; Fri, 01
 Jul 2022 12:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
 <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com> <xmqqmtds8ylz.fsf@gitster.g>
In-Reply-To: <xmqqmtds8ylz.fsf@gitster.g>
From:   Eric D <eric.decosta@gmail.com>
Date:   Fri, 1 Jul 2022 15:15:02 -0400
Message-ID: <CAMxJVdG5OCgWMN+0aymdVTorrkeViGNy=f49fu7GJE6trwyoWw@mail.gmail.com>
Subject: Re: Option to allow fsmonitor to run against repos on network file systems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One more possibility:

Leave the check, but make it a warning if there are still concerns
about running fsmonitor against network file systems. Maybe also
provide an option to suppress the warning? Not that much different
from having "fsmonitor.allowRemote" I suppose other than by default
fsmonitor would "just work" for network mounts.

On Fri, Jul 1, 2022 at 2:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
> > Having said all of that, I did do lots of testing and never had an
> > issue with remote drives actually working correctly, so I think it'd
> > be fine allow a config setting to optionally allow it.  I just didn't
> > want to clutter up things in advance if no one actually wanted to
> > use it on remote file systems.
> >
> > I think it would be fine to have a "fsmonitor.allowRemote" or
> > "fsmonitor.allowWindowsRemote" config setting and default them to false
> > for now.  Or until we learn which combinations of remote mounts are
> > safe and/or problematic.
>
> How about getting rid of "is this remote?" check altogether (which
> presumably would simplify the logic) and make it totally up to the
> user of the repository?  fsmonitor.disableInRepository that is set
> in ~/.gitignore and lists the paths to the repositories (like
> safe.directory does), for which fsmonitor gets disabled, may be a
> handy mechanism to set up the default (and it can be re-enabled with
> per-repository core.fsmonitor).
>
>
