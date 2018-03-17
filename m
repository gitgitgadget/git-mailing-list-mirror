Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EEC1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeCQWFw (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:05:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32979 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCQWFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:05:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id s206so7431241wme.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nXG+FGVatg8zKFJuaUxk42EVDqGzovL5SsgKwe4Fag4=;
        b=dP/lZ7mVvJ/K2ek0/y2O9M94eIq9AcjpGGLC1JLPjVdk/P9s4d3ZvMn6Lz0cO3wLFY
         A2FkwHX84AyVKXm98Ty4fSq1WTBbXVuNw0HEqPUCC+ISyEH35+6l8BaaOtUzdJEMlTxq
         mAAVR/6WZXX26udPKrNGwnn6mNByWgm67TRvA2nlIDbiwuCczxmsE37Xlr617z1DD1lp
         thB2Vbo197bSS/h0AZ6tBT7vuu0DoJAQufoCKLHyBWFALrhLZTXbn9gD8j/gxtfuQxd9
         HcU5j98VfBOWyRJuLbSGqNlhdTHhnAsH1wObmlo+5g57/31eAQlJ2RH9zZ8DL9QECeoL
         SzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nXG+FGVatg8zKFJuaUxk42EVDqGzovL5SsgKwe4Fag4=;
        b=uoJq+KNn/n/z7sWhA7ChIXh5KTE2fW4ZzDSqpVcEQymoV1dl7w1vWRzvJCwLmHmZ0S
         j9H9xzeFEchXCL2bh4jWUzRggYLIWeY6m7lWQoUq+7fTK2c8dTDbuBolkPSG2Tkhv7e6
         l4JmekD3iB0i2kdZRmuew1PWhrHBf2ciSzPuCQUkU60LlHhPsGdZrLHXqiHTVtICA8VD
         RzpGZ07Im21JGvgKGOH8NV1vt9F/znp0o25vVy48l/R/1Y95q2doVX6YY/5YCOpngODX
         sweScVbGIplFeVHRJLS3+4zTMWAyLDLzfPj+/Gsgj0VFNo2/q18XGj5cxdG9HdVBb7vU
         aG3g==
X-Gm-Message-State: AElRT7ESMTkMTGDtA0NjZRyK/YSLTOtkLc1qM7evfR7KE03K+eBPUMB+
        0NEIT4/Zp+/UH9IRt/jntdX7yoH5
X-Google-Smtp-Source: AG47ELv8b+xMTP3CH9KzTY5PhuyJSBYQ7j5FopXSoeeFFsmsE45NtyPROY35ySwfzbvj4LSI9MHCxA==
X-Received: by 10.28.238.2 with SMTP id m2mr4568461wmh.135.1521324349539;
        Sat, 17 Mar 2018 15:05:49 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id n190sm5525096wmb.15.2018.03.17.15.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:05:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/4] worktree: be clearer when "add" dwim-ery kicks in
Date:   Sat, 17 Mar 2018 22:08:28 +0000
Message-Id: <20180317220830.30963-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317220830.30963-1-t.gummerer@gmail.com>
References: <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180317220830.30963-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no indication in the "git worktree add" output that
a new branch was created.  This would be especially useful information
in the case where the dwim of "git worktree add <path>" kicks in, as the
user didn't explicitly ask for a new branch, but we create one from
them.

Print some additional output showing that a branch was created and the
branch name to help the user.

This will also be useful in the next commit, which introduces a new kind
of dwim-ery of checking out the branch if it exists instead of refusing
to create a new worktree in that case, and where it's nice to tell the
user which kind of dwim-ery kicked in.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e5d04f0b4b..2266c132f9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	if (opts->new_branch)
+		fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
+
 	fprintf(stderr, _("worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
-- 
2.17.0.rc0.231.g781580f06

