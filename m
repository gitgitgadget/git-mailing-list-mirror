From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Mon, 30 Aug 2010 21:28:06 +0000
Message-ID: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:29:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBuR-0008Ah-NW
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab0H3V2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:28:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab0H3V2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:28:34 -0400
Received: by wyb35 with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=yZYsAItqTzKjjFTGDes5zDoroDTiWv1e+KyS36GRKDQ=;
        b=PCbf9GjhDfHmXttWy3BpoU/PI3LIeVRTKmqj2NfqCBAXtGIlmEqyuxb0I6psYIDMcK
         ye20Zj6a50SgAJt9t4R+ddHj/RkG56mh9DnUqcT84OSr8DkVkLE//W8+rW2XBdvwfF2n
         08Lxt+WoEbWXH/zL+G9D4Vsw6LfBj9CWS7oZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ApCvLQJwfBZV2+5EwMJw36PoBuiWp41c2XzaVvoL/eJnSDQ6ZTITLd+ZXoUxBar2FG
         quK/Q6uQ0YFnKm152NmYUhTMmCL0jPh66DL18xKG9tfhcYvW4gEKz3b+zrFFozaQ2u5d
         B46d8SB3H5vvxGHsJOgzDsKbLpeL/V4/oyiqI=
Received: by 10.227.127.149 with SMTP id g21mr5198715wbs.218.1283203712981;
        Mon, 30 Aug 2010 14:28:32 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154852>

Now that Git has the infrastructure for translation in next I'm going
to start submitting patches to make the main porcelain translatable.

This series starts that work, and fixes and also fixes up some of the
infrastructure (like the bug discussed in "Odd encoding issue with
UTF-8 + gettext yields ? on non-ASCII"), and adds tests to make sure
it's all working.

With it applied git-init is the one and only utility of the porcelain
that's translatable. The series includes a translation of it into
Icelandic and Polish.

I think it's ready to be applied. I tested it on Solaris, FreeBSD and
Debian. But there's almost definitely something I'm missing in a
series this big, so it's an RFC.

Marcin Cie=C5=9Blak (1):
  po/pl.po: add Polish translation

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (16):
  Makefile: A variable for options used by xgettext(1) calls
  Makefile: provide a --msgid-bugs-address to xgettext(1)
  Makefile: tell xgettext(1) that our source is in UTF-8
  builtin.h: Include gettext.h
  gettext: make the simple parts of git-init localizable
  gettext: localize the main git-init message
  gettext.c: work around us not using setlocale(LC_CTYPE, "")
  gettext tests: test if $VERSION exists before using it
  gettext tests: update test/is.po to match t/t0200/test.c
  gettext tests: add detection for is_IS.ISO-8859-1 locale
  gettext tests: test message re-encoding under Shell
  gettext tests: test re-encoding with a UTF-8 msgid under Shell
  gettext tests: mark a test message as not needing translation
  po/is.po: msgmerge and add Language: header
  po/is.po: add Icelandic translation
  gettext tests: test message re-encoding under C

 Makefile                           |    7 +-
 builtin.h                          |    1 +
 builtin/init-db.c                  |   56 ++++++-----
 gettext.c                          |    6 +
 po/is.po                           |  153 ++++++++++++++++++++++++++++=
--
 po/pl.po                           |  187 ++++++++++++++++++++++++++++=
++++++++
 t/lib-gettext.sh                   |   26 +++++-
 t/t0200-gettext-basic.sh           |    4 +-
 t/t0200/test.c                     |   10 ++
 t/t0202/test.pl                    |    4 +-
 t/t0204-gettext-reencode-sanity.sh |   78 +++++++++++++++
 11 files changed, 490 insertions(+), 42 deletions(-)
 create mode 100644 po/pl.po
 create mode 100755 t/t0204-gettext-reencode-sanity.sh

--=20
1.7.2.2.536.g3f548
