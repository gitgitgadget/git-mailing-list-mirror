From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/19] Reroll of the remote-vcs-helper series
Date: Thu, 29 Oct 2009 11:01:08 -0700
Message-ID: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKF-0004KN-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbZJ2SCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZJ2SCG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:06 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:55291 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbZJ2SCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:05 -0400
Received: by pxi9 with SMTP id 9so1335963pxi.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=GlNzF0Kc1omxEhFdTpNxKxD3MYZxQRe/CjEMVs0BRLA=;
        b=fazWxfelTXoOLvlxMRXlseOqDTmXd6Yg+GsAe/SeSzEI/8SQxFVbt5SXRAhWaEGNSc
         n+a/ikrwJvjZjTbik00sO9rrgkoVUBQ6YIph0WghzSk1NpTqkQMZ2kj43mlHFJeuicDu
         TrFzERB3s6+MgD7nTbMKxPu8R1mcld/fUrzSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=BVyw2XNYzYDW5npXSbD4qN4u8dAQy3jP8RVMsCXe3MKT9RG6zf8Tx6TJgMO8odTceC
         M6MG8DX9kePGfqMKsnaBIBABj3opt1xKhXvpmjkGa8kgw6xU3jdoV/ljEgBLHgck/bFJ
         mhzeMGXtZKf9j1Xi8SbR4DFkTDgW2uhiqv2Q0=
Received: by 10.115.86.7 with SMTP id o7mr277053wal.50.1256839329563;
        Thu, 29 Oct 2009 11:02:09 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131620>

Reroll of the entire series that is currently in pu, rebased on
current master.

I did not squash the cvs makefile fixes since my Makefile foo is not
that great.

Daniel, please have a close look at the UNSTABLE patch, as I am not
sure at all that I rebased it properly.

I did not have time to work on my git-remote-hg patches yet, but I
might send those two out later today before I get on my flight back
home. If not it'll be tomorrow somewhere :).

Daniel Barkalow (7):
      Use a function to determine whether a remote is valid
      Allow fetch to modify refs
      Allow programs to not depend on remotes having urls
      Add a config option for remotes to specify a foreign vcs
      Add support for "import" helper command
      Allow helpers to report in "list" command that the ref is unchanged
      Fix memory leak in helper method for disconnect

Johan Herland (8):
      Allow helpers to request marks for fast-import
      Basic build infrastructure for Python scripts
      1/2: Add Python support library for CVS remote helper
      2/2: Add Python support library for CVS remote helper
      git-remote-cvs: Remote helper program for CVS repositories
      Add simple selftests of git-remote-cvs functionality
      Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
      More fixes to the git-remote-cvs installation procedure

Johannes Schindelin (1):
      Finally make remote helper support useful

Sverre Rabbelier (3):
      Factor ref updating out of fetch_with_import
      Refactor git_remote_cvs to a more generic git_remote_helpers
      .gitignore: add git-remote-cvs

 .gitignore                              |    1 +
 Documentation/config.txt                |    4 +
 Documentation/git-remote-cvs.txt        |   85 +++
 Documentation/git-remote-helpers.txt    |   22 +-
 Makefile                                |   53 ++
 builtin-clone.c                         |   12 +-
 builtin-fetch.c                         |   10 +-
 builtin-ls-remote.c                     |    4 +-
 builtin-push.c                          |   68 ++-
 configure.ac                            |    3 +
 git-remote-cvs.py                       |  683 +++++++++++++++++++++
 git_remote_helpers/.gitignore           |    2 +
 git_remote_helpers/Makefile             |   35 ++
 git_remote_helpers/__init__.py          |   27 +
 git_remote_helpers/cvs/changeset.py     |  126 ++++
 git_remote_helpers/cvs/commit_states.py |   62 ++
 git_remote_helpers/cvs/cvs.py           |  998 +++++++++++++++++++++++++++++++
 git_remote_helpers/cvs/revision_map.py  |  418 +++++++++++++
 git_remote_helpers/cvs/symbol_cache.py  |  313 ++++++++++
 git_remote_helpers/git/git.py           |  680 +++++++++++++++++++++
 git_remote_helpers/setup.py             |   17 +
 git_remote_helpers/util.py              |  194 ++++++
 remote.c                                |   15 +-
 remote.h                                |    2 +
 t/t9800-remote-cvs-basic.sh             |  524 ++++++++++++++++
 t/t9801-remote-cvs-fetch.sh             |  291 +++++++++
 t/test-lib.sh                           |   10 +
 transport-helper.c                      |  117 ++++-
 transport.c                             |   37 +-
 transport.h                             |   45 ++-
 30 files changed, 4810 insertions(+), 48 deletions(-)
