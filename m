Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E5C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbiFPFED (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiFPFEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:04:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0027544EF
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:03:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so2185983wms.5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aHlDPl766bclNObWLHStvODiPaABsIyLCA7q3kHw6ak=;
        b=XjDg2/QTfX2UuFOBoXbg7ibRCHNk/YIrSdqlGjP27ZlhJu+mT0sSL3aK8jSATLVJYl
         iFMlvl07gTK+0Kg705BH9pvPOYOgRsYiImNaWLwJ9nEQdZWdRdeJdcm5nV5EILABcj42
         moAJ2YWJRGcL46djP+EI7yC9KchzaJXGLNRi3SEzcvJB2lRT7jWQ9YvHnVl4gKsjiUIz
         FLWMRleC9rgAH9kVCZ+53L4i5f4h8E/C90aR7MG+hbGA2Ghk+ET5buLNYG27F2XGVSO8
         392U/xEcf3Hb1jCUxnVCmTmt4HzFK0vuMWZvJUEdi4/N9y1B81AadIu3RH6JAgRknhKx
         q0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aHlDPl766bclNObWLHStvODiPaABsIyLCA7q3kHw6ak=;
        b=MCJY+pX+jS/KkXu+NUOWnyTbBq8bgYrPtk4WHnVdFjzWaip+2U57BuvfSuhZKvhw45
         QH3Enm7kMcPW/1dxQM+c6MB+4uCL0c4jMOFVpiRjTuUMVcp03Na94LtSIdGiN+vaCL/6
         KIifTJniJPOVdSwJfrdu6hDuDYrwjkGIL/nTBIqPXu+zjyELrWtGJT/jF8gGuSmgelzD
         1TFdb9r6ZL9OTYBIzG6njSc3voVRKWkpPZgQVh1KBd6jqoFeySPG7pvdalvtv3Ql+SDB
         RkhNngSOOdmIHNeCM/hGuNzyqKroq2V09zV4gKB3dyHh3NmwDkzpUZ1j4OF+3ASoSZsh
         VWsQ==
X-Gm-Message-State: AJIora+d1HL5jAnakEyTIM/9qrh0v7YKFKB9LLDy7l1FNQcIK3jtlMYC
        Ud5hG9jcEQMnprjFShaWy9AaBe8RwOGrog==
X-Google-Smtp-Source: AGRyM1tsldx0zms37TusGPrOfp9gxvPIhHZd0F00xwk4ZDEQm+EOo0JXcNCcAWG0JlyGNCcTwlCM0g==
X-Received: by 2002:a05:600c:1e09:b0:39c:5351:789a with SMTP id ay9-20020a05600c1e0900b0039c5351789amr2944572wmb.177.1655355837744;
        Wed, 15 Jun 2022 22:03:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b00397122e63b6sm958713wms.29.2022.06.15.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 22:03:56 -0700 (PDT)
Message-Id: <494c1c1bd522a6de1d6bc811b86f579ca6507013.1655355834.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
References: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
        <pull.1246.v4.git.1655355834.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 05:03:52 +0000
Subject: [PATCH v4 1/3] bitmap-format.txt: feed the file to asciidoc to
 generate html
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Documentation/Makefile does not include bitmap-format.txt to generate
a html page using asciidoc.

Teach Documentation/Makefile to also generate a html page for
Documentation/technical/bitmap-format.txt file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f2e7fc1daa5..4f801f4e4c9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -94,6 +94,7 @@ TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
+TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
-- 
gitgitgadget

