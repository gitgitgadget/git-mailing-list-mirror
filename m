Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EAFC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D80220838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ah1AMHFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgJ2Vcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgJ2Vcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:46 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBFC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t13so2576619qvm.14
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=jNpZYdfA2v8kViHg5yyabr+u6XDxnMcDU78apOksAVo=;
        b=Ah1AMHFvVCLYjJg+rwMZiaS4q7Nb3JNs6whIOZctSmTlRPZR/RfJ/yW98A0yRqe7G/
         7XBqBRIwpMOkaf0dt68CrM/wBTbMI97ro9bfG4QMZAAWYDHpMHJdUuAli9tLzCbruweL
         my98+rQa6kODALQqeSOPdKUVcv5oJqzsZhzCfboWVlv2RKSP17//ZqKV4QEZeXCCtdkL
         H4Ixc+XSleoZxnC2ExQmCq+W/tutS9PehZ5GkonJvLUIIshO4o6OUQcdwlSFbc9gFkTO
         R31MXbV7CurgYbjRkGQXM5iz/f6NnFFJKpMT1cQFDz2zPp8VN9TWNVgYcy/RiDhwymKG
         vBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=jNpZYdfA2v8kViHg5yyabr+u6XDxnMcDU78apOksAVo=;
        b=EnC3QUzDMhtkInCqJ4kWBQv5eK2ZCiq8vbBGwLt/9IbDHrH1Vi2oJcYXqKEfTxS9FS
         i5G3kzu0oraHLq8lDy+EZr4dI8BcOa06sMyfUPtx20+Ej9ZbcGy1wfQ46BiwVTGFUzts
         R3o3wiX9GBPWAhfZr5OuoHXE7ZTqm7PVTD7K0g8lMI/IrjEWs4KjrcZT7+zKGLdhOzZZ
         QlLcQgbpkNIOz/uv1QjCU4KV18ww/jP1Td2haKD7AlUk+QSwjd8d4xVlRApR3LPIXCDj
         /FZc6b0o0jXsYPhYn1VArohs5Vg1ilj3tp0vlpL0Lnk5fddHPTu5ym2kwfAu2OixAjxT
         DB9A==
X-Gm-Message-State: AOAM530coM0qomI81Zb6KI5/gljlyylfahHxzuX9teO2lXEf6V+INDul
        ZVRo309EkCe3qVeeUz4eO7ksFUWQeI8vCYrGRax2BHQslJRt08SjOwOzNq2aCSlif/iJQ8UjPnf
        5mZB/speGqN3SdmkBCsmM2W2T4VPlt8aEHdznQGCMqstnQCQlYMdVWslc44uXbo0=
X-Google-Smtp-Source: ABdhPJy/9ijQgWZCvuWSZpDSNGPYtFlvynBxqBuCPGSL6iEv+KPfwffN9OE6480s9alIUS2EmHublvey2fIwAQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a05:6214:951:: with SMTP id
 dn17mr6598451qvb.9.1604007163795; Thu, 29 Oct 2020 14:32:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:31 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 01/10] docs: new capability to advertise trace2 SIDs
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

