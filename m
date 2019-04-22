Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927891F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfDVFoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:44:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44232 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDVFoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:44:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so5171487pfm.11
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GaACQTwGmVOkl57rwXIIOJ61wZKfX2aoPx6Ou9VulnM=;
        b=uAjQs706Zin2k1DiXUdMN1pwI+Xx1x1IA9swULE/LPSrAatTpMtxkgGrJRVN/bqd4R
         Y+xTu3i2+oql/qQdjrQ6ihbDYgzRvNfc41sKrxpMIgMkNUckaw31OBf/mUcUwgmcETK1
         aF6q2CarciL6mcfZMshuJaBrq3o91GGIBP3Znv+2xq/ai+c8UgSeZ1T5raWl9SiLpaLl
         j09XbrN9hkyKaNwIjibWhCsjsKrJhfQAZz3bGU7awpLmcAYon6r2+gAhjRYfFvb/rDv4
         ahfpjIS69Rq722aj4n+e2oVAGKg/arPHQZ4dBUYSlnR4/GOQhHbL3bgJ9YE99M9hDY85
         DVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GaACQTwGmVOkl57rwXIIOJ61wZKfX2aoPx6Ou9VulnM=;
        b=UN30Z0+oQCKRZmRFbcYlINK8FeZc6bcEoCXtssgBByWq5MAt8b7FRJ9ss7GbGD/J6z
         7HyJz47xQxoM5UrihQKK8GmZAKsczmcUMym4oQEtYOKJYAe+/azJR+oacXUdgiZfqQqi
         k4+0wkf2jOpqDCP9jC81IogRv/Wneu4JVWN0ExyAF1Nds7YGnHBiomdMEbw7plYLmRhN
         f7YcnHMj270+43vMVJgiWbu/JrtnWqIAPgpMihNEwvmTyzxdr5e48Nim2UA8BjBtvdAo
         K7ZIUd3277WvCnXHmJtfql6VVr/vIx98R068dH+2Su0E64oBYQJsNZhDKCtpkF7ianVC
         9dXg==
X-Gm-Message-State: APjAAAVNwmMnegs3Z6ThYVBvOHhWEoUv0+eKs39U7Afe7ic16MlqBGyT
        LSrSZYLOdXmIYLIkfg1sU7Wd+Ttz
X-Google-Smtp-Source: APXvYqy6jH7hkpGq2ZIrAZkUOyGUBgNvRg8SecIlYOfPiPv+ZC1CW3PKvyBtCXMozMhIlHknEULHmQ==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr18907056pfz.172.1555911847376;
        Sun, 21 Apr 2019 22:44:07 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id w1sm19543387pfw.101.2019.04.21.22.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:44:06 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:44:04 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] cache.h: fix mismerge of 'dl/no-extern-in-func-decl'
Message-ID: <9d6c51b2118b24cd94f3e2951ff0e9ee82afbd98.1555911520.git.liu.denton@gmail.com>
References: <cover.1555487380.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555487380.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After merging 'dl/no-extern-in-func-decl' into 'pu', it seems like the
conflict resolution mostly went well except for one spot, which this
patch should fix. Although this is only currently only a problem in
'pu', we should fix the entry rerere cache for if this branch ends up
merged in 'next' in the future.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

I guess while we're at it, I noticed that these commits are all missing
signoffs from you. We should probably attach those while we're fixing
this up.

Thanks,

Denton

 cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 5f8607d4f4..bb53660f45 100644
--- a/cache.h
+++ b/cache.h
@@ -1393,7 +1393,7 @@ int repo_get_oid_mb(struct repository *r, const char *str, struct object_id *oid
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
-extern enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
+enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
 
-- 
2.21.0.1000.g11cd861522

