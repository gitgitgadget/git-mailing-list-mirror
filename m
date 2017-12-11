Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0921F404
	for <e@80x24.org>; Mon, 11 Dec 2017 13:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbdLKNoT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 08:44:19 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:45586 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbdLKNoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 08:44:19 -0500
Received: by mail-wm0-f50.google.com with SMTP id 9so14514819wme.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 05:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tCpZOlIdOPrFBhTv8/t5f4062IC2Gp8Xkmsd/Jb9GFs=;
        b=uPtJKWd7VpFS9ef/eXDVLPkZfeoGYSp0k9QNmOYzZrDuNF+eFqi+ypWaX/VGksxfo+
         jK53CD3GwWbKbuFovZZb35ODZdJJaNoHTP56tJQCsjsCBzxJ+fwXkWSLAeIxbyFUsyw9
         WMDXEzANHIowjMIUW9o/eoVdoA2hmk/hi3zZMT9Ny9mlaxLqtcnbPkRWL++K1tSPncCu
         EJ1UT9fqKeCa54+iMpXdCz7oWIHwI6pMxMDSDnHXxH4srNRIp1wxT+3jJFfxlwhvOrB2
         OZq1Wq0/Rjrxe+VshYSlLDHAh31acIfi4of6DYZl6+H8S9mS/8b5Wg6E8u1onk+RNypU
         oRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCpZOlIdOPrFBhTv8/t5f4062IC2Gp8Xkmsd/Jb9GFs=;
        b=m3tSkXej84n4BkbTk1QUHOCpVdzV98402OxSJziwVVzfA9w5Q1vRmWoyxozEvtCnKe
         jzE0f1vupv3XZnkbwcLoqWQM21bJ7Z+I6bh/L+3PtVDZz0XIRS/E1AoTluHf+aNXbVIa
         mcnqtLhmJ8A+4fYhFtkyGqWuITOwTMUYO2Ok1KYhSpyvsJYRL2YjKWOQNNf1pgTLcUQo
         tFL1gMojcq4ONF+cuPuNRcLuVVjZHsZMPdPn0dW0DsK5BjpNOZvAG9CMElSu9yeTwO+b
         7OHYQA7FgthumdRvfzMDl5nVxpnO+HGcB8aw5i5M5lLgiqWQkLTIpYHNtc0BqfPayu4O
         qVsQ==
X-Gm-Message-State: AKGB3mJ9QjFuVH5R92ccLRLuYCJ+70BZXJO+QvN5RDmakXM40BV7LRmL
        kz0e/xIcHq9Oyv4x3vKzLxtjcHMJwro=
X-Google-Smtp-Source: ACJfBosbe+NaUn+rshjws3geB/MvmAYFdh+sJArO880iMc3bmHTErpE7GBodViXkPWBi8HBf7l83eA==
X-Received: by 10.80.149.21 with SMTP id u21mr1135239eda.137.1512999857633;
        Mon, 11 Dec 2017 05:44:17 -0800 (PST)
Received: from strabo.eu-central-1.compute.internal (ec2-52-28-144-170.eu-central-1.compute.amazonaws.com. [52.28.144.170])
        by smtp.gmail.com with ESMTPSA id a52sm6316037eda.92.2017.12.11.05.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 05:44:16 -0800 (PST)
From:   George Papanikolaou <g3orge.app@gmail.com>
To:     git@vger.kernel.org
Cc:     George Papanikolaou <g3orge.app@gmail.com>
Subject: [PATCH] builtin/tag.c: return appropriate value when --points-at finds an empty list
Date:   Mon, 11 Dec 2017 13:44:09 +0000
Message-Id: <20171211134409.13339-1-g3orge.app@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git tag --points-at` can simply return if the given rev does not have
any tags pointing to it. It's not a failure but it shouldn't return
with 0 value.
---
 builtin/tag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/tag.c b/builtin/tag.c
index b38329b59..68b84db2a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -58,6 +58,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
+
+	if (array.nr == 0)
+		return -1;
+
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
-- 
2.11.0

