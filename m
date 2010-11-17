From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch for AIX system
Date: Wed, 17 Nov 2010 09:51:25 -0800
Message-ID: <7vr5ejg7oi.fsf@alter.siamese.dyndns.org>
References: <4CE38472.8070206@Nemec-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Norbert Nemec <Norbert@Nemec-online.de>
X-From: git-owner@vger.kernel.org Wed Nov 17 18:51:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PImAW-00052M-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 18:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934996Ab0KQRvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 12:51:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0KQRve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 12:51:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 160E13C94;
	Wed, 17 Nov 2010 12:51:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Y2uuzkqhK9s0pxEOJcb0EaZEQsA=; b=M7JtCRACEoIchY1+Wbh+K2P
	CyIOjuD69KXmrN0ozn/KROcTl3yf1kV6khofrs3WX+qXsD/inucLhA6eFz0G9EV2
	b9vhQaLZGsPqqktC3T+4W2dYNurFuMMVKbZnVPqYBQ5KSbWfnJT75EmOGW/n9DRA
	s//EPkh/PKzHhvqBIiNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dzmNBP4zjlusgBp8Q/WfS8zpAKox4GjlNbchG4rH5FaIKq8q9
	/5DXZ5o8Wblc1a6OqcUs01PDz6G7072Csf8l4ajrmTSeBKrQ9U4AeVlXZ4bND7i2
	hCphT4NUm4vxq6FG9SGVtIDCVRjJu7kbqphrKsdECU+iBrFv4nokAH0vk8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA22C3C93;
	Wed, 17 Nov 2010 12:51:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2D2D3C91; Wed, 17 Nov 2010
 12:51:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 549CAE00-F273-11DF-8F3B-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161627>

Norbert Nemec <Norbert@Nemec-online.de> writes:

> Find attached a small patch to make git install cleanly on an AIX system

A few comments, some from Documentation/SubmittingPatches.

> From def4428ad827d1e6550634a2fe1f035c1b148426 Mon Sep 17 00:00:00 2001
> From: Norbert Nemec <Norbert@Nemec-online.de>
> Date: Wed, 17 Nov 2010 08:25:44 +0100
> Subject: [PATCH] Fix for installation on AIX

Please don't do this; instead, make sure that From/Date/Subject of your
e-mail usable as the metainfo for the resulting commit (in this case only
the Subject needs a change) and drop these lines, i.e. make the patch
inline, not an attachment.

Also make the subject more specific, to make it clear _what_ you fixed;
phrase it like "Makefile: On AIX, bsdinstall does not understand -d" or
something, perhaps.

> The BSD style 'install' command is call 'installbsd' and does not support the -d option.
> Therefore '$(INSTALL) -d' is replaced by a new variable '$(INSTALLDIR)' in all Makefiles
> which can be changed independently of $(INSTALL).

These lines are tad too long; please wrap at around 66-72 cols.

Missing sign-off.

> ---
>  Documentation/Makefile |   10 +++++-----
>  Makefile               |    7 +++++--
>  git-gui/Makefile       |    4 ++--
>  gitk-git/Makefile      |    2 +-
>  gitweb/Makefile        |    4 ++--
>  templates/Makefile     |    2 +-
>  6 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index e117bc4..c2db8db 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> ...
>  install-pdf: pdf
> -	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
> +	$(INSTALLDIR) -m 755 $(DESTDIR)$(pdfdir)
>  	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
>  
>  install-html: html

In the main Makefile, we have this line:

	export DIFF TAR INSTALL DESTDIR SHELL_PATH

so that they can be used in "$(MAKE) -C Documentaiton install-frotz"
invocations in subdirectories, but I do not see an addition of export in
your patch, and you do not define INSTALLDIR in Documentation/Makefile
either.  I wonder how this could possibly work...

> diff --git a/Makefile b/Makefile
> index 1f1ce04..2664d7c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -953,6 +954,8 @@ ifeq ($(uname_S),AIX)
>  	NO_MKSTEMPS = YesPlease
>  	NO_STRLCPY = YesPlease
>  	NO_NSEC = YesPlease
> +	INSTALL = installbsd
> +	INSTALLDIR = mkdir -p
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	INTERNAL_QSORT = UnfortunatelyYes
>  	NEEDS_LIBICONV=YesPlease

I'd defer this section to AIX experts; I've always assumed that people
on non-gnu platforms used ginstall, but perhaps AIX doesn't have one?

Other changes looked mostly OK, but I am still wondering how your
INSTALLDIR is passed down to submakes.

 ... spends quality 30-minutes digging ...

No, your patch does not work.  Have you even tested it?

The attached patch on top of yours makes things working, it seems.

Points to note:

 - People may have already used "make INSTALL=ginstall" and been expecting
   it to work.  Defining "INSTALLDIR = install -d" as the default will
   break them (see how I defined it in the attached);

 - "cd gitweb && make" is supposed to work, so you would need fallback
   definitions in Makefiles in subdirectories; and

 - When coming from the toplevel make, submakes do want the INSTALLDIR
   definition passed from it (see how "export" is used).

Thanks.

 Documentation/Makefile |    3 ++-
 Makefile               |    4 ++--
 git-gui/Makefile       |    3 +++
 gitk-git/Makefile      |    1 +
 gitweb/Makefile        |    1 +
 templates/Makefile     |    1 +
 6 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c2db8db..5c8aacc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -44,7 +44,8 @@ ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
-INSTALL?=install
+INSTALL ?= install
+INSTALLDIR ?= $(INSTALL) -d
 RM ?= rm -f
 DOC_REF = origin/man
 HTML_REF = origin/html
diff --git a/Makefile b/Makefile
index 2664d7c..b91de40 100644
--- a/Makefile
+++ b/Makefile
@@ -308,7 +308,7 @@ DIFF = diff
 TAR = tar
 FIND = find
 INSTALL = install
-INSTALLDIR = install -d
+INSTALLDIR = $(INSTALL) -d
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
@@ -1573,7 +1573,7 @@ endif
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
-export DIFF TAR INSTALL DESTDIR SHELL_PATH
+export DIFF TAR INSTALL INSTALLDIR DESTDIR SHELL_PATH
 
 
 ### Build rules
diff --git a/git-gui/Makefile b/git-gui/Makefile
index b96b3df..be8bd2d 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -44,6 +44,9 @@ endif
 ifndef INSTALL
 	INSTALL = install
 endif
+ifndef INSTALLDIR
+	INSTALLDIR = $(INSTALL) -d
+endif
 
 RM_RF     ?= rm -rf
 RMDIR     ?= rmdir
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index b838d87..473c500 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -11,6 +11,7 @@ msgsdir_SQ  = $(subst ','\'',$(msgsdir))
 TCL_PATH ?= tclsh
 TCLTK_PATH ?= wish
 INSTALL ?= install
+INSTALLDIR ?= $(INSTALL) -d
 RM ?= rm -f
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 3f1ac82..ee6dcc1 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -16,6 +16,7 @@ gitwebdir ?= /var/www/cgi-bin
 
 RM ?= rm -f
 INSTALL ?= install
+INSTALLDIR ?= $(INSTALL) -d
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
diff --git a/templates/Makefile b/templates/Makefile
index 3808b04..953037c 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -5,6 +5,7 @@ ifndef V
 endif
 
 INSTALL ?= install
+INSTALLDIR ?= $(INSTALL) -d
 TAR ?= tar
 RM ?= rm -f
 prefix ?= $(HOME)
