Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E6B1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbeHMV2g (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:28:36 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48561 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeHMV2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:28:36 -0400
Received: by mail-ua1-f74.google.com with SMTP id k17-v6so7987543uao.15
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SxpWA/J7cvY0kBvdkOdOZzxSRqnNj3ErtjB8T3dwzd4=;
        b=O2BbLt3DDZzzfQbxbqjkTkIx4pqVLnRLOY4T427/CMjxDp9ERaoR0aDNKHq8OgEGJ2
         2xe/LwffQwhjUpnU2qJs9QJ3QJzH4nUSn477vT6P5Vng8cDPVrvuUnR+cK0/o5cor6Qs
         SvOKuyPdgB7/wAkkPNTs0/sZ2AyeJ/caIe3/giy0PhigA0uF8Dcrrj+nK4IB2Xl4wHs5
         dVdGgpNJU8J/VqqhOaOWnOoHB2ElJY0PnJIl1Vfzb09gYHh52CDuZgeZ/0KIX2oOulwT
         VNXoKE4mwaIvkWKvF9IoPpIxrtSw1Qa1xyUFqXal9skhe/1q8rpsEJ+XvmJZuKejzbZ4
         P66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SxpWA/J7cvY0kBvdkOdOZzxSRqnNj3ErtjB8T3dwzd4=;
        b=bGqmETd1ItuMD8mHPBirKsNGncYtbUgORFErHUi38WP8DmVmyMfzp/tH4beydKy028
         /dCs5eI8+AqOHz/G1hRZWCgwaCAuMQ03XHQNAYtM5OPKxdUl6W0bAjsLOfRICJQiJ5QU
         E0cKWsMFTUke6JeEejtyy67NeJfhRvpfpJ+vLrrqcT4sc4+NGt6xMVab84FiqKVFgAP4
         rW7qfdinPdxe+mzc7AVza+e4Ov1hnw8qQbiSxoqvmFIhewvmhNOKjVUf/gG22ky93uq8
         shlSg5eoIQjgJM7xjNBiQJwLhrgjARw9Y+Ay+AF9GjytkxbBxLKP2L8loktHK/utzk8Q
         xNxw==
X-Gm-Message-State: AOUpUlH9jJrKAduLriUIvzt8rTnk7pRjK2qPuUFxsNLLCKS1t2OpOfsC
        CtaUs/0tfyR4na4dmpj0+EaD1MlpDUXNxnhqGIqO
X-Google-Smtp-Source: AA+uWPwu902wBfHDdHeAWTeKDv+Of1pmdanwHGl35XCwtuylxeQXkwnS5Y2gGBofP2TWyzXVs4Di5kptmJy0/vRIRy2S
X-Received: by 2002:ab0:6245:: with SMTP id p5-v6mr8527756uao.77.1534185910270;
 Mon, 13 Aug 2018 11:45:10 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:45:06 -0700
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Message-Id: <20180813184506.18232-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180810230729.GA19090@sigill.intra.peff.net>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [PATCH 0/7] speeding up cat-file by reordering object access
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   [1/7]: for_each_*_object: store flag definitions in a single location
>   [2/7]: for_each_*_object: take flag arguments as enum
>   [3/7]: for_each_*_object: give more comprehensive docstrings
>   [4/7]: for_each_packed_object: support iterating in pack-order
>   [5/7]: t1006: test cat-file --batch-all-objects with duplicates
>   [6/7]: cat-file: rename batch_{loose,packed}_object callbacks
>   [7/7]: cat-file: support "unordered" output for --batch-all-objects

Thanks for laying all the patches out so cleanly! All of them are:
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Normally I would re-explain the patches to demonstrate that I understand
them, but in this case, I think they are simple enough - patches 1, 2,
3, and 6 are refactorings that I agree with, patch 5 just makes a test
more comprehensive, and patches 4 and 7 do what their commit messages
say.

Stefan brought up the concern that cache.h is increasing in size, but I
agree with the patch as written that it's probably best that we
centralize all the flags somewhere, and we can deal with the location in
a future patch.
