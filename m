Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C451C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B5C20658
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 20:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWTyDrie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0U7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:59:44 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35609 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0U7o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 16:59:44 -0400
Received: by mail-ot1-f46.google.com with SMTP id v2so6699834oto.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9bxnt74yMohZ2vXycxFZgqyXuk2e9X1FyHUj6kO2G8=;
        b=tWTyDriezARhRy5gVxlrAn2naPiXp4f61QGJXQ/vIyHxxwPffKB5TvGcBzN14/zxQ6
         Nw+bNJOtwK9lJsvTPS57+jPkP9uLq4O9mGY6sUDYYii3Udh1NvcJYus7SvpN8/2MUc+g
         x+M3VhxDq4DjS5Ehuf4eQOdGqh228qRjCGBo22pCWPnxqnez4qxsk60vlhjaf3ZE2iKa
         dmuuTXL7HY8HmfBA+TSsb1oPYoErI9lKMupdlLGWz8VXZ9Y2v+XPva8fKY45A97SEtRw
         mSVamKT9hqwHw2UghRDqrUgi82T62Jry7KDVLqg7TVezTjwMxaIUenbllJw8r8o8nm71
         kOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9bxnt74yMohZ2vXycxFZgqyXuk2e9X1FyHUj6kO2G8=;
        b=FMnJQQTEtNTsLyNkZS1YPy7XyTXXHtZbi1WyCFtxUw5Ye+PwO43Ju9E16Nc5toP2DY
         r82v4qKV5RMc22F6tf75AoeZU6cLhi6W5KcMrycP34nmEahvH2ReqEAX8R6D7nxxDWwA
         z1MLfiDrb96wc8Us9Tml9adfjVX1k9coz7FXJ/59Z6ZNIsKG7FGE2+YD8dUzoEMAXB+H
         OFGeSb7JgOcgpGQljFF8e9aATn40ymMoWtS8OxMH71ZnG6tzV6KC6ZW3yQ+HyGZUi1ct
         lVvxCc89cVa+l5osf4MyX5Is23+0GfysT0D3uNjFJklloQpWJnhRYph22tnTIVpr4La5
         bN7A==
X-Gm-Message-State: ANhLgQ0ji4gpj2uPFm/RuJMHkIY0GDMPHVh/K18Wi3p4TezIwc7wk6bm
        qhZkMocHBqJkCnCuTDlqU+Hy32IlpfEV3YPvu+Y=
X-Google-Smtp-Source: ADFU+vvMxUMRAvr6zz02azdRER8ibrkT7z022PJcpmnj+ThCfVe8U33Jj8hZfYG8hIhlIumLy5Vwe8T6+KQk4T7QtuU=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr514928otl.162.1585342783077;
 Fri, 27 Mar 2020 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
 <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
 <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
 <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
 <CABPp-BFMN+pnOjEe2tZZJp3_Noojn5j1ip3dh8Xz9hCZoKJbxw@mail.gmail.com>
 <20200326072840.GA2198456@coredump.intra.peff.net> <CAM+g_NthmmJh3=Tp3ea6PmDr1h2-WtpiSTO8q02V3judc9p-Kg@mail.gmail.com>
 <CAM+g_NtV5iUM=VJHOX7Um2DFLzjq-x76TYa_P_U6q5HBRmCY=A@mail.gmail.com> <CABPp-BHihQjMc9qugVtVTZVduRxLYUAhf18R5c=3Lb5bcRzjAw@mail.gmail.com>
In-Reply-To: <CABPp-BHihQjMc9qugVtVTZVduRxLYUAhf18R5c=3Lb5bcRzjAw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Mar 2020 13:59:31 -0700
Message-ID: <CABPp-BGKeUeMCaOt2b6j1kqgbeTDJxYjRxAPdM+=JB6V1r4EpA@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 11:34 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Mar 27, 2020 at 11:01 AM Norbert Kiesel <nkiesel@gmail.com> wrote:
> >
...
> What's in your .git/config, and in your $HOME/.gitconfig?  (Or maybe
> just the output of 'git config --list'?)
> What hooks do you have setup in .git/hooks/?

After some off-thread discussion due to concerns with sharing his
configuration globally...

Ahah, so I can duplicate when using both pull.rebase=true and
rebase.autosquash=true.  rebase.autosquash in the rebase code sets
allow_preemptive_ff to 0, meaning it disables rebase from
fast-forwarding.  That would have been fine if we only ran a rebase,
but we ran both a merge and a rebase and thus updated ORIG_HEAD
*twice*.  So, the "extra" bug I found upthread (pull runs both merge
and rebase for a fast-forward) isn't an extra bug but is *the* bug in
question.  It's been with us for a few years as Jeff pointed out, but
just was uncovered due to the other recent 2.26 changes.  Patch
incoming soon.
