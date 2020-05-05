Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE8C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862B520658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PGDvIRcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEEBNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbgEEBNq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F727C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so519935pjo.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jK+Rwt+nS7OjuO/flIwEQvarAHH/qY14AqXmcGd1LX4=;
        b=PGDvIRcRN33oW4g5LxEWunGv/Ooy466u0jR4JpB98FVDzYQDDNfZ+3EoFDlP7K+5l0
         /Hst/OyqML9Yk2q3dk3HFQfgHpB8tPzmIR74+h4PMlKAs3ZXnIWUUbtX/AS+4DS68anF
         iLhH7//AGd9H6f/WdPm4g13J4mSiFbpKTK/sM6q0pB2jg1VEMC7BmRmMWJXEC25MxICu
         eG6EqyKE1r9hAUMEdIknNVX2eMHMbMhEpjZafGPHL1K2wnLvFILtD7/oX3MB0YhSUB1r
         Rk0L9/P4fjCi3yvmLHVDEe5ZlwDYzKiTzV9e3j6u5KpTuVSeDDBSUx/AuSnhhumIOxYn
         ij6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jK+Rwt+nS7OjuO/flIwEQvarAHH/qY14AqXmcGd1LX4=;
        b=c/kynbKJc18/J7sfoxrH04t7wKI5Aqyu77vclc1Hb9cjsBZ1pDjVGrA7obsBTPwK+J
         t/QdDA6IrhnFmRXO8NCh7NCp1/chZsQPH6bl5mSJEjqfdBhx3bTt9OlxtOKIIykFxcgk
         aehTJEUPROmVzVhtm3+LfUwzP9FJ1FLm66vv5OfiRLwkWYpbRWXpgHKyMikEJHGqO/Kz
         GPZujZmk2FGluoc5tfuVBWzTb4aQiBYZKtZYOmc/N83kRanKtmLn1+TpdJNHv1Umd8Hz
         aJ7mZ+C/Y7E59qUc7YRk7YDH/ChuhtGFlnyZ12TWQx+xB+VRe7MCnPHMkV09SZsqhJT1
         hg+g==
X-Gm-Message-State: AGi0PuaecuY/4Fy2k0eJBrcOhRONjC5dwL2rGLJZT5AQO1ht5wZx3nbs
        aXJ2hmhcOqdBvYCsuS/Ha+ZhufNR8+s5IA==
X-Google-Smtp-Source: APiQypIk2j0V7wyQd6Rsn60XDNIEF1l3oBF/Z4gpSVdsPIj3Z0+kElK0MgYK8AHAo79kV06EJeKTrQ==
X-Received: by 2002:a17:90a:e28c:: with SMTP id d12mr59250pjz.19.1588641224731;
        Mon, 04 May 2020 18:13:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b15sm297483pfd.139.2020.05.04.18.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:44 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:43 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 3/8] commit-graph.c: peel refs in 'add_ref_to_set'
Message-ID: <5ff56feab55b005b4a4d9559909ce7a08e5fa81e.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While iterating references (to discover the set of commits to write to
the commit-graph with 'git commit-graph write --reachable'),
'add_ref_to_set' can save 'fill_oids_from_commits()' some time by
peeling the references beforehand.

Move peeling out of 'fill_oids_from_commits()' and into
'add_ref_to_set()' to use 'peel_ref()' instead of 'deref_tag()'. Doing
so allows the commit-graph machinery to use the peeled value from
'$GIT_DIR/packed-refs' instead of having to load and parse tags.

While we're at it, discard non-commit objects reachable from ref tips.
This would be done automatically by 'fill_oids_from_commits()', but such
functionality will be removed in a subsequent patch after the call to
'lookup_commit_reference_gently' is dropped (at which point a non-commit
object in the commits oidset will become an error).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8f61256b0a..5c3fad0dd7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1327,11 +1327,15 @@ static int add_ref_to_set(const char *refname,
 			  const struct object_id *oid,
 			  int flags, void *cb_data)
 {
+	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
 	display_progress(data->progress, oidset_size(data->commits) + 1);
 
-	oidset_insert(data->commits, oid);
+	if (peel_ref(refname, &peeled))
+		peeled = *oid;
+	if (oid_object_info(the_repository, &peeled, NULL) == OBJ_COMMIT)
+		oidset_insert(data->commits, &peeled);
 	return 0;
 }
 
-- 
2.26.0.113.ge9739cdccc

