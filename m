From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] submodule-config: keep update strategy around
Date: Tue,  2 Feb 2016 09:51:30 -0800
Message-ID: <1454435497-26429-2-git-send-email-sbeller@google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 02 18:52:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQf7n-0002Zx-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbcBBRwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:52:18 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35091 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbcBBRvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:51:46 -0500
Received: by mail-pf0-f181.google.com with SMTP id 65so108842102pfd.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3UoHwYEuxzOZLYso4j5G+8y786ivC2lbQx3Xh77713E=;
        b=Gc2MCvl0xJcJmy//US7jhGTh7ANn44HKIAQTxJn8/r4OR+oAgnI5F8/ePPdJc1nFkH
         JX55MYCDQyFwANIpv20s7gGRkOL4MKciZpe1QjMSJaOUKqxJT9TBYWKjGfcTydwO0pwN
         J8irOC9H9HWpNHFVg+PshR7SNe6yQ15WHD4LRbN6B8U1jmp0jV/T/uzucZE/ivB2lyU3
         KcOyDVKmKddO84X4PHr2ISGLDP7yBWlHvBbr9xraTjDb1Skx3WCXwoGSmoiAIyvfiZJu
         QP0k/od0uYM9jCMIAkSYqrcqfIwCNdwInw/LcEtkR0Th5qht4INu9kEB4vq3GEhRARSX
         pd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3UoHwYEuxzOZLYso4j5G+8y786ivC2lbQx3Xh77713E=;
        b=clcpdjTtYrIJlB64wwYR3vB5qioc2pKujZaC0o5/7RUuz2Rbz+yIIkI4YssrhvXWHS
         TYDAm+shzV5pirvFMnlgBkVqKWoht5fgNHuULdIM+aX0izy0hL0ZT5bzYjDuDM3RJ4+s
         +E6Wzjp89nr1Di1L4o5ldna0MGhr7a6pJ1CbZPiy12iu5g5hFAPMZO2eyZWsru3hGaMP
         xk5TEF9ri/OKZs0ocsosjwpIwPg9hhhxt44DeKol7WBnFFL9XCdGFCHpAj/MYldbXvDB
         gpRHZ5NDBhiNNyQBsu38uCKWxvfuTY+u2X+DfjUqaXPcLPUJQk3NNVlWW2lcxwXK85bV
         0Tuw==
X-Gm-Message-State: AG10YORqgeCQebqbv0v2DB6Xq0v7x/lcZW1sSjKYEVP0c+3FFXVBleY2S+/0e1H0uVA9aF8r
X-Received: by 10.98.11.143 with SMTP id 15mr18313524pfl.134.1454435506436;
        Tue, 02 Feb 2016 09:51:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:11e1:ff63:6d72:465a])
        by smtp.gmail.com with ESMTPSA id tp6sm4081844pab.25.2016.02.02.09.51.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 09:51:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <1454435497-26429-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285291>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..4239b0e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->update != NULL)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else {
+			free((void *) submodule->update);
+			submodule->update = xstrdup(value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..f9e2a29 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -14,6 +14,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
-- 
2.7.0.rc0.42.ge5f5e2d
