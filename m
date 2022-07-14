Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFAC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiGNJuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiGNJuU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 05:50:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE532DC9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 02:50:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 23so1062120pgc.8
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 02:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=sPNkAMkJGBUMb1tZRaAO5KtFr1H1xIJJmzk6O1j6pGk=;
        b=QlfoU/JwTVs8HYmz7rb8DRfmPBsV7bkoWiEE6WD67fkM+gehNBTTeNCT+Qgoyt9KtY
         IAflhviBp6Zc4lycraAfnjDbN6XXNG80aPlIkUMni6qWMAmikOr8C/715BUUBrgxKR0V
         mtuYmjEnAQUHYOzC9vSgAkRe07K2dnRtSa099/ZCcBIufdtSNYoroEThSHXqwYi+vigW
         kgSt46dwWwuCmWIcoVOHhTXtVyMWrOjnHSQVLPMk3CExTnHytHVC5NyikI/CvwYdwzuz
         H0hfo7xGLrCs1P+3U4E9rN+/ggaxR74gv9pjHqWPSxKNLDbZz+67rC5MYOXh46uIz7St
         NnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sPNkAMkJGBUMb1tZRaAO5KtFr1H1xIJJmzk6O1j6pGk=;
        b=FWHkOI1yllzoQJNRNgjw+T2cDkQRqR0Wej0eitkqcMs9WZ5RtTX5SFohT4zR4+c0rL
         LnMweZtPCAMZlLgNWODPKXnWzt58b+tykELKPTtrHZQ2ra5CiP0hBRso+2Wo11GFdDxq
         JZTIjkDfGGU5pcWgSrCpPOm+XTEyC4uFDAXLU7mMRKtovn4sg5BobxtlVamU9xu/wNBe
         3JwKGZW0BHWayFZDUgXzbfIO5p3vCF4yrdh0/DXtuq8J4BM5yXGVBHjQ+5xs4+7RYFjn
         SBBY2m3EfZQhB1DCrG8TXG4GsX76BAGO0gn2ogTMnvSngJVwf77/Kn1dYClgvYr3DsF+
         llyw==
X-Gm-Message-State: AJIora+HQcIVzaur38oZFK6DeDOLth8YuD5/Wq94qM63Jf2UFFVDzJAq
        qvocrE0JotKxJ+5JFYfFNQIgJc0OyYdyEGeswp21TalpNe2N4g==
X-Google-Smtp-Source: AGRyM1udwqkaDHKs/22MkJ7qckz1PYfSmiii1OZlUCPmZwWyjkQcsiiOX1HXwrWgKXIugCKaFUHtwGTDesxslRbr7NI=
X-Received: by 2002:a63:1b63:0:b0:417:b4b6:1cc4 with SMTP id
 b35-20020a631b63000000b00417b4b61cc4mr7015631pgm.573.1657792215210; Thu, 14
 Jul 2022 02:50:15 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Antonio_Caba=C3=B1as_Zurita?= <antoniozurita99@gmail.com>
Date:   Thu, 14 Jul 2022 11:50:04 +0200
Message-ID: <CADxQiQZR2pM4F3vizq_HyM6xeZMRHstNHPk2rXuux7LgqWkUfg@mail.gmail.com>
Subject: Create Remote Repository from local
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm setting up a git server, but I've run into a little problem.

It is possible to generate a remote repository on the server from a
local repository, or for this it must be created on the remote
(server), regardless of whether it is by cloning or by remote add.

Assuming that I am in a newly created local repository I have tried:

Do a git remote add ssh://git@git/<location>

And I have not previously created a repository in location(on the
server side), it returns an error that it is not a known repository in
the destination.

I do not know if I explained well.

Thank you for your your time,

Cheers
