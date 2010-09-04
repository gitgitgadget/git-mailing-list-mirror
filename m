From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/63] [REDO] Add gettext support to Git
Date: Sat,  4 Sep 2010 22:10:20 +0000
Message-ID: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0wh-00035X-D1
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0IDWKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:10:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37424 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0IDWKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:10:40 -0400
Received: by wwj40 with SMTP id 40so4554637wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=rzcSbYwR2X09WiN35mMlUVAqf9IOqPVe+Wlme0BhBWw=;
        b=TT872uOgruWCHUPlNhynr/2zpFe+qF6TSZzx6+hEisfovCCPBmbu97NQqsMfvP73X0
         hwmjtXBC2IPvQXMBgtmAtFINKI1GbtpMBgBSh85h1OT+KTFfwWzqRii41Arh5RmI9/JB
         GVRgrug8gW0ebEfdE71JHj7P2nCAI90DbMNkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=XYZoppFgO2jxNWEORCsNOZZYch2aD/fEqwXgfTuAzdX5pZCRFJ0FEH9USaMZh4/HpL
         iUy7MXIpyRavzTEgCXgYQv2WVfFwD9NXvdAK1kDTHWV3oC3WYyJnxIkvcG+YEBq0mvjm
         vtzY23FWNsD9C6bS7r64OCvFz5SK/6QoTZ5kY=
Received: by 10.216.150.195 with SMTP id z45mr1514463wej.63.1283638239305;
        Sat, 04 Sep 2010 15:10:39 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.10.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:10:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155368>

The previous nested pull requests were a mess, and I needed to fix
some bugs. So here's a total re-do of the ab/i18n series. Everything
that's already in pu from ab/i18n can be ejected in favor of this.

Most of these 63 patches have been seen here before. So I'll only be
sending the stuff that's changed or interesting along with this
series. To get the full thing go to:

    git://github.com/avar/git.git ab/i18n-all
    http://github.com/avar/git/compare/master...ab/i18n-all
    http://github.com/avar/git/compare/master...ab/i18n-all.patch

The last of which is a patch file suitable for git-am(1).

Since last time I've rebased this on the new upstream master branch,
which now has my ab/test-2 series.

See comments by the patches below for other changes in this
series since last time.

Jan Kr=C3=BCger (1):
  po/de.po: add German translation

Marcin Cie=C5=9Blak (1):
  po/pl.po: add Polish translation

Sam Reed (1):
  po/en_GB.po: add British English Translation

    I minimized this so it now only contains 3 msgid/msgstr pairs,
    instead of containing *all* of them just to translate those three.

    As an aside I really need to patch the upstream gettext tools to
    make this easy. I have to manually edit the file now to do this.

