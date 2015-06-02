From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 06/16] remote.h: add new struct for options
Date: Mon,  1 Jun 2015 17:02:08 -0700
Message-ID: <1433203338-27493-7-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:05:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfd-0000ju-CL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbbFBAC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:59 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33133 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbFBACk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:40 -0400
Received: by iebgx4 with SMTP id gx4so121187110ieb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T661gZve4w9bKMOhxSnv7Ap79jB06qeIansHNaDSErE=;
        b=FlYcof4ab6Buh/YRB6Ec625D9Gch8R7+mNbJ3MVEcpNVJNhQqF/I7yi+WUIKNvg1bR
         9/rEGM8NnArQUXCydAr8vp61daHQcSOjaXhqcH+2W2Co437wIKE+iVbA3r3Jd5m6Da3P
         DtBgW7ot+z95buZ1ufZbxISHMUZoEGbvmWD4IlLM/kU5FrNZErJ175BFgq6voESQKw6V
         SOpRo9QMQHMfA6kBDCArYcmOu+6bLJ2hiEduNiHmgJRbUtI3Ka3aapPL+/lMWDVwIo0m
         iX4DSGeAZFlR3p/Zv6HT2hG72S36norOjCYW/kIg8fhrWC54GQnEECIqAem5HyMLIYAr
         25cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T661gZve4w9bKMOhxSnv7Ap79jB06qeIansHNaDSErE=;
        b=EtyJB7//S9Hh3gWhbZONjNUQpgu9ZMqL/miXTa4n80QfqnZy1sjISnriXAqymQeSjT
         YBWIPqnV91sia+65INl6QI+P09tMsfhbDZeFzJMm0hUrbzuFoZphLzCiv7Tm30NQFtIn
         vrnI2SN+Vr7jHjvZyK0leFpnPkJNR8TniYtuVGJ2Zl7LyPl2cMuG7FUh9UE3zkGCMG9F
         KcvM37aB3lG4c8+uWogvNfrUsWnBD7/bv/I1TD0HxLuW+XnCbhRCBqiV4ggpZ8fcrL5Q
         aedalP9fungTLJZwwbHIg8YWfawBFYUGSMJOr2wwzXZSVvbgBKafBKyu6OmnTbRQ88bx
         jONA==
X-Gm-Message-State: ALoCoQlIz9OAM7nTGK8WXb4e6GqDH7WMob9jI3tdNEi8ehTjC4aH6wXEDmaKqmctjvFGvNIu+8t9
X-Received: by 10.107.161.6 with SMTP id k6mr31236064ioe.41.1433203359489;
        Mon, 01 Jun 2015 17:02:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id 17sm11467902ioq.39.2015.06.01.17.02.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270496>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 remote.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/remote.h b/remote.h
index d5242b0..16cacfe 100644
--- a/remote.h
+++ b/remote.h
@@ -56,6 +56,20 @@ struct remote {
 	char *http_proxy;
 };
 
+/* todo: discuss if this should be merged with
+ * git_transport_options in transport.c */
+struct transport_options {
+	unsigned multi_ack : 2;
+	unsigned no_done : 1;
+	unsigned use_thin_pack : 1;
+	unsigned no_progress : 1;
+	unsigned include_tag : 1;
+	unsigned prefer_ofs_delta : 1;
+	unsigned agent_supported : 1;
+	unsigned allow_tip_sha1_in_want : 1;
+	unsigned use_sideband;
+};
+
 struct remote *remote_get(const char *name);
 struct remote *pushremote_get(const char *name);
 int remote_is_configured(const char *name);
-- 
2.4.1.345.gab207b6.dirty
