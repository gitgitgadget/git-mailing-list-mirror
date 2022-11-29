Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA32C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiK2Vtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 16:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiK2Vtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 16:49:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C4663E0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 13:49:43 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso69767pjt.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TA6RN7hLYoYqYbAYxkNTTBvnM6a60LOgamgCqf3tCo=;
        b=nwlrl5zX5BTcz6f6+V0k81p5662BxooI/BUzgt6cPU2k1kkr8wFwJfE9plRed8lSNh
         DtwdecPOCEP9sGZ2Mkt700LdlRHIwxhNgZFwn1XApG2202VwyU9B5bebQwpGq1C9PRsP
         YP2XPt8Ex7XJWVTQC1w+5/rFbxLytbZUl/orWzfqexgSS2AJWw29pyXWGkuOFFGcTAn0
         hmX8okBMKS81fcURdhX7kP5x+6xwoDFRBk5yhBYSc/JCnFdri1gWpAr7KzHNXuml2JvI
         GIn/jIUxCKdNCRh3Dp5eIygJP+zFTD3KXKvljD/9QfG9EP3SuIC+TJE8MCXZTksxv7l7
         8mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TA6RN7hLYoYqYbAYxkNTTBvnM6a60LOgamgCqf3tCo=;
        b=BaKaHivgQpm4EACTmMzuTJYqxZJrXHR2iYG9UntuEGHGLuiSRKSE6h0/Vty+l41WhZ
         aecbPL0uOXmOAArREIansB/9jhxgFJZt1zUSoho9Q7QpdGL0tKbPZ1GCUYcuYq3pDcsm
         ou7Ttzvd5QTUDP3dH6Rh5QsmMC+s/rAjUCEPmecFH93s/5SEb5C7SMp6xIo8fPXTY5rD
         kY+nbR8A9ysC4FDR+eeejaM63HUY0nFCyV8k/7Slt2ICBPr95/NuN9lizC8/UewDeh0O
         GOEWgG4Z+KvccUQxRglMtcuTea5ZEckdQyIxqJdSIsHWAwypRa+qevuR0+smz7NQ7Q28
         cndw==
X-Gm-Message-State: ANoB5pnkHNlZOxWfCkI/jRScUO72BUnHFoIfDTKCaDfDhgzlU5/klDO6
        q0Rneki1BTjTeX6g7nmYSBRw2wKLR/IQEmE2BEM=
X-Google-Smtp-Source: AA0mqf7kTDx2XmA49YQxhId6+9ZHrpiNKL0T8Q/BfeoPSsQsYI81ZL0MxeSko7KuCQNc1LNTMBzJzUkjLOV5VuX+qiQ=
X-Received: by 2002:a17:903:2350:b0:189:8ea3:7455 with SMTP id
 c16-20020a170903235000b001898ea37455mr10751818plh.19.1669758582517; Tue, 29
 Nov 2022 13:49:42 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8niurChnXPrZSeBa7g1z5AF3PqYdf1X0Rm03rDanec6Gw@mail.gmail.com>
 <Y4ZXRx4mf0UMk4H6@coredump.intra.peff.net>
In-Reply-To: <Y4ZXRx4mf0UMk4H6@coredump.intra.peff.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 29 Nov 2022 16:49:30 -0500
Message-ID: <CAH8yC8=zv30qNKVGZcT02hfTWgn4x1RCEUioB=jG9yq9X_Qp=g@mail.gmail.com>
Subject: Re: Git port to Debian SH4 may have trouble
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 2:02 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 29, 2022 at 12:01:01PM -0500, Jeffrey Walton wrote:
>
> > This is a crummy bug report... I am  testing on Debian Unstable within
> > a SH4 Chroot. I'm seeing a hang during a git pull. Eventually I have
> > to CTRL+C, which results in "fatal: fetch-pack: invalid index-pack
> > output."
>
> The message is probably a red herring. Once you terminate index-pack,
> the fetch-pack process reading from it will see EOF before reading the
> expected "pack ..." line, and generate that message.
>
> So the hang is probably the only interesting part.
>
> > (sh4) debian-chroot:~# git clone -vv https://github.com/weidai11/cryptopp
> > Cloning into 'cryptopp'...
> > POST git-upload-pack (175 bytes)
> > want e9cbc4698a6b3ed067910862ad1355069f348d2b (HEAD)
> > want e9cbc4698a6b3ed067910862ad1355069f348d2b (refs/heads/master)
> > ...
> > want 511806c0eba8ba5b5cedd4b4a814e96df92864a6 (refs/tags/CRYPTOPP_8_7_0)
> > POST git-upload-pack (gzip 1602 to 825 bytes)
> > remote: Enumerating objects: 28448, done.
> > remote: Counting objects: 100% (68/68), done.
> > remote: Compressing objects: 100% (50/50), done.
> > remote: Total 28448 (delta 29), reused 49 (delta 18), pack-reused 28380
> > Receiving objects: 100% (28448/28448), 27.01 MiB | 4.30 MiB/s, done.
> > Resolving deltas:   0% (0/20757)
> > ^Cfatal: fetch-pack: invalid index-pack output
>
> If we're in the "resolving deltas" section, then that means we're
> probably not hanging on receiving input from the remote side. At this
> point we should have gotten all of the data and would be CPU-bound
> reassembling deltas and computing their hashes.
>
> Just a hunch, but does:
>
>   git config --global pack.threads 1
>
> help? The delta resolution is multi-threaded, but nothing else in the
> clone should be.

Yes, `git config --global pack.threads 1` allowed things to continue.
The check-out was successful.

Jeff
