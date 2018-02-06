Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7871F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeBFAU5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:20:57 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46417 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBFAUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:20:55 -0500
Received: by mail-pl0-f65.google.com with SMTP id 36so111646ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MiAFA6AxxjlIVBG9RvkXISxWPlLpNE69wLoPhvEeeOw=;
        b=iusQoUKv4YbZsz27mbE1PpgOrJL18kEOre/sGRoKgnPHKys0Ofy7fPpKcFyHAysfi2
         q+xEhaEpGFjY4Gimk+/YBRCDTmh3TP+4DCdz3GmVPeMw6tGooB2/Jw/QwQaXEUot1MkQ
         D9EJIWc9Svqo4Vii8aWBqX+39WAOt80qX0eMSV/6TsFApZkyFZofgMsC7CUVbRDFJOe6
         PoPrBEdCCTxA2s7B8SzitB93v+hYPl3yJYlonTvIy55M/csQq5b8wFFnZAQp13pLzafM
         de4Xq5RUONo7vYloEl+9lEbl0+C5pGSfkn+Wwxz+riSy5/8I+W4TZ2lN8+sl3l0Cldy/
         j5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MiAFA6AxxjlIVBG9RvkXISxWPlLpNE69wLoPhvEeeOw=;
        b=oWrp/mgPW6wc0lfvb2sT3lMheFHQcP9IaMJTE95g0YYRbRln7T7zF/nYbYzaV1vmvJ
         TnG9mR6KOr3ONxKj7lKhKukoSc0R/2/KkUaU7l/Q0dASmzgoxJQWQjee7JzV8cvAoQ8u
         AVTjRjMP2P0FbALAUdgqfj9RSE7kv2VBO33sWethP/9f/AtTdl878c+p+AIjliXe4EE5
         3K+MwCLiPMyjOpeHeKKmY62nhB7Y3/3j8lJmCsZx3D3XCCvPqr+fXjOmPvUjKmIrkfz2
         MIIwCXB9T2MicoQCUlLBeR7kYiRpDlVjaRvFdqOchoWeUWR0UTS2+qw6e1c6p+Bbvz+y
         pQYA==
X-Gm-Message-State: APf1xPCzTowfVkk0eTF24tigg4AprRMWZ/Cf/0+yGqYyyB47FpXeu8Er
        Ft7z5jTeGQ5Ubltq54YXPkxXIulOjMI=
X-Google-Smtp-Source: AH8x2270ixQ9bn5nrFdu8SAB76NE5HCt7KF/e3Bxn55QncutUK1qVp7S9CCPnPCDZ/vVErYg2xaK7Q==
X-Received: by 2002:a17:902:b492:: with SMTP id y18-v6mr539300plr.437.1517876453909;
        Mon, 05 Feb 2018 16:20:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i3sm14430418pgs.63.2018.02.05.16.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:20:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 119/194] streaming: add repository argument to istream_source
Date:   Mon,  5 Feb 2018 16:16:34 -0800
Message-Id: <20180206001749.218943-21-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of istream_source
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/streaming.c b/streaming.c
index 90acf7448f..5d2c24798e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -111,7 +111,8 @@ ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 	return st->vtbl->read(st, buf, sz);
 }
 
-static enum input_source istream_source(const unsigned char *sha1,
+#define istream_source(r, s, t, o) istream_source_##r(s, t, o)
+static enum input_source istream_source_the_repository(const unsigned char *sha1,
 					enum object_type *type,
 					struct object_info *oi)
 {
@@ -144,7 +145,7 @@ struct git_istream *open_istream_the_repository(const unsigned char *sha1,
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
 	const unsigned char *real = lookup_replace_object(the_repository, sha1);
-	enum input_source src = istream_source(real, type, &oi);
+	enum input_source src = istream_source(the_repository, real, type, &oi);
 
 	if (src < 0)
 		return NULL;
-- 
2.15.1.433.g936d1b9894.dirty

