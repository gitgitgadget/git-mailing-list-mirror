Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F8EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjGESoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjGESoO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:44:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2019C
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:44:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-262fa79e9b3so7208a91.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688582651; x=1691174651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpwzz/5AlzMYVBecvZJ5aPxztazwa9XQnWaBm3/oiFo=;
        b=hXEhU8YVDlcEFLTn0KJZ/UMfHwoRBDKQ2OEkyLO7hvQ21Loroh1GeX4VCjmU4C9CmX
         M3yE2S+syPNwtcODUBC58mgK/riK7PwA7sfQQcxspuHGfhwe+2o+da4uJv76Dpb6RbYP
         wTfKnRCnSylZanyYt1gmYsMlMixJLBRULYeajlH9vrLgl/MkEx4+AnAtocHXf+Z8s883
         n6076EqEfxxPdNvohToRX8B1wdjmg1L1tU0PzNaa4tcLdJ6xo91UcywFlUjuvP6AfWR5
         F0Fb8F4UyQusULF/2b7N89SDIbCEQd5714yRcHcgwIk9BH7w/drVTqHunEeNlbh8m+uF
         pvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688582651; x=1691174651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpwzz/5AlzMYVBecvZJ5aPxztazwa9XQnWaBm3/oiFo=;
        b=V7pSBFdDOpmoSnjUcQdMcQ+ImpQiNSkc1KiUlnDM+nDj+uvqGaKJNKEgMm9wsjJUiP
         umJDW9i/0qcFPq+XauRadj1xgRapRdgjNyf8Gah/fCdk1J6oA3Mo4pcPuDNvecQ4dieN
         H/QTMiVjA/DiC1IHIs/7+4vZ8Ea0eioE5W3tISIynbgmr50f1R5pfyNdfQ7RRyrfwrva
         jgW1YN4KSJmv5Z0BjcB6Gv9aBVGIYfzS90sDZVmDSmbTCR17LJQvsRi7m/1mJlZcaO5n
         Qn0WxmytmXl7GVlQVkupdF77srQCECtCBbInLHRW+MGIrJGcJJYutuxgt6lcKKhD/96R
         XRYw==
X-Gm-Message-State: ABy/qLaBDpCTwQegiqwA6vpdunwZMBG9Ksxoy7z4UQsoSXq9lf72XfA7
        Zgxdu5KBd5JFyzR+VAJG/zw9EiqLFmpWxmVyNgUZsQFx4/U=
X-Google-Smtp-Source: APBJJlEyhltBMdhZM/lEXgYw+2NfrbTNmEZxo9sb+9wZrn07unY1gEdJ9/wulljKCpQ0grbyMgmhntcB7ImwUW1NmuI=
X-Received: by 2002:a17:90a:c918:b0:256:8dbd:74fa with SMTP id
 v24-20020a17090ac91800b002568dbd74famr11785207pjt.22.1688582651189; Wed, 05
 Jul 2023 11:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <AN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
 <20230705183532.3057433-1-martin.agren@gmail.com>
In-Reply-To: <20230705183532.3057433-1-martin.agren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Jul 2023 20:43:59 +0200
Message-ID: <CAN0heSqkg=_BKyPP1A-KMUR5+JBLY-HQxzfbUC4EjTjYX0pcHQ@mail.gmail.com>
Subject: Re: [PATCH v3] t0091-bugreport.sh: actually verify some content of report
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Jul 2023 at 20:35, Martin =C3=85gren <martin.agren@gmail.com> wro=
te:
>
> In the first test in this script, 'creates a report with content in the

This v3 has the wrong In-Reply-To. I've resent to the original thread,
https://lore.kernel.org/git/20230705184058.3057709-1-martin.agren@gmail.com=
/

Sorry about the noise,
Martin
