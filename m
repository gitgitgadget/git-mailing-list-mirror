Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6300C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352648AbiHSVaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352587AbiHSVaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:24 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E415104B3A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q8so4253556qvr.9
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=arZxlmoQFLEphCbCK0kNlqnrKdx4dYYcctDBCHQpTIU=;
        b=O50MoVHV4EdF9g0YccLN9tiwDuLLk4iT4B1yR8EKFivXMDv9tcmPV/b1Vf/uKFqXBg
         Pw+bFz4GV7BVh/jvbwuik/LSL7dF5lNewMhN+nRSWiIVZpru+gP9KbEjx23Ab9NTi+yu
         0iiFuioHGFV4GicD8VnsjvOJhKx6jr/jWutLfVG90DDU0Ifqb6VWYuqtSssBPjqLjRQM
         V9IBEN5+MLTQYuAQ5r+d/S9TIPH8YWRBa8n9gLhiTB1WNogdE0KvpkpOsLRdjuSsqBiI
         pj4+ALIn8xvkeaZpmFceM5moYAPwfYMLSLDXNhSJNdt23x/Z+r4PZ6e+iju63DKXKjOK
         tq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=arZxlmoQFLEphCbCK0kNlqnrKdx4dYYcctDBCHQpTIU=;
        b=um49+jFUn7PqvrofrxUGMlKjVAz5DwbBWhQzg3OmJh/fRSCcdT48daDqZAvIJLMDHX
         hwe/XMTrDFEHVYzU+OKZLFnMv+TkuSqn0zujP3PyptLPt1GK8CV5rcylOn6WzzdPzTZ+
         Pcx7BeOX8WUknn5ebYlwbpfwGZLErX3WAB+39RItGs7+kEXZlh6BGjA2K2O3ulBVmpzK
         SHb1VB6W3T2pbear7QYUQ/tTJasbpitjPRaxYGyqV0yAVOmv5B/lXv7w9VMw2ryx9uWG
         ShJcqS6rK2FX1AQFXhiQNapfzl4DhAOHXYmH7qQP54D65DXqxf7aryiVgjh8rG08HNdx
         mscA==
X-Gm-Message-State: ACgBeo2v0KYmKsMKULpCHusO5B2JUuLoiGDQJXgx1Mzr+WKkxTnldzHC
        Amu/12hWJInRso/6coLt/USVcq0qmtfrBFFp
X-Google-Smtp-Source: AA6agR7FcpOJiEk6kHZbHZuIs+0dak1Y05WSoqKEDzqlbndU2DnDESadl2snwBRbLgilAf3fnNs49w==
X-Received: by 2002:a05:6214:c8f:b0:491:76f9:b318 with SMTP id r15-20020a0562140c8f00b0049176f9b318mr7914899qvr.22.1660944622506;
        Fri, 19 Aug 2022 14:30:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f12-20020a05622a104c00b003438a8e842fsm4185133qte.44.2022.08.19.14.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:22 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 5/6] midx.c: extract `midx_fanout_add_pack_fanout()`
Message-ID: <db1c6ea8e5e9280db478f7452f725029fec747e8.1660944574.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a routine to add all objects whose object ID's first byte is
`cur_fanout` from a given pack (identified by its index into the `struct
pack_info` array maintained by the MIDX writing routine).

Unlike the previous extraction (for `midx_fanout_add_midx_fanout()`),
this function will be called twice, once for all new packs, and again
for the preferred pack (if it appears in an existing MIDX). The latter
change is to resolve the bug described a few patches ago, and will be
made in the subsequent commit.

Similar to the previous refactoring, this function also enhances the
readability of its caller in `get_sorted_entries()`.

Its functionality is unchanged in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/midx.c b/midx.c
index 0d40089c4d..be8186eec2 100644
--- a/midx.c
+++ b/midx.c
@@ -618,6 +618,31 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 	}
 }
 
+static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
+					struct pack_info *info,
+					uint32_t cur_pack,
+					int preferred,
+					uint32_t cur_fanout)
+{
+	struct packed_git *pack = info[cur_pack].p;
+	uint32_t start = 0, end;
+	uint32_t cur_object;
+
+	if (cur_fanout)
+		start = get_pack_fanout(pack, cur_fanout - 1);
+	end = get_pack_fanout(pack, cur_fanout);
+
+	for (cur_object = start; cur_object < end; cur_object++) {
+		midx_fanout_grow(fanout, fanout->nr + 1);
+		fill_pack_entry(cur_pack,
+				info[cur_pack].p,
+				cur_object,
+				&fanout->entries[fanout->nr],
+				preferred);
+		fanout->nr++;
+	}
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -663,22 +688,10 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						    cur_fanout);
 
 		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
-			uint32_t start = 0, end;
 			int preferred = cur_pack == preferred_pack;
-
-			if (cur_fanout)
-				start = get_pack_fanout(info[cur_pack].p, cur_fanout - 1);
-			end = get_pack_fanout(info[cur_pack].p, cur_fanout);
-
-			for (cur_object = start; cur_object < end; cur_object++) {
-				midx_fanout_grow(&fanout, fanout.nr + 1);
-				fill_pack_entry(cur_pack,
-						info[cur_pack].p,
-						cur_object,
-						&fanout.entries[fanout.nr],
-						preferred);
-				fanout.nr++;
-			}
+			midx_fanout_add_pack_fanout(&fanout,
+						    info, cur_pack,
+						    preferred, cur_fanout);
 		}
 
 		midx_fanout_sort(&fanout);
-- 
2.37.0.1.g1379af2e9d

