Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32091F403
	for <e@80x24.org>; Thu, 14 Jun 2018 08:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeFNIKC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 04:10:02 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:46466 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeFNIKB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 04:10:01 -0400
Received: by mail-oi0-f45.google.com with SMTP id h79-v6so4843279oig.13
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=caya9s6AduDd6ab9b1HHu1oOxURxt12GmgycGy3gnCg=;
        b=bcdPn6DW5eufv2pLBmkApe5anycuYfwBMVrisooQGOL3C3jyYSWxs/F0KXtcR6z6T0
         vru2rx16xpvJAfmJmEhwS6JZcJ/memCD9fHaC/OCx6IHtAorrsXQjgfJdV1LoTcF5hZ0
         x5wZmfxiGkRWBatUB+oWLQNaqq1cmcwau9lPaUmNXdgHd6TK+xE6tU1dqvcNMzssU0Vc
         FVOJzbKYKaQ8Wx13+bwMySPidSagnU2PB/sLe+x7na2j6O5lGGSChr/x30pKnHJzWCyX
         KEFBl4Az19Y0HYujbONd3tC5IFuueZlyiWQJxTFdyeby/J1Kst8vktGHEbqp5vKtDJKm
         yS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=caya9s6AduDd6ab9b1HHu1oOxURxt12GmgycGy3gnCg=;
        b=DFVmVi7nGmTCTQ/QjuKsEFIN3hIkjXthmMayBf80i21RgQVfmHLbYkQkAwiNmbs/Lg
         /Qz391zVJLxHVjtpGJXPaYXyYwhf10M/kF+HHvr+f9vsDnL0uqTvXrbwtc7uI2H8LtKE
         BVGP5W3kyMu2vCixrQ4YPyfuf7WcmaCokaeTL72XHF71Z6XuK8lobvLeO4LsJsI80eKD
         MwEMBchqA71WEcpOA3xtOMmAxToR9og1UdqHy6ueAdQs9xzgWUu1x3o9SwgvKCvwDJJ6
         MFgI3/OsaRLMoAX5ssEJBFVIOXRjL3E0aL1Tzb5j4dwWy2pmh+58TUnlrPP5HImB+pcs
         QYEQ==
X-Gm-Message-State: APt69E2LDfLXSnnma+3oqYB7XvsZh9YCtd4lKK5cPxrYT7w4Hc7mCsNl
        gkUzXvApQhkvjAe829XIieNPh1AwRcBVzNxNosFNTg==
X-Google-Smtp-Source: ADUXVKJ4GyBJQOW0WoQsj7u0EaioFUTvWfQG6UaNSCfnzxLfZShug6vk/uP7tJ9mxqi5NIW1zmG+UiFJSuSCzQk/7Yk=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr786799oia.44.1528963800197;
 Thu, 14 Jun 2018 01:10:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:754f:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:09:39
 -0700 (PDT)
From:   Christian Halstrick <christian.halstrick@gmail.com>
Date:   Thu, 14 Jun 2018 10:09:39 +0200
Message-ID: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
Subject: OAuth2 support in git?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can I use native git as client to contact a git server which does
authentication with OAuth2 Client Credentials Grant [1]?

Background: We are running gerrit based git servers [2] in a cloud
environment. That environment supports OAuth2 authorization for the
apps running in the cloud. The idea is that clients (e.g. jenkins
jobs) talking git over http with such git servers should be able to
use OAuth2 tokens to authenticate clone/fetch requests. We would have
to adapt gerrit source code for token handling/validation but I am
asking here about the client side.

I know that other git server environments like github support that on
client side by allowing tokens to be used as usernames in a BASIC
authentication flow. We could do the same but I am asking whether
there is also a way to transport tokens in a standard conform
"Authorization: Bearer ..." Header field.

[1] https://tools.ietf.org/html/rfc6749#section-4.4
[2] https://www.gerritcodereview.com/
