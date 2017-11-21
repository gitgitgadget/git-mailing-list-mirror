Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612572036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdKUXgZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:36:25 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:32906 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUXgY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:36:24 -0500
Received: by mail-io0-f196.google.com with SMTP id i184so13895103ioa.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MM5DJjzenL+0eDQ+gDQRrb7QgxvINn1OTeRrQpyWMUo=;
        b=YAa7wwZOpwS2K7wDEkdSbpAWvWY1A5fgY8jJQzTx0wFF0V8I3ligI1dB00nNHbFWTU
         rZPCmcK5yZ78JXVA/opkwN/tUn4frqjEANYolqYx27XtZv4yilxt0o3b1Vm08iY8huq7
         heZyyGbsw53uqXnpZBAQJxkMFHNDEFw8Q8c3Nrum2Mvhr7TLpwUjF4cd9rvFvhHSr231
         8RZlRAz9yS6buu5W/pRzRu7TEcFKKAxTmpdCRtROGV/PVQFanKifr5pdyuagh6eD6nS+
         EeuhNZt7QHC2dDaHUSCclGsCchryLlEuRLs1tS4PgXTK1Xei4qcyA/HdmeAWxS3t3gn/
         pnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MM5DJjzenL+0eDQ+gDQRrb7QgxvINn1OTeRrQpyWMUo=;
        b=EQvkBq41S6Lyx+q+DhKbwHjQoZlAOXnp2UFBMTyKGUZRrpEWQ4yLNJ23GuwPJa4fbA
         dep6b7SotEi3pgWuR0iGRgavtD+ZXqUMz+xqD3DTniCjhRvuMd6s9tthPKWV1D798i/Y
         ARJmrb4I6DBjS1s5CgDBs/nQ673eULXi7xkUGTRaxri9+XAQxPlgR02E9hCHDEkSNzl6
         RZlzP1ZBNt9VEIWdUSnb/8nX/CH30dX90oxC4KcnrT2GZ26lSth26chkFjLsltsaNUTB
         j2Zo+WT5TiX8zogezDNVQoK+7Z+/bWlMZmZiLcdnElOViSF41jDaMg2bCmjg+rH6qxfK
         8ccw==
X-Gm-Message-State: AJaThX6PEwGK74jVoj7ihQa7NOcgwQ6N8biIliNNWpPt7A6RKwQg2Lu4
        KeR1V4vZNyVOWOcLu9uyr7UsDhi0
X-Google-Smtp-Source: AGs4zMZd8XRlqI7DnENo9YnXPLN+dGbqmvJeT9z2Q2YzTkjWFkJsG+WcGAj8EMnf1k2rsPIOhjBsHw==
X-Received: by 10.107.32.70 with SMTP id g67mr14342282iog.69.1511307384095;
        Tue, 21 Nov 2017 15:36:24 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 191sm1222614itb.21.2017.11.21.15.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 15:36:23 -0800 (PST)
Date:   Tue, 21 Nov 2017 15:36:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/3] git-gui: sort entries in optimized tclIndex
Message-ID: <20171121233621.GO3429@aiede.mtv.corp.google.com>
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121232935.GM3429@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anders Kaseorg <andersk@mit.edu>
Date: Wed, 16 Nov 2016 16:37:17 -0500

auto_mkindex expands wildcards in directory order, which depends on
the underlying filesystem.  To improve build reproducibility, sort the
list of *.tcl files in the Makefile.

The unoptimized loading case was previously fixed in gitgui-0.21.0~14
(git-gui: sort entries in tclIndex, 2015-01-26).

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 918a8de369..f10caedaa7 100644
--- a/Makefile
+++ b/Makefile
@@ -254,7 +254,7 @@ $(ALL_MSGFILES): %.msg : %.po
 lib/tclIndex: $(ALL_LIBFILES) GIT-GUI-VARS
 	$(QUIET_INDEX)if echo \
 	  $(foreach p,$(PRELOAD_FILES),source $p\;) \
-	  auto_mkindex lib '*.tcl' \
+	  auto_mkindex lib $(patsubst lib/%,%,$(sort $(ALL_LIBFILES))) \
 	| $(TCL_PATH) $(QUIET_2DEVNULL); then : ok; \
 	else \
 	 echo >&2 "    * $(TCL_PATH) failed; using unoptimized loading"; \
-- 
2.15.0.448.gf294e3d99a

