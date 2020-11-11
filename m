Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6CC388F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A920791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYm11KBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgKLBc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgKKX3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:29:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57814C0613D6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e142so755492ybf.16
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=LpVxdvBMcmSDcbss/la6MvnV7rivL9P1LqACanV9DxE=;
        b=gYm11KBCnvUBSfr0tIjz7sMC0JtFCq5cKhT7zk25yIClnkcBLjesoASk3XebkNzmtM
         xlrUnTxT+IfA+593M0+obMQ9uMGD4LmK3xpy6rTQQH66GDSgT+/sEK7fZgqFx/L3KaP3
         4AZ6YUxaa2m5ODOvmWT5lYnnu3AS1x6Bedv6aBK9tBjx51Zo/fb/5+tlxy4k035raqQB
         H2WMy6RQM3sjKMHi5z/si3BrBGOKbp3umVIUHL5USbOgpUEIQlDR72qeXtZ84IyqlOn+
         9QlHF+KzdxKpL8ueNUBK8a1nuNuFhG2GwXz3Lwq1jlZh9CiE/0A1swvfLbG/ffg5f9+J
         hSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=LpVxdvBMcmSDcbss/la6MvnV7rivL9P1LqACanV9DxE=;
        b=IV0ajf7mbE9f/2fZWVtK0FN9U71vNndsJs/Hu0GPzKuoajhTcopdSd36LL667RKNlO
         v4ax9VefKiD9ALtvtP9C1n3wU9TJMPjizJO0IfTsKNHb/WNbjQopdiW94F+5R0Om6xR6
         OJRrs/jQ5hazWcDc8XKDflZydzF12k285j5cglNWXZImLbmBs0UYSoTbvN7gxtfBMwjs
         7UbHnd2JKOtHbdPQzi3qjMg0D/8/fH13cJ9GNefUrTUvcEndOFIdX5o3GPe7CMDwDXoY
         IkfeCtwVB+pVjcm2+O4PcqB/L0uz3cOziKqCZ45HDHADzN5gvSOj2b9cMPWP37Qk2ik3
         mvAQ==
X-Gm-Message-State: AOAM533EqVPEU2SQCKzFZjmrtHzzZYPXAsWbwh4PLedAhSFndVHL+4wJ
        jv3lk8kKOdJCxkCjMqubeilXsd/Q3bRN3yAbyG5CpwPh5wg5mWXFSclogZba/45bAvTIDRtxAZq
        o8qkPgDVUG5EtCp90ix6ZUm2TvnD4vmS1sQVL1w4TxogMXpCM/4PkwC7/1D1z4i8=
X-Google-Smtp-Source: ABdhPJxIV0Rk5fOuQQRJCRMKXhUTofhk3JLqqrEllVU8yb9naPXGijkc4rcMUtZ3TKYozDyRsOKr37UfnLJ/Zg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:6dc6:: with SMTP id
 i189mr36502472ybc.299.1605137378530; Wed, 11 Nov 2020 15:29:38 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:24 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <184cabb6f5d56f4c7cc744fc311428f1ab13d93b.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 01/11] docs: new capability to advertise session IDs
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In future patches, we will add the ability for Git servers and clients
to advertise unique session IDs via protocol capabilities. This
allows for easier debugging when both client and server logs are
available.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .../technical/protocol-capabilities.txt         | 17 +++++++++++++++--
 Documentation/technical/protocol-v2.txt         | 13 +++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index ba869a7d36..9dfade930d 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -27,8 +27,8 @@ and 'push-cert' capabilities are sent and recognized by the receive-pack
 (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
-by both upload-pack and receive-pack protocols.  The 'agent' capability
-may optionally be sent in both protocols.
+by both upload-pack and receive-pack protocols.  The 'agent' and 'session-id'
+capabilities may optionally be sent in both protocols.
 
 All other capabilities are only recognized by the upload-pack (fetch
 from server) process.
@@ -365,3 +365,16 @@ If the upload-pack server advertises the 'filter' capability,
 fetch-pack may send "filter" commands to request a partial clone
 or partial fetch and request that the server omit various objects
 from the packfile.
+
+session-id=<session id>
+-----------------------
+
+The server may advertise a session ID that can be used to identify this process
+across multiple requests. The client may advertise its own session ID back to
+the server as well.
+
+Session IDs should be unique to a given process. They must fit within a
+packet-line, and must not contain non-printable or whitespace characters. The
+current implementation uses trace2 session IDs (see
+link:api-trace2.html[api-trace2] for details), but this may change and users of
+the session ID should not rely on this fact.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index e597b74da3..85daeb5d9e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -492,3 +492,16 @@ form `object-format=X`) to notify the client that the server is able to deal
 with objects using hash algorithm X.  If not specified, the server is assumed to
 only handle SHA-1.  If the client would like to use a hash algorithm other than
 SHA-1, it should specify its object-format string.
+
+session-id=<session id>
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The server may advertise a session ID that can be used to identify this process
+across multiple requests. The client may advertise its own session ID back to
+the server as well.
+
+Session IDs should be unique to a given process. They must fit within a
+packet-line, and must not contain non-printable or whitespace characters. The
+current implementation uses trace2 session IDs (see
+link:api-trace2.html[api-trace2] for details), but this may change and users of
+the session ID should not rely on this fact.
-- 
2.29.2.222.g5d2a92d10f8-goog

