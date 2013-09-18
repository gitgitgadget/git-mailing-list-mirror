From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/7] connect.c: make parse_feature_value() static
Date: Tue, 17 Sep 2013 22:14:21 -0700
Message-ID: <1379481263-29903-6-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA6J-0006Dp-7t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab3IRFOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab3IRFOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 372703C950;
	Wed, 18 Sep 2013 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QIDL
	VAzU5nZ0KbRgghhTuq2vw28=; b=TUACZ/5Lu9Ye7IRf9rEgP5gZLrGVucathyW9
	SDEmVHNY4YyFlphka/CZFMOa9BIwr6AswbQDVIWEtmwZGaZEA7RWDMr4ow5uG13Y
	/70uE+WSxIYQWBbs8BZTUFtrHxx3Mh6IMhwtMfO5BOWiElvbDklbg5dLwMl9PuXB
	jN3QR1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	U6iYmvKJETweSFQCjgOddVqcGlV4Cto8m0kSjQ8YnM/lyfF2sAQ/WrjqwF48PcpB
	jGdrBeoo1gOzcdzhNCA+IDYDsiD6S2HUK2LcGgafKk6DB5BcyhOWZ6ZoZWTMicNb
	noTxzwshTbTGgs08G0dB0bbB3WBnkPvorVq0Pf8dHIY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AFF03C94F;
	Wed, 18 Sep 2013 05:14:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82DF33C949;
	Wed, 18 Sep 2013 05:14:35 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 358976FE-2021-11E3-AB2B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234952>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h   | 1 -
 connect.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 85b544f..2c853ba 100644
--- a/cache.h
+++ b/cache.h
@@ -1098,7 +1098,6 @@ extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
-extern const char *parse_feature_value(const char *feature_list, const char *feature, int *len_ret);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index a0783d4..e4c7ae6 100644
--- a/connect.c
+++ b/connect.c
@@ -8,6 +8,7 @@
 #include "url.h"
 
 static char *server_capabilities;
+static const char *parse_feature_value(const char *, const char *, int *);
 
 static int check_ref(const char *name, int len, unsigned int flags)
 {
@@ -116,7 +117,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	return list;
 }
 
-const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
+static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
 {
 	int len;
 
-- 
1.8.4-585-g8d1dcaf
