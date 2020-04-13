Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFB0C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5632072D
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk3YUzNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgDMRTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732693AbgDMRTI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 13:19:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3DC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 10:19:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h9so10930501wrc.8
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BjtWY+eZuuXyL2AZ3sLJyNGdGzf+pJgXzX/bp2Yc0lI=;
        b=uk3YUzNpQhijsQ1CvhnBSMAB7J0ukGu7UEk8D8Rh6z5T+snsjFQ7F6QhXatOXW3Lkb
         mZ0ygXc+Vt8ZVYCeJtjD0EQNEjcd5yIxQ0EDNGXLmIKXpFMwPr1XYyIJxr/2VbKqomC4
         3KsHEbr17cxPQ/lGh8L32lc2nuqjcG+kbdefTMT6XeG34wecnU1v5GSSmKRtm7IARUmJ
         52z+pXuuyrKV2RWmeQy0vbDIWAUyQ4Q7vJNCX1Twl306/S5nJbhpV0VVGB9FiSqVDR96
         WmB2rsrh1WDOKeM504fO5aN0cgjYfhBSVxijgZ2xev+K6FvVtV9GZ+AyOy0KdcQBHSCP
         3+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BjtWY+eZuuXyL2AZ3sLJyNGdGzf+pJgXzX/bp2Yc0lI=;
        b=OB4Vf7CejPUCJBxRGCXRqHjqrIAoOjNtYVNF5Btek03pqiQO+pXe+dEKn/qa4Xgez8
         vdCnSxhG+V7I/IWdoVHuJ744hBxko+pBe3BB8beyCtP7KQIMXY2ksFzlO/P32on6zob8
         +dReFqJxpNPIjTj8y3mnyGpCVx3uUnsA1MrLhSx6My1nyHpSoELxiUP1k7jKGtNb8HJd
         eaObeR3aVwoiuJ4dWCBJNIV4BBhThd2xKJnnN7I5ecObWbVaj4+nb5KVtqLJNcpmhdhp
         nY/uWPu7kPPeHiE8U6PocWhMdALpqxBQet2Z8qwyAEbtC7acTVPNz+WmdUaxi3/+Z60H
         tsSw==
X-Gm-Message-State: AGi0PubcIW+S2HbYCCsTgRptdfBBCI4RTAIIOBHJbrVFs5m3PLshF8ZT
        Ghwv0Fm4gMTuns/RROVzaK8=
X-Google-Smtp-Source: APiQypJ+R6s/OleAVnWsLtMHs76OGRVKkPG5HGj62/RWcCh6yJ+aPW1RtEhIKAEWpWZG0rI0QX9xkA==
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr19239887wrw.402.1586798345235;
        Mon, 13 Apr 2020 10:19:05 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:208b:691d:155b:7fa3? ([2a02:a210:ca2:9c00:208b:691d:155b:7fa3])
        by smtp.gmail.com with ESMTPSA id j11sm15609493wrt.14.2020.04.13.10.19.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:19:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Git pull stuck when Trace2 target set to Unix Stream Socket
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <20200413160051.GB59601@syl.local>
Date:   Mon, 13 Apr 2020 19:19:03 +0200
Cc:     git@vger.kernel.org, Jeff.Hostetler@microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D350F464-61DE-4EB6-BBE1-514A0C051F38@gmail.com>
References: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
 <20200413160051.GB59601@syl.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Thanks for the swift reply.

> On Apr 13, 2020, at 18:00, Taylor Blau <me@ttaylorr.com> wrote:
> I doubt that this is important (for a reason that I'll point out =
below),
> but it looks like your invocation here is malformed with the trailing
> pipe character.
>=20
> Did you mean to redirect the output of rm away? If so, '2>&1 =
>/dev/null'
> will do what you want.
It was an emailing mistake. I meant to write
> rm /tmp/git_trace.sock || true
So that the command is reproducible on repeated run.
I must have deleted the remaining part by mistake.

> Odd. =46rom my memory, trace2 will give up trying to connect to the =
socket
> (disabling itself and optionally printing a warning) if 'socket(2)' or
> 'connect(2)' set the error bit. My guess above is that you don't have =
a
> listening socket (because your shell is waiting for you to close the
> '|'), so there's no connection to be made.
There is definitely connection still, as I can still receive more events =
after interupting the stuck git command by Ctrl-C.

> Odd. What version of Git are you using? Your description makes it
> sound like it may be a bug, so I'd be curious to hear Jeff's
> interpretation of things, too.
2.26.0 built from Master git/git

For more info, I have created a paste to demonstrate the bug
https://gist.github.com/sluongng/e14563e4ce3cc9545781ecd5a95169f6
In which, I run `git pull origin` and `git version` on a relatively =
stale https://gitlab.com/gitlab-org/gitlab.git local copy.

You can get more information from the trace in that paste.
I have annotated the moment which the stuck happened with `It stucks =
HERE` phrase so look for it.

Cheers,
Son Luong.

