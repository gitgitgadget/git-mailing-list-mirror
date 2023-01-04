Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447EC46467
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjADVyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjADVyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:54:45 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD31E3FD
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:54:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y2-20020a17090a784200b00225c0839b80so11557697pjl.5
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwwyDRcEc/QahaSm8IQ8wFaNXRSbSZzT+SIlbiS7D3Q=;
        b=OHUDQ0/6H2yINksptjngFM9jfRCRK8Nt+kN0bBVsaGpK8r6KvDq4+n87OqD4o/x2G8
         EBebywDpRDI59Yot/GIcyx6q+lZjXcFQXpfpKASdA+/s2BhqynrJuriX+Fts/Sijn0H8
         4P49+9pljF8o7quiEZOWP7DW9AujCQgRw3HtX3XmLgF0uNanwtN22cCVLj9e3GYB+MQA
         OPDiPjWqYJ4wodVTC5C+Wfi+sOPDasqK+c3lZRDLcdvf65T/H9TufVBZ81b+StcEr4ic
         AC8z58noRGKRodV19+Ng461sxNacGbg0B3MWGqEbWm0fC5oXZKcId9am4AYLGVUJn1wf
         a8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwwyDRcEc/QahaSm8IQ8wFaNXRSbSZzT+SIlbiS7D3Q=;
        b=5Wt3xXwhXXKRgSBV0G1eavUS2w5Am0JtTQFkxqXR0sc3E1/fCSUjx/PPm2AY62ZPcA
         JMERVT4U0zBupjffnqIEXnZRFAAJzQ+hCP7McfZ6GZ9tJIYhnGet2g1JLwW/ouqmRTVt
         Nspu3mnfqzJv4S1y81MekSa9r/5Nu9P8jFX6UYodU5A2LdpXrIKSeGbDd6AubXO2wyHF
         yLYtmgPyItxY31wNyxuA8uH3b+bTC0fwrLXmfjWXedJTzu7dlIMGP8qfvDsDQ2sO1Oqu
         2KF9W5kd+BJ4DBN2MpnLMKWlJwvre9V3S5ZOsAB+pDox9Voqe/bXohdj3++B1faK0/fy
         KxXw==
X-Gm-Message-State: AFqh2koUtlF247SSGZ1rQ3psPvv6y9P4X4ze5O8vVkTHdtAjqE4SYFnY
        ong/BlJ0Z8cDevVXCUcqHCFWJxhO48yO1kGs1DdOvLESs5sqU7CekCQ538AIUp5D/TiaudpjJ8R
        BTHVIempyPNOu4ScskKxShF74HrC91OuOrfhNoG+AkAa0QhiriSkj/bEsoILafyH0fw==
X-Google-Smtp-Source: AMrXdXt6ioubDvWQT/SKVqc4kcJxMFQ2T6BcIMdySbSZNM2G8CKQEVbIL4PFsBTIB92bzVwAYKEROSu9XMkS20k=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:9188:0:b0:582:687f:83e8 with SMTP id
 x8-20020aa79188000000b00582687f83e8mr810520pfa.79.1672869284734; Wed, 04 Jan
 2023 13:54:44 -0800 (PST)
Date:   Wed,  4 Jan 2023 21:54:11 +0000
In-Reply-To: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104215415.1083526-3-calvinwan@google.com>
Subject: [PATCH v5 2/6] submodule: strbuf variable rename
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index fae24ef34a..faf37c1101 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1906,25 +1906,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.39.0.314.g84b9a713c41-goog

