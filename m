Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CFC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 02:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiCWC5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiCWC5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 22:57:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898370848
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 19:55:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o10so273601ejd.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1oXMUjQAsReH1W9jJcEDp1cur0zRoA6/NKx83NgYum8=;
        b=AJqae6nJofrRkV6vFENoI0IKFetnnx7oOYJUOWW+6MEkSFnynk4P4jUVzTVr6uqs8l
         rGt8E4ibDYZnrSG4Fhgtm8hshzPwt2G/YZyNJnpiRkvLFQlqVbmp619rn/oImqQudurX
         l1tJRsinN/s7KfL6tcar5BsU+LspcjxwsPdqHK1iZNeh6h0JZsRhBMYuGQtbylZTrWQs
         Xa7A0flfaVozZA5S86cCRmnpcnX8x+Bc/FPCGt7hwhTPTYl6KsnfD3B638RPyuUi2bHQ
         vJU7r5sV3fQA0QRmGxWOpf4CBCeQEbVP7hn4M1jxYijmHp594kZES5RK79Nz2+VXcM/N
         sgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1oXMUjQAsReH1W9jJcEDp1cur0zRoA6/NKx83NgYum8=;
        b=HLA+hEDYJ/QW4h9UL8vq12tPfHDcoGV43zl88CXTrveEk/9oAwqg/SlV74PKiFfSos
         2SzYaLGrSY0F3oHelzqI0L9LmBqjYax4OIAUkcUqHLAwwnTgleIAXuoPhfUW6sD0qqjJ
         YoPDPXRMoj8cPBNeE+nRtHEj83yweeUxK3H84p4tPDSzCMQB55d23+6hJT/9tYGcquch
         VsIkS1cJcI7Uf00uwhp95+PKYJfJv8UpVy73MXztvo4wkLH3hPEBuFa0NQPdKtlW7q6K
         gZg6cV+H3R/MwlxA/ddlh+yrx6IKmL0lp2KFmgEpP0vEBwcTzlGURqG88yw+uN8LIe17
         x+vA==
X-Gm-Message-State: AOAM530SzxpruczTBP08erWZnkWu9dtxFlp2/LqzhlRYkiQbjlXQdeI4
        xxZt4dlwr48/yWyZG3qO9NcGo/hQsVU=
X-Google-Smtp-Source: ABdhPJzbq8O+zF1JYKBRIcilUtatyhQJc3p/JAwKnEWn9vxjdaLi+7KBg7go+AaDCdd4qq7Na9wuXg==
X-Received: by 2002:a17:907:d04:b0:6db:56be:ef8 with SMTP id gn4-20020a1709070d0400b006db56be0ef8mr30439055ejc.188.1648004139132;
        Tue, 22 Mar 2022 19:55:39 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b006d582121f99sm9105538ejf.36.2022.03.22.19.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 19:55:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWr9t-000S73-7A;
        Wed, 23 Mar 2022 03:55:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Raphael Bauer <raphael@pdev.de>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: BUG: %+ format placeholder and colors
Date:   Wed, 23 Mar 2022 03:49:00 +0100
References: <6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de>
 <600744a4-8d5a-0ef3-6e75-e3637e7070aa@pdev.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <600744a4-8d5a-0ef3-6e75-e3637e7070aa@pdev.de>
Message-ID: <220323.86wnglnzrq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Raphael Bauer wrote:

> Hello,
>
> I am not familiar with using mailing list for bug tracking. I already
> reported this bug, but got no answer, so I wanted to mention it again.

There was my answer at
https://lore.kernel.org/git/220222.865yp7aj6z.gmgdl@evledraar.gmail.com/
and your reply at
https://lore.kernel.org/git/6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de/;
Perhaps not the answer you wanted, but not "no answer"...

> * What did you do before the bug happened? (Steps to reproduce your issue)
> git log --pretty=format:'%h%Cred%+d test' --graph
>
> This also happens with a PAGER=cat environment, just to preclude this
> is related to the pager.

This example also renders differently under PAGER=cat for me. I.e. it's
the pager that's resetting the colors, but maybe I'm not understanding
the subtlety here...

> * What did you expect to happen? (Expected behavior)
> A graph listing of commit hashes and, if ref names for this commit
> exist, a second line.
> This line should be colored in red and contain the ref names as well
> as the string 'test'.
> In the case of no refs, the string 'test' should appear in line with
> the commit hash, also in red.
>
> * What happened instead? (Actual behavior)
> In case of ref names / a second line, the color is missing completely.
> The colors work correctly for the single line case (when no ref names
> are available).
>
> * What's different between what you expected and what actually happened?
> The %+d placeholder inserts newlines if the string is non-empty, but
> in doing so, resets any coloring information.
> This is demonstrated by the string 'test' which should always show in
> red, but does so only if %+d is not expanded.
> This makes it currently impossible to color anything with the %+
> placeholder.

At least for me a screenshot & a link to a repo you expect to run this
on would really help, since the output is very different depending on
branch topology, ref names etc.
