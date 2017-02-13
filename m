Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7341FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbdBMPVA (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:21:00 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36739 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbdBMPU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:20:58 -0500
Received: by mail-ot0-f196.google.com with SMTP id 36so11908512otx.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiD/H4Nufnbe0cOIQ7LP8avhtOxNo4kDIIKtkQGAKKA=;
        b=J/8JrS9nEl+k6C9q/GXuODsTJTlioXROxHyO7kIC9I42mfuBUWLZYnbtxMaGGkP6Rf
         tmRk4twX/wA9i/L7eMx+b/gROMkAgzDKbT7SXQOdKBSK+nU3jvOgD7Ia4uqYHgorki8K
         pSMru3tPqO9nYzinrWWrjoqHTtQiDjW1lBEb2C4/UMJyyO2cTbQ6ttT9fQX07uuIhZjf
         XGEtWoxcWbIgygnn0mKCl4B6N9w50OiQc9cJvygt71ohxKzMqG3Hmr3aAhLxglWEAj4q
         YIyCYYGYKzcKPQ9BQKkCQ3fQskpmE6jXZyx8MXnZ+f5MNTM9+aFH9TUON6wjwiWWok6/
         FLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiD/H4Nufnbe0cOIQ7LP8avhtOxNo4kDIIKtkQGAKKA=;
        b=rUpxn32BNFurYRCOSRepA58YxK8wrbMgTV41tjIgza9ZJJhTpj6hmjfz4Nae5Ak+3c
         zTOm3HSkzL+ETRHBf5aIsDJyig7RF8QEmYzYXg2EF5g+2b0fT5SJWSuoGZD07aHPSQ/L
         EAZwRcpeoSn6kyCWde/p+ckYgI2El32MI2uhaIF5AuSp/lNCgf2T917aw093iTjt6WUQ
         zx74pw7yVu4PGVLXe9yretwmUjnCWNQOX/zpyU8yGtyRCegsxQU605BaVx6GO6lOUxRi
         iQy0Mklr/MkziQ8vcZp1cabHRwsWATxaEyVTExoUPqBMOAF5DX/WNE6LIT5m8VBkSn3t
         ELAg==
X-Gm-Message-State: AMke39kDftGNgfWnPcHhBywPKek/3Vd3lzVNiRrKpb4bcRyMQ+R+e89gQJlPowMXwCjBTQ==
X-Received: by 10.99.100.70 with SMTP id y67mr27000945pgb.74.1486999252458;
        Mon, 13 Feb 2017 07:20:52 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id u24sm21697182pfi.25.2017.02.13.07.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:20:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/11] refs-internal.h: correct is_per_worktree_ref()
Date:   Mon, 13 Feb 2017 22:20:06 +0700
Message-Id: <20170213152011.12050-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All refs outside refs/ directory is per-worktree, not just HEAD.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/refs-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f4aed49f5..69d02b6ba 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,7 +653,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 
 static inline int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
+	return !starts_with(refname, "refs/") ||
 		starts_with(refname, "refs/bisect/");
 }
 
-- 
2.11.0.157.gd943d85

