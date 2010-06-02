From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 4/7] Makefile: Don't install Gettext .mo files if NO_GETTEXT
Date: Wed,  2 Jun 2010 01:06:01 +0000
Message-ID: <1275440764-26153-5-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPp-0004k8-Tf
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497Ab0FBBGX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:06:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0FBBGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:21 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=J0onK+u6uRvSHJvl8kQr6hFQvPv4jtwFU4qUM0AbYe8=;
        b=sy3d0wdGcVjnx3nLIl5GnsPwhIIZqLQdyXusDLppbWq11stel+ze8zV5NVxlryVr2O
         Wh4H3tcyzSuRFKcpLJZewgrpKMCuPFLhK5bnAfoYUFQOucm1Wf99EaJF9FmituAQmzoP
         CvF/OktlR/iQ+d0Ymaj/x9L9cux5xs4nyioD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FXq/Wu3H2rH24IeiiUBpaNq0gIQMOy1HsUKq2kn+vY1ugW4zaZ71VzQZfnXnnwRene
         tUXl7zg7VsCQa0p9N7T0NRy6EsK4+LFBNa4z73/kBAmmqKvKwwEeJTyilP9R3D5+BxYz
         /iisGcfzCYsAkD+K1jdtiezoZgwvR213rXMuE=
Received: by 10.223.98.19 with SMTP id o19mr7876673fan.80.1275440780651;
        Tue, 01 Jun 2010 18:06:20 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148183>

Change the Makefile not to build/install .mo files as part of the
default target if NO_GETTEXT=3D1 is given.

This was both redundant, and meant that the Perl and Shell programs
would use the Gettext strings, since they don't use the
git_setup_gettext() function in gettext.c, which is compiled to a stub
if NO_GETTEXT=3D1 is set.

Reported-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3f0e305..40eb1a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1891,7 +1891,9 @@ pot:
 POFILES :=3D $(wildcard po/*.po)
 MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
 MODIRS :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/,$(POFILES))
+ifndef NO_GETTEXT
 all:: $(MOFILES)
+endif
 share/locale/%/LC_MESSAGES/git.mo: po/%.po
 	@mkdir -p $(dir $@)
 	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
@@ -2008,9 +2010,11 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sharedir_SQ)/locale'
 	(cd share && tar cf - locale) | \
 		(cd '$(DESTDIR_SQ)$(sharedir_SQ)' && umask 022 && tar xof -)
+endif
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' ins=
tall
--=20
1.7.1.251.gec7f5.dirty
