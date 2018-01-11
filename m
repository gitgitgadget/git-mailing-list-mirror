Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DC21F406
	for <e@80x24.org>; Thu, 11 Jan 2018 11:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeAKLZj (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 06:25:39 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32814 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754206AbeAKLZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 06:25:38 -0500
Received: by mail-pg0-f52.google.com with SMTP id i196so1989357pgd.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pN6+sYxU+kq/PLnBLSjTRHnHitSi1fhNvwy5OK40ps8=;
        b=r504X991V9rHQ3asltRF7v0Lf3MWXvpRS8v45M48PSh6SCNle87ZCMdNnNxYiAyXsP
         6JlO8F2u68dUZNbfeY5rBuqqXj4D7xFdL/tT9poqt83nj/kDLEC6ru7b53w5r25nlhjB
         qQSMC2GwqryDBWk4iEisqweieYKfciPMVL21qQfD8JVyfubRzw1McdODFCQsyy2LWFqg
         RS4WUa3yCBgjwVC4CPr9squ2rTn49MtySHaLhIoghAsYo3GJJzctNcin1HKxefq/3Rd4
         dUzfOGPDl0aAt/4varjwde49ou5/R56lcoDpefY5uhHdlxRSkM4uiLT65cX7zHUCmBCy
         gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pN6+sYxU+kq/PLnBLSjTRHnHitSi1fhNvwy5OK40ps8=;
        b=nAQx/TpI8EAlj+RXzq8AgrugAI35CawxPQXJdTwp6l0CD3GCddGGkKB28TOC1t7wOA
         si5f4Uvst6tuEQP9Ov1WFl9tthnmvUuINUj/2EN8iNPxH27Goo6QfxTA/S4E8lkYzHTf
         qAf0FNA6K33icysVNC4aex5KRqEknBB+FetMWU4qBG1tFEDIO48jFQoszoxLgPbBQH2A
         hYzJbTBmpJ6vJLTxlQ3f7pmJThnlwc+zXhtyH6xRrGZiUmikplJS4KmlUDvpMazJw8I/
         u/0rJs5ExulIpztYmdwF7wk7AwMXZYxZdou2c1fPv3bw7kW6w28Zb1bXrcHqLRzG1ICa
         6DSg==
X-Gm-Message-State: AKGB3mIt5p+sZ8b5mISr3njJ3irtCBBpTdZDiWk9FiRWfx1scXZT4VxB
        MWS8BbC+bi4vBKaBeaJO2tPJwFzs8GHx+ccshX4=
X-Google-Smtp-Source: ACJfBoszigjAFuNqeYyMn9OXK747BIOyJQNV4vrA0GPwzGDZWG48AVWHl9QnUttbNHC/j59gyWU5VuvgVKXbJ1B0UoM=
X-Received: by 10.99.0.17 with SMTP id 17mr17656112pga.149.1515669937764; Thu,
 11 Jan 2018 03:25:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.183.106 with HTTP; Thu, 11 Jan 2018 03:25:07 -0800 (PST)
In-Reply-To: <20180111094712.2551-1-pclouds@gmail.com>
References: <20180110104835.22905-1-pclouds@gmail.com> <20180111094712.2551-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Jan 2018 18:25:07 +0700
Message-ID: <CACsJy8BpFiNTQKLU2g=4Fat2gC1R0OcMteqcZx0ubg5ChNmKgw@mail.gmail.com>
Subject: Re: [PATCH v2] run-command.c: print env vars when GIT_TRACE is set
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 4:47 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>  Though, Stefan, while i'm not opposed to trace every single setting
>  in child_process, including variable deletion, cwd and even more, it

Another thing I forgot to add, s/ and even more/, redirection&/. At
some point I think I was checking the git-pack-objects command from
GIT_TRACE and didn't realize it was taking input from stdin (I was
naive :D). At least on linux we could even take advantage of
/proc/<pid>/fd to show path names and stuff in addition to plain file
descriptors.

>  may be not that often needed for a "casual" developer.
>
>  I suggest we have something like $GIT_TRACE_EXEC instead that could
>  be super verbose when we need it and leave $GIT_TRACE with a
>  reasonable subset.
--=20
Duy
