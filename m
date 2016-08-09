Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2230F1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbcHILx0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804AbcHILxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:53:24 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0FEF3B71E
	for <git@vger.kernel.org>; Tue,  9 Aug 2016 11:53:23 +0000 (UTC)
Received: from [10.36.7.128] (vpn1-7-128.ams2.redhat.com [10.36.7.128])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u79BrMWD002846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 9 Aug 2016 07:53:23 -0400
From:	Michael Stahl <mstahl@redhat.com>
Subject: [PATCH] document git-repack interaction of pack.threads and
 pack.windowMemory
To:	git@vger.kernel.org
Organization: Red Hat
Message-ID: <db25fccf-ed85-3974-143d-2c50b3037642@redhat.com>
Date:	Tue, 9 Aug 2016 13:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 09 Aug 2016 11:53:23 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael Stahl <mstahl@redhat.com>
---
 Documentation/git-pack-objects.txt | 2 +-
 Documentation/git-repack.txt       | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 19cdcd0..0b655a5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -105,7 +105,7 @@ base-name::
 	advantage of the large window for the smaller objects.  The
 	size can be suffixed with "k", "m", or "g".
 	`--window-memory=0` makes memory usage unlimited, which is the
-	default.
+	default, unless the config variable `pack.windowMemory` is set.
 
 --max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c597523..300455b 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -101,7 +101,11 @@ other objects in that pack they already have locally.
 	advantage of the large window for the smaller objects.  The
 	size can be suffixed with "k", "m", or "g".
 	`--window-memory=0` makes memory usage unlimited, which is the
-	default.
+	default, unless the config variable `pack.windowMemory` is set.
+	Note that the actual memory usage will be multiplied
+	by the number of threads used by linkgit:git-pack-objects[1],
+	which is lacking a corresponding git-repack flag but can be
+	set via the config variable `pack.threads`.
 
 --max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
-- 
2.7.4

