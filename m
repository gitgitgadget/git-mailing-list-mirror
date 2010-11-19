From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/6] url: add str wrapper for end_url_with_slash()
Date: Fri, 19 Nov 2010 20:46:26 +0800
Message-ID: <1290170790-2200-3-git-send-email-rctay89@gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
 <1290170790-2200-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:47:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQN3-0001C8-Pp
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab0KSMq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:46:58 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:54600 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab0KSMq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:46:57 -0500
Received: by pxi15 with SMTP id 15so1003656pxi.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+aMe3xA5qoAmvXkUeklba7gdzRt+UHdZo3QTg5J0H9Q=;
        b=Zmfe7HB4RV099PWr0AqBKRPiAs986R4NcmfjADaYb/BjI+WFfE/g8jpn950ejJRgXA
         QAWbEgwUa7UMXAFi2ZDbbp+vbgpyJzwEfPSXRQZRxwDASt1m6yzTACAVshfVJR/sdOZg
         SbLjsVPnUiuzZq8OGPqDJD6H16f91EG+T84tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YuqEYaaCvQh8Z+PIotsDwWEEu2wA/bmr/KcwUFi679+ODOFGToOmnh1zKdLzFxAkoK
         8PhDX94MGhxXn51vxiKWfQaskdOEgv7E7t8Kh9n6z5bsFYQ4GpPSV5Q6/ts3KtZ5hJI3
         ORKt37JlYgh48uerkNgN5dJxkLOPx0cyMxrJk=
Received: by 10.142.11.18 with SMTP id 18mr1661141wfk.262.1290170817272;
        Fri, 19 Nov 2010 04:46:57 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.46.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:46:56 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290170790-2200-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161747>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 url.c |    8 ++++++++
 url.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/url.c b/url.c
index 7cebc64..138396c 100644
--- a/url.c
+++ b/url.c
@@ -132,3 +132,11 @@ void end_url_with_slash(struct strbuf *buf, const char *url)
 	if (buf->len && buf->buf[buf->len - 1] != '/')
 		strbuf_addstr(buf, "/");
 }
+
+void str_end_url_with_slash(const char *url, char **dest) {
+	struct strbuf buf = STRBUF_INIT;
+	end_url_with_slash(&buf, url);
+	if (dest)
+		free(*dest);
+	*dest = strbuf_detach(&buf, NULL);
+}
diff --git a/url.h b/url.h
index 8cb74d4..7100e32 100644
--- a/url.h
+++ b/url.h
@@ -8,5 +8,6 @@ extern char *url_decode_parameter_name(const char **query);
 extern char *url_decode_parameter_value(const char **query);
 
 extern void end_url_with_slash(struct strbuf *buf, const char *url);
+extern void str_end_url_with_slash(const char *url, char **dest);
 
 #endif /* URL_H */
-- 
1.7.3.67.g2a10b
