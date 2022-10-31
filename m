Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F96FA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJaXrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaXrn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:47:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52EE014
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:47:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o13so676983ilq.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ClTRbYKwf2ReqAbgw47Drl2AO3hitEL3pnbewr+cfU=;
        b=xOoUkWofz1ryXxBT5it7U+bJ+pG7FnLWBAkdO6qc87JLaFglQtRCcrJwEGVAlp1nIE
         2ld4uR3kyeCDJddA+cHv6VSSD26S7msZlqorskBd6aN55WpXewYtnPt8ChNlq4MYRmHs
         tnADpamM1VAV4oCoi3hIb0eBTHYEUPCG9jdZDyX8qzVLje6LETvBlM5IYm09O2s5WW8n
         AnJDRKOP0ozjp0PcoROzXfPuBi/wYSFV9+Ye08gI8F3g7+GF1DYk6N1XlYRGL6CppZIn
         FDXSr2xoXA8yYALUoMDEmhB8K8NKKXvByuqJ0jgBLR02yjUZVe+Y4N+cjAHOca00ecnL
         81qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ClTRbYKwf2ReqAbgw47Drl2AO3hitEL3pnbewr+cfU=;
        b=N+KQJM7QBoPhVD58dmhLuf4595f/uxk0hgw2nbHWOic/OtfjzSFGdmxmfe90ZICB3A
         Rz2S4ifuhk1+WfYTFFZXzrLYgwQ2pN+2tkniTc2Pkrv4FWp2kyyPYbvJ1wtGnzUHz2+k
         VqUNn3B+9R2XypcAEyDJ88LIvAZnEHNwehwEPCYJWj/KMybRXNCUVn3r27TSgCtLAqNS
         JNfXctzyn9p4aUYq+qzIBDiG15nv6SOaP5BxkKq6Td+0mrrlMI8D1TDLRZKAP2O+l/Jk
         kqRK38ye6rJfBfACSjCby0l+LtTyn8py95Fz0ZS09FhtFBw+JbZcpbWW1Q8pRNsC/22n
         mQZA==
X-Gm-Message-State: ACrzQf2/s7K/OO/HbUKloNbxduTm2/SvkSGcuRhIWeA8vB016F6xOcJ/
        iQ8k2PhyIBatprW+KymjiahkEejGrLnRoRPO
X-Google-Smtp-Source: AMsMyM4fhbiDpB8wRm7fsNJ32xfUJa75TSkDUHojvtAIN24oSJKLq2MS6wRY4dVi3QZYWgEM4+YoUg==
X-Received: by 2002:a05:6e02:4c7:b0:300:8d6d:286a with SMTP id f7-20020a056e0204c700b003008d6d286amr8721136ils.164.1667260062560;
        Mon, 31 Oct 2022 16:47:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a71-20020a02944d000000b003633748c95dsm3271889jai.163.2022.10.31.16.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:47:42 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:47:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Documentation: build redo-jch.sh from master..jch
Message-ID: <7fa56b1a002338cba17013e904ee095813bb772c.1667260044.git.me@ttaylorr.com>
References: <cover.1667260044.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667260044.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebuilding the 'jch' branch begins by reintegrating any topics between
'master' and 'jch', not 'master' and 'seen'.

In the maintainer guide, the documentation isn't quite right, since the
initial input to Meta/Reintegrate is "master..seen", not "master..jch".
This can lead to confusing results when generating the Meta/redo-jch.sh
script for the first time.

Additionally, rebuilding 'jch' takes place in two steps. First, running
the script up to the first "### match next" cut-line, and then comparing
the result with what's on 'next' (i.e. with "git diff jch next"). Then,
the remaining set of topics get merged down to 'jch' (which aren't on
'next') by running the entire "redo-jch.sh" script.

Clarify the documentation to reflect this.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/howto/maintain-git.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 215e2edb0f..bac6429fbc 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -231,7 +231,7 @@ by doing the following:
  - Prepare 'jch' branch, which is used to represent somewhere
    between 'master' and 'seen' and often is slightly ahead of 'next'.
 
-     $ Meta/Reintegrate master..seen >Meta/redo-jch.sh
+     $ Meta/Reintegrate master..jch >Meta/redo-jch.sh
 
    The result is a script that lists topics to be merged in order to
    rebuild 'seen' as the input to Meta/Reintegrate script.  Remove
@@ -283,6 +283,11 @@ by doing the following:
 
      $ git diff jch next
 
+   Then build the rest of 'jch':
+
+     $ git checkout jch
+     $ sh Meta/redo-jch.sh
+
    When all is well, clean up the redo-jch.sh script with
 
      $ sh Meta/redo-jch.sh -u
-- 
2.38.0.16.g393fd4c6db

