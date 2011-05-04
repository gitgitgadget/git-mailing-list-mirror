From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH V2 5/5] configure: Check for libpcre
Date: Thu,  5 May 2011 00:00:21 +0200
Message-ID: <1304546421-25439-6-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 00:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHk8k-0002pM-KT
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab1EDWBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 18:01:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53302 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab1EDWBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:01:31 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so1189562wya.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=x45PbF7eKZkO0oL/vz9H1cd5BzoagvSd9PRKOoONViw=;
        b=gdCJsMvzGF5a1idNPwIFQQqYpTX7PRTS7Gm1GlkqXpkvmagxdZukTSKk0zHxfFqgFY
         iPVuk4o25wLrb3TnN15VJdr+FLvJ2EFWpwzbBEeFHrXDl2zNy03V8K1+TDl0t3bfiaqn
         HMROmiI2/0JL+pzfARfwR8jKT2bfL4bS09OeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s7YNLUvY3fFdP/NZhcfFbLZPXTPY57exZHMrKOxzqrrMXGlZoeLG3+KqJQYO2acMQZ
         /+MET5V3FI4bP4lqPqfSOhzHyKB5+Dm/GjTef4GFd0W5iXqRnHxEyM8DLNeoMk5gXmgg
         Srs9wGaMEjsDwgAesB5AzKA37uVTj4iln+bzY=
Received: by 10.216.237.67 with SMTP id x45mr5402899weq.72.1304546491204;
        Wed, 04 May 2011 15:01:31 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id r80sm800867wei.15.2011.05.04.15.01.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 15:01:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172777>

This adds checks for libpcre based on checking for curl.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 config.mak.in |    1 +
 configure.ac  |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index e378534..9bab021 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -30,6 +30,7 @@ export srcdir VPATH
 ASCIIDOC7=3D@ASCIIDOC7@
 NEEDS_SSL_WITH_CRYPTO=3D@NEEDS_SSL_WITH_CRYPTO@
 NO_OPENSSL=3D@NO_OPENSSL@
+NO_LIBPCRE=3D@NO_LIBPCRE@
 NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
diff --git a/configure.ac b/configure.ac
index fafd815..4711369 100644
--- a/configure.ac
+++ b/configure.ac
@@ -220,6 +220,17 @@ AS_HELP_STRING([--with-openssl],[use OpenSSL libra=
ry (default is YES)])
 AS_HELP_STRING([],              [ARG can be prefix for openssl library=
 and headers]),\
 GIT_PARSE_WITH(openssl))
 #
+# Define NO_LIBPCRE if you do not have libpcre installed.  git-grep ca=
nnot use
+# Perl-compatible regexes.
+#
+# Define LIBPCREDIR=3D/foo/bar if your libpcre header and library file=
s are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
+AC_ARG_WITH(libpcre,
+AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes (defa=
ult is YES)])
+AS_HELP_STRING([],           [ARG can be also prefix for libpcre libra=
ry and headers]),
+GIT_PARSE_WITH(libpcre))
+#
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
@@ -435,6 +446,21 @@ AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
 AC_SUBST(NO_OPENSSL)
=20
 #
+# Define NO_LIBPCRE if you do not have libpcre installed.  git-grep ca=
nnot use
+# Perl-compatible regexes.
+#
+
+GIT_STASH_FLAGS($LIBPCREDIR)
+
+AC_CHECK_LIB([pcre], [pcre_version],
+[NO_LIBPCRE=3D],
+[NO_LIBPCRE=3DYesPlease])
+
+GIT_UNSTASH_FLAGS($LIBPCREDIR)
+
+AC_SUBST(NO_LIBPCRE)
+
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull =
and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
--=20
1.7.3.4
