Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B29EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFZQmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjFZQmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:42:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072C083
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:42:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f95c975995so608279e87.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687797749; x=1690389749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp/4ggvsQOUg+Onto98aMZT4Nwg4b4d9RxduEjqjr8s=;
        b=SMS2oBHJV01ygBMYitd0P9AffiOuQqS4P4Q/C6dX2Jja8Lm4X2xkx5AkoKhQYYhTiD
         tKujoKzsswomzowOdyRda4ucWcFpqE4EAYYqykcaGAzExenZwFy+ElsVyHlYpco/ISfY
         xD025UXS+sAMT3qhRYNw/5YnSqMvQVODzMOEV3o+TNlJpHWaxzSiW1+AqMxvzvBgy/Vs
         C2hAAOYtLXtbk9UrFkhbcPRH2wunGNaoeoRZWD678WceeUuIQQq8Vlgf7Ch0rVeQKHoA
         JFM9F2H+Nf29/1HZyk95uI+ZUWiZrrIt2RASs8giXhbyLjEuynqSRZRKYLIuyQHyftss
         v8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797749; x=1690389749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp/4ggvsQOUg+Onto98aMZT4Nwg4b4d9RxduEjqjr8s=;
        b=PO5qCWNloitzgOt3NapK6jM+3ZQvlqrrrGsIutVhapvUmL4DjTO3LbJUM4g8Di7yck
         lVHLH7gO8zwBzqQ1AZnH2bvubEBzy6PfgyLzIKW8qsk6H8ZU/3sZl9VA5K0ueR0gGjSn
         hzDKXOi0d0LidVJj9iXfKAxQoH3xVf5BUrNSQNs2wmJad8+NtWstRRM62+lVKAPp1Xra
         rQAnmPok/DS5fy8w5fwPjN5M/l+VqiSW41SvjQNDuwOZw7gzjdsvikx5xeBUp3tqBa3M
         OXVbp55i1zO5Pb1CnEATMDpTtLWkLA4/WCqBte3OVG7iCGi4QB4b4PqxJJTOIUFglHaD
         gwmg==
X-Gm-Message-State: AC+VfDw5RNQzSXnkTytSCtPpBY5g1ghJ71H8/j8rETWgXmn3wLhafVBe
        /QuUpx7z/vSS3iECid6I2crU9nbWzcKSQm7IWK8=
X-Google-Smtp-Source: ACHHUZ5aqJuJGhWJ051NEPk1clGHO54pThev6yz5bfG49q80k4eG26gjyaR+QHA8tKAOkDCTzg2d0+JmoWmzV1/wjTc=
X-Received: by 2002:a19:7410:0:b0:4f8:6ab4:aac6 with SMTP id
 v16-20020a197410000000b004f86ab4aac6mr11459974lfe.1.1687797748727; Mon, 26
 Jun 2023 09:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
 <20230624011234.GA95358@coredump.intra.peff.net> <CAHGBnuPO63Hi8mfA+MkAGES-gs0eNCDPG2FcPZT=YsnVzKd30A@mail.gmail.com>
 <xmqqo7l25ibw.fsf@gitster.g>
In-Reply-To: <xmqqo7l25ibw.fsf@gitster.g>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 26 Jun 2023 18:42:17 +0200
Message-ID: <CAHGBnuMjCsMetCJfhfDXb7aYttgUOc0WY+wJ_Q-tmoV4WES-pQ@mail.gmail.com>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2023 at 5:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> > PS: As a future idea, it might be good if "git mv" gives a hint about
> > updating .gitattributes if files matching .gitattributes pattern are
> > moved.
>
> Interesting.  "git mv hello.jpg hello.jpeg" would suggest updating
> a "*.jpg <list of attribute definitions>" line in the .gitattributes
> to begin with "*.jpeg"?

Yes, right. Or as a simpler variant to start with (as patterns might
match files in different directories, and not all of the matching
files might be moved), just say that a specific .gitattributes line
needs updating (or needs to be duplicated / generalized in case files
in both the old and new location match).

--=20
Sebastian Schuberth
