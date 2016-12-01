Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1841FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbcLATps (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:45:48 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34190 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757305AbcLATpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:45:34 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so98267925pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sr/2qXQmtv13TprooLVDXBQ4yeFcygd1T5w4C5UdZ7E=;
        b=ApOPURYOwlc0Pi1WRQBDC7VV4wQ+Sh0qJ1/AIKcq/zezOVd7E6LyJPYP+JQroIQVwS
         4K+vOjfAHO5DaqQyQJJdf02iFKhsr1KlTZ0S268dAEEH4Dd+Rd/MdqPDJ1dzG/q0SpEI
         QH1RzHgo7afS/9VrSUNlVt1evmk0wLroWE0ZsPotHBUBuPNgnTNgOXBVFDlcHg8dARU8
         aU8/WKDaBnNf6PMvUxRc0bSBbWpzXWsVS86hIktRLO8J25Fi1pbQXARrbeyz1jB6/K7K
         ed/HtFo+0CU2YFhRndmZR7lT56AgoMPgKGvRh/fVrCM+wzxIIk/miBEWGLB05oEfWHkB
         756A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sr/2qXQmtv13TprooLVDXBQ4yeFcygd1T5w4C5UdZ7E=;
        b=Xp5RNw8A11oii4Y/Sv2aaxWXgvMsAkR86w1QUUB5QUcg5n8/m8tNtrWyoQtFE6Ur7H
         8f4N/Jmi/D/NARVwK5hWyQtFpxJlIVPswwSDbHqFSAc0N0u9DP966MszajSKgrdWMZNs
         hTuSCJICSvWbx8SU4o4XJ1MvUdeOVbzAlK0yiBb4OFDOEN3vSsmMBgTfSjtNKHZ/BqrG
         ssscNRbUbuU3EKnWP4lN3UAgbCY2FiSZZTnUeB57q1ZN4TMwTAm6T5iGNJBxHMY1TNkL
         EBTuWVRo6VQFzK38M7ILcZs93dx+OuVg3+csIKpgc9VDmOYhGOg0KTFS4eqNxLSjxMBG
         B71A==
X-Gm-Message-State: AKaTC03Bmx/xohyujy7F2tPSNjKajxkdcyxZ4sXOeUFrAk26ftvBESEH98cpowfa8VrrHMjQ
X-Received: by 10.99.3.202 with SMTP id 193mr72021366pgd.157.1480621489463;
        Thu, 01 Dec 2016 11:44:49 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q145sm2090998pfq.22.2016.12.01.11.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:44:48 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v6 0/4] transport protocol policy configuration
Date:   Thu,  1 Dec 2016 11:44:03 -0800
Message-Id: <1480621447-52399-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478555462-132573-1-git-send-email-bmwill@google.com>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 introduces 2 additional patches which address problems with protocols that
libcurl is allowed to use for redirection.

Brandon Williams (4):
  lib-proto-disable: variable name fix
  transport: add protocol policy config option
  http: always warn if libcurl version is too old
  transport: check if protocol can be used on a redirect

 Documentation/config.txt         |  46 +++++++++++++
 Documentation/git.txt            |  38 ++++-------
 git-submodule.sh                 |  12 ++--
 http.c                           |  13 ++--
 t/lib-proto-disable.sh           | 142 ++++++++++++++++++++++++++++++++++++---
 t/t5509-fetch-push-namespaces.sh |   1 +
 t/t5802-connect-helper.sh        |   1 +
 transport.c                      |  82 +++++++++++++++++++---
 transport.h                      |  13 ++--
 9 files changed, 281 insertions(+), 67 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

