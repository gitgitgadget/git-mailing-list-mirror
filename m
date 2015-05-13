From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.1
Date: Wed, 13 May 2015 15:24:00 -0700
Message-ID: <xmqqegmk9kvz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu May 14 00:24:13 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Ysf4W-0007i5-N5
	for glk-linux-kernel-3@plane.gmane.org; Thu, 14 May 2015 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbbEMWYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 13 May 2015 18:24:07 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35134 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965062AbbEMWYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 May 2015 18:24:03 -0400
Received: by igbyr2 with SMTP id yr2so152130317igb.0;
        Wed, 13 May 2015 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=wY8CRlslZOckL+HQD+RfWJFnZtRxr1aWgDiqpw8dJuo=;
        b=V7MibRuPLs+CsHa9RLuD1859kwx443+oNrHon7dI7weBo+rxrnXkaOZMmxU935uGof
         FYa3xncTTl74wRFP5sncROPikjGc3RgjxXcZo+qd6zW0fEJ2o1b9GDoOJXvc0ywvEoT0
         buQjdzOiwlEyhztvxK2ziCEfnFan1gWYFjvquKvpuGPNDUT8UsGQNek6MkYMiaaEJzjl
         K0pK28/ZSnZ8t1v++6VBC3nN8PTnDlrH/m48PQTn9/8tLoqFm+4tPxf3ssiSEVOKyPe9
         zpn2jD+n1Tb+8cmM4FVWZot99HIDajujSgrTZwjGWI52trSYIsJzRmBC5ElbLXlDN2/S
         iwOw==
X-Received: by 10.42.63.80 with SMTP id b16mr11026825ici.64.1431555842298;
        Wed, 13 May 2015 15:24:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id lq3sm4552450igb.3.2015.05.13.15.24.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 15:24:01 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269012>

The first maintenance release Git v2.4.1 is now available at the
usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4
----------------

 * The usual "git diff" when seeing a file turning into a directory
   showed a patchset to remove the file and create all files in the
   directory, but "git diff --no-index" simply refused to work.  Also,
   when asked to compare a file and a directory, imitate POSIX "diff"
   and compare the file with the file with the same name in the
   directory, instead of refusing to run.

 * The default $HOME/.gitconfig file created upon "git config --global"
   that edits it had incorrectly spelled user.name and user.email
   entries in it.

 * "git commit --date=3Dnow" or anything that relies on approxidate los=
t
   the daylight-saving-time offset.

 * "git cat-file bl $blob" failed to barf even though there is no
   object type that is "bl".

 * Teach the codepaths that read .gitignore and .gitattributes files
   that these files encoded in UTF-8 may have UTF-8 BOM marker at the
   beginning; this makes it in line with what we do for configuration
   files already.

 * Access to objects in repositories that borrow from another one on a
   slow NFS server unnecessarily got more expensive due to recent code
   becoming more cautious in a naive way not to lose objects to pruning=
=2E

 * We avoid setting core.worktree when the repository location is the
   ".git" directory directly at the top level of the working tree, but
   the code misdetected the case in which the working tree is at the
   root level of the filesystem (which arguably is a silly thing to
   do, but still valid).

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.0 are as follows:

Carlos Mart=C3=ADn Nieto (1):
      dir: allow a BOM at the beginning of exclude files

Elia Pinto (1):
      test-lib-functions.sh: fix the second argument to some helper fun=
ctions

Jeff King (5):
      init: don't set core.worktree when initializing /.git
      type_from_string_gently: make sure length matches
      reachable: only mark local objects as recent
      sha1_file: freshen pack objects before loose
      sha1_file: only freshen packs once per run

Junio C Hamano (10):
      diff-no-index: DWIM "diff D F" into "diff D/F F"
      diff-no-index: align D/F handling with that of normal Git
      parse_date_basic(): return early when given a bogus timestamp
      parse_date_basic(): let the system handle DST conversion
      add_excludes_from_file: clarify the bom skipping logic
      utf8-bom: introduce skip_utf8_bom() helper
      config: use utf8_bom[] from utf.[ch] in git_parse_source()
      attr: skip UTF8 BOM at the beginning of the input file
      Git 2.3.8
      Git 2.4.1

Matthieu Moy (2):
      Documentation: change -L:<regex> to -L:<funcname>
      log -L: improve error message on malformed argument

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      t1509: update prepare script to be able to run t1509 in chroot ag=
ain

Ossi Herrala (1):
      config: fix settings in default_user_config template

Stefan Beller (2):
      line-log.c: fix a memleak
      pack-bitmap.c: fix a memleak
