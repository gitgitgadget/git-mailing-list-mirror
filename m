From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 00/17] Reroll a version 5 of this series
Date: Wed, 11 Aug 2010 23:03:25 +0800
Message-ID: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCqu-0004i8-Pe
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab0HKPEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:04:20 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46611 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab0HKPET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:04:19 -0400
Received: by pxi10 with SMTP id 10so75091pxi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kPZs7dN+h+NH4C98weOOZBbyAnZ4tBMp7DajGl8sHsQ=;
        b=mcPCDGrR1Bz0MuE/vFAnVHbICj5i7J/mL7oit15+rxcfWwrM+tsL5+F68imR/U9tYC
         APZMQrMBT5l1ToZ8xBpuTaBozVt1ocLJqT8hOc8TBpdi06JaH+Xnf/130o+1PhDAZbcv
         v4aZKMnxQkv/tikbPaVlU8IFyzsE7dgwt88zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jiMdGRhyp7+vt95iPRGnP2uTtuySN1w///Z6mYZCmVOZEjdFQ+98k7+kC8VEp2jic6
         Ys9OqwnsDu3pKP2YPckGKxoH+Yq50O8c8273Q8nGKAvZvuLEtWQC5VEMgzdIYWnuhAKe
         Q9ocjgpXX77mm1R/3Bhn0QvvPphItQGZTpY2U=
Received: by 10.114.36.1 with SMTP id j1mr14885334waj.141.1281539059044;
        Wed, 11 Aug 2010 08:04:19 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.04.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:04:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153239>

Changes:
1. Fix all format problems;
2. Split the "too long" lines in multiple lines;
3. '$' to represent the last line of a file;
4. Error string change;
5. Add more comments;
6. Combine test cases together;
7. Struct name change

Bo Yang (17):
  parse-options: enhance STOP_AT_NON_OPTION
  parse-options: add two helper functions
  Add the basic data structure for line level history
  Refactor parse_loc
  Parse the -L options
  Export three functions from diff.c
  Add range clone functions
  map/take range to the parent of commits
  Print the line log
  Hook line history into cmd_log, ensuring a topo-ordered walk
  Make rewrite_parents public to other part of git
  Make graph_next_line external to other part of git
  Add parent rewriting to line history browser
  Add --graph prefix before line history output
  Add --full-line-diff option
  Add tests for line history browser
  Document line history browser

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   15 +
 Documentation/line-range-format.txt |   18 +
 Makefile                            |    2 +
 builtin/blame.c                     |   89 +--
 builtin/log.c                       |  113 +++-
 diff.c                              |    6 +-
 diff.h                              |   17 +
 graph.c                             |   14 +-
 graph.h                             |   10 +
 line.c                              | 1551 +++++++++++++++++++++++++++++++++++
 line.h                              |  141 ++++
 parse-options.c                     |   22 +-
 parse-options.h                     |    7 +-
 revision.c                          |   25 +-
 revision.h                          |   23 +-
 t/t4301-log-line-single-history.sh  |  627 ++++++++++++++
 t/t4302-log-line-merge-history.sh   |  163 ++++
 18 files changed, 2733 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line.c
 create mode 100644 line.h
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

-- 
1.7.2.19.g79e5d
