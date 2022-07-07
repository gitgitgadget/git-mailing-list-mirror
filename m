Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE4C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 01:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiGGByM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiGGByL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 21:54:11 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10062F001
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 18:54:09 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9GiVoJnsoGjO89GiWovRPW; Thu, 07 Jul 2022 02:54:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657158848; bh=t2HihjNAjMXuVpUfVknnWPsuKy3D34tSHAQEDJCXjYM=;
        h=Date:To:Cc:From:Subject;
        b=im2X0Eb2uiDXlo2tM0f1sCwjcUN6cr1FtmnNgFrF2+pPqEBDZ3IIatTeB7SSOPcVx
         J4Gk39hTkSafaG0Vv1GJn7LN6Ppf+ns/0RpPTKnQK9/o58Fs5Mx139GJgpzyod/NlE
         LcKYWZStaPKkJg2Y8W8JomquQ5TPAAMbvpDNHZQKUVePQib7VgRSa7yGArzLLcj6zw
         Gq/LfSh28Vij5VOf64hYPJ6SCvPX/j7iF2AdN1AAIKI8g19n0GjCVlv4tCM7qt0mEG
         LpoyrblEnrkd1H+k2BJAVN4DReh+j6t/z9nOT6pSAne54DW9B6QEilnhd8abPRLWHT
         NFO73xNpoH0bg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62c63cc0
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=FW6NSCOM1oqWCzoeRFIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8c69c921-3b79-e7e0-9d7b-bf98151e4e6d@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 02:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 1A] credential-cache: also handle ECONNABORTED connection
 closure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM6ybO3joaSRRZviybkY4qXvKHq+1VmzmaTMGRWFJEdkKk0tXbT/XGNYZz0R6FG9Otc9qVAc2P3SBINg8XPiBAlwmVpKqfglmqB3jjhM5xxFfrn2yjNr
 M11OtDcKH27DK9po6zvpUbm+JT3kAPJ86KBHe8p5JAO/wr+ivR4doP68jf7I7SchGjUEmxEVX5m/uBwwdikgUTLT/hEdjnRgcBA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 78c02ad531..84fd513c62 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -27,7 +27,7 @@ static int connection_fatally_broken(int error)
 
 static int connection_closed(int error)
 {
-	return (error == ECONNRESET);
+	return (error == ECONNRESET) || (error == ECONNABORTED);
 }
 
 static int connection_fatally_broken(int error)
-- 
2.37.0
