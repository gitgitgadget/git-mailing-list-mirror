Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06FF20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934445AbdBQOTk (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:19:40 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32929 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOTh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:19:37 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so5069873pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjmhnSDriTqE8MXD8Q4O0wxE54t0BYXKWehAhvd19bU=;
        b=S0/Vj+ifpOo4jDoeems7BqBX1NzomqubrAXRZWWipDitLZdvcrKRcBZQZ2A4j4nrcl
         CVFvkkbG2MaOwp+MRwXUDh9FpMbuuR1IljprY/UwvJTofhHrjpV9L/eHscnust2Lsi8/
         FLJJCS+hvXAh0T+Ti4YuNAV1UlijOKOkshrMLyZp+R+PDO7CUpwLd8a0W2yFe/VjK7K+
         N3sAGd8IV7IbNKK0kk4o7LH6pPemNlfa8cAX4lPWqPz0igINaN7gZ4ysfZe4DV/n49pr
         ZDvhT9QmZhs7ZPaC4uZnLhdu+esyA+v5IyL5X09D4fjORSrfbgnGetHj/1OpMKc6tagy
         7WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjmhnSDriTqE8MXD8Q4O0wxE54t0BYXKWehAhvd19bU=;
        b=VtSsULb8CYcdkhlVy0a61FqWyZaVkHtlDPFix+ag6xgE/G8VhscUnJ6f0376sub+kA
         H3m9X1NGaOHdLkZH5SCMDdny7nmuPP7jeWjVdwBFjKqPVLOYn2OdirwCx3JxQLmKwMet
         Kp5an9WfRc+/df2r+zLDDF8fyA8y40NX3Jk5xL3rL3XsqfENHa3D7LtJ3Z+Tgrpj60pB
         EqExgqY0Bsv1n6xN6BLjgWkFu0LJkkmA2Mw1pnAqrbKKWuPsYivKnLOAwmmttt6nDMgM
         EbWxyk6PzkBW096DvhN3oQ8eD4wUZylMjiNZ6sVS0VB7+/pmEcZ1VWjjOOYsiwkD5xsI
         JlOQ==
X-Gm-Message-State: AMke39m3T+caMKN+eiSauo/8PbFFyU0LTaRUji2yplguosI3Es5Hvt6UDtmnlvRIwFyUsw==
X-Received: by 10.84.212.136 with SMTP id e8mr11662210pli.140.1487341171972;
        Fri, 17 Feb 2017 06:19:31 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 143sm20108775pgb.66.2017.02.17.06.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/15] revision.h: new flag in struct rev_info wrt. worktree-related refs
Date:   Fri, 17 Feb 2017 21:18:54 +0700
Message-Id: <20170217141908.18012-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision walker can walk through per-worktree refs like HEAD or
SHA-1 references in the index. These currently are from the current
worktree only. This new flag is added to change rev-list behavior in
this regard:

When single_worktree is set, only current worktree is considered. When
it is not set (which is the default), all worktrees are considered.

The default is chosen so because the two big components that rev-list
works with are object database (entirely shared between worktrees) and
refs (mostly shared). It makes sense that default behavior goes per-repo
too instead of per-worktree.

The flag will eventually be exposed as a rev-list argument with
documents. For now it stays internal until the new behavior is fully
implemented.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index 9fac1a607..c851b94ad 100644
--- a/revision.h
+++ b/revision.h
@@ -88,6 +88,7 @@ struct rev_info {
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
+			single_worktree:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-- 
2.11.0.157.gd943d85

