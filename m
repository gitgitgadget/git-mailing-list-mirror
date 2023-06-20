Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDBEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTV4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFTV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:56:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECAF1730
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:56:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc615ca6ea6so5253510276.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687298182; x=1689890182;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eMvbuFpcOsIRG8bJBC0KzP/gjQ1ogS0gt6ajYtS25mI=;
        b=kPe4LWSdQU6nqhG+2dZlV5k+wWuXIrmmJmZ4azRCYn4KxbyqBnqgI6d5j41c6ncpcA
         vfQhdOgicBPaJfs0aotuvXrDua3cxsSyGrB4Qqz2f/iwijzsB8djxYuHiAJ3XmAquR5V
         drSartf4AE80ub52t32KzrXx02KWr3b/DRvA2ZU55DwAK5T1JiTtgICCxS3NTtrnWo9U
         FY9Mf32qbqL8A3MEdLCnlcO3vqh/dJh9hz3sbiIVP9t528mRUf8z93u3oU2SXiM0RC1i
         PfqaRexkiS5pjCHusqOfk5I5/cz5oFEPAL0mzA+nWb7q8hx1kniuLVEIdPJIBgD++wQM
         +lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298182; x=1689890182;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMvbuFpcOsIRG8bJBC0KzP/gjQ1ogS0gt6ajYtS25mI=;
        b=J3tJYMJ6+YIxDwh+5yjN03pBWATtvZtZ4BKr0LIRo6HHwatsFQf4dVTs7mXp0l0QqV
         Ikf817AQtcn8TSoSy6zvWcla8jzHK/vJDENknuUei3FKGdx3tOftGDDWqdrO2LJKVqez
         fL4TKZK7R5C6Ksc3JRIpRRTNV15N5jEs/PQBorvqfzmI3J/XY62Y8Es+4cEmQnaMQBxI
         Bqw1hkNKzdBdnv4BIQsH2cV+2NxLpjetxiBpVc2e8vA3ie7xztyaIkv0yN2tw6a9D9Xz
         u0KwVnKpetzm+nyqcA7fcJXzdgYMqWy1edH+th0RHx8PiPnCnEJhxaBWsCkDGDj+akMX
         d4RQ==
X-Gm-Message-State: AC+VfDxloGLu8o5fy7A1SsfkeUi6hNuadS91lHqwaIxKZIPi5vTdjPZW
        1i0mgWdO9x7gbHYY6+DiRI/X/inqsbw74OBVAa6D
X-Google-Smtp-Source: ACHHUZ5FTU0nA6XnOeAo2xWBVcVfcAlL85n4iewidQBGMOl9jqDwElj9NhewB5SFN3P7LB0l3Xaguyrl/U+dgp9ckUih
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:825e:43a2:8c93:d4e1])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ce92:0:b0:ba8:9653:c948 with
 SMTP id x140-20020a25ce92000000b00ba89653c948mr1452921ybe.3.1687298181887;
 Tue, 20 Jun 2023 14:56:21 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:56:19 -0700
In-Reply-To: <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230620215619.1398374-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> When commitGraph.changedPathsVersion is set, it does not allow
> reading a previous filter version, leaving us in a poor performance
> state until the commit-graph file can be rewritten.
> 
> While I was reviewing, it seemed reasonable to deprecate
> commitGraph.readChangedPaths, but this use of "also restrict writes
> to this version" didn't make sense to me at the time. Instead, it
> would be good to have this clarity between the config options:
> 
>  commitGraph.readChangedPaths: should we read and use the filters
>  that exist on disk? Defaults to 'true'.
> 
>  commitGraph.changedPathsVersion: Which version should we _write_
>  when writing a new commit-graph? Defaults to '1' but will default
>  to '2' in the next major verion, then '1' will no longer be an
>  accepted value in the version after that.
> 
> The tricky part is that during the commit-graph write, you will
> need to check the existing filter value to see if it matches. If
> not, the filters will need to be recomputed from scratch. This
> will change patch 4 a bit, but it's the right thing to do.
> 
> Thanks,
> -Stolee

OK - this sounds reasonable. I'll take a look.
