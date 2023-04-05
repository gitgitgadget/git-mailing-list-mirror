Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629DC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 13:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjDENgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjDENgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 09:36:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA945FCC
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 06:36:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id cf7so42558576ybb.5
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680701762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VggWtoWbZcPILk7ArjMga2p++PX4pdis5t7T53gcfGY=;
        b=FtOFAyY50SBhAfiaP7GNqNV+Jdvn41/Hhe3ukTBWfYB1gJd6isIXSIP/XYMDfunfmi
         egJ7gPOfrxxEFNdnMXvGFeoFT9BsXLm27Ty567UmCkJOQeIO2lw9/gg3gvwxEzcD5AUM
         Tjfo7dOZOb/LzAzls54fgK8PVYc8sqh91oNSW6XyKYpPskexd50qCOXgW8QZDrkTj93D
         qBa/0mixDUZxUaqPWE5oIJwhY4AaOpTCKk/i1CHbKBgkUzcBOC000z9bX4p4JdQRmnRY
         1D1dCec3l9EoC+dxqCRNro7Az0PQ5HgQY+wLcnpdx1wJZLxUUuuaADj4jlEFeC2ExxG4
         vipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680701762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VggWtoWbZcPILk7ArjMga2p++PX4pdis5t7T53gcfGY=;
        b=0t/dW/xaCq5yIHs0Z6Y21770CQ/HUx7rFfD9JNLO8dCJDFZPfSbRv4u47BrHrbefay
         pK/v8ch92czhZn4JvaYiAgHOtd8r0sfrM9w+Nbb+ivKzZzdhgQCCrXUMq8b6VUSiTi4R
         UKiVASPUyYrmdkWRH0TDVp8HsQgCNDEx8uEEzBH/75huaf2vvhPkTa4uk9BEkqWSk8Ff
         qAzwc/do0VEjeuFJe2WV/KAUG8tNjbLZamcLngV5zetjrrsu05cpTyyGb1bMX5+PodO8
         2kwT5rPXa+TGs7yD8s73ecBl51b4behUJDgFDr20sRlBBed1vdiihtJiw2LGMzLgfLYY
         u/5A==
X-Gm-Message-State: AAQBX9fIIHtlk/Q6S8bWep2Qbm8ZTLSQRITlubjgphV62Z+1b1Gapgn9
        GZoc66xftF293EUvfJdmre1fQR6AA25C41zddfuwfScb
X-Google-Smtp-Source: AKy350Y46r+bk5IGbQuCHlZq9uL3JezlK529SPLNisbLTHEfitIhqmIgahTRs9ocZMbKagXrxsanD41SQZxGzf1f7w4=
X-Received: by 2002:a25:d285:0:b0:b4a:3896:bc17 with SMTP id
 j127-20020a25d285000000b00b4a3896bc17mr3564223ybg.0.1680701761847; Wed, 05
 Apr 2023 06:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
In-Reply-To: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 08:35:50 -0500
Message-ID: <CAMP44s0eLNOWFr7fc6M5Fompw1Y13vAxk8=fAWVZ8-22Y-xihg@mail.gmail.com>
Subject: Re: [PATCH] global: resolve Perl executable via PATH
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 5:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> shebang. This is not a portable location for the Perl interpreter and
> may thus break on some systems that have the interpreter installed in a
> different location. One such example is NixOS, where the only executable
> installed in `/usr/bin` is env(1).
>
> Convert the shebangs to resolve the location of the Perl interpreter via
> env(1) to make these scripts more portable. While the location of env(1)
> is not guaranteed by any standard either, in practice all distributions
> including NixOS have it available at `/usr/bin/env`. We're also already
> using this idiom in a small set of other scripts, and until now nobody
> complained about them.

This is standard practice in Ruby, and it does seem to work everywhere.

However, I wonder if /bin/env does also work. I can't imagine a system
system providing /usr/bin/env but not /bin/env.

--=20
Felipe Contreras
