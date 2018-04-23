Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB931F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeDWXZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:25:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42547 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWXZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:25:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id o16so10584773pfk.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CWygTvjbYcHXWMOlF36965VLT90+9pgdTbqgOaHyN2M=;
        b=tUC9zebPPHXIsLleUJ3woradMNSGQy58VDUnSUpdw+nxhCif+NV+tiJWitK/W3jH3U
         R088wygw5Hjq3CUDvHvZ0Jus9CjjJMHfSZLziy31HDvMEvqjmNv2Tq6jXzW8aGZ6S4Zc
         EVLxIyc5zGQgsQuW+S4Ou+YjzCC1+JVUqpU3ocTzq+bgn/on6IfxPKj1hfjJHg4e2URL
         HZNIp3uhwW4F3Ssw9TDztUErepcui1sIZa3ump5edrgJ+BlsCoulV3gETing8feSqH4a
         3OMsVBD1UvX4Ijp/sTTzF6vkGeLk/1/Y9lzwS+cUXb2N0YuIhl7o7Rgeh7zHWnxQw8+R
         V5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CWygTvjbYcHXWMOlF36965VLT90+9pgdTbqgOaHyN2M=;
        b=bfZGUojZP/yNEgr7Cr5JV5P7skGy6ZLe4HuMiQhL5EwZJAlLlrYVEHMKo4tLadkOCw
         BNAtODn+1r2M1gupoY6ADq8kvpFpRymB/IlaxhjRgOoViLOy0v1VhuSTSvzCAJKGT/r1
         eo7PF9n0eCfSl7BGMMTgXsn/FXqBWEmUHWUn3KdtZ9eIaA3GozKNtQY+ztq2dOCWnTs3
         qobTrT+FytecsVuC73O2BG4PlWjn13+a4WLi1N0r577DSlkMzg1GXIM2JAdquZXG6Q8I
         rqxCUnkGrv3WDVFXTsYH8eDPQ/6B2GHQGyd3Wjqq/iTRi6mYy4+5sVrL8CkEJx5Jcqc5
         hwkQ==
X-Gm-Message-State: ALQs6tBcguUip40groyhIRnlpamtUm0SfMmGYpXIK2rXQufuJFApWg76
        UzUcDz1ZlBq4Gh8vxIpBwPQ0HwUS
X-Google-Smtp-Source: AIpwx48zTfdVQ4Mhiu3NqjBLc5ojjD2g7RpvJWZWVeNqloFHXpt07yeFn3b+u/ZWd4Cv+oCUD331qQ==
X-Received: by 10.98.198.195 with SMTP id x64mr21471346pfk.11.1524525937771;
        Mon, 23 Apr 2018 16:25:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c28sm33462618pfe.27.2018.04.23.16.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:25:37 -0700 (PDT)
Date:   Mon, 23 Apr 2018 16:25:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dan Jacques <dnj@google.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/2] Makefile: quote $INSTLIBDIR when passing it to sed
Message-ID: <20180423232535.GD25128@aiede.svl.corp.google.com>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com>
 <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
 <20180423232326.GB25128@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423232326.GB25128@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f6a0ad4b (Makefile: generate Perl header from template file,
2018-04-10) moved code for generating the 'use lib' lines at the top
of perl scripts from the $(SCRIPT_PERL_GEN) rule to a separate
GIT-PERL-HEADER rule.

This rule first populates INSTLIBDIR and then substitutes it into the
GIT-PERL-HEADER using sed:

	INSTLIBDIR=... something ...
	sed -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' $< > $@

Because $INSTLIBDIR is not surrounded by double quotes, the shell
splits it at each space, causing errors if INSTLIBDIR contains an $IFS
character:

 sed: 1: "s=@@INSTLIBDIR@@=/usr/l ...": unescaped newline inside substitute pattern

Add back the missing double-quotes to make it work again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8f4cb506ff..727eca5d0a 100644
--- a/Makefile
+++ b/Makefile
@@ -2108,7 +2108,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
-	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
-- 
2.17.0.441.gb46fe60e1d

