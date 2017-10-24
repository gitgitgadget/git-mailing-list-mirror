Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B039B1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdJXS7Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:59:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54210 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdJXS7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:59:23 -0400
Received: by mail-it0-f65.google.com with SMTP id n195so11279186itg.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MNxUcIB0vn++MkCfZry3CLSI8QXjvDqysOF+D2qLzoI=;
        b=dFmSQaWwKnQ4sHkOwrvfoxzTD4qSRmUAinRSYXCsy6+F6byl18ABC9UagiVyBIh2zC
         8PKQ/IdwK7VspqXqh936myc/w5pFO1VPfeCTxm0WNaSI0v8wjCGCEbTIhJlc8JQ0Qwy3
         D2Ypr2p19njkRRJAN9QnNaaRPDZ1eT9PxZybUzfHyWRlQn84Ioq5D71oaGRjjJ3IPl4y
         +hMsQD5UiL+xHGbXfEb8/l0SomgAUJRGDwz/rGUSGxvHZJypcPlec9UuJh+7c7sbkfJJ
         bpj+zrd5c/Ly28hoA3CPA9RmnKGwMX/U3d/7s61EcQNcHHwD1j6pQAj/76OyXIg+j+r5
         lFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MNxUcIB0vn++MkCfZry3CLSI8QXjvDqysOF+D2qLzoI=;
        b=UjTNKDhk5QDvPRnCuiQWuRF/P1umm8fw9wU1UfvOgYBb26L6WfyKfOzfjt6dLmZTA9
         a0tPuCEj4kzaBosVMMAcNnkxsC4KpwPfKOHPI8YgOWA1QOe9bCQSaE3d4qLSS8ygz0Ef
         7ZqUHNwWKgR2zr6LdgHGxPzrgzj1LvfPUKcD3oQbPYeF+i/pi9bkDggOgKsog2SAyfwT
         bM3gmYDvwrqJagWohKj3OAhTyUpnUVnxhDCzrDzghJ11K4RAI87k7IrRUm2Cbtya3PHs
         FAkUkjSJowKR2iEHFAmlFObkA5/JoiGxE8zdOr3/s8iFYEhne13dgkrGVFnudd/KnsHm
         3q2A==
X-Gm-Message-State: AMCzsaW/IdhILeB0klb7zayNLG2oJNx8lquv90vEPH6U3ZTespKcPr+A
        +swOmhdycXI+MpaYIYQTC4C3ibD+IoE=
X-Google-Smtp-Source: ABhQp+TtpZC1/ktl2BFw2A5eJ62nXpdvJEeAkwagvqXAlZtKmKbgdjJSowjTPf2J0suxcgEQoQTMHw==
X-Received: by 10.36.115.197 with SMTP id y188mr73658itb.98.1508871561883;
        Tue, 24 Oct 2017 11:59:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id z8sm402971itc.41.2017.10.24.11.59.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:59:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] (x)diff cleanup: remove duplicate code
Date:   Tue, 24 Oct 2017 11:59:13 -0700
Message-Id: <20171024185917.20515-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio wrote:

>  * I was hoping that the next_byte() and string_hash() thing, once
>    they are cleaned up, will eventually be shared with the xdiff/
>    code at the lower layer, which needs to do pretty much the same
>    in order to implement various whitespace ignoring options.  I am
>    not sure how well the approach taken by the WIP patch meshes with
>    the needs of the lower layer.

This series does exactly this; although I chose to reuse the code in
xdiff/xutils.c instead of the new fancy next_byte/string_hash, as that
code has seen more exercise already (hence I assume it has fewer bugs
if any as well as its performance implications are well understood).

However to do so, we need to pollute xdiff/xutils.c and include
hashmap.h there (which also requires cache.h as that header has
an inline function using BUG()), which I find a bit unfortunate but
worth the trade off of using better tested code.

Thanks,
Stefan

Stefan Beller (4):
  hashmap: introduce memhash_feed to access the internals of FNV-1 hash
  xdiff-interface: export comparing and hashing strings
  xdiff: use stronger hash function internally
  diff.c: get rid of duplicate implementation

 diff.c            | 82 +++----------------------------------------------------
 hashmap.c         |  7 ++++-
 hashmap.h         |  3 ++
 xdiff-interface.c | 11 ++++++++
 xdiff-interface.h |  5 ++++
 xdiff/xutils.c    | 19 ++++++-------
 6 files changed, 37 insertions(+), 90 deletions(-)

-- 
2.15.0.rc2.6.g953226eb5f

