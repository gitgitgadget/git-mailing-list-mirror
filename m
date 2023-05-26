Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D2C77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 21:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjEZVZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjEZVZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 17:25:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59CA9C
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:25:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565b499da27so20939407b3.1
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685136327; x=1687728327;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8GV1zCUvpexoW0Kw+65YgaNaPaqrQiNUec3FDzPpo/s=;
        b=mz05K2ChpBl2PQYj7npudTq6FfMXeWy3hCQGSnflnqc+UiocLljZeuxsTKeBv1R07x
         4KDigdVsAWq4asgvogud8BPhZsDmnIQtznG6qAsCscbJa0He0LeFL5cJ5uTZwLPpRYK4
         QFvX0Mp1GCd9vYeX/O8SgpJ7D2MVlD09/Nw0tvkp5fesKKBgP0gl87uhrehgGTohriu5
         fG9wqk2toawZuA8rpESKWuw8EJTMN1ntZR3pslz3hEedaQsqjaY1ykE88EZT8f5BLbjP
         PyRTNADTVYal3XENlPX1GuccHy0byr1dV4M6EwroaRokil46ZEwadCGIT2LpColnM31J
         qjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685136327; x=1687728327;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GV1zCUvpexoW0Kw+65YgaNaPaqrQiNUec3FDzPpo/s=;
        b=S6PbKAGHjnB03VudKiwpfcy82aOUq4b1wrJFJkxrmgUwuOV8ADiaY5o7/NvSdk3CnO
         dtdE782CFOlVLkgJOmH/MCTvsae3RPdqnrTIEbgtEAeIl2u2myygi7lplyn6vvHKWhOx
         VkXd2xGT8Nr/NDoyI80qZOVnJ8Sr4/Gexcvw3KPxQ4AC8We5QM1WHix+POT7Yyua8PJY
         xEUN2dS8upBKybaHPd3nWroX8Y7s5R3eTrt604B8a4SIj1rDPqtXdna6DoZf59FI8ls2
         4FkWTGcVk/20CST72RcSlxs1IJEhWD7miPixbPD5k85YXK9ca8SoZXsLO8e0j8bDRc2P
         Zx4g==
X-Gm-Message-State: AC+VfDyufvMxL/G57thtHurwFYqBkHN7ydJj/ua/69U6TwlTfNEnEL55
        2IjnCsR2LJSDGt+a2x6rsZmCyGKCkJJKTgnSCvxR
X-Google-Smtp-Source: ACHHUZ6MZfAbyADkgCYes33WbqjTvMTtw3XncEI4uk3VgBHcBkk6xwLhyAPE0zLmCuMjNHF8R8Q2pgsxEukXsgxAgSVb
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:4ab8:70ac:b28a:a7ab])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4319:0:b0:55d:e173:8a73 with
 SMTP id q25-20020a814319000000b0055de1738a73mr240362ywa.2.1685136327246; Fri,
 26 May 2023 14:25:27 -0700 (PDT)
Date:   Fri, 26 May 2023 14:25:25 -0700
In-Reply-To: <20230523192949.1271671-2-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526212525.2293692-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/7] wrapper.h: move declarations for wrapper.c
 functions from git-compat-util.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Since the functions in wrapper.c are widely used across the codebase,
> include it by default in git-compat-util.h. A future patch will remove
> now unnecessary inclusions of wrapper.h from other files.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Thanks. So currently, if you wanted to xmmap, you don't have to include
wrapper.h, but if you wanted to read_in_full, you do. Making Git code
treat functions like those 2 in the same way makes sense to me.
 
