Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4231FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbcFYFYH (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33064 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFYFYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id l188so23746734lfe.0
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7Pty/see6/KF0hwmGIMWBW/zeDIPCw0EWVSqfP+Gqk=;
        b=OTgF0BTcckuUbMSZrVCJFqibMQrkmRubzvwzpSG6hgCKEk1nhg8hbOgECEPPO0GhP1
         WxrvipW2ttkGrNCaXsSROdlKEpAwJO7zNFwa4rc4U5HPkgzOz9Ukq3fVdVa8bj8nnPDk
         UNDta6RwJwxQ9JkAcvAd2DVG0QLORCdyJia0djjChPhr6/iZQvE4joX7q+ISH8OQPWL7
         9TYzb+w/Nf0424NQr1jpdKb5B/YJCg78gjAWly6YrRqTauZiGlO8+S0WX7RzxdZijQB+
         I+MIu+zLTSW9zokX7MRysAPqEP4mHWhZybk69aUvaK5gS52U6RS/FvFEQjwR9j1ZfJAA
         rDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7Pty/see6/KF0hwmGIMWBW/zeDIPCw0EWVSqfP+Gqk=;
        b=bdnbnIxuIv+VlqfYKY+zRZcmP7ozq3VmdmstYEFsiKdfbicDxQ0QpwlLcrcMHXHiX7
         xC5Xj4O4qG3X2k0vJlCbo72/SmIIozyPKSU9UGrg86q2Bq5yuJ78zgH4FPceCID0Cmhf
         YQGPuw6YMsC1wLVjr3gteiCuroFXz+5cKqbf4ezNgBRJFnQySqD1F0dc8MLpncTKVnkI
         ts0KubqLqrcWeSy1Xvc8uEPauVFyyHGqZYE9ztYt0Erlt4UdatshPx0dk4Rk1XjC26Hd
         NftpJYTpox/5g++0+lPcaKdFy0s8EsKBgA5xg2JR4sXTTHHjDPyH99wjziuGlTsRtopI
         cRfw==
X-Gm-Message-State: ALyK8tJhUlv0PsE8hxfbz53B7HKSOQZM6MzLKJJjn1S7wAJQd1D4QLRoZEKcXo+tXGjFBQ==
X-Received: by 10.25.4.202 with SMTP id 193mr2590667lfe.204.1466832244228;
        Fri, 24 Jun 2016 22:24:04 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:03 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/12] grep: break down an "if" stmt in preparation for next changes
Date:	Sat, 25 Jun 2016 07:22:27 +0200
Message-Id: <20160625052238.13615-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 7b2b96a..f430d7e 100644
--- a/grep.c
+++ b/grep.c
@@ -403,7 +403,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
 
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed)
+		p->fixed = 1;
+	else if (is_fixed(p->pattern, p->patternlen))
 		p->fixed = 1;
 	else
 		p->fixed = 0;
-- 
2.8.2.526.g02eed6d

