Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13892C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC28F22525
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oberbrunner-com.20150623.gappssmtp.com header.i=@oberbrunner-com.20150623.gappssmtp.com header.b="h8JQ16dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgATRdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:33:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37093 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 12:33:10 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so34491086ioc.4
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oberbrunner-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dPJt7mu6FVR+NbiJPgccYtB2tEKqBtcv1sti8fOSN3I=;
        b=h8JQ16drO3MD86Em1a1B1UCA9Hz/hrq0TBP85wHudGFC5mhENmJy0Js4HOMpvuxBl7
         GCuvuK5vujek4QBesPw8oitCUbIGX6d0Y/F0GA9ZrLin9d7QKFb2iv59tACi2nZ54J5g
         B3t7gMbJ8NB1oDs7BD86DT9zlI5Yq7dWju2jRXMRyXtL7cV0kQhSHmv55VJE+kLY4Fsd
         HoYZU1SLWpPi7i0Ma4nd76p0ki+Dq2CSqH2/e63HyUqXjAKvUXyjEThcEQI6f74EdAci
         HtX0ZugnZ4bvD+hOfWANzGW57No9USpEmGEg/Gn1XJuL7wGc/Qx15q/UikTtbzHMrEqU
         hXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dPJt7mu6FVR+NbiJPgccYtB2tEKqBtcv1sti8fOSN3I=;
        b=fNIhEccsDOM9OQ2yBe5Xp11zLEdqioRtj/4YijRCF8H2gGeTpKxoXVZ3NwFgD/wzE3
         mJmV8zn+F070aR7Y0OZ6HrTPi8pR4HU+R10Q8KbkGC4EGQ02VzZPUR58nV+L44ZjKxtm
         J/7dIhW4KMSRGjxAjj8/Ngxd3v1AhsY3auo8NynpDdmx4Ru6pCJz0cHDH82G3V7eztM9
         O+dxpE1FSG2oPqhtuBI6V+mKyMtckH5EvO7qf656rn5fs2gFyY19/Rgg1QlP7TES8WZD
         AGTF9bLS16DbXwcCnLcfxLyul86YAJDuo5ArO+tc3oEtY4Z37AQ8biugggLtK0O9SV+Z
         XZGA==
X-Gm-Message-State: APjAAAX1fFj6PLY1vZuQXnItJ4dDjx6v5ZpLQNDVJk97j7wIYQZ77zkz
        0yNkyPZfDbvfnxMAGuuxXOCbXdybT2TRJdd4/oHkwflbV18=
X-Google-Smtp-Source: APXvYqyx/LAZb+CBIz1sJZObeOwwfCl+P1dOYln+Z3yGA+7KyfR/BuqpNaIs3O/pXJEN1HW/E3tniP5vRl2wFXxjC0U=
X-Received: by 2002:a02:cd3b:: with SMTP id h27mr136266jaq.18.1579541589246;
 Mon, 20 Jan 2020 09:33:09 -0800 (PST)
MIME-Version: 1.0
References: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
In-Reply-To: <CAFChFygiaMsUJC5Kfpnk26DLWbY0gPdNJpZ_gLMf4utZ6_oZxA@mail.gmail.com>
From:   Gary Oberbrunner <garyo@oberbrunner.com>
Date:   Mon, 20 Jan 2020 12:32:53 -0500
Message-ID: <CAFChFyi5J-mb+rshtF7U2m=MtPzEPUa+V1_qbEXC=-LdQ218yA@mail.gmail.com>
Subject: Fwd: Possible git bug in commit-graph: "invalid commit position"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm running git 2.24.1 on Linux/WSL, and sometimes git fails with this error:
```
% git diff --cached
fatal: invalid commit position. commit-graph is likely corrupt
```
Usually that error goes away after I do a few more git operations, but
I haven't been able to discern a pattern yet. It's not always with
"diff", can be any git command as far as I can tell.
Perhaps it started after I enabled the commit-graph stuff:
```
[core]
        editor = emacsclient -c -a \"\"
        preloadindex = true
        fscache = true
        autocrlf = false
        commitGraph = true
        writeCommitGraph = true
```
In fact, when I turn off `commitGraph`, the error goes away. But as I
say, sometimes it goes away of its own accord.

Googling turns up almost nothing on this error. I have no idea if I've
done something wrong to corrupt the commit graph, or if it's a git
bug. If there's anything I can do to help debug it, I'd be happy to --
just let me know.

-- 
Gary
