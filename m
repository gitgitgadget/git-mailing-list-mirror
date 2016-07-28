Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3C11F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759073AbcG1R0u (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:26:50 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34101 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758990AbcG1R0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:26:49 -0400
Received: by mail-pf0-f169.google.com with SMTP id p64so23980764pfb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 10:26:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/oJa+nqWCfrrOOy/v/Xp+ttGta+akRR6sQt27WnSQqg=;
        b=EYep4DHTyKY8bGZ/WUicqrkSr2al3BY/5+5H+RhuCzSLXr836wFkZZJLY8YxfdnvZu
         8ANkDDT1AU6LFbdaKZEDTrPt5o6C0LUx3sSQN8aJ3ZhWPMNE6RycZTeljU17+Rqm1AKI
         o7imirrU7iqrpUDx/LznixOes5zs8eSFsDGod8G8csldEmDrSHLeG+InLLtRy8KMOpOm
         E3UIHsm9hUhVLzKZO0TB4jtJfMZf9LPlLzQlhJSo+t5fXaQ33YKlA4zvAGzqOE45MGjC
         pc2zA/8Dsuddk5h95nLh6DYaC8thjWDSSW+FHJY8qk3QvFi80uP+1FqrLej2enK1gROf
         zfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/oJa+nqWCfrrOOy/v/Xp+ttGta+akRR6sQt27WnSQqg=;
        b=Cks6j6nUWqArL/N9lbEHYj9cYLMt3e7pUxjekOo7AtAvDnm9RHtg5HPxykUq5lfbFe
         A6xj2Qd12DHo0tzAZgonRjsTdnMkyzCr9U7CEc/nZdLuB6Fr5enCta021hz86a9tigMQ
         xLvj9QORz2OehfVY5URXiSBS4kUJMZ0cdSw/q7CUFTCF2ZUvJF/BcLzUO42o2Fh1wN4g
         BSC93a6ydSayS2lUAs6/TYLBOlt5d51mfbJndiyhM/VHycuPEyirzRIRhRU5wrrN03YT
         xXCwJfU6b7xPA8xABJe825CWuOFeZl0foce+3dycYk+rejsQ4U5SUuPUZzATvXfyUKlk
         c1+A==
X-Gm-Message-State: AEkoousfmgEZ33VfglHPTUYbfHd5PV4YEEWq09ICnq8MEV+HtD2VssvXMXG0vB2CqgAxGU4/
X-Received: by 10.98.75.65 with SMTP id y62mr60218390pfa.99.1469726808351;
        Thu, 28 Jul 2016 10:26:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id a5sm18544925pfc.89.2016.07.28.10.26.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 10:26:47 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] submodule update: allow '.' for branch value
Date:	Thu, 28 Jul 2016 10:26:39 -0700
Message-Id: <20160728172641.8376-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.466.g8c6d1f9.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The meat is in patch 2 and helps Git and Gerrit work well together.

patch 1 looks unrelated but it is not, as when left out the broken test, breaks
with patch 2. This is because we add more commits in the submodule.

Thanks,
Stefan

Stefan Beller (2):
  t7406: correct depth test in shallow test
  submodule update: allow '.' for branch value

 git-submodule.sh            |  7 +++++++
 t/t7406-submodule-update.sh | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.9.2.466.g8c6d1f9.dirty

