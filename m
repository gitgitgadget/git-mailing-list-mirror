From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 00/10] git p4 test fixes
Date: Wed, 27 Jun 2012 08:00:53 -0400
Message-ID: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:01:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqvr-0002w4-RG
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab2F0MBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:01:09 -0400
Received: from honk.padd.com ([74.3.171.149]:52760 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223Ab2F0MBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:01:08 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 14BC0D02;
	Wed, 27 Jun 2012 05:01:07 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B5A8531383; Wed, 27 Jun 2012 08:01:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200713>

Changes from v1 are:

    * Extend p4d start time to 5 min, modifiable by an
      environment variable.  Add a "kill -0" mechanism
      to detect early if the p4d we started died.
      (Thanks Junio)

    * Rewrite the badp4dir PATH and return value handling
      to make sure that earlier commands in the && chain
      are checked properly.  (Thanks Hannes)

This is a series of accumulated minor annoyances in
the "git p4" tests.  I've been carrying these around for
a while, now.

The big line count change here is from splitting big chunks
of t9800 out into logically separate tests.

Pete Wyckoff (10):
  git p4 test: wait longer for p4d to start and test its pid
  git p4 test: use real_path to resolve p4 client symlinks
  git p4 test: simplify quoting involving TRASH_DIRECTORY
  git p4 test: never create default test repo
  git p4 test: rename some "git-p4 command" strings
  git p4 test: check for error message in failed test
  git p4 test: copy source indeterminate
  git p4 test: cleanup_git should make a new $git
  git p4 test: split up big t9800 test
  git p4 test: fix badp4dir test

 t/lib-git-p4.sh                    |  26 ++-
 t/t9800-git-p4-basic.sh            | 416 ++-----------------------------------
 t/t9805-git-p4-skip-submit-edit.sh |   9 +-
 t/t9806-git-p4-options.sh          |  17 +-
 t/t9808-git-p4-chdir.sh            |   4 +-
 t/t9810-git-p4-rcs.sh              |   8 +-
 t/t9812-git-p4-wildcards.sh        | 147 +++++++++++++
 t/t9813-git-p4-preserve-users.sh   | 153 ++++++++++++++
 t/t9814-git-p4-rename.sh           | 206 ++++++++++++++++++
 9 files changed, 557 insertions(+), 429 deletions(-)
 create mode 100755 t/t9812-git-p4-wildcards.sh
 create mode 100755 t/t9813-git-p4-preserve-users.sh
 create mode 100755 t/t9814-git-p4-rename.sh

-- 
1.7.11.1.69.gd505fd2
