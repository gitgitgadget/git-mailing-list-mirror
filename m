Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F805C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 22:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjHJWFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjHJWFN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 18:05:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3292684
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:05:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso1478761276.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691705112; x=1692309912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwvC4BCGCx8y1TjtLqI1BK7RvHLirflu6Juam74hIKQ=;
        b=uRR4YU6P+dRVGpXToPtBk7z5uhGBHlIytftHs81yOH8puHwOpVP6bi63i4tL+1CISG
         5488MrvhMExyUwGuHsbDqFgQIl42JTUXQMQ9coVc8qvOwD0q5PaDaADDlcStOm6a3cw9
         JqOXLXFvRifPgaeg9DL55jZZ1+3CY/BQxV1lW92BpuKP6GADedJVLN7mK8lS6IlmTiAG
         usZ8Zp1AnYdlylg3n1SMQn0mHFp8Qyg6FJmYu3aV02NW7tzGCyudn/1LwkTeZhVLue1p
         MaasBTrJ/aaoGooQISzONuZ5UWAXtES5/Evi0nLULvZOR6QIF5Hmy/ok/Vq8gXRmlfxv
         4ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705112; x=1692309912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwvC4BCGCx8y1TjtLqI1BK7RvHLirflu6Juam74hIKQ=;
        b=XzF61cTwDe/+png6opsErq6KMtyUrxSDBfAzXD+qbTsNrQ8z8Z3365SP38kjJ/YIbW
         bAVgTJH8fbNhMzWlU8HTyldPWBcgZ13D8kFuBVyKAc9qBhEI7xu+oSTWGaLhI82dWHae
         FXpRPb5719inQgdVV4ARI4DrpBnTGCDDkN3EoUGdvw6a+0y5kNYbVEAJO2pP0vKf54YR
         90Mc4AQ4WhN0naQTKQjr8PIvfKorsMbumBIVk8P+85vyiQw+kYmZlujqtyqriP2liPCi
         ILHGUPfKuD48Snuv6PrigOPYy/WXk0JTzd9lqD6ec0qE5/Z6HIHSs2yRIry57Rmtq3sG
         4g9g==
X-Gm-Message-State: AOJu0Yyn5RRhU2MyRojtjmI/r4YN9/2OiigdymxpO9iOQRZP9JRI+rz3
        FeQbkLdsW01M2i4+rc0ML2U7SA9Jmza9Kg==
X-Google-Smtp-Source: AGHT+IEVa7lyA8HHwSUk2PBwu+2B7ZaGD1QYCF2kAxigYPqEw6s3Z8VA5V0vwhuRuYjHwev/Sc7kJfAuMnQymg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:ce53:0:b0:d0c:ca92:1b92 with SMTP id
 x80-20020a25ce53000000b00d0cca921b92mr258ybe.6.1691705112799; Thu, 10 Aug
 2023 15:05:12 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:05:04 -0700
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com> <20230810163346.274132-1-calvinwan@google.com>
Message-ID: <kl6lmsyy8sfj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2 0/7] Introduce Git Standard Library
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Calvin Wan (7):
>   hex-ll: split out functionality from hex
>   object: move function to object.c
>   config: correct bad boolean env value error message
>   parse: create new library for parsing strings and env values
>   date: push pager.h dependency up
>   git-std-lib: introduce git standard library
>   git-std-lib: add test file to call git-std-lib.a functions

This doesn't seem to apply to 'master'. Do you have a base commit that
reviewers could apply the patches to?
