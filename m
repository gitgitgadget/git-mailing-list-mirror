Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC9C433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB05F207D0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 08:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhACIf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 03:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACIf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 03:35:28 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045EC061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 00:34:48 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id u67so5509509vkb.5
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 00:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ki5HgLOnRBc0GKOXoFT/o9S9s//uiJbIx6uZqbzEiCM=;
        b=FaknFN3cgtBPwW7oS9SKgjCFUrEi3f7bDrq7CBPmriziqDjhGEugfCU2pdWIlNdxFk
         k0e9RrXUK/rbmG/YlH8C35ebVLXKEjQrrfKBiQ33BV7IsBlbq3sr4Y3Rnr2rIRA89i/i
         DRktaeRAmhvanOZOAT9MKIiywUbOvicERGYWtAxhteNzy4adzNM88VGdMHSx0V4hXYdt
         ka2h01bXsNeaqy9YMVyp7ia5Z8nzjSpECpCBM71M+nPEOFOxT9GT3FSqa7H6NNain07s
         3rYIN3H3bAVkXtFoUyOXRlNX1JZcyoP3CjRYbhsYh24c4m7RlJsrqVex0TFJ0w7Czj6U
         NCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ki5HgLOnRBc0GKOXoFT/o9S9s//uiJbIx6uZqbzEiCM=;
        b=MY9nQ8h3HUx6Po3YL9dNhevBbNi1mgPe0ZvMT9UMBKwW8jdwlJ6CnLmB2lu/7W6C5q
         aOWBER6T3d3Na0vnqu0driyk1FS56NDXx1hJSqnTCjX+UofXJrOICPZyflo7LRVnJ3mI
         N0/rVDK33zWAZP+3BB8kOiYEvYQlXJHTJFdK176j1Ieas/h+r8D+JYT4qc/gfG+/x10j
         AV0GNAHroVob92OzmKVidVsO4WYR5UJ8Qmb+LuqMZvpCmTt2fX1MQWCfbydvuih8QB+w
         8WaWv7FI2H9/RQ1AFlkwu1BvB6TOR0VyMqclK+26cyb+MoP233t4ZrT+o8OxIraFTXgT
         1ybg==
X-Gm-Message-State: AOAM530Qs4yR+p098EXoUki77aDc5lKsnAMtkzZA1e2uDCegHYNXP4s8
        6BaX8vYdh9g2QW1V6tHJT2YTCUMsIH6b4wkKvO0=
X-Google-Smtp-Source: ABdhPJyL1n3d2q/vpMzRh/zFzqg4/HA0Rjwe7BeFhB92LwMUulSyf9zW+mKqhM3eW2Sruu7UC+aK3EGDogMZth/ZL9w=
X-Received: by 2002:a1f:2d01:: with SMTP id t1mr41725539vkt.8.1609662887042;
 Sun, 03 Jan 2021 00:34:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
 <CAN0heSqC3K6pJOr2ztz56+ZpKaMomA28rc4W5x8n0cC3K-rVgQ@mail.gmail.com> <5ff0ef1332a66_a76d2086d@natae.notmuch>
In-Reply-To: <5ff0ef1332a66_a76d2086d@natae.notmuch>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 3 Jan 2021 09:34:34 +0100
Message-ID: <CAN0heSq8Hkq43mn06o_vxQD_FW3zSg5YSFDAtuONsFAvbNiNuA@mail.gmail.com>
Subject: Re: [PATCH] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Gustaf Hendeby <hendeby@isy.liu.se>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2 Jan 2021 at 23:09, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Martin =C3=85gren wrote:

> > Good catch! I wonder what we should conclude from this having gone
> > unreported for so long.
>
> That perhaps not that many people actually read the official
> documentation?
>
> I've noticed the common response RTFM is not that common anymore. A lot
> of people seem to rely on Stack Overflow, blogs, and some semi-official
> documentation (GitHub, Atlassian, etc.).

Hmm, now that you say it, I think that matches my impression. There was
a time when that seemed to be a really "in" answer, if not always
entirely friendly. You're right that it seems to be quite a bit less
common today.

Martin
