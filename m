Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7483EB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 22:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFVW2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 18:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVW17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 18:27:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02988E9
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 15:27:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5732d86d932so24020897b3.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687472878; x=1690064878;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hsb1GNxMYHDeW2X3h6N/MbEGHE7u9A1LiDTmqmS3MQc=;
        b=J63zLzqFy5gEOoG50NHfTFEpChZAsZS7PJ1MAUmjJD5yzXIMVkGa1Llq8LDmSD4mR6
         3NnrnuX/RuyCWk648luhdDC3v4ue8UWMtrEwN0ziWd8gASjYWHZi8zZrcp8AQ9Or7r5B
         65q8nLp4I3pGV2uJnwH2N3o30ejyj4dFB0500H76RCF1oYEzErdRuOZoKlNd3RL+juen
         oX11BqV/dEhCD2UD0dQskEXxkRMNIDr8KFp5g6qGWzVOWB+MZIJlMca2MJI49lKoRGM9
         kD1zsxXGaorbypmv7mgCoiQ+sRiWVTTzWNs+TOfBb4a1nFKy9f0q77HtNOOq2X4Pvz0U
         aFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472878; x=1690064878;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsb1GNxMYHDeW2X3h6N/MbEGHE7u9A1LiDTmqmS3MQc=;
        b=YXd6mSST894a1yvF6RpaJjYmi1bbyWUtii2qsMukzCp4Xo6ixii4Vmb9CTD40yP9BG
         7xksaozWzShls3qF4UQHweo2+yV0nSeyvI0hD30KuspdIWdh0LATfUmZYFZqXmym9TGn
         7mKWbgNH1+/inTiVfTrLMWxKWv4K3rJVuzJHJCdHrSh5i33FMdCyZ2lxbAhYWrudQo0K
         +6OyfX4hyx80lVyCULVHuRh9XECVempHdVL0DZfaAFnRu3wn9rupVsWAFffJd4OHH637
         PJULQN4Ttg6Y2em2RMXDs7Pxoy0chgcOo39zdED8hfuKnTIJxFcjhFbUVlxBTQIqkvTP
         8E6w==
X-Gm-Message-State: AC+VfDyyACc1lE1eBa+1hhgfkas4z+zHZJDkVTx8094h+Clu7fNdmSaQ
        nGrMSG1C4QGQQ2U3l/NXtEd4PwtmX5YSctfc0ovz
X-Google-Smtp-Source: ACHHUZ6+LvqBu+EjA5HIHfmlk8ja2KagQb0dDpKCLuNX9dXhPsyuemntrNjU8cEXO8nghSxnEUym3MAUVBFYb5k97eSA
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:b7b:317e:b418:a6e5])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d304:0:b0:bc3:cdb7:4ec8 with
 SMTP id e4-20020a25d304000000b00bc3cdb74ec8mr7961702ybf.6.1687472878282; Thu,
 22 Jun 2023 15:27:58 -0700 (PDT)
Date:   Thu, 22 Jun 2023 15:27:56 -0700
In-Reply-To: <0fd02ca8-bd5d-4143-956f-2c456897b87a@github.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230622222756.2046051-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> On 6/21/2023 8:19 AM, Taylor Blau wrote:
> > On Tue, Jun 20, 2023 at 09:43:46AM -0400, Derrick Stolee wrote:
> 
> >>  commitGraph.changedPathsVersion: Which version should we _write_
> >>  when writing a new commit-graph? Defaults to '1' but will default
> >>  to '2' in the next major verion, then '1' will no longer be an
> >>  accepted value in the version after that.
> > 
> > I am not sure if there's a situation where we'd ever want to not write
> > the newer versions when starting a new commit-graph (or chain) from
> > scratch.
> 
> I'd rather have the choice to start writing the new filter mode be
> made by config rather than a change to the Git binary. Makes for a
> more gradual rollout to be sure there aren't issues with the new
> version.
> 
> So please keep the configuration value, but have it indicate the
> mode used when writing filters.
> 
> Thanks,
> -Stolee

It looks like we can't avoid writing both versions (we need to write
version 1 so that we can reuse existing Bloom filters when writing, if
the repo has version 1 Bloom filters) so a config that tells us which to
write sounds doable. I'll take a look.
