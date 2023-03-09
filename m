Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B1BC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 13:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCINXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCINXk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 08:23:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B553C37
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 05:23:38 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id n18so1832653ybm.10
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 05:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678368218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERtGb4/rPzVNJ6ffQ0k/tck0Xb4Gc2+VqQh0irQWHuE=;
        b=cpTJGaN7KbRGey/Kthd6OQ+Z/+uMUKQu34XN8Hct/JrCIlWjYVnPxHeWxy+FYOgBHo
         08HmtXqu/aCmwJD/PZUcNgD2GBdzuv003xdkteM+rL5Wwvx3ECGoFwF+ypqgV28OxM93
         fTwLj9TEiwlwpUu5h6+y01H3lZ1o46UgdHKNFl4xpgNKaNMlruR/VhATnWTOHVPZR9Wn
         h8IhTY0lIjBbPa/2t4Oy9Rl6yL6cqOG3UCJ39RQyy+b7zIu6xy7j/NF0oPwUiNriOsHi
         JUzti0Z4LdD0N499QIIORgp8KS3PSBOZ3vumhRBTVYADLx7Qk8tRwv51JgSO0T8HzIc7
         KM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERtGb4/rPzVNJ6ffQ0k/tck0Xb4Gc2+VqQh0irQWHuE=;
        b=MF+e5SoH4O/SUa5OABu78w+pVGhVvWFlR/Has1eDYtI8eukXQVKA1niNjQinU5Ojte
         EcEuDPJ/Ynxay5b4LNMsgBQ9scePLoCd4tQ4GYTqoZdPx7fGdBCb2aB3r28ablUSAm5p
         JsjLeeXWuO8hQEpNPITH+Cu8wwx0JGtmH3Kf9Z+0sS94Yvs1OoApK/qPvoaTUg0scFQR
         xsHKKaaybZt6s8HycfQFzLlLms84afzx75JRWuX142bsf1C3yyJeKzh/H90A+2ZO8C6K
         zMyWNWi7OpmkRHD0jyKYO8gAn4cKv9Zb9DyRZ/k1Ng7M3yEdpMaIuGRg91m74bEuFSfs
         0myA==
X-Gm-Message-State: AO0yUKVJUoUoh2/nwPgm9CqwuMCy7H4vYunms2CaGdjV1gUuGRQvV01i
        SuXqCkglh5/KPpOQBZJm7VURQuyTBZth3VleLEwNgoIi2tA=
X-Google-Smtp-Source: AK7set+AlqBJtILOCLb4hSbS4lef/KtbL6vK8miieozLDG4vLfU67kbO1mWeEbql9sIl1nwcAZuOs6L8jyqA/S8ywXI=
X-Received: by 2002:a5b:5d0:0:b0:a48:6236:1be4 with SMTP id
 w16-20020a5b05d0000000b00a4862361be4mr13340975ybp.2.1678368217992; Thu, 09
 Mar 2023 05:23:37 -0800 (PST)
MIME-Version: 1.0
References: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
In-Reply-To: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2023 14:23:26 +0100
Message-ID: <CAP8UFD2s12CLDj6tOQAE-KMhog_qPpFUnp5TXHNSZAauue-8AQ@mail.gmail.com>
Subject: Re: [GSoC23] Working on project Idea from SOC 2011
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Mar 9, 2023 at 1:15=E2=80=AFPM Khalid Masum <khalid.masum.92@gmail.=
com> wrote:
>
> There is this SOC 2011 idea named "Resumable clone" here:
>
> https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/SoC2011I=
deas.html

[...]

> Goal: Allow Git to resume a cloning process that
> has been aborted for any reason.
> Languages: C

> Can I work on this idea for GSoC23?

You would need to find (co-)mentors willing to mentor you on this project.

I think we don't propose this kind of project anymore as we think they
are too difficult. Some reasons are explained in the "Note about
refactoring projects versus projects that implement new features" in
https://git.github.io/General-Application-Information/

> If so how should I get started?

See the section I just mentioned. There is "an applicant proposing
something original must engage with the community strongly before and
during the application period to get feedback and guidance to improve
the proposal and avoid the above potential issues".

> I have completed one of the microprojects by the way.

Great, thanks for your interest in working on Git!
