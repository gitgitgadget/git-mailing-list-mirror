Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695AFC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiD0R5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiD0R5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:57:33 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751C6B7C6D
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:54:22 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id t12so1260436vkt.5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/Rq4n2RLkDqGLHBiei8I977WxUKFurdn+oRJEqn0Ag=;
        b=iSurzOtfL7xnfkr2eo4jiPjtulhAAqU0m6sLpDNDBO9N7jq13sfLQmGbo+p6lXrDyq
         mQ8P79fN5M15o2OtDScbd0cSzVe8jEWE8/X8qtLRYm+6KGaphLiljOcLSuSVWUVkeXLI
         9U2Y5kcNzs9/a8icw2vdWQyz+L6djzHniszJDETrmtHHqMIBbo7ogaIY/HRiP1K3W1e3
         ktmtTXrCBGAG4jE1EC2gjJ4uHNrQJBVTidTnJI12N2Sh6IzwXdFnLc14o25seUS2SeZh
         XdRA0wrUGH66F1zATCGDUeRpy9JoY75jSQz4kMlVkdtUY8d2LaKjYksPF2GrcLLC0Zrd
         S+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/Rq4n2RLkDqGLHBiei8I977WxUKFurdn+oRJEqn0Ag=;
        b=IiYhrtgIoYoVLuzvJ542q7v96MZpS4VUjWbckZo2xO9nnOqqr190yeqfUUK37BpmYg
         hXEEpxypijhQ0+u/M6Lix6fWTB7xQc9NE5RN7qerBnNd5FG+6l0kYaAsgVEZJtvlDApD
         awV+FTbutlg9M3B2TYFfNwHVz+E37dsS2paSb+0KDnnUQ8lfYawLOFJF8/YR7mHaggVk
         qipqkUDlbpZNU41KkCzV14cnLtJXmLstTSV6lIYAbtyB+fu1seRWdtrlWsIjQnsErGOV
         JweFWKbPrvo6IelrG618DrRbK6HOgCU5rWN0HYV3OjrGOFA/z9a2565WKN8V0nwWeDdf
         G/3Q==
X-Gm-Message-State: AOAM532xH5vdjKtV2TBLRE15AtXiHdaT41k9AwE+/pxpnN4SyTm54GyX
        mL2mGjF4kRtMQqSymzmmIA9zPTi7nCOqZ3H48jk=
X-Google-Smtp-Source: ABdhPJynLRocpF0eeVrDRZMhHHkv0Q4axX5PE+eYoYrFLVBxp+GnOhXF+lEup3bFIcM/OF//CngA1ixYEnTM5EuwApc=
X-Received: by 2002:a1f:a3d7:0:b0:349:6b56:a90 with SMTP id
 m206-20020a1fa3d7000000b003496b560a90mr9926648vke.12.1651082061518; Wed, 27
 Apr 2022 10:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <xmqqczh2o5xg.fsf@gitster.g> <ed2cdc8f-1908-a095-ddf1-660ef8b5a90b@gmail.com> <00ab01d85a5f$2831e0a0$7895a1e0$@nexbridge.com>
In-Reply-To: <00ab01d85a5f$2831e0a0$7895a1e0$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 10:54:10 -0700
Message-ID: <CAPUEspjgMw2CwFCj4i+iH8phX_8mSRT0wPYhNrEA0E6avNTaTQ@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     rsbecker@nexbridge.com
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 10:49 AM <rsbecker@nexbridge.com> wrote:
>
> I can confirm this on multiple 32-bit platforms. With strtol("123456789012345678", &endptr, 10) returns 2147483647 and *endptr == '\0' just beyond the last 8.

can you also confirm that you have strtoul and works the same, before
I break NON-STOP in my next reroll?

Carlo
