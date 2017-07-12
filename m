Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E87920357
	for <e@80x24.org>; Wed, 12 Jul 2017 22:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbdGLWV1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 18:21:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33470 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdGLWV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 18:21:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id j85so1562637wmj.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cIY95FwnZpElo8im1SuF8MSZxkNL1gDU3zze9r43hMM=;
        b=kwdLN5R6hknqGFTPezDJxK2LGtEujo39tvmLWIif8Dt/nRpYGhnmVg2u8SbPioKYfT
         lmwenMkcitqjU7XN51IhWiMEz/UPjEPoVH/vz9+z9UxlAml61nKaHMOh08VGWNXhegvt
         hb/KHgVrlSAJ8Xr7R85sghses39PCls/Zub6ZIm95I+kz+UEzQlasYn2oX2HstVsK7pq
         V/vj1X6Om2qoH+p8IU96WiUUQEbRi00LejvRWw25dGq71ymfCKNiEx3r3hxd4mlHL8Mb
         YwiC8v/TOwg/vRbjVP5ahmkzkeFBV5ZDPYMZ4Aw85lc4Xk0TGordVZVXQjBAjSv6QnYv
         zjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cIY95FwnZpElo8im1SuF8MSZxkNL1gDU3zze9r43hMM=;
        b=poIr7j4ExrGsMdLXNf3sxSZC+VWorUiDhuO5GxpaTlZyl7fouC/du9BeW7oWBXG4Wq
         42APcapLX07ku57a7ID0V15TNNAFYiviREd2F0T36fgAd3mHbISMuaZWR98/yoBglDNM
         uT2atQK+NgNiQc+SkpkSm7CoCZ0UaKascQ9xSBu4J6t5yafYyLrr0Or8RfATeq5++/LJ
         VOxvZnXXsvxcJtuOQDAwWUFhqWJJw/uxnD6lzxh3G64pz9bWnOeBnTzaKHLSKy+RfIXL
         hb9OWbpBg5q+TFxnr1QzfXUqbRmE4Udn/vQ2871z2xfISaYzpJRxdim6CxGzVK+M+B2C
         TGPQ==
X-Gm-Message-State: AIVw1110ChRu3LJ173qC6lZZSy1gnX+SjreK/JQ0laK7H9P6BqU1tyWR
        rniExR7lMGGO3vxKtpA=
X-Received: by 10.28.32.70 with SMTP id g67mr4189187wmg.101.1499898079671;
        Wed, 12 Jul 2017 15:21:19 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id r200sm3444539wmd.20.2017.07.12.15.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 15:21:18 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/3] interpret-trailers: add --where, --if-exists, --if-missing
Date:   Thu, 13 Jul 2017 00:21:13 +0200
Message-Id: <20170712222116.7095-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

These options are useful to experiment with "git interpret-trailers"
without having to tinker with .gitconfig.  It can also be useful in the
oddball case where you want a different placement for the trailer.

Compared to "git -c", they are more easily discoverable, and also have
slightly different behavior because they override all trailer.*
configuration keys.

Paolo

v1->v2: support --no-* options, minor code fixes

Paolo Bonzini (3):
  trailers: create struct trailer_opts
  trailers: export action enums and corresponding lookup functions
  interpret-trailers: add options for actions

 Documentation/git-interpret-trailers.txt |  16 +++++
 builtin/interpret-trailers.c             |  44 ++++++++++---
 t/t7513-interpret-trailers.sh            |  66 ++++++++++++++++++++
 trailer.c                                | 102 ++++++++++++++++++++-----------
 trailer.h                                |  35 ++++++++++-
 5 files changed, 218 insertions(+), 45 deletions(-)

-- 
2.13.0

