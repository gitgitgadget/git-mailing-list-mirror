From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 14:43:20 -0800
Message-ID: <7vtxpxdldj.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <7vy5f9dmrt.fsf@alter.siamese.dyndns.org>
 <20130131222817.GP1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12rC-0003WJ-Rg
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063Ab3AaWnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:43:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969Ab3AaWnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:43:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCCFBA4E;
	Thu, 31 Jan 2013 17:43:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMRJ2BBVpiPApeeVo/CsVjIhtJo=; b=huqF/m
	0KeTccc129NEMwjMDJ08/1LEWtkWcVoGlZ1Ucjtd3zLq8YwS+MBbSANhH3bSdbuH
	jS8rqGcvu2nh59jw9u0wAb0ZtwqLlbrsqlVNSeIwKGJNNMG23tJ9Zi2regszEVM6
	yUjLP3yqNDW7NBaynyGlgViolwcP4tuY8GLkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z2jRY4d5hEO4jTns6EtVggJ2g0nFXVVD
	i31Y6XQAqPspr/gIQlPHrvz/dekCRBwl+DTjp3QVNDxEWuGToAdQtORWXfJk5Xbh
	Od1n7aL33ODAXV5M192rbg93MjnjUtxvG9UGCRi8iG2hQBUEXio//WMcFU8mqrHc
	No67UrQMQkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32483BA49;
	Thu, 31 Jan 2013 17:43:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 169C5BA42; Thu, 31 Jan 2013
 17:43:22 -0500 (EST)
In-Reply-To: <20130131222817.GP1342@serenity.lan> (John Keeping's message of
 "Thu, 31 Jan 2013 22:28:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DB3C3C6-6BF7-11E2-B95E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215182>

John Keeping <john@keeping.me.uk> writes:

> Yes.  Should I change it to "git-remote-helpers.html.in" and then copy
> it into place?  That seems like the simplest answer and means that
> "*.html" will continue to refer only to generated files.

I'd like to see if we can have a way to keep its look as the default
css gets updated without maintainance burden.

How about using AsciiDoc instead of "cp", perhaps like this on top
of your patch?

 Documentation/.gitignore              |  1 -
 Documentation/Makefile                |  9 +++++-
 Documentation/git-remote-helpers.txto | 26 +++++++++++++++++
 Documentation/git-remote-helpers.html | 55 -----------------------------------
 4 files changed, 34 insertions(+), 57 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 4685378..d62aebd 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,6 +1,5 @@
 *.xml
 *.html
-!git-remote-helpers.html
 *.[1-8]
 *.made
 *.texi
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 13e0098..fa2f9f9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -13,7 +13,8 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
-DOC_HTML=$(MAN_HTML) git-remote-helpers.html
+OBSOLETE_HTML = git-remote-helpers.html
+DOC_HTML=$(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES = howto-index
 ARTICLES += everyday
@@ -261,6 +262,12 @@ $(MAN_HTML): %.html : %.txt asciidoc.conf
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
+$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
+		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	mv $@+ $@
+
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
diff --git a/Documentation/git-remote-helpers.txto b/Documentation/git-remote-helpers.txto
new file mode 100644
index 0000000..a966013
--- /dev/null
+++ b/Documentation/git-remote-helpers.txto
@@ -0,0 +1,25 @@
+git-remote-helpers(1)
+=====================
+
+NAME
+----
+git-remote-helpers - obsoleted page
+
+SYNOPSIS
+--------
+See linkgit:gitremote-helpers[1].
+
+DESCRIPTION
+-----------
+This document has been moved to linkgit:gitremote-helpers[1].
+
+Please let the owners of the referring site know so that they can update the
+link you clicked to get here.
+
+SEE ALSO
+--------
+linkgit:gitremote-helpers[1]
+
+GIT
+---
+No longer a part of the linkgit:git[1] suite
diff --git a/Documentation/git-remote-helpers.html b/Documentation/git-remote-helpers.html
deleted file mode 100644
index 0c5ec27..0000000
--- a/Documentation/git-remote-helpers.html
+++ /dev/null
@@ -1,55 +0,0 @@
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
-    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
-<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
-<head>
-<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
-<title>git-remote-helpers(1) - Document Moved</title>
-<style type="text/css">
-/* Cut-down styles from asciidoc.css. */
-
-/* Default font. */
-body {
-  font-family: Georgia,serif;
-}
-
-/* Title font. */
-h1 {
-  font-family: Arial,Helvetica,sans-serif;
-}
-
-body {
-  margin: 1em 5% 1em 5%;
-}
-
-a {
-  color: blue;
-  text-decoration: underline;
-}
-a:visited {
-  color: fuchsia;
-}
-
-h1, h2, h3, h4, h5, h6 {
-  color: #527bbd;
-  margin-top: 1.2em;
-  margin-bottom: 0.5em;
-  line-height: 1.3;
-}
-
-</style>
-</head>
-<body class="manpage">
-<div id="header">
-<h1>
-Document Moved
-</h1>
-</div>
-
-<p>This document is now called <a
-href="gitremote-helpers.html">gitremote-helpers</a>.</p>
-
-<p>Please let the owners of the referring site know so that they can update the
-link you clicked to get here.</p>
-
-</body>
-</html>
