Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751A41F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbfKHUI1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38660 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbfKHUIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so5341641pfp.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vpfICAP3d5WqeBWCy5bXSXu/nCu+BGQpwQeeO3/PNc=;
        b=UVGyzm9HjvX7cfzPGXVE7jORtSsQOx9Jx/jzW5/AUle6qeq6EdBZTGQ0qUaB3TXho0
         jpuX6FJ17sG/2ncz4AZ628aoiZcZhBIurmUvhmYdM+hvKzIS1b7qdg9MT0XzrkLXzbCL
         dlOD3v+460HxtO9UpIUjq91NZCnHFbR/GhABGhBP1IoIe/E0iuNO3Kwdp8KMFJUhl1vT
         Fgo+awRt1bBNvq5gRKCY0PZi4wBU6RJU6iPPXx9ou59EOEp48JN/fDoIK8f9zL+R6VIZ
         HIGdYEmc4elQ02naJIdIU2WODB9oHvfzd6rbyVpbSNowIX7fEbFrqzkmjPS+P48K9tLE
         IKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vpfICAP3d5WqeBWCy5bXSXu/nCu+BGQpwQeeO3/PNc=;
        b=R3IP+VvrfIp+oJFWfxqkOoW3PzvllG20H5OawOHQ6mZfF7noUoG9L+/d4cG8zQ/Imu
         Cn1e/5d5L8Cu/Ae1sK3awV6rkghWtjOUS9BBMaqWvqS2YHqT6bJgosCfWcgPGFjWkyc/
         onDIyq3ORE2BJzBPAYfE+zz5wqJxCarP1RV0GeN2NkXEWd2jrXodYtvYSOnT9UAUrGaV
         GoC3qwh/JvA3tl1D7VaL0LSJwb8TX+Gk3Mxs5hLXAIgsxoaRPvVFDgghtHcZ44UKpTAc
         KYIa7XlDS11wFQ8qJqEV5UBELWUptNlmRBKqTHsCQ0fejAL7Yox0HvS1r9reWiOjZ9Hz
         c9Ww==
X-Gm-Message-State: APjAAAUSADZG79bkiOWyXMt3EbHMJzsCbdqpMphZgyA6qLPltiy/Fjca
        AJwmdPEEikcU8BVPxsTkvldp3XZE
X-Google-Smtp-Source: APXvYqyKoTj8Mg7d8by6C/TnKuQqeJPpqhlTDpSWCGOwRUnA+EDJlA0aqC3aeRQAIC1PZkG9dXwhvA==
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr16018546pjb.18.1573243703321;
        Fri, 08 Nov 2019 12:08:23 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id j14sm6622925pje.17.2019.11.08.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:22 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/10] revision: make get_revision_mark() return const
 pointer
Message-ID: <b31cffd5effc3a25c063498cfbbcb7c69d8f6e6f.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_revision_mark() used to return a `char *`, even though all of the
strings it was returning were string literals. Make get_revision_mark()
return a `const char *` so that callers won't be tempted to modify the
returned string.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 revision.c | 4 ++--
 revision.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 0e39b2b8a5..2151b119b7 100644
--- a/revision.c
+++ b/revision.c
@@ -3944,7 +3944,7 @@ struct commit *get_revision(struct rev_info *revs)
 	return c;
 }
 
-char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
+const char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
 	if (commit->object.flags & BOUNDARY)
 		return "-";
@@ -3966,7 +3966,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 
 void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
-	char *mark = get_revision_mark(revs, commit);
+	const char *mark = get_revision_mark(revs, commit);
 	if (!strlen(mark))
 		return;
 	fputs(mark, stdout);
diff --git a/revision.h b/revision.h
index 4134dc6029..addd69410b 100644
--- a/revision.h
+++ b/revision.h
@@ -322,8 +322,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 void reset_revision_walk(void);
 int prepare_revision_walk(struct rev_info *revs);
 struct commit *get_revision(struct rev_info *revs);
-char *get_revision_mark(const struct rev_info *revs,
-			const struct commit *commit);
+const char *get_revision_mark(const struct rev_info *revs,
+			      const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
-- 
2.24.0.298.g3e88fbd976

