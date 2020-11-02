Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF71FC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F75D22384
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZezBtPSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKBWbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:16 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFEC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:14 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x85so9724377qka.14
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=jNpZYdfA2v8kViHg5yyabr+u6XDxnMcDU78apOksAVo=;
        b=ZezBtPSfrJY6Udt+EzqghhK6FsRrq6DTTWTuiXVUDSQ07975bV0GW99wtnxTOo9lcI
         1rDJBYaHzmWFOIxFOk2VDw2NOA3554j2u8vu/75OnGcHEVz9eEcMefrlibacucdV/oyD
         c5j3FC+Oe/8kFbi05Pbn6qMceW2OPe2WBEtS2Xd4x214WJpBosxHASM36SdQmv7cKae+
         BWiGodFtXvzigG8wzcvFFy5DEOr/4Q+Hd8pTiwSaSZQ6OMfl0uxZNbTifetwc294CQOd
         6eG14mAJUV4P9Sdbf4wRD971cN1CGdEhAhbdvBg9e3KE5m2TUipcpfhpDWr2a87C8DR7
         /pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=jNpZYdfA2v8kViHg5yyabr+u6XDxnMcDU78apOksAVo=;
        b=GRkrx4OJ5AL+elPtEvVSsreSRShjrIxsJQ42ijBAoUvK4rwPoYG2+VZhDso7Wct6W2
         KM+iC+biC2hDhQlizkQumEkqlrmRAyRK7Gg4gMLMLQsYJWUcpo0OhVi8+hWvDUspf1fm
         +hp/ARSKCWB38sJxsgV0nVQpyNiHpQ0JBZj8MO7C/jBiLwgOy9v8rED7V/H6Tisw+oAS
         yuN2tnNoTDvlHGjeLklCYZP5vA/DQgFVX2tQ+OJAaR/P9mB7fwNQ4ivcErYVhPXb58Ig
         FFttZENmmG6h1jYliU2a7DIBvTaZ+CojXN7SqrWuaDspSEw2v+a6IeWm6otZSZNeP2TK
         BCwg==
X-Gm-Message-State: AOAM530OHUITQrVJMaYL/cJRd9s9vdg07UqCsHphppR+rsdwzFW68RNx
        +0YnddW2aiP+aATaQ9rLPbYl0iFVIYeEsXbS7G118t0An0NcKVbh2ZcnN9eGynO+3ROd52MyK7K
        Uw1hBkxC7RFjp9pOg3vXxNDSFGZ9At2LvEK1D7ZuOLdW4UIRRTAMvuMqVZJ/dswY=
X-Google-Smtp-Source: ABdhPJwwBsT8dadNhwZdY1vFfxrnS7jDfU5Kt9XVkTXJZpyCMQvaaVi461sTqCM/3QMaw2Lse59mljhOS+8mIw==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:cb02:: with SMTP id
 o2mr23714823qvk.8.1604356273789; Mon, 02 Nov 2020 14:31:13 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:30:59 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In future patches, we will add the ability for Git servers and clients
to advertise their trace2 session IDs via protocol capabilities. This
allows for easier debugging when both client and server logs are
available.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/protocol-capabilities.txt | 13 +++++++++++--
 Documentation/technical/protocol-v2.txt           |  9 +++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index ba869a7d36..73d4ee7f27 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -27,8 +27,8 @@ and 'push-cert' capabilities are sent and recognized by the receive-pack
 (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
-by both upload-pack and receive-pack protocols.  The 'agent' capability
-may optionally be sent in both protocols.
+by both upload-pack and receive-pack protocols.  The 'agent' and 'trace2-sid'
+capabilities may optionally be sent in both protocols.
 
 All other capabilities are only recognized by the upload-pack (fetch
 from server) process.
@@ -365,3 +365,12 @@ If the upload-pack server advertises the 'filter' capability,
 fetch-pack may send "filter" commands to request a partial clone
 or partial fetch and request that the server omit various objects
 from the packfile.
+
+trace2-sid=<session-id>
+-----------------------
+
+If trace2 tracing is enabled on the server, it may advertise its session ID via
+this capability. The client may choose to log the server's session ID in its
+trace logs, and advertise its own session ID back to the server for it to log
+as well. This allows for easier debugging of remote sessions when both client
+and server logs are available.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index e597b74da3..a5b9ef04f6 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -492,3 +492,12 @@ form `object-format=X`) to notify the client that the server is able to deal
 with objects using hash algorithm X.  If not specified, the server is assumed to
 only handle SHA-1.  If the client would like to use a hash algorithm other than
 SHA-1, it should specify its object-format string.
+
+trace2-sid=<session-id>
+~~~~~~~~~~~~~~~~~~~~~~~
+
+If trace2 tracing is enabled on the server, it may advertise its session ID via
+this capability. The client may choose to log the server's session ID in its
+trace logs, and advertise its own session ID back to the server for it to log
+as well. This allows for easier debugging of remote sessions when both client
+and server logs are available.
-- 
2.29.1.341.ge80a0c044ae-goog

