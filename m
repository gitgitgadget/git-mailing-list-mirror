Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D37C77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEDQe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDQe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 12:34:27 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBC1FC0
        for <git@vger.kernel.org>; Thu,  4 May 2023 09:34:25 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-18ef8aa1576so627473fac.0
        for <git@vger.kernel.org>; Thu, 04 May 2023 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683218063; x=1685810063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T5Qx8IkChB6S7/eHAe3pyutJMYocXWlD/nLd9OHu5I=;
        b=NWczyMdAeAqpypVdQmF31nTKT6KpP2vKUEqDBgk/9q7OVPrDTaEORgdFpawnITyoca
         zWsr4MjdPrqlXQcOyFbnXzid9sAwgSKLwcdZdDQ7eT1hpztc7LMJ1IxL3x+hKs4RMiDj
         n9RrrtnMv2MRBDAFTK9VDIWVIBePC2QdZMmjXtmMfkKSgDcDAWal9P/D477P/6NYCp7i
         L5T4kYRS89KRvFvvbQc/+kGYW1+/PrR1SGQAJY6qRdSawIRESZ2daxwbMVhtKRTDLtS9
         nyUXtS+13KAd8baXihkGXOuSLexDrQ8447cF+2H65k8dKb8lIWvEipJzgjOQc4czHKtd
         ZocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218063; x=1685810063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T5Qx8IkChB6S7/eHAe3pyutJMYocXWlD/nLd9OHu5I=;
        b=fOzl0yPe/mNaJXW+dDVRIdYVGCFusZesHVKvAOlzueec6OZbLR49uMGCdxSEeN658K
         dFT7/Pbq5nogR8v+gZtfTprUckkDHTa7ZgU+JXj1y7I+YBu8PnRQ7uRPKy5KlVokooGq
         q/LId9GnuR5KUc0igOWU7S2D0v0Bejs7ElsDo1CX4GFz/oMJTaBBJ6vmWqnptmdbIvDG
         lgdWkYDEbROk6BcIQrvGErXRkn6mQfgkOhPjjjsuZ9T6gozDx6ZhcI2FPZnO5vl2Q9bI
         sIweOpDq+LhN446vEQZbvV4RV9ZLP+Rikc0j20fIuhLTf0qmbNUIH0Q8XE2G2oZ+R+NE
         am3A==
X-Gm-Message-State: AC+VfDwpyWgFG0M1N6blh63RGXvDu7RqnV0pQmQoS2C9EHUaVbQfYMDj
        SrJkZt4T5uH5TYcAU4RfpFCmBy8736A=
X-Google-Smtp-Source: ACHHUZ7PHPvfmPGIJECeor1TMc6VPXxZECv0yS/nPJ8JffOfCj0hTz4QQ7nHgx0AArQ+j9qV0h4CKA==
X-Received: by 2002:a05:6870:5301:b0:192:550f:9c6e with SMTP id j1-20020a056870530100b00192550f9c6emr1211392oan.0.1683218063543;
        Thu, 04 May 2023 09:34:23 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l8-20020a4abe08000000b0054c84710025sm3514005oop.8.2023.05.04.09.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:34:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] doc: revisions: fixes and cleanups
Date:   Thu,  4 May 2023 10:34:19 -0600
Message-Id: <20230504163421.100400-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I spotted a bunch of issues in revisions.txt, one bug, and many style
issues.

Felipe Contreras (2):
  doc: revisions: fix missing escape
  doc: revisions: add a bunch of missing quotes

 Documentation/revisions.txt | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

-- 
2.40.0+fc1

