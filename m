Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1310320248
	for <e@80x24.org>; Thu,  7 Mar 2019 06:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfCGGoc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 01:44:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46130 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfCGGob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 01:44:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so10673021pfh.13
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+MgsD3XCv+iRDk4Be2acXCpxr0v5ZoKFj4lHGZSm9I=;
        b=GUddjDVDWNK/MEF9nQRKZcYH/FHboU+qT4FhV5gJDO4IjAwn2i2QY77dZd8w9V5p+i
         jbYCPk2jo3NqeibQkdbaYqNzY5X7TBG3NcSqMuRbJZ1qBvtYhPjsB1uwwfg5y9UXhf+s
         aO82yrHYDTiwnV2LA4jnw2bIZy/yDbJj9vcfYrFgfIp2I1dixaOqVxuyXOcXOvfpc71N
         q+bM+D5g8HaBqtsMj/dTQZAMHkBwR0R42K/hFp0Fq86nrGnplEUocERs0a6B64P+9+nR
         4ej4NgZXVbUEp9vZAqKYNeaOaHjdNSvRDO/sJeDuXEJVDQgZhFd0zw78owi/sxH16uSn
         RYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+MgsD3XCv+iRDk4Be2acXCpxr0v5ZoKFj4lHGZSm9I=;
        b=cTtShPKbnN03ULhjueJYHO3ICWC4sP/48QBUI/DDXAJdFinQGaZlQh6JdWZyC6QChk
         fo3oOeZvDIgz/JlqKOROjtwkMI8fBAlgNvXRyWCxG/jR+mYnib1J11b4qfDDqFjAjWw7
         jNI+MN7kMxcdjQhNi79So8RZ4EGH+0bhXy8he1Om7sJPEe+FYD9ZF8DpV9DaN6c72p9B
         z/vt9RZpQIy94z1p6eqtUwuzuajZo6MMFTQKjDrwMMBiEOGcmk9W3OemCmGjZriLeJR7
         wvso3YVx/R+R+1sAH3AvumRLJwQuqmE0opcadRiBv//qRWCqbywrvH0OuaZAiwgdl69E
         am3Q==
X-Gm-Message-State: APjAAAXz8Abg4+px9f3HzjQesHzrRNsec3H9UqjqEjx+VhsCINrm4CxS
        KsMp/VqNbfEwwmrfmU2y18RsdvWB
X-Google-Smtp-Source: APXvYqxOa8GYexg2OHcaykFrDBLJDsiwE4NQw/sGVXVJBZQ+i3rDqbjeYfaYZMSoEVvi5/STW9ievw==
X-Received: by 2002:a17:902:9893:: with SMTP id s19mr11328899plp.165.1551941070683;
        Wed, 06 Mar 2019 22:44:30 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id x1sm5221737pge.73.2019.03.06.22.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:44:30 -0800 (PST)
Date:   Wed, 6 Mar 2019 22:44:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] sequencer.c: don't die on invalid cleanup_arg
Message-ID: <f3af8000aec51e49f3fe8f90dbfec61606596b2e.1551940635.git.liu.denton@gmail.com>
References: <cover.1551867827.git.liu.denton@gmail.com>
 <cover.1551940635.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551940635.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When get_cleanup_mode was provided with an invalid cleanup_arg, it used
to die. Warn user and fallback to default behaviour if an invalid
cleanup_arg is given.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5c04bae7ac..f9bdfa90ad 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -502,8 +502,11 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	else if (!strcmp(cleanup_arg, "scissors"))
 		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
 				    COMMIT_MSG_CLEANUP_SPACE;
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	else {
+		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	}
 }
 
 void append_conflicts_hint(struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
-- 
2.21.0.368.gbf248417d7

