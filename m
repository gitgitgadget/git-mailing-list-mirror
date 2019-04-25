Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACBC1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfDYPzY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:55:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33599 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfDYPzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:55:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id s11so191236vsn.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdsUGb22EawLsJTPID0XWGRL4thRDJgksT2HzocUJ+E=;
        b=SE7RUTDTvnxFkjbJ80Xllks8U31tBQYX5dI256iwW4LcX1LUpbuD9ENDK8wxRZV2m0
         zO9tqIZ3OKFhzDdAQLvPxwoxv6ZyujVnwc+QO9xoGgNQ1bpSZEsYfkb7s4pmHgvuO/El
         oGFBiBweBtuUJ8/725z25UNlSQmRpz1cwnLZR9aSzaDeUwgkqPqcwlZREKcZBrTwkOUi
         aWBHDBj90E1J6kCo57KCBek58sMaA0vvLgYR678IDUDhrwNh1Xe+lkopvXB4ph4rVKHy
         MpqfadNtrN+lju6yVfH1fM+OYXwon/WbLmkAy4+9+KWqyQ2ScEz7cNnuM0VxSN7Uc4JL
         FkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdsUGb22EawLsJTPID0XWGRL4thRDJgksT2HzocUJ+E=;
        b=NybBp3iBOiRWp5E88pptndNPtfksAiNpXqvzsGLzNLlh49KjtnhaOXQcz1rKYgf6jx
         1m3Tq+h4BkVISwR1qRZVHI8EtDvVanlPk7kyYzWJS7ms846Ny/CsyHgp5L3Ho7Oe+J8A
         jsjK8rUHebcr/KDJzyYW2ELrhRnwKGwHKKG1MtJSaoieFuxh0JLrPfF/NFt/k3RL2CkG
         7hsHfp9kui+ylaKgf0OETxDYvvFxsUVvAHMDJjBbaw0AfAtZ9T7C3RbJWSTezR+bGZMr
         PIKdOIMC+ZSUN1ILSAuzafIVygyJyDM6Bq9K6oVLPfKztqw/wJ+5hRe/hmspgoGhU6IA
         +UqQ==
X-Gm-Message-State: APjAAAU+UotZeEVqPDNzMjB6U6ilcpTic8pV1XJ+H/I76nMKbmDrbZ/d
        ZDAb4gHqvH8alnT+qT01I4KyDq5PoTNByXMuq8OAwg==
X-Google-Smtp-Source: APXvYqxNnULIlpLh0wsTzANXpb8hOcSCHwsip93sBpFo1drSO+2Jbp/L8mX4ItfmxfA4nEf/hYcLtPS7ku7RdD/532I=
X-Received: by 2002:a67:f416:: with SMTP id p22mr22190729vsn.175.1556207723167;
 Thu, 25 Apr 2019 08:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190425155118.7918-1-newren@gmail.com>
In-Reply-To: <20190425155118.7918-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Apr 2019 09:55:11 -0600
Message-ID: <CABPp-BEsSpFYVto2E998n-UUwD6UcVRVP61VPVg1nEgRUL1UzQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix and extend encoding handling in fast export/import
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 9:51 AM Elijah Newren <newren@gmail.com> wrote:
>
> While stress testing `git filter-repo`, I noticed an issue with
> encoding; further digging led to the fixes and features in this series.
> See the individual commit messages for details.

Whoops, forgot to cc Brian; I'm curious if my understanding is correct
about the sha256sum transition plans that the intent in the short term
is using fast-export & fast-import to transition to-and-from a
sha256sum repo on the fly; if so, I believe that transition work
should use the new --reencode=yes option in patch five.
