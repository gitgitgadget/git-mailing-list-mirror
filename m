Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF21EB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjF1TaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF1T3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:29:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89290130
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:29:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5707177ff8aso1427057b3.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687980568; x=1690572568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpF5+/UHcE/T4qrZmp+PWzY1lu4cGv+JzdrgM6H3sfw=;
        b=uIcHlMIZ2NIaUsdmnXnFd4BjgsXD8ZSwHymeBGJrxdKqzv5ggK0O0LFHGCK1zUsjgN
         0DbmxAKT16YSsDbweOtw+87lXdEUsQVALwVngm1AtZDIdabPdvMSCUpqzMDwM7b8xaHU
         M5BbNTS6IXNrAhuCpZHPlRpbKoKgFWTPL5Ef5qDYfm8BVHYkwSSZyAJgv/EYVY3qlss/
         +6rTywwliME+nnetLEZp9TBGN6pOSdJDKBNeRR9KGZ6csuGcwCLJhWpNjy27KitMkQA0
         WXkDLNwRDFZ+24ryRqCVD8BRwUAd3w0KQsbAS3obhsLAZ8T5f9raZHrTbZiLKnaw2V+o
         MOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980568; x=1690572568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpF5+/UHcE/T4qrZmp+PWzY1lu4cGv+JzdrgM6H3sfw=;
        b=JvqswZbVicCzUpE4nMCipbhtXBPq8jkIEJGPsInv1kqYhHX4TeN88waJYiUfGNjbGd
         Cf90BpyDafnpUAo3kWeSDLDhUpSWLpbqy6SxnQgYfQO8l4piO2tkSuOnwMuLL3ZfYSKc
         e396SguslryXOekdB9MtnPDfpTpQbL/xz/tRivLypOXHh0IqIIvlb5WKKNeuKF/FbOYx
         XpA8NHEaTg8hcJrVr4qflfIekstYCArczRIfgFokqiSD2ffGuZ8pixQDxd2JCUDuOPK7
         3Ff60VgYIyQll3a3C96vJKZ1L6La9m60qWWCOWHA3JobMphSj+qRJimv3+VD6EIb5d8d
         N2zA==
X-Gm-Message-State: AC+VfDy9Bg9OaNebnZnd0z+/rjlTNf+3Nf9VkGnZg10RAIVSvH3nhW0W
        rFsV0T0iENEfFqCbWepn6m/M4fPPtQYGpw==
X-Google-Smtp-Source: ACHHUZ7AaPtYZsPhSQB+6csqK+UYHS+u5dFpKM5hep+IzvO6XmTuYtXAj6iulvuAecbMWlECgNNq8nc1bdQQiw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:4f1:b0:c15:cbd1:60d6 with SMTP
 id w17-20020a05690204f100b00c15cbd160d6mr3623917ybs.5.1687980568797; Wed, 28
 Jun 2023 12:29:28 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:29:20 -0700
In-Reply-To: <xmqqcz1gftdn.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqcz1gftdn.fsf@gitster.g>
Message-ID: <kl6lh6qrqtbj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: cw/header-compat-util-shuffle (was Re: What's cooking in git.git (Jun
 2023, #07; Tue, 27))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I notice that

  https://lore.kernel.org/git/20230606170711.912972-1-calvinwan@google.com/

is available as cw/header-compat-util-shuffle, but AFAICT that's not in
this announcement or 'seen'.
