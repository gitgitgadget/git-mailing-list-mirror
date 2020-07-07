Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6348C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B287E20708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 05:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxYCcTp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGFiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGGFiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 01:38:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6AC061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 22:38:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t15so3629564pjq.5
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eOwzzxBTmt/mt+sT7IgSY9TTvk+lt7JxeE3qKRe3BRE=;
        b=QxYCcTp/GIk8BpfV72ga/wvLZcGGGT+TCNoMxMEDsoWfOUaGUAONdUdr67rfqNy9dp
         AOJOTXxZprIiWh9dO9jHHvAmEBj1Kajx9gP9qk0ttyg3qxDpE3f/F+lcn3SmUi1JqcP1
         wHxXvAhaSOep2wGsv/Gf3fWLSUQ5nrM3ccDmN4aFm67z0pm5Jv6uzO6D/LzgVPa1mC/C
         PdjfIWkeaF7Nlyu2TWhNfBRy5YGgzbCD+kqnVG3Zd4CvkuwjfPeciFJcdaOM57aup2R7
         K1dZn+Q5p22reESpdXaO8bS+74/sMD+v7+/dTWQS/SbvK+hvPbXF0u3JqNDOC1bBs9DK
         5oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eOwzzxBTmt/mt+sT7IgSY9TTvk+lt7JxeE3qKRe3BRE=;
        b=HTsvX28AjKXLFHaK2PO16rw053xFB+jr2NiymZnAWlwT+HiLghuQpM92BiTCt85m2R
         OdH+cOX9AVmb1QKecXrMopaao3Kf9knlfQA+6UiIswXti330zUAd8I8XCy1JSJRvye7c
         aNqGpQ9poV9rcJf4f2CQOd+O3HAAFQvMvc1n99K4aixC3fo8BEcD8DHhguImqrBb2IwX
         7m8t47ykjEi+pBK6CGjEzi2e88Xf1DJ1m4pBRh3q5d/0fj9m/2K9xjR7gAQpo91GSaR+
         Ux5Rnci6XUk4kNJ4Ye1rmjx8oxMm++r3YdjxBwgmpyqZBx4KcTU0zrruJCG21hXstH1d
         A4rQ==
X-Gm-Message-State: AOAM5320epTbtr8E/oDKx78cp4kfcDaiqzXsdiDIwK4TN1kq+PJcASK8
        KmFf9DiRO2wy9JdMbMv+ShU/5SZp
X-Google-Smtp-Source: ABdhPJyDGZkyppeHHBdlG5Ey9fKXlosU7V2qKAdpkLECAnZ3q1c1aVBY1SCeU6cQ+yMRJDztJHtQYA==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr2576228pja.15.1594100288035;
        Mon, 06 Jul 2020 22:38:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id bg6sm1131587pjb.51.2020.07.06.22.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:38:07 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:38:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH/RFC] config: default to protocol v2
Message-ID: <20200707053805.GB784740@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git 2.26 used protocol v2 as its default protocol, but soon after
release, reports of edge-case regressions started rolling in.  So Git
2.27 returned to protocol v0 as a default (but with the various fixes
in place to make protocol v2 safe) and Git 2.28 will use protocol v0
as default but enable protocol v2 for those adventurous users that
enable experimental features by setting feature.experimental=true.

Thus if all goes well, by the time Git 2.29 is being released, we can
be confident in protocol v2 as a default again.  Make it the default.

This especially speeds up fetches from repositories with many refs,
such as https://chromium.googlesource.com/chromium/src.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Mostly sending this to get the discussion started about what changes
we want before flipping the default.

Are there tests we can run?  Should we make the negotiation code more
similar?  Any other bits we'd want to change?

Thanks,
Jonathan

 Documentation/config/feature.txt  | 4 ----
 Documentation/config/protocol.txt | 3 +--
 protocol.c                        | 6 +-----
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 28c33602d52..4e3a5c0cebc 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -22,10 +22,6 @@ existing commit-graph file(s). Occasionally, these files will merge and the
 write may take longer. Having an updated commit-graph file helps performance
 of many Git commands, including `git merge-base`, `git push -f`, and
 `git log --graph`.
-+
-* `protocol.version=2` speeds up fetches from repositories with many refs by
-allowing the client to specify which refs to list before the server lists
-them.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index c46e9b3d00a..756591d77b0 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -48,8 +48,7 @@ protocol.version::
 	If set, clients will attempt to communicate with a server
 	using the specified protocol version.  If the server does
 	not support it, communication falls back to version 0.
-	If unset, the default is `0`, unless `feature.experimental`
-	is enabled, in which case the default is `2`.
+	If unset, the default is `2`.
 	Supported versions:
 +
 --
diff --git a/protocol.c b/protocol.c
index d1dd3424bba..803bef5c87e 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,7 +17,6 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
-	int val;
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
 	const char *git_test_v;
 
@@ -31,9 +30,6 @@ enum protocol_version get_protocol_version_config(void)
 		return version;
 	}
 
-	if (!git_config_get_bool("feature.experimental", &val) && val)
-		return protocol_v2;
-
 	git_test_v = getenv(git_test_k);
 	if (git_test_v && *git_test_v) {
 		enum protocol_version env = parse_protocol_version(git_test_v);
@@ -43,7 +39,7 @@ enum protocol_version get_protocol_version_config(void)
 		return env;
 	}
 
-	return protocol_v0;
+	return protocol_v2;
 }
 
 enum protocol_version determine_protocol_version_server(void)
-- 
2.27.0.383.g050319c2ae

