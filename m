Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2340EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 16:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjF2QGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF2QGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 12:06:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC41FD2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 09:06:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6a152a933so13175551fa.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688054764; x=1690646764;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=brYX17CAKS4Zvfuvmiu77VyMH/gcvJD4gPQmt5UuExk=;
        b=EMTC5HtG1Kgq3v5eCNOjzgHmDS0WJoga+npX0eqXhoGoUZPPTCb+wVQLLFUxDltwDs
         oK3ARZjFUl/sA8p7OUt4BB7qXkHMoQKNujiJEvRKiNsRtYrL+7s66Ygu8n34z8lN7hfU
         FouG/Q5BtfoDveHbsaHYzzx4YLOoreG/AhmJ/UbjLB0QR79EB4jrSiAEpYFFE+o5zrG2
         GYAXoCJsGbfCfsH1zvd0IszAwsZhQJZn6OMLj9SNry5LAh724YKky0vuKlVwTrgzFcof
         xTrgfyH2BN63cLc6E5bOlgm7WYePy3KHcjPMRaE4sFCDf466lMXx08CfBvR/b0fKilBi
         XQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054764; x=1690646764;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brYX17CAKS4Zvfuvmiu77VyMH/gcvJD4gPQmt5UuExk=;
        b=dj04wFIgQ7TYWpjaTdCdD29rNlyzB8eYl1JI6Uevpri0bXqLj7lJ9SI2DFB2oTkPNP
         4ALmaoYu/v19n2qsED3RIF8rOiCDybjcPzRG3SSqF2omF1WJTQvC4ulbtL4R4DRP54Nv
         h9iVGwuag4iIJbvc7RqoScaKkdn9ymcAz2RRTWt77C+/zYCoVyk+CcgfQWFP1AVDLHJv
         /h8acHbEcGGTDJ70ikdeaLz80Q3j+xDQ4S1TnkLbFpHWEbUln+raTAVCWKvuezu5k11K
         2VN48hGy8f1fiD8rqzMJcESGslixgqHZneGXsvid05b55aQNuT35plqjLRyx5F1fjLVW
         6anw==
X-Gm-Message-State: ABy/qLaobnmAVD/XmP7NofS2KGHNe0qaA3qahcFZSkDiB1cMRoUwbXnd
        AZMBVt6z0iozdDOs2IcrjMv49nNcVlKbCWgVWidZN2/e
X-Google-Smtp-Source: APBJJlHmjwVXQ8k0O2kr+la2E1VOCtYlkcqEcUYH4QTjAj9uQ1EcgiwmN4ZK15KXDrpGrgBdnLQ9PON5tfwPgBGjElQ=
X-Received: by 2002:a2e:b046:0:b0:2b6:a630:1e7 with SMTP id
 d6-20020a2eb046000000b002b6a63001e7mr115601ljl.37.1688054763658; Thu, 29 Jun
 2023 09:06:03 -0700 (PDT)
MIME-Version: 1.0
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Thu, 29 Jun 2023 21:35:51 +0530
Message-ID: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
Subject: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there!
I was looking through Documentation/MyFirstObjectWalk.txt, and upon
building the branch containing the given code, I find that I get the
error that C99 does not allow implicit function declaration where
trace_printf() is encountered. However, upon including trace.h the
error disappears, and the build proceeds just fine.

I did put DEVELOPER=1 in config.mak before building, but it doesn't
seem to work.

Is the error pointing to a problem, or am I doing something wrong?
If it is the former, I would be very happy to send a patch fixing this.

Thanks a lot!
Vinayak