Thomas Rast (1):
  tests: locate i18n lib&data correctly under --valgrind

    The 2e75a8c that's in pu right now solves the merge conflict
    between ab/i18n and ab/test incorrectly. Since ab/test has been
    merged this needs no changes to test-lib.sh at all (GIT_BUILD_DIR
    is now already defined there).

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (59):
  builtin: use builtin.h for all builtin commands

    These changes for builtin.h are now part of this series for
    convenience. But Junio might want to split them up away from the
    ab/i18n topic.

  Add infrastructure for translating Git with gettext

    Updated to solve merge conflicts with the new master. No other
    changes.

  tests: rename test to work around GNU gettext bug
  gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
  Makefile: A variable for options used by xgettext(1) calls
  Makefile: provide a --msgid-bugs-address to xgettext(1)
  Makefile: tell xgettext(1) that our source is in UTF-8
  Makefile: use variables and shorter lines for xgettext
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

    I've rewritten these and all other changes to po/*.po files to not
    have the autogenerated line numbers. So with this new topic these
    *never* apprear in the po/*.po history.

  gettext tests: test message re-encoding under C
  gettext tests: remove old sanity test under NO_GETTEXT
  gettext docs: add po/README file documenting Git's gettext
  gettext tests: add GETTEXT_POISON=3DYesPlease Makefile parameter

  gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON

    Split up from the below. Easier to review this way.

  gettext tests: skip breaking tests under GETTEXT_POISON

    Ejected changes to t7602-merge-octopus-many.sh from this. Those
    tests tested for a plumbing message (see below)

    This is still the part of this series that needs the most
    review. I *think* I got this right, but more eyes are needed on
    it.

  gettextize: git-clone basic messages
  gettextize: git-clone "Cloning into" message
  gettextize: git-add basic messages
  gettextize: git-add refresh_index message
  gettextize: git-branch basic messages
  gettextize: git-branch "remote branch '%s' not found" message
  gettextize: git-branch "git branch -v" messages
  gettextize: git-branch "(no branch)" message
  gettextize: git-checkout: our/their version message
  gettextize: git-checkout basic messages
  gettextize: git-checkout describe_detached_head messages
  gettextize: git-checkout "Switched to a .. branch" message
  gettextize: git-commit basic messages
  gettextize: git-commit formatting messages
  gettextize: git-commit advice messages
  gettextize: git-diff basic messages
  gettextize: git-fetch basic messages
  gettextize: git-fetch formatting messages
  gettextize: git-fetch update_local_ref messages
  gettextize: git-fetch split up "(non-fast-forward)" message
  gettextize: git-grep basic messages
  gettextize: git-log basic messages
  gettextize: git-merge basic messages

    The finish() command ends up writing to the reflog, not only to
    stdout. So I needed drop all these patches:
   =20
        gettextize: git-merge remaining cmd_merge messages
        gettextize: git-merge "Merge made by %s." message
        gettextize: git-merge "In-index merge" message

    Now git-merge only makes the basic output/die messages
    translatable.
   =20
  gettextize: git-mv basic messages
  gettextize: git-mv "bad" messages
  gettextize: git-rm basic messages
  gettextize: git-reset basic messages
  gettextize: git-reset reset_type_names messages
  gettextize: git-tag basic messages
  gettextize: git-tag tag_template message
  gettextize: git-push basic messages
  gettextize: git-status basic messages
  gettextize: git-status shortstatus messages

 .gitignore                          |    2 +
 INSTALL                             |   12 +
 Makefile                            |   92 ++-
 builtin.h                           |    1 +
 builtin/add.c                       |   46 +-
 builtin/branch.c                    |   69 +-
 builtin/checkout.c                  |   93 +-
 builtin/clone.c                     |   61 +-
 builtin/commit.c                    |  156 ++--
 builtin/diff.c                      |   20 +-
 builtin/fetch-pack.c                |    2 +-
 builtin/fetch.c                     |   82 +-
 builtin/grep.c                      |   34 +-
 builtin/hash-object.c               |    2 +-
 builtin/index-pack.c                |    2 +-
 builtin/init-db.c                   |   56 +-
 builtin/log.c                       |   68 +-
 builtin/merge-index.c               |    2 +-
 builtin/merge-recursive.c           |    2 +-
 builtin/merge-tree.c                |    2 +-
 builtin/merge.c                     |  122 ++--
 builtin/mktag.c                     |    2 +-
 builtin/mv.c                        |   32 +-
 builtin/pack-redundant.c            |    2 +-
 builtin/pack-refs.c                 |    2 +-
 builtin/patch-id.c                  |    2 +-
 builtin/push.c                      |   42 +-
 builtin/receive-pack.c              |    2 +-
 builtin/remote.c                    |    3 +-
 builtin/reset.c                     |   44 +-
 builtin/rm.c                        |   22 +-
 builtin/send-pack.c                 |    2 +-
 builtin/tag.c                       |   66 +-
 builtin/unpack-file.c               |    2 +-
 builtin/var.c                       |    2 +-
 config.mak.in                       |    2 +
 configure.ac                        |   12 +
 daemon.c                            |    3 +
 fast-import.c                       |    3 +
 gettext.c                           |   27 +
 gettext.h                           |   22 +
 git-sh-i18n.sh                      |   71 ++
 git.c                               |    3 +
 http-backend.c                      |    3 +
 http-fetch.c                        |    3 +
 http-push.c                         |    3 +
 imap-send.c                         |    3 +
 perl/Git/I18N.pm                    |   91 ++
 perl/Makefile                       |    3 +-
 perl/Makefile.PL                    |   14 +-
 po/.gitignore                       |    1 +
 po/README                           |   68 ++
 po/de.po                            | 1888 +++++++++++++++++++++++++++=
++++++++
 po/en_GB.po                         |   22 +
 po/is.po                            |  152 +++
 po/pl.po                            |  153 +++
 shell.c                             |    3 +
 show-index.c                        |    3 +
 t/lib-gettext.sh                    |   68 ++
 t/lib-httpd.sh                      |    2 +-
 t/t0001-init.sh                     |    2 +-
 t/t0200-gettext-basic.sh            |  108 ++
 t/t0200/test.c                      |   23 +
 t/t0200/test.perl                   |   14 +
 t/t0200/test.sh                     |   14 +
 t/t0201-gettext-fallbacks.sh        |   49 +
 t/t0202-gettext-perl.sh             |   27 +
 t/t0202/test.pl                     |  109 ++
 t/t0203-gettext-setlocale-sanity.sh |   26 +
 t/t0204-gettext-reencode-sanity.sh  |   78 ++
 t/t1200-tutorial.sh                 |    4 +-
 t/t2200-add-update.sh               |    2 +-
 t/t2204-add-ignored.sh              |    8 +-
 t/t3030-merge-recursive.sh          |    2 +-
 t/t3200-branch.sh                   |    2 +-
 t/t3203-branch-output.sh            |    2 +-
 t/t3700-add.sh                      |    4 +-
 t/t4001-diff-rename.sh              |    4 +-
 t/t4014-format-patch.sh             |    2 +-
 t/t5541-http-push.sh                |    2 +-
 t/t5601-clone.sh                    |    2 +-
 t/t6040-tracking-info.sh            |    2 +-
 t/t7004-tag.sh                      |    6 +-
 t/t7060-wtstatus.sh                 |    2 +-
 t/t7102-reset.sh                    |    2 +-
 t/t7110-reset-merge.sh              |    6 +-
 t/t7201-co.sh                       |   10 +-
 t/t7500-commit.sh                   |    9 +-
 t/t7501-commit.sh                   |   14 +-
 t/t7502-commit.sh                   |   46 +-
 t/t7506-status-submodule.sh         |   28 +-
 t/t7508-status.sh                   |   98 +-
 t/t7600-merge.sh                    |    2 +-
 t/t7811-grep-open.sh                |    2 +-
 t/test-lib.sh                       |    3 +
 upload-pack.c                       |    3 +
 wt-status.c                         |  116 ++--
 97 files changed, 3901 insertions(+), 706 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/README
 create mode 100644 po/de.po
 create mode 100644 po/en_GB.po
 create mode 100644 po/is.po
 create mode 100644 po/pl.po
 create mode 100644 t/lib-gettext.sh
 create mode 100755 t/t0200-gettext-basic.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0201-gettext-fallbacks.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
 create mode 100755 t/t0203-gettext-setlocale-sanity.sh
 create mode 100755 t/t0204-gettext-reencode-sanity.sh

--=20
1.7.2.3.313.gcd15
