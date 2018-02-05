Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD5A1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBEX4J (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:09 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34798 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBEXzv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:51 -0500
Received: by mail-pl0-f66.google.com with SMTP id q17so94593pll.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4lJx1JA7AwGSLPA/26bQVIPnNanBO7K6dKKWxtcGVc=;
        b=o//jDCzEq//4hZumZU2tJji9ThoH35EnS+CvUdzgyFDzSfyCesTPBRPeW35NuAkWJF
         KjKfUnl7MAGoUlq2EqmkyDI2A+WN1R1Ez2YZdgzGU+gF4TexK+YY/WT1jd60qsVXPKW0
         JUYn4n/IensdaxgGQ491mqE8JxCeOTb37OLQ4ur4rOIbvoMm6OeFx4C6ElUWwKIcQlLt
         ZGVIFFU6/K45hvVZnAq2leavn+a6idGWIiOKuqjnjJjxmYTyMRdRGbFujE7bQS1j8ewM
         z99rtY0bjGVqhahkBsXTR5l3MfyR1wmuQ3J4NPKOXsOr5KheL6eG/rmDkR41aoMYkwWu
         ZbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4lJx1JA7AwGSLPA/26bQVIPnNanBO7K6dKKWxtcGVc=;
        b=Ue/lGAz02serYOtIhcC7sGyyfSYwBQH7fFBhXLJv7Cg/kznR+aB9WPFzCXB3txurI7
         8kSzUFQb66A/x7qmsdh3EA1kbnpVVc01ltYn7gqEkC1jM5hWgJ4O8ZfqrtbyBgrnFP6G
         kQim0QoB0ztn+k18CuoJf7MKkm9E6OaZGoCpPj7mMdN8Vha0Fcktf246OQyhVU1+3cK0
         TXxrTFIu+HiprUzT+HMsr4Ot+jo0DLsI2b6SC0pCWWXZquW8BNear6abZmwujDxfHkrM
         w7t3ABA1oWA98WcOoNYLMgzaYlhdh45u52cOb53abCse+ejgQmowsbEwMvhjZVhpV4F9
         tVXQ==
X-Gm-Message-State: APf1xPDYIaW8qAoAsihniUgEnmf3SdKfe4kQp+0Khqs6w804N3UFP2SI
        9SDHmu8WAhgKpz/D4wn2P4q2DXeyGxE=
X-Google-Smtp-Source: AH8x224JFxQsLGM8xLEfTCT1aAFGjzr4nVrvGZsB4Xrg9gHfkS+GbfnzoQJqO/Hni7ikd+6Ec2/N3Q==
X-Received: by 2002:a17:902:8284:: with SMTP id y4-v6mr493926pln.194.1517874950502;
        Mon, 05 Feb 2018 15:55:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f12sm15400383pga.67.2018.02.05.15.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 013/194] sha1_file: add repository argument to sha1_loose_object_info
Date:   Mon,  5 Feb 2018 15:52:07 -0800
Message-Id: <20180205235508.216277-14-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the sha1_loose_object_info caller
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 24832c4b32..514f59c390 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1152,9 +1152,10 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi,
-				  int flags)
+#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
+static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
+						 struct object_info *oi,
+						 int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1267,7 +1268,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.15.1.433.g936d1b9894.dirty

