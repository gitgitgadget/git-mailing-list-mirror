Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3660C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D92613E1
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhEUWw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhEUWw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:52:27 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BEC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:51:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t24so5628827oiw.3
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Qh7QRofjKUoProwi9LUnQtvfbcrtVuBS067kNo+16Mo=;
        b=pxC0Cn+YtQuj83do3DhATBun6JqkmU1oPbhqdLy1SEd2muSH7CkrRLqbJ3VG08q0v7
         hanNiv2ukhxECHLUAI18hcB2UiTEJFzc2PmnIjN+NjcrkF90eBQ9MCeMPMp8rtFa8ea7
         4CUGN3hpDh3yHIgwcPUJ5OjYlBWQfE4PHVopubQle+xi2NpZD4r84bkR+cB0QXzf4Dp6
         YGarw/GeKVWLI6w7tttEL6tAQvH6FYHvqNHAUqBhMU0VF+HoHCJNgqFURzRRZoVnsLr/
         upA1MBfjcDBQFffwKFmgovyqn/nfXcL3liHAO8a7uz4L0/XCuKnojqSQlrO3rsRwKXVN
         WxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Qh7QRofjKUoProwi9LUnQtvfbcrtVuBS067kNo+16Mo=;
        b=B1ikfu6KJVrU5L5RCqq+Ugd2FmzzCAMoAwcO7ooaaLvhYH8TAQ9jn4zrcxuMz0tFRR
         yDcWhdTbMAXNmne7tlTqIKr2IbjngmrVeOjpJwb0rxgXFcLjVRtV/hQZyprCJgNFUtCx
         AZk1bX2fhbUiQ4KizSj4PpN9MMbfnQL7QiHzHtAJm26Jpyt/38ZXDCv4sZD3B/yi/Rgn
         6r4C3kQ1CJTKJuPU++bC5MPsCm9wGKHSy4RbPGY07G8vdUQR5omiPuNRK1R0lWaYZIvM
         FH850YBBfWU2ypIQwxkgnAba1R1aJTjwVkSdDqm5gaTan9ArjX+6ZnzJzhCSzR2ptgKY
         QOEw==
X-Gm-Message-State: AOAM532IkK2J24XRjx8P6u20TMygiJqmpGHFJWEQ95iceeQnDEWNKtxl
        Zu4huKIKoCHrR6AAQ8hukXk=
X-Google-Smtp-Source: ABdhPJzq2eTLOk6jDxko0O00qd4B4Qsk5lHGHjgoEBiYK3O+2NDCCu5JOxXlzgZfyZJ5gkYu7CU9Uw==
X-Received: by 2002:aca:bc02:: with SMTP id m2mr3739039oif.154.1621637463680;
        Fri, 21 May 2021 15:51:03 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w10sm1433592oou.35.2021.05.21.15.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:51:03 -0700 (PDT)
Date:   Fri, 21 May 2021 17:51:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60a83956270be_81ac020848@natae.notmuch>
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
Subject: RE: [PATCH v2 00/11] doc: asciidoctor: direct man page creation and
 fixes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> This patch series enables direct man page creation with asciidoctor, bu=
t in addition tries to
> minimize the difference with asciidoc+docbook.
> =

> I fixed as many issues as I could, and now the doc-diff looks very sens=
ible. I could not find any
> major issues, however, some minor ones still remain.
> =

> On the other hand the asciidoc method has issues as well, so it's not c=
lear which method is superior
> at this point; both have advantages and disadvantages.
> =

> At the very least the man pages with pure asciidoctor should be quite u=
sable now.
> =

> This series builds on top of my previous cleanups [1].

I forgot to mention what changed since v1:

 * The option USE_ASCIIDOCTOR_MANPAGE was added
 * Jeff's patch for *asciidoctor-direct optiosn to doc-diff was added
 * Martin =C3=85gren's patch to remove -cut-footer was added
 * The format of linkgit was updated to be closer to brian's version
   (though not quite the same)
 * A few tiny cleanups

-- =

Felipe Contreras=
