Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17769C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 20:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbiBWUA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBWUA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 15:00:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833932ED8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:00:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x5so45833551edd.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/5oxZzmPJPswYfArEPceL/wUKmtAdoT4KARjSd+HjI=;
        b=fZzSvPz3/h5yyHJV6oysCPMLe+NQCO6v/xsuwkLM1RZxqLVsE4NE64ITXZWpvgDAE8
         kKToHiIyF5RZ5im+kqZL9YeXLekPW8CUV6upnX+9z06OZi5N4ccKrqTb9vAUiTCl1svv
         uvzQIYYRMoqk3K8NCLo2pJ+/rII9DVcWcwZfoPu8DVqe5SXtNVKXE42q3W4lVsLsEN2K
         i//yHHvDw2IVbSeFnA2BzMZ9DerU2D+RLKmhdCPV87U/k0R/2wdWEY4GVXNOfwY08pFO
         jivUyx42ck0BMS8/mBQDBoZtij/o2wanaO5hJDDzF6CpO+pO33A2E0Eis3p7/ELx3z2a
         cNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/5oxZzmPJPswYfArEPceL/wUKmtAdoT4KARjSd+HjI=;
        b=TAPcpfaeh3srNzGr83zXdjzn1dT3+58i1LOYrLN40C0Hj+jvtMpaNzIA9GTTCrIfXy
         xrsE9bIg61V3TWMnu+pfopbcDRE/2P7tq0dmg4HyB6J2RxXLKXI9/AtNICE1nxb6yy11
         lWAKz1jNNlxzkt6uRZJa3Zn1eZmpDLkkwFrb9R65keo54q6T7aRQTFJQxG9DcJdJz7jZ
         Hv/dR3P+2mlsRwibN57An++FQH0nF8XG6fKPhcESYfO/dTuRdNVWyGxp7nz06UjcP0UB
         bykW8yRMtktLuufhq2foDy98vMKLeqp8qMz38SHuSwt51CSUCYUhovLsV+101VZd55Fo
         lKgw==
X-Gm-Message-State: AOAM533UomDb4lLZf9GeNh1HUQOMJlkFvkyXYdWa6WYwe8SqrutZngHv
        Y/EQ5U49llGRuy008dqiUzsJEey1K/NA2l4FeaY=
X-Google-Smtp-Source: ABdhPJzPFpAXzmHN/Lo818/sZXaECgwV3COZUve10G/diTAYTBkYszUqjPajHCzFraacntR7XktBHfL+nEBgvgPGlIo=
X-Received: by 2002:a05:6402:2750:b0:412:f7a6:6d52 with SMTP id
 z16-20020a056402275000b00412f7a66d52mr1008401edd.187.1645646398884; Wed, 23
 Feb 2022 11:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com> <20220223115347.3083-3-shivam828787@gmail.com>
 <YhZ0yXFIZNw/us6d@nand.local>
In-Reply-To: <YhZ0yXFIZNw/us6d@nand.local>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 24 Feb 2022 01:29:47 +0530
Message-ID: <CAC316V4NkdnqM99POmUELUeSHukgQDyGk_h_BcLs0Ud5igvnFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t0003: avoid pipes with Git on LHS
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for reviewing it :)

On Wed, Feb 23, 2022 at 11:24 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Feb 23, 2022 at 05:23:47PM +0530, Shubham Mishra wrote:
> >  t/t0003-attributes.sh | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> This patch looks great to me, thanks!
>
>     Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor
