Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D8C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C4C60F57
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbhJHUHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhJHUHO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:07:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9AC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:05:18 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w185-20020a6362c2000000b0029566b18a88so2167854pgb.15
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kza7mVZY7ZXWUlLcgTub9G2nvUGBk+NCto9+koqKKwU=;
        b=QpoXXPX6bWVjrscCRoqpsVT4t1qaqiQLBhKyDfJCcRF6+2N3o7XWJys9HZP4xUp2K2
         uo98iUpTK0z+YXWR2T1pXZPlTNsI/UbAhg42NXtI70DeRWI4lPFcyIeWR3VtwT93m+Hm
         OPtVV1wu0aLbt2IeUMxs/w75JyuR6yNTLFTRSOFLsQoZeNm8kHIdWv/xR98JpiPfepyT
         F2w2XarXOQEQPJOqME2YbecXVg6TIvw3K9lOqyTzl+KrC+AatCCou7wsuQyc0oZCW7YQ
         yl8wI24XD9tRiqfA+FswT9IdeH7bUv1FmUybo+r259Aho+9/zEmQn/+ldCGtnXL+Oy1B
         xUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kza7mVZY7ZXWUlLcgTub9G2nvUGBk+NCto9+koqKKwU=;
        b=l8MAKdgkcBIHaGQ35Bf8wH9LiFiJLouIoB5W36u7NZiMHuae45IFF/n0AZuuIk4pta
         KtyXs0fvEFX3uuIrP9efTmKTf2U6Mmy5A8yc4jJRPNfXlY1gE792uvHiFfBLg63nAkWy
         5HUCEjPvbLmiTzAIGvt3RJGxlaLIwYRvF5GDYG+ulC9ALrg40287/BGYVrRurN19E5hd
         utpBxKBjZgUxIFZVRDM6L7cgBxZMxUoVf0SPlmdQ3OrfdevynSi5CGlISu9ryeFrCEh3
         W8BM2C9/Iz9t/9M7Zyw/dQcigcpwiIAXHlGhesjH/Ec6aSb51IzgDvi1nvm42KbnQjiw
         8IQQ==
X-Gm-Message-State: AOAM533Ppwn2I0HbM4+D7r40bKfGGcI2kwh3hsv0bhwrAAJhikp0unwe
        ++REcJN7RX5IEwcGvhibYXOb/m7Q5LlN/q6tD5Kt
X-Google-Smtp-Source: ABdhPJz8JNtsomXUJHlUpdFsQXGpt0Eia6DaOCciaq4M/t7U6Y/yLgWsDiwU5zQS0PzFHVC+xkMiUfTZtML7aHDaEwwT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with
 SMTP id m1-20020a170902bb8100b0012da7ec3d85mr11529662pls.17.1633723518255;
 Fri, 08 Oct 2021 13:05:18 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:05:14 -0700
In-Reply-To: <20211006174231.80434-1-chooglen@google.com>
Message-Id: <20211008200514.1320355-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211006174231.80434-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH] fixup! refs: plumb repo into ref stores
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If we are plumbing repo into ref stores, it makes sense to get rid of
> the_repository in refs/files-backend.c and use ref_store.repo instead.

Doing that would mean changing some functions (e.g. should_pack_ref())
to take a ref store or repository parameter, and as it is, I'm not sure
if there are still implicit references to the_repository. I think that
all these can be done in a separate patch set.
