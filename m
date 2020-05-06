Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6AC38A2A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F322075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1JtYohX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgEFVsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730029AbgEFVsm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 17:48:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0589CC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 14:48:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so1674757pjw.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2k3AKX9/tT2bWgNLPAjNugY4Vx8U15rWf+Q6KEJ9VZE=;
        b=V1JtYohXnfEzPAEpn6Ni+OXbtbGMrdi1f3LpfaLz/9mbgCicRMLn3MkPcsjaAhynPU
         U2/UHPb4dYwhSnXu4PXZU0Coj3z0wdo8SRF2pLIFA1PK8ifLAHQmRfWogJuHdu2vOrke
         RVxABgdcoTuX+qNf2uWhoILRWkgOgn2ugHly7DwxQb5C3GhAClSeMyAfwAkhp6BiUOUW
         njHXHXaMKlU8spQqdOEu+5lq+UmBonlibm+IQmH5lDjpM7vxydM9twnrrJ00wlpOzwoy
         Qj+IpCDc+1goxI04yYRtNiVrkOOJ0WXRYo6LBA98wHXH3W1FGE1uOoNX9xjqooyHcAuf
         Bn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2k3AKX9/tT2bWgNLPAjNugY4Vx8U15rWf+Q6KEJ9VZE=;
        b=AwkSpRI4ZXKqnSmrBBjMo69wRz1xdd/HAOO1u8OS/XRJBqNOrfVV4VqVawilP4+BG/
         FmVU8+iUwVT5kOa9ohddHPPShA+0WnR96cbK3ecEzqhDWirxZOSIDfzOf3pgLmS0v7KZ
         fsws72XSczVR5mXzSDE2qhZ4ho0SP32XA9Gi7+WYhv6IzGJfczxYWqv0DsJlnRZ1+yJO
         HH/FYr/nm1V4Hlbe8KlbqaZK7NlTMQdwK/TVa/omhjC9kLumvszYDkqudJm+wwdN1VDA
         G8WCDMMIPoz9vbp+2DHxjOWU+PwrYFmS3D6HgTEe2sqRcRgaabUlxs5ngcABF+0xJJg8
         yPxw==
X-Gm-Message-State: AGi0PuYLE17X2cMVgEV+X8qhdk3FV2Z09IY0jViQcA+15j79uWG5wxQt
        yB5mf5XJov22ff4bNSEUzCUaJBDE
X-Google-Smtp-Source: APiQypJCIoKLx/OafPLS1IvKlbzNXE0SltE7cvYv9B3vvKU0yVoBPBCYZQZCcQAX39f4Iv+bNoWJKQ==
X-Received: by 2002:a17:902:d34a:: with SMTP id l10mr10356655plk.234.1588801721162;
        Wed, 06 May 2020 14:48:41 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm2703432pff.47.2020.05.06.14.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 14:48:40 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 3/4] credential: update gitcredentials documentation
Date:   Wed,  6 May 2020 14:47:25 -0700
Message-Id: <20200506214726.81854-4-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200506214726.81854-1-carenas@gmail.com>
References: <20200505013908.4596-1-carenas@gmail.com>
 <20200506214726.81854-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the expected effect of all attributes and how the helpers
are expected to handle them and the context where they operate.

While at it, space the descriptions for clarity, and add a paragraph
mentioning the early termination in the list processing of helpers,
to complement the one about the special "quit" attribute.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/gitcredentials.txt | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 1814d2d23c..05e544ee49 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -262,16 +262,25 @@ For a `get` operation, the helper should produce a list of attributes on
 stdout in the same format (see linkgit:git-credential[1] for common
 attributes). A helper is free to produce a subset, or even no values at
 all if it has nothing useful to provide. Any provided attributes will
-overwrite those already known about by Git.  If a helper outputs a
-`quit` attribute with a value of `true` or `1`, no further helpers will
-be consulted, nor will the user be prompted (if no credential has been
-provided, the operation will then fail).
+overwrite those already known about by Git's credential subsystem.
+
+While it is possible to override all attributes, well behaving helpers
+should refrain from doing so for anyone other than username and password.
+
+If a helper outputs a `quit` attribute with a value of `true` or `1`,
+no further helpers will be consulted, nor will the user be prompted
+(if no credential has been provided, the operation will then fail).
+
+Similarly, no more helpers will be consulted once both username and
+password had been provided.
 
 For a `store` or `erase` operation, the helper's output is ignored.
-If it fails to perform the requested operation, it may complain to
-stderr to inform the user. If it does not support the requested
-operation (e.g., a read-only store), it should silently ignore the
-request.
+
+If a helper fails to perform the requested operation or needs to notify
+the user of a potential issue, it may write to stderr.
+
+If it does not support the requested operation (e.g., a read-only store),
+it should silently ignore the request.
 
 If a helper receives any other operation, it should silently ignore the
 request. This leaves room for future operations to be added (older
-- 
2.26.2.686.gfaf46a9ccd

