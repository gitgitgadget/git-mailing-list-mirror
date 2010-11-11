From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] nd/setup fixups
Date: Thu, 11 Nov 2010 21:20:41 +0700
Message-ID: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY2i-0008Ud-8M
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0KKOWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:22:19 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54981 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab0KKOWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:22:18 -0500
Received: by pwi9 with SMTP id 9so185637pwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=5xE7rFmImFWfvisX+RgSmMt6UKgeF2VzOJRLYdBlyA0=;
        b=v/Sn3k6URqQaksFNLOVRhg/mAua9JkBgt4eOvcDQUwBNDhSo19r3Wl/d+BAR957rS+
         pEoPRR7mhXUyaBS7FbLgYacFFUUl3rtgPnvr2h3cib4hgsdkAT8ujJUgpSze83UvhIO1
         3BEviTaV4zwLfDsSCDDF3Y4JBLTMtD+RgfPcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=xqMh/3kj345qcFKy0+yIjffDl4M08Y6SVUF1wZhK0HrqSlX3CkvLJzJ1ZEDanDYH3K
         rzrdl/xEerLLZnIOzIVMnW9UMYHsUc9/Fdqb07FLK+Rg0FZYczFME12Ef9jv92vnfsg1
         0vWbmr6/JyzxWPquRgMvydSZO8JIjzIwUEm24=
Received: by 10.142.216.16 with SMTP id o16mr501319wfg.434.1289485338586;
        Thu, 11 Nov 2010 06:22:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id v19sm2427212wfh.0.2010.11.11.06.22.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:22:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:20:55 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161254>

This replaces the last three patches in nd/setup in pu (from clean up
setup_discovered_git_dir to t1020-subdirectory)

Changes are:

 - Retain old behavior of setup_discovered_git_dir() when .git is not
   explicitly set by set_git_dir(), but later on by setup_git_env().
   This helps remove the ugly workaround in set_git_dir() earlier.

 - Include t0001 tests from Jonathan. You'll see I sneak more patches
   in from my old nd/setup from time to time, until I push all of them =
:)

 - set_git_work_tree() now allows multiple calls as long as the new
   worktree and the old one is the same, as Junio suggested.

 - Document update. Turns out not much is needed.

Jonathan Nieder (1):
  t0001: test git init when run via an alias

Michael J Gruber (1):
  t1020-subdirectory: test alias expansion in a subdirectory

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  setup: clean up setup_discovered_git_dir()
  setup: rework setup_explicit_git_dir()
  Remove all logic from get_git_work_tree()
  Revert "Documentation: always respect core.worktree if set"
  git.txt: correct where --work-tree path is relative to

 Documentation/config.txt |   23 ++---
 Documentation/git.txt    |    2 +-
 builtin/init-db.c        |   14 ++-
 cache.h                  |    1 -
 environment.c            |   32 ++----
 setup.c                  |  208 +++++++++++++++++--------------
 t/t0001-init.sh          |   56 +++++++++
 t/t1020-subdirectory.sh  |    8 ++
 t/t1510-repo-setup.sh    |  310 +++++++++++++++++++++++---------------=
--------
 9 files changed, 360 insertions(+), 294 deletions(-)

--=20
1.7.3.2.210.g045198
