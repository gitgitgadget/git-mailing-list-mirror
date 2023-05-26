Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15BFC77B73
	for <git@archiver.kernel.org>; Fri, 26 May 2023 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjEZVDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjEZVDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 17:03:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F8BC
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:03:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-256258bea56so859143a91.0
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685135021; x=1687727021;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQaAq7V2E07VL7a5xBlcv27mBXFoyN+EIuMfDzneEjw=;
        b=ClKbuKYdH9hlDhUG9gpwzzBy400anrkAjyYxM4Bl+LjFTjwj3PHgrvR9B1fC6+SNa2
         Eb1paJ8B+hS76TmZvYK2chGbsikLf2WhkmiqJttjpJhHvHIVbAd95hYMnFVzcqCDKQaP
         4LeHdmQ24nV3ZQb6P3Nhyoor+9S1nGJHQR1V8/guxQdKTU4AbtWaacZm9Z+CiLvDGMx8
         pIB5b2AQyOf2UeROY/du5g8t9hx0ZtO4/NB2AvNUr0icA6Q0i+dvhbB+8vY8hwKjyyFe
         anpnzOtNMFjOdFIqi1rW9tSaT7kS6PWuFonzZGOw/RB6oVCPAFtHpEzimdZgXW1iYwLs
         88nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135021; x=1687727021;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQaAq7V2E07VL7a5xBlcv27mBXFoyN+EIuMfDzneEjw=;
        b=NDCC5+V46UE4SSCf2PmpFCUzs0Om+0dGtGqeAqVbRWOPIR05j4ViUVi6qBLnSa6IX3
         2059sgpLkQjDE54wCksCS9Bl9lisTZC1PnkBu5H8BeHtQtlWBk2MyXcI0drwsIZY1QGE
         3jAlldm578MHsoY626i+5N7f3d3bQDveYa3GDt/Z9xKwWpzcklq1EWllq3Bk5kio9ZVj
         A7AGPbiA1xydselozV2gxrVD+HBdwKiuT5OXEioYwTusXzprf2IHWLCkK9vSHzFvMM4R
         iJdKS3+qZ7PEYgtuAJP1zSp+nQOrb4PC27b061oh3ZPWkzBvnu78CHu/V4V06AnEvCG7
         SE4Q==
X-Gm-Message-State: AC+VfDyKPYwRsxdR6gcEZEwDP5W680WhrvChQa7qJ202shbwdw6BaTUh
        kRyZqT1Mv17S8HzUNq/a5+1vcO7Vqifc8j4Qrxey
X-Google-Smtp-Source: ACHHUZ7ApXpb6ms0bghOx5gyySSiIQuV5xRovxhvHZLsO9kQZs6SSvkxmKtix+3uUv6InwCPT+vbx3H3UimvG0eOmMAq
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:4ab8:70ac:b28a:a7ab])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:4294:b0:24d:fefd:a7fe with
 SMTP id p20-20020a17090a429400b0024dfefda7femr779679pjg.7.1685135020963; Fri,
 26 May 2023 14:03:40 -0700 (PDT)
Date:   Fri, 26 May 2023 14:03:38 -0700
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526210338.2290394-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/7] git-compat-util cleanups
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Changes since v1:
>  - rebased onto 8afb38ac80f6

I couldn't find this object. Calvin and I resolved this off-list, so I
can proceed with the review, but remember to rebase onto a more stable
base in version 3.
 
