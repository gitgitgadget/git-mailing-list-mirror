Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FEC83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2955D206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="U7t0RARM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD1FQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgD1FQD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 01:16:03 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68831C03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:16:03 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i16so19057912ils.12
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D96CCCnmD6JUYh+SCvFKniRlYvxxhgUxKaO0FYMEQmA=;
        b=U7t0RARMrIMfkMQhlL75T690u2j4v1bvSboHsP0Xw2C5O7BLEtOdnaqGvHnbHcf7u/
         G3RHN6oYaAsP/3XVFmS2Vfh+UGT+HXBqDVQtXR+y0w+dJ6EKXHzLcFeUoxg+DIE0b/Dk
         n/At/rUp/KhOV5cK19ZnBuFlm/41NaWNtEG8M3W6Sunpklhza+WZMB/vass6nCZkGDVg
         GsF/fhfKNux2vN6lUOWwp0gKVb9+/CNHyS6yT29mH+W45nvumm1j+ZJ84Qu7rviHjlx5
         y6aq0n18RpE4ykg6xYf+bmfeq35I+M7al4Dm295BDlRTU5Y90oWMwky8XiPcWAB+q8GS
         9cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=D96CCCnmD6JUYh+SCvFKniRlYvxxhgUxKaO0FYMEQmA=;
        b=nJ0Yv3sBTj4JOKP4yEdGXO4JPmEGH4nCZsPXy+HvvSfk0DYgiRpJuYXCnrimckRwqY
         Tex2kbiow0+jNPz2FCsaZ0s2hlKAHD/Yg+ukyxvWYVlaN13tCD7Ihgzo+Qk+JHQQbjKn
         ym/+SyjfWyXeWR1oaaop+sd3+X4E5iDewqQp3pzOMOE0NxcmIkaeo7qTRzjpUFPCA9Xp
         p8+mtHs6rt0AjBzrB9b7Bdw6fKJ3rnrB6Qflcq6fc66oWa+UPYQFkXPKjjGjHd7bMRgW
         5ViXIMF+wCpPm0Bjp4UlaTW1P206NYSFP9aeIFvJoewKwytxhpDXhC+Yh5vejX5NobkE
         ZlCw==
X-Gm-Message-State: AGi0PuYtP/dmE9MUDyn+0elTeVXbCt7Hqyc7GsODx8dBIj8G8Qf1psPz
        Z8dzrxAXLVL86PstjEkz627kFPyfUHpodNafowOOvSYC
X-Google-Smtp-Source: APiQypJO1KgdEaDH/U/BHyKOjocPSDE6isE1vOAYdJfn1Pc2e3xKbr44NMGycZtr5yTFF90puOzGUD4LGKjV+B4teus=
X-Received: by 2002:a92:4952:: with SMTP id w79mr2594729ila.15.1588050962493;
 Mon, 27 Apr 2020 22:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-FWssYXkJQ_LignBPRuVchrAR9MFE7rX5d+vy8PLCY5Mw@mail.gmail.com>
In-Reply-To: <CAGyf7-FWssYXkJQ_LignBPRuVchrAR9MFE7rX5d+vy8PLCY5Mw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 27 Apr 2020 22:15:51 -0700
Message-ID: <CAGyf7-FZ5vUCgs+DY-GZUb+zNNBPQmVgLzOLf+wqgO7PpHikDw@mail.gmail.com>
Subject: Fwd: Repack memory usage
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to help a user who has run into a situation where their
repository has gotten so "big" (to some dimension of "big"ness) that
they can no longer repack it on their hardware. Every time repack
runs, it ends up consuming so much RAM the Linux OOM killer kills it
before it can complete.

The repack command being used is: git repack -Adln
--unpack-unreachable=3D72.hours.ago

A count-objects on the repository (without -h, so these sizes are in
K) showed this:

count: 346911
size: 18367032
in-pack: 45117481
packs: 27
size-pack: 9462621
prune-packable: 22584
garbage: 0
size-garbage: 0

After the next repack was killed by the OOM killer, the numbers changed to =
this:

count: 427870
size: 22559712
in-pack: 90554922
packs: 37
size-pack: 18953693
prune-packable: 371285
garbage: 0
size-garbage: 0

The machine in question has 12 cores and 32GB of RAM. I've tried
setting pack.threads=3D1, but still hit the OOM killer. Bumping the RAM
for the machine to 64GB, paired with limiting repacking to a single
thread, finally produced a successful repack. (But it appears to be
unreliable, with some runs still failing. By the time the successful
repack completed the git process was showing over 60GB of RAM in
use--though that number is likely misleading.) There=E2=80=99s no setting
applied for pack.windowMemory, but my local testing (on a different
repository, I should note) didn=E2=80=99t show much change to repack=E2=80=
=99s overall
memory usage even with that set. Repacking a 500MB repository with
pack.windowMemory set to =E2=80=9C100m=E2=80=9D (and pack.threads set to 1)=
 had still
allocated far more than 100MB of RAM before the process completed.

Unfortunately, I don't really know too much about the contents of the
repository. I _do_ know that it contains binaries, some of which may
be large, but that's all I can find out; the user is unable to share
the actual repository with me.

Does anyone have any suggestions on how I can constrain repack's
memory usage, so this user can get a successful repack without
requiring all the memory in the system to run (and bringing the system
to a complete standstill for all other processing while it=E2=80=99s runnin=
g)?

Best regards,
Bryan Turner
