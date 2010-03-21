From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/19] nd/setup part two, second round
Date: Sun, 21 Mar 2010 17:30:27 +0700
Message-ID: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIUM-00032k-R1
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab0CUKea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:34:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54002 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0CUKe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:34:29 -0400
Received: by gwaa18 with SMTP id a18so509917gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=1tGxXOwdgNLBBeXClfZDUqw3FNGAPgdtp462JshB02Q=;
        b=JIDNIOVwA8mXWUXjIOTJOjEeBYihatTjDGwsqOIke1Wug445wKIvaJvFdQogWIItfM
         eBwfpjU39Er5fBX3NboHia5VEojz6eGQf7KIM+FI32UFfPZxKnw1IPgAsENRPnKuyCbK
         OoQjR6FaV8pcrdTZsXXgv5dyVP6XJWnT3FC68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Njj+EiiUfaCR9luM+yx6FCaBT6vIYIjK8yRIKtsQnGeV4jngAHfWak4KxkNlH7D8Ej
         hXQ7IMOB90qnaYU6dgBm1dLeVw+phdwbov5ksmTiJGrlk/1+qFMoCWZxgFkgDBUFe9vu
         SP/FUGksxqOmyKGFDu7ZMmwXB25P/qMRN0hKw=
Received: by 10.151.59.15 with SMTP id m15mr4839116ybk.246.1269167668153;
        Sun, 21 Mar 2010 03:34:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 23sm3360903iwn.2.2010.03.21.03.34.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:34:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:30:47 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142796>

Again, this series is to make repository setup more predictable, i.e. m=
ust be done
in either setup_git_dir*, enter_repo or init_db. Compared to the first =
version [1]:

 - More detail in commit messages, mostly extracted from [2]
 - Fix "git foo -h" code path (that skips repo setup) in patches 14-16

[1] http://mid.gmane.org/1268313754-28179-1-git-send-email-pclouds@gmai=
l.com
[2] http://mid.gmane.org/fcaeb9bf1003200110w721903e7v7a5823cb312cbc71@m=
ail.gmail.com

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (19):
  Move enter_repo() to setup.c
  enter_repo(): initialize other variables as setup_git_directory_gentl=
y() does
  rev-parse --git-dir: print relative gitdir correctly
  worktree setup: call set_git_dir explicitly
  Add git_config_early()
  Use git_config_early() instead of git_config() during repo setup
  worktree setup: restore original state when things go wrong
  init/clone: turn on startup->have_repository properly
  git_config(): do not read .git/config if there is no repository
  Do not read .git/info/exclude if there is no repository
  Do not read .git/info/attributes if there is no repository
  apply: do not check sha1 when repository has not been found
  config: do not read .git/config if there is no repository
  run_builtin(): save "-h" detection result for later use
  builtins: utilize startup_info->help where possible
  builtins: check for startup_info->help, print and exit early
  Allow to undo setup_git_directory_gently() gracefully (and fix alias =
code)
  alias: keep repository found while collecting aliases as long as poss=
ible
  Guard unallowed access to repository when it's not set up

 attr.c                     |    5 +-
 builtin/apply.c            |    2 +-
 builtin/branch.c           |    3 +
 builtin/check-ref-format.c |    2 +-
 builtin/checkout-index.c   |    3 +
 builtin/clone.c            |    3 +-
 builtin/commit.c           |    6 ++
 builtin/config.c           |    9 ++-
 builtin/gc.c               |    3 +
 builtin/grep.c             |    2 +-
 builtin/index-pack.c       |    2 +-
 builtin/init-db.c          |   10 ++-
 builtin/log.c              |    7 +-
 builtin/ls-files.c         |    3 +
 builtin/merge-ours.c       |    2 +-
 builtin/merge.c            |    3 +
 builtin/pack-redundant.c   |    2 +-
 builtin/rev-parse.c        |    8 ++
 builtin/show-ref.c         |    2 +-
 builtin/update-index.c     |    3 +
 builtin/upload-archive.c   |    7 +-
 cache.h                    |    7 ++-
 config.c                   |   22 ++++-
 dir.c                      |    8 +-
 environment.c              |   33 +++++++-
 git.c                      |   33 +++++---
 path.c                     |   91 ---------------------
 setup.c                    |  191 ++++++++++++++++++++++++++++++++++++=
+++++---
 t/t1300-repo-config.sh     |   14 +++
 t/t1302-repo-version.sh    |    2 +-
 t/t7002-grep.sh            |   24 ++++++
 31 files changed, 360 insertions(+), 152 deletions(-)
