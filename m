Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D94F1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbdBPMDt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:03:49 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34586 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdBPMDs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:03:48 -0500
Received: by mail-pf0-f177.google.com with SMTP id e4so5441378pfg.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nuyFC+B1kuXHpQ0wOBTImWJkjeFdMgURHxG6JeWs04=;
        b=oJErNHd9WLE9iq1X+XPlOhWV74cGvcCp1pHpnT+u7sM3mj34F0bDjVI4exPdxOj84K
         /u8hMo0TP0EXkb3+k+wytdn+iVwHauxqChOxdo+nhJTURn94DtZgqfu5PnKD0ILAAU01
         zuje0QskZ1msF/kb+c3HAsvSdIdJWSLmBX1wFT61pudEH4XbhDuNHIpZwh+f8TTyFSOa
         uoyu68igX7sbconq+FzkI4+XVw71uPUrxRZ9OoUVMAZjh9rRBDL9vr8H50XP2dNrTPgJ
         ZwjnF6uP1dObxovcsq72/ACj/w3KG868wnc8PN6y5Yf2W+cfm3YKpscJzs8Tdis6Hsll
         wpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nuyFC+B1kuXHpQ0wOBTImWJkjeFdMgURHxG6JeWs04=;
        b=cFFIbpMMXLiqm6Bov+weYcLA2v5RFkgqPQqZNZaiz+2jJ+wBglXEWKWF4dvFkuPrKV
         p96HFdZbTvfOqFtlZPuXL2LWTWKi9phlPO6RyOJjcYV3qc0d+Tjv0j+xUZuEtP8lG4k6
         VhLZBNFJNbvbzYsZdIUuRuaJCGFDbgquWWwfstCnutDOO053Wr7BcA9fsn20Po3AF/Ht
         NP+l7gJqde9LSCV4O38btnqVIHVUhUfMOnCOg/g5vnufzjASVHlbOGsnREdeE6+DZoLs
         jms34mBAFfSZnmtaLBMsx7xiatrxhXwr1xdi3wq6beyUC3v5dZswFDUrxQTzCl4wsXp5
         3tOQ==
X-Gm-Message-State: AMke39n8vB6kCh8GyGOgo+8g8lOLzSck1GAqmbaP/4/dJFv+A/+grmwcfvTwar0Q2HWr3A==
X-Received: by 10.84.233.134 with SMTP id l6mr2697548plk.49.1487246628226;
        Thu, 16 Feb 2017 04:03:48 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t87sm13408666pfe.59.2017.02.16.04.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 04:03:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 19:03:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/5]  Kill manual ref parsing code in worktree.c
Date:   Thu, 16 Feb 2017 19:02:57 +0700
Message-Id: <20170216120302.5302-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170208113144.8201-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 still kills parse_ref(), but the series now depends on my other
series [1] and as a result does not make any confusing "submodule"
calls any more.

It also kills another function, introduced for multi-worktree, that
should not have been there to begin with. Good riddance.

Again, the naming convention with refs_ prefix for new APIs may not be
the best idea...

[1] public-inbox.org/git/20170213152011.12050-1-pclouds@gmail.com

Nguyễn Thái Ngọc Duy (5):
  refs: introduce get_worktree_ref_store()
  refs.c: add refs_resolve_ref_unsafe()
  worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
  refs: add refs_create_symref()
  refs: kill set_worktree_head_symref()

 branch.c             |  15 ++++----
 refs.c               |  58 ++++++++++++++++++++++++-----
 refs.h               |  21 ++++++-----
 refs/files-backend.c |  43 +---------------------
 refs/refs-internal.h |   5 ---
 worktree.c           | 102 ++++++++++++++-------------------------------------
 worktree.h           |   2 +-
 7 files changed, 98 insertions(+), 148 deletions(-)

-- 
2.11.0.157.gd943d85

