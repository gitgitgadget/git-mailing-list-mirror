From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/4] Add OPT_FILENAME to parse-opts
Date: Sat, 23 May 2009 11:53:09 -0700
Message-ID: <1243104793-3254-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 20:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wLq-0007xZ-QG
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbZEWSxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 14:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZEWSxQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 14:53:16 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:54773 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZEWSxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 14:53:15 -0400
Received: by pxi1 with SMTP id 1so1894468pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Vr08B83o+tHKqS9cGzzAnrC5sjQymjeCkmggW3FCaoo=;
        b=dls7uoXKh/73xgMJ0K4WWZISC9PKSbe/IsdKgJCAt+s2OMSNPMWIfhEjqlDEilhCbw
         UttwQoUjcQKWkXs+z/WyvGwzmFL5nq9SkjkkmrKWObhv6z9KZL5tN0QFhGP/baUaVex6
         T2BmlwTBTmLjakYSUNESnRrkmTKf+Ho39Xv8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sub093uykvigI5oPFEQpBI2xLmTPOW8VXKm27klNOV4AUeOE1vMwCrwoQCAFIg2/Uc
         MP0Uz488zNnNp2T8yTVLbWMVVZcJQ4ZQudT6tVu+NrYYyi+GpTt1MkObd46gjjEoE1RK
         XAAxGmH6bZxgky6McKU6egmQyecPReR18HmH4=
Received: by 10.114.72.1 with SMTP id u1mr10562486waa.154.1243104797179;
        Sat, 23 May 2009 11:53:17 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id c26sm10789434waa.15.2009.05.23.11.53.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 11:53:16 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 11:53:13 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119782>

OPT_FILENAME is used to prefix filenames given on the command line, so
that they are relative to the current working directory. For a more 
in-depth description see the fourth patch.

This series is really two parts, two bug fixes and the introduction
of OPT_FILNAME, but they're all related to one commit
dbd0f5c (Files given on the command line are relative to $cwd,
2008-08-06).

It touches a lot of files, but that's mostly because of
patch three.

Stephen Boyd (4):
  commit: -F overrides -t
  apply, fmt-merge-msg: use relative filenames
  parse-opts: prepare for OPT_FILENAME
  parse-opts: add OPT_FILENAME and transition builtins

 Documentation/technical/api-parse-options.txt |    9 ++++-
 archive.c                                     |    2 +-
 builtin-add.c                                 |    2 +-
 builtin-apply.c                               |    5 ++-
 builtin-archive.c                             |    3 +-
 builtin-bisect--helper.c                      |    3 +-
 builtin-blame.c                               |    2 +-
 builtin-branch.c                              |    3 +-
 builtin-cat-file.c                            |    2 +-
 builtin-check-attr.c                          |    4 +-
 builtin-checkout-index.c                      |    2 +-
 builtin-checkout.c                            |    2 +-
 builtin-clean.c                               |    3 +-
 builtin-clone.c                               |    2 +-
 builtin-commit.c                              |    9 ++---
 builtin-config.c                              |    3 +-
 builtin-count-objects.c                       |    2 +-
 builtin-describe.c                            |    2 +-
 builtin-fast-export.c                         |    2 +-
 builtin-fetch.c                               |    2 +-
 builtin-fmt-merge-msg.c                       |    5 ++-
 builtin-for-each-ref.c                        |    2 +-
 builtin-fsck.c                                |    2 +-
 builtin-gc.c                                  |    3 +-
 builtin-grep.c                                |    2 +-
 builtin-help.c                                |    2 +-
 builtin-ls-files.c                            |    2 +-
 builtin-merge-base.c                          |    2 +-
 builtin-merge-file.c                          |    2 +-
 builtin-merge.c                               |    4 +-
 builtin-mv.c                                  |    3 +-
 builtin-name-rev.c                            |    2 +-
 builtin-pack-refs.c                           |    2 +-
 builtin-prune.c                               |    2 +-
 builtin-push.c                                |    2 +-
 builtin-remote.c                              |   16 +++++---
 builtin-reset.c                               |    2 +-
 builtin-rev-parse.c                           |    4 +-
 builtin-revert.c                              |    2 +-
 builtin-rm.c                                  |    3 +-
 builtin-shortlog.c                            |    2 +-
 builtin-symbolic-ref.c                        |    3 +-
 builtin-tag.c                                 |    5 +--
 builtin-update-ref.c                          |    3 +-
 hash-object.c                                 |    3 +-
 parse-options.c                               |   47 ++++++++++++++++--------
 parse-options.h                               |   11 ++++--
 t/t0040-parse-options.sh                      |   19 +++++++++-
 t/t4131-apply-fake-ancestor.sh                |   42 ++++++++++++++++++++++
 t/t6200-fmt-merge-msg.sh                      |   32 +++++++++++++++++
 t/t7500-commit.sh                             |   10 +++++
 test-parse-options.c                          |    6 +++-
 52 files changed, 226 insertions(+), 85 deletions(-)
 create mode 100755 t/t4131-apply-fake-ancestor.sh
