Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE1AC4167B
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 14:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiLQOwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 09:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLQOww (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 09:52:52 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6979713F8F
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 06:52:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so3048776otb.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ1FtX0fW7RtRf/2INuoKOMilH4yrNOAW/2FG1Ty/Wk=;
        b=QfMQ1iLYOqxzgtrKTqEQtviwU6m8VtE1DeslXCsie40A5hMMJ2Xxg0fBYMXP/FcDT3
         r20P7KodP/EC/BwbA8MCXpTUM0YdAZC1M3++SgCchnfVRFE2Gr39hlsSb0jnQ0fTKiny
         2ehHN/c0UuNneoXQBKY3sqZmMskr9YuoJyetraToc4/cvE1xGMumW1/rBITF1pFin+qx
         /6M6PJhrPmaykaRohBI6ZPi1OmzPDA0MZA3KponrSFYEiWXioZeaw81BuHmv7yIP8UMT
         Qa3kTgky0FU2ZeSAO0+/Mt0OEgzKnWk8TxLH9ctOVgHBwrN5w0SatQxoQ00BDZt0FPgW
         3Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ1FtX0fW7RtRf/2INuoKOMilH4yrNOAW/2FG1Ty/Wk=;
        b=06ac62gldr6CVfGAZrit4sSextxWIJ2Xv44np81Tpa8NnsnUKA+YYGN6oYK1riKIuF
         0LRojkdYJxTvgSbjUKuIbO0qAOHrofQMoboYZ9ANt9OBvt+GlgGYsyA4yCN4BCMqwOT3
         FVPoWf5IGiL/sARECBRE49ZFjUKGwTc4jqsJQrzVbtzSO6TC+3FtQ+BrN0eOMVK0b5Tb
         oDGwPoX3O+aNXOkC333SnqC2w5UqcysIDrlk9CffzhbOTkvESTjkhUjmfL8u5hgcgt4L
         usqpax7w0ieoTsNaxLjJ6eabPkPg3UiXrIgBhCn+vNGjt/y8Q//0kmRQPOJtl7TUC18P
         rxUA==
X-Gm-Message-State: ANoB5plPma96vCr4KMzAjlwr3XovLqV4W4JHksJdYreHSdQz6BSG2Mgy
        9gbwFcw4tLrf2VUtVZt4FLRxl/fCSs5DxBdzJyXl5JCpPg8=
X-Google-Smtp-Source: AA0mqf71ylMqkP6yc4TK1wtenZqx2duV+NPAXKR5ubHsumc3tpcdXD9cQ07doiX2ImcoxonWyK3nnZxNjLvpfdvIEec=
X-Received: by 2002:a9d:550d:0:b0:66d:6909:e477 with SMTP id
 l13-20020a9d550d000000b0066d6909e477mr49566565oth.114.1671288769267; Sat, 17
 Dec 2022 06:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20221216093552.3171319-1-karthik.188@gmail.com> <071e44b5-607e-0db5-af90-85daae81f611@dunelm.org.uk>
In-Reply-To: <071e44b5-607e-0db5-af90-85daae81f611@dunelm.org.uk>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 15:52:23 +0100
Message-ID: <CAOLa=ZRp+JjFbdhyv9wFLyQgKmQN8p6xwUsHe7=254_q6xqPxQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, toon@iotcl.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2022 at 11:53 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > This is specifically useful in bare repositories wherein the gitattributes are
> > only present in the git working tree but not available directly on the
> > filesystem.
>
> I was thinking about this and wondering if the problem is really that
> bare repositories ignore attributes because they don't have a working
> copy. If that's the case then we should perhaps be looking to fix that
> so that all git commands such as diff as log benefit rather than just
> adding a flag to check-attr. A simple solution would be to read the
> attributes from HEAD in a bare repository in the same way that we
> fallback to the index if there are no attributes in the working copy for
> non-bare repositories.
>

This is actually the direction I started this series in, but I soon
realized it's also useful
to have a more generic version (which is currently what we have in
this patch series)
which also satisfies the bare repository scenario. It seemed like a
natural extension.

I thought it's also useful because it lets you see how attributes
changes over history.
