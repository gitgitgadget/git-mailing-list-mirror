Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E704C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiAJTA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiAJTA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:00:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31362C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:00:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m1so14628004lfq.4
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=17X4+umi009nkE3kCwG7Ykv8PDquU9+l6cT4QUOyy4E=;
        b=HKloZTquPMA+MoFZWphh8RF/vnV8QQMpgMtC12zpzYZvAk4DeIBxAHlSoa37n44eoP
         dFvqaEBnt8SRUXs8SNPB0p81XAM2TvuVwhRew9rcruthXeEnP1dmagdVBcgX0c6RayhL
         4fMn+zPzUXvWH9vZmgtOtrXUxWvP7vo+5g+thZS/8MNXqg10l+6ob9033fftwubW2Er+
         s9G3VCr44uhE96dLBsb30bP9yYRXFQFICOl9kDajH5pabdpEhcA3hI7qDMAksWw3CHTZ
         bFa+PG4/DFLwsu/3coZXdIkX3s2iqmIA8H3O7dR2Ed8ENZA+F+TM8TaXajTpnqSTAnIh
         0N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=17X4+umi009nkE3kCwG7Ykv8PDquU9+l6cT4QUOyy4E=;
        b=i4JO4eNOJU97filzsWkmCMEldC+6dMxF/Bxi7RQESXOIWmd3yILqy+lYBMMP6r5qiN
         OboWeC4dlQsdcMZXpyYopgX7dBeQVKGv4ClpDT69qb7z8G+JqE0MtWsCz2ivAlCHuNR4
         sHftNM/+b5VrXH2Z258oWFavGj8hQaQeMwKc+ZYnukxvdZ7d3cMd62Yk4ngAIvIMdl6r
         m4GMnEfLXXteeG1CPHWPn7lxk09HBPWj+HNRmzpWKycW6acCiemus45wk3NS9jmF6KX5
         pzoDUxIzdUGrHkkS9knY/bn3Y0qD33d4FTus+x4zFxPlreG5phhb71s/25pM0d/pl5fV
         QSsw==
X-Gm-Message-State: AOAM531SOjk5pkXShBdeLtH89oMTW+uiPdFyH68wnqnT6YHCGzTeKViZ
        Gr8nemNlhLC5Eg7WciukCXlxcYWUaVNJWPwf/i4=
X-Google-Smtp-Source: ABdhPJwEjwCc36AUJ3FwrkkgbsoC/ORTtn3etZTLS3oEJaZGz4lFmyEqvTdPkV4j/1dhwOf4TL/JxfmgjgItudGsxBc=
X-Received: by 2002:ac2:5b89:: with SMTP id o9mr787027lfn.592.1641841226441;
 Mon, 10 Jan 2022 11:00:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com> <CANQDOddJzgyfQHi8hVMPU5iLwyt4GmpGt5qob0ZrjqTax6K0tw@mail.gmail.com>
 <007001d804f3$a2e573a0$e8b05ae0$@nexbridge.com>
In-Reply-To: <007001d804f3$a2e573a0$e8b05ae0$@nexbridge.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 10 Jan 2022 11:00:15 -0800
Message-ID: <CANQDOdf4k5K8U-hs+Cv5W9DZFDonab6eMO4XFX4UFHkJ2RzQQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] A design for future-proofing fsync() configuration
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 8, 2022 at 4:55 PM <rsbecker@nexbridge.com> wrote:
>
> Please remember that fsync() is operating system and version specific. Yo=
u cannot make any assumptions about what is supported and what is not. I ha=
ve recently had issues with git built on a recent operating system not runn=
ing on a version from 2020. The proposed patches do not work, as I recall, =
in a portable manner, so caution is required making this change. You can ex=
pect this not to work on some platforms and some versions. Please account f=
or that. Requiring users who are not aware of OS details to configure git t=
o function at all is a bad move, in my view - which has not changed since l=
ast time.
>

There was already an implied configuration of fsync in the Git
codebase.  None of the defaults are changing--assuming that a user
does not explicitly configure the core.fsync setting, Git should work
the same as it always has.  I don't believe the current patch series
introduces any new incompatibilities.

Thanks,
Neeraj
