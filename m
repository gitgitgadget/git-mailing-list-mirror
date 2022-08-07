Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB125C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 00:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiHGAzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiHGAzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 20:55:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE31028
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 17:55:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so10831506ejp.13
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yjf5f/HpD0XUFwqeyJy5cpF4WV7dRFjgA0pAx0qzNfc=;
        b=JPX0zNtNfcgFZEM9BxPYsgt9pORcKVGV6x7C80Rhrr8dExenI40W7jV9EcsfGg7lB9
         DnwzvJqNqQH3gWF2AInISb1iiuKSSpzzdctiNTmI6hmGZp1qulSz8OqSFNfVc8OXqpQO
         Uh2HOy/FqVK0JvKAgsteb6JkTb/wPu7GHmUg1bbLvcBYPJGfwfQ9f8BFOuaH/aLm92zQ
         M5c+CNnO66UR7rWtzZ5SXgfQnX5/NbHzjAH0TsxvVBtD67cv9oICLpliAopNJw5ZJSuQ
         thhyE6NPFz2KlVrGSPiRbmcvYjj8bzCG81RdjlBpCdnFrWG0Ixx32eL0ZL3g5utbe8At
         6JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yjf5f/HpD0XUFwqeyJy5cpF4WV7dRFjgA0pAx0qzNfc=;
        b=1Vhrr3/NpQwVFnHMXkS/hXCPGoMwI5VLR5v+4yx54jL6CAaHW9GixE0dKKNBKBdD3U
         3yBItLp/9jl9NIN+LH0uksO6kF+WAjBHGmou6yJz7UAtr9YKHk0PlU6a+qeO8izK0T/2
         Rz90uPf7bqpYZNOzYsPnsdu6WN3t80yp4e5WP+306Yjla4uMf9EQOgY1VkAMf3H1O1BX
         KSrIeCSi5UKOGQIRdYiU829ry1gACjLBbrQ/8gylb643VHyN27RSpWD21McRf0fJ37RA
         cUwuR0LPeG/DNYvCUsjQfYQMItIT+3hdT3uvMQfH51gwcfq6djfqngGE5pgDqFosXtiq
         0oyQ==
X-Gm-Message-State: ACgBeo0nr/IpR5gSbKo6yC/GcjfIp6eDwJT5dE7mcDtvNBZ6l7jVJRhr
        jMRPk7dN/2KoVbGtivmBlwy1kbheV+05wOTHPi9zFelC0Kg=
X-Google-Smtp-Source: AA6agR67GdAe1txser50+EdAljRHC4YQMCV4C8gr6krBSijax6OemN/UB6RbO+6+5xq7co7Mjr/IxDYbA/UbxmjHIHY=
X-Received: by 2002:a17:906:ef90:b0:730:9d18:17b3 with SMTP id
 ze16-20020a170906ef9000b007309d1817b3mr9669779ejb.141.1659833718087; Sat, 06
 Aug 2022 17:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <Yu7ccuxYATwsJ7CF@zacax395.localdomain> <20220806213005.92045-1-greenfoo@u92.eu>
In-Reply-To: <20220806213005.92045-1-greenfoo@u92.eu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 6 Aug 2022 19:55:07 -0500
Message-ID: <CAMP44s0QjKzt7VNFPWAi9RKThP2H2VP=4hYiDP4X9-CzrmYrew@mail.gmail.com>
Subject: Re: [PATCH] vimdiff: fix 'vimdiff3' behavior (colors + no extra key press)
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 6, 2022 at 4:30 PM Fernando Ramos <greenfoo@u92.eu> wrote:

>
> +               # Add an extra "-c" option to move to the first tab (notice that we
> +               # can't simply append the command to the previous "-c" string as
> +               # explained here: https://github.com/vim/vim/issues/9076
>
> -       # Add an extra "-c" option to move to the first tab (notice that we
> -       # can't simply append the command to the previous "-c" string as
> -       # explained here: https://github.com/vim/vim/issues/9076
> +               FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
> +       else
> +               CMD="$CMD | set hidden | let tmp=bufnr('%') | silent bufdo diffthis | exe 'buffer '.tmp"

NAK: This runs `exe 'buffer #'` in every buffer. While switching to
the desired buffer 3 extra times isn't a problem, it's also not
correct.

You need something like:

    silent exe 'bufdo diffthis' | exe 'buffer '.tmp"

But at this point it seems like we are working around the current
organization of the code, when we could simply reorganize it.

Cheers.

-- 
Felipe Contreras
