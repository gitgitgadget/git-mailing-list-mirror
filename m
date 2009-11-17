From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Mon, 16 Nov 2009 22:49:27 -0800
Message-ID: <7vy6m5hci0.fsf@alter.siamese.dyndns.org>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v3a4enkzt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHsm-0006Pr-Oi
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbZKQGtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbZKQGtb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:49:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbZKQGtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:49:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 133BB7D024;
	Tue, 17 Nov 2009 01:49:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcggIPnXJ65HVpVsF72wIJK0/6Q=; b=UhzhxH
	dkVCTmko4C6bwrS89Dw/GjVt4FY94toEexo083vuA0HI8pMc1abVOTKUPxqIqya4
	JMQgbpcXEMuAuIw/n6C63/75WlWqjNfUmL/VE/AtLTxaus3+z/4wa6R9nXZm3ab4
	d8HCCJoC68K8dkU1vBzGNKhwb59GxlkI92oww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6anYcA3/snmXsoYrl/YeXMuKmCZykJ/
	xPRmhHxbZ6NOOh5qrCGloPlgJ8+u0rtL1lPuUXsssjqNzTc8fMyF7UrLZSpgf/eB
	XmgCaAYM/M8qhgxLVOXAfBK2zdoH5pKPLCsIx0PNGJziLcJn1veUuzqeZbj0tgyK
	XIXV5+ljMl8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9E397D023;
	Tue, 17 Nov 2009 01:49:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E402B7D021; Tue, 17 Nov
 2009 01:49:28 -0500 (EST)
In-Reply-To: <7v3a4enkzt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 16 Nov 2009 14\:49\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CAAC45E-D345-11DE-9B9B-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133068>

I'd like to squash this to your patch, based on the earlier review
comments.

I didn't mention about the first hunk; it is just a style.  An opening
brace that begins a function body comes at column 1.

Also first_slash and to_copy are made const pointers, as they do not have
to touch the region of memory they point to (otherwise you cannot assign
path to to_copy without getting warned).

 config.c |    3 ++-
 path.c   |   32 ++++++++++++++------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/config.c b/config.c
index 0fcc4ce..b3d1ff4 100644
--- a/config.c
+++ b/config.c
@@ -351,7 +351,8 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
-int git_config_pathname(const char **dest, const char *var, const char *value) {
+int git_config_pathname(const char **dest, const char *var, const char *value)
+{
 	if (!value)
 		return config_error_nonbool(var);
 	*dest = expand_user_path(value);
diff --git a/path.c b/path.c
index 009c8e0..2470f78 100644
--- a/path.c
+++ b/path.c
@@ -208,11 +208,8 @@ int validate_headref(const char *path)
 	return -1;
 }
 
-static inline struct passwd *getpw_str(const char *username, size_t len)
+static struct passwd *getpw_str(const char *username, size_t len)
 {
-	if (len == 0)
-		return getpwuid(getuid());
-
 	struct passwd *pw;
 	char *username_z = xmalloc(len + 1);
 	memcpy(username_z, username, len);
@@ -223,18 +220,18 @@ static inline struct passwd *getpw_str(const char *username, size_t len)
 }
 
 /*
- * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL, then
- * it is a newly allocated string. Returns NULL on getpw failure or if
- * path is NULL.
+ * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL,
+ * then it is a newly allocated string. Returns NULL on getpw failure or
+ * if path is NULL.
  */
 char *expand_user_path(const char *path)
 {
 	struct strbuf user_path = STRBUF_INIT;
-	char * first_slash = strchrnul(path, '/');
-	char * to_copy;
+	const char *first_slash = strchrnul(path, '/');
+	const char *to_copy = path;
+
 	if (path == NULL)
 		goto return_null;
-
 	if (path[0] == '~') {
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
@@ -243,8 +240,6 @@ char *expand_user_path(const char *path)
 			goto return_null;
 		strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
 		to_copy = first_slash;
-	} else if (path[0] != '/') {
-		to_copy = path;
 	}
 	strbuf_add(&user_path, to_copy, strlen(to_copy));
 	return strbuf_detach(&user_path, NULL);
@@ -300,14 +295,15 @@ char *enter_repo(char *path, int strict)
 		if (path[0] == '~') {
 			char *newpath = expand_user_path(path);
 			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
-				if (path != newpath)
-					free(newpath);
+				free(newpath);
 				return NULL;
 			}
-			/* Copy back into the static buffer. A pity
-			   since newpath was not bounded, but other
-			   branches of the if are limited by PATH_MAX
-			   anyway. */
+			/*
+			 * Copy back into the static buffer. A pity
+			 * since newpath was not bounded, but other
+			 * branches of the if are limited by PATH_MAX
+			 * anyway.
+			 */
 			strcpy(used_path, newpath); free(newpath);
 			strcpy(validated_path, path);
 			path = used_path;
-- 
1.6.5.3.283.g4b054
