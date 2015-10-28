From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 08/26] refs.c: move the hidden refs functions to the common code
Date: Tue, 27 Oct 2015 22:14:09 -0400
Message-ID: <1445998467-11511-9-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGId-0002yF-At
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbbJ1CRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:17:00 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36297 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbbJ1COz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:55 -0400
Received: by igdg1 with SMTP id g1so97169991igd.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTaoSgB3qqEPFD5rkEYClRWit+f13esaLyglsPW8UJ0=;
        b=xkMJgi9My+CCpjMsQX9gjEvwOS9Z8foRHlSgUdNqXFNaqnv945KWEJwzWm+NQK52Kc
         9exZYHztW83wqwnhF6FK5OjQKQkMdYg+bheDOBLXJvE6vIlRvvHPRz2E/xNevp0/o7H9
         KRGYkoeOTYDbLJiCrgURe2mikK3WTyZNElJ/99kIAdKWiCRzTrSSrGdwOhOgDvONu/eC
         TWWpVX2pJRFeU+2ZOGBrQTbEtIs90LHsQNbYM+vfn+gCofvVQQ1xAetohpQbIwAqpPn9
         n7VBmY2mG2JI7BqLfcRAZv0sRQnpYK7dc9ZWvkPgRmof1/jMWgTGmfTFC9OaOXXLuaOd
         TZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTaoSgB3qqEPFD5rkEYClRWit+f13esaLyglsPW8UJ0=;
        b=hZ+/xMu217SSyo1vUk4sFDignJzQtKBvo1JS0/XQunbkoyleKoXRB1ZtVuicZ+8hYa
         sbipMSMa0VePV4fpFEKePLrrRPhgZwm4QuftY0J7xZ2yxDHVpn4JC6oK48pJMFQKvEgX
         QBHpGd+id3SWF25BQIR+vrwVbdNM93YbgyJBqs2kXUG2Uu6P/J7s9LoMa9SA8NqyfAEF
         owwxoYxOHDC+AUA1vFv+aL8tze6LKJvHu+d5I0XEw7AYr61IjeQOchuWZhE1Q2cEzEvW
         wh/xxHc5Z81IkZ7bt+46DbEZIxd7TU+RLpqD3cUY2uajx8c/8geeUXsbzWW+QU+6EyCA
         whhQ==
X-Gm-Message-State: ALoCoQl3iUjB8eOe4JWCjyXBRxjf0RH6p0xdFLqjYpgJx8Rc03/nWrwsgqB7IWTCpt9WwtrwE7JM
X-Received: by 10.50.143.12 with SMTP id sa12mr323229igb.7.1445998493912;
        Tue, 27 Oct 2015 19:14:53 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280350>

From: Ronnie Sahlberg <sahlberg@google.com>

Move the hidden refs functions to the refs.c file since these
functions do not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 51 ---------------------------------------------------
 refs.c          | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 841fa6d..8be8405 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -4214,57 +4214,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
-static struct string_list *hide_refs;
-
-int parse_hide_refs_config(const char *var, const char *value, const char *section)
-{
-	if (!strcmp("transfer.hiderefs", var) ||
-	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (starts_with(var, section) && var[strlen(section)] == '.' &&
-	     !strcmp(var + strlen(section), ".hiderefs"))) {
-		char *ref;
-		int len;
-
-		if (!value)
-			return config_error_nonbool(var);
-		ref = xstrdup(value);
-		len = strlen(ref);
-		while (len && ref[len - 1] == '/')
-			ref[--len] = '\0';
-		if (!hide_refs) {
-			hide_refs = xcalloc(1, sizeof(*hide_refs));
-			hide_refs->strdup_strings = 1;
-		}
-		string_list_append(hide_refs, ref);
-	}
-	return 0;
-}
-
-int ref_is_hidden(const char *refname)
-{
-	int i;
-
-	if (!hide_refs)
-		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
-		int neg = 0;
-		int len;
-
-		if (*match == '!') {
-			neg = 1;
-			match++;
-		}
-
-		if (!starts_with(refname, match))
-			continue;
-		len = strlen(match);
-		if (!refname[len] || refname[len] == '/')
-			return !neg;
-	}
-	return 0;
-}
-
 struct expire_reflog_cb {
 	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
diff --git a/refs.c b/refs.c
index 751219c..071784c 100644
--- a/refs.c
+++ b/refs.c
@@ -291,3 +291,54 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 
 	return 1;
 }
+
+static struct string_list *hide_refs;
+
+int parse_hide_refs_config(const char *var, const char *value, const char *section)
+{
+	if (!strcmp("transfer.hiderefs", var) ||
+	    /* NEEDSWORK: use parse_config_key() once both are merged */
+	    (starts_with(var, section) && var[strlen(section)] == '.' &&
+	     !strcmp(var + strlen(section), ".hiderefs"))) {
+		char *ref;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		ref = xstrdup(value);
+		len = strlen(ref);
+		while (len && ref[len - 1] == '/')
+			ref[--len] = '\0';
+		if (!hide_refs) {
+			hide_refs = xcalloc(1, sizeof(*hide_refs));
+			hide_refs->strdup_strings = 1;
+		}
+		string_list_append(hide_refs, ref);
+	}
+	return 0;
+}
+
+int ref_is_hidden(const char *refname)
+{
+	int i;
+
+	if (!hide_refs)
+		return 0;
+	for (i = hide_refs->nr - 1; i >= 0; i--) {
+		const char *match = hide_refs->items[i].string;
+		int neg = 0;
+		int len;
+
+		if (*match == '!') {
+			neg = 1;
+			match++;
+		}
+
+		if (!starts_with(refname, match))
+			continue;
+		len = strlen(match);
+		if (!refname[len] || refname[len] == '/')
+			return !neg;
+	}
+	return 0;
+}
-- 
2.4.2.658.g6d8523e-twtrsrc
