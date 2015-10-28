From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/8] submodule config: keep update strategy around
Date: Wed, 28 Oct 2015 16:21:38 -0700
Message-ID: <1446074504-6014-3-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra38-0003Ev-K3
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbbJ1XWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34920 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbJ1XWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:02 -0400
Received: by pasz6 with SMTP id z6so20295135pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FYURr56FbNAxCvM4buIv6gEVUH6jmuVD2AnqLrcyOew=;
        b=cBt4I2RLLdmTFXSPgq2lijvUfiWTkHSKiZV2esYoxGWqwJo/86kSSKRNEx5Lk0dScY
         u33+QHhfC9WNki/3IR1nnOAFDYSRT0/GPSZz19RLNp60lpGb5M8ap32pRy39Y/HZRHvh
         0K8g6fFenZt4OzPe0ychwMX+Ze0o8zsRF4hIUmfUXhq3qbR598MWmEP9CpF89NC4wErv
         0MkF94ULEJY9bOha0fbvA8iPRS1JYUORCz7ikI8khVvjA+Gy2Lysadr2e4HW6+Jhi5Fj
         IH1H+S4qtYCkpu1M0ZMfIXksCvYnEeCOypn+9OSPXRjaUcIkT8/q0/hmX7h4EBfE9o98
         Cl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FYURr56FbNAxCvM4buIv6gEVUH6jmuVD2AnqLrcyOew=;
        b=cj8RcTxrjhXQ9llIZBRqQsmeG2nqigUlmXIihHMOXFrZhKn1NI6qf6gHoD0a7MehIg
         ronNxJ86+mmMbfb3Dmrr70pDcCikw14kUVhYX+lFK+oIGAoVCUqyhIUHPUqvSsmIqsrK
         +mgAqKOCYJ7DmqOyKz5me4kwYgU7jRy18qdI2v/NbRCR6voe/dOy33J+BY3tsdgp75bw
         5VQ8aoHzmKJ1xL/K+WA1sKGhahV5yoYG2TV8sqSnEkVsPAK07rfKEDPAw2KwL7trUVYv
         o6BfXSxmk8Qgq0XX/peexWDIQnPp4n+LN/9ioLwFdGKF0xgQ/iicZh/m8qnfaLb/TAjy
         sGvA==
X-Gm-Message-State: ALoCoQn+17/NiV3CX62IjhVqjntyTcyjCnUlhnM059riivomX1OLnUzoFeycG9VXHkTT5S9WI+4y
X-Received: by 10.67.14.66 with SMTP id fe2mr28984747pad.4.1446074521802;
        Wed, 28 Oct 2015 16:22:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id tj2sm47512076pab.4.2015.10.28.16.22.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280430>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..8b8c7d1 100644
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
+			free((void *)submodule->update);
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
2.5.0.281.g4ed9cdb
