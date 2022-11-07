Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F2C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiKGVTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiKGVSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:18:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42F3E0AF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:15:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so33478302ejb.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAxB7yT6yXnbsVkdWenpjbvxnMVEyjr8Tv7S3G0sip0=;
        b=R+Ck47F0hQ0hB07qJK7EBqcWLGauz6GdTF/awPE/tYsd9WBDnG6bpOjcKFKJ1bdkM+
         CAcjJc6zdTsVg8SGkuxLo0yued8f6J3ADeOw/Cmuo666ZpXkmLI8tTTf6J1BOLdYVk6j
         qbL9alqJ5gnRgA9NBWlLxXhvhbNKtF5aJ/39yroFNkF216gV+zXIDGKbVFtiNc2NfEPB
         hHaHGHroMmLQSimyrlwH+aDOQSczWjrZMRN7AJA7ZF/CtgK/mcSey7nGe46nOkJX5N1Y
         yGe3PxWYFxL9SmjAhQKauuTkK2EcYFVYXMUzggzh9JlKl/0UFljGMpmGvUq9OMhQcl/Z
         uFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAxB7yT6yXnbsVkdWenpjbvxnMVEyjr8Tv7S3G0sip0=;
        b=zyFDcBk+q5/F0iTha6T8qSrrJ1g4wtMnTb9JZNSKKATe7AzSPNwYxnjnjXFXZEjJEx
         3V+WJryjrcgytRVKHfhVbw4CjpVZmJPbz8WoYH52LO76Fcl5DxD0kFuQTik1S2Jpu5+w
         s+9h3x/i33XuO2IXE4bmUiXUikEm8b/kQ9enAmWOVO86SLrd7UqQl9hckBGiUAjyjg6h
         ceBiJbbESZaiIn1EAXFFtk9ajZuAm19nHn5LNrSBCt72i804XuQLfej2WpQtwd5rsAX1
         sm6kY/9JEWtgMYTyMDSjpehnYUh0azTPAq516hN9/MXH/1Id5QAEeRyMTapAN91hWDhT
         /xVQ==
X-Gm-Message-State: ACrzQf1OP/qUdcBeBy0Px+OaWAEkIjkhVjkuHvnuyWIdzJvY9dEQ0owk
        +5duUvwfPIWUoPaaFXHg8QuNN2s3Xyw=
X-Google-Smtp-Source: AA0mqf76C8yTEE37/UfNmkTA2j78lMzNhOgO/v4Znubc9y2ZfBmaD+qUYrHe/MHjmikR+QKmhYjf9w==
X-Received: by 2002:a17:906:5da5:b0:7ae:5b41:853d with SMTP id n5-20020a1709065da500b007ae5b41853dmr10748247ejv.600.1667855724561;
        Mon, 07 Nov 2022 13:15:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906068c00b007919ba4295esm3885079ejb.216.2022.11.07.13.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:15:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9Sl-000LIA-1F;
        Mon, 07 Nov 2022 22:15:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: ab/coccicheck-incremental (was: What's cooking in git.git (Nov
 2022, #01; Thu, 3))
Date:   Mon, 07 Nov 2022 22:14:28 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221107.861qqev53o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/coccicheck-incremental (2022-11-02) 13 commits
>  - spatchcache: add a ccache-alike for "spatch"
>  - cocci: run against a generated ALL.cocci
>  - cocci rules: remove <id>'s from rules that don't need them
>  - Makefile: copy contrib/coccinelle/*.cocci to build/
>  - cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
>  - cocci: make "coccicheck" rule incremental
>  - cocci: split off "--all-includes" from SPATCH_FLAGS
>  - cocci: split off include-less "tests" from SPATCH_FLAGS
>  - Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
>  - Makefile: have "coccicheck" re-run if flags change
>  - Makefile: add ability to TAB-complete cocci *.patch rules
>  - cocci rules: remove unused "F" metavariable from pending rule
>  - Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
>
>  "make coccicheck" is time consuming. It has been made to run more
>  incrementally.
>
>  Will merge to 'next'?
>  source: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>

I think it's ready for that, the v5 having hopefully solved any last
remaining nits / issues.
