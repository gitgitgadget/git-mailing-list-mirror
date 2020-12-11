Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD9C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1CF23105
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393914AbgLKAR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbgLKAQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 19:16:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB7C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:16:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t16so7287858wra.3
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNn4p5CUtJKoDrVQZG/IDS2W0KtwX5tS2TknBOE3Hw0=;
        b=Ty4jGSNukGNu8IQSun065to+sNbc3+jmqKPxNcyGNye7uD3/TbCe4qIwCUyvzhZaj0
         aB0X5NfMiSgC0g3jnTtEtcZVIaNH0HMYEz9rmfOMeLBqNxPL9xQiafgFMagfd6Ntz7UB
         XA08Rv66EUPL9DHwyeFOY1KjM63byW/g59Vz8h2ishkJWA5+uYLv/z+F8KrnMMeIk5F8
         O7xOhW+lCtW6a6smC//EtyzInzHzwDgXz/V+Mcf7HCeinPc1ckSgxWtdk9jNkcDSd/5n
         3aaNwAm3456aaHLXWy7MB/AMa7bDbP6uLv2KAw2Nq0nqovJSNqgSa2w2ywOCByrx+vLY
         pWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNn4p5CUtJKoDrVQZG/IDS2W0KtwX5tS2TknBOE3Hw0=;
        b=s6oNxFXJfST/AdToUI109yGaTxhXD70xdIlGbRTQkBSA2Pu/NZqQ+w1qqiCx0h2OeG
         BkWZCnfAXDaXAIfI8pwZiJYXSShmtUteOv5kMWHL9q0f0ISYVtnezlgjNmwAKUjoWk4x
         /OFQDlcOTu50TxBcRYBYkkBo5o8r+wyD678k0kETAFgylDbgVSFMgM+7OoZkSRle+FOZ
         1HV4mTBmvbq8zPfVbwfVbzCkINdLTuIO6cJQXuJYhnKFxhi9EF/CuMI6gR5pjKN04Pz0
         Mhf6FUDlL1Z/+LRR1TTg9W3diM1dGguj9RiQP5AL2m+gwFAcrx+z8LXzCTkyGnYoT5zn
         Vtng==
X-Gm-Message-State: AOAM532fAmBH4olBdJe+rJ2htK/Mu6fiClNT75+6hXD6hI1oUBSZGqQE
        9zjOt5gJXeGszYvnpP3J+VqznQFuPX7ry7arj1Q=
X-Google-Smtp-Source: ABdhPJzoo8QGTo/vyBXcEmTkcdRYxtdvQL+qCJ5ErcrRNJLzgcMJreclVShTdoW11bLR9lk9uaq24xm0f6mesN25x7I=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr10904042wrv.255.1607645763608;
 Thu, 10 Dec 2020 16:16:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
 <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com> <2f21c505d560132b4563849f955554fc7d79a9cb.1607637517.git.gitgitgadget@gmail.com>
In-Reply-To: <2f21c505d560132b4563849f955554fc7d79a9cb.1607637517.git.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 18:15:52 -0600
Message-ID: <CAMP44s0mEsfmc7gT6Yv10_nt8d=HrbETmnwNNqxVmRGdHSOHYw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] init: provide useful advice about init.defaultBranch
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 3:58 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> +static const char default_branch_name_advice[] = N_(
> +"Using '%s' as the name for the initial branch. This default branch name\n"
> +"is subject to change. To configure the initial branch name to use in all\n"
> +"of your new repositories, which will suppress this warning, call:\n"
> +"\n"
> +"\tgit config --global init.defaultBranch <name>\n"
> +"\n"
> +"Common names are 'main', 'trunk' and 'development'. The initial branch\n"

This is disingenuous; the most common name is "master"... by far. In a
couple years this might change, but not right now.

If you don't want to mention "master", then don't mention "common
names" that are not really the most common names.

Cheers.

-- 
Felipe Contreras
