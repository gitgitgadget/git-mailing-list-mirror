Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6691FF6D
	for <e@80x24.org>; Wed, 14 Dec 2016 22:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935048AbcLNWkW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:22 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33575 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbcLNWkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:19 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so12528571pgd.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xkSjYNCjq6Y5+Q1pG9AMXjaqshic0OAGItoWZRciaXc=;
        b=W6Fk/YhBedcgpBm9fvHWmPl3aUrFhHAwdoj0W20nWfOHLfjEJz5/hZVUAT4BjBH/sl
         wHel++E2ecWG8G/WU9g1YjEBL6h8Qt4TN5XLP6leAhmUmycZ3UqcQbYt23QW8knhtCfq
         wJ7cV+pThYd5naVBgCssfldEK7BiADPfnN0R2yU1OfJTng6/0GDdbl0Q8jX3GXvDD3ZO
         l3bcrQOCufVPl58mUXSSC1ivLgIL0tUyrSEAjeivonLB1NHP5rgrlDw4mLMudBtPNZXJ
         4PKjYkMvSOrn4UOMjBskDCdKE8Ghb921vR682VCn1EI77zX6NP3I/3ACtcYZBC7neuFR
         yZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xkSjYNCjq6Y5+Q1pG9AMXjaqshic0OAGItoWZRciaXc=;
        b=txaUK3L0MxOrWllYM8pgHfUujdtHRxKUV1IpZoDHEabUs94a/tX4a0F1gUh+fiRG6r
         KDb+CIsDOrUyM2Vd5XeHsuC6pKfJhGlZZSsdFoCj9CZfjy2pTrmD3OWXSyXdT/4o2nON
         OsdAq+HV5s5429XI6cIQeBsg65yND1woi3mgfOQmfnZOVSama5as2oRROcmyhDjSGFgZ
         uZilHGPgV+LVySAsc0atBmWw3bjr2j3YbYBzv1CrKZS2ODSDzfXtzgvCH0gHBVIHv2id
         0Vo31Q1Yb3CwjDmOnTbXpnrp6/kOoYI9FqbeSO8bE3ikZzSAbox9z7idljIYpxK2UtfK
         HXZQ==
X-Gm-Message-State: AKaTC01pi2K5ypmDTnRZ5bKbinpO7p4DalQ038vVuWrDhDgma07zWh4Gm+mn5RHLRpETUphu
X-Received: by 10.99.44.84 with SMTP id s81mr189629354pgs.153.1481755213631;
        Wed, 14 Dec 2016 14:40:13 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:12 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH v10 0/6] transport protocol policy configuration
Date:   Wed, 14 Dec 2016 14:39:49 -0800
Message-Id: <1481755195-174539-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481679637-133137-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v10 of this series fixes the following:
* A few updates to the commit messages in order to better convey the reasoning
  behind the a few of the patches.
* Additional test to verify that curl redirects respect configured protocol
  policies.
* Patch added by Jeff King to make http alternates respect configured
  protocol policies.

Brandon Williams (5):
  lib-proto-disable: variable name fix
  http: always warn if libcurl version is too old
  transport: add protocol policy config option
  http: create function to get curl allowed protocols
  transport: add from_user parameter to is_transport_allowed

Jeff King (1):
  http: respect protocol.*.allow=user for http-alternates

 Documentation/config.txt         |  46 +++++++++++++
 Documentation/git.txt            |  38 ++++-------
 git-submodule.sh                 |  12 ++--
 http-walker.c                    |  52 +++++++++++---
 http.c                           |  36 ++++++----
 t/lib-proto-disable.sh           | 142 ++++++++++++++++++++++++++++++++++++---
 t/t5509-fetch-push-namespaces.sh |   1 +
 t/t5550-http-fetch-dumb.sh       |  10 +++
 t/t5802-connect-helper.sh        |   1 +
 t/t5812-proto-disable-http.sh    |   7 ++
 transport.c                      |  84 ++++++++++++++++++++---
 transport.h                      |  19 +++---
 12 files changed, 363 insertions(+), 85 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

