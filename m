Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54487C19425
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 08:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1523423122
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 08:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLFIcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 03:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgLFIcL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 03:32:11 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E0C061A4F
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 00:31:25 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id q16so10325244edv.10
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Q849XMQtkYzb6SQpogVgboTmGqX+JQMGAQR7uOv2+o=;
        b=es+nR65Q85vGC99mgtNZaK828Xe0RGdm9StsUIMztkDXROujhNQbGI8WLZyrFiUC2/
         Par3B1zMegg5onNWDiAdNwEvsX1fpJHmqunHV3hPe2uq1/9cTFSWjKS4rcEnw2P+3Md2
         P/iRZW3FUlw8+NDjE6dAbtWEIRk0RnLHd0qolteQAhtVrnvTlH03bp/+8lbezvF9FJGO
         riajDVs5ftZn2/nKslXEMUmfS6wpuvpu6SgZe76UKbTAyUorZF9XLO2Z2NyJG+jcqx7S
         s0j07i2KSe6KfldcW05LRUqg3A8va6oJ1Yk7Qs/Jx1r0em81UUbUCgxgBT5R/1HmdZlC
         KMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Q849XMQtkYzb6SQpogVgboTmGqX+JQMGAQR7uOv2+o=;
        b=OsLxFdR1botBG7mJuiwPTFg8zP/eIi56Kh0J1abUvABB4EWcNXCGocTo/uKWNrQD2c
         kbvfQmZY1foVjadnTN5T5KkoyrRCvZ1WPXblI+jAEIj93NGPQ7C4S4rXsbIjJhvS27vJ
         tsUaDI0mkN1fY2K68e3bxWhKvN7nQW+XNyc6Yn2//beMg0M/p3KUxXDeQkooXKmrKU0g
         H5F9dWTyZ993Z2LqAdRLpTAA0WHeA3WeqpsWz6AYNvSJg5+AM1LQ+FmP4DVjSJ+8Esgd
         w6m02DuTdKGb587VrdP0ycDGsoBONA8UTGELdC6X0JroZSWgQXOZjTi642ltHNLCKW0H
         KeCA==
X-Gm-Message-State: AOAM533uq+EYZ/QOYcRLhHF3VLl0kcUVC5xK06WwGhqin9b4KCFOrfEP
        N+hS4ecfLIhy0HPjAQgMbNLglQ+7i+mNf/hl/WQ=
X-Google-Smtp-Source: ABdhPJwiKgUtr+qcwLrVYyc4KzJqaHUxzslpBBhSQ02f7ps/UR/6QvNwqbe2WGm6QU5aafjviZC7AOfvqRA4yoXJLo4=
X-Received: by 2002:a50:8163:: with SMTP id 90mr14885532edc.142.1607243483054;
 Sun, 06 Dec 2020 00:31:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <cb3dea224b0776a332c38c6a251406314dfe87ba.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <cb3dea224b0776a332c38c6a251406314dfe87ba.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 6 Dec 2020 09:31:11 +0100
Message-ID: <CAP8UFD1txMfR9KY5U-s+XyROOYGJfrqVRt1DmJn+_7Pa1EXKwQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/19] entry: extract a header file for entry.c functions
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> --- a/entry.c
> +++ b/entry.c
> @@ -6,6 +6,7 @@
>  #include "submodule.h"
>  #include "progress.h"
>  #include "fsmonitor.h"
> +#include "entry.h"
>
>  static void create_directories(const char *path, int path_len,
>                                const struct checkout *state)
> @@ -429,14 +430,6 @@ static void mark_colliding_entries(const struct checkout *state,
>         }
>  }
>
> -/*
> - * Write the contents from ce out to the working tree.
> - *
> - * When topath[] is not NULL, instead of writing to the working tree
> - * file named by ce, a temporary file is created by this function and
> - * its name is returned in topath[], which must be able to hold at
> - * least TEMPORARY_FILENAME_LENGTH bytes long.
> - */

About the above change, the commit message might want to say something like:

"While at it let's also move a comment related to checkout_entry()
from entry.c to entry.h as it's more useful to describe the function
there."
