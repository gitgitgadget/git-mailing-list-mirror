Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BC01FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbcLIUe7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 15:34:59 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32865 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbcLIUe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 15:34:59 -0500
Received: by mail-pf0-f176.google.com with SMTP id d2so4957857pfd.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 12:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PqQElE9CWLlrFfHRGbVSYD+h/yWoquAz+OY1iA3xuqY=;
        b=Hld/LeS4ES4CCdBuSkNdVqumIiisK75JZXTz+AAgR3P++s+8p3frdt/4UNPFbRUhVK
         F5kW+1YXoE6H3EYOiPGKpNpmMpvt4aYLq8CqjUaSig6LO9Iuji9NKrMMg6HnduxFUZuq
         DjXipAn+WXX9sVQ/WPuspCeW3QW3L2iIkNOsEKe8Kbt9DergTrbrYe+BbT8GPaa77PkJ
         PI2QiZDf+RvXmVVVvUloTyLVIkRARylWA+fOHrEoEW4OIdPkeGMgrkC7BDE2dDHBx7Z+
         Cy87F6ltj97l7LS0mXeVeeVqnl8UXaZuX9KVMzHmOAu5W5IA/2NOjMZHrGI1z7m/P4pE
         M9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PqQElE9CWLlrFfHRGbVSYD+h/yWoquAz+OY1iA3xuqY=;
        b=PIwRR3u7GrWX1eptCb3B+EDtFw5fz5l5pCk0CKvZnpcGohYV3QySjVnBQY9wCRmD3/
         H71fdr0A6QzLxR4PYwAXbhGNzAi9JWLTTG24IFnJlKjYqS07mquzUYL5fKyTT9TwPylG
         36v++GfPNjWz9kvQgUEYykpi4wXNkUx42d0OqHUD5GfqDc7wP2QXd4iTG4gIchx17ed+
         A0OCo61Ga5JvwNdBg2WwyintVTzSc0gXtKFs0JsogZzdDrc0B2R2bZPHhk/IIpgMu+Ag
         j0bUcRToD/085OVV1Gkco0XrjQJ5IaGj37h1ZphkYsjjx8lmzQ64BJQg7JRlSXK4Nz6H
         tnaw==
X-Gm-Message-State: AKaTC02p+y6CBWI2qrAT69Fhs6i7sIJx6Ea2kHlyuirx6kFgrm+XgS96kjiM7NqzxslK6Ntx
X-Received: by 10.99.45.134 with SMTP id t128mr148387750pgt.86.1481315698045;
        Fri, 09 Dec 2016 12:34:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7403:8709:9328:e064])
        by smtp.gmail.com with ESMTPSA id 140sm59921485pgg.0.2016.12.09.12.34.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 12:34:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] send-email: allow a custom hook to prevent sending email
Date:   Fri,  9 Dec 2016 12:34:49 -0800
Message-Id: <20161209203449.17940-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This custom hook could be used to prevent sending out e.g. patches
with change ids or other information that upstream doesn't like to see
or is not supposed to see.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

My first perl contribution to Git. :)

Marked as RFC to gauge general interest before writing tests and documentation.

Thanks,
Stefan

 git-send-email.perl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index da81be40cb..d3ebf666c3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -815,6 +815,15 @@ if (!$force) {
 				. "Pass --force if you really want to send.\n";
 		}
 	}
+	my @hook = ( $ENV{GIT_DIR}.'hooks/send-email', $f )
+	if( -x $hook[0] ) {
+		unless( system( @hook ) == 0 )
+		{
+			die "Refusing to send because the patch\n\t$f\n"
+				. "was refused by the send-email hook."
+				. "Pass --force if you really want to send.\n";
+		}
+	}
 }
 
 if (defined $sender) {
-- 
2.11.0.rc2.49.ge1f3b0c.dirty

