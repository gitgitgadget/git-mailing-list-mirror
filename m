From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sat, 21 Jan 2012 20:36:45 +0100
Message-ID: <201201212036.46681.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RogkC-0003Zj-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 20:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab2AUTgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jan 2012 14:36:53 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47854 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2AUTgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2012 14:36:50 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3C87D1B05048C
	for <git@vger.kernel.org>; Sat, 21 Jan 2012 20:36:49 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lk8Ow-1SLHPG37Ig-00bek7; Sat, 21 Jan 2012 20:36:48 +0100
X-Provags-ID: V02:K0:vuyszvoZTEUArm34kWUnmY1tH8+0tGmwvqM86dQjGf2
 xRIyM5lvcwg0OPFfycxXz8NAEPqHA6iJbRhyUsIYQCuzHksa+p
 7lK2JPzCYdNqnQa1KcDFFgFM0rmHGwCvhxMdkFjzP1jYymWYew
 noJEK7SQ7AYBTqGwTHKyAKyVjZGj8W6NLIMZGnuqd4izv9m8iS
 njrUPqCY/rn5C86Diw2CQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188929>

Changes since V3:

- Be much more defensive:
  Do not set core.precomposedunicode=3Dtrue, even if the file system
  probing indicates that it could be true.
  (but we don't say that it should be true).
  This is to keep better backward compatibility within git.
  The user needs to manually enable the precomposition.
  However, the .git/config indicates that we have a new
  configuration variable, and will encourage people to use it.

- compat/precomposed_utf8.c:=20
    - re-order #includes
    - Added some empty lines to make code easier to read.=20
    - Small fixes (xmalloc, errno handling)

- Make function names more consistent by renaming these functions:
    argv_precompose() -> precompose_argv()
    str_precompose() -> precompose_str()
- Improved the commit message


Torsten B=C3=B6gershausen (1):
  git on Mac OS and precomposed unicode

 Documentation/config.txt     |    9 ++
 Makefile                     |    3 +
 builtin/init-db.c            |    2 +
 compat/precomposed_utf8.c    |  208 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/precomposed_utf8.h    |   30 ++++++
 git-compat-util.h            |    9 ++
 git.c                        |    1 +
 t/t3910-mac-os-precompose.sh |  117 +++++++++++++++++++++++
 8 files changed, 379 insertions(+), 0 deletions(-)
 create mode 100644 compat/precomposed_utf8.c
 create mode 100644 compat/precomposed_utf8.h
 create mode 100755 t/t3910-mac-os-precompose.sh

--=20
1.7.8.rc0.43.gb49a8
