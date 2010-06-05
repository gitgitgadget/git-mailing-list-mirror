From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v7 0/2] Add infrastructure for translating Git with gettext
Date: Sat,  5 Jun 2010 02:13:53 +0000
Message-ID: <1275704035-6552-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 04:14:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKity-0001K7-N0
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 04:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab0FECOJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 22:14:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43793 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab0FECOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 22:14:07 -0400
Received: by bwz11 with SMTP id 11so471609bwz.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 19:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=d4Hc8KDFBfJX/VfJFxRbOQ5Z2oybory+rYl6e72nwl4=;
        b=M34sduCVGBKvOrG4AHtRFgB7U2Uu1xa9C8Y0BRwZ34yRVFZeaSwEN0oUaWMe0NqDRS
         sXUYmdZCfVTc6igtyYleavE5BLO01HOFoafyoThbIFKazzFXt2Fi9d9tCg7LpAZwcw41
         uf0N1+MJrHVhnEgsstPBsH/kWV5LacKy12qsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=gydnMfFARPGSTLTMM3tEN+5ZrKmhjukfGa2ZHhKM6CAsMh6aMBWr+PcnQzY7Ckv7cY
         up5i9Qzw6DQmC43PNfmMFz+lcrguXPEoDzv3aEQ8c9rCAjUz7yDdczGJhNdfYqKzLxy5
         IdXXt9XA8zLojJs6njy8nAKOYP123RVKuRChY=
Received: by 10.204.83.18 with SMTP id d18mr4591541bkl.131.1275704044079;
        Fri, 04 Jun 2010 19:14:04 -0700 (PDT)
Received: from aoeu.localdomain (pD9537C21.dip.t-dialin.net [217.83.124.33])
        by mx.google.com with ESMTPS id v2sm7779342bkz.13.2010.06.04.19.14.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 19:14:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148446>

This is version 7, and hopefully the final version, of the patch
series to make Git optionally translatable with GNU gettext.

Changes since version 6:

   * Document the NO_GETTEXT and NEEDS_LIBINTL parameters in the
     Makefile.

   * non-GNU need -lintl during linking to use gettext. Supply it
     everywhere where we don't expect glibc, i.e. Linux, Hurd and
     GNU/kFreeBSD. I've described how I did the Makefile change in
     "[PATCH RFC] gettext: Support building on non-GNU with -lintl".

   * Skip some tests when Git is built with NO_GETTEXT=3DYesPlease, and
     add a new one to test that it really wasn't compiled as the user
     requested.

Here's the diffstat since version 6:

     Makefile           |   27 +++++++++++++++++++++++++--
     t/t0200-gettext.sh |   48 +++++++++++++++++++++++++++++++---------=
--------
     t/test-lib.sh      |    1 +
     3 files changed, 57 insertions(+), 19 deletions(-)

That's it. I've tested this on FreeBSD, Debian testing and
Ubuntu. Both with and without building gettext support, with and
without libintl-perl, and with and without the Icelandic locale on the
system (which is used for some tests).

Here's the script I used to test it. I'd appreciate test reports from
more platforms:

    curl http://github.com/avar/test-git-gettext/raw/master/test-git-ge=
ttext.sh | sh

If it all works I'll submit a non-RFC.
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                   |    2 +
 INSTALL                      |    8 ++
 Makefile                     |   67 ++++++++++++++++++-
 config.mak.in                |    1 +
 configure.ac                 |    6 ++
 gettext.c                    |   25 +++++++
 gettext.h                    |   13 ++++
 git-pull.sh                  |   16 +++--
 git-send-email.perl          |    3 +-
 git-sh-i18n.sh               |   47 +++++++++++++
 git.c                        |    3 +
 perl/Git/I18N.pm             |   91 +++++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 ++++-
 po/.gitignore                |    1 +
 po/is.po                     |   69 +++++++++++++++++++
 t/t0200-gettext.sh           |  150 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   10 +++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   42 ++++++++++++
 t/t0202-gettext-perl.sh      |   20 ++++++
 t/t0202/test.pl              |  104 +++++++++++++++++++++++++++++
 t/test-lib.sh                |    2 +
 wt-status.c                  |  107 +++++++++++++++---------------
 25 files changed, 767 insertions(+), 65 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0201-gettext-fallbacks.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
