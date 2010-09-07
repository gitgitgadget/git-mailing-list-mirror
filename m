From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/20] *** SUBJECT HERE ***
Date: Tue,  7 Sep 2010 16:43:03 +0000
Message-ID: <1283877803-17757-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:45:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1Io-0001M6-QV
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792Ab0IGQpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:45:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50451 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab0IGQpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:45:40 -0400
Received: by wyf22 with SMTP id 22so4439126wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=m0YlDMr4VZJt6hFAEw3Yz1usbNpNVkRQ7nc4lsJMTJo=;
        b=Ssx4OOel8c9IF3YmjwXgO89/cbTPB9AFOtInUuPrJNgcE65wCPJUCGQisa4uSgbYB7
         y3jPb+3T0KWcoYxFt5gI8Y+pgnGImUC8Q121axWb6Z8v/JsD8RCBI3ps7MFCm9P0WhDH
         Y7HIagiXyhmHt5Xrso5GV7AB1/4fnrzanrjWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=r1SxD8Fmz+rYPBV9SWDSLhjleKAFvfcTsaZK8urFKzf3D8E0mmk+i+gqLI1vhV7gbB
         3D9CG4msCkC677iUtb2uebaYLLRHU/9F+81Xz0/hV8cTEYnFy8EirkcVZBCHqctPh5HQ
         bFVTVnvBzvGPDCCpQOjSTA08/BGn0GWI2sCnM=
Received: by 10.227.141.141 with SMTP id m13mr53898wbu.152.1283877810773;
        Tue, 07 Sep 2010 09:43:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id i14sm5889329wbe.18.2010.09.07.09.43.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:43:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155708>

This series continues work where the already pulled ab/i18n series
(now merged to pu) left off.

It can also be pulled from:

    git://github.com/avar/git.git ab/i18n-continue
    http://github.com/avar/git/compare/ab/i18n-in-git-2010-09-07...ab/i=
18n-continue
    http://github.com/avar/git/compare/ab/i18n-in-git-2010-09-07...ab/i=
18n-continue.patch

It includes the first translation of a mainporcelain command written
in shellscript (git-am). Comments on invividual patches below.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (20):
  gettextize: git-clean clean.requireForce braces
  gettextize: git-clone "Cloning into" message braces

Under GCC this warns under -Wall and will presumably break Junio's
-Werror build. I didn't notice because I use clang which (IMO rightly)
doesn't complain about this.

  po/de.po: make the German translation msgfmt --check clean

We'll see what ze Germans come up with translation wise, but meanwhile
this un-breaks the translation already in ab/i18n.

  Makefile: add GNU_GETTEXT, set when we expect GNU gettext
  Makefile: MSGFMT=3D"msgfmt --check" under GNU_GETTEXT

And these two patches make sure that a translation will never break
like that again. Since msgfmt --check is a GNU-ism I needed to add
support for GNU_GETTEXT=3DYesPlease in the Makefile.

Maybe a check for this could be added to the configure.ac script, but
I couldn't find a way to do so, and for the reasons explained in the
patches I don't think it was worth my time.

  Revert "gettextize: git-revert mark the "me" variable for
    translation"

Revert this as discussion on-list. Alternatively the "gettextize:
git-revert mark the "me" variable for translation" patch could be
ejected from the existing ab/i18n series.

  gettextize: git-revert "Your local changes" message
  gettextize: git-revert literal "me" messages

Do The Right Thing when translating the "me" messsages.

  gettext: add GETTEXT_POISON support for shell scripts
  gettext: add GETTEXT_POISON tests for shell scripts

We need poison for .sh too to ensure sanity.

  gettextize: git-am add git-sh-i18n
  gettextize: git-am one-line gettext $msg; echo
  gettextize: git-am multi-line getttext $msg; echo
  gettextize: git-am eval_gettext messages
  gettextize: git-am die messages
  gettextize: git-am cannot_fallback messages

Note: Isn't --check clean because the existing code indented with
spaces.

  gettextize: git-am clean_abort messages
  gettextize: git-am "Apply?" message
  gettextize: git-am core say messages
  gettextize: git-am printf(1) message to eval_gettext

All these git-am patches are split up like this to make it easier to
review them, and to demonstrate the different sort of messages we'll
have to translate in the shell scripts.

I won't sent commits quite so granular in the future (unless
requested).

 Makefile                     |   16 +++++++++
 builtin/clean.c              |    3 +-
 builtin/clone.c              |    3 +-
 builtin/revert.c             |   32 +++++++++++------
 git-am.sh                    |   68 +++++++++++++++++++---------------=
--
 git-sh-i18n.sh               |   77 +++++++++++++++++++++++++---------=
-------
 po/de.po                     |   11 +++---
 t/t0201-gettext-fallbacks.sh |   12 +++---
 t/t0201-gettext-poison.sh    |   36 +++++++++++++++++++
 t/t4150-am.sh                |    4 ++-
 t/t4151-am-abort.sh          |    2 +-
 t/test-lib.sh                |    9 ++++-
 12 files changed, 184 insertions(+), 89 deletions(-)
 create mode 100755 t/t0201-gettext-poison.sh

--=20
1.7.2.3.313.gcd15
