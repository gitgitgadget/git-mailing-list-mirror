Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317AE1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKDJ7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 04:59:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJ7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 04:59:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so14428664wrw.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 01:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Bv6Sa/pPpzTh7PcHzB7QghBNPzN2NHdW081Foirntg=;
        b=X3CYw2jzxG2OGnRs7UAeWH5v2+KgtiuqBYjS+24RDNT21YMnamfvdmdAW4RyJKY9eh
         axnjhK36+e40/BZ408X6sAwvWU7tzljykWJ+NWie1u0I+3RCl/gj9f3F3CE5FpGj1AJ0
         YgCovvA/AJ9LI2O6nVvaZKHcoBcj9cYZ1pCrKUxLPJG9jlrEAmbXa2gweej7wHkXowYm
         Xk523VMcYRd0pyAH2jTgSefjOJQmJ3wtjdG2Xib6tVUcgJ8niX4OWdWnt12b6ksIL2LF
         V4Tso2MuNJVKeUy69uAtRWK0McXrMQqbexKjucvBloizvYFzG89pubZMY7pfQQFxQ7mZ
         J0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Bv6Sa/pPpzTh7PcHzB7QghBNPzN2NHdW081Foirntg=;
        b=Be+gorZy5/JF6ixIpuGDr/qwYZwowm2jFNzy6kA1od+6bJ7BCFsdgdYWfsZ7ko3wkM
         OZ/DZOV5ZA1n247kRL1Td8uoysAivxhQUo1r3IuF/EnJeZvvgsBbmW0ed6oSKGi4xGru
         XcUQaapDgrDMABEjh1iNqr4lb5CfgnbpbOZQM7+oJbi8Emn2G4QysUbdq+wVSXyTz9h4
         ZMd8x7oaXo2rc3lbj2L2G0iC2gGeG0jKKIGW2iuHbFEvEdlndQ2OPlkzgxEturtqiDjq
         8pOOr5oxFdnhWmIBCL+/ykN1fKYP6tyzxCscTgdBUua3GdHJBA9j8ee980UgPLqtSa8C
         b3qg==
X-Gm-Message-State: APjAAAUNLHLjQ3DMBb6qk6myY5712IY8RsFVkPbYit2XkcRfRriLtBB9
        EvAuH8pcAtftJ4P5ZkizfxqbJVx2
X-Google-Smtp-Source: APXvYqznmQKK+ozq7Mnb4wH0jEXwNj3oWSddDFbwmSfuxTF82PU2QPoG8Rek+WmMZNn/mPTjVjLq5Q==
X-Received: by 2002:adf:d083:: with SMTP id y3mr21078762wrh.53.1572861567791;
        Mon, 04 Nov 2019 01:59:27 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.81.118.113])
        by smtp.gmail.com with ESMTPSA id j22sm23382554wrd.41.2019.11.04.01.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 01:59:27 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 30/32] ident.c: fix LGTM warning on the possible abuse of the '=' operator
Date:   Mon,  4 Nov 2019 09:59:21 +0000
Message-Id: <20191104095923.116086-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.467.g566ccdd3e4.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the LGTM warning of the rule that finds uses of the assignment
operator = in places where the equality operator == would
make more sense.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 ident.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/ident.c b/ident.c
index e666ee4e59..07f2f03b0a 100644
--- a/ident.c
+++ b/ident.c
@@ -172,12 +172,15 @@ const char *ident_default_email(void)
 			strbuf_addstr(&git_default_email, email);
 			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		} else if ((email = query_user_email()) && email[0]) {
-			strbuf_addstr(&git_default_email, email);
-			free((char *)email);
-		} else
-			copy_email(xgetpwuid_self(&default_email_is_bogus),
+		} else {
+			email = query_user_email();
+			if (email && email[0]) {
+				strbuf_addstr(&git_default_email, email);
+				free((char *)email);
+			} else
+				copy_email(xgetpwuid_self(&default_email_is_bogus),
 				   &git_default_email, &default_email_is_bogus);
+		}
 		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;
-- 
2.24.0.rc0.467.g566ccdd3e4.dirty

